Received: from eggs.gnu.org ([2001:4830:134:3::10]:56020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fwgek-0007NX-67
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fwgeg-0004Pk-Ui
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:40:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:38786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fwgeg-0004PO-Ni
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:40:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id u11-v6so8046021plq.5
	for <qemu-devel@nongnu.org>; Sun, 02 Sep 2018 21:40:02 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon,  3 Sep 2018 12:38:45 +0800
Message-Id: <20180903043900.28592-5-zhangckid@gmail.com>
In-Reply-To: <20180903043900.28592-1-zhangckid@gmail.com>
References: <20180903043900.28592-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V12 04/19] COLO: integrate colo compare with
 colo frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>

For COLO FT, both the PVM and SVM run at the same time,
only sync the state while it needs.

So here, let SVM runs while not doing checkpoint, change
DEFAULT_MIGRATE_X_CHECKPOINT_DELAY to 200*100.

Besides, we forgot to release colo_checkpoint_semd and
colo_delay_timer, fix them here.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c      | 42 ++++++++++++++++++++++++++++++++++++++++--
 migration/migration.c |  6 ++----
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 88936f5962..f4bdfde170 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -25,8 +25,11 @@
 #include "qemu/error-report.h"
 #include "migration/failover.h"
 #include "replication.h"
+#include "net/colo-compare.h"
+#include "net/colo.h"
 
 static bool vmstate_loading;
+static Notifier packets_compare_notifier;
 
 #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
 
@@ -343,6 +346,11 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
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
@@ -400,6 +408,11 @@ out:
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
@@ -416,6 +429,9 @@ static void colo_process_checkpoint(MigrationState *s)
         goto out;
     }
 
+    packets_compare_notifier.notify = colo_compare_notify_checkpoint;
+    colo_compare_register_notifier(&packets_compare_notifier);
+
     /*
      * Wait for Secondary finish loading VM states and enter COLO
      * restore.
@@ -461,11 +477,21 @@ out:
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
@@ -559,6 +585,11 @@ void *colo_process_incoming_thread(void *opaque)
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
@@ -578,6 +609,11 @@ void *colo_process_incoming_thread(void *opaque)
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
@@ -631,6 +667,8 @@ void *colo_process_incoming_thread(void *opaque)
         }
 
         vmstate_loading = false;
+        vm_start();
+        trace_colo_vm_state_change("stop", "run");
         qemu_mutex_unlock_iothread();
 
         if (failover_get_state() == FAILOVER_STATUS_RELAUNCH) {
diff --git a/migration/migration.c b/migration/migration.c
index 4b316ec343..2f3e9d40d1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -76,10 +76,8 @@
 /* Migration XBZRLE default cache size */
 #define DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE (64 * 1024 * 1024)
 
-/* The delay time (in ms) between two COLO checkpoints
- * Note: Please change this default value to 10000 when we support hybrid mode.
- */
-#define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
+/* The delay time (in ms) between two COLO checkpoints */
+#define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
 #define DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT 16
 
-- 
2.17.GIT
