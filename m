Received: from eggs.gnu.org ([2001:4830:134:3::10]:41109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIg2N-0000td-E2
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIg2L-0004GR-N7
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:50:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30447)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIg2L-0004GH-HN
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:50:33 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 22:49:21 +0400
Message-Id: <20170607184921.28407-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170607184921.28407-1-marcandre.lureau@redhat.com>
References: <20170607184921.28407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] test-char: start a /char/serial test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Quite limited test, to check that the chardev can be created with a
path and with the tty alias.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index dfe856cb85..ecc3fec194 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -5,6 +5,7 @@
 #include "qemu/config-file.h"
 #include "qemu/sockets.h"
 #include "chardev/char-fe.h"
+#include "chardev/char-serial.h" /* for HAVE_CHARDEV_SERIAL */
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
@@ -450,6 +451,32 @@ static void char_udp_test(void)
     g_free(tmp);
 }
=20
+#ifdef HAVE_CHARDEV_SERIAL
+static void char_serial_test(void)
+{
+    QemuOpts *opts;
+    Chardev *chr;
+
+    opts =3D qemu_opts_create(qemu_find_opts("chardev"), "serial-id",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "serial", &error_abort);
+    qemu_opt_set(opts, "path", "/dev/null", &error_abort);
+
+    chr =3D qemu_chr_new_from_opts(opts, NULL);
+    g_assert_nonnull(chr);
+    /* TODO: add more tests with a pty */
+    object_unparent(OBJECT(chr));
+
+    /* test tty alias */
+    qemu_opt_set(opts, "backend", "tty", &error_abort);
+    chr =3D qemu_chr_new_from_opts(opts, NULL);
+    g_assert_nonnull(chr);
+    object_unparent(OBJECT(chr));
+
+    qemu_opts_del(opts);
+}
+#endif
+
 static void char_file_test(void)
 {
     char *tmp_path =3D g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
@@ -597,6 +624,9 @@ int main(int argc, char **argv)
     g_test_add_func("/char/file", char_file_test);
     g_test_add_func("/char/socket", char_socket_test);
     g_test_add_func("/char/udp", char_udp_test);
+#ifdef HAVE_CHARDEV_SERIAL
+    g_test_add_func("/char/serial", char_serial_test);
+#endif
=20
     return g_test_run();
 }
--=20
2.13.0.91.g00982b8dd
