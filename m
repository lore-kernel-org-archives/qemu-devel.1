Received: from eggs.gnu.org ([209.51.188.92]:39182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqQ-0002hy-82
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqP-0007kj-6s
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:10 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:39166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqO-0007jf-OM
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:09 -0500
Received: by mail-wr1-x435.google.com with SMTP id l12so1947945wrp.6
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:08 +0100
Message-Id: <1551979804-6060-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/57] chardev-socket: do not blindly reset
 handlers when switching GMainContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lviver@redhat.com

If the socket is connecting or connected, tcp_chr_update_read_handler will
be called but it should not set the NetListener's callbacks again.
Otherwise, tcp_chr_accept is invoked while the socket is in connected
state and you get an assertion failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c |   2 +-
 tests/test-char.c     | 102 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 4fcdd8a..6d287ba 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -632,7 +632,7 @@ static void tcp_chr_update_read_handler(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
-    if (s->listener) {
+    if (s->listener && s->state == TCP_CHARDEV_STATE_DISCONNECTED) {
         /*
          * It's possible that chardev context is changed in
          * qemu_chr_be_update_read_handlers().  Reset it for QIO net
diff --git a/tests/test-char.c b/tests/test-char.c
index 63b4d32..de32838 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1003,6 +1003,103 @@ static void char_socket_client_test(gconstpointer opaque)
     g_free(optstr);
 }
 
+static void
+count_closed_event(void *opaque, int event)
+{
+    int *count = opaque;
+    if (event == CHR_EVENT_CLOSED) {
+        (*count)++;
+    }
+}
+
+static void
+char_socket_discard_read(void *opaque, const uint8_t *buf, int size)
+{
+}
+
+static void char_socket_server_two_clients_test(gconstpointer opaque)
+{
+    SocketAddress *incoming_addr = (gpointer) opaque;
+    Chardev *chr;
+    CharBackend be = {0};
+    QObject *qaddr;
+    SocketAddress *addr;
+    Visitor *v;
+    char *optstr;
+    QemuOpts *opts;
+    QIOChannelSocket *ioc1, *ioc2;
+    int closed = 0;
+
+    g_setenv("QTEST_SILENT_ERRORS", "1", 1);
+    /*
+     * We rely on addr containing "nowait", otherwise
+     * qemu_chr_new() will block until a client connects. We
+     * can't spawn our client thread though, because until
+     * qemu_chr_new() returns we don't know what TCP port was
+     * allocated by the OS
+     */
+    optstr = char_socket_addr_to_opt_str(incoming_addr,
+                                         false,
+                                         NULL,
+                                         true);
+    opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
+                                   optstr, true);
+    g_assert_nonnull(opts);
+    chr = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    qemu_opts_del(opts);
+    g_assert_nonnull(chr);
+    g_assert(!object_property_get_bool(OBJECT(chr), "connected", &error_abort));
+
+    qaddr = object_property_get_qobject(OBJECT(chr), "addr", &error_abort);
+    g_assert_nonnull(qaddr);
+
+    v = qobject_input_visitor_new(qaddr);
+    visit_type_SocketAddress(v, "addr", &addr, &error_abort);
+    visit_free(v);
+    qobject_unref(qaddr);
+
+    qemu_chr_fe_init(&be, chr, &error_abort);
+
+    qemu_chr_fe_set_handlers(&be, char_socket_can_read, char_socket_discard_read,
+                             count_closed_event, NULL,
+                             &closed, NULL, true);
+
+    ioc1 = qio_channel_socket_new();
+    qio_channel_socket_connect_sync(ioc1, addr, &error_abort);
+    qemu_chr_wait_connected(chr, &error_abort);
+
+    /* switch the chardev to another context */
+    GMainContext *ctx = g_main_context_new();
+    qemu_chr_fe_set_handlers(&be, char_socket_can_read, char_socket_discard_read,
+                             count_closed_event, NULL,
+                             &closed, ctx, true);
+
+    /* Start a second connection while the first is still connected.
+     * It will be placed in the listen() backlog, and connect() will
+     * succeed immediately.
+     */
+    ioc2 = qio_channel_socket_new();
+    qio_channel_socket_connect_sync(ioc2, addr, &error_abort);
+
+    object_unref(OBJECT(ioc1));
+    /* The two connections should now be processed serially.  */
+    while (g_main_context_iteration(ctx, TRUE)) {
+        if (closed == 1 && ioc2) {
+            object_unref(OBJECT(ioc2));
+            ioc2 = NULL;
+        }
+        if (closed == 2) {
+            break;
+        }
+    }
+
+    qapi_free_SocketAddress(addr);
+    object_unparent(OBJECT(chr));
+    g_main_context_unref(ctx);
+    g_free(optstr);
+    g_unsetenv("QTEST_SILENT_ERRORS");
+}
+
 
 #ifdef HAVE_CHARDEV_SERIAL
 static void char_serial_test(void)
@@ -1342,12 +1439,15 @@ int main(int argc, char **argv)
 
     SOCKET_SERVER_TEST(tcp, &tcpaddr);
     SOCKET_CLIENT_TEST(tcp, &tcpaddr);
+    g_test_add_data_func("/char/socket/server/two-clients/tcp", &tcpaddr,
+                         char_socket_server_two_clients_test);
 #ifndef WIN32
     SOCKET_SERVER_TEST(unix, &unixaddr);
     SOCKET_CLIENT_TEST(unix, &unixaddr);
+    g_test_add_data_func("/char/socket/server/two-clients/unix", &unixaddr,
+                         char_socket_server_two_clients_test);
 #endif
 
-
     g_test_add_func("/char/udp", char_udp_test);
 #ifdef HAVE_CHARDEV_SERIAL
     g_test_add_func("/char/serial", char_serial_test);
-- 
1.8.3.1
