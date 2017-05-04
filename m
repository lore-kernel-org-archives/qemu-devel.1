Received: from eggs.gnu.org ([2001:4830:134:3::10]:46663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FBj-0004Zr-Hf
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FBf-0004vi-CC
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6FBf-0004vT-3B
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:47 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 15:42:29 +0400
Message-Id: <20170504114232.20318-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170504114232.20318-1-marcandre.lureau@redhat.com>
References: <20170504114232.20318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/21] tests: add /char/file test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 71 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 2b155ffcb7..87a4e2986d 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -277,6 +277,76 @@ static void char_pipe_test(void)
 }
 #endif
=20
+static void char_file_test(void)
+{
+    char *tmp_path =3D g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
+    char *out =3D g_build_filename(tmp_path, "out", NULL);
+    char *contents =3D NULL;
+    ChardevFile file =3D { .out =3D out };
+    ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_FILE,
+                               .u.file.data =3D &file };
+    Chardev *chr;
+    gsize length;
+    int ret;
+
+    chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
+                           &error_abort);
+    ret =3D qemu_chr_write_all(chr, (uint8_t *)"hello!", 6);
+    g_assert_cmpint(ret, =3D=3D, 6);
+    object_unref(OBJECT(chr));
+
+    ret =3D g_file_get_contents(out, &contents, &length, NULL);
+    g_assert(ret =3D=3D TRUE);
+    g_assert_cmpint(length, =3D=3D, 6);
+    g_assert(strncmp(contents, "hello!", 6) =3D=3D 0);
+    g_free(contents);
+
+#ifndef _WIN32
+    {
+        CharBackend be;
+        FeHandler fe =3D { 0, };
+        char *fifo =3D g_build_filename(tmp_path, "fifo", NULL);
+        int fd;
+
+        if (mkfifo(fifo, 0600) < 0) {
+            abort();
+        }
+
+        fd =3D open(fifo, O_RDWR);
+        ret =3D write(fd, "fifo-in", 8);
+        g_assert_cmpint(ret, =3D=3D, 8);
+
+        file.in =3D fifo;
+        file.has_in =3D true;
+        chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
+                               &error_abort);
+
+        qemu_chr_fe_init(&be, chr, &error_abort);
+        qemu_chr_fe_set_handlers(&be,
+                                 fe_can_read,
+                                 fe_read,
+                                 fe_event,
+                                 &fe, NULL, true);
+
+        main_loop();
+
+        close(fd);
+
+        g_assert_cmpint(fe.read_count, =3D=3D, 8);
+        g_assert_cmpstr(fe.read_buf, =3D=3D, "fifo-in");
+        qemu_chr_fe_deinit(&be);
+        object_unref(OBJECT(chr));
+        g_unlink(fifo);
+        g_free(fifo);
+    }
+#endif
+
+    g_unlink(out);
+    g_rmdir(tmp_path);
+    g_free(tmp_path);
+    g_free(out);
+}
+
 static void char_null_test(void)
 {
     Error *err =3D NULL;
@@ -348,6 +418,7 @@ int main(int argc, char **argv)
 #ifndef _WIN32
     g_test_add_func("/char/pipe", char_pipe_test);
 #endif
+    g_test_add_func("/char/file", char_file_test);
=20
     return g_test_run();
 }
--=20
2.12.0.191.gc5d8de91d
