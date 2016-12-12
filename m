Received: from eggs.gnu.org ([2001:4830:134:3::10]:42920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZKc-0003kr-Ur
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZKc-0003YY-3V
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZKb-0003X5-Ro
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:26 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 005D98123A
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:44:25 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:44 +0300
Message-Id: <20161212224325.20790-14-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/54] char: use error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Prefer error_report() over fprintf(stderr..)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-char.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 9220001906..315037049b 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -451,8 +451,8 @@ int qemu_chr_fe_get_msgfd(CharBackend *be)
     int fd;
     int res =3D (qemu_chr_fe_get_msgfds(be, &fd, 1) =3D=3D 1) ? fd : -1;
     if (s && qemu_chr_replay(s)) {
-        fprintf(stderr,
-                "Replay: get msgfd is not supported for serial devices y=
et\n");
+        error_report("Replay: get msgfd is not supported "
+                     "for serial devices yet");
         exit(1);
     }
     return res;
@@ -1674,8 +1674,8 @@ static Chardev *qemu_chr_open_pty(const CharDriver =
*driver,
     ret->pty =3D g_strdup(pty_name);
     ret->has_pty =3D true;
=20
-    fprintf(stderr, "char device redirected to %s (label %s)\n",
-            pty_name, id);
+    error_report("char device redirected to %s (label %s)",
+                 pty_name, id);
=20
     s =3D (PtyChardev *)chr;
     s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
@@ -3376,8 +3376,8 @@ static int tcp_chr_wait_connected(Chardev *chr, Err=
or **errp)
      * in TLS and telnet cases, only wait for an accepted socket */
     while (!s->ioc) {
         if (s->is_listen) {
-            fprintf(stderr, "QEMU waiting for connection on: %s\n",
-                    chr->filename);
+            error_report("QEMU waiting for connection on: %s",
+                         chr->filename);
             qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, N=
ULL);
             tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
             qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), false, =
NULL);
@@ -4130,17 +4130,20 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
     }
=20
     if (is_help_option(qemu_opt_get(opts, "backend"))) {
-        fprintf(stderr, "Available chardev backend types:\n");
+        GString *str =3D g_string_new("");
         for (i =3D 0; i < ARRAY_SIZE(backends); i++) {
             cd =3D backends[i];
             if (cd) {
-                fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->ki=
nd]);
+                g_string_append_printf(str, "\n%s", ChardevBackendKind_l=
ookup[cd->kind]);
                 if (cd->alias) {
-                    fprintf(stderr, "%s\n", cd->alias);
+                    g_string_append_printf(str, "\n%s", cd->alias);
                 }
             }
         }
-        exit(!is_help_option(qemu_opt_get(opts, "backend")));
+
+        error_report("Available chardev backend types: %s", str->str);
+        g_string_free(str, true);
+        exit(0);
     }
=20
     if (id =3D=3D NULL) {
@@ -4255,8 +4258,8 @@ Chardev *qemu_chr_new(const char *label, const char=
 *filename)
             qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
         }
         if (qemu_chr_replay(chr) && chr->driver->chr_ioctl) {
-            fprintf(stderr,
-                    "Replay: ioctl is not supported for serial devices y=
et\n");
+            error_report("Replay: ioctl is not supported "
+                         "for serial devices yet");
         }
         replay_register_char_driver(chr);
     }
--=20
2.11.0
