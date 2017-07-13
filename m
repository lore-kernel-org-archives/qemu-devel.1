Received: from eggs.gnu.org ([2001:4830:134:3::10]:51093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3E-0000l1-Q8
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3C-0002Bc-UM
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:08 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf3C-000292-Nv
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:06 -0400
Received: by mail-wr0-x22d.google.com with SMTP id k67so53863945wrc.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:09 +0200
Message-Id: <1499955874-10954-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/41] test-char: add hotswap test
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

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <1499342940-56739-10-git-send-email-anton.nefedov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-char.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index c654eea..7ac25ff 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -658,6 +658,76 @@ static void char_invalid_test(void)
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
+    ChardevReturn *ret;
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
+    ret = qmp_chardev_change("chardev", &backend, NULL);
+    g_assert(!ret);
+    g_assert(be.chr == chr);
+
+    char_udp_test_internal(chr, sock);
+
+    /* now allow the change */
+    qemu_chr_fe_set_handlers(&be, NULL, NULL,
+                             NULL, chardev_change, NULL, NULL, true);
+
+    /* has to succeed now */
+    ret = qmp_chardev_change("chardev", &backend, &error_abort);
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
+    qapi_free_ChardevReturn(ret);
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
@@ -692,6 +762,7 @@ int main(int argc, char **argv)
 #ifdef HAVE_CHARDEV_SERIAL
     g_test_add_func("/char/serial", char_serial_test);
 #endif
+    g_test_add_func("/char/hotswap", char_hotswap_test);
 
     return g_test_run();
 }
-- 
1.8.3.1
