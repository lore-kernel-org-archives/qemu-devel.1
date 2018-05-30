Received: from eggs.gnu.org ([2001:4830:134:3::10]:46213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAA8-0004g0-Kn
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAA6-00007H-Re
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOAA6-00006R-II
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:46 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 30 May 2018 20:05:24 -0300
Message-Id: <20180530230528.30166-9-ehabkost@redhat.com>
In-Reply-To: <20180530230528.30166-1-ehabkost@redhat.com>
References: <20180530230528.30166-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 08/12] cli: add --preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

This option allows pausing QEMU in the new RUN_STATE_PRECONFIG state,
allowing the configuration of QEMU from QMP before the machine jumps
into board initialization code of machine_run_board_init()

The intent is to allow management to query machine state and additionally
configure it using previous query results within one QEMU instance
(i.e. eliminate the need to start QEMU twice, 1st to query board specific
parameters and 2nd for actual VM start using query results for
additional parameters).

The new option complements -S option and could be used with or without
it. The difference is that -S pauses QEMU when the machine is completely
initialized with all devices wired up and ready to execute guest code
(QEMU needs only to unpause VCPUs to let guest execute its code),
while the "preconfig" option pauses QEMU early before board specific init
callback (machine_run_board_init) is executed and allows the configuration
of machine parameters which will be used by board init code.

When early introspection/configuration is done, command 'exit-preconfig'
should be used to exit RUN_STATE_PRECONFIG and transition to the next
requested state (i.e. if -S is used then QEMU will pause the second
time when board/device initialization is completed or start guest
execution if -S isn't provided on CLI)

PS:
Initially 'preconfig' is planned to be used for configuring numa
topology depending on board specified possible cpus layout.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1526059483-42847-1-git-send-email-imammedo@redhat.com>
[ehabkost: Changed "since 2.13" to "since 3.0"]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/misc.json          | 23 +++++++++++++++++++++++
 include/sysemu/sysemu.h |  1 +
 qapi/qmp-dispatch.c     |  8 ++++++++
 qmp.c                   | 10 ++++++++++
 vl.c                    | 35 ++++++++++++++++++++++++++++++++++-
 qemu-options.hx         | 13 +++++++++++++
 qemu-tech.texi          | 40 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index ae2bb27b83..bd6d1805ab 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1244,6 +1244,29 @@
 ##
 { 'command': 'cont' }
 
+##
+# @exit-preconfig:
+#
+# Exit from "preconfig" state
+#
+# This command makes QEMU exit the preconfig state and proceed with
+# VM initialization using configuration data provided on the command line
+# and via the QMP monitor during the preconfig state. The command is only
+# available during the preconfig state (i.e. when the --preconfig command
+# line option was in use).
+#
+# Since 3.0
+#
+# Returns: nothing
+#
+# Example:
+#
+# -> { "execute": "exit-preconfig" }
+# <- { "return": {} }
+#
+##
+{ 'command': 'exit-preconfig', 'allow-preconfig': true }
+
 ##
 # @system_wakeup:
 #
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 544ab77a2b..e893f72f3b 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -66,6 +66,7 @@ typedef enum WakeupReason {
     QEMU_WAKEUP_REASON_OTHER,
 } WakeupReason;
 
+void qemu_exit_preconfig_request(void);
 void qemu_system_reset_request(ShutdownCause reason);
 void qemu_system_suspend_request(void);
 void qemu_register_suspend_notifier(Notifier *notifier);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index f9377b27fd..935f9e159c 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -18,6 +18,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
+#include "sysemu/sysemu.h"
 
 QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 {
@@ -101,6 +102,13 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
         return NULL;
     }
 
+    if (runstate_check(RUN_STATE_PRECONFIG) &&
+        !(cmd->options & QCO_ALLOW_PRECONFIG)) {
+        error_setg(errp, "The command '%s' isn't permitted in '%s' state",
+                   cmd->name, RunState_str(RUN_STATE_PRECONFIG));
+        return NULL;
+    }
+
     if (!qdict_haskey(dict, "arguments")) {
         args = qdict_new();
     } else {
diff --git a/qmp.c b/qmp.c
index 25fdc9a5b2..73e46d795f 100644
--- a/qmp.c
+++ b/qmp.c
@@ -161,6 +161,16 @@ SpiceInfo *qmp_query_spice(Error **errp)
 };
 #endif
 
+void qmp_exit_preconfig(Error **errp)
+{
+    if (!runstate_check(RUN_STATE_PRECONFIG)) {
+        error_setg(errp, "The command is permitted only in '%s' state",
+                   RunState_str(RUN_STATE_PRECONFIG));
+        return;
+    }
+    qemu_exit_preconfig_request();
+}
+
 void qmp_cont(Error **errp)
 {
     BlockBackend *blk;
diff --git a/vl.c b/vl.c
index 038d7f8042..c4fe25560c 100644
--- a/vl.c
+++ b/vl.c
@@ -594,7 +594,7 @@ static int default_driver_check(void *opaque, QemuOpts *opts, Error **errp)
 /***********************************************************/
 /* QEMU state */
 
-static RunState current_run_state = RUN_STATE_PRELAUNCH;
+static RunState current_run_state = RUN_STATE_PRECONFIG;
 
 /* We use RUN_STATE__MAX but any invalid value will do */
 static RunState vmstop_requested = RUN_STATE__MAX;
@@ -607,6 +607,13 @@ typedef struct {
 
 static const RunStateTransition runstate_transitions_def[] = {
     /*     from      ->     to      */
+    { RUN_STATE_PRECONFIG, RUN_STATE_PRELAUNCH },
+      /* Early switch to inmigrate state to allow  -incoming CLI option work
+       * as it used to. TODO: delay actual switching to inmigrate state to
+       * the point after machine is built and remove this hack.
+       */
+    { RUN_STATE_PRECONFIG, RUN_STATE_INMIGRATE },
+
     { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
     { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_DEBUG, RUN_STATE_PRELAUNCH },
@@ -1630,6 +1637,7 @@ static pid_t shutdown_pid;
 static int powerdown_requested;
 static int debug_requested;
 static int suspend_requested;
+static bool preconfig_exit_requested = true;
 static WakeupReason wakeup_reason;
 static NotifierList powerdown_notifiers =
     NOTIFIER_LIST_INITIALIZER(powerdown_notifiers);
@@ -1714,6 +1722,11 @@ static int qemu_debug_requested(void)
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
@@ -1887,6 +1900,13 @@ static bool main_loop_should_exit(void)
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
@@ -3667,6 +3687,9 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_preconfig:
+                preconfig_exit_requested = false;
+                break;
             case QEMU_OPTION_enable_kvm:
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=kvm", false);
@@ -4031,6 +4054,12 @@ int main(int argc, char **argv, char **envp)
 
     replay_configure(icount_opts);
 
+    if (incoming && !preconfig_exit_requested) {
+        error_report("'preconfig' and 'incoming' options are "
+                     "mutually exclusive");
+        exit(EXIT_FAILURE);
+    }
+
     machine_class = select_machine();
 
     set_memory_options(&ram_slots, &maxram_size, machine_class);
@@ -4548,6 +4577,10 @@ int main(int argc, char **argv, char **envp)
     }
     parse_numa_opts(current_machine);
 
+    /* do monitor/qmp handling at preconfig state if requested */
+    main_loop();
+
+    /* from here on runstate is RUN_STATE_PRELAUNCH */
     machine_run_board_init(current_machine);
 
     realtime_init();
diff --git a/qemu-options.hx b/qemu-options.hx
index abbfa6ae9e..2f61ea42ee 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3299,6 +3299,19 @@ STEXI
 Run the emulation in single step mode.
 ETEXI
 
+DEF("preconfig", 0, QEMU_OPTION_preconfig, \
+    "--preconfig     pause QEMU before machine is initialized\n",
+    QEMU_ARCH_ALL)
+STEXI
+@item --preconfig
+@findex --preconfig
+Pause QEMU for interactive configuration before the machine is created,
+which allows querying and configuring properties that will affect
+machine initialization. Use the QMP command 'exit-preconfig' to exit
+the preconfig state and move to the next state (ie. run guest if -S
+isn't used or pause the second time if -S is used).
+ETEXI
+
 DEF("S", 0, QEMU_OPTION_S, \
     "-S              freeze CPU at startup (use 'c' to start execution)\n",
     QEMU_ARCH_ALL)
diff --git a/qemu-tech.texi b/qemu-tech.texi
index 52a56ae25e..dcecba83cb 100644
--- a/qemu-tech.texi
+++ b/qemu-tech.texi
@@ -5,6 +5,7 @@
 * CPU emulation::
 * Translator Internals::
 * QEMU compared to other emulators::
+* Managed start up options::
 * Bibliography::
 @end menu
 
@@ -314,6 +315,45 @@ VirtualBox [9], Xen [10] and KVM [11] are based on QEMU. QEMU-SystemC
 [12] uses QEMU to simulate a system where some hardware devices are
 developed in SystemC.
 
+@node Managed start up options
+@section Managed start up options
+
+In system mode emulation, it's possible to create a VM in a paused state using
+the -S command line option. In this state the machine is completely initialized
+according to command line options and ready to execute VM code but VCPU threads
+are not executing any code. The VM state in this paused state depends on the way
+QEMU was started. It could be in:
+@table @asis
+@item initial state (after reset/power on state)
+@item with direct kernel loading, the initial state could be amended to execute
+code loaded by QEMU in the VM's RAM and with incoming migration
+@item with incoming migration, initial state will by amended with the migrated
+machine state after migration completes.
+@end table
+
+This paused state is typically used by users to query machine state and/or
+additionally configure the machine (by hotplugging devices) in runtime before
+allowing VM code to run.
+
+However, at the -S pause point, it's impossible to configure options that affect
+initial VM creation (like: -smp/-m/-numa ...) or cold plug devices. That's
+when the --preconfig command line option should be used. It allows pausing QEMU
+before the initial VM creation, in a new preconfig state, where additional
+queries and configuration can be performed via QMP before moving on to
+the resulting configuration startup. In the preconfig state, QEMU only allows
+a limited set of commands over the QMP monitor, where the commands do not
+depend on an initialized machine, including but not limited to:
+@table @asis
+@item qmp_capabilities
+@item query-qmp-schema
+@item query-commands
+@item query-status
+@item exit-preconfig
+@end table
+The full list of commands is in QMP schema which could be queried with
+query-qmp-schema, where commands supported at preconfig state have option
+'allow-preconfig' set to true.
+
 @node Bibliography
 @section Bibliography
 
-- 
2.17.1
