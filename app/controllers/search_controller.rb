# coding: utf-8
class SearchController < ApplicationController
  def index
    @keywords = Segment.split(params[:q])
    search_text = @keywords.join(" ")
    @search = Sunspot.search(Topic) do
      keywords search_text, :highlight => true
      paginate :page => params[:page], :per_page => 20
      order_by :replied_at, :desc
    end

    set_seo_meta("#{t("common.search")}: #{params[:q]}")
    drop_breadcrumb("#{t("common.search")}: #{params[:q]}")
  end
  
  def wiki
    @keywords = Segment.split(params[:q])
    search_text = @keywords.join(" ")
    @search = Sunspot.search(Page) do
      keywords search_text, :highlight => true
      paginate :page => params[:page], :per_page => 20
    end

    set_seo_meta("WIKI#{t("common.search")}: #{params[:q]}")
    drop_breadcrumb("WIKI#{t("common.search")}: #{params[:q]}")
  end
end
