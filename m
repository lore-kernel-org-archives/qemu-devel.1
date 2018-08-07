Received: from eggs.gnu.org ([2001:4830:134:3::10]:46665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fn30W-0001Ck-Cs
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fn30T-0007Op-JJ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:30:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44136 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fn30T-0007OM-AQ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:30:41 -0400
Date: Tue, 7 Aug 2018 15:30:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180807143036.GJ2556@work-vm>
References: <20180722193350.6028-1-zhangckid@gmail.com>
	<20180722193350.6028-6-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722193350.6028-6-zhangckid@gmail.com>
Subject: Re: [Qemu-devel] [PATCH V10 05/20] COLO: Add block replication into
 colo process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

* Zhang Chen (zhangckid@gmail.com) wrote:
> Make sure master start block replication after slave's block
> replication started.
> 
> Besides, we need to activate VM's blocks before goes into
> COLO state.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  migration/colo.c      | 43 +++++++++++++++++++++++++++++++++++++++++++
>  migration/migration.c |  9 +++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 081df1835f..e06640c3d6 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -27,6 +27,7 @@
>  #include "replication.h"
>  #include "net/colo-compare.h"
>  #include "net/colo.h"
> +#include "block/block.h"
>  
>  static bool vmstate_loading;
>  static Notifier packets_compare_notifier;
> @@ -56,6 +57,7 @@ static void secondary_vm_do_failover(void)
>  {
>      int old_state;
>      MigrationIncomingState *mis = migration_incoming_get_current();
> +    Error *local_err = NULL;
>  
>      /* Can not do failover during the process of VM's loading VMstate, Or
>       * it will break the secondary VM.
> @@ -73,6 +75,11 @@ static void secondary_vm_do_failover(void)
>      migrate_set_state(&mis->state, MIGRATION_STATUS_COLO,
>                        MIGRATION_STATUS_COMPLETED);
>  
> +    replication_stop_all(true, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
> +
>      if (!autostart) {
>          error_report("\"-S\" qemu option will be ignored in secondary side");
>          /* recover runstate to normal migration finish state */
> @@ -110,6 +117,7 @@ static void primary_vm_do_failover(void)
>  {
>      MigrationState *s = migrate_get_current();
>      int old_state;
> +    Error *local_err = NULL;
>  
>      migrate_set_state(&s->state, MIGRATION_STATUS_COLO,
>                        MIGRATION_STATUS_COMPLETED);
> @@ -133,6 +141,13 @@ static void primary_vm_do_failover(void)
>                       FailoverStatus_str(old_state));
>          return;
>      }
> +
> +    replication_stop_all(true, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        local_err = NULL;
> +    }
> +
>      /* Notify COLO thread that failover work is finished */
>      qemu_sem_post(&s->colo_exit_sem);
>  }
> @@ -356,6 +371,11 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>      qemu_savevm_state_header(fb);
>      qemu_savevm_state_setup(fb);
>      qemu_mutex_lock_iothread();
> +    replication_do_checkpoint_all(&local_err);
> +    if (local_err) {
> +        qemu_mutex_unlock_iothread();
> +        goto out;
> +    }

In docs/block-replication.txt it says:
  b. replication_do_checkpoint_all()
   This interface is called after all VM state is transferred to
   Secondary QEMU. The Disk buffer will be dropped in this interface.
   The caller must hold the I/O mutex lock if it is in migration/checkpoint
   thread.

but we're making this call before the call below that actually transfers
all the state.  Which is right?

Other than that I think it's OK.

Dave

>      qemu_savevm_state_complete_precopy(fb, false, false);
>      qemu_mutex_unlock_iothread();
>  
> @@ -446,6 +466,12 @@ static void colo_process_checkpoint(MigrationState *s)
>      object_unref(OBJECT(bioc));
>  
>      qemu_mutex_lock_iothread();
> +    replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
> +    if (local_err) {
> +        qemu_mutex_unlock_iothread();
> +        goto out;
> +    }
> +
>      vm_start();
>      qemu_mutex_unlock_iothread();
>      trace_colo_vm_state_change("stop", "run");
> @@ -585,6 +611,11 @@ void *colo_process_incoming_thread(void *opaque)
>      object_unref(OBJECT(bioc));
>  
>      qemu_mutex_lock_iothread();
> +    replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
> +    if (local_err) {
> +        qemu_mutex_unlock_iothread();
> +        goto out;
> +    }
>      vm_start();
>      trace_colo_vm_state_change("stop", "run");
>      qemu_mutex_unlock_iothread();
> @@ -665,6 +696,18 @@ void *colo_process_incoming_thread(void *opaque)
>              goto out;
>          }
>  
> +        replication_get_error_all(&local_err);
> +        if (local_err) {
> +            qemu_mutex_unlock_iothread();
> +            goto out;
> +        }
> +        /* discard colo disk buffer */
> +        replication_do_checkpoint_all(&local_err);
> +        if (local_err) {
> +            qemu_mutex_unlock_iothread();
> +            goto out;
> +        }
> +
>          vmstate_loading = false;
>          vm_start();
>          trace_colo_vm_state_change("stop", "run");
> diff --git a/migration/migration.c b/migration/migration.c
> index ce06941706..c97b7660af 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -385,6 +385,7 @@ static void process_incoming_migration_co(void *opaque)
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      PostcopyState ps;
>      int ret;
> +    Error *local_err = NULL;
>  
>      assert(mis->from_src_file);
>      mis->largest_page_size = qemu_ram_pagesize_largest();
> @@ -416,6 +417,14 @@ static void process_incoming_migration_co(void *opaque)
>  
>      /* we get COLO info, and know if we are in COLO mode */
>      if (!ret && migration_incoming_enable_colo()) {
> +        /* Make sure all file formats flush their mutable metadata */
> +        bdrv_invalidate_cache_all(&local_err);
> +        if (local_err) {
> +            migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> +                    MIGRATION_STATUS_FAILED);
> +            error_report_err(local_err);
> +            exit(EXIT_FAILURE);
> +        }
>          mis->migration_incoming_co = qemu_coroutine_self();
>          qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
>               colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
