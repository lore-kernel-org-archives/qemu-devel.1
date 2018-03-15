Received: from eggs.gnu.org ([2001:4830:134:3::10]:44515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewRD2-0006qz-GN
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewRCz-0001pX-5b
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:38:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ewRCy-0001pD-WF
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:38:09 -0400
Date: Thu, 15 Mar 2018 11:37:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180315113759.GD3062@work-vm>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-5-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313075739.11194-5-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 4/8] migration: introduce
 control_save_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, quintela@redhat.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Abstract the common function control_save_page() to cleanup the code,
> no logic is changed
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

It would be good to find a better name for control_save_page, but I
can't think of one!).
> ---
>  migration/ram.c | 174 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 89 insertions(+), 85 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index c47185d38c..e7b8b14c3c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -957,6 +957,44 @@ static void ram_release_pages(const char *rbname, uint64_t offset, int pages)
>      ram_discard_range(rbname, offset, pages << TARGET_PAGE_BITS);
>  }
>  
> +/*
> + * @pages: the number of pages written by the control path,
> + *        < 0 - error
> + *        > 0 - number of pages written

What about 0 !

> + * Return true if the pages has been saved, otherwise false is returned.
> + */
> +static bool control_save_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
> +                              int *pages)
> +{
> +    uint64_t bytes_xmit = 0;
> +    int ret;
> +
> +    *pages = -1;
> +    ret = ram_control_save_page(rs->f, block->offset, offset, TARGET_PAGE_SIZE,
> +                                &bytes_xmit);
> +    if (ret == RAM_SAVE_CONTROL_NOT_SUPP) {
> +        return false;
> +    }
> +
> +    if (bytes_xmit) {
> +        ram_counters.transferred += bytes_xmit;
> +        *pages = 1;
> +    }
> +
> +    if (ret == RAM_SAVE_CONTROL_DELAYED) {
> +        return true;
> +    }
> +
> +    if (bytes_xmit > 0) {
> +        ram_counters.normal++;
> +    } else if (bytes_xmit == 0) {
> +        ram_counters.duplicate++;
> +    }
> +
> +    return true;
> +}
> +
>  /**
>   * ram_save_page: send the given page to the stream
>   *
> @@ -973,56 +1011,36 @@ static void ram_release_pages(const char *rbname, uint64_t offset, int pages)
>  static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>  {
>      int pages = -1;
> -    uint64_t bytes_xmit;
> -    ram_addr_t current_addr;
>      uint8_t *p;
> -    int ret;
>      bool send_async = true;
>      RAMBlock *block = pss->block;
>      ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> +    ram_addr_t current_addr = block->offset + offset;
>  
>      p = block->host + offset;
>      trace_ram_save_page(block->idstr, (uint64_t)offset, p);
>  
> -    /* In doubt sent page as normal */
> -    bytes_xmit = 0;
> -    ret = ram_control_save_page(rs->f, block->offset,
> -                           offset, TARGET_PAGE_SIZE, &bytes_xmit);
> -    if (bytes_xmit) {
> -        ram_counters.transferred += bytes_xmit;
> -        pages = 1;
> +    if (control_save_page(rs, block, offset, &pages)) {
> +        return pages;
>      }
>  
>      XBZRLE_cache_lock();
> -
> -    current_addr = block->offset + offset;
> -
> -    if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
> -        if (ret != RAM_SAVE_CONTROL_DELAYED) {
> -            if (bytes_xmit > 0) {
> -                ram_counters.normal++;
> -            } else if (bytes_xmit == 0) {
> -                ram_counters.duplicate++;
> -            }
> -        }
> -    } else {
> -        pages = save_zero_page(rs, block, offset);
> -        if (pages > 0) {
> -            /* Must let xbzrle know, otherwise a previous (now 0'd) cached
> -             * page would be stale
> +    pages = save_zero_page(rs, block, offset);
> +    if (pages > 0) {
> +        /* Must let xbzrle know, otherwise a previous (now 0'd) cached
> +         * page would be stale
> +         */
> +        xbzrle_cache_zero_page(rs, current_addr);
> +        ram_release_pages(block->idstr, offset, pages);
> +    } else if (!rs->ram_bulk_stage &&
> +               !migration_in_postcopy() && migrate_use_xbzrle()) {
> +        pages = save_xbzrle_page(rs, &p, current_addr, block,
> +                                 offset, last_stage);
> +        if (!last_stage) {
> +            /* Can't send this cached data async, since the cache page
> +             * might get updated before it gets to the wire
>               */
> -            xbzrle_cache_zero_page(rs, current_addr);
> -            ram_release_pages(block->idstr, offset, pages);
> -        } else if (!rs->ram_bulk_stage &&
> -                   !migration_in_postcopy() && migrate_use_xbzrle()) {
> -            pages = save_xbzrle_page(rs, &p, current_addr, block,
> -                                     offset, last_stage);
> -            if (!last_stage) {
> -                /* Can't send this cached data async, since the cache page
> -                 * might get updated before it gets to the wire
> -                 */
> -                send_async = false;
> -            }
> +            send_async = false;
>          }
>      }
>  
> @@ -1152,63 +1170,49 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
>                                      bool last_stage)
>  {
>      int pages = -1;
> -    uint64_t bytes_xmit = 0;
>      uint8_t *p;
> -    int ret;
>      RAMBlock *block = pss->block;
>      ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
>  
>      p = block->host + offset;
>  
> -    ret = ram_control_save_page(rs->f, block->offset,
> -                                offset, TARGET_PAGE_SIZE, &bytes_xmit);
> -    if (bytes_xmit) {
> -        ram_counters.transferred += bytes_xmit;
> -        pages = 1;
> +    if (control_save_page(rs, block, offset, &pages)) {
> +        return pages;
>      }
> -    if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
> -        if (ret != RAM_SAVE_CONTROL_DELAYED) {
> -            if (bytes_xmit > 0) {
> -                ram_counters.normal++;
> -            } else if (bytes_xmit == 0) {
> -                ram_counters.duplicate++;
> -            }
> +
> +    /* When starting the process of a new block, the first page of
> +     * the block should be sent out before other pages in the same
> +     * block, and all the pages in last block should have been sent
> +     * out, keeping this order is important, because the 'cont' flag
> +     * is used to avoid resending the block name.
> +     */
> +    if (block != rs->last_sent_block) {
> +        flush_compressed_data(rs);
> +        pages = save_zero_page(rs, block, offset);
> +        if (pages > 0) {
> +            ram_release_pages(block->idstr, offset, pages);
> +        } else {
> +            /*
> +             * Make sure the first page is sent out before other pages.
> +             *
> +             * we post it as normal page as compression will take much
> +             * CPU resource.
> +             */
> +            ram_counters.transferred += save_page_header(rs, rs->f, block,
> +                                            offset | RAM_SAVE_FLAG_PAGE);
> +            qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
> +                                  migrate_release_ram() &
> +                                  migration_in_postcopy());
> +            ram_counters.transferred += TARGET_PAGE_SIZE;
> +            ram_counters.normal++;
> +            pages = 1;
>          }
>      } else {
> -        /* When starting the process of a new block, the first page of
> -         * the block should be sent out before other pages in the same
> -         * block, and all the pages in last block should have been sent
> -         * out, keeping this order is important, because the 'cont' flag
> -         * is used to avoid resending the block name.
> -         */
> -        if (block != rs->last_sent_block) {
> -            flush_compressed_data(rs);
> -            pages = save_zero_page(rs, block, offset);
> -            if (pages > 0) {
> -                ram_release_pages(block->idstr, offset, pages);
> -            } else {
> -                /*
> -                 * Make sure the first page is sent out before other pages.
> -                 *
> -                 * we post it as normal page as compression will take much
> -                 * CPU resource.
> -                 */
> -                ram_counters.transferred += save_page_header(rs, rs->f, block,
> -                                                offset | RAM_SAVE_FLAG_PAGE);
> -                qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
> -                                      migrate_release_ram() &
> -                                      migration_in_postcopy());
> -                ram_counters.transferred += TARGET_PAGE_SIZE;
> -                ram_counters.normal++;
> -                pages = 1;
> -            }
> +        pages = save_zero_page(rs, block, offset);
> +        if (pages == -1) {
> +            pages = compress_page_with_multi_thread(rs, block, offset);
>          } else {
> -            pages = save_zero_page(rs, block, offset);
> -            if (pages == -1) {
> -                pages = compress_page_with_multi_thread(rs, block, offset);
> -            } else {
> -                ram_release_pages(block->idstr, offset, pages);
> -            }
> +            ram_release_pages(block->idstr, offset, pages);
>          }
>      }
>  
> -- 
> 2.14.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
