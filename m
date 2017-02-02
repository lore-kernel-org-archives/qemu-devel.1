Received: from eggs.gnu.org ([2001:4830:134:3::10]:39908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIl7-0005XE-DZ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIl1-0004Y7-DJ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:53:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIl1-0004XM-4T
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:53:07 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E39C3D945
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:53:07 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:37 +0400
Message-Id: <20170202145141.17138-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170202145141.17138-1-marcandre.lureau@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 18/22] tests: add /char/pipe test
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 90 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index aa9b18a61b..8166ace487 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include <glib/gstdio.h>
=20
 #include "qemu-common.h"
 #include "qemu/config-file.h"
@@ -7,12 +8,28 @@
 #include "qapi/error.h"
 #include "qmp-commands.h"
=20
+static bool quit;
+
 typedef struct FeHandler {
     int read_count;
     int last_event;
     char read_buf[128];
 } FeHandler;
=20
+#ifndef _WIN32
+static void main_loop(void)
+{
+    bool nonblocking;
+    int last_io =3D 0;
+
+    quit =3D false;
+    do {
+        nonblocking =3D last_io > 0;
+        last_io =3D main_loop_wait(nonblocking);
+    } while (!quit);
+}
+#endif
+
 static int fe_can_read(void *opaque)
 {
     FeHandler *h =3D opaque;
@@ -28,6 +45,7 @@ static void fe_read(void *opaque, const uint8_t *buf, i=
nt size)
=20
     memcpy(h->read_buf + h->read_count, buf, size);
     h->read_count +=3D size;
+    quit =3D true;
 }
=20
 static void fe_event(void *opaque, int event)
@@ -35,6 +53,7 @@ static void fe_event(void *opaque, int event)
     FeHandler *h =3D opaque;
=20
     h->last_event =3D event;
+    quit =3D true;
 }
=20
 #ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
@@ -192,6 +211,72 @@ static void char_mux_test(void)
     qemu_chr_delete(chr);
 }
=20
+#ifndef _WIN32
+static void char_pipe_test(void)
+{
+    gchar *tmp_path =3D g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
+    gchar *tmp, *in, *out, *pipe =3D g_build_filename(tmp_path, "pipe", =
NULL);
+    Chardev *chr;
+    CharBackend be;
+    int ret, fd;
+    char buf[10];
+    FeHandler fe =3D { 0, };
+
+    in =3D g_strdup_printf("%s.in", pipe);
+    if (mkfifo(in, 0600) < 0) {
+        abort();
+    }
+    out =3D g_strdup_printf("%s.out", pipe);
+    if (mkfifo(out, 0600) < 0) {
+        abort();
+    }
+
+    tmp =3D g_strdup_printf("pipe:%s", pipe);
+    chr =3D qemu_chr_new("pipe", tmp);
+    g_assert_nonnull(chr);
+    g_free(tmp);
+
+    qemu_chr_fe_init(&be, chr, &error_abort);
+
+    ret =3D qemu_chr_fe_write(&be, (void *)"pipe-out", 9);
+    g_assert_cmpint(ret, =3D=3D, 9);
+
+    fd =3D open(out, O_RDWR);
+    ret =3D read(fd, buf, sizeof(buf));
+    g_assert_cmpint(ret, =3D=3D, 9);
+    g_assert_cmpstr(buf, =3D=3D, "pipe-out");
+    close(fd);
+
+    fd =3D open(in, O_WRONLY);
+    ret =3D write(fd, "pipe-in", 8);
+    g_assert_cmpint(ret, =3D=3D, 8);
+    close(fd);
+
+    qemu_chr_fe_set_handlers(&be,
+                             fe_can_read,
+                             fe_read,
+                             fe_event,
+                             &fe,
+                             NULL, true);
+
+    main_loop();
+
+    g_assert_cmpint(fe.read_count, =3D=3D, 8);
+    g_assert_cmpstr(fe.read_buf, =3D=3D, "pipe-in");
+
+    qemu_chr_fe_deinit(&be);
+    qemu_chr_delete(chr);
+
+    g_assert(g_unlink(in) =3D=3D 0);
+    g_assert(g_unlink(out) =3D=3D 0);
+    g_assert(g_rmdir(tmp_path) =3D=3D 0);
+    g_free(in);
+    g_free(out);
+    g_free(tmp_path);
+    g_free(pipe);
+}
+#endif
+
 static void char_null_test(void)
 {
     Error *err =3D NULL;
@@ -245,6 +330,8 @@ static void char_invalid_test(void)
=20
 int main(int argc, char **argv)
 {
+    qemu_init_main_loop(&error_abort);
+
     g_test_init(&argc, &argv, NULL);
=20
     module_call_init(MODULE_INIT_QOM);
@@ -258,6 +345,9 @@ int main(int argc, char **argv)
     g_test_add_func("/char/stdio/subprocess", char_stdio_test_subprocess=
);
     g_test_add_func("/char/stdio", char_stdio_test);
 #endif
+#ifndef _WIN32
+    g_test_add_func("/char/pipe", char_pipe_test);
+#endif
=20
     return g_test_run();
 }
--=20
2.11.0.295.gd7dffce1c.dirty
