Received: from eggs.gnu.org ([2001:4830:134:3::10]:54332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dANkX-0005Ga-Ul
	for qemu-devel@nongnu.org; Mon, 15 May 2017 17:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dANkT-0004rD-VY
	for qemu-devel@nongnu.org; Mon, 15 May 2017 17:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dANkT-0004qy-Ng
	for qemu-devel@nongnu.org; Mon, 15 May 2017 17:41:49 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 15 May 2017 16:41:11 -0500
Message-Id: <20170515214114.15442-3-eblake@redhat.com>
In-Reply-To: <20170515214114.15442-1-eblake@redhat.com>
References: <20170515214114.15442-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v9 2/5] shutdown: Prepare for use of an enum in
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
Cc: armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>

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
pass the reason through, although for now nothing is actually changed
with regards to what gets reported.  The enum could be exported via
QAPI at a later date, if deemed necessary, but for now, there has not
been a request to expose that much detail to end clients.

For the most part, we turn 0 into SHUTDOWN_CAUSE_NONE, and 1 into
SHUTDOWN_CAUSE_HOST_ERROR; the only specific case where we have enough
information right now to use a different value is when we are reacting
to a host signal.  It will take a further patch to edit all call-sites
that can trigger a reset or shutdown request to properly pass in any
other reasons; this patch includes TODOs to point such places out.

qemu_system_reset() trades its 'bool report' parameter for a
'ShutdownCause reason', with all non-zero values having the same
effect; this lets us get rid of the weird #defines for VMRESET_*
as synonyms for bools.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v9: one more stray FIXME
v8: s/FIXME/TODO/, include SHUTDOWN_CAUSE__MAX now rather than later,
tweak comment on GUEST_SHUTDOWN to mention suspend
v7: drop 'bool report' from qemu_system_reset(), reorder enum to put
HOST_ERROR == 1, improve commit message
v6: make ShutdownCause internal-only, add SHUTDOWN_CAUSE_NONE so that
comparison to 0 still works, tweak initial FIXME values
v5: no change
v4: s/ShutdownType/ShutdownCause/, no thanks to mingw header pollution
v3: new patch
---
 include/sysemu/sysemu.h | 23 ++++++++++++++++-----
 vl.c                    | 53 ++++++++++++++++++++++++++++++-------------------
 hw/i386/xen/xen-hvm.c   |  7 +++++--
 migration/colo.c        |  2 +-
 migration/savevm.c      |  2 +-
 5 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 15656b7..52102fd 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -33,8 +33,21 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
 void vm_state_notify(int running, RunState state);

-#define VMRESET_SILENT   false
-#define VMRESET_REPORT   true
+/* Enumeration of various causes for shutdown. */
+typedef enum ShutdownCause {
+    SHUTDOWN_CAUSE_NONE,          /* No shutdown request pending */
+    SHUTDOWN_CAUSE_HOST_ERROR,    /* An error prevents further use of guest */
+    SHUTDOWN_CAUSE_HOST_QMP,      /* Reaction to a QMP command, like 'quit' */
+    SHUTDOWN_CAUSE_HOST_SIGNAL,   /* Reaction to a signal, such as SIGINT */
+    SHUTDOWN_CAUSE_HOST_UI,       /* Reaction to UI event, like window close */
+    SHUTDOWN_CAUSE_GUEST_SHUTDOWN,/* Guest shutdown/suspend request, via
+                                     ACPI or other hardware-specific means */
+    SHUTDOWN_CAUSE_GUEST_RESET,   /* Guest reset request, and command line
+                                     turns that into a shutdown */
+    SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line turns
+                                     that into a shutdown */
+    SHUTDOWN_CAUSE__MAX,
+} ShutdownCause;

 void vm_start(void);
 int vm_prepare_start(void);
@@ -62,10 +75,10 @@ void qemu_system_debug_request(void);
 void qemu_system_vmstop_request(RunState reason);
 void qemu_system_vmstop_request_prepare(void);
 bool qemu_vmstop_requested(RunState *r);
-int qemu_shutdown_requested_get(void);
-int qemu_reset_requested_get(void);
+ShutdownCause qemu_shutdown_requested_get(void);
+ShutdownCause qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
-void qemu_system_reset(bool report);
+void qemu_system_reset(ShutdownCause reason);
 void qemu_system_guest_panicked(GuestPanicInformation *info);
 size_t qemu_target_page_size(void);

diff --git a/vl.c b/vl.c
index 7396748..5c61d8c 100644
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
@@ -1647,14 +1648,15 @@ static void qemu_kill_report(void)
     }
 }

-static int qemu_reset_requested(void)
+static ShutdownCause qemu_reset_requested(void)
 {
-    int r = reset_requested;
+    ShutdownCause r = reset_requested;
+
     if (r && replay_checkpoint(CHECKPOINT_RESET_REQUESTED)) {
-        reset_requested = 0;
+        reset_requested = SHUTDOWN_CAUSE_NONE;
         return r;
     }
-    return false;
+    return SHUTDOWN_CAUSE_NONE;
 }

 static int qemu_suspend_requested(void)
@@ -1686,7 +1688,10 @@ static int qemu_debug_requested(void)
     return r;
 }

-void qemu_system_reset(bool report)
+/*
+ * Reset the VM. Issue an event unless @reason is SHUTDOWN_CAUSE_NONE.
+ */
+void qemu_system_reset(ShutdownCause reason)
 {
     MachineClass *mc;

@@ -1699,7 +1704,8 @@ void qemu_system_reset(bool report)
     } else {
         qemu_devices_reset();
     }
-    if (report) {
+    if (reason) {
+        /* TODO update event based on reason */
         qapi_event_send_reset(&error_abort);
     }
     cpu_synchronize_all_post_reset();
@@ -1738,9 +1744,10 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
 void qemu_system_reset_request(void)
 {
     if (no_reboot) {
-        shutdown_requested = 1;
+        /* TODO - add a parameter to allow callers to specify reason */
+        shutdown_requested = SHUTDOWN_CAUSE_HOST_ERROR;
     } else {
-        reset_requested = 1;
+        reset_requested = SHUTDOWN_CAUSE_HOST_ERROR;
     }
     cpu_stop_current();
     qemu_notify_event();
@@ -1807,7 +1814,7 @@ void qemu_system_killed(int signal, pid_t pid)
     /* Cannot call qemu_system_shutdown_request directly because
      * we are in a signal handler.
      */
-    shutdown_requested = 1;
+    shutdown_requested = SHUTDOWN_CAUSE_HOST_SIGNAL;
     qemu_notify_event();
 }

@@ -1815,7 +1822,8 @@ void qemu_system_shutdown_request(void)
 {
     trace_qemu_system_shutdown_request();
     replay_shutdown_request();
-    shutdown_requested = 1;
+    /* TODO - add a parameter to allow callers to specify reason */
+    shutdown_requested = SHUTDOWN_CAUSE_HOST_ERROR;
     qemu_notify_event();
 }

@@ -1846,14 +1854,18 @@ void qemu_system_debug_request(void)
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
+        /* TODO update event based on request */
         qapi_event_send_shutdown(&error_abort);
         if (no_shutdown) {
             vm_stop(RUN_STATE_SHUTDOWN);
@@ -1861,9 +1873,10 @@ static bool main_loop_should_exit(void)
             return true;
         }
     }
-    if (qemu_reset_requested()) {
+    request = qemu_reset_requested();
+    if (request) {
         pause_all_vcpus();
-        qemu_system_reset(VMRESET_REPORT);
+        qemu_system_reset(request);
         resume_all_vcpus();
         if (!runstate_check(RUN_STATE_RUNNING) &&
                 !runstate_check(RUN_STATE_INMIGRATE)) {
@@ -1872,7 +1885,7 @@ static bool main_loop_should_exit(void)
     }
     if (qemu_wakeup_requested()) {
         pause_all_vcpus();
-        qemu_system_reset(VMRESET_SILENT);
+        qemu_system_reset(SHUTDOWN_CAUSE_NONE);
         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
         resume_all_vcpus();
@@ -4682,7 +4695,7 @@ int main(int argc, char **argv, char **envp)
        reading from the other reads, because timer polling functions query
        clock values from the log. */
     replay_checkpoint(CHECKPOINT_RESET);
-    qemu_system_reset(VMRESET_SILENT);
+    qemu_system_reset(SHUTDOWN_CAUSE_NONE);
     register_global_state();
     if (replay_mode != REPLAY_MODE_NONE) {
         replay_vmstate_init();
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index b1c05ff..222d89a 100644
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
+                qemu_system_reset(request);
                 destroy_hvm_domain(true);
             }
         }
diff --git a/migration/colo.c b/migration/colo.c
index 963c802..12d355a 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -623,7 +623,7 @@ void *colo_process_incoming_thread(void *opaque)
         }

         qemu_mutex_lock_iothread();
-        qemu_system_reset(VMRESET_SILENT);
+        qemu_system_reset(SHUTDOWN_CAUSE_NONE);
         vmstate_loading = true;
         if (qemu_loadvm_state(fb) < 0) {
             error_report("COLO: loadvm failed");
diff --git a/migration/savevm.c b/migration/savevm.c
index 7f66d58..b89dede 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2286,7 +2286,7 @@ int load_vmstate(const char *name)
         return -EINVAL;
     }

-    qemu_system_reset(VMRESET_SILENT);
+    qemu_system_reset(SHUTDOWN_CAUSE_NONE);
     mis->from_src_file = f;

     aio_context_acquire(aio_context);
-- 
2.9.4
