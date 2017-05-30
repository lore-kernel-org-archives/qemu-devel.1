Received: from eggs.gnu.org ([2001:4830:134:3::10]:46051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dFhfb-0005Fw-RF
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dFhfX-0007I3-H4
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:47 -0400
Received: from mail-he1eur01on0136.outbound.protection.outlook.com
	([104.47.0.136]:15171
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dFhfX-0007GL-4O
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:43 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 30 May 2017 16:57:59 +0300
Message-ID: <1496152683-102751-10-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 09/13] test-char: add hotswap test
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

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 tests/test-char.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index ed6b18f..cd54f88 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -635,6 +635,73 @@ static void char_invalid_test(void)
     g_assert_null(chr);
 }
 
+static int chardev_change(void *opaque)
+{
+    return 0;
+}
+
+static int chardev_change_denied(void *opaque)
+{
+    return -1;
+}
+
+static void char_hotswap_test(void)
+{
+    char *chr_args;
+    Chardev *chr;
+    CharBackend be;
+
+    gchar *tmp_path = g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
+    char *filename = g_build_filename(tmp_path, "file", NULL);
+    ChardevFile file = { .out = filename };
+    ChardevBackend backend = { .type = CHARDEV_BACKEND_KIND_FILE,
+                               .u.file.data = &file };
+
+    int port;
+    int sock = make_udp_socket(&port);
+    g_assert_cmpint(sock, >, 0);
+
+    chr_args = g_strdup_printf("udp:127.0.0.1:%d", port);
+
+    chr = qemu_chr_new("chardev", chr_args);
+    qemu_chr_fe_init(&be, chr, &error_abort);
+
+    /* check that chardev operates correctly */
+    char_udp_test_internal(chr, sock);
+
+    /* set the handler that denies the hotswap */
+    qemu_chr_fe_set_handlers(&be, NULL, NULL,
+                             NULL, chardev_change_denied, NULL, NULL, true);
+
+    /* now, change is denied and has to keep the old backend operating */
+    qmp_chardev_change("chardev", &backend, NULL);
+    g_assert(be.chr == chr);
+
+    char_udp_test_internal(chr, sock);
+
+    /* now allow the change */
+    qemu_chr_fe_set_handlers(&be, NULL, NULL,
+                             NULL, chardev_change, NULL, NULL, true);
+
+    /* has to succeed now */
+    qmp_chardev_change("chardev", &backend, &error_abort);
+    g_assert(be.chr != chr);
+
+    close(sock);
+    chr = be.chr;
+
+    /* run the file chardev test */
+    char_file_test_internal(chr, filename);
+
+    object_unparent(OBJECT(chr));
+
+    g_unlink(filename);
+    g_free(filename);
+    g_rmdir(tmp_path);
+    g_free(tmp_path);
+    g_free(chr_args);
+}
+
 int main(int argc, char **argv)
 {
     qemu_init_main_loop(&error_abort);
@@ -666,6 +733,7 @@ int main(int argc, char **argv)
 #endif
     g_test_add_func("/char/socket", char_socket_test);
     g_test_add_func("/char/udp", char_udp_test);
+    g_test_add_func("/char/hotswap", char_hotswap_test);
 
     return g_test_run();
 }
-- 
2.7.4
