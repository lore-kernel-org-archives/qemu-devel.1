Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0D0C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8673C20724
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkmIc5Od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8673C20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTnr-0001s3-8c
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTby-0004HF-Iq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbp-000336-MN
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603822929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pi/b90EuJXjEqRHRI09EPL9quTSA4phic7NtbYeO/n4=;
 b=XkmIc5OdOVOBh6sYSONY6MWMG5kRAP6E6V5jrXLw8CzNXDChzhuFms4nmNvPtm3kiJtAFy
 AD64COjb3+gX3dbsIZLv3Nwz5xibHkX8D8GPpdiXNugptZf3aMslkA+wqVKMts72A5q2jE
 nM12YsOHptA1DrBxDRk+p+AWEMLU26g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-tdTWqWLUMZa5VDStgpySWg-1; Tue, 27 Oct 2020 14:22:08 -0400
X-MC-Unique: tdTWqWLUMZa5VDStgpySWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F35E81EE7D
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:55 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C0E95B4AD
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/29] remove preconfig state
Date: Tue, 27 Oct 2020 14:21:42 -0400
Message-Id: <20201027182144.3315885-28-pbonzini@redhat.com>
In-Reply-To: <20201027182144.3315885-1-pbonzini@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The preconfig state is only used if -incoming is not specified, which
makes the RunState state machine more tricky than it need be.  However
there is already an equivalent condition which works even with -incoming,
namely qdev_hotplug.  Use it instead of a separate runstate.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine-qmp-cmds.c    |  5 ++---
 include/qapi/qmp/dispatch.h   |  1 +
 monitor/hmp.c                 |  7 ++++---
 monitor/qmp-cmds.c            |  5 ++---
 qapi/qmp-dispatch.c           |  5 +----
 qapi/run-state.json           |  5 +----
 softmmu/qdev-monitor.c        | 12 ++++++++++++
 softmmu/vl.c                  | 13 ++-----------
 stubs/meson.build             |  1 +
 stubs/qmp-command-available.c |  7 +++++++
 10 files changed, 33 insertions(+), 28 deletions(-)
 create mode 100644 stubs/qmp-command-available.c

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 5362c80a18..cb9387c5f5 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -286,9 +286,8 @@ HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
 
 void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
 {
-    if (!runstate_check(RUN_STATE_PRECONFIG)) {
-        error_setg(errp, "The command is permitted only in '%s' state",
-                   RunState_str(RUN_STATE_PRECONFIG));
+    if (qdev_hotplug) {
+         error_setg(errp, "The command is permitted only before the machine has been created");
          return;
     }
 
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index af8d96c570..1486cac3ef 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -48,6 +48,7 @@ void qmp_disable_command(QmpCommandList *cmds, const char *name);
 void qmp_enable_command(QmpCommandList *cmds, const char *name);
 
 bool qmp_command_is_enabled(const QmpCommand *cmd);
+bool qmp_command_available(const QmpCommand *cmd, Error **errp);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QDict *qmp_error_response(Error *err);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index f13ef455e2..0027f1465d 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include <dirent.h>
+#include "hw/qdev-core.h"
 #include "monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
@@ -215,7 +216,7 @@ static bool cmd_can_preconfig(const HMPCommand *cmd)
 
 static bool cmd_available(const HMPCommand *cmd)
 {
-    return !runstate_check(RUN_STATE_PRECONFIG) || cmd_can_preconfig(cmd);
+    return qdev_hotplug || cmd_can_preconfig(cmd);
 }
 
 static void help_cmd_dump_one(Monitor *mon,
@@ -658,8 +659,8 @@ static const HMPCommand *monitor_parse_command(MonitorHMP *hmp_mon,
         return NULL;
     }
     if (!cmd_available(cmd)) {
-        monitor_printf(mon, "Command '%.*s' not available with -preconfig "
-                            "until after exit_preconfig.\n",
+        monitor_printf(mon, "Command '%.*s' not available "
+                            "until machine initialization has completed.\n",
                        (int)(p - cmdp_start), cmdp_start);
         return NULL;
     }
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index a08143b323..7c10b182e4 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -104,9 +104,8 @@ void qmp_system_powerdown(Error **errp)
 
 void qmp_x_exit_preconfig(Error **errp)
 {
-    if (!runstate_check(RUN_STATE_PRECONFIG)) {
-        error_setg(errp, "The command is permitted only in '%s' state",
-                   RunState_str(RUN_STATE_PRECONFIG));
+    if (qdev_hotplug) {
+        error_setg(errp, "The command is permitted only before machine initialization");
         return;
     }
     qemu_exit_preconfig_request();
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 9a2d7dd29a..0a2b20a4e4 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -167,10 +167,7 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
         goto out;
     }
 
-    if (runstate_check(RUN_STATE_PRECONFIG) &&
-        !(cmd->options & QCO_ALLOW_PRECONFIG)) {
-        error_setg(&err, "The command '%s' isn't permitted in '%s' state",
-                   cmd->name, RunState_str(RUN_STATE_PRECONFIG));
+    if (!qmp_command_available(cmd, &err)) {
         goto out;
     }
 
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 964c8ef391..38194b0e44 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -50,15 +50,12 @@
 # @colo: guest is paused to save/restore VM state under colo checkpoint,
 #        VM can not get into this state unless colo capability is enabled
 #        for migration. (since 2.8)
-# @preconfig: QEMU is paused before board specific init callback is executed.
-#             The state is reachable only if the --preconfig CLI option is used.
-#             (Since 3.0)
 ##
 { 'enum': 'RunState',
   'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
             'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
             'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
-            'guest-panicked', 'colo', 'preconfig' ] }
+            'guest-panicked', 'colo' ] }
 
 ##
 # @ShutdownCause:
diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index bcfcbac181..00720eb827 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -25,6 +25,7 @@
 #include "sysemu/arch_init.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
+#include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/config-file.h"
@@ -997,3 +998,14 @@ int qemu_global_option(const char *str)
 
     return 0;
 }
+
+bool qmp_command_available(const QmpCommand *cmd, Error **errp)
+{
+    if (!qdev_hotplug &&
+        !(cmd->options & QCO_ALLOW_PRECONFIG)) {
+        error_setg(errp, "The command '%s' is permitted only after machine initialization has completed",
+                   cmd->name);
+        return false;
+    }
+    return true;
+}
diff --git a/softmmu/vl.c b/softmmu/vl.c
index edabd17dac..68acd24d01 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -574,7 +574,7 @@ static int default_driver_check(void *opaque, QemuOpts *opts, Error **errp)
 /***********************************************************/
 /* QEMU state */
 
-static RunState current_run_state = RUN_STATE_PRECONFIG;
+static RunState current_run_state = RUN_STATE_PRELAUNCH;
 
 /* We use RUN_STATE__MAX but any invalid value will do */
 static RunState vmstop_requested = RUN_STATE__MAX;
@@ -586,13 +586,7 @@ typedef struct {
 } RunStateTransition;
 
 static const RunStateTransition runstate_transitions_def[] = {
-    /*     from      ->     to      */
-    { RUN_STATE_PRECONFIG, RUN_STATE_PRELAUNCH },
-      /* Early switch to inmigrate state to allow  -incoming CLI option work
-       * as it used to. TODO: delay actual switching to inmigrate state to
-       * the point after machine is built and remove this hack.
-       */
-    { RUN_STATE_PRECONFIG, RUN_STATE_INMIGRATE },
+    { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
 
     { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
     { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
@@ -1633,9 +1627,6 @@ static bool main_loop_should_exit(void)
     ShutdownCause request;
 
     if (preconfig_exit_requested) {
-        if (runstate_check(RUN_STATE_PRECONFIG)) {
-            runstate_set(RUN_STATE_PRELAUNCH);
-        }
         preconfig_exit_requested = false;
         return true;
     }
diff --git a/stubs/meson.build b/stubs/meson.build
index 82b7ba60ab..cc56c83063 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -29,6 +29,7 @@ stub_ss.add(files('pci-bus.c'))
 stub_ss.add(files('pci-host-piix.c'))
 stub_ss.add(files('qemu-timer-notify-cb.c'))
 stub_ss.add(files('qmp_memory_device.c'))
+stub_ss.add(files('qmp-command-available.c'))
 stub_ss.add(files('qtest.c'))
 stub_ss.add(files('ram-block.c'))
 stub_ss.add(files('ramfb.c'))
diff --git a/stubs/qmp-command-available.c b/stubs/qmp-command-available.c
new file mode 100644
index 0000000000..46540af7bf
--- /dev/null
+++ b/stubs/qmp-command-available.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "qapi/qmp/dispatch.h"
+
+bool qmp_command_available(const QmpCommand *cmd, Error **errp)
+{
+    return true;
+}
-- 
2.26.2



