Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4D2C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20F82084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20F82084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtcK-0001Fs-VY
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:29:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLq-0003aU-5u
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLo-0005FX-QE
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLo-0005Ew-FB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B27CE2CD7F1;
	Tue,  9 Apr 2019 16:11:55 +0000 (UTC)
Received: from localhost (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 490F75C223;
	Tue,  9 Apr 2019 16:11:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:10:08 +0200
Message-Id: <20190409161009.6322-20-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Tue, 09 Apr 2019 16:11:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 19/20] monitor: teach HMP about asynchronous
 commands
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
	Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409161008.Pb1rtpJ4Hvl6k4TZ7KQ5H7qlHfrLOGuaCaE5Ff74wnk@z>

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
 monitor.c | 103 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 82 insertions(+), 21 deletions(-)

diff --git a/monitor.c b/monitor.c
index 477ccd852d..4943c7635c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -130,13 +130,17 @@ typedef struct mon_cmd_t {
     const char *params;
     const char *help;
     const char *flags; /* p=3Dpreconfig */
-    void (*cmd)(Monitor *mon, const QDict *qdict);
+    union {
+        void (*cmd)(Monitor *mon, const QDict *qdict);
+        void (*async_cmd)(Monitor *mon, const QDict *qdict, QmpReturn *q=
ret);
+    };
     /* @sub_table is a list of 2nd level of commands. If it does not exi=
st,
      * cmd should be used. If it exists, sub_table[?].cmd should be
      * used, and cmd of 1st level plays the role of help function.
      */
     struct mon_cmd_t *sub_table;
     void (*command_completion)(ReadLineState *rs, int nb_args, const cha=
r *str);
+    bool async;
 } mon_cmd_t;
=20
 /* file descriptors passed via SCM_RIGHTS */
@@ -207,6 +211,7 @@ struct Monitor {
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool skip_flush;
     bool use_io_thread;
+    QmpReturn *for_qmp_command;
=20
     /*
      * State used only in the thread "owning" the monitor.
@@ -707,7 +712,7 @@ static void monitor_qapi_event_init(void)
                                                 qapi_event_throttle_equa=
l);
 }
=20
-static void handle_hmp_command(Monitor *mon, const char *cmdline);
+static bool handle_hmp_command(Monitor *mon, const char *cmdline);
=20
 static void monitor_iothread_init(void);
=20
@@ -743,16 +748,70 @@ static void monitor_data_destroy(Monitor *mon)
     g_queue_free(mon->qmp.qmp_requests);
 }
=20
+static void free_hmp_monitor(void *opaque)
+{
+    Monitor *hmp =3D opaque;
+
+    qmp_session_destroy(&hmp->qmp.session);
+    monitor_data_destroy(hmp);
+    g_free(hmp);
+}
+
+static AioContext *monitor_get_aio_context(void)
+{
+    return iothread_get_aio_context(mon_iothread);
+}
+
+static void qmp_human_monitor_command_finish(Monitor *hmp, QmpReturn *qr=
et)
+{
+    char *output;
+
+    qemu_mutex_lock(&hmp->mon_lock);
+    if (qstring_get_length(hmp->outbuf) > 0) {
+        output =3D g_strdup(qstring_get_str(hmp->outbuf));
+    } else {
+        output =3D g_strdup("");
+    }
+    qemu_mutex_unlock(&hmp->mon_lock);
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
+    Monitor *hmp =3D container_of(session, Monitor, qmp.session);
+    QDict *err =3D qdict_get_qdict(rsp, "error");
+    Monitor *old_mon =3D cur_mon;
+
+    cur_mon =3D hmp;
+    if (err) {
+        error_report("%s", qdict_get_str(err, "desc"));
+    } /* XXX: else, report depending on command */
+
+    if (hmp->for_qmp_command) {
+        qmp_human_monitor_command_finish(hmp, hmp->for_qmp_command);
+    } else {
+        monitor_resume(hmp);
+    }
+    cur_mon =3D old_mon;
+}
+
 void qmp_human_monitor_command(const char *command_line, bool has_cpu_in=
dex,
                                int64_t cpu_index, QmpReturn *qret)
 {
-    char *output =3D NULL;
-    Monitor *old_mon, hmp;
+    Monitor *old_mon, *hmp =3D g_new0(Monitor, 1);
=20
-    monitor_data_init(&hmp, true, false);
+    monitor_data_init(hmp, true, false);
+    qmp_session_init(&hmp->qmp.session, NULL, NULL, hmp_dispatch_return_=
cb);
+    hmp->for_qmp_command =3D qret;
=20
     old_mon =3D cur_mon;
-    cur_mon =3D &hmp;
+    cur_mon =3D hmp;
=20
     if (has_cpu_index) {
         int ret =3D monitor_set_cpu(cpu_index);
@@ -761,25 +820,17 @@ void qmp_human_monitor_command(const char *command_=
line, bool has_cpu_index,
             error_setg(&err, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
                        "a CPU number");
             qmp_return_error(qret, err);
+            monitor_data_destroy(hmp);
             goto out;
         }
     }
=20
-    handle_hmp_command(&hmp, command_line);
-
-    qemu_mutex_lock(&hmp.mon_lock);
-    if (qstring_get_length(hmp.outbuf) > 0) {
-        output =3D g_strdup(qstring_get_str(hmp.outbuf));
-    } else {
-        output =3D g_strdup("");
+    if (!handle_hmp_command(hmp, command_line)) {
+        qmp_human_monitor_command_finish(hmp, qret);
     }
-    qemu_mutex_unlock(&hmp.mon_lock);
-
-    qmp_human_monitor_command_return(qret, output);
=20
 out:
     cur_mon =3D old_mon;
-    monitor_data_destroy(&hmp);
 }
=20
 static int compare_cmd(const char *name, const char *list)
@@ -3438,7 +3489,7 @@ fail:
     return NULL;
 }
=20
-static void handle_hmp_command(Monitor *mon, const char *cmdline)
+static bool handle_hmp_command(Monitor *mon, const char *cmdline)
 {
     QDict *qdict;
     const mon_cmd_t *cmd;
@@ -3448,7 +3499,7 @@ static void handle_hmp_command(Monitor *mon, const =
char *cmdline)
=20
     cmd =3D monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table=
);
     if (!cmd) {
-        return;
+        return false;
     }
=20
     qdict =3D monitor_parse_arguments(mon, &cmdline, cmd);
@@ -3458,11 +3509,19 @@ static void handle_hmp_command(Monitor *mon, cons=
t char *cmdline)
         }
         monitor_printf(mon, "Try \"help %.*s\" for more information\n",
                        (int)(cmdline - cmd_start), cmd_start);
-        return;
+        return false;
     }
=20
-    cmd->cmd(mon, qdict);
+    if (cmd->async) {
+        QmpReturn *qret =3D qmp_return_new(&mon->qmp.session, NULL);
+        monitor_suspend(mon);
+        cmd->async_cmd(mon, qdict, qret);
+    } else {
+        cmd->cmd(mon, qdict);
+    }
     qobject_unref(qdict);
+
+    return cmd->async;
 }
=20
 static void cmd_completion(Monitor *mon, const char *name, const char *l=
ist)
@@ -4638,6 +4697,8 @@ void monitor_init(Chardev *chr, int flags)
                                      NULL, mon, NULL, true);
         }
     } else {
+        qmp_session_init(&mon->qmp.session,
+                         NULL, NULL, hmp_dispatch_return_cb);
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_re=
ad,
                                  monitor_event, NULL, mon, NULL, true);
     }
--=20
2.21.0.196.g041f5ea1cf


