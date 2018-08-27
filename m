Received: from eggs.gnu.org ([2001:4830:134:3::10]:57555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fuMSR-000153-Ld
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 14:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fuMSE-0007dl-Ls
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 14:41:45 -0400
Received: from smtp58.i.mail.ru ([217.69.128.38]:45136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fuMSE-0007aN-7x
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 14:41:34 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Mon, 27 Aug 2018 21:41:03 +0300
Message-Id: <20180827184103.32190-3-jusual@mail.ru>
In-Reply-To: <20180827184103.32190-1-jusual@mail.ru>
References: <20180827184103.32190-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v2 2/2] tests/test-char: Check websocket
 chardev functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Test order:
    Creating server websocket chardev
    Creating usual tcp chardev client
    Sending handshake message from client
    Receiving handshake reply
    Sending ping frame with "hello" payload
    Receiving pong reply
    Sending binary data "world"
    Checking the received data on server side
    Checking of closing handshake

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 tests/test-char.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 5905d31441..deba699b25 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -406,6 +406,130 @@ static void char_socket_fdpass_test(void)
 }
 
 
+static void websock_server_read(void *opaque, const uint8_t *buf, int size)
+{
+    g_assert(size == 5);
+    g_assert(strncmp((char *) buf, "world", size) == 0);
+    quit = true;
+}
+
+
+static int websock_server_can_read(void *opaque)
+{
+    return 10;
+}
+
+
+static bool websock_check_http_headers(char *buf, int size)
+{
+    int i;
+    const char *ans[] = { "HTTP/1.1 101 Switching Protocols\r\n",
+                          "Server: QEMU VNC\r\n",
+                          "Upgrade: websocket\r\n",
+                          "Connection: Upgrade\r\n",
+                          "Sec-WebSocket-Accept:",
+                          "Sec-WebSocket-Protocol: binary\r\n" };
+
+    for (i = 0; i < 6; i++) {
+        if (g_strstr_len(buf, size, ans[i]) == NULL) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+
+static void websock_client_read(void *opaque, const uint8_t *buf, int size)
+{
+    const uint8_t ping[] = { 0x89, 0x85,                  /* Ping header */
+                             0x07, 0x77, 0x9e, 0xf9,      /* Masking key */
+                             0x6f, 0x12, 0xf2, 0x95, 0x68 /* "hello" */ };
+
+    const uint8_t binary[] = { 0x82, 0x85,                  /* Binary header */
+                               0x74, 0x90, 0xb9, 0xdf,      /* Masking key */
+                               0x03, 0xff, 0xcb, 0xb3, 0x10 /* "world" */ };
+    Chardev *chr_client = opaque;
+
+    if (websock_check_http_headers((char *) buf, size)) {
+        qemu_chr_fe_write(chr_client->be, ping, sizeof(ping));
+    } else if (buf[0] == 0x8a && buf[1] == 0x05) {
+        g_assert(strncmp((char *) buf + 2, "hello", 5) == 0);
+        qemu_chr_fe_write(chr_client->be, binary, sizeof(binary));
+    } else {
+        g_assert(buf[0] == 0x88 && buf[1] == 0x16);
+        g_assert(strncmp((char *) buf + 4, "peer requested close", 10) == 0);
+        quit = true;
+    }
+}
+
+
+static int websock_client_can_read(void *opaque)
+{
+    return 4096;
+}
+
+
+static void char_websock_test(void)
+{
+    QObject *addr;
+    QDict *qdict;
+    const char *port;
+    char *tmp;
+    char *handshake_port;
+    CharBackend be;
+    CharBackend client_be;
+    Chardev *chr_client;
+    Chardev *chr = qemu_chr_new("server",
+                                "websock:127.0.0.1:0,server,nowait");
+    const char handshake[] = "GET / HTTP/1.1\r\n"
+                             "Upgrade: websocket\r\n"
+                             "Connection: Upgrade\r\n"
+                             "Host: localhost:%s\r\n"
+                             "Origin: http://localhost:%s\r\n"
+                             "Sec-WebSocket-Key: o9JHNiS3/0/0zYE1wa3yIw==\r\n"
+                             "Sec-WebSocket-Version: 13\r\n"
+                             "Sec-WebSocket-Protocol: binary\r\n\r\n";
+    const uint8_t close[] = { 0x88, 0x82,             /* Close header */
+                              0xef, 0xaa, 0xc5, 0x97, /* Masking key */
+                              0xec, 0x42              /* Status code */ };
+
+    addr = object_property_get_qobject(OBJECT(chr), "addr", &error_abort);
+    qdict = qobject_to(QDict, addr);
+    port = qdict_get_str(qdict, "port");
+    tmp = g_strdup_printf("tcp:127.0.0.1:%s", port);
+    handshake_port = g_strdup_printf(handshake, port, port);
+    qobject_unref(qdict);
+
+    qemu_chr_fe_init(&be, chr, &error_abort);
+    qemu_chr_fe_set_handlers(&be, websock_server_can_read, websock_server_read,
+                             NULL, NULL, chr, NULL, true);
+
+    chr_client = qemu_chr_new("client", tmp);
+    qemu_chr_fe_init(&client_be, chr_client, &error_abort);
+    qemu_chr_fe_set_handlers(&client_be, websock_client_can_read,
+                             websock_client_read,
+                             NULL, NULL, chr_client, NULL, true);
+    g_free(tmp);
+
+    qemu_chr_write_all(chr_client,
+                       (uint8_t *) handshake_port,
+                       strlen(handshake_port));
+    g_free(handshake_port);
+    main_loop();
+
+    g_assert(object_property_get_bool(OBJECT(chr), "connected", &error_abort));
+    g_assert(object_property_get_bool(OBJECT(chr_client),
+                                      "connected", &error_abort));
+
+    qemu_chr_write_all(chr_client, close, sizeof(close));
+    main_loop();
+
+    object_unparent(OBJECT(chr_client));
+    object_unparent(OBJECT(chr));
+}
+
+
 #ifndef _WIN32
 static void char_pipe_test(void)
 {
@@ -829,6 +953,7 @@ int main(int argc, char **argv)
     g_test_add_func("/char/serial", char_serial_test);
 #endif
     g_test_add_func("/char/hotswap", char_hotswap_test);
+    g_test_add_func("/char/websocket", char_websock_test);
 
     return g_test_run();
 }
-- 
2.17.1
