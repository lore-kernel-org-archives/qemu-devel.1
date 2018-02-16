Received: from eggs.gnu.org ([2001:4830:134:3::10]:44334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emfHz-0004KX-WC
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emfHy-0003Z7-In
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:38:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1emfHy-0003Yy-Dn
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:38:54 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 16 Feb 2018 13:37:15 +0100
Message-Id: <1518784641-43151-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/9] CLI: add -preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

Option allows to pause QEMU at new RUN_STATE_PRECONFIG time,
which would allow to configure QEMU from QMP before machine
jumps into board initialization code machine_run_board_init().

Intent is to allow management to query machine state and
additionally configure it using previous query results
within one QEMU instance (i.e. eliminate need to start QEMU
twice, 1st to query board specific parameters and 2nd for
for actual VM start using query result for additional
parameters).

Initially it's planned to be used for configuring numa
topology depending on cpu layout.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/sysemu/sysemu.h |  1 +
 qapi/run-state.json     |  3 ++-
 qemu-options.hx         | 11 +++++++++++
 qmp.c                   |  5 +++++
 vl.c                    | 35 ++++++++++++++++++++++++++++++++++-
 5 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 77bb3da..99d1aad 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -64,6 +64,7 @@ typedef enum WakeupReason {
     QEMU_WAKEUP_REASON_OTHER,
 } WakeupReason;
 
+void qemu_exit_preconfig_request(void);
 void qemu_system_reset_request(ShutdownCause reason);
 void qemu_system_suspend_request(void);
 void qemu_register_suspend_notifier(Notifier *notifier);
diff --git a/qapi/run-state.json b/qapi/run-state.json
index bca46a8..d24a4e8 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -49,12 +49,13 @@
 # @colo: guest is paused to save/restore VM state under colo checkpoint,
 #        VM can not get into this state unless colo capability is enabled
 #        for migration. (since 2.8)
+# @preconfig: QEMU is paused before machine is created.
 ##
 { 'enum': 'RunState',
   'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
             'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
             'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
-            'guest-panicked', 'colo' ] }
+            'guest-panicked', 'colo', 'preconfig' ] }
 
 ##
 # @StatusInfo:
diff --git a/qemu-options.hx b/qemu-options.hx
index 5050a49..ed0b4b7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3283,6 +3283,17 @@ STEXI
 Run the emulation in single step mode.
 ETEXI
 
+DEF("preconfig", 0, QEMU_OPTION_preconfig, \
+    "-preconfig      pause QEMU before machine is initialized\n",
+    QEMU_ARCH_ALL)
+STEXI
+@item -preconfig
+@findex -preconfig
+Pause QEMU for interactive configuration before machine is created,
+which allows to query and configure properties affecting machine
+initialization. Use QMP command 'cont' to exit paused state.
+ETEXI
+
 DEF("S", 0, QEMU_OPTION_S, \
     "-S              freeze CPU at startup (use 'c' to start execution)\n",
     QEMU_ARCH_ALL)
diff --git a/qmp.c b/qmp.c
index 793f6f3..2c6e147 100644
--- a/qmp.c
+++ b/qmp.c
@@ -164,6 +164,11 @@ void qmp_cont(Error **errp)
     BlockBackend *blk;
     Error *local_err = NULL;
 
+    if (runstate_check(RUN_STATE_PRECONFIG)) {
+        qemu_exit_preconfig_request();
+        return;
+    }
+
     /* if there is a dump in background, we should wait until the dump
      * finished */
     if (dump_in_progress()) {
diff --git a/vl.c b/vl.c
index 7a5554b..7fc133d 100644
--- a/vl.c
+++ b/vl.c
@@ -594,7 +594,7 @@ static int default_driver_check(void *opaque, QemuOpts *opts, Error **errp)
 /***********************************************************/
 /* QEMU state */
 
-static RunState current_run_state = RUN_STATE_PRELAUNCH;
+static RunState current_run_state = RUN_STATE_PRECONFIG;
 
 /* We use RUN_STATE__MAX but any invalid value will do */
 static RunState vmstop_requested = RUN_STATE__MAX;
@@ -607,6 +607,9 @@ typedef struct {
 
 static const RunStateTransition runstate_transitions_def[] = {
     /*     from      ->     to      */
+    { RUN_STATE_PRECONFIG, RUN_STATE_PRELAUNCH },
+    { RUN_STATE_PRECONFIG, RUN_STATE_INMIGRATE },
+
     { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
     { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_DEBUG, RUN_STATE_PRELAUNCH },
@@ -1630,6 +1633,7 @@ static pid_t shutdown_pid;
 static int powerdown_requested;
 static int debug_requested;
 static int suspend_requested;
+static bool preconfig_exit_requested = true;
 static WakeupReason wakeup_reason;
 static NotifierList powerdown_notifiers =
     NOTIFIER_LIST_INITIALIZER(powerdown_notifiers);
@@ -1714,6 +1718,11 @@ static int qemu_debug_requested(void)
     return r;
 }
 
+void qemu_exit_preconfig_request(void)
+{
+    preconfig_exit_requested = true;
+}
+
 /*
  * Reset the VM. Issue an event unless @reason is SHUTDOWN_CAUSE_NONE.
  */
@@ -1880,6 +1889,13 @@ static bool main_loop_should_exit(void)
     RunState r;
     ShutdownCause request;
 
+    if (preconfig_exit_requested) {
+        if (runstate_check(RUN_STATE_PRECONFIG)) {
+            runstate_set(RUN_STATE_PRELAUNCH);
+        }
+        preconfig_exit_requested = false;
+        return true;
+    }
     if (qemu_debug_requested()) {
         vm_stop(RUN_STATE_DEBUG);
     }
@@ -3701,6 +3717,14 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_preconfig:
+                if (runstate_check(RUN_STATE_INMIGRATE)) {
+                    error_report("option can not be used with "
+                                 "-incoming option");
+                    exit(EXIT_FAILURE);
+                }
+                preconfig_exit_requested = false;
+                break;
             case QEMU_OPTION_enable_kvm:
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=kvm", false);
@@ -3908,6 +3932,11 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_incoming:
+                if (!preconfig_exit_requested) {
+                    error_report("option can not be used with "
+                                 "-preconfig option");
+                    exit(EXIT_FAILURE);
+                }
                 if (!incoming) {
                     runstate_set(RUN_STATE_INMIGRATE);
                 }
@@ -4607,6 +4636,10 @@ int main(int argc, char **argv, char **envp)
     }
     parse_numa_opts(current_machine);
 
+    /* do monitor/qmp handling at preconfig state if requested */
+    main_loop();
+
+    /* from here on runstate is RUN_STATE_PRELAUNCH */
     machine_run_board_init(current_machine);
 
     realtime_init();
-- 
2.7.4
