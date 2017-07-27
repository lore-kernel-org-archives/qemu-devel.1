Received: from eggs.gnu.org ([2001:4830:134:3::10]:38548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dajQT-0008Kh-Qi
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dajQR-00058f-6O
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:06:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dajQQ-00055x-UF
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:06:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5D00C0BB281
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 13:57:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1501148776-16890-2-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Thu, 27 Jul 2017 11:46:14 +0200")
References: <1501148776-16890-1-git-send-email-armbru@redhat.com>
	<1501148776-16890-2-git-send-email-armbru@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 27 Jul 2017 15:57:32 +0200
Message-ID: <8760eehtir.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/3] xbzrle: Drop unused cache_resize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Markus Armbruster <armbru@redhat.com> wrote:
> Unused since commit fd8cec XBZRLE: Fix qemu crash when resize the
> xbzrle cache.
>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Amit Shah <amit.shah@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Included for next PULL.  thanks.

> ---
>  migration/page_cache.c | 56 --------------------------------------------------
>  migration/page_cache.h | 11 ----------
>  2 files changed, 67 deletions(-)
>
> diff --git a/migration/page_cache.c b/migration/page_cache.c
> index 5f85787..ba984c4 100644
> --- a/migration/page_cache.c
> +++ b/migration/page_cache.c
> @@ -178,59 +178,3 @@ int cache_insert(PageCache *cache, uint64_t addr, const uint8_t *pdata,
>  
>      return 0;
>  }
> -
> -int64_t cache_resize(PageCache *cache, int64_t new_num_pages)
> -{
> -    PageCache *new_cache;
> -    int64_t i;
> -
> -    CacheItem *old_it, *new_it;
> -
> -    g_assert(cache);
> -
> -    /* cache was not inited */
> -    if (cache->page_cache == NULL) {
> -        return -1;
> -    }
> -
> -    /* same size */
> -    if (pow2floor(new_num_pages) == cache->max_num_items) {
> -        return cache->max_num_items;
> -    }
> -
> -    new_cache = cache_init(new_num_pages, cache->page_size);
> -    if (!(new_cache)) {
> -        DPRINTF("Error creating new cache\n");
> -        return -1;
> -    }
> -
> -    /* move all data from old cache */
> -    for (i = 0; i < cache->max_num_items; i++) {
> -        old_it = &cache->page_cache[i];
> -        if (old_it->it_addr != -1) {
> -            /* check for collision, if there is, keep MRU page */
> -            new_it = cache_get_by_addr(new_cache, old_it->it_addr);
> -            if (new_it->it_data && new_it->it_age >= old_it->it_age) {
> -                /* keep the MRU page */
> -                g_free(old_it->it_data);
> -            } else {
> -                if (!new_it->it_data) {
> -                    new_cache->num_items++;
> -                }
> -                g_free(new_it->it_data);
> -                new_it->it_data = old_it->it_data;
> -                new_it->it_age = old_it->it_age;
> -                new_it->it_addr = old_it->it_addr;
> -            }
> -        }
> -    }
> -
> -    g_free(cache->page_cache);
> -    cache->page_cache = new_cache->page_cache;
> -    cache->max_num_items = new_cache->max_num_items;
> -    cache->num_items = new_cache->num_items;
> -
> -    g_free(new_cache);
> -
> -    return cache->max_num_items;
> -}
> diff --git a/migration/page_cache.h b/migration/page_cache.h
> index 10ed532..4fadd0c 100644
> --- a/migration/page_cache.h
> +++ b/migration/page_cache.h
> @@ -72,15 +72,4 @@ uint8_t *get_cached_data(const PageCache *cache, uint64_t addr);
>  int cache_insert(PageCache *cache, uint64_t addr, const uint8_t *pdata,
>                   uint64_t current_age);
>  
> -/**
> - * cache_resize: resize the page cache. In case of size reduction the extra
> - * pages will be freed
> - *
> - * Returns -1 on error new cache size on success
> - *
> - * @cache pointer to the PageCache struct
> - * @num_pages: new page cache size (in pages)
> - */
> -int64_t cache_resize(PageCache *cache, int64_t num_pages);
> -
>  #endif
