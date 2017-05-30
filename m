Received: from eggs.gnu.org ([2001:4830:134:3::10]:46036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dFhfa-0005EU-Px
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dFhfW-0007Hs-TQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:46 -0400
Received: from mail-he1eur01on0136.outbound.protection.outlook.com
	([104.47.0.136]:15171
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dFhfW-0007GL-H3
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:42 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 30 May 2017 16:57:58 +0300
Message-ID: <1496152683-102751-9-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 08/13] test-char: split char_file_test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

makes it possible to test the existing chardev-file

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 tests/test-char.c | 127 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 79 insertions(+), 48 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index ad0752a..ed6b18f 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -484,75 +484,103 @@ static void char_udp_test(void)
     char_udp_test_internal(NULL, 0);
 }
 
-static void char_file_test(void)
+#ifndef _WIN32
+static void char_file_fifo_test(void)
 {
+    Chardev *chr;
+    CharBackend be;
     char *tmp_path = g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
+    char *fifo = g_build_filename(tmp_path, "fifo", NULL);
     char *out = g_build_filename(tmp_path, "out", NULL);
-    char *contents = NULL;
-    ChardevFile file = { .out = out };
+    ChardevFile file = { .in = fifo,
+                         .has_in = true,
+                         .out = out };
     ChardevBackend backend = { .type = CHARDEV_BACKEND_KIND_FILE,
                                .u.file.data = &file };
+    FeHandler fe = { 0, };
+    int fd, ret;
+
+    if (mkfifo(fifo, 0600) < 0) {
+        abort();
+    }
+
+    fd = open(fifo, O_RDWR);
+    ret = write(fd, "fifo-in", 8);
+    g_assert_cmpint(ret, ==, 8);
+
+    chr = qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
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
+    main_loop();
+
+    close(fd);
+
+    g_assert_cmpint(fe.read_count, ==, 8);
+    g_assert_cmpstr(fe.read_buf, ==, "fifo-in");
+
+    qemu_chr_fe_deinit(&be);
+    object_unref(OBJECT(chr));
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
+static void char_file_test_internal(Chardev *ext_chr, const char *filepath)
+{
+    char *tmp_path = g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
+    char *out;
     Chardev *chr;
+    char *contents = NULL;
+    ChardevFile file = {};
+    ChardevBackend backend = { .type = CHARDEV_BACKEND_KIND_FILE,
+                               .u.file.data = &file };
     gsize length;
     int ret;
 
-    chr = qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
-                           &error_abort);
+    if (ext_chr) {
+        chr = ext_chr;
+        out = g_strdup(filepath);
+        file.out = out;
+    } else {
+        out = g_build_filename(tmp_path, "out", NULL);
+        file.out = out;
+        chr = qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
+                               &error_abort);
+    }
     ret = qemu_chr_write_all(chr, (uint8_t *)"hello!", 6);
     g_assert_cmpint(ret, ==, 6);
-    object_unref(OBJECT(chr));
 
     ret = g_file_get_contents(out, &contents, &length, NULL);
     g_assert(ret == TRUE);
     g_assert_cmpint(length, ==, 6);
     g_assert(strncmp(contents, "hello!", 6) == 0);
-    g_free(contents);
-
-#ifndef _WIN32
-    {
-        CharBackend be;
-        FeHandler fe = { 0, };
-        char *fifo = g_build_filename(tmp_path, "fifo", NULL);
-        int fd;
-
-        if (mkfifo(fifo, 0600) < 0) {
-            abort();
-        }
-
-        fd = open(fifo, O_RDWR);
-        ret = write(fd, "fifo-in", 8);
-        g_assert_cmpint(ret, ==, 8);
-
-        file.in = fifo;
-        file.has_in = true;
-        chr = qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
-                               &error_abort);
-
-        qemu_chr_fe_init(&be, chr, &error_abort);
-        qemu_chr_fe_set_handlers(&be,
-                                 fe_can_read,
-                                 fe_read,
-                                 fe_event,
-                                 NULL,
-                                 &fe, NULL, true);
-
-        main_loop();
 
-        close(fd);
-
-        g_assert_cmpint(fe.read_count, ==, 8);
-        g_assert_cmpstr(fe.read_buf, ==, "fifo-in");
-        qemu_chr_fe_deinit(&be);
+    if (!ext_chr) {
         object_unref(OBJECT(chr));
-        g_unlink(fifo);
-        g_free(fifo);
+        g_unlink(out);
+        g_free(out);
     }
-#endif
-
-    g_unlink(out);
+    g_free(contents);
     g_rmdir(tmp_path);
     g_free(tmp_path);
-    g_free(out);
+}
+
+static void char_file_test(void)
+{
+    char_file_test_internal(NULL, NULL);
 }
 
 static void char_null_test(void)
@@ -633,6 +661,9 @@ int main(int argc, char **argv)
     g_test_add_func("/char/pipe", char_pipe_test);
 #endif
     g_test_add_func("/char/file", char_file_test);
+#ifndef _WIN32
+    g_test_add_func("/char/file-fifo", char_file_fifo_test);
+#endif
     g_test_add_func("/char/socket", char_socket_test);
     g_test_add_func("/char/udp", char_udp_test);
 
-- 
2.7.4
