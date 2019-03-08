Received: from eggs.gnu.org ([209.51.188.92]:41144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2JTc-0001c7-ES
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2JTb-0002QM-Gz
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:40:08 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  8 Mar 2019 11:39:56 -0600
Message-Id: <20190308173958.20618-3-eblake@redhat.com>
In-Reply-To: <20190308173958.20618-1-eblake@redhat.com>
References: <20190308173958.20618-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] nbd: allow authorization with
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: "Daniel P. Berrange" <berrange@redhat.com>

As with the previous patch to qemu-nbd, the nbd-server-start QMP command
also needs to be able to specify authorization when enabling TLS encrypti=
on.

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
             'match': '*CN=3Dfred',
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20190227162035.18543-3-berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block.json     |  8 +++++++-
 include/block/nbd.h |  2 +-
 blockdev-nbd.c      | 11 ++++++++---
 hmp.c               |  2 +-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 5a79d639e8c..79623088e72 100644
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
+#             If missing, it will default to denying access (since 4.0).
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
diff --git a/include/block/nbd.h b/include/block/nbd.h
index b742ec4a89b..6d05983a55f 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -332,7 +332,7 @@ void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);

 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
-                      Error **errp);
+                      const char *tls_authz, Error **errp);

 /* nbd_read
  * Reads @size bytes from @ioc. Returns 0 on success.
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index d73ac1b026a..66eebab3187 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -23,6 +23,7 @@
 typedef struct NBDServerData {
     QIONetListener *listener;
     QCryptoTLSCreds *tlscreds;
+    char *tlsauthz;
 } NBDServerData;

 static NBDServerData *nbd_server;
@@ -36,7 +37,7 @@ static void nbd_accept(QIONetListener *listener, QIOCha=
nnelSocket *cioc,
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
@@ -87,7 +89,7 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char *i=
d, Error **errp)


 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
-                      Error **errp)
+                      const char *tls_authz, Error **errp)
 {
     if (nbd_server) {
         error_setg(errp, "NBD server already running");
@@ -117,6 +119,8 @@ void nbd_server_start(SocketAddress *addr, const char=
 *tls_creds,
         }
     }

+    nbd_server->tlsauthz =3D g_strdup(tls_authz);
+
     qio_net_listener_set_client_func(nbd_server->listener,
                                      nbd_accept,
                                      NULL,
@@ -131,11 +135,12 @@ void nbd_server_start(SocketAddress *addr, const ch=
ar *tls_creds,

 void qmp_nbd_server_start(SocketAddressLegacy *addr,
                           bool has_tls_creds, const char *tls_creds,
+                          bool has_tls_authz, const char *tls_authz,
                           Error **errp)
 {
     SocketAddress *addr_flat =3D socket_address_flatten(addr);

-    nbd_server_start(addr_flat, tls_creds, errp);
+    nbd_server_start(addr_flat, tls_creds, tls_authz, errp);
     qapi_free_SocketAddress(addr_flat);
 }

diff --git a/hmp.c b/hmp.c
index c2ad3f8251e..4a702d5b977 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2373,7 +2373,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict=
 *qdict)
         goto exit;
     }

-    nbd_server_start(addr, NULL, &local_err);
+    nbd_server_start(addr, NULL, NULL, &local_err);
     qapi_free_SocketAddress(addr);
     if (local_err !=3D NULL) {
         goto exit;
--=20
2.20.1
