require 'mailgun'
class HomeController < ApplicationController
  def index
  end
  def write
   
     @apple = params[:email]
        @banana = params[:title]
        @cherry = params[:content]
    
    mg_client = Mailgun::Client.new("key-1955524484bcba70d928f057865d087b")

    message_params =  {
                   from: 'topdaeyoung@likelion.net',
                   to:   @apple,
                   subject: @banana,
                   text:    @cherry
                  }

    result = mg_client.send_message('sandbox48d52f75a94540639901187f3c9e28f1.mailgun.org', message_params).to_h!

    message_id = result['id']
    message = result['message']
  
      redirect_to "/list"   
      @apple = params[:email]
      @banana = params[:title]
      @cherry = params[:content]
      
      new_post = Post.new
      new_post.email = @apple
      new_post.title = @banana
      new_post.content = @cherry
      new_post.save
       
  
  end
  
  def list
      @everypost = Post.all.order ("id desc")
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @post.destroy
    redirect_to "/list"
  end
  
  
end
