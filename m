Received: from eggs.gnu.org ([2001:4830:134:3::10]:56809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhym-00054j-RH
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyi-0007Qf-K4
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:28 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:43969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyi-0007QA-DM
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:24 -0500
Received: by mail-wr0-x241.google.com with SMTP id w68so10470396wrc.10
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:56 +0100
Message-Id: <1513790098-9815-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 44/46] blockdev: convert internal NBD server to
 QIONetListener
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

Instead of creating a QIOChannelSocket directly for the NBD
server socket, use a QIONetListener. This provides the ability
to listen on multiple sockets at the same time, so enables
full support for IPv4/IPv6 dual stack.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20171218101643.20360-2-berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockdev-nbd.c | 50 ++++++++++++++++----------------------------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 28f551a..9e3c221 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -18,10 +18,10 @@
 #include "qmp-commands.h"
 #include "block/nbd.h"
 #include "io/channel-socket.h"
+#include "io/net-listener.h"
 
 typedef struct NBDServerData {
-    QIOChannelSocket *listen_ioc;
-    int watch;
+    QIONetListener *listener;
     QCryptoTLSCreds *tlscreds;
 } NBDServerData;
 
@@ -32,27 +32,13 @@ static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
     nbd_client_put(client);
 }
 
-static gboolean nbd_accept(QIOChannel *ioc, GIOCondition condition,
-                           gpointer opaque)
+static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
+                       gpointer opaque)
 {
-    QIOChannelSocket *cioc;
-
-    if (!nbd_server) {
-        return FALSE;
-    }
-
-    cioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
-                                     NULL);
-    if (!cioc) {
-        return TRUE;
-    }
-
     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
     nbd_client_new(NULL, cioc,
                    nbd_server->tlscreds, NULL,
                    nbd_blockdev_client_closed);
-    object_unref(OBJECT(cioc));
-    return TRUE;
 }
 
 
@@ -62,10 +48,8 @@ static void nbd_server_free(NBDServerData *server)
         return;
     }
 
-    if (server->watch != -1) {
-        g_source_remove(server->watch);
-    }
-    object_unref(OBJECT(server->listen_ioc));
+    qio_net_listener_disconnect(server->listener);
+    object_unref(OBJECT(server->listener));
     if (server->tlscreds) {
         object_unref(OBJECT(server->tlscreds));
     }
@@ -112,12 +96,12 @@ void nbd_server_start(SocketAddress *addr, const char *tls_creds,
     }
 
     nbd_server = g_new0(NBDServerData, 1);
-    nbd_server->watch = -1;
-    nbd_server->listen_ioc = qio_channel_socket_new();
-    qio_channel_set_name(QIO_CHANNEL(nbd_server->listen_ioc),
-                         "nbd-listener");
-    if (qio_channel_socket_listen_sync(
-            nbd_server->listen_ioc, addr, errp) < 0) {
+    nbd_server->listener = qio_net_listener_new();
+
+    qio_net_listener_set_name(nbd_server->listener,
+                              "nbd-listener");
+
+    if (qio_net_listener_open_sync(nbd_server->listener, addr, errp) < 0) {
         goto error;
     }
 
@@ -134,12 +118,10 @@ void nbd_server_start(SocketAddress *addr, const char *tls_creds,
         }
     }
 
-    nbd_server->watch = qio_channel_add_watch(
-        QIO_CHANNEL(nbd_server->listen_ioc),
-        G_IO_IN,
-        nbd_accept,
-        NULL,
-        NULL);
+    qio_net_listener_set_client_func(nbd_server->listener,
+                                     nbd_accept,
+                                     NULL,
+                                     NULL);
 
     return;
 
-- 
1.8.3.1
