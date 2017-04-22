Received: from eggs.gnu.org ([2001:4830:134:3::10]:59947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNq-000248-PL
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNp-0000vP-MT
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:27:10 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3405
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qNo-0000uu-Qq
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:27:09 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:25:45 +0800
Message-ID: <1492849558-17540-6-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 05/18] COLO: Handle shutdown command for VM
 in COLO state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, gilbert@redhat.com
Cc: quintela@redhat.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

If VM is in COLO FT state, we need to do some extra works before
starting normal shutdown process.

Secondary VM will ignore the shutdown command if users issue it directly
to Secondary VM. COLO will capture shutdown command and after
shutdown request from user.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/colo.h |  1 +
 include/sysemu/sysemu.h  |  3 +++
 migration/colo.c         | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 qapi-schema.json         |  4 +++-
 vl.c                     | 19 ++++++++++++++++---
 5 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 2bbff9e..aadd040 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -37,4 +37,5 @@ COLOMode get_colo_mode(void);
 void colo_do_failover(MigrationState *s);
 
 void colo_checkpoint_notify(void *opaque);
+bool colo_handle_shutdown(void);
 #endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 16175f7..8054f53 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -49,6 +49,8 @@ typedef enum WakeupReason {
     QEMU_WAKEUP_REASON_OTHER,
 } WakeupReason;
 
+extern int colo_shutdown_requested;
+
 void qemu_system_reset_request(void);
 void qemu_system_suspend_request(void);
 void qemu_register_suspend_notifier(Notifier *notifier);
@@ -56,6 +58,7 @@ void qemu_system_wakeup_request(WakeupReason reason);
 void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
 void qemu_register_wakeup_notifier(Notifier *notifier);
 void qemu_system_shutdown_request(void);
+void qemu_system_shutdown_request_core(void);
 void qemu_system_powerdown_request(void);
 void qemu_register_powerdown_notifier(Notifier *notifier);
 void qemu_system_debug_request(void);
diff --git a/migration/colo.c b/migration/colo.c
index a3344ce..c4fc865 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -384,6 +384,21 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
         goto out;
     }
 
+    if (colo_shutdown_requested) {
+        colo_send_message(s->to_dst_file, COLO_MESSAGE_GUEST_SHUTDOWN,
+                          &local_err);
+        if (local_err) {
+            error_free(local_err);
+            /* Go on the shutdown process and throw the error message */
+            error_report("Failed to send shutdown message to SVM");
+        }
+        qemu_fflush(s->to_dst_file);
+        colo_shutdown_requested = 0;
+        qemu_system_shutdown_request_core();
+        /* Fix me: Just let the colo thread exit ? */
+        qemu_thread_exit(0);
+    }
+
     ret = 0;
 
     qemu_mutex_lock_iothread();
@@ -449,7 +464,9 @@ static void colo_process_checkpoint(MigrationState *s)
             goto out;
         }
 
-        qemu_sem_wait(&s->colo_checkpoint_sem);
+        if (!colo_shutdown_requested) {
+            qemu_sem_wait(&s->colo_checkpoint_sem);
+        }
 
         ret = colo_do_checkpoint_transaction(s, bioc, fb);
         if (ret < 0) {
@@ -534,6 +551,16 @@ static void colo_wait_handle_message(QEMUFile *f, int *checkpoint_request,
     case COLO_MESSAGE_CHECKPOINT_REQUEST:
         *checkpoint_request = 1;
         break;
+    case COLO_MESSAGE_GUEST_SHUTDOWN:
+        qemu_mutex_lock_iothread();
+        vm_stop_force_state(RUN_STATE_COLO);
+        qemu_system_shutdown_request_core();
+        qemu_mutex_unlock_iothread();
+        /*
+         * The main thread will be exit and terminate the whole
+         * process, do need some cleanup ?
+         */
+        qemu_thread_exit(0);
     default:
         *checkpoint_request = 0;
         error_setg(errp, "Got unknown COLO message: %d", msg);
@@ -696,3 +723,20 @@ out:
 
     return NULL;
 }
+
+bool colo_handle_shutdown(void)
+{
+    /*
+     * If VM is in COLO-FT mode, we need do some significant work before
+     * respond to the shutdown request. Besides, Secondary VM will ignore
+     * the shutdown request from users.
+     */
+    if (migration_incoming_in_colo_state()) {
+        return true;
+    }
+    if (migration_in_colo_state()) {
+        colo_shutdown_requested = 1;
+        return true;
+    }
+    return false;
+}
diff --git a/qapi-schema.json b/qapi-schema.json
index 01b087f..4b3e1b7 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1187,12 +1187,14 @@
 #
 # @vmstate-loaded: VM's state has been loaded by SVM.
 #
+# @guest-shutdown: shutdown requested from PVM to SVM. (Since 2.9)
+#
 # Since: 2.8
 ##
 { 'enum': 'COLOMessage',
   'data': [ 'checkpoint-ready', 'checkpoint-request', 'checkpoint-reply',
             'vmstate-send', 'vmstate-size', 'vmstate-received',
-            'vmstate-loaded' ] }
+            'vmstate-loaded', 'guest-shutdown' ] }
 
 ##
 # @COLOMode:
diff --git a/vl.c b/vl.c
index 0b4ed52..72638c9 100644
--- a/vl.c
+++ b/vl.c
@@ -1611,6 +1611,8 @@ static NotifierList wakeup_notifiers =
     NOTIFIER_LIST_INITIALIZER(wakeup_notifiers);
 static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
 
+int colo_shutdown_requested;
+
 int qemu_shutdown_requested_get(void)
 {
     return shutdown_requested;
@@ -1737,7 +1739,10 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
 void qemu_system_reset_request(void)
 {
     if (no_reboot) {
-        shutdown_requested = 1;
+        qemu_system_shutdown_request();
+        if (!shutdown_requested) {/* colo handle it ? */
+            return;
+        }
     } else {
         reset_requested = 1;
     }
@@ -1810,14 +1815,22 @@ void qemu_system_killed(int signal, pid_t pid)
     qemu_notify_event();
 }
 
-void qemu_system_shutdown_request(void)
+void qemu_system_shutdown_request_core(void)
 {
-    trace_qemu_system_shutdown_request();
     replay_shutdown_request();
     shutdown_requested = 1;
     qemu_notify_event();
 }
 
+void qemu_system_shutdown_request(void)
+{
+    trace_qemu_system_shutdown_request();
+    if (colo_handle_shutdown()) {
+        return;
+    }
+    qemu_system_shutdown_request_core();
+}
+
 static void qemu_system_powerdown(void)
 {
     qapi_event_send_powerdown(&error_abort);
-- 
1.8.3.1
