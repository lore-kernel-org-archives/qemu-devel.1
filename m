Received: from eggs.gnu.org ([2001:4830:134:3::10]:39367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e2aJB-0008IG-FS
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e2aJ5-0006bC-Uo
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:01:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e2aJ5-0006ZH-O0
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:01:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BABC13DBC2
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 10:01:34 +0000 (UTC)
Date: Thu, 12 Oct 2017 11:01:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171012100127.GB2343@work-vm>
References: <20171010181542.24168-1-quintela@redhat.com>
	<20171010181542.24168-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010181542.24168-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] migration: Make cache size elements
 use the right types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/page_cache.c | 8 ++++----
>  migration/page_cache.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/page_cache.c b/migration/page_cache.c
> index 381e555ddb..6b2dd77cf0 100644
> --- a/migration/page_cache.c
> +++ b/migration/page_cache.c
> @@ -39,12 +39,12 @@ struct CacheItem {
>  
>  struct PageCache {
>      CacheItem *page_cache;
> -    unsigned int page_size;
> -    int64_t max_num_items;
> -    int64_t num_items;
> +    size_t page_size;
> +    size_t max_num_items;
> +    size_t num_items;
>  };
>  
> -PageCache *cache_init(int64_t num_pages, unsigned int page_size)
> +PageCache *cache_init(size_t num_pages, size_t page_size)
>  {
>      int64_t i;
>  
> diff --git a/migration/page_cache.h b/migration/page_cache.h
> index 4fadd0c501..931868b857 100644
> --- a/migration/page_cache.h
> +++ b/migration/page_cache.h
> @@ -28,7 +28,7 @@ typedef struct PageCache PageCache;
>   * @num_pages: cache maximal number of cached pages
>   * @page_size: cache page size
>   */
> -PageCache *cache_init(int64_t num_pages, unsigned int page_size);
> +PageCache *cache_init(size_t num_pages, size_t page_size);

Makes sense;  have you checked that the build is happy on 32bit
machines with xbzrle_cache_resize still passing an int64_t at this
point?

However, it's the right thing to move to, so:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  /**
>   * cache_fini: free all cache resources
> -- 
> 2.13.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
