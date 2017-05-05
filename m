Received: from eggs.gnu.org ([2001:4830:134:3::10]:41388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6j3W-0004Xk-Gn
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6j3U-0003oZ-Ug
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:38:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6j3U-0003o3-Lb
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:38:20 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 May 2017 14:38:07 -0500
Message-Id: <20170505193810.2934-3-eblake@redhat.com>
In-Reply-To: <20170505193810.2934-1-eblake@redhat.com>
References: <20170505193810.2934-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 2/5] shutdown: Prepare for use of an enum in
 reset/shutdown_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>

We want to track why a guest was shutdown; in particular, being able
to tell the difference between a guest request (such as ACPI request)
and host request (such as SIGINT) will prove useful to libvirt.
Since all requests eventually end up changing shutdown_requested in
vl.c, the logical change is to make that value track the reason,
rather than its current 0/1 contents.

Since command-line options control whether a reset request is turned
into a shutdown request instead, the same treatment is given to
reset_requested.

This patch adds an internal enum ShutdownCause that describes reasons
that a shutdown can be requested, and changes qemu_system_reset() to
pass the reason through, although for now it is not reported.  The
enum could be exported via QAPI at a later date, if deemed necessary,
but for now, there has not been a request to expose that much detail
to end clients.

For now, we only populate the reason with HOST_ERROR, along with FIXME
comments that describe our plans for how to pass an actual correct
reason.  The next patches will then actually wire things up to modify
events to report data based on the reason, and to pass the correct enum
value in from various call-sites that can trigger a reset/shutdown (big
enough that it was worth splitting from this patch).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v6: make ShutdownCause internal-only, add SHUTDOWN_CAUSE_NONE so that
comparison to 0 still works, tweak initial FIXME values
v5: no change
v4: s/ShutdownType/ShutdownCause/, no thanks to mingw header pollution
v3: new patch
---
 include/sysemu/sysemu.h | 22 ++++++++++++++++++---
 vl.c                    | 51 +++++++++++++++++++++++++++++++------------------
 hw/i386/xen/xen-hvm.c   |  7 +++++--
 migration/colo.c        |  2 +-
 migration/savevm.c      |  2 +-
 5 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 16175f7..e4da9d4 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -36,6 +36,22 @@ void vm_state_notify(int running, RunState state);
 #define VMRESET_SILENT   false
 #define VMRESET_REPORT   true

+/* Enumeration of various causes for shutdown. */
+typedef enum ShutdownCause ShutdownCause;
+enum ShutdownCause {
+    SHUTDOWN_CAUSE_NONE,          /* No shutdown requested yet */
+    SHUTDOWN_CAUSE_HOST_QMP,      /* Reaction to a QMP command, like 'quit' */
+    SHUTDOWN_CAUSE_HOST_SIGNAL,   /* Reaction to a signal, such as SIGINT */
+    SHUTDOWN_CAUSE_HOST_UI,       /* Reaction to UI event, like window close */
+    SHUTDOWN_CAUSE_HOST_ERROR,    /* An error prevents further use of guest */
+    SHUTDOWN_CAUSE_GUEST_SHUTDOWN,/* Guest requested shutdown, such as via
+                                     ACPI or other hardware-specific means */
+    SHUTDOWN_CAUSE_GUEST_RESET,   /* Guest requested reset, and command line
+                                     turns that into a shutdown */
+    SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line turns
+                                     that into a shutdown */
+};
+
 void vm_start(void);
 int vm_prepare_start(void);
 int vm_stop(RunState state);
@@ -62,10 +78,10 @@ void qemu_system_debug_request(void);
 void qemu_system_vmstop_request(RunState reason);
 void qemu_system_vmstop_request_prepare(void);
 bool qemu_vmstop_requested(RunState *r);
-int qemu_shutdown_requested_get(void);
-int qemu_reset_requested_get(void);
+ShutdownCause qemu_shutdown_requested_get(void);
+ShutdownCause qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
-void qemu_system_reset(bool report);
+void qemu_system_reset(bool report, ShutdownCause reason);
 void qemu_system_guest_panicked(GuestPanicInformation *info);
 size_t qemu_target_page_size(void);

diff --git a/vl.c b/vl.c
index f22a3ac..6069fb2 100644
--- a/vl.c
+++ b/vl.c
@@ -1597,8 +1597,9 @@ void vm_state_notify(int running, RunState state)
     }
 }

-static int reset_requested;
-static int shutdown_requested, shutdown_signal;
+static ShutdownCause reset_requested;
+static ShutdownCause shutdown_requested;
+static int shutdown_signal;
 static pid_t shutdown_pid;
 static int powerdown_requested;
 static int debug_requested;
@@ -1612,19 +1613,19 @@ static NotifierList wakeup_notifiers =
     NOTIFIER_LIST_INITIALIZER(wakeup_notifiers);
 static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);

-int qemu_shutdown_requested_get(void)
+ShutdownCause qemu_shutdown_requested_get(void)
 {
     return shutdown_requested;
 }

-int qemu_reset_requested_get(void)
+ShutdownCause qemu_reset_requested_get(void)
 {
     return reset_requested;
 }

 static int qemu_shutdown_requested(void)
 {
-    return atomic_xchg(&shutdown_requested, 0);
+    return atomic_xchg(&shutdown_requested, SHUTDOWN_CAUSE_NONE);
 }

 static void qemu_kill_report(void)
@@ -1647,14 +1648,14 @@ static void qemu_kill_report(void)
     }
 }

-static int qemu_reset_requested(void)
+static ShutdownCause qemu_reset_requested(void)
 {
-    int r = reset_requested;
+    ShutdownCause r = reset_requested;
     if (r && replay_checkpoint(CHECKPOINT_RESET_REQUESTED)) {
-        reset_requested = 0;
+        reset_requested = SHUTDOWN_CAUSE_NONE;
         return r;
     }
-    return false;
+    return SHUTDOWN_CAUSE_NONE;
 }

 static int qemu_suspend_requested(void)
@@ -1686,7 +1687,12 @@ static int qemu_debug_requested(void)
     return r;
 }

-void qemu_system_reset(bool report)
+/*
+ * Reset the VM. If @report is VMRESET_REPORT, issue an event, using
+ * the @reason interpreted as ShutdownCause for details.  Otherwise,
+ * @report is VMRESET_SILENT and @reason is ignored.
+ */
+void qemu_system_reset(bool report, ShutdownCause reason)
 {
     MachineClass *mc;

@@ -1700,6 +1706,7 @@ void qemu_system_reset(bool report)
         qemu_devices_reset();
     }
     if (report) {
+        assert(reason);
         qapi_event_send_reset(&error_abort);
     }
     cpu_synchronize_all_post_reset();
@@ -1738,9 +1745,10 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
 void qemu_system_reset_request(void)
 {
     if (no_reboot) {
-        shutdown_requested = 1;
+        /* FIXME - add a parameter to allow callers to specify reason */
+        shutdown_requested = SHUTDOWN_CAUSE_HOST_ERROR;
     } else {
-        reset_requested = 1;
+        reset_requested = SHUTDOWN_CAUSE_HOST_ERROR;
     }
     cpu_stop_current();
     qemu_notify_event();
@@ -1807,7 +1815,7 @@ void qemu_system_killed(int signal, pid_t pid)
     /* Cannot call qemu_system_shutdown_request directly because
      * we are in a signal handler.
      */
-    shutdown_requested = 1;
+    shutdown_requested = SHUTDOWN_CAUSE_HOST_SIGNAL;
     qemu_notify_event();
 }

@@ -1815,7 +1823,8 @@ void qemu_system_shutdown_request(void)
 {
     trace_qemu_system_shutdown_request();
     replay_shutdown_request();
-    shutdown_requested = 1;
+    /* FIXME - add a parameter to allow callers to specify reason */
+    shutdown_requested = SHUTDOWN_CAUSE_HOST_ERROR;
     qemu_notify_event();
 }

@@ -1846,13 +1855,16 @@ void qemu_system_debug_request(void)
 static bool main_loop_should_exit(void)
 {
     RunState r;
+    ShutdownCause request;
+
     if (qemu_debug_requested()) {
         vm_stop(RUN_STATE_DEBUG);
     }
     if (qemu_suspend_requested()) {
         qemu_system_suspend();
     }
-    if (qemu_shutdown_requested()) {
+    request = qemu_shutdown_requested();
+    if (request) {
         qemu_kill_report();
         qapi_event_send_shutdown(&error_abort);
         if (no_shutdown) {
@@ -1861,9 +1873,10 @@ static bool main_loop_should_exit(void)
             return true;
         }
     }
-    if (qemu_reset_requested()) {
+    request = qemu_reset_requested();
+    if (request) {
         pause_all_vcpus();
-        qemu_system_reset(VMRESET_REPORT);
+        qemu_system_reset(VMRESET_REPORT, request);
         resume_all_vcpus();
         if (!runstate_check(RUN_STATE_RUNNING) &&
                 !runstate_check(RUN_STATE_INMIGRATE)) {
@@ -1872,7 +1885,7 @@ static bool main_loop_should_exit(void)
     }
     if (qemu_wakeup_requested()) {
         pause_all_vcpus();
-        qemu_system_reset(VMRESET_SILENT);
+        qemu_system_reset(VMRESET_SILENT, SHUTDOWN_CAUSE_NONE);
         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
         resume_all_vcpus();
@@ -4686,7 +4699,7 @@ int main(int argc, char **argv, char **envp)
        reading from the other reads, because timer polling functions query
        clock values from the log. */
     replay_checkpoint(CHECKPOINT_RESET);
-    qemu_system_reset(VMRESET_SILENT);
+    qemu_system_reset(VMRESET_SILENT, SHUTDOWN_CAUSE_NONE);
     register_global_state();
     if (replay_mode != REPLAY_MODE_NONE) {
         replay_vmstate_init();
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index b1c05ff..b1001c1 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1089,11 +1089,14 @@ static void cpu_handle_ioreq(void *opaque)
          * causes Xen to powerdown the domain.
          */
         if (runstate_is_running()) {
+            ShutdownCause request;
+
             if (qemu_shutdown_requested_get()) {
                 destroy_hvm_domain(false);
             }
-            if (qemu_reset_requested_get()) {
-                qemu_system_reset(VMRESET_REPORT);
+            request = qemu_reset_requested_get();
+            if (request) {
+                qemu_system_reset(VMRESET_REPORT, request);
                 destroy_hvm_domain(true);
             }
         }
diff --git a/migration/colo.c b/migration/colo.c
index 963c802..bf5b7e9 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -623,7 +623,7 @@ void *colo_process_incoming_thread(void *opaque)
         }

         qemu_mutex_lock_iothread();
-        qemu_system_reset(VMRESET_SILENT);
+        qemu_system_reset(VMRESET_SILENT, SHUTDOWN_CAUSE_NONE);
         vmstate_loading = true;
         if (qemu_loadvm_state(fb) < 0) {
             error_report("COLO: loadvm failed");
diff --git a/migration/savevm.c b/migration/savevm.c
index a00c1ab..9ac2d22 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2300,7 +2300,7 @@ int load_vmstate(const char *name)
         return -EINVAL;
     }

-    qemu_system_reset(VMRESET_SILENT);
+    qemu_system_reset(VMRESET_SILENT, SHUTDOWN_CAUSE_NONE);
     mis->from_src_file = f;

     aio_context_acquire(aio_context);
-- 
2.9.3
