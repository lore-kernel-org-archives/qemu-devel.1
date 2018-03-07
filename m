Received: from eggs.gnu.org ([2001:4830:134:3::10]:38125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXCl-0002NU-Cb
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXCj-0000S8-Nz
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:25:55 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  7 Mar 2018 11:25:31 +0000
Message-Id: <20180307112532.24248-6-berrange@redhat.com>
In-Reply-To: <20180307112532.24248-1-berrange@redhat.com>
References: <20180307112532.24248-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/6] qio: non-default context for async conn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

We have worked on qio_task_run_in_thread() already.  Further, let
all the qio channel APIs use that context.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c          |  4 ++--
 include/io/channel-socket.h    | 15 ++++++++++++---
 io/channel-socket.c            | 15 +++++++++------
 migration/socket.c             |  3 ++-
 tests/test-io-channel-socket.c |  4 ++--
 5 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 22f65971a1..b0d11387f3 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -867,7 +867,7 @@ static gboolean socket_reconnect_timeout(gpointer opa=
que)
     tcp_chr_set_client_ioc_name(chr, sioc);
     qio_channel_socket_connect_async(sioc, s->addr,
                                      qemu_chr_socket_connected,
-                                     chr, NULL);
+                                     chr, NULL, NULL);
=20
     return false;
 }
@@ -951,7 +951,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
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
@@ -101,6 +101,8 @@ int qio_channel_socket_connect_sync(QIOChannelSocket =
*ioc,
  * @callback: the function to invoke on completion
  * @opaque: user data to pass to @callback
  * @destroy: the function to free @opaque
+ * @context: the context to run the async task. If %NULL, the default
+ *           context will be used.
  *
  * Attempt to connect to the address @addr. This method
  * will run in the background so the caller will regain
@@ -113,7 +115,8 @@ void qio_channel_socket_connect_async(QIOChannelSocke=
t *ioc,
                                       SocketAddress *addr,
                                       QIOTaskFunc callback,
                                       gpointer opaque,
-                                      GDestroyNotify destroy);
+                                      GDestroyNotify destroy,
+                                      GMainContext *context);
=20
=20
 /**
@@ -138,6 +141,8 @@ int qio_channel_socket_listen_sync(QIOChannelSocket *=
ioc,
  * @callback: the function to invoke on completion
  * @opaque: user data to pass to @callback
  * @destroy: the function to free @opaque
+ * @context: the context to run the async task. If %NULL, the default
+ *           context will be used.
  *
  * Attempt to listen to the address @addr. This method
  * will run in the background so the caller will regain
@@ -150,7 +155,8 @@ void qio_channel_socket_listen_async(QIOChannelSocket=
 *ioc,
                                      SocketAddress *addr,
                                      QIOTaskFunc callback,
                                      gpointer opaque,
-                                     GDestroyNotify destroy);
+                                     GDestroyNotify destroy,
+                                     GMainContext *context);
=20
=20
 /**
@@ -179,6 +185,8 @@ int qio_channel_socket_dgram_sync(QIOChannelSocket *i=
oc,
  * @callback: the function to invoke on completion
  * @opaque: user data to pass to @callback
  * @destroy: the function to free @opaque
+ * @context: the context to run the async task. If %NULL, the default
+ *           context will be used.
  *
  * Attempt to initialize a datagram socket bound to
  * @localAddr and communicating with peer @remoteAddr.
@@ -194,7 +202,8 @@ void qio_channel_socket_dgram_async(QIOChannelSocket =
*ioc,
                                     SocketAddress *remoteAddr,
                                     QIOTaskFunc callback,
                                     gpointer opaque,
-                                    GDestroyNotify destroy);
+                                    GDestroyNotify destroy,
+                                    GMainContext *context);
=20
=20
 /**
diff --git a/io/channel-socket.c b/io/channel-socket.c
index b4d914b767..57cfb4d3a6 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -174,7 +174,8 @@ void qio_channel_socket_connect_async(QIOChannelSocke=
t *ioc,
                                       SocketAddress *addr,
                                       QIOTaskFunc callback,
                                       gpointer opaque,
-                                      GDestroyNotify destroy)
+                                      GDestroyNotify destroy,
+                                      GMainContext *context)
 {
     QIOTask *task =3D qio_task_new(
         OBJECT(ioc), callback, opaque, destroy);
@@ -189,7 +190,7 @@ void qio_channel_socket_connect_async(QIOChannelSocke=
t *ioc,
                            qio_channel_socket_connect_worker,
                            addrCopy,
                            (GDestroyNotify)qapi_free_SocketAddress,
-                           NULL);
+                           context);
 }
=20
=20
@@ -234,7 +235,8 @@ void qio_channel_socket_listen_async(QIOChannelSocket=
 *ioc,
                                      SocketAddress *addr,
                                      QIOTaskFunc callback,
                                      gpointer opaque,
-                                     GDestroyNotify destroy)
+                                     GDestroyNotify destroy,
+                                     GMainContext *context)
 {
     QIOTask *task =3D qio_task_new(
         OBJECT(ioc), callback, opaque, destroy);
@@ -248,7 +250,7 @@ void qio_channel_socket_listen_async(QIOChannelSocket=
 *ioc,
                            qio_channel_socket_listen_worker,
                            addrCopy,
                            (GDestroyNotify)qapi_free_SocketAddress,
-                           NULL);
+                           context);
 }
=20
=20
@@ -310,7 +312,8 @@ void qio_channel_socket_dgram_async(QIOChannelSocket =
*ioc,
                                     SocketAddress *remoteAddr,
                                     QIOTaskFunc callback,
                                     gpointer opaque,
-                                    GDestroyNotify destroy)
+                                    GDestroyNotify destroy,
+                                    GMainContext *context)
 {
     QIOTask *task =3D qio_task_new(
         OBJECT(ioc), callback, opaque, destroy);
@@ -325,7 +328,7 @@ void qio_channel_socket_dgram_async(QIOChannelSocket =
*ioc,
                            qio_channel_socket_dgram_worker,
                            data,
                            qio_channel_socket_dgram_worker_free,
-                           NULL);
+                           context);
 }
=20
=20
diff --git a/migration/socket.c b/migration/socket.c
index e090097077..8a93fb1af5 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -103,7 +103,8 @@ static void socket_start_outgoing_migration(Migration=
State *s,
                                      saddr,
                                      socket_outgoing_migration,
                                      data,
-                                     socket_connect_data_free);
+                                     socket_connect_data_free,
+                                     NULL);
     qapi_free_SocketAddress(saddr);
 }
=20
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socke=
t.c
index d357cd2a8e..b273fd3ba2 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -179,7 +179,7 @@ static void test_io_channel_setup_async(SocketAddress=
 *listen_addr,
     lioc =3D qio_channel_socket_new();
     qio_channel_socket_listen_async(
         lioc, listen_addr,
-        test_io_channel_complete, &data, NULL);
+        test_io_channel_complete, &data, NULL, NULL);
=20
     g_main_loop_run(data.loop);
     g_main_context_iteration(g_main_context_default(), FALSE);
@@ -200,7 +200,7 @@ static void test_io_channel_setup_async(SocketAddress=
 *listen_addr,
=20
     qio_channel_socket_connect_async(
         QIO_CHANNEL_SOCKET(*src), connect_addr,
-        test_io_channel_complete, &data, NULL);
+        test_io_channel_complete, &data, NULL, NULL);
=20
     g_main_loop_run(data.loop);
     g_main_context_iteration(g_main_context_default(), FALSE);
--=20
2.14.3
