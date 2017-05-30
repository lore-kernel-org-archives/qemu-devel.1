Received: from eggs.gnu.org ([2001:4830:134:3::10]:46009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dFhfZ-0005DJ-Hr
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dFhfV-0007G7-0j
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:45 -0400
Received: from mail-he1eur01on0131.outbound.protection.outlook.com
	([104.47.0.131]:9825
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dFhfU-0007Fk-LC
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:40 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 30 May 2017 16:57:57 +0300
Message-ID: <1496152683-102751-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 07/13] test-char: split char_udp_test
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

makes it possible to test the existing chardev-udp

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 tests/test-char.c | 58 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index d63d3d2..ad0752a 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -413,16 +413,11 @@ static void char_pipe_test(void)
 }
 #endif
 
-static void char_udp_test(void)
+static int make_udp_socket(int *port)
 {
-    struct sockaddr_in addr = { 0, }, other;
-    SocketIdleData d = { 0, };
-    Chardev *chr;
-    CharBackend be;
+    struct sockaddr_in addr = { 0, };
     socklen_t alen = sizeof(addr);
     int ret, sock = qemu_socket(PF_INET, SOCK_DGRAM, 0);
-    char buf[10];
-    char *tmp;
 
     g_assert_cmpint(sock, >, 0);
     addr.sin_family = AF_INET ;
@@ -433,19 +428,41 @@ static void char_udp_test(void)
     ret = getsockname(sock, (struct sockaddr *)&addr, &alen);
     g_assert_cmpint(ret, ==, 0);
 
-    tmp = g_strdup_printf("udp:127.0.0.1:%d",
-                          ntohs(addr.sin_port));
-    chr = qemu_chr_new("client", tmp);
-    g_assert_nonnull(chr);
+    *port = ntohs(addr.sin_port);
+    return sock;
+}
+
+static void char_udp_test_internal(Chardev *reuse_chr, int sock)
+{
+    struct sockaddr_in other;
+    SocketIdleData d = { 0, };
+    Chardev *chr;
+    CharBackend *be;
+    socklen_t alen = sizeof(other);
+    int ret;
+    char buf[10];
+    char *tmp = NULL;
+
+    if (reuse_chr) {
+        chr = reuse_chr;
+        be = chr->be;
+    } else {
+        int port;
+        sock = make_udp_socket(&port);
+        tmp = g_strdup_printf("udp:127.0.0.1:%d", port);
+        chr = qemu_chr_new("client", tmp);
+        g_assert_nonnull(chr);
+
+        be = g_alloca(sizeof(CharBackend));
+        qemu_chr_fe_init(be, chr, &error_abort);
+    }
 
     d.chr = chr;
-    qemu_chr_fe_init(&be, chr, &error_abort);
-    qemu_chr_fe_set_handlers(&be, socket_can_read_hello, socket_read_hello,
+    qemu_chr_fe_set_handlers(be, socket_can_read_hello, socket_read_hello,
                              NULL, NULL, &d, NULL, true);
     ret = qemu_chr_write_all(chr, (uint8_t *)"hello", 5);
     g_assert_cmpint(ret, ==, 5);
 
-    alen = sizeof(addr);
     ret = recvfrom(sock, buf, sizeof(buf), 0,
                    (struct sockaddr *)&other, &alen);
     g_assert_cmpint(ret, ==, 5);
@@ -454,10 +471,17 @@ static void char_udp_test(void)
 
     main_loop();
 
-    close(sock);
+    if (!reuse_chr) {
+        close(sock);
+        qemu_chr_fe_deinit(be);
+        object_unparent(OBJECT(chr));
+    }
     g_free(tmp);
-    qemu_chr_fe_deinit(&be);
-    object_unparent(OBJECT(chr));
+}
+
+static void char_udp_test(void)
+{
+    char_udp_test_internal(NULL, 0);
 }
 
 static void char_file_test(void)
-- 
2.7.4
