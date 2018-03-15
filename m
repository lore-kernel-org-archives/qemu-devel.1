Received: from eggs.gnu.org ([2001:4830:134:3::10]:46266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewRMC-0002EC-Pb
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewRM8-0008Oa-6Y
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:47:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ewRM8-0008OK-1T
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:47:36 -0400
Date: Thu, 15 Mar 2018 11:47:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180315114715.GE3062@work-vm>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-6-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313075739.11194-6-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 5/8] migration: move calling
 control_save_page to the common place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> The function is called by both ram_save_page and ram_save_target_page,
> so move it to the common caller to cleanup the code
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/ram.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index e7b8b14c3c..839665d866 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1020,10 +1020,6 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>      p = block->host + offset;
>      trace_ram_save_page(block->idstr, (uint64_t)offset, p);
>  
> -    if (control_save_page(rs, block, offset, &pages)) {
> -        return pages;
> -    }
> -
>      XBZRLE_cache_lock();
>      pages = save_zero_page(rs, block, offset);
>      if (pages > 0) {
> @@ -1176,10 +1172,6 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
>  
>      p = block->host + offset;
>  
> -    if (control_save_page(rs, block, offset, &pages)) {
> -        return pages;
> -    }
> -
>      /* When starting the process of a new block, the first page of
>       * the block should be sent out before other pages in the same
>       * block, and all the pages in last block should have been sent
> @@ -1472,6 +1464,13 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>  
>      /* Check the pages is dirty and if it is send it */
>      if (migration_bitmap_clear_dirty(rs, pss->block, pss->page)) {
> +        RAMBlock *block = pss->block;
> +        ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> +
> +        if (control_save_page(rs, block, offset, &res)) {
> +            goto page_saved;

OK, but I'd prefer if you avoided this forward goto;  we do use goto but
we tend to keep it just for error cases.

Dave

> +        }
> +
>          /*
>           * If xbzrle is on, stop using the data compression after first
>           * round of migration even if compression is enabled. In theory,
> @@ -1484,6 +1483,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>              res = ram_save_page(rs, pss, last_stage);
>          }
>  
> +page_saved:
>          if (res < 0) {
>              return res;
>          }
> -- 
> 2.14.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
