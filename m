Received: from eggs.gnu.org ([2001:4830:134:3::10]:51091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3E-0000kz-Ps
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf39-00025Q-Pb
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:08 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf39-000255-Jt
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:03 -0400
Received: by mail-wr0-x241.google.com with SMTP id n18so1461796wrb.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:07 +0200
Message-Id: <1499955874-10954-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/41] test-char: split char_udp_test
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

makes it possible to test the existing chardev-udp

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <1499342940-56739-8-git-send-email-anton.nefedov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-char.c | 56 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 536536e..e0bde5e 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -407,16 +407,11 @@ static void char_pipe_test(void)
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
@@ -427,19 +422,41 @@ static void char_udp_test(void)
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
@@ -448,9 +465,16 @@ static void char_udp_test(void)
 
     main_loop();
 
-    close(sock);
+    if (!reuse_chr) {
+        close(sock);
+        qemu_chr_fe_deinit(be, true);
+    }
     g_free(tmp);
-    qemu_chr_fe_deinit(&be, true);
+}
+
+static void char_udp_test(void)
+{
+    char_udp_test_internal(NULL, 0);
 }
 
 #ifdef HAVE_CHARDEV_SERIAL
-- 
1.8.3.1
