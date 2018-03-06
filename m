Received: from eggs.gnu.org ([2001:4830:134:3::10]:41474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5EQ-0000vh-6W
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5EP-0006l4-2S
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1et5EO-0006kt-TN
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 785648182D1E
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 05:33:44 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Mar 2018 13:33:15 +0800
Message-Id: <20180306053320.15401-5-peterx@redhat.com>
In-Reply-To: <20180306053320.15401-1-peterx@redhat.com>
References: <20180306053320.15401-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/9] chardev: allow telnet gsource to switch
 gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

It was originally created by qio_channel_add_watch() so it's always
assigning the task to main context.  Now we use the new API called
qio_channel_add_watch_source() so that we get the GSource handle rather
than the tag ID.

Meanwhile, caching the gsource and TCPChardevTelnetInit (which holds the
handshake data) in SocketChardev.telnet_source so that we can also do
dynamic context switch when update read handlers.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c | 67 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 5aa01e15ff..c22b3f330c 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -39,6 +39,11 @@
 
 #define TCP_MAX_FDS 16
 
+typedef struct {
+    char buf[21];
+    size_t buflen;
+} TCPChardevTelnetInit;
+
 typedef struct {
     Chardev parent;
     QIOChannel *ioc; /* Client I/O channel */
@@ -59,6 +64,8 @@ typedef struct {
     bool is_listen;
     bool is_telnet;
     bool is_tn3270;
+    GSource *telnet_source;
+    TCPChardevTelnetInit *telnet_init;
 
     GSource *reconnect_timer;
     int64_t reconnect_time;
@@ -69,6 +76,7 @@ typedef struct {
     OBJECT_CHECK(SocketChardev, (obj), TYPE_CHARDEV_SOCKET)
 
 static gboolean socket_reconnect_timeout(gpointer opaque);
+static void tcp_chr_telnet_init(Chardev *chr);
 
 static void tcp_chr_reconn_timer_cancel(SocketChardev *s)
 {
@@ -555,6 +563,15 @@ static void tcp_chr_connect(void *opaque)
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
+static void tcp_chr_telnet_destroy(SocketChardev *s)
+{
+    if (s->telnet_source) {
+        g_source_destroy(s->telnet_source);
+        g_source_unref(s->telnet_source);
+        s->telnet_source = NULL;
+    }
+}
+
 static void tcp_chr_update_read_handler(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
@@ -569,6 +586,10 @@ static void tcp_chr_update_read_handler(Chardev *chr)
                                               chr, NULL, chr->gcontext);
     }
 
+    if (s->telnet_source) {
+        tcp_chr_telnet_init(CHARDEV(s));
+    }
+
     if (!s->connected) {
         return;
     }
@@ -582,32 +603,30 @@ static void tcp_chr_update_read_handler(Chardev *chr)
     }
 }
 
-typedef struct {
-    Chardev *chr;
-    char buf[21];
-    size_t buflen;
-} TCPChardevTelnetInit;
-
 static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
                                        GIOCondition cond G_GNUC_UNUSED,
                                        gpointer user_data)
 {
-    TCPChardevTelnetInit *init = user_data;
+    SocketChardev *s = user_data;
+    Chardev *chr = CHARDEV(s);
+    TCPChardevTelnetInit *init = s->telnet_init;
     ssize_t ret;
 
+    assert(init);
+
     ret = qio_channel_write(ioc, init->buf, init->buflen, NULL);
     if (ret < 0) {
         if (ret == QIO_CHANNEL_ERR_BLOCK) {
             ret = 0;
         } else {
-            tcp_chr_disconnect(init->chr);
+            tcp_chr_disconnect(chr);
             goto end;
         }
     }
     init->buflen -= ret;
 
     if (init->buflen == 0) {
-        tcp_chr_connect(init->chr);
+        tcp_chr_connect(chr);
         goto end;
     }
 
@@ -616,16 +635,30 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
     return G_SOURCE_CONTINUE;
 
 end:
-    g_free(init);
+    g_free(s->telnet_init);
+    s->telnet_init = NULL;
+    g_source_unref(s->telnet_source);
+    s->telnet_source = NULL;
     return G_SOURCE_REMOVE;
 }
 
 static void tcp_chr_telnet_init(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
-    TCPChardevTelnetInit *init = g_new0(TCPChardevTelnetInit, 1);
+    TCPChardevTelnetInit *init;
     size_t n = 0;
 
+    /* Destroy existing task */
+    tcp_chr_telnet_destroy(s);
+
+    if (s->telnet_init) {
+        /* We are possibly during a handshake already */
+        goto cont;
+    }
+
+    s->telnet_init = g_new0(TCPChardevTelnetInit, 1);
+    init = s->telnet_init;
+
 #define IACSET(x, a, b, c)                      \
     do {                                        \
         x[n++] = a;                             \
@@ -633,7 +666,6 @@ static void tcp_chr_telnet_init(Chardev *chr)
         x[n++] = c;                             \
     } while (0)
 
-    init->chr = chr;
     if (!s->is_tn3270) {
         init->buflen = 12;
         /* Prep the telnet negotion to put telnet in binary,
@@ -656,10 +688,11 @@ static void tcp_chr_telnet_init(Chardev *chr)
 
 #undef IACSET
 
-    qio_channel_add_watch(
-        s->ioc, G_IO_OUT,
-        tcp_chr_telnet_init_io,
-        init, NULL);
+cont:
+    s->telnet_source = qio_channel_add_watch_source(s->ioc, G_IO_OUT,
+                                                    tcp_chr_telnet_init_io,
+                                                    s, NULL,
+                                                    chr->gcontext);
 }
 
 
@@ -834,6 +867,8 @@ static void char_socket_finalize(Object *obj)
     tcp_chr_free_connection(chr);
     tcp_chr_reconn_timer_cancel(s);
     qapi_free_SocketAddress(s->addr);
+    tcp_chr_telnet_destroy(s);
+    g_free(s->telnet_init);
     if (s->listener) {
         qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
                                               NULL, chr->gcontext);
-- 
2.14.3
