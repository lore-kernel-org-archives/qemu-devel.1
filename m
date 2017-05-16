Received: from eggs.gnu.org ([2001:4830:134:3::10]:45796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAdMt-0002O2-2v
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAdMo-0008Mq-4y
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:22:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAdMn-0008Mb-SB
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:22:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5C6A7F4A7
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 14:22:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170516111123.17692-1-quintela@redhat.com>
	<20170516111123.17692-4-quintela@redhat.com>
Date: Tue, 16 May 2017 16:22:04 +0200
In-Reply-To: <20170516111123.17692-4-quintela@redhat.com> (Juan Quintela's
	message of "Tue, 16 May 2017 13:11:21 +0200")
Message-ID: <87o9usg9v7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/5] migration: Remove use of old
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Juan Quintela <quintela@redhat.com> writes:

> We have change in the previous patch to use migration capabilities for
> it.  Notice that we continue using the old command line flags from
> migrate command from the time being.  Remove the set_params method as
> now it is empty.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> ---
> - Maintain shared/enabled dependency (Xu suggestion)
> - Now we maintain the dependency on the setter functions
> ---
>  include/migration/migration.h |  3 +--
>  migration/block.c             | 17 ++---------------
>  migration/colo.c              |  4 ++--
>  migration/migration.c         |  3 ---
>  migration/savevm.c            |  8 ++++++--
>  5 files changed, 11 insertions(+), 24 deletions(-)
>
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index adcb8f6..1277226 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -43,8 +43,7 @@
>  extern int only_migratable;
>  
>  struct MigrationParams {
> -    bool blk;
> -    bool shared;
> +    bool unused; /* C doesn't allow empty structs */
>  };
>  
>  /* Messages sent on the return path from destination to source */
> diff --git a/migration/block.c b/migration/block.c
> index 060087f..5d22926 100644
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
> +        bmds->shared_base = migrate_use_block_incremental();
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
> +    return migrate_use_block();
>  }
>  
>  static SaveVMHandlers savevm_block_handlers = {
> -    .set_params = block_set_params,
>      .save_live_setup = block_save_setup,
>      .save_live_iterate = block_save_iterate,
>      .save_live_complete_precopy = block_save_complete,
> diff --git a/migration/colo.c b/migration/colo.c
> index 963c802..8c86892 100644
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
> @@ -345,8 +346,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>      }
>  
>      /* Disable block migration */
> -    s->params.blk = 0;
> -    s->params.shared = 0;
> +    migrate_set_block_enabled(false, &local_err);
>      qemu_savevm_state_header(fb);
>      qemu_savevm_state_begin(fb, &s->params);
>      qemu_mutex_lock_iothread();
> diff --git a/migration/migration.c b/migration/migration.c
> index 03f96df..c03f34e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1249,9 +1249,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>      bool block_enabled = false;
>      const char *p;
>  
> -    params.blk = has_blk && blk;
> -    params.shared = has_inc && inc;
> -
>      if (migration_is_setup_or_active(s->state) ||
>          s->state == MIGRATION_STATUS_CANCELLING ||
>          s->state == MIGRATION_STATUS_COLO) {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b4f736f..5fc10ab 100644
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
> @@ -1245,6 +1243,12 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>          goto done;
>      }
>  
> +    if (migrate_use_block()) {
> +        error_setg(errp, "Block migration and snapshots are incompatible");
> +        ret = -EINVAL;
> +        goto done;
> +    }
> +
>      qemu_mutex_unlock_iothread();
>      qemu_savevm_state_header(f);
>      qemu_savevm_state_begin(f, &params);

New error that isn't mentioned in the commit message.  Does it belong
here?
