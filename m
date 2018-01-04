Received: from eggs.gnu.org ([2001:4830:134:3::10]:36763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybF-0003ZY-3e
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybD-00042A-VY
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:01:57 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eWybD-0003zn-OV
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:01:55 -0500
Received: by mail-pl0-x244.google.com with SMTP id d21so521160pll.1
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 22:01:55 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu,  4 Jan 2018 14:01:03 +0800
Message-Id: <1515045675-6993-5-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH RESEND V3 04/16] COLO: integrate colo compare
 with colo frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: Zhang Chen <zhangckid@gmail.com>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

For COLO FT, both the PVM and SVM run at the same time,
only sync the state while it needs.

So here, let SVM runs while not doing checkpoint, change
DEFAULT_MIGRATE_X_CHECKPOINT_DELAY to 200*100.

Besides, we forgot to release colo_checkpoint_semd and
colo_delay_timer, fix them here.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c      | 42 ++++++++++++++++++++++++++++++++++++++++--
 migration/migration.c |  4 ++--
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index dee3aa8..c513805 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -24,8 +24,11 @@
 #include "migration/failover.h"
 #include "replication.h"
 #include "qmp-commands.h"
+#include "net/colo-compare.h"
+#include "net/colo.h"
 
 static bool vmstate_loading;
+static Notifier packets_compare_notifier;
 
 #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
 
@@ -342,6 +345,11 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
         goto out;
     }
 
+    colo_notify_compares_event(NULL, COLO_EVENT_CHECKPOINT, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
     /* Disable block migration */
     migrate_set_block_enabled(false, &local_err);
     qemu_savevm_state_header(fb);
@@ -399,6 +407,11 @@ out:
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
@@ -415,6 +428,9 @@ static void colo_process_checkpoint(MigrationState *s)
         goto out;
     }
 
+    packets_compare_notifier.notify = colo_compare_notify_checkpoint;
+    colo_compare_register_notifier(&packets_compare_notifier);
+
     /*
      * Wait for Secondary finish loading VM states and enter COLO
      * restore.
@@ -460,11 +476,21 @@ out:
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
@@ -557,6 +583,11 @@ void *colo_process_incoming_thread(void *opaque)
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
@@ -576,6 +607,11 @@ void *colo_process_incoming_thread(void *opaque)
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
@@ -629,6 +665,8 @@ void *colo_process_incoming_thread(void *opaque)
         }
 
         vmstate_loading = false;
+        vm_start();
+        trace_colo_vm_state_change("stop", "run");
         qemu_mutex_unlock_iothread();
 
         if (failover_get_state() == FAILOVER_STATUS_RELAUNCH) {
diff --git a/migration/migration.c b/migration/migration.c
index 4de3b55..ced463c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -74,9 +74,9 @@
 #define DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE (64 * 1024 * 1024)
 
 /* The delay time (in ms) between two COLO checkpoints
- * Note: Please change this default value to 10000 when we support hybrid mode.
+ * Note: Please change this default value to 20000 when we support hybrid mode.
  */
-#define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
+#define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
 #define DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT 16
 
-- 
2.7.4
