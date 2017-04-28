Received: from eggs.gnu.org ([2001:4830:134:3::10]:34332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d49BE-0006AL-Dd
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d49BB-0007gO-BO
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:55:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d49BB-0007g7-2L
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:55:37 -0400
Date: Fri, 28 Apr 2017 17:55:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170428165522.GG3276@work-vm>
References: <20170425103049.4073-1-quintela@redhat.com>
	<20170425103049.4073-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425103049.4073-3-quintela@redhat.com>
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, zhang.zhanghailiang@huawei.com

* Juan Quintela (quintela@redhat.com) wrote:
> We have change in the previous patch to use migration capabilities for
> it.  Notice that we continue using the old command line flags from
> migrate command from the time being.  Remove the set_params method as
> now it is empty.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h |  3 +--
>  migration/block.c             | 17 ++---------------
>  migration/colo.c              |  3 ---
>  migration/migration.c         |  8 +++++---
>  migration/savevm.c            |  2 --
>  5 files changed, 8 insertions(+), 25 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index c19eb3f..5c6c2f0 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -332,9 +332,6 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>          goto out;
>      }
>  
> -    /* Disable block migration */
> -    s->params.blk = 0;
> -    s->params.shared = 0;

Hmm you don't seem to have replaced this with anything.
I think that's a behavioural change; the trick COLO did (I'm not sure if this
is still the way it works) is that they initiate the first migration
with block migration enabled so that the two hosts (with non-shared storage)
get sync'd storage, and then at the completion of that first migration
they then switch into the checkpointing mode where they're only
doing updates - that's why it gets switched off at this point
prior to the 1st checkpoint.

Dave

>      qemu_savevm_state_header(fb);
>      qemu_savevm_state_begin(fb, &s->params);
>      qemu_mutex_lock_iothread();
> diff --git a/migration/migration.c b/migration/migration.c
> index 775b24c..9b96f1a 100644
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
> +        migrate_set_block_enabled(s);
>          migrate_set_block_shared(s);
>      }
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 0c01988..102b11d 100644
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
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
