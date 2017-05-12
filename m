Received: from eggs.gnu.org ([2001:4830:134:3::10]:48237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d91Re-0001l6-UX
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d91Rb-0005VL-0l
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:40:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d91Ra-0005Us-NT
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:40:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BA32C059738
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 03:40:41 +0000 (UTC)
Date: Fri, 12 May 2017 11:40:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170512034033.GN28293@pxdev.xzpeter.org>
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511163228.6666-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Thu, May 11, 2017 at 06:32:27PM +0200, Juan Quintela wrote:
> We have change in the previous patch to use migration capabilities for
> it.  Notice that we continue using the old command line flags from
> migrate command from the time being.  Remove the set_params method as
> now it is empty.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h |  3 +--
>  migration/block.c             | 17 ++---------------
>  migration/colo.c              |  5 +++--
>  migration/migration.c         |  8 +++++---
>  migration/savevm.c            |  2 --
>  5 files changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 30c2913..2d5525c 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -39,8 +39,7 @@
>  #define QEMU_VM_SECTION_FOOTER       0x7e
>  
>  struct MigrationParams {
> -    bool blk;
> -    bool shared;
> +    bool unused; /* C doesn't allow empty structs */
>  };
>  
>  /* Messages sent on the return path from destination to source */
> diff --git a/migration/block.c b/migration/block.c
> index 060087f..fcfa823 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -94,9 +94,6 @@ typedef struct BlkMigBlock {
>  } BlkMigBlock;
>  
>  typedef struct BlkMigState {
> -    /* Written during setup phase.  Can be read without a lock.  */
> -    int blk_enable;
> -    int shared_base;
>      QSIMPLEQ_HEAD(bmds_list, BlkMigDevState) bmds_list;
>      int64_t total_sector_sum;
>      bool zero_blocks;
> @@ -425,7 +422,7 @@ static int init_blk_migration(QEMUFile *f)
>          bmds->bulk_completed = 0;
>          bmds->total_sectors = sectors;
>          bmds->completed_sectors = 0;
> -        bmds->shared_base = block_mig_state.shared_base;
> +        bmds->shared_base = migrate_use_block_shared();
>  
>          assert(i < num_bs);
>          bmds_bs[i].bmds = bmds;
> @@ -994,22 +991,12 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>      return 0;
>  }
>  
> -static void block_set_params(const MigrationParams *params, void *opaque)
> -{
> -    block_mig_state.blk_enable = params->blk;
> -    block_mig_state.shared_base = params->shared;
> -
> -    /* shared base means that blk_enable = 1 */
> -    block_mig_state.blk_enable |= params->shared;
> -}
> -
>  static bool block_is_active(void *opaque)
>  {
> -    return block_mig_state.blk_enable == 1;
> +    return migrate_use_block_enabled();
>  }
>  
>  static SaveVMHandlers savevm_block_handlers = {
> -    .set_params = block_set_params,
>      .save_live_setup = block_save_setup,
>      .save_live_iterate = block_save_iterate,
>      .save_live_complete_precopy = block_save_complete,
> diff --git a/migration/colo.c b/migration/colo.c
> index 963c802..e772384 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -14,6 +14,7 @@
>  #include "qemu/timer.h"
>  #include "sysemu/sysemu.h"
>  #include "migration/colo.h"
> +#include "migration/block.h"
>  #include "io/channel-buffer.h"
>  #include "trace.h"
>  #include "qemu/error-report.h"
> @@ -345,8 +346,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>      }
>  
>      /* Disable block migration */
> -    s->params.blk = 0;
> -    s->params.shared = 0;
> +    migrate_set_block_enabled(s, false);
> +    migrate_set_block_shared(s, false);
>      qemu_savevm_state_header(fb);
>      qemu_savevm_state_begin(fb, &s->params);
>      qemu_mutex_lock_iothread();
> diff --git a/migration/migration.c b/migration/migration.c
> index 2f981aa..8a3bf89 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -787,6 +787,10 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
>          s->enabled_capabilities[cap->value->capability] = cap->value->state;
>      }
>  
> +    if (s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED]) {
> +        s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_ENABLED] = true;
> +    }
> +

[1]

>      if (migrate_postcopy_ram()) {
>          if (migrate_use_compression()) {
>              /* The decompression threads asynchronously write into RAM
> @@ -1214,9 +1218,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>      MigrationParams params;
>      const char *p;
>  
> -    params.blk = has_blk && blk;
> -    params.shared = has_inc && inc;
> -
>      if (migration_is_setup_or_active(s->state) ||
>          s->state == MIGRATION_STATUS_CANCELLING ||
>          s->state == MIGRATION_STATUS_COLO) {
> @@ -1239,6 +1240,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>      }
>  
>      if (has_inc && inc) {
> +        migrate_set_block_enabled(s, true);
>          migrate_set_block_shared(s, true);

[2]

IIUC for [1] & [2] we are solving the same problem that "shared"
depends on "enabled" bit. Would it be good to unitfy this dependency
somewhere? E.g., by changing migrate_set_block_shared() into:

void migrate_set_block_shared(MigrationState *s, bool value)
{
    s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED] = value;
    if (value) {
        migrate_set_block_enabled(s, true);
    }
}

?

Another thing to mention: after switching to the capability interface,
we'll cache the "enabled" and "shared" bits now while we don't cache
it before, right? IIUC it'll affect behavior of such sequence:

- 1st migrate with enabled=1, shared=1, then
- 2nd migrate with enabled=0, shared=0

Before the series, the 2nd migrate will use enabled=shared=0, but
after the series it should be using enabled=shared=1. Not sure whether
this would be a problem (or I missed anything?).

Thanks,

>      }
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f8d1e8b..221fb4b 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1233,8 +1233,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>  {
>      int ret;
>      MigrationParams params = {
> -        .blk = 0,
> -        .shared = 0
>      };
>      MigrationState *ms = migrate_init(&params);
>      MigrationStatus status;
> -- 
> 2.9.3
> 

-- 
Peter Xu
