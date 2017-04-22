Received: from eggs.gnu.org ([2001:4830:134:3::10]:34214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXG-00014w-Vv
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXF-0003vo-Vi
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:55 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3846
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXF-0003tw-Cs
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:53 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:35:14 +0800
Message-ID: <1492850128-17472-5-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND v2 04/18] COLO: integrate colo compare
 with colo frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: quintela@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>

For COLO FT, both the PVM and SVM run at the same time,
only sync the state while it needs.

So here, let SVM runs while not doing checkpoint, change
DEFAULT_MIGRATE_X_CHECKPOINT_DELAY to 200*100.

Besides, we forgot to release colo_checkpoint_semd and
colo_delay_timer, fix them here.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c      | 42 ++++++++++++++++++++++++++++++++++++++++--
 migration/migration.c |  2 +-
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index c19eb3f..a3344ce 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -21,8 +21,11 @@
 #include "migration/failover.h"
 #include "replication.h"
 #include "qmp-commands.h"
+#include "net/colo-compare.h"
+#include "net/colo.h"
 
 static bool vmstate_loading;
+static Notifier packets_compare_notifier;
 
 #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
 
@@ -332,6 +335,11 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
         goto out;
     }
 
+    colo_notify_compares_event(NULL, COLO_CHECKPOINT, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
     /* Disable block migration */
     s->params.blk = 0;
     s->params.shared = 0;
@@ -390,6 +398,11 @@ out:
     return ret;
 }
 
+static void colo_compare_notify_checkpoint(Notifier *notifier, void *data)
+{
+    colo_checkpoint_notify(data);
+}
+
 static void colo_process_checkpoint(MigrationState *s)
 {
     QIOChannelBuffer *bioc;
@@ -406,6 +419,9 @@ static void colo_process_checkpoint(MigrationState *s)
         goto out;
     }
 
+    packets_compare_notifier.notify = colo_compare_notify_checkpoint;
+    colo_compare_register_notifier(&packets_compare_notifier);
+
     /*
      * Wait for Secondary finish loading VM states and enter COLO
      * restore.
@@ -451,11 +467,21 @@ out:
         qemu_fclose(fb);
     }
 
-    timer_del(s->colo_delay_timer);
-
     /* Hope this not to be too long to wait here */
     qemu_sem_wait(&s->colo_exit_sem);
     qemu_sem_destroy(&s->colo_exit_sem);
+
+    /*
+     * It is safe to unregister notifier after failover finished.
+     * Besides, colo_delay_timer and colo_checkpoint_sem can't be
+     * released befor unregister notifier, or there will be use-after-free
+     * error.
+     */
+    colo_compare_unregister_notifier(&packets_compare_notifier);
+    timer_del(s->colo_delay_timer);
+    timer_free(s->colo_delay_timer);
+    qemu_sem_destroy(&s->colo_checkpoint_sem);
+
     /*
      * Must be called after failover BH is completed,
      * Or the failover BH may shutdown the wrong fd that
@@ -548,6 +574,11 @@ void *colo_process_incoming_thread(void *opaque)
     fb = qemu_fopen_channel_input(QIO_CHANNEL(bioc));
     object_unref(OBJECT(bioc));
 
+    qemu_mutex_lock_iothread();
+    vm_start();
+    trace_colo_vm_state_change("stop", "run");
+    qemu_mutex_unlock_iothread();
+
     colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_READY,
                       &local_err);
     if (local_err) {
@@ -567,6 +598,11 @@ void *colo_process_incoming_thread(void *opaque)
             goto out;
         }
 
+        qemu_mutex_lock_iothread();
+        vm_stop_force_state(RUN_STATE_COLO);
+        trace_colo_vm_state_change("run", "stop");
+        qemu_mutex_unlock_iothread();
+
         /* FIXME: This is unnecessary for periodic checkpoint mode */
         colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_REPLY,
                      &local_err);
@@ -620,6 +656,8 @@ void *colo_process_incoming_thread(void *opaque)
         }
 
         vmstate_loading = false;
+        vm_start();
+        trace_colo_vm_state_change("stop", "run");
         qemu_mutex_unlock_iothread();
 
         if (failover_get_state() == FAILOVER_STATUS_RELAUNCH) {
diff --git a/migration/migration.c b/migration/migration.c
index 353f272..2ade2aa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -70,7 +70,7 @@
 /* The delay time (in ms) between two COLO checkpoints
  * Note: Please change this default value to 10000 when we support hybrid mode.
  */
-#define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
+#define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
-- 
1.8.3.1
