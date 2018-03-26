Received: from eggs.gnu.org ([2001:4830:134:3::10]:55517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tm8-0006g0-Rc
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tm5-0003fR-LV
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:11:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tm5-0003fA-G9
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:11:05 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:15 +0200
Message-Id: <20180326150916.9602-38-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 37/38] monitor: teach HMP about asynchronous
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Similar to how we handle both synchronous and asynchronous commands in
QMP, HMP gains a new async_cmd() that will allow the command to
complete asynchronously. For interactive reasons, and command
ordering, the HMP monitor is suspended until the asynchronous command
completes.

Note that QMP human-monitor-command is modified to deal with it, by
using a specialized QmpSession return callback to destroy the
temporary HMP monitor.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 106 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 27 deletions(-)

diff --git a/monitor.c b/monitor.c
index e11c0abdca..018bd9280f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -127,13 +127,17 @@ typedef struct mon_cmd_t {
     const char *args_type;
     const char *params;
     const char *help;
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
@@ -203,6 +207,7 @@ struct Monitor {
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool skip_flush;
     bool use_io_thr;
+    QmpReturn *for_qmp_command;
=20
     QemuMutex out_lock;
     QString *outbuf;
@@ -607,7 +612,7 @@ static void monitor_qapi_event_init(void)
     qmp_event_set_func_emit(monitor_qapi_event_queue);
 }
=20
-static void handle_hmp_command(Monitor *mon, const char *cmdline);
+static bool handle_hmp_command(Monitor *mon, const char *cmdline);
=20
 static void monitor_data_init(Monitor *mon, bool skip_flush,
                               bool use_io_thr)
@@ -637,16 +642,68 @@ static void monitor_data_destroy(Monitor *mon)
     g_queue_free(mon->qmp.qmp_requests);
 }
=20
+static void free_temporary_hmp(void *opaque)
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
+    return iothread_get_aio_context(mon_global.mon_iothread);
+}
+
+static void qmp_human_monitor_command_finish(Monitor *hmp, QmpReturn *qr=
et)
+{
+    char *output;
+
+    if (qstring_get_length(hmp->outbuf) > 0) {
+        output =3D g_strdup(qstring_get_str(hmp->outbuf));
+    } else {
+        output =3D g_strdup("");
+    }
+
+    qmp_human_monitor_command_return(qret, output);
+
+    if (hmp->for_qmp_command) {
+        aio_bh_schedule_oneshot(monitor_get_aio_context(),
+                                free_temporary_hmp, hmp);
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
@@ -659,20 +716,11 @@ void qmp_human_monitor_command(const char *command_=
line, bool has_cpu_index,
         }
     }
=20
-    handle_hmp_command(&hmp, command_line);
-
-    qemu_mutex_lock(&hmp.out_lock);
-    if (qstring_get_length(hmp.outbuf) > 0) {
-        output =3D g_strdup(qstring_get_str(hmp.outbuf));
-    } else {
-        output =3D g_strdup("");
+    if (!handle_hmp_command(hmp, command_line)) {
+        qmp_human_monitor_command_finish(hmp, qret);
     }
-    qemu_mutex_unlock(&hmp.out_lock);
-
-    qmp_human_monitor_command_return(qret, output);
=20
 out:
-    monitor_data_destroy(&hmp);
     cur_mon =3D old_mon;
 }
=20
@@ -3244,7 +3292,7 @@ fail:
     return NULL;
 }
=20
-static void handle_hmp_command(Monitor *mon, const char *cmdline)
+static bool handle_hmp_command(Monitor *mon, const char *cmdline)
 {
     QDict *qdict;
     const mon_cmd_t *cmd;
@@ -3253,18 +3301,25 @@ static void handle_hmp_command(Monitor *mon, cons=
t char *cmdline)
=20
     cmd =3D monitor_parse_command(mon, cmdline, &cmdline, mon->cmd_table=
);
     if (!cmd) {
-        return;
+        return false;
     }
=20
     qdict =3D monitor_parse_arguments(mon, &cmdline, cmd);
     if (!qdict) {
         monitor_printf(mon, "Try \"help %s\" for more information\n",
                        cmd->name);
-        return;
+        return false;
+    }
+    if (cmd->async) {
+        QmpReturn *qret =3D qmp_return_new(&mon->qmp.session, NULL);
+        monitor_suspend(mon);
+        cmd->async_cmd(mon, qdict, qret);
+    } else {
+        cmd->cmd(mon, qdict);
     }
-
-    cmd->cmd(mon, qdict);
     QDECREF(qdict);
+
+    return cmd->async;
 }
=20
 static void cmd_completion(Monitor *mon, const char *name, const char *l=
ist)
@@ -4296,11 +4351,6 @@ static GMainContext *monitor_get_io_context(void)
     return iothread_get_g_main_context(mon_global.mon_iothread);
 }
=20
-static AioContext *monitor_get_aio_context(void)
-{
-    return iothread_get_aio_context(mon_global.mon_iothread);
-}
-
 static void monitor_iothread_init(void)
 {
     mon_global.mon_iothread =3D iothread_create("mon_iothread",
@@ -4439,6 +4489,8 @@ void monitor_init(Chardev *chr, int flags)
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
2.17.0.rc1.1.g4c4f2b46a3
