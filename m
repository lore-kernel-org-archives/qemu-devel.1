Received: from eggs.gnu.org ([2001:4830:134:3::10]:51092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3E-0000l0-Q9
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3B-00026x-53
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:08 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf3A-00025m-RJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:05 -0400
Received: by mail-wr0-x244.google.com with SMTP id y28so4890920wrd.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:08 +0200
Message-Id: <1499955874-10954-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/41] test-char: split char_file_test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

makes it possible to test the existing chardev-file

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <1499342940-56739-9-git-send-email-anton.nefedov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-char.c | 137 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 84 insertions(+), 53 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index e0bde5e..c654eea 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -503,82 +503,110 @@ static void char_serial_test(void)
 }
 #endif
 
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
+    chr = qemu_chardev_new("label-file", TYPE_CHARDEV_FILE, &backend,
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
+    g_assert_cmpint(fe.last_event, !=, CHR_EVENT_BREAK);
+    qmp_chardev_send_break("label-foo", NULL);
+    g_assert_cmpint(fe.last_event, !=, CHR_EVENT_BREAK);
+    qmp_chardev_send_break("label-file", NULL);
+    g_assert_cmpint(fe.last_event, ==, CHR_EVENT_BREAK);
+
+    main_loop();
+
+    close(fd);
+
+    g_assert_cmpint(fe.read_count, ==, 8);
+    g_assert_cmpstr(fe.read_buf, ==, "fifo-in");
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
-        chr = qemu_chardev_new("label-file", TYPE_CHARDEV_FILE, &backend,
-                               &error_abort);
 
-        qemu_chr_fe_init(&be, chr, &error_abort);
-        qemu_chr_fe_set_handlers(&be,
-                                 fe_can_read,
-                                 fe_read,
-                                 fe_event,
-                                 NULL,
-                                 &fe, NULL, true);
-
-        g_assert_cmpint(fe.last_event, !=, CHR_EVENT_BREAK);
-        qmp_chardev_send_break("label-foo", NULL);
-        g_assert_cmpint(fe.last_event, !=, CHR_EVENT_BREAK);
-        qmp_chardev_send_break("label-file", NULL);
-        g_assert_cmpint(fe.last_event, ==, CHR_EVENT_BREAK);
-
-        main_loop();
-
-        close(fd);
-
-        g_assert_cmpint(fe.read_count, ==, 8);
-        g_assert_cmpstr(fe.read_buf, ==, "fifo-in");
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
 
+static void char_file_test(void)
+{
+    char_file_test_internal(NULL, NULL);
+}
+
 static void char_null_test(void)
 {
     Error *err = NULL;
@@ -656,6 +684,9 @@ int main(int argc, char **argv)
     g_test_add_func("/char/pipe", char_pipe_test);
 #endif
     g_test_add_func("/char/file", char_file_test);
+#ifndef _WIN32
+    g_test_add_func("/char/file-fifo", char_file_fifo_test);
+#endif
     g_test_add_func("/char/socket", char_socket_test);
     g_test_add_func("/char/udp", char_udp_test);
 #ifdef HAVE_CHARDEV_SERIAL
-- 
1.8.3.1
