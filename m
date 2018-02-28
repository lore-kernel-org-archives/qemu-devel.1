Received: from eggs.gnu.org ([2001:4830:134:3::10]:33608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxT-0008BX-Nb
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxS-0000lV-Mf
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47012 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqtxS-0000lK-Hz
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E81E87ABA
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:07:14 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Feb 2018 13:06:27 +0800
Message-Id: <20180228050633.7410-9-peterx@redhat.com>
In-Reply-To: <20180228050633.7410-1-peterx@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 08/14] chardev: allow telnet gsource to switch
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

It was originally created by qio_channel_add_watch() so it's always
assigning the task to main context.  Now we use the new API called
qio_channel_add_watch_full() so that we get the GSource handle rather
than the tag ID.

Meanwhile, caching the gsource in SocketChardev.telnet_source so that we
can also do dynamic context switch when update read handlers.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 8f0935cd15..a16d894c40 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -59,6 +59,7 @@ typedef struct {
     bool is_listen;
     bool is_telnet;
     bool is_tn3270;
+    GSource *telnet_source;
 
     GSource *reconnect_timer;
     int64_t reconnect_time;
@@ -69,6 +70,7 @@ typedef struct {
     OBJECT_CHECK(SocketChardev, (obj), TYPE_CHARDEV_SOCKET)
 
 static gboolean socket_reconnect_timeout(gpointer opaque);
+static void tcp_chr_telnet_init(Chardev *chr);
 
 static void tcp_chr_reconn_timer_cancel(SocketChardev *s)
 {
@@ -555,6 +557,15 @@ static void tcp_chr_connect(void *opaque)
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
@@ -568,6 +579,11 @@ static void tcp_chr_update_read_handler(Chardev *chr)
         qio_net_listener_set_context(s->listener, chr->gcontext);
     }
 
+    if (s->telnet_source) {
+        tcp_chr_telnet_destroy(s);
+        tcp_chr_telnet_init(CHARDEV(s));
+    }
+
     if (!s->connected) {
         return;
     }
@@ -592,6 +608,7 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
                                        gpointer user_data)
 {
     TCPChardevTelnetInit *init = user_data;
+    SocketChardev *s = SOCKET_CHARDEV(init->chr);
     ssize_t ret;
 
     ret = qio_channel_write(ioc, init->buf, init->buflen, NULL);
@@ -616,6 +633,8 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
 
 end:
     g_free(init);
+    g_source_unref(s->telnet_source);
+    s->telnet_source = NULL;
     return G_SOURCE_REMOVE;
 }
 
@@ -655,10 +674,10 @@ static void tcp_chr_telnet_init(Chardev *chr)
 
 #undef IACSET
 
-    qio_channel_add_watch(
-        s->ioc, G_IO_OUT,
-        tcp_chr_telnet_init_io,
-        init, NULL);
+    s->telnet_source = qio_channel_add_watch_full(s->ioc, G_IO_OUT,
+                                                  tcp_chr_telnet_init_io,
+                                                  init, NULL,
+                                                  chr->gcontext);
 }
 
 
@@ -831,6 +850,7 @@ static void char_socket_finalize(Object *obj)
     tcp_chr_free_connection(chr);
     tcp_chr_reconn_timer_cancel(s);
     qapi_free_SocketAddress(s->addr);
+    tcp_chr_telnet_destroy(s);
     if (s->listener) {
         qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
         object_unref(OBJECT(s->listener));
-- 
2.14.3
