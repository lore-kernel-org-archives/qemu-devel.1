Received: from eggs.gnu.org ([2001:4830:134:3::10]:56018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dn1VA-000470-Ot
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dn1V9-0005rz-O1
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:49:44 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170830100605.22694-1-famz@redhat.com> (Fam Zheng's message of
	"Wed, 30 Aug 2017 18:06:05 +0800")
References: <20170830100605.22694-1-famz@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 30 Aug 2017 13:49:28 +0200
Message-ID: <87mv6h5l87.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block: Cleanup BMDS in bdrv_close_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, peterx@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Fam Zheng <famz@redhat.com> wrote:
> This fixes the assertion due to op blockers added by BMDS:
>
> block.c:3248: bdrv_delete: Assertion `bdrv_op_blocker_is_empty(bs)' failed.
>
> Reproducer: simply start block migration and quit QEMU before it ends.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>

No need for one stub, see later.


> ---
>  block.c                 | 2 ++
>  migration/block.c       | 2 +-
>  migration/block.h       | 1 +
>  stubs/Makefile.objs     | 1 +
>  stubs/block-migration.c | 6 ++++++
>  5 files changed, 11 insertions(+), 1 deletion(-)
>  create mode 100644 stubs/block-migration.c
>
> diff --git a/block.c b/block.c
> index 3308814bba..508a57274d 100644
> --- a/block.c
> +++ b/block.c
> @@ -43,6 +43,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/id.h"
>  #include "qapi/util.h"
> +#include "migration/block.h"

this should be misc.h

>  
>  #ifdef CONFIG_BSD
>  #include <sys/ioctl.h>
> @@ -3111,6 +3112,7 @@ static void bdrv_close(BlockDriverState *bs)
>  
>  void bdrv_close_all(void)
>  {
> +    block_migration_cleanup_bmds();
>      block_job_cancel_sync_all();
>      nbd_export_close_all();
>  

> diff --git a/migration/block.h b/migration/block.h
> index 22ebe94259..8bae1cf55a 100644
> --- a/migration/block.h
> +++ b/migration/block.h
> @@ -42,4 +42,5 @@ static inline uint64_t blk_mig_bytes_total(void)
>  #endif /* CONFIG_LIVE_BLOCK_MIGRATION */
>  
>  void migrate_set_block_enabled(bool value, Error **errp);
> +void block_migration_cleanup_bmds(void);
>  #endif /* MIGRATION_BLOCK_H */
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index e69c217aff..7540913767 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -19,6 +19,7 @@ stub-obj-y += is-daemonized.o
>  stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
>  stub-obj-y += machine-init-done.o
>  stub-obj-y += migr-blocker.o
> +stub-obj-y += block-migration.o
>  stub-obj-y += change-state-handler.o
>  stub-obj-y += monitor.o
>  stub-obj-y += notify-event.o
> diff --git a/stubs/block-migration.c b/stubs/block-migration.c
> new file mode 100644
> index 0000000000..855f15c757
> --- /dev/null
> +++ b/stubs/block-migration.c
> @@ -0,0 +1,6 @@
> +#include "qemu/osdep.h"
> +#include "migration/block.h"
> +
> +void block_migration_cleanup_bmds(void)
> +{
> +}

You can add this inside include/migration/misc.h

#ifdef CONFIG_LIVE_BLOCK_MIGRATION
void blk_mig_init(void);
#else
static inline void blk_mig_init(void) {}

// And then you add the stub here?

#endif


Once here, I would consider to give one error/warning if we quit qemu
and we are in the middle of a block migration, no?

Thanks, Juan.
