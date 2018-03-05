Received: from eggs.gnu.org ([2001:4830:134:3::10]:45580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjqo-00034c-So
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjqi-00068C-MJ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53396 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1esjqi-00067b-Gw
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17D8B40FB64A
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 06:43:52 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  5 Mar 2018 14:43:23 +0800
Message-Id: <20180305064324.9238-6-peterx@redhat.com>
In-Reply-To: <20180305064324.9238-1-peterx@redhat.com>
References: <20180305064324.9238-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/6] qio: non-default context for async conn
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

We have worked on qio_task_run_in_thread() already.  Further, let
all the qio channel APIs use that context.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c          |  4 ++--
 include/io/channel-socket.h    | 15 ++++++++++++---
 io/channel-socket.c            | 15 +++++++++------
 migration/socket.c             |  3 ++-
 tests/test-io-channel-socket.c |  4 ++--
 5 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index bdd6cff5f6..754d82679a 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -866,7 +866,7 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
     tcp_chr_set_client_ioc_name(chr, sioc);
     qio_channel_socket_connect_async(sioc, s->addr,
                                      qemu_chr_socket_connected,
-                                     chr, NULL);
+                                     chr, NULL, NULL);
 
     return false;
 }
@@ -950,7 +950,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
         tcp_chr_set_client_ioc_name(chr, sioc);
         qio_channel_socket_connect_async(sioc, s->addr,
                                          qemu_chr_socket_connected,
-                                         chr, NULL);
+                                         chr, NULL, NULL);
     } else {
         if (s->is_listen) {
             char *name;
diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index 53801f6042..d7134d2cd6 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -101,6 +101,8 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
  * @callback: the function to invoke on completion
  * @opaque: user data to pass to @callback
  * @destroy: the function to free @opaque
+ * @context: the context to run the async task. If %NULL, the default
+ *           context will be used.
  *
  * Attempt to connect to the address @addr. This method
  * will run in the background so the caller will regain
@@ -113,7 +115,8 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
                                       SocketAddress *addr,
                                       QIOTaskFunc callback,
                                       gpointer opaque,
-                                      GDestroyNotify destroy);
+                                      GDestroyNotify destroy,
+                                      GMainContext *context);
 
 
 /**
@@ -138,6 +141,8 @@ int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
  * @callback: the function to invoke on completion
  * @opaque: user data to pass to @callback
  * @destroy: the function to free @opaque
+ * @context: the context to run the async task. If %NULL, the default
+ *           context will be used.
  *
  * Attempt to listen to the address @addr. This method
  * will run in the background so the caller will regain
@@ -150,7 +155,8 @@ void qio_channel_socket_listen_async(QIOChannelSocket *ioc,
                                      SocketAddress *addr,
                                      QIOTaskFunc callback,
                                      gpointer opaque,
-                                     GDestroyNotify destroy);
+                                     GDestroyNotify destroy,
+                                     GMainContext *context);
 
 
 /**
@@ -179,6 +185,8 @@ int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
  * @callback: the function to invoke on completion
  * @opaque: user data to pass to @callback
  * @destroy: the function to free @opaque
+ * @context: the context to run the async task. If %NULL, the default
+ *           context will be used.
  *
  * Attempt to initialize a datagram socket bound to
  * @localAddr and communicating with peer @remoteAddr.
@@ -194,7 +202,8 @@ void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
                                     SocketAddress *remoteAddr,
                                     QIOTaskFunc callback,
                                     gpointer opaque,
-                                    GDestroyNotify destroy);
+                                    GDestroyNotify destroy,
+                                    GMainContext *context);
 
 
 /**
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 4224ce323a..18c139c365 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -173,7 +173,8 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
                                       SocketAddress *addr,
                                       QIOTaskFunc callback,
                                       gpointer opaque,
-                                      GDestroyNotify destroy)
+                                      GDestroyNotify destroy,
+                                      GMainContext *context)
 {
     QIOTask *task = qio_task_new(
         OBJECT(ioc), callback, opaque, destroy);
@@ -188,7 +189,7 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
                            qio_channel_socket_connect_worker,
                            addrCopy,
                            (GDestroyNotify)qapi_free_SocketAddress,
-                           NULL);
+                           context);
 }
 
 
@@ -233,7 +234,8 @@ void qio_channel_socket_listen_async(QIOChannelSocket *ioc,
                                      SocketAddress *addr,
                                      QIOTaskFunc callback,
                                      gpointer opaque,
-                                     GDestroyNotify destroy)
+                                     GDestroyNotify destroy,
+                                     GMainContext *context)
 {
     QIOTask *task = qio_task_new(
         OBJECT(ioc), callback, opaque, destroy);
@@ -247,7 +249,7 @@ void qio_channel_socket_listen_async(QIOChannelSocket *ioc,
                            qio_channel_socket_listen_worker,
                            addrCopy,
                            (GDestroyNotify)qapi_free_SocketAddress,
-                           NULL);
+                           context);
 }
 
 
@@ -309,7 +311,8 @@ void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
                                     SocketAddress *remoteAddr,
                                     QIOTaskFunc callback,
                                     gpointer opaque,
-                                    GDestroyNotify destroy)
+                                    GDestroyNotify destroy,
+                                    GMainContext *context)
 {
     QIOTask *task = qio_task_new(
         OBJECT(ioc), callback, opaque, destroy);
@@ -324,7 +327,7 @@ void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
                            qio_channel_socket_dgram_worker,
                            data,
                            qio_channel_socket_dgram_worker_free,
-                           NULL);
+                           context);
 }
 
 
diff --git a/migration/socket.c b/migration/socket.c
index e090097077..8a93fb1af5 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -103,7 +103,8 @@ static void socket_start_outgoing_migration(MigrationState *s,
                                      saddr,
                                      socket_outgoing_migration,
                                      data,
-                                     socket_connect_data_free);
+                                     socket_connect_data_free,
+                                     NULL);
     qapi_free_SocketAddress(saddr);
 }
 
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
index d357cd2a8e..b273fd3ba2 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -179,7 +179,7 @@ static void test_io_channel_setup_async(SocketAddress *listen_addr,
     lioc = qio_channel_socket_new();
     qio_channel_socket_listen_async(
         lioc, listen_addr,
-        test_io_channel_complete, &data, NULL);
+        test_io_channel_complete, &data, NULL, NULL);
 
     g_main_loop_run(data.loop);
     g_main_context_iteration(g_main_context_default(), FALSE);
@@ -200,7 +200,7 @@ static void test_io_channel_setup_async(SocketAddress *listen_addr,
 
     qio_channel_socket_connect_async(
         QIO_CHANNEL_SOCKET(*src), connect_addr,
-        test_io_channel_complete, &data, NULL);
+        test_io_channel_complete, &data, NULL, NULL);
 
     g_main_loop_run(data.loop);
     g_main_context_iteration(g_main_context_default(), FALSE);
-- 
2.14.3
