Received: from eggs.gnu.org ([2001:4830:134:3::10]:38689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fwjMV-0004xM-OF
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fwjMU-0008Om-06
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:33:27 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fwjMT-0008Ny-Jg
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:33:25 -0400
Received: by mail-wm0-x242.google.com with SMTP id q8-v6so49336wmq.4
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 00:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180903043900.28592-1-zhangckid@gmail.com>
	<20180903043900.28592-6-zhangckid@gmail.com>
In-Reply-To: <20180903043900.28592-6-zhangckid@gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 3 Sep 2018 15:31:53 +0800
Message-ID: <CAK3tnvLJ4y19DxDrmcTc4mfDxhCAgRnEVrc6t=TgOU15w7xR6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V12 05/19] COLO: Add block replication into
 colo process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, jasowang@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Sorry, forgot to add the reviewed by:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks
Zhang Chen

On Mon, Sep 3, 2018 at 12:40 PM Zhang Chen <zhangckid@gmail.com> wrote:

> Make sure master start block replication after slave's block
> replication started.
>
> Besides, we need to activate VM's blocks before goes into
> COLO state.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  migration/colo.c      | 43 +++++++++++++++++++++++++++++++++++++++++++
>  migration/migration.c | 10 ++++++++++
>  2 files changed, 53 insertions(+)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index f4bdfde170..af04010061 100644
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
>          error_report("\"-S\" qemu option will be ignored in secondary
> side");
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
> @@ -356,6 +371,11 @@ static int
> colo_do_checkpoint_transaction(MigrationState *s,
>      qemu_savevm_state_header(fb);
>      qemu_savevm_state_setup(fb);
>      qemu_mutex_lock_iothread();
> +    replication_do_checkpoint_all(&local_err);
> +    if (local_err) {
> +        qemu_mutex_unlock_iothread();
> +        goto out;
> +    }
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
> @@ -586,6 +612,11 @@ void *colo_process_incoming_thread(void *opaque)
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
> @@ -666,6 +697,18 @@ void *colo_process_incoming_thread(void *opaque)
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
> index 2f3e9d40d1..f4ab7b2d01 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -386,6 +386,7 @@ static void process_incoming_migration_co(void *opaque)
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      PostcopyState ps;
>      int ret;
> +    Error *local_err = NULL;
>
>      assert(mis->from_src_file);
>      mis->migration_incoming_co = qemu_coroutine_self();
> @@ -418,6 +419,15 @@ static void process_incoming_migration_co(void
> *opaque)
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
> +
>          qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
>               colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
>          mis->have_colo_incoming_thread = true;
> --
> 2.17.GIT
>
>
