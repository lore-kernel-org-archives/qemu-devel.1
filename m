Received: from eggs.gnu.org ([2001:4830:134:3::10]:51814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6X-0003iG-LK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6V-00085L-5L
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:17 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:32861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6U-00084l-VQ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:15 -0500
Received: by mail-wr0-x242.google.com with SMTP id i10so2281066wrb.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:32 +0100
Message-Id: <1487255507-106654-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/23] move vm_start to cpus.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

This patch:

* moves vm_start to cpus.c.
* exports qemu_vmstop_requested, since it's needed by vm_start.
* extracts vm_prepare_start from vm_start; it does what vm_start did,
  except restarting the cpus.
* vm_start now calls vm_prepare_start and then restarts the cpus.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Message-Id: <1487092068-16562-2-git-send-email-imbrenda@linux.vnet.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c                  | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/sysemu.h |  2 ++
 vl.c                    | 30 +-----------------------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/cpus.c b/cpus.c
index 71a82e5..0bcb5b5 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1578,6 +1578,48 @@ int vm_stop(RunState state)
     return do_vm_stop(state);
 }
 
+/**
+ * Prepare for (re)starting the VM.
+ * Returns -1 if the vCPUs are not to be restarted (e.g. if they are already
+ * running or in case of an error condition), 0 otherwise.
+ */
+int vm_prepare_start(void)
+{
+    RunState requested;
+    int res = 0;
+
+    qemu_vmstop_requested(&requested);
+    if (runstate_is_running() && requested == RUN_STATE__MAX) {
+        return -1;
+    }
+
+    /* Ensure that a STOP/RESUME pair of events is emitted if a
+     * vmstop request was pending.  The BLOCK_IO_ERROR event, for
+     * example, according to documentation is always followed by
+     * the STOP event.
+     */
+    if (runstate_is_running()) {
+        qapi_event_send_stop(&error_abort);
+        res = -1;
+    } else {
+        replay_enable_events();
+        cpu_enable_ticks();
+        runstate_set(RUN_STATE_RUNNING);
+        vm_state_notify(1, RUN_STATE_RUNNING);
+    }
+
+    /* We are sending this now, but the CPUs will be resumed shortly later */
+    qapi_event_send_resume(&error_abort);
+    return res;
+}
+
+void vm_start(void)
+{
+    if (!vm_prepare_start()) {
+        resume_all_vcpus();
+    }
+}
+
 /* does a state transition even if the VM is already stopped,
    current state is forgotten forever */
 int vm_stop_force_state(RunState state)
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 4d50694..eda5241 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -37,6 +37,7 @@ void vm_state_notify(int running, RunState state);
 #define VMRESET_REPORT   true
 
 void vm_start(void);
+int vm_prepare_start(void);
 int vm_stop(RunState state);
 int vm_stop_force_state(RunState state);
 
@@ -60,6 +61,7 @@ void qemu_register_powerdown_notifier(Notifier *notifier);
 void qemu_system_debug_request(void);
 void qemu_system_vmstop_request(RunState reason);
 void qemu_system_vmstop_request_prepare(void);
+bool qemu_vmstop_requested(RunState *r);
 int qemu_shutdown_requested_get(void);
 int qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
diff --git a/vl.c b/vl.c
index b4eaf03..0d866ad 100644
--- a/vl.c
+++ b/vl.c
@@ -724,7 +724,7 @@ StatusInfo *qmp_query_status(Error **errp)
     return info;
 }
 
-static bool qemu_vmstop_requested(RunState *r)
+bool qemu_vmstop_requested(RunState *r)
 {
     qemu_mutex_lock(&vmstop_lock);
     *r = vmstop_requested;
@@ -745,34 +745,6 @@ void qemu_system_vmstop_request(RunState state)
     qemu_notify_event();
 }
 
-void vm_start(void)
-{
-    RunState requested;
-
-    qemu_vmstop_requested(&requested);
-    if (runstate_is_running() && requested == RUN_STATE__MAX) {
-        return;
-    }
-
-    /* Ensure that a STOP/RESUME pair of events is emitted if a
-     * vmstop request was pending.  The BLOCK_IO_ERROR event, for
-     * example, according to documentation is always followed by
-     * the STOP event.
-     */
-    if (runstate_is_running()) {
-        qapi_event_send_stop(&error_abort);
-    } else {
-        replay_enable_events();
-        cpu_enable_ticks();
-        runstate_set(RUN_STATE_RUNNING);
-        vm_state_notify(1, RUN_STATE_RUNNING);
-        resume_all_vcpus();
-    }
-
-    qapi_event_send_resume(&error_abort);
-}
-
-
 /***********************************************************/
 /* real time host monotonic timer */
 
-- 
1.8.3.1
