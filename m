Received: from eggs.gnu.org ([2001:4830:134:3::10]:37673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fhK7o-00029y-Rq
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fhK7l-0000XZ-N1
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:34:36 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:44970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fhK7l-0000WQ-Ev
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:34:33 -0400
Received: by mail-pg1-x535.google.com with SMTP id r1-v6so10655093pgp.11
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 12:34:33 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 23 Jul 2018 03:33:34 +0800
Message-Id: <20180722193350.6028-5-zhangckid@gmail.com>
In-Reply-To: <20180722193350.6028-1-zhangckid@gmail.com>
References: <20180722193350.6028-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V10 04/20] COLO: integrate colo compare with
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
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

For COLO FT, both the PVM and SVM run at the same time,
only sync the state while it needs.

So here, let SVM runs while not doing checkpoint, change
DEFAULT_MIGRATE_X_CHECKPOINT_DELAY to 200*100.

Besides, we forgot to release colo_checkpoint_semd and
colo_delay_timer, fix them here.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c      | 42 ++++++++++++++++++++++++++++++++++++++++--
 migration/migration.c |  6 ++----
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 4381067ed4..081df1835f 100644
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
@@ -558,6 +584,11 @@ void *colo_process_incoming_thread(void *opaque)
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
@@ -577,6 +608,11 @@ void *colo_process_incoming_thread(void *opaque)
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
@@ -630,6 +666,8 @@ void *colo_process_incoming_thread(void *opaque)
         }
 
         vmstate_loading = false;
+        vm_start();
+        trace_colo_vm_state_change("stop", "run");
         qemu_mutex_unlock_iothread();
 
         if (failover_get_state() == FAILOVER_STATUS_RELAUNCH) {
diff --git a/migration/migration.c b/migration/migration.c
index 8d56d56930..ce06941706 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -75,10 +75,8 @@
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
2.17.1
