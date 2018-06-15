Received: from eggs.gnu.org ([2001:4830:134:3::10]:58816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTr0O-0008TH-SJ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTr0N-0006Zx-L2
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:16 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Jun 2018 16:50:58 +0100
Message-Id: <20180615155103.11924-2-berrange@redhat.com>
In-Reply-To: <20180615155103.11924-1-berrange@redhat.com>
References: <20180615155103.11924-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] qemu-nbd: add support for authorization of
 TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Currently any client which can complete the TLS handshake is able to use
the NBD server. The server admin can turn on the 'verify-peer' option
for the x509 creds to require the client to provide a x509 certificate.
This means the client will have to acquire a certificate from the CA
before they are permitted to use the NBD server. This is still a fairly
low bar to cross.

This adds a '--tls-authz OBJECT-ID' option to the qemu-nbd command which
takes the ID of a previously added 'QAuthZ' object instance. This will
be used to validate the client's x509 distinguished name. Clients
failing the authorization check will not be permitted to use the NBD
server.

For example to setup authorization that only allows connection from a client
whose x509 certificate distinguished name contains 'CN=fred', you would
use:

  qemu-nbd -object tls-creds-x509,id=tls0,dir=/home/berrange/qemutls,\
                   endpoint=server,verify-peer=yes \
           -object authz-simple,id=authz0,policy=deny,\
	           rules.0.match=*CN=fred,rules.0.policy=allow \
           -tls-creds tls0 \
           -tls-authz authz0
	   ....other qemu-nbd args...

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/block/nbd.h |  2 +-
 nbd/server.c        | 12 +++++++-----
 qemu-nbd.c          | 13 ++++++++++++-
 qemu-nbd.texi       |  4 ++++
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index fcdcd54502..80ea9d240c 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -307,7 +307,7 @@ void nbd_export_close_all(void);
 void nbd_client_new(NBDExport *exp,
                     QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
-                    const char *tlsaclname,
+                    const char *tlsauthz,
                     void (*close_fn)(NBDClient *, bool));
 void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);
diff --git a/nbd/server.c b/nbd/server.c
index 9e1f227178..579fc828e1 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -100,7 +100,7 @@ struct NBDClient {
 
     NBDExport *exp;
     QCryptoTLSCreds *tlscreds;
-    char *tlsaclname;
+    char *tlsauthz;
     QIOChannelSocket *sioc; /* The underlying data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */
 
@@ -677,7 +677,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
 
     tioc = qio_channel_tls_new_server(ioc,
                                       client->tlscreds,
-                                      client->tlsaclname,
+                                      client->tlsauthz,
                                       errp);
     if (!tioc) {
         return NULL;
@@ -1250,7 +1250,7 @@ void nbd_client_put(NBDClient *client)
         if (client->tlscreds) {
             object_unref(OBJECT(client->tlscreds));
         }
-        g_free(client->tlsaclname);
+        g_free(client->tlsauthz);
         if (client->exp) {
             QTAILQ_REMOVE(&client->exp->clients, client, next);
             nbd_export_put(client->exp);
@@ -2140,7 +2140,7 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 void nbd_client_new(NBDExport *exp,
                     QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
-                    const char *tlsaclname,
+                    const char *tlsauthz,
                     void (*close_fn)(NBDClient *, bool))
 {
     NBDClient *client;
@@ -2153,7 +2153,9 @@ void nbd_client_new(NBDExport *exp,
     if (tlscreds) {
         object_ref(OBJECT(client->tlscreds));
     }
-    client->tlsaclname = g_strdup(tlsaclname);
+    if (tlsauthz) {
+        client->tlsauthz = g_strdup(tlsauthz);
+    }
     client->sioc = sioc;
     object_ref(OBJECT(client->sioc));
     client->ioc = QIO_CHANNEL(sioc);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 51b9d38c72..c0c9c805c0 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -52,6 +52,7 @@
 #define QEMU_NBD_OPT_TLSCREDS      261
 #define QEMU_NBD_OPT_IMAGE_OPTS    262
 #define QEMU_NBD_OPT_FORK          263
+#define QEMU_NBD_OPT_TLSAUTHZ      264
 
 #define MBR_SIZE 512
 
@@ -66,6 +67,7 @@ static int shared = 1;
 static int nb_fds;
 static QIONetListener *server;
 static QCryptoTLSCreds *tlscreds;
+static const char *tlsauthz;
 
 static void usage(const char *name)
 {
@@ -355,7 +357,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
     nb_fds++;
     nbd_update_server_watch();
     nbd_client_new(newproto ? NULL : exp, cioc,
-                   tlscreds, NULL, nbd_client_closed);
+                   tlscreds, tlsauthz, nbd_client_closed);
 }
 
 static void nbd_update_server_watch(void)
@@ -533,6 +535,7 @@ int main(int argc, char **argv)
         { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
         { "trace", required_argument, NULL, 'T' },
         { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
+        { "tls-authz", no_argument, NULL, QEMU_NBD_OPT_TLSAUTHZ },
         { NULL, 0, NULL, 0 }
     };
     int ch;
@@ -755,6 +758,9 @@ int main(int argc, char **argv)
             g_free(trace_file);
             trace_file = trace_opt_parse(optarg);
             break;
+        case QEMU_NBD_OPT_TLSAUTHZ:
+            tlsauthz = optarg;
+            break;
         case QEMU_NBD_OPT_FORK:
             fork_process = true;
             break;
@@ -819,6 +825,11 @@ int main(int argc, char **argv)
                          error_get_pretty(local_err));
             exit(EXIT_FAILURE);
         }
+    } else {
+        if (tlsauthz) {
+            error_report("--tls-authz is not permitted without --tls-creds");
+            exit(EXIT_FAILURE);
+        }
     }
 
     if (disconnect) {
diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 9a84e81eed..8f16bfb513 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -91,6 +91,10 @@ of the TLS credentials object previously created with the --object
 option.
 @item --fork
 Fork off the server process and exit the parent once the server is running.
+@item --tls-authz=ID
+Specify the ID of a qauthz object previously created with the
+--object option. This will be used to authorize users who
+connect against their x509 distinguished name.
 @item -v, --verbose
 Display extra debugging information
 @item -h, --help
-- 
2.17.0
