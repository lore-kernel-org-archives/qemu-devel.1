Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19756C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D812620665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D812620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42111 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn6QF-0000vU-SD
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 15:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40409)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hn6Pr-0007nQ-6u
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hn6Pn-00045V-G2
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hn6Pn-00044M-7q
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:13:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D2A6C036744;
 Mon, 15 Jul 2019 19:13:33 +0000 (UTC)
Received: from localhost (ovpn-112-18.ams2.redhat.com [10.36.112.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00D865D96F;
 Mon, 15 Jul 2019 19:13:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 23:10:00 +0400
Message-Id: <20190715191001.1188-20-marcandre.lureau@redhat.com>
In-Reply-To: <20190715191001.1188-1-marcandre.lureau@redhat.com>
References: <20190715191001.1188-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 15 Jul 2019 19:13:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 19/20] monitor: teach HMP about asynchronous
 commands
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to how we handle both synchronous and asynchronous commands in
QMP, HMP gains a new async_cmd() that will allow the command to
complete asynchronously. For interactive reasons, and command
ordering, the HMP monitor is suspended until the asynchronous command
completes.

It is expected that HMP async commands will be implemented re-using
QMP async commands counterparts, so it reuses the QmpSession/QmpReturn
for context handling (instead of introducing HmpSession/HmpReturn and
having to convert from one to the other as we call QMP counterparts).

hmp_dispatch_return_cb() will handle printing the result to the
current monitor. It may have different ways to print the QmpReturn
result to the current monitor. Currently, only error reporting is
implemented.

QMP human-monitor-command is modified to deal with an async HMP
commands too. It creates a temporary session, and the return callback
will return asynchronously to the original QMP command and destroy the
temporary monitor when hmp->for_qmp_command is set.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/monitor.h  |   2 +-
 monitor/hmp.c              | 110 +++++++++++++++++++++++++++++++++++--
 monitor/misc.c             |  40 --------------
 monitor/monitor-internal.h |   9 ++-
 monitor/qmp.c              |  14 +++--
 5 files changed, 123 insertions(+), 52 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 6a2907a366..5968b52fe2 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -44,6 +44,6 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_=
fd);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 int64_t monitor_fdset_dup_fd_find(int dup_fd);
=20
-Monitor *qmp_return_get_monitor(QmpReturn *qret);
+Monitor *qmp_return_get_monitor(QmpReturn *qret, bool hmp);
=20
 #endif /* MONITOR_H */
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 5223661e82..b2b6dce8fb 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -26,11 +26,15 @@
 #include <dirent.h>
 #include "monitor-internal.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
+#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
@@ -38,6 +42,8 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
=20
+static bool handle_hmp_command(MonitorHMP *mon, const char *cmdline);
+
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque)
 {
@@ -1056,7 +1062,7 @@ fail:
     return NULL;
 }
=20
-void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
+static bool handle_hmp_command(MonitorHMP *mon, const char *cmdline)
 {
     QDict *qdict;
     const HMPCommand *cmd;
@@ -1066,7 +1072,7 @@ void handle_hmp_command(MonitorHMP *mon, const char=
 *cmdline)
=20
     cmd =3D monitor_parse_command(mon, cmdline, &cmdline, hmp_cmds);
     if (!cmd) {
-        return;
+        return false;
     }
=20
     qdict =3D monitor_parse_arguments(&mon->common, &cmdline, cmd);
@@ -1076,11 +1082,19 @@ void handle_hmp_command(MonitorHMP *mon, const ch=
ar *cmdline)
         }
         monitor_printf(&mon->common, "Try \"help %.*s\" for more informa=
tion\n",
                        (int)(cmdline - cmd_start), cmd_start);
-        return;
+        return false;
     }
=20
-    cmd->cmd(&mon->common, qdict);
+    if (cmd->async) {
+        QmpReturn *qret =3D qmp_return_new(&mon->qmp_session, NULL);
+        monitor_suspend(&mon->common);
+        cmd->async_cmd(&mon->common, qdict, qret);
+    } else {
+        cmd->cmd(&mon->common, qdict);
+    }
     qobject_unref(qdict);
+
+    return cmd->async;
 }
=20
 static void cmd_completion(MonitorHMP *mon, const char *name, const char=
 *list)
@@ -1395,6 +1409,59 @@ static void monitor_readline_flush(void *opaque)
     monitor_flush(&mon->common);
 }
=20
+static void free_hmp_monitor(void *opaque)
+{
+    MonitorHMP *hmp =3D opaque;
+
+    qmp_session_destroy(&hmp->qmp_session);
+    monitor_data_destroy(&hmp->common);
+    g_free(hmp);
+}
+
+static AioContext *monitor_get_aio_context(void)
+{
+    return iothread_get_aio_context(mon_iothread);
+}
+
+static void qmp_human_monitor_command_finish(MonitorHMP *hmp, QmpReturn =
*qret)
+{
+    char *output;
+
+    qemu_mutex_lock(&hmp->common.mon_lock);
+    if (qstring_get_length(hmp->common.outbuf) > 0) {
+        output =3D g_strdup(qstring_get_str(hmp->common.outbuf));
+    } else {
+        output =3D g_strdup("");
+    }
+    qemu_mutex_unlock(&hmp->common.mon_lock);
+
+    qmp_human_monitor_command_return(qret, output);
+
+    if (hmp->for_qmp_command) {
+        aio_bh_schedule_oneshot(monitor_get_aio_context(),
+                                free_hmp_monitor, hmp);
+    }
+}
+
+static void hmp_dispatch_return_cb(QmpSession *session, QDict *rsp)
+{
+    MonitorHMP *hmp =3D container_of(session, MonitorHMP, qmp_session);
+    QDict *err =3D qdict_get_qdict(rsp, "error");
+    Monitor *old_mon =3D cur_mon;
+
+    cur_mon =3D &hmp->common;
+    if (err) {
+        error_report("%s", qdict_get_str(err, "desc"));
+    } /* XXX: else, report depending on command */
+
+    if (hmp->for_qmp_command) {
+        qmp_human_monitor_command_finish(hmp, hmp->for_qmp_command);
+    } else {
+        monitor_resume(&hmp->common);
+    }
+    cur_mon =3D old_mon;
+}
+
 void monitor_init_hmp(Chardev *chr, bool use_readline)
 {
     MonitorHMP *mon =3D g_new0(MonitorHMP, 1);
@@ -1411,7 +1478,42 @@ void monitor_init_hmp(Chardev *chr, bool use_readl=
ine)
         monitor_read_command(mon, 0);
     }
=20
+    qmp_session_init(&mon->qmp_session,
+                     NULL, NULL, hmp_dispatch_return_cb);
     qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read, monitor=
_read,
                              monitor_event, NULL, &mon->common, NULL, tr=
ue);
     monitor_list_append(&mon->common);
 }
+
+void qmp_human_monitor_command(const char *command_line, bool has_cpu_in=
dex,
+                               int64_t cpu_index, QmpReturn *qret)
+{
+    Monitor *old_mon;
+    MonitorHMP *hmp =3D g_new0(MonitorHMP, 1);
+
+    monitor_data_init(&hmp->common, false, true, false);
+    qmp_session_init(&hmp->qmp_session, NULL, NULL, hmp_dispatch_return_=
cb);
+    hmp->for_qmp_command =3D qret;
+
+    old_mon =3D cur_mon;
+    cur_mon =3D &hmp->common;
+
+    if (has_cpu_index) {
+        int ret =3D monitor_set_cpu(cpu_index);
+        if (ret < 0) {
+            Error *err =3D NULL;
+            error_setg(&err, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
+                       "a CPU number");
+            qmp_return_error(qret, err);
+            free_hmp_monitor(hmp);
+            goto out;
+        }
+    }
+
+    if (!handle_hmp_command(hmp, command_line)) {
+        qmp_human_monitor_command_finish(hmp, qret);
+    }
+
+out:
+    cur_mon =3D old_mon;
+}
diff --git a/monitor/misc.c b/monitor/misc.c
index 0645667e1b..19a2919154 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -115,46 +115,6 @@ static QLIST_HEAD(, MonFdset) mon_fdsets;
=20
 static HMPCommand hmp_info_cmds[];
=20
-void qmp_human_monitor_command(const char *command_line, bool has_cpu_in=
dex,
-                               int64_t cpu_index, QmpReturn *qret)
-{
-    char *output =3D NULL;
-    Monitor *old_mon;
-    MonitorHMP hmp =3D {};
-
-    monitor_data_init(&hmp.common, false, true, false);
-
-    old_mon =3D cur_mon;
-    cur_mon =3D &hmp.common;
-
-    if (has_cpu_index) {
-        int ret =3D monitor_set_cpu(cpu_index);
-        if (ret < 0) {
-            Error *err =3D NULL;
-            error_setg(&err, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
-                       "a CPU number");
-            qmp_return_error(qret, err);
-            goto out;
-        }
-    }
-
-    handle_hmp_command(&hmp, command_line);
-
-    qemu_mutex_lock(&hmp.common.mon_lock);
-    if (qstring_get_length(hmp.common.outbuf) > 0) {
-        output =3D g_strdup(qstring_get_str(hmp.common.outbuf));
-    } else {
-        output =3D g_strdup("");
-    }
-    qemu_mutex_unlock(&hmp.common.mon_lock);
-
-    qmp_human_monitor_command_return(qret, output);
-
-out:
-    cur_mon =3D old_mon;
-    monitor_data_destroy(&hmp.common);
-}
-
 /**
  * Is @name in the '|' separated list of names @list?
  */
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 65cf668b20..cab2712187 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -73,7 +73,10 @@ typedef struct HMPCommand {
     const char *params;
     const char *help;
     const char *flags; /* p=3Dpreconfig */
-    void (*cmd)(Monitor *mon, const QDict *qdict);
+    union {
+        void (*cmd)(Monitor *mon, const QDict *qdict);
+        void (*async_cmd)(Monitor *mon, const QDict *qdict, QmpReturn *q=
ret);
+    };
     /*
      * @sub_table is a list of 2nd level of commands. If it does not exi=
st,
      * cmd should be used. If it exists, sub_table[?].cmd should be
@@ -81,6 +84,7 @@ typedef struct HMPCommand {
      */
     struct HMPCommand *sub_table;
     void (*command_completion)(ReadLineState *rs, int nb_args, const cha=
r *str);
+    bool async;
 } HMPCommand;
=20
 struct Monitor {
@@ -121,6 +125,8 @@ struct MonitorHMP {
      * These members can be safely accessed without locks.
      */
     ReadLineState *rs;
+    QmpReturn *for_qmp_command;
+    QmpSession qmp_session;
 };
=20
 typedef struct {
@@ -176,7 +182,6 @@ void monitor_qmp_bh_dispatcher(void *data);
=20
 int get_monitor_def(int64_t *pval, const char *name);
 void help_cmd(Monitor *mon, const char *name);
-void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
=20
 #endif
diff --git a/monitor/qmp.c b/monitor/qmp.c
index df8b9d8d4f..cadaf77515 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -391,13 +391,17 @@ void monitor_init_qmp(Chardev *chr, bool pretty)
     }
 }
=20
-Monitor *qmp_return_get_monitor(QmpReturn *qret)
+Monitor *qmp_return_get_monitor(QmpReturn *qret, bool hmp)
 {
-    MonitorQMP *mon;
-
     if (!qret->session) {
         return NULL;
     }
-    mon =3D container_of(qret->session, MonitorQMP, session);
-    return &mon->common;
+
+    if (hmp) {
+        MonitorHMP *hmp =3D container_of(qret->session, MonitorHMP, qmp_=
session);
+        return &hmp->common;
+    } else {
+        MonitorQMP *qmp =3D container_of(qret->session, MonitorQMP, sess=
ion);
+        return &qmp->common;
+    }
 }
--=20
2.22.0.428.g6d5b264208


