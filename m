Received: from eggs.gnu.org ([2001:4830:134:3::10]:59135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f40qp-0000oc-0Z
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f40qk-0006WX-1x
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51480 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f40qj-0006VZ-SN
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1B014023112
	for <qemu-devel@nongnu.org>; Thu,  5 Apr 2018 09:06:25 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Apr 2018 11:05:05 +0200
Message-Id: <1522919113-158775-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1522919113-158775-1-git-send-email-imammedo@redhat.com>
References: <1522919113-158775-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 v5 03/11] cli: add --preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com

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
built with all devices wired up and ready to run (QEMU needs only to
unpause CPUs to let guest execute its code), while the "preconfig"
option pauses QEMU early before board specific init callback
(machine_run_board_init) is executed and will allow the configuration
of machine parameters which will be used by board init code.

When early introspection/configuration is done, command 'cont' should
be used to exit RUN_STATE_PRECONFIG and transition to the next
requested state (i.e. if -S is used then QEMU will pause the second
time when board/device initialization is completed or start guest
execution if -S isn't provided on CLI)

PS:
Initially 'preconfig' is planned to be used for configuring numa
topology depending on board specified possible cpus layout.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v4:
  * Explain more on behaviour in commit message and use suggested
    wording in message and patch (Eric Blake <eblake@redhat.com>)
v5:
  - (Eric Blake <eblake@redhat.com>)
    * more spelling/wording fixes
    * s/-preconfig/--preconfig/
    * s/2.12/2.13/
  - (Eduardo Habkost <ehabkost@redhat.com>)
    * move QCO_ALLOWED_IN_PRECONFIG and do_qmp_dispatch() runstate check
      from the later patch 'qapi: introduce new cmd option  "allowed-in-preconfig"'
      to here for better bissectability
    * add TODO comment to '{ RUN_STATE_PRECONFIG, RUN_STATE_INMIGRATE }' transition
    * check for incoming && preconfig outside of option parsing loop
---
 include/qapi/qmp/dispatch.h |  1 +
 include/sysemu/sysemu.h     |  1 +
 qapi/qmp-dispatch.c         |  8 ++++++++
 qapi/run-state.json         |  5 ++++-
 qemu-options.hx             | 13 +++++++++++++
 qmp.c                       |  5 +++++
 vl.c                        | 35 ++++++++++++++++++++++++++++++++++-
 7 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index ffb4652..6242cfc 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -23,6 +23,7 @@ typedef enum QmpCommandOptions
     QCO_NO_OPTIONS            =  0x0,
     QCO_NO_SUCCESS_RESP       =  (1U << 0),
     QCO_ALLOW_OOB             =  (1U << 1),
+    QCO_ALLOWED_IN_PRECONFIG  =  (1U << 2),
 } QmpCommandOptions;
 
 typedef struct QmpCommand
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 2b42151..5085978 100644
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
index dd05907..2604115 100644
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
+        !(cmd->options & QCO_ALLOWED_IN_PRECONFIG)) {
+        error_setg(errp, "The command '%s' isn't permitted in '%s' state",
+                   cmd->name, RunState_str(RUN_STATE_PRECONFIG));
+        return NULL;
+    }
+
     if (!qdict_haskey(dict, "arguments")) {
         args = qdict_new();
     } else {
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 1c9fff3..9694a9f 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -49,12 +49,15 @@
 # @colo: guest is paused to save/restore VM state under colo checkpoint,
 #        VM can not get into this state unless colo capability is enabled
 #        for migration. (since 2.8)
+# @preconfig: QEMU is paused before board specific init callback is executed.
+#             The state is reachable only if the --preconfig CLI option is used.
+#             (Since 2.13)
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
index 3ece30d..f8818ee 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3304,6 +3304,19 @@ STEXI
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
+machine initialization. Use the QMP command 'cont' to exit the preconfig
+state and move to the next state (ie. run guest if -S isn't used or
+pause the second time if -S is used).
+ETEXI
+
 DEF("S", 0, QEMU_OPTION_S, \
     "-S              freeze CPU at startup (use 'c' to start execution)\n",
     QEMU_ARCH_ALL)
diff --git a/qmp.c b/qmp.c
index f722616..cd1b62f 100644
--- a/qmp.c
+++ b/qmp.c
@@ -166,6 +166,11 @@ void qmp_cont(Error **errp)
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
index fce1fd1..0d56908 100644
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
@@ -3704,6 +3724,9 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_preconfig:
+                preconfig_exit_requested = false;
+                break;
             case QEMU_OPTION_enable_kvm:
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=kvm", false);
@@ -4073,6 +4096,12 @@ int main(int argc, char **argv, char **envp)
 
     replay_configure(icount_opts);
 
+    if (incoming && !preconfig_exit_requested) {
+        error_report("'preconfig' and 'incoming' options are "
+                     "mutually exclusive");
+        exit(EXIT_FAILURE);
+    }
+
     machine_class = select_machine();
 
     set_memory_options(&ram_slots, &maxram_size, machine_class);
@@ -4604,6 +4633,10 @@ int main(int argc, char **argv, char **envp)
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
