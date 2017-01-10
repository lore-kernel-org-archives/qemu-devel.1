Received: from eggs.gnu.org ([2001:4830:134:3::10]:47465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XS-0005SC-21
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XO-0007wz-34
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cR0XN-0007w9-Qb
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:45 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3BC061B8A
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 17:48:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 18:48:06 +0100
Message-Id: <20170110174810.17748-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170110174810.17748-1-marcandre.lureau@redhat.com>
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 16/20] char: use error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Prefer error_report() over fprintf(stderr..)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-char.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index bf04360c5b..08c2113fb2 100644
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
@@ -1680,8 +1680,8 @@ static Chardev *qemu_chr_open_pty(const CharDriver =
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
@@ -3384,8 +3384,8 @@ static int tcp_chr_wait_connected(Chardev *chr, Err=
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
@@ -4144,16 +4144,19 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
     }
=20
     if (is_help_option(name)) {
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
+
+        error_report("Available chardev backend types: %s", str->str);
+        g_string_free(str, true);
         exit(0);
     }
=20
@@ -4265,8 +4268,8 @@ Chardev *qemu_chr_new(const char *label, const char=
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
