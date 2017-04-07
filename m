Received: from eggs.gnu.org ([2001:4830:134:3::10]:59088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwWId-0005oO-67
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwWIZ-0004cq-AB
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:59:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cwWIZ-0004cg-1d
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:59:43 -0400
Date: Fri, 7 Apr 2017 16:59:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170407155934.GC2623@work-vm>
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-5-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487734936-43472-5-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 04/15] COLO: integrate colo compare with
 colo frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>

* zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> For COLO FT, both the PVM and SVM run at the same time,
> only sync the state while it needs.
> 
> So here, let SVM runs while not doing checkpoint,
> Besides, change DEFAULT_MIGRATE_X_CHECKPOINT_DELAY to 200*100.
> 
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/colo.c      | 25 +++++++++++++++++++++++++
>  migration/migration.c |  2 +-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 712308e..fb8d8fd 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -19,8 +19,11 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "migration/failover.h"
> +#include "net/colo-compare.h"
> +#include "net/colo.h"
>  
>  static bool vmstate_loading;
> +static Notifier packets_compare_notifier;
>  
>  #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
>  
> @@ -263,6 +266,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>      if (local_err) {
>          goto out;
>      }
> +
>      /* Reset channel-buffer directly */
>      qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
>      bioc->usage = 0;
> @@ -283,6 +287,11 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>          goto out;
>      }
>  
> +    colo_notify_compares_event(NULL, COLO_CHECKPOINT, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
>      /* Disable block migration */
>      s->params.blk = 0;
>      s->params.shared = 0;
> @@ -341,6 +350,11 @@ out:
>      return ret;
>  }
>  
> +static void colo_compare_notify_checkpoint(Notifier *notifier, void *data)
> +{
> +    colo_checkpoint_notify(data);
> +}
> +
>  static void colo_process_checkpoint(MigrationState *s)
>  {
>      QIOChannelBuffer *bioc;
> @@ -357,6 +371,9 @@ static void colo_process_checkpoint(MigrationState *s)
>          goto out;
>      }
>  
> +    packets_compare_notifier.notify = colo_compare_notify_checkpoint;
> +    colo_compare_register_notifier(&packets_compare_notifier);
> +
>      /*
>       * Wait for Secondary finish loading VM states and enter COLO
>       * restore.
> @@ -402,6 +419,7 @@ out:
>          qemu_fclose(fb);
>      }
>  
> +    colo_compare_unregister_notifier(&packets_compare_notifier);
>      timer_del(s->colo_delay_timer);
>  
>      /* Hope this not to be too long to wait here */
> @@ -518,6 +536,11 @@ void *colo_process_incoming_thread(void *opaque)
>              goto out;
>          }
>  
> +        qemu_mutex_lock_iothread();
> +        vm_stop_force_state(RUN_STATE_COLO);
> +        trace_colo_vm_state_change("run", "stop");
> +        qemu_mutex_unlock_iothread();
> +
>          /* FIXME: This is unnecessary for periodic checkpoint mode */
>          colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_REPLY,
>                       &local_err);
> @@ -571,6 +594,8 @@ void *colo_process_incoming_thread(void *opaque)
>          }
>  
>          vmstate_loading = false;
> +        vm_start();
> +        trace_colo_vm_state_change("stop", "run");
>          qemu_mutex_unlock_iothread();
>  
>          if (failover_get_state() == FAILOVER_STATUS_RELAUNCH) {
> diff --git a/migration/migration.c b/migration/migration.c
> index c6ae69d..2339be7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -66,7 +66,7 @@
>  /* The delay time (in ms) between two COLO checkpoints
>   * Note: Please change this default value to 10000 when we support hybrid mode.
>   */
> -#define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
> +#define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
>  
>  static NotifierList migration_state_notifiers =
>      NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
> -- 
> 1.8.3.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
