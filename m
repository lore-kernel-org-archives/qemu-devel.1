Received: from eggs.gnu.org ([2001:4830:134:3::10]:39599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cXB00-0001mN-D4
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cXAzw-0008II-0f
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:11:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51291
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1cXAzv-0008Hn-Rf
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:11:43 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0RI3lQd094447
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 13:11:41 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28896pmubq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 13:11:41 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Fri, 27 Jan 2017 18:11:38 -0000
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2017 19:11:32 +0100
In-Reply-To: <1485540693-31723-1-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1485540693-31723-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Message-Id: <1485540693-31723-2-git-send-email-imbrenda@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v7 1/2] move vm_start to cpus.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, palves@redhat.com, alex.bennee@linaro.org

This patch:

* moves vm_start to cpus.c.
* exports qemu_vmstop_requested, since it's needed by vm_start.
* extracts vm_prepare_start from vm_start; it does what vm_start did,
  except restarting the cpus.
* vm_start now calls vm_prepare_start and then restarts the cpus.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
 cpus.c                  | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/sysemu.h |  2 ++
 vl.c                    | 30 +-----------------------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/cpus.c b/cpus.c
index 71a82e5..061de39 100644
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
+    /* XXX: is it ok to send this even before actually resuming the CPUs? */
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
index ff8ffb5..0bb0c40 100644
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
index abb0900..7a32a30 100644
--- a/vl.c
+++ b/vl.c
@@ -757,7 +757,7 @@ StatusInfo *qmp_query_status(Error **errp)
     return info;
 }
 
-static bool qemu_vmstop_requested(RunState *r)
+bool qemu_vmstop_requested(RunState *r)
 {
     qemu_mutex_lock(&vmstop_lock);
     *r = vmstop_requested;
@@ -778,34 +778,6 @@ void qemu_system_vmstop_request(RunState state)
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
1.9.1
