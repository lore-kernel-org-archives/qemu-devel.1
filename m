Received: from eggs.gnu.org ([2001:4830:134:3::10]:47974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejD7k-0002Ez-W0
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 18:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejD7h-0000mr-Uq
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 18:58:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55890 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejD7h-0000m3-OF
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 18:58:01 -0500
Date: Wed, 7 Feb 2018 01:57:51 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180207014345-mutt-send-email-mst@kernel.org>
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<1517915299-15349-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517915299-15349-3-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] migration: use the free page
 reporting feature from balloon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On Tue, Feb 06, 2018 at 07:08:18PM +0800, Wei Wang wrote:
> Use the free page reporting feature from the balloon device to clear the
> bits corresponding to guest free pages from the dirty bitmap, so that the
> free memory are not sent.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>

What the patch seems to do is stop migration
completely - blocking until guest completes the reporting.

Which makes no sense to me, since it's just an optimization.
Why not proceed with the migration? What do we have to loose?

I imagine some people might want to defer migration until reporting
completes to reduce the load on the network. Fair enough,
but it does not look like you actually measured the reduction
in traffic. So I suggest you work on that as a separate feature.


> ---
>  migration/ram.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index d6f462c..4fe16d2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -49,6 +49,7 @@
>  #include "qemu/rcu_queue.h"
>  #include "migration/colo.h"
>  #include "migration/block.h"
> +#include "sysemu/balloon.h"
>  
>  /***********************************************************/
>  /* ram save/restore */
> @@ -206,6 +207,10 @@ struct RAMState {
>      uint32_t last_version;
>      /* We are in the first round */
>      bool ram_bulk_stage;
> +    /* The feature, skipping the transfer of free pages, is supported */
> +    bool free_page_support;
> +    /* Skip the transfer of free pages in the bulk stage */
> +    bool free_page_done;
>      /* How many times we have dirty too many pages */
>      int dirty_rate_high_cnt;
>      /* these variables are used for bitmap sync */
> @@ -773,7 +778,7 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>      unsigned long *bitmap = rb->bmap;
>      unsigned long next;
>  
> -    if (rs->ram_bulk_stage && start > 0) {
> +    if (rs->ram_bulk_stage && start > 0 && !rs->free_page_support) {
>          next = start + 1;
>      } else {
>          next = find_next_bit(bitmap, size, start);
> @@ -1653,6 +1658,8 @@ static void ram_state_reset(RAMState *rs)
>      rs->last_page = 0;
>      rs->last_version = ram_list.version;
>      rs->ram_bulk_stage = true;
> +    rs->free_page_support = balloon_free_page_support();
> +    rs->free_page_done = false;
>  }
>  
>  #define MAX_WAIT 50 /* ms, half buffered_file limit */
> @@ -2135,7 +2142,7 @@ static int ram_state_init(RAMState **rsp)
>      return 0;
>  }
>  
> -static void ram_list_init_bitmaps(void)
> +static void ram_list_init_bitmaps(RAMState *rs)
>  {
>      RAMBlock *block;
>      unsigned long pages;
> @@ -2145,7 +2152,11 @@ static void ram_list_init_bitmaps(void)
>          QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>              pages = block->max_length >> TARGET_PAGE_BITS;
>              block->bmap = bitmap_new(pages);
> -            bitmap_set(block->bmap, 0, pages);
> +            if (rs->free_page_support) {
> +                bitmap_set(block->bmap, 1, pages);
> +            } else {
> +                bitmap_set(block->bmap, 0, pages);
> +            }
>              if (migrate_postcopy_ram()) {
>                  block->unsentmap = bitmap_new(pages);
>                  bitmap_set(block->unsentmap, 0, pages);
> @@ -2161,7 +2172,7 @@ static void ram_init_bitmaps(RAMState *rs)
>      qemu_mutex_lock_ramlist();
>      rcu_read_lock();
>  
> -    ram_list_init_bitmaps();
> +    ram_list_init_bitmaps(rs);
>      memory_global_dirty_log_start();
>      migration_bitmap_sync(rs);
>  
> @@ -2275,6 +2286,11 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>  
>      ram_control_before_iterate(f, RAM_CONTROL_ROUND);
>  
> +    if (rs->free_page_support && !rs->free_page_done) {
> +        balloon_free_page_poll();
> +        rs->free_page_done = true;
> +    }
> +
>      t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>      i = 0;
>      while ((ret = qemu_file_rate_limit(f)) == 0) {
> -- 
> 1.8.3.1
