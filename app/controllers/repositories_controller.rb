class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    begin
     @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
       req.params['client_id'] = 8e52ba79d99a414b8d61
       req.params['client_secret'] = 461c7a065b83e011188df751550cbb742035dfea
       req.params['q'] = params[:query]
     end
     body = JSON.parse(@resp.body)
     if @resp.success?
       @repositories = body["items"]
     else
       @error = body["message"]
     end

   rescue Faraday::ConnectionFailed
     @error = "There was a timeout. Please try again."
   end
   render 'search'
  end
end 
  
end
