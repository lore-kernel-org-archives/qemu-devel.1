Received: from eggs.gnu.org ([2001:4830:134:3::10]:44160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhT0W-0005YZ-VR
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhT0T-0005cC-Ri
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:03:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fhT0T-0005c1-MQ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:03:37 -0400
Date: Mon, 23 Jul 2018 13:03:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180723050325.GF2491@xz-mi>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-7-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719121520.30026-7-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/8] migration: move handle of zero page
 to the thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Thu, Jul 19, 2018 at 08:15:18PM +0800, guangrong.xiao@gmail.com wrote:

[...]

> @@ -1950,12 +1971,16 @@ retry:
>              set_compress_params(&comp_param[idx], block, offset);
>              qemu_cond_signal(&comp_param[idx].cond);
>              qemu_mutex_unlock(&comp_param[idx].mutex);
> -            pages = 1;
> -            /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
> -            compression_counters.reduced_size += TARGET_PAGE_SIZE -
> -                                                 bytes_xmit + 8;
> -            compression_counters.pages++;
>              ram_counters.transferred += bytes_xmit;
> +            pages = 1;

(moving of this line seems irrelevant; meanwhile more duplicated codes
so even better to have a helper now)

> +            if (comp_param[idx].zero_page) {
> +                ram_counters.duplicate++;
> +            } else {
> +                /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
> +                compression_counters.reduced_size += TARGET_PAGE_SIZE -
> +                                                     bytes_xmit + 8;
> +                compression_counters.pages++;
> +            }
>              break;
>          }
>      }

[...]

> @@ -2249,15 +2308,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>          return res;
>      }
>  
> -    /*
> -     * When starting the process of a new block, the first page of
> -     * the block should be sent out before other pages in the same
> -     * block, and all the pages in last block should have been sent
> -     * out, keeping this order is important, because the 'cont' flag
> -     * is used to avoid resending the block name.
> -     */
> -    if (block != rs->last_sent_block && save_page_use_compression(rs)) {
> -            flush_compressed_data(rs);
> +    if (save_compress_page(rs, block, offset)) {
> +        return 1;

It's a bit tricky (though it seems to be a good idea too) to move the
zero detect into the compression thread, though I noticed that we also
do something else for zero pages:

    res = save_zero_page(rs, block, offset);
    if (res > 0) {
        /* Must let xbzrle know, otherwise a previous (now 0'd) cached
         * page would be stale
         */
        if (!save_page_use_compression(rs)) {
            XBZRLE_cache_lock();
            xbzrle_cache_zero_page(rs, block->offset + offset);
            XBZRLE_cache_unlock();
        }
        ram_release_pages(block->idstr, offset, res);
        return res;
    }

I'd guess that the xbzrle update of the zero page is not needed for
compression since after all xbzrle is not enabled when compression is
enabled, however do we need to do ram_release_pages() somehow?

>      }
>  
>      res = save_zero_page(rs, block, offset);
> @@ -2275,18 +2327,10 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>      }
>  
>      /*
> -     * Make sure the first page is sent out before other pages.
> -     *
> -     * we post it as normal page as compression will take much
> -     * CPU resource.
> -     */
> -    if (block == rs->last_sent_block && save_page_use_compression(rs)) {
> -        res = compress_page_with_multi_thread(rs, block, offset);
> -        if (res > 0) {
> -            return res;
> -        }
> -        compression_counters.busy++;
> -    } else if (migrate_use_multifd()) {
> +    * do not use multifd for compression as the first page in the new
> +    * block should be posted out before sending the compressed page
> +    */
> +    if (!save_page_use_compression(rs) && migrate_use_multifd()) {
>          return ram_save_multifd_page(rs, block, offset);
>      }
>  
> -- 
> 2.14.4
> 

Regards,

-- 
Peter Xu
