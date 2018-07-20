Received: from eggs.gnu.org ([2001:4830:134:3::10]:60828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgQIH-0007Wf-SG
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 03:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgQID-0001g7-T9
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 03:57:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41530 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fgQID-0001g0-NU
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 03:57:37 -0400
Date: Fri, 20 Jul 2018 15:57:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180720075729.GQ4071@xz-mi>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
	<20180718154200.26777-7-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718154200.26777-7-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v1 06/17] background snapshot: add helpers
 to manage a copy of ram block list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, Jul 18, 2018 at 06:41:49PM +0300, Denis Plotnikov wrote:
> The VM ramblock list may be changed during the snapshotting.
> We want to make sure that we have the same ramblock list as it
> was at the time of snapshot beginning.
> So, we create a copy of the list at the beginning of the snapshotting
> and use it during the process.

Could I ask why the list might change?

> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  migration/ram.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/ram.h |  6 ++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 021d583b9b..4399c31606 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1508,6 +1508,57 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
>      return pages;
>  }
>  
> +/* BackGround Snapshot Blocks */
> +static RamBlockList bgs_blocks;
> +
> +static RamBlockList *ram_bgs_block_list_get(void)
> +{
> +    return &bgs_blocks;
> +}
> +
> +void ram_block_list_create(void)
> +{
> +    RAMBlock *block = NULL;
> +    RamBlockList *block_list = ram_bgs_block_list_get();
> +
> +    qemu_mutex_lock_ramlist();
> +    QLIST_FOREACH(block, &ram_list.blocks, next) {

Even if we want to copy a list of ramblocks, we possibly don't need
the ones that aren't migratable?  Please refer to
RAMBLOCK_FOREACH_MIGRATABLE().  Then I think...

> +        memory_region_ref(block->mr);
> +        QLIST_INSERT_HEAD(block_list, block, bgs_next);
> +    }
> +    qemu_mutex_unlock_ramlist();
> +}
> +
> +void ram_block_list_destroy(void)
> +{
> +    RAMBlock *next, *block;
> +    RamBlockList *block_list = ram_bgs_block_list_get();
> +
> +    QLIST_FOREACH_SAFE(block, block_list, bgs_next, next) {
> +        QLIST_REMOVE(block, bgs_next);
> +        memory_region_unref(block->mr);
> +    }
> +}
> +
> +RAMBlock *ram_bgs_block_find(uint8_t *address, ram_addr_t *page_offset)
> +{
> +    RAMBlock *block = NULL;
> +    RamBlockList *block_list = ram_bgs_block_list_get();
> +
> +    QLIST_FOREACH(block, block_list, bgs_next) {
> +        /* This case append when the block is not mapped. */
> +        if (block->host == NULL) {

... things like this should not happen.

Thanks,

> +            continue;
> +        }
> +
> +        if (address - block->host < block->max_length) {
> +            *page_offset = (address - block->host) & TARGET_PAGE_MASK;
> +            return block;
> +        }
> +    }
> +
> +    return NULL;
> +}
>  /**
>   * ram_find_and_save_block: finds a dirty page and sends it to f
>   *
> diff --git a/migration/ram.h b/migration/ram.h
> index 64d81e9f1d..385579cae9 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -31,6 +31,7 @@
>  
>  #include "qemu-common.h"
>  #include "exec/cpu-common.h"
> +#include "exec/ramlist.h"
>  
>  extern MigrationStats ram_counters;
>  extern XBZRLECacheStats xbzrle_counters;
> @@ -61,5 +62,10 @@ void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
>  int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
>  void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
>  void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
> +/* For background snapshot */
> +void ram_block_list_create(void);
> +void ram_block_list_destroy(void);
> +
> +RAMBlock *ram_bgs_block_find(uint8_t *address, ram_addr_t *page_offset);
>  
>  #endif
> -- 
> 2.17.0
> 
> 

-- 
Peter Xu
