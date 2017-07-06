Received: from eggs.gnu.org ([2001:4830:134:3::10]:35978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5bz-0005nZ-GJ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5bv-0004rp-GI
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:23 -0400
Received: from mail-ve1eur01on0105.outbound.protection.outlook.com
	([104.47.1.105]:29312
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dT5bv-0004rZ-09
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:19 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu,  6 Jul 2017 15:08:55 +0300
Message-ID: <1499342940-56739-9-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 08/13] test-char: split char_file_test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, amit@kernel.org, mst@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

makes it possible to test the existing chardev-file

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 137 +++++++++++++++++++++++++++++++++-----------------=
----
 1 file changed, 84 insertions(+), 53 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 1265224..de72974 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -507,82 +507,110 @@ static void char_serial_test(void)
 }
 #endif
=20
-static void char_file_test(void)
+#ifndef _WIN32
+static void char_file_fifo_test(void)
 {
+    Chardev *chr;
+    CharBackend be;
     char *tmp_path =3D g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
+    char *fifo =3D g_build_filename(tmp_path, "fifo", NULL);
     char *out =3D g_build_filename(tmp_path, "out", NULL);
-    char *contents =3D NULL;
-    ChardevFile file =3D { .out =3D out };
+    ChardevFile file =3D { .in =3D fifo,
+                         .has_in =3D true,
+                         .out =3D out };
     ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_FILE,
                                .u.file.data =3D &file };
+    FeHandler fe =3D { 0, };
+    int fd, ret;
+
+    if (mkfifo(fifo, 0600) < 0) {
+        abort();
+    }
+
+    fd =3D open(fifo, O_RDWR);
+    ret =3D write(fd, "fifo-in", 8);
+    g_assert_cmpint(ret, =3D=3D, 8);
+
+    chr =3D qemu_chardev_new("label-file", TYPE_CHARDEV_FILE, &backend,
+                           &error_abort);
+
+    qemu_chr_fe_init(&be, chr, &error_abort);
+    qemu_chr_fe_set_handlers(&be,
+                             fe_can_read,
+                             fe_read,
+                             fe_event,
+                             NULL,
+                             &fe, NULL, true);
+
+    g_assert_cmpint(fe.last_event, !=3D, CHR_EVENT_BREAK);
+    qmp_chardev_send_break("label-foo", NULL);
+    g_assert_cmpint(fe.last_event, !=3D, CHR_EVENT_BREAK);
+    qmp_chardev_send_break("label-file", NULL);
+    g_assert_cmpint(fe.last_event, =3D=3D, CHR_EVENT_BREAK);
+
+    main_loop();
+
+    close(fd);
+
+    g_assert_cmpint(fe.read_count, =3D=3D, 8);
+    g_assert_cmpstr(fe.read_buf, =3D=3D, "fifo-in");
+
+    qemu_chr_fe_deinit(&be, true);
+
+    g_unlink(fifo);
+    g_free(fifo);
+    g_unlink(out);
+    g_free(out);
+    g_rmdir(tmp_path);
+    g_free(tmp_path);
+}
+#endif
+
+static void char_file_test_internal(Chardev *ext_chr, const char *filepath=
)
+{
+    char *tmp_path =3D g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
+    char *out;
     Chardev *chr;
+    char *contents =3D NULL;
+    ChardevFile file =3D {};
+    ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_FILE,
+                               .u.file.data =3D &file };
     gsize length;
     int ret;
=20
-    chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
-                           &error_abort);
+    if (ext_chr) {
+        chr =3D ext_chr;
+        out =3D g_strdup(filepath);
+        file.out =3D out;
+    } else {
+        out =3D g_build_filename(tmp_path, "out", NULL);
+        file.out =3D out;
+        chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
+                               &error_abort);
+    }
     ret =3D qemu_chr_write_all(chr, (uint8_t *)"hello!", 6);
     g_assert_cmpint(ret, =3D=3D, 6);
-    object_unref(OBJECT(chr));
=20
     ret =3D g_file_get_contents(out, &contents, &length, NULL);
     g_assert(ret =3D=3D TRUE);
     g_assert_cmpint(length, =3D=3D, 6);
     g_assert(strncmp(contents, "hello!", 6) =3D=3D 0);
-    g_free(contents);
-
-#ifndef _WIN32
-    {
-        CharBackend be;
-        FeHandler fe =3D { 0, };
-        char *fifo =3D g_build_filename(tmp_path, "fifo", NULL);
-        int fd;
-
-        if (mkfifo(fifo, 0600) < 0) {
-            abort();
-        }
-
-        fd =3D open(fifo, O_RDWR);
-        ret =3D write(fd, "fifo-in", 8);
-        g_assert_cmpint(ret, =3D=3D, 8);
-
-        file.in =3D fifo;
-        file.has_in =3D true;
-        chr =3D qemu_chardev_new("label-file", TYPE_CHARDEV_FILE, &backend=
,
-                               &error_abort);
=20
-        qemu_chr_fe_init(&be, chr, &error_abort);
-        qemu_chr_fe_set_handlers(&be,
-                                 fe_can_read,
-                                 fe_read,
-                                 fe_event,
-                                 NULL,
-                                 &fe, NULL, true);
-
-        g_assert_cmpint(fe.last_event, !=3D, CHR_EVENT_BREAK);
-        qmp_chardev_send_break("label-foo", NULL);
-        g_assert_cmpint(fe.last_event, !=3D, CHR_EVENT_BREAK);
-        qmp_chardev_send_break("label-file", NULL);
-        g_assert_cmpint(fe.last_event, =3D=3D, CHR_EVENT_BREAK);
-
-        main_loop();
-
-        close(fd);
-
-        g_assert_cmpint(fe.read_count, =3D=3D, 8);
-        g_assert_cmpstr(fe.read_buf, =3D=3D, "fifo-in");
-        qemu_chr_fe_deinit(&be, true);
-        g_unlink(fifo);
-        g_free(fifo);
+    if (!ext_chr) {
+        object_unref(OBJECT(chr));
+        g_unlink(out);
     }
-#endif
-
-    g_unlink(out);
+    g_free(contents);
     g_rmdir(tmp_path);
     g_free(tmp_path);
     g_free(out);
 }
=20
+static void char_file_test(void)
+{
+    char_file_test_internal(NULL, NULL);
+}
+
 static void char_null_test(void)
 {
     Error *err =3D NULL;
@@ -660,6 +688,9 @@ int main(int argc, char **argv)
     g_test_add_func("/char/pipe", char_pipe_test);
 #endif
     g_test_add_func("/char/file", char_file_test);
+#ifndef _WIN32
+    g_test_add_func("/char/file-fifo", char_file_fifo_test);
+#endif
     g_test_add_func("/char/socket", char_socket_test);
     g_test_add_func("/char/udp", char_udp_test);
 #ifdef HAVE_CHARDEV_SERIAL
--=20
2.7.4
