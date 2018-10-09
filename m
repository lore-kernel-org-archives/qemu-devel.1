Received: from eggs.gnu.org ([2001:4830:134:3::10]:53111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rzo-0005xD-83
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rzc-00032f-2b
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:24:18 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  9 Oct 2018 14:23:26 +0100
Message-Id: <20181009132330.7549-3-berrange@redhat.com>
In-Reply-To: <20181009132330.7549-1-berrange@redhat.com>
References: <20181009132330.7549-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/6] nbd: allow authorization with
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

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
 blockdev-nbd.c      | 11 ++++++++---
 hmp.c               |  2 +-
 include/block/nbd.h |  2 +-
 qapi/block.json     |  8 +++++++-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 1d170c80b8..c10d6c0c81 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -23,6 +23,7 @@
 typedef struct NBDServerData {
     QIONetListener *listener;
     QCryptoTLSCreds *tlscreds;
+    char *tlsauthz;
 } NBDServerData;
 
 static NBDServerData *nbd_server;
@@ -36,7 +37,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
                        gpointer opaque)
 {
     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
-    nbd_client_new(cioc, nbd_server->tlscreds, NULL,
+    nbd_client_new(cioc, nbd_server->tlscreds, nbd_server->tlsauthz,
                    nbd_blockdev_client_closed);
 }
 
@@ -52,6 +53,7 @@ static void nbd_server_free(NBDServerData *server)
     if (server->tlscreds) {
         object_unref(OBJECT(server->tlscreds));
     }
+    g_free(server->tlsauthz);
 
     g_free(server);
 }
@@ -87,7 +89,7 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
 
 
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
-                      Error **errp)
+                      const char *tls_authz, Error **errp)
 {
     if (nbd_server) {
         error_setg(errp, "NBD server already running");
@@ -117,6 +119,8 @@ void nbd_server_start(SocketAddress *addr, const char *tls_creds,
         }
     }
 
+    nbd_server->tlsauthz = g_strdup(tls_authz);
+
     qio_net_listener_set_client_func(nbd_server->listener,
                                      nbd_accept,
                                      NULL,
@@ -131,11 +135,12 @@ void nbd_server_start(SocketAddress *addr, const char *tls_creds,
 
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
index 61ef120423..7fc5a6502f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2300,7 +2300,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
         goto exit;
     }
 
-    nbd_server_start(addr, NULL, &local_err);
+    nbd_server_start(addr, NULL, NULL, &local_err);
     qapi_free_SocketAddress(addr);
     if (local_err != NULL) {
         goto exit;
diff --git a/include/block/nbd.h b/include/block/nbd.h
index d7aa6b24d0..6cb336b45a 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -318,7 +318,7 @@ void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);
 
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
-                      Error **errp);
+                      const char *tls_authz, Error **errp);
 
 void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
                        const char *bitmap_export_name, Error **errp);
diff --git a/qapi/block.json b/qapi/block.json
index 11f01f28ef..812a9b1917 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -225,6 +225,11 @@
 #
 # @addr: Address on which to listen.
 # @tls-creds: (optional) ID of the TLS credentials object. Since 2.6
+# @tls-authz: ID of the QAuthZ authorization object used to validate
+#             the client's x509 distinguished name. This object is
+#             is only resolved at time of use, so can be deleted and
+#             recreated on the fly while the NBD server is active.
+#             If missing, it will default to denying access. Since 3.1
 #
 # Returns: error if the server is already running.
 #
@@ -232,7 +237,8 @@
 ##
 { 'command': 'nbd-server-start',
   'data': { 'addr': 'SocketAddressLegacy',
-            '*tls-creds': 'str'} }
+            '*tls-creds': 'str',
+            '*tls-authz': 'str'} }
 
 ##
 # @nbd-server-add:
-- 
2.17.1
