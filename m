Received: from eggs.gnu.org ([2001:4830:134:3::10]:42680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dx9Ze-0004S7-Sv
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dx9Zb-0005hO-Mk
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 06:28:14 -0400
Date: Wed, 27 Sep 2017 11:28:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170927102801.GA5453@work-vm>
References: <1506421996-12513-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506421996-12513-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V3] migration: disable auto-converge during
 bulk block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-stable@nongnu.org

* Peter Lieven (pl@kamp.de) wrote:
> auto-converge and block migration currently do not play well together.
> During block migration the auto-converge logic detects that ram
> migration makes no progress and thus throttles down the vm until
> it nearly stalls completely. Avoid this by disabling the throttling
> logic during the bulk phase of the block migration.

Queued for migration (which hopefully I'll send a pull later today)

Dave

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
> V1->V2: add comment why we disable auto-converge during bulk block migration [Stefan]
> V2->V3: add missing patch for migration/block.h
> 
>  migration/block.c | 5 +++++
>  migration/block.h | 7 +++++++
>  migration/ram.c   | 6 +++++-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/block.c b/migration/block.c
> index 9171f60..606ad4d 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -161,6 +161,11 @@ int blk_mig_active(void)
>      return !QSIMPLEQ_EMPTY(&block_mig_state.bmds_list);
>  }
>  
> +int blk_mig_bulk_active(void)
> +{
> +    return blk_mig_active() && !block_mig_state.bulk_completed;
> +}
> +
>  uint64_t blk_mig_bytes_transferred(void)
>  {
>      BlkMigDevState *bmds;
> diff --git a/migration/block.h b/migration/block.h
> index 22ebe94..3178609 100644
> --- a/migration/block.h
> +++ b/migration/block.h
> @@ -16,6 +16,7 @@
>  
>  #ifdef CONFIG_LIVE_BLOCK_MIGRATION
>  int blk_mig_active(void);
> +int blk_mig_bulk_active(void);
>  uint64_t blk_mig_bytes_transferred(void);
>  uint64_t blk_mig_bytes_remaining(void);
>  uint64_t blk_mig_bytes_total(void);
> @@ -25,6 +26,12 @@ static inline int blk_mig_active(void)
>  {
>      return false;
>  }
> +
> +static inline int blk_mig_bulk_active(void)
> +{
> +    return false;
> +}
> +
>  static inline uint64_t blk_mig_bytes_transferred(void)
>  {
>      return 0;
> diff --git a/migration/ram.c b/migration/ram.c
> index 88ca69e..b83f897 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -46,6 +46,7 @@
>  #include "exec/ram_addr.h"
>  #include "qemu/rcu_queue.h"
>  #include "migration/colo.h"
> +#include "migration/block.h"
>  
>  /***********************************************************/
>  /* ram save/restore */
> @@ -825,7 +826,10 @@ static void migration_bitmap_sync(RAMState *rs)
>              / (end_time - rs->time_last_bitmap_sync);
>          bytes_xfer_now = ram_counters.transferred;
>  
> -        if (migrate_auto_converge()) {
> +        /* During block migration the auto-converge logic incorrectly detects
> +         * that ram migration makes no progress. Avoid this by disabling the
> +         * throttling logic during the bulk phase of block migration. */
> +        if (migrate_auto_converge() && !blk_mig_bulk_active()) {
>              /* The following detection logic can be refined later. For now:
>                 Check to see if the dirtied bytes is 50% more than the approx.
>                 amount of bytes that just got transferred since the last time we
> -- 
> 1.9.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
