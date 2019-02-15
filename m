Received: from eggs.gnu.org ([209.51.188.92]:37020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guh5U-0005DZ-2Q
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guh5Q-0006Pq-5g
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:15:43 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Feb 2019 17:14:31 +0000
Message-Id: <20190215171436.30457-2-berrange@redhat.com>
In-Reply-To: <20190215171436.30457-1-berrange@redhat.com>
References: <20190215171436.30457-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/6] qemu-nbd: add support for authorization
 of TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, libvir-list@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

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

For example to setup authorization that only allows connection from a cli=
ent
whose x509 certificate distinguished name is

   CN=3Dlaptop.example.com,O=3DExample Org,L=3DLondon,ST=3DLondon,C=3DGB

escape the commas in the name and use:

  qemu-nbd --object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemutls=
,\
                    endpoint=3Dserver,verify-peer=3Dyes \
           --object 'authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.examp=
le.com,,\
                     O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB' \
           --tls-creds tls0 \
           --tls-authz authz0 \
	   ....other qemu-nbd args...

NB: a real shell command line would not have leading whitespace after
the line continuation, it is just included here for clarity.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/block/nbd.h        |  2 +-
 nbd/server.c               | 10 +++++-----
 qemu-nbd.c                 | 14 +++++++++++++-
 qemu-nbd.texi              |  4 ++++
 tests/qemu-iotests/233     | 31 ++++++++++++++++++++++++++++---
 tests/qemu-iotests/233.out | 11 +++++++++++
 6 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 96cfb1d7d5..554f531c1a 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -325,7 +325,7 @@ void nbd_export_close_all(void);
=20
 void nbd_client_new(QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
-                    const char *tlsaclname,
+                    const char *tlsauthz,
                     void (*close_fn)(NBDClient *, bool));
 void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);
diff --git a/nbd/server.c b/nbd/server.c
index 0910d09a6d..8ddfd3e319 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -111,7 +111,7 @@ struct NBDClient {
=20
     NBDExport *exp;
     QCryptoTLSCreds *tlscreds;
-    char *tlsaclname;
+    char *tlsauthz;
     QIOChannelSocket *sioc; /* The underlying data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS=
) */
=20
@@ -686,7 +686,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDC=
lient *client,
=20
     tioc =3D qio_channel_tls_new_server(ioc,
                                       client->tlscreds,
-                                      client->tlsaclname,
+                                      client->tlsauthz,
                                       errp);
     if (!tioc) {
         return NULL;
@@ -1348,7 +1348,7 @@ void nbd_client_put(NBDClient *client)
         if (client->tlscreds) {
             object_unref(OBJECT(client->tlscreds));
         }
-        g_free(client->tlsaclname);
+        g_free(client->tlsauthz);
         if (client->exp) {
             QTAILQ_REMOVE(&client->exp->clients, client, next);
             nbd_export_put(client->exp);
@@ -2425,7 +2425,7 @@ static coroutine_fn void nbd_co_client_start(void *=
opaque)
  */
 void nbd_client_new(QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
-                    const char *tlsaclname,
+                    const char *tlsauthz,
                     void (*close_fn)(NBDClient *, bool))
 {
     NBDClient *client;
@@ -2437,7 +2437,7 @@ void nbd_client_new(QIOChannelSocket *sioc,
     if (tlscreds) {
         object_ref(OBJECT(client->tlscreds));
     }
-    client->tlsaclname =3D g_strdup(tlsaclname);
+    client->tlsauthz =3D g_strdup(tlsauthz);
     client->sioc =3D sioc;
     object_ref(OBJECT(client->sioc));
     client->ioc =3D QIO_CHANNEL(sioc);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 00c07fd27e..0738073d95 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -58,6 +58,7 @@
 #define QEMU_NBD_OPT_TLSCREDS      261
 #define QEMU_NBD_OPT_IMAGE_OPTS    262
 #define QEMU_NBD_OPT_FORK          263
+#define QEMU_NBD_OPT_TLSAUTHZ      264
=20
 #define MBR_SIZE 512
=20
@@ -71,6 +72,7 @@ static int shared =3D 1;
 static int nb_fds;
 static QIONetListener *server;
 static QCryptoTLSCreds *tlscreds;
+static const char *tlsauthz;
=20
 static void usage(const char *name)
 {
@@ -103,6 +105,7 @@ static void usage(const char *name)
 "  --object type,id=3DID,...   define an object such as 'secret' for pro=
viding\n"
 "                            passwords and/or encryption keys\n"
 "  --tls-creds=3DID            use id of an earlier --object to provide =
TLS\n"
+"  --tls-authz=3DID            use id of an earlier --object to provide =
authorization\n"
 "  -T, --trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]\=
n"
 "                            specify tracing options\n"
 "  --fork                    fork off the server process and exit the pa=
rent\n"
@@ -452,7 +455,7 @@ static void nbd_accept(QIONetListener *listener, QIOC=
hannelSocket *cioc,
=20
     nb_fds++;
     nbd_update_server_watch();
-    nbd_client_new(cioc, tlscreds, NULL, nbd_client_closed);
+    nbd_client_new(cioc, tlscreds, tlsauthz, nbd_client_closed);
 }
=20
 static void nbd_update_server_watch(void)
@@ -643,6 +646,7 @@ int main(int argc, char **argv)
         { "export-name", required_argument, NULL, 'x' },
         { "description", required_argument, NULL, 'D' },
         { "tls-creds", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
+        { "tls-authz", required_argument, NULL, QEMU_NBD_OPT_TLSAUTHZ },
         { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
         { "trace", required_argument, NULL, 'T' },
         { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
@@ -862,6 +866,9 @@ int main(int argc, char **argv)
             g_free(trace_file);
             trace_file =3D trace_opt_parse(optarg);
             break;
+        case QEMU_NBD_OPT_TLSAUTHZ:
+            tlsauthz =3D optarg;
+            break;
         case QEMU_NBD_OPT_FORK:
             fork_process =3D true;
             break;
@@ -940,6 +947,11 @@ int main(int argc, char **argv)
                          error_get_pretty(local_err));
             exit(EXIT_FAILURE);
         }
+    } else {
+        if (tlsauthz) {
+            error_report("--tls-authz is not permitted without --tls-cre=
ds");
+            exit(EXIT_FAILURE);
+        }
     }
=20
     if (list) {
diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index d0c5182814..d45ed9e0a0 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -117,6 +117,10 @@ option; or provide the credentials needed for connec=
ting as a client
 in list mode.
 @item --fork
 Fork off the server process and exit the parent once the server is runni=
ng.
+@item --tls-authz=3DID
+Specify the ID of a qauthz object previously created with the
+--object option. This will be used to authorize connecting users
+against their x509 distinguished name.
 @item -v, --verbose
 Display extra debugging information.
 @item -h, --help
diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index fc345a1a46..4762c380cb 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -59,6 +59,7 @@ tls_x509_create_root_ca "ca2"
 tls_x509_create_server "ca1" "server1"
 tls_x509_create_client "ca1" "client1"
 tls_x509_create_client "ca2" "client2"
+tls_x509_create_client "ca1" "client3"
=20
 echo
 echo "=3D=3D preparing image =3D=3D"
@@ -91,11 +92,15 @@ $QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port
=20
 echo
 echo "=3D=3D check TLS works =3D=3D"
-obj=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=3Dtls=
0
-$QEMU_IMG info --image-opts --object $obj \
+obj1=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=3Dtl=
s0
+obj2=3Dtls-creds-x509,dir=3D${tls_dir}/client3,endpoint=3Dclient,id=3Dtl=
s0
+$QEMU_IMG info --image-opts --object $obj1 \
     driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
     2>&1 | sed "s/$nbd_tcp_port/PORT/g"
-$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port --object $obj \
+$QEMU_IMG info --image-opts --object $obj2 \
+    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
+    2>&1 | sed "s/$nbd_tcp_port/PORT/g"
+$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port --object $obj1 \
     --tls-creds=3Dtls0
=20
 echo
@@ -117,6 +122,26 @@ $QEMU_IO -c 'r -P 0x11 1m 1m' -c 'w -P 0x22 1m 1m' -=
-image-opts \
=20
 $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "$TEST_IMG" | _filter_qem=
u_io
=20
+echo
+echo "=3D=3D check TLS with authorization =3D=3D"
+
+nbd_server_stop
+
+nbd_server_start_tcp_socket \
+    --object tls-creds-x509,dir=3D${tls_dir}/server1,endpoint=3Dserver,i=
d=3Dtls0,verify-peer=3Dyes \
+    --object "authz-simple,identity=3DCN=3Dlocalhost,,O=3DCthulu Dark Lo=
rd Enterprises client1,,L=3DR'lyeh,,C=3DSouth Pacific,id=3Dauthz0" \
+    --tls-authz authz0 \
+    --tls-creds tls0 \
+    -f $IMGFMT "$TEST_IMG" 2>> "$TEST_DIR/server.log"
+
+$QEMU_IMG info --image-opts \
+    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0 \
+    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0
+
+$QEMU_IMG info --image-opts \
+    --object tls-creds-x509,dir=3D${tls_dir}/client3,endpoint=3Dclient,i=
d=3Dtls0 \
+    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0
+
 echo
 echo "=3D=3D final server log =3D=3D"
 cat "$TEST_DIR/server.log"
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 6d45f3b230..5acbc13b54 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -6,6 +6,7 @@ Generating a self signed certificate...
 Generating a signed certificate...
 Generating a signed certificate...
 Generating a signed certificate...
+Generating a signed certificate...
=20
 =3D=3D preparing image =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
@@ -29,6 +30,10 @@ image: nbd://127.0.0.1:PORT
 file format: nbd
 virtual size: 64M (67108864 bytes)
 disk size: unavailable
+image: nbd://127.0.0.1:PORT
+file format: nbd
+virtual size: 64M (67108864 bytes)
+disk size: unavailable
 exports available: 1
  export: ''
   size:  67108864
@@ -51,7 +56,13 @@ wrote 1048576/1048576 bytes at offset 1048576
 read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
+=3D=3D check TLS with authorization =3D=3D
+qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809,tls=
-creds=3Dtls0': Failed to read option reply: Cannot read from TLS channel=
: Software caused connection abort
+qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809,tls=
-creds=3Dtls0': Failed to read option reply: Cannot read from TLS channel=
: Software caused connection abort
+
 =3D=3D final server log =3D=3D
 qemu-nbd: option negotiation failed: Verify failed: No certificate was f=
ound.
 qemu-nbd: option negotiation failed: Verify failed: No certificate was f=
ound.
+qemu-nbd: option negotiation failed: TLS x509 authz check for CN=3Dlocal=
host,O=3DCthulhu Dark Lord Enterprises client1,L=3DR'lyeh,C=3DSouth Pacif=
ic is denied
+qemu-nbd: option negotiation failed: TLS x509 authz check for CN=3Dlocal=
host,O=3DCthulhu Dark Lord Enterprises client3,L=3DR'lyeh,C=3DSouth Pacif=
ic is denied
 *** done
--=20
2.20.1
