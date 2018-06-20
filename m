Received: from eggs.gnu.org ([2001:4830:134:3::10]:36703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVc0Q-0000Uf-Sx
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVc0P-0008Fm-JW
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:34 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 20 Jun 2018 13:14:19 +0100
Message-Id: <20180620121423.16979-3-berrange@redhat.com>
In-Reply-To: <20180620121423.16979-1-berrange@redhat.com>
References: <20180620121423.16979-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/6] nbd: allow authorization with
 nbd-server-start QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

As with the previous patch to qemu-nbd, the nbd-server-start QMP command
also needs to be able to specify authorization when enabling TLS encryption.

First the client must create a QAuthZ object instance using the
'object-add' command:

   {
     'execute': 'object-add',
     'arguments': {
       'qom-type': 'authz-list',
       'id': 'authz0',
       'parameters': {
         'policy': 'deny',
         'rules': [
           {
             'match': '*CN=fred',
             'policy': 'allow'
           }
         ]
       }
     }
   }

They can then reference this in the new 'tls-authz' parameter when
executing the 'nbd-server-start' command:

   {
     'execute': 'nbd-server-start',
     'arguments': {
       'addr': {
           'type': 'inet',
           'host': '127.0.0.1',
           'port': '9000'
       },
       'tls-creds': 'tls0',
       'tls-authz': 'authz0'
     }
   }

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 blockdev-nbd.c      | 12 +++++++++---
 hmp.c               |  2 +-
 include/block/nbd.h |  2 +-
 qapi/block.json     |  8 +++++++-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 65a84739ed..2627379ede 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -23,6 +23,7 @@
 typedef struct NBDServerData {
     QIONetListener *listener;
     QCryptoTLSCreds *tlscreds;
+    char *tlsauthz;
 } NBDServerData;
 
 static NBDServerData *nbd_server;
@@ -37,7 +38,8 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
 {
     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
     nbd_client_new(NULL, cioc,
-                   nbd_server->tlscreds, NULL,
+                   nbd_server->tlscreds,
+                   nbd_server->tlsauthz,
                    nbd_blockdev_client_closed);
 }
 
@@ -53,6 +55,7 @@ static void nbd_server_free(NBDServerData *server)
     if (server->tlscreds) {
         object_unref(OBJECT(server->tlscreds));
     }
+    g_free(server->tlsauthz);
 
     g_free(server);
 }
@@ -88,7 +91,7 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
 
 
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
-                      Error **errp)
+                      const char *tls_authz, Error **errp)
 {
     if (nbd_server) {
         error_setg(errp, "NBD server already running");
@@ -118,6 +121,8 @@ void nbd_server_start(SocketAddress *addr, const char *tls_creds,
         }
     }
 
+    nbd_server->tlsauthz = g_strdup(tls_authz);
+
     qio_net_listener_set_client_func(nbd_server->listener,
                                      nbd_accept,
                                      NULL,
@@ -132,11 +137,12 @@ void nbd_server_start(SocketAddress *addr, const char *tls_creds,
 
 void qmp_nbd_server_start(SocketAddressLegacy *addr,
                           bool has_tls_creds, const char *tls_creds,
+                          bool has_tls_authz, const char *tls_authz,
                           Error **errp)
 {
     SocketAddress *addr_flat = socket_address_flatten(addr);
 
-    nbd_server_start(addr_flat, tls_creds, errp);
+    nbd_server_start(addr_flat, tls_creds, tls_authz, errp);
     qapi_free_SocketAddress(addr_flat);
 }
 
diff --git a/hmp.c b/hmp.c
index f40d8279cf..b93a871830 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2221,7 +2221,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
         goto exit;
     }
 
-    nbd_server_start(addr, NULL, &local_err);
+    nbd_server_start(addr, NULL, NULL, &local_err);
     qapi_free_SocketAddress(addr);
     if (local_err != NULL) {
         goto exit;
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 80ea9d240c..8a8ae8c3a7 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -313,7 +313,7 @@ void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);
 
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
-                      Error **errp);
+                      const char *tls_authz, Error **errp);
 
 
 /* nbd_read
diff --git a/qapi/block.json b/qapi/block.json
index c694524002..9403d45d20 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -197,6 +197,11 @@
 #
 # @addr: Address on which to listen.
 # @tls-creds: (optional) ID of the TLS credentials object. Since 2.6
+# @tls-authz: ID of the QAuthZ authorization object used to validate
+#             the client's x509 distinguished name. This object is
+#             is only resolved at time of use, so can be deleted and
+#             recreated on the fly while the NBD server is active.
+#             If missing, it will default to denying access. Since 3.0
 #
 # Returns: error if the server is already running.
 #
@@ -204,7 +209,8 @@
 ##
 { 'command': 'nbd-server-start',
   'data': { 'addr': 'SocketAddressLegacy',
-            '*tls-creds': 'str'} }
+            '*tls-creds': 'str',
+            '*tls-authz': 'str'} }
 
 ##
 # @nbd-server-add:
-- 
2.17.0
