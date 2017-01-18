Received: from eggs.gnu.org ([2001:4830:134:3::10]:38000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsj2-0003Oa-9l
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiy-0007ma-50
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsix-0007mU-TN
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:36 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F3D97AE74
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:21 +0400
Message-Id: <20170118160332.13390-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/25] monitor: add !qmp pre-conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

It's not always obvious whether a function is meant to be used only with
HMP or QMP. Add a few pre-conditions to document this aspect and
eventually catch run-time bugs.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 585f7b6a1a..c5c70d7e17 100644
--- a/monitor.c
+++ b/monitor.c
@@ -246,6 +246,8 @@ bool monitor_cur_is_qmp(void)
=20
 void monitor_read_command(Monitor *mon, int show_prompt)
 {
+    assert(!monitor_is_qmp(mon));
+
     if (!mon->rs)
         return;
=20
@@ -257,6 +259,8 @@ void monitor_read_command(Monitor *mon, int show_prom=
pt)
 int monitor_read_password(Monitor *mon, ReadLineFunc *readline_func,
                           void *opaque)
 {
+    assert(!monitor_is_qmp(mon));
+
     if (mon->rs) {
         readline_start(mon->rs, "Password: ", 1, readline_func, opaque);
         /* prompt is printed on return from the command handler */
@@ -2548,6 +2552,8 @@ static const mon_cmd_t *monitor_parse_command(Monit=
or *mon,
     const mon_cmd_t *cmd;
     char cmdname[256];
=20
+    assert(!monitor_is_qmp(mon));
+
     /* extract the command name */
     p =3D get_command_name(*cmdp, cmdname, sizeof(cmdname));
     if (!p)
@@ -2592,6 +2598,8 @@ static QDict *monitor_parse_arguments(Monitor *mon,
     char buf[1024];
     QDict *qdict =3D qdict_new();
=20
+    assert(!monitor_is_qmp(mon));
+
     /* parse the parameters */
     typestr =3D cmd->args_type;
     for(;;) {
@@ -2971,6 +2979,8 @@ static void cmd_completion(Monitor *mon, const char=
 *name, const char *list)
     char cmd[128];
     int len;
=20
+    assert(!monitor_is_qmp(mon));
+
     p =3D list;
     for(;;) {
         pstart =3D p;
@@ -3000,6 +3010,8 @@ static void file_completion(Monitor *mon, const cha=
r *input)
     int input_path_len;
     const char *p;
=20
+    assert(!monitor_is_qmp(mon));
+
     p =3D strrchr(input, '/');
     if (!p) {
         input_path_len =3D 0;
@@ -3552,6 +3564,8 @@ static void monitor_find_completion_by_table(Monito=
r *mon,
     const mon_cmd_t *cmd;
     BlockBackend *blk =3D NULL;
=20
+    assert(!monitor_is_qmp(mon));
+
     if (nb_args <=3D 1) {
         /* command completion */
         if (nb_args =3D=3D 0)
@@ -3633,6 +3647,8 @@ static void monitor_find_completion(void *opaque,
     char *args[MAX_ARGS];
     int nb_args, len;
=20
+    assert(!monitor_is_qmp(mon));
+
     /* 1. parse the cmdline */
     if (parse_cmdline(cmdline, &nb_args, args) < 0) {
         return;
@@ -3801,6 +3817,8 @@ static void monitor_qmp_read(void *opaque, const ui=
nt8_t *buf, int size)
=20
     cur_mon =3D opaque;
=20
+    assert(monitor_is_qmp(cur_mon));
+
     json_message_parser_feed(&cur_mon->qmp.parser, (const char *) buf, s=
ize);
=20
     cur_mon =3D old_mon;
@@ -3812,6 +3830,7 @@ static void monitor_read(void *opaque, const uint8_=
t *buf, int size)
     int i;
=20
     cur_mon =3D opaque;
+    assert(!monitor_is_qmp(cur_mon));
=20
     if (cur_mon->rs) {
         for (i =3D 0; i < size; i++)
@@ -3831,6 +3850,8 @@ static void monitor_command_cb(void *opaque, const =
char *cmdline,
 {
     Monitor *mon =3D opaque;
=20
+    assert(!monitor_is_qmp(mon));
+
     monitor_suspend(mon);
     handle_hmp_command(mon, cmdline);
     monitor_resume(mon);
@@ -3838,6 +3859,8 @@ static void monitor_command_cb(void *opaque, const =
char *cmdline,
=20
 int monitor_suspend(Monitor *mon)
 {
+    assert(!monitor_is_qmp(mon));
+
     if (!mon->rs)
         return -ENOTTY;
     mon->suspend_cnt++;
@@ -3846,6 +3869,8 @@ int monitor_suspend(Monitor *mon)
=20
 void monitor_resume(Monitor *mon)
 {
+    assert(!monitor_is_qmp(mon));
+
     if (!mon->rs)
         return;
     if (--mon->suspend_cnt =3D=3D 0)
@@ -3867,6 +3892,8 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
     QObject *data;
     Monitor *mon =3D opaque;
=20
+    assert(monitor_is_qmp(mon));
+
     switch (event) {
     case CHR_EVENT_OPENED:
         qmp_client_init(&mon->qmp.client, qmp_dispatch_return);
@@ -3890,6 +3917,8 @@ static void monitor_event(void *opaque, int event)
 {
     Monitor *mon =3D opaque;
=20
+    assert(!monitor_is_qmp(mon));
+
     switch (event) {
     case CHR_EVENT_MUX_IN:
         qemu_mutex_lock(&mon->out_lock);
@@ -3962,15 +3991,23 @@ static void sortcmdlist(void)
 static void GCC_FMT_ATTR(2, 3) monitor_readline_printf(void *opaque,
                                                        const char *fmt, =
...)
 {
+    Monitor *mon =3D opaque;
     va_list ap;
+
+    assert(!monitor_is_qmp(mon));
+
     va_start(ap, fmt);
-    monitor_vprintf(opaque, fmt, ap);
+    monitor_vprintf(mon, fmt, ap);
     va_end(ap);
 }
=20
 static void monitor_readline_flush(void *opaque)
 {
-    monitor_flush(opaque);
+    Monitor *mon =3D opaque;
+
+    assert(!monitor_is_qmp(mon));
+
+    monitor_flush(mon);
 }
=20
 /*
@@ -4059,6 +4096,8 @@ static void bdrv_password_cb(void *opaque, const ch=
ar *password,
     int ret =3D 0;
     Error *local_err =3D NULL;
=20
+    assert(!monitor_is_qmp(mon));
+
     bdrv_add_key(bs, password, &local_err);
     if (local_err) {
         error_report_err(local_err);
@@ -4076,6 +4115,8 @@ int monitor_read_bdrv_key_start(Monitor *mon, Block=
DriverState *bs,
 {
     int err;
=20
+    assert(!monitor_is_qmp(mon));
+
     monitor_printf(mon, "%s (%s) is encrypted.\n", bdrv_get_device_name(=
bs),
                    bdrv_get_encrypted_filename(bs));
=20
@@ -4097,6 +4138,8 @@ int monitor_read_block_device_key(Monitor *mon, con=
st char *device,
     Error *err =3D NULL;
     BlockBackend *blk;
=20
+    assert(!monitor_is_qmp(mon));
+
     blk =3D blk_by_name(device);
     if (!blk) {
         monitor_printf(mon, "Device not found %s\n", device);
--=20
2.11.0.295.gd7dffce1c
