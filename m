Received: from eggs.gnu.org ([2001:4830:134:3::10]:37340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1f74Kw-000583-Ko
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 15:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1f74Kv-0001qh-0T
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 15:26:18 -0400
From: Nir Soffer <nirsof@gmail.com>
Date: Fri, 13 Apr 2018 22:26:03 +0300
Message-Id: <20180413192605.2145-2-nirsof@gmail.com>
In-Reply-To: <20180413192605.2145-1-nirsof@gmail.com>
References: <20180413192605.2145-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] nbd: Add option to disallow listing exports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, rjones@redhat.com, qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>

When a management application expose images using qemu-nbd, it needs a
secure way to allow temporary access to the disk. Using a random export
name can solve this problem:

    nbd://server:10809/22965f19-9ab5-4d18-94e1-cbeb321fa433

Assuming that the url is passed to the user in a secure way, and the
user is using TLS to access the image.

However, since qemu-nbd implements NBD_OPT_LIST, anyone can easily find
the secret export:

    $ nbd-client -l server 10809
    Negotiation: ..
    22965f19-9ab5-4d18-94e1-cbeb321fa433

Add a new --nolist option, disabling listing, similar the "allowlist"
nbd-server configuration option.

When used, listing exports will fail like this:

    $ nbd-client -l localhost 10809
    Negotiation: ..

    E: listing not allowed by server.
    Server said: Listing exports is forbidden

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 blockdev-nbd.c      | 2 +-
 include/block/nbd.h | 1 +
 nbd/server.c        | 7 +++++++
 qemu-nbd.c          | 9 ++++++++-
 qemu-nbd.texi       | 2 ++
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 65a84739ed..b9a885dc4b 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -37,7 +37,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
 {
     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
     nbd_client_new(NULL, cioc,
-                   nbd_server->tlscreds, NULL,
+                   nbd_server->tlscreds, NULL, true,
                    nbd_blockdev_client_closed);
 }
 
diff --git a/include/block/nbd.h b/include/block/nbd.h
index fcdcd54502..5c6b6272a0 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -308,6 +308,7 @@ void nbd_client_new(NBDExport *exp,
                     QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsaclname,
+                    bool allow_list,
                     void (*close_fn)(NBDClient *, bool));
 void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);
diff --git a/nbd/server.c b/nbd/server.c
index 9e1f227178..7b91922d1d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -115,6 +115,7 @@ struct NBDClient {
 
     bool structured_reply;
     NBDExportMetaContexts export_meta;
+    bool allow_list;
 
     uint32_t opt; /* Current option being negotiated */
     uint32_t optlen; /* remaining length of data in ioc for the option being
@@ -1032,6 +1033,10 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
             case NBD_OPT_LIST:
                 if (length) {
                     ret = nbd_reject_length(client, false, errp);
+                } else if (!client->allow_list) {
+                    ret = nbd_negotiate_send_rep_err(client,
+                                                     NBD_REP_ERR_POLICY, errp,
+                                                     "Listing exports is forbidden");
                 } else {
                     ret = nbd_negotiate_handle_list(client, errp);
                 }
@@ -2141,6 +2146,7 @@ void nbd_client_new(NBDExport *exp,
                     QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsaclname,
+                    bool allow_list,
                     void (*close_fn)(NBDClient *, bool))
 {
     NBDClient *client;
@@ -2158,6 +2164,7 @@ void nbd_client_new(NBDExport *exp,
     object_ref(OBJECT(client->sioc));
     client->ioc = QIO_CHANNEL(sioc);
     object_ref(OBJECT(client->ioc));
+    client->allow_list = allow_list;
     client->close_fn = close_fn;
 
     co = qemu_coroutine_create(nbd_co_client_start, client);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 0af0560ad1..b63d4d9e8b 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -52,6 +52,7 @@
 #define QEMU_NBD_OPT_TLSCREDS      261
 #define QEMU_NBD_OPT_IMAGE_OPTS    262
 #define QEMU_NBD_OPT_FORK          263
+#define QEMU_NBD_OPT_NOLIST        264
 
 #define MBR_SIZE 512
 
@@ -66,6 +67,7 @@ static int shared = 1;
 static int nb_fds;
 static QIONetListener *server;
 static QCryptoTLSCreds *tlscreds;
+static bool allow_list = true;
 
 static void usage(const char *name)
 {
@@ -86,6 +88,7 @@ static void usage(const char *name)
 "  -v, --verbose             display extra debugging information\n"
 "  -x, --export-name=NAME    expose export by name\n"
 "  -D, --description=TEXT    with -x, also export a human-readable description\n"
+"      --nolist              do not list export\n"
 "\n"
 "Exposing part of the image:\n"
 "  -o, --offset=OFFSET       offset into the image\n"
@@ -355,7 +358,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
     nb_fds++;
     nbd_update_server_watch();
     nbd_client_new(newproto ? NULL : exp, cioc,
-                   tlscreds, NULL, nbd_client_closed);
+                   tlscreds, NULL, allow_list, nbd_client_closed);
 }
 
 static void nbd_update_server_watch(void)
@@ -523,6 +526,7 @@ int main(int argc, char **argv)
         { "object", required_argument, NULL, QEMU_NBD_OPT_OBJECT },
         { "export-name", required_argument, NULL, 'x' },
         { "description", required_argument, NULL, 'D' },
+        { "nolist", no_argument, NULL, QEMU_NBD_OPT_NOLIST },
         { "tls-creds", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
         { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
         { "trace", required_argument, NULL, 'T' },
@@ -717,6 +721,9 @@ int main(int argc, char **argv)
         case 'D':
             export_description = optarg;
             break;
+        case QEMU_NBD_OPT_NOLIST:
+            allow_list = false;
+            break;
         case 'v':
             verbose = 1;
             break;
diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 9a84e81eed..010b29588f 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -85,6 +85,8 @@ the new style NBD protocol negotiation
 @item -D, --description=@var{description}
 Set the NBD volume export description, as a human-readable
 string. Requires the use of @option{-x}
+@item --nolist
+Do not allow the client to fetch a list of exports from this server.
 @item --tls-creds=ID
 Enable mandatory TLS encryption for the server by setting the ID
 of the TLS credentials object previously created with the --object
-- 
2.14.3
