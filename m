Received: from eggs.gnu.org ([209.51.188.92]:38932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h2HK7-00083V-Ed
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h2HK4-0002Fe-Vn
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:22:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h2HK2-00026J-KN
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:22:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73670307E072
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 15:22:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  8 Mar 2019 15:21:50 +0000
Message-Id: <20190308152150.32030-2-berrange@redhat.com>
In-Reply-To: <20190308152150.32030-1-berrange@redhat.com>
References: <20190308152150.32030-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/1] chardev: add support for authorization
 for TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Currently any client which can complete the TLS handshake is able to use
a chardev server. The server admin can turn on the 'verify-peer' option
for the x509 creds to require the client to provide a x509
certificate. This means the client will have to acquire a certificate
from the CA before they are permitted to use the chardev server. This is
still a fairly low bar.

This adds a 'tls-authz=3DOBJECT-ID' option to the socket chardev backend
which takes the ID of a previously added 'QAuthZ' object instance. This
will be used to validate the client's x509 distinguished name. Clients
failing the check will not be permitted to use the chardev server.

For example to setup authorization that only allows connection from a
client whose x509 certificate distinguished name contains 'CN=3Dfred', yo=
u
would use:

  $QEMU -object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemutls,\
                endpoint=3Dserver,verify-peer=3Dyes \
        -object authz-simple,id=3Dauthz0,identity=3DCN=3Dlaptop.example.c=
om,,\
                O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB \
        -chardev socket,host=3D127.0.0.1,port=3D9000,server,\
	         tls-creds=3Dtls0,tls-authz=3Dauthz0 \
        ...other qemu args...

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 chardev/char-socket.c | 12 +++++++++++-
 chardev/char.c        |  3 +++
 qapi/char.json        |  6 ++++++
 qemu-options.hx       | 10 ++++++++--
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 6d287babfb..3916505d67 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -59,6 +59,7 @@ typedef struct {
     QIONetListener *listener;
     GSource *hup_source;
     QCryptoTLSCreds *tls_creds;
+    char *tls_authz;
     TCPChardevState state;
     int max_size;
     int do_telnetopt;
@@ -807,7 +808,7 @@ static void tcp_chr_tls_init(Chardev *chr)
     if (s->is_listen) {
         tioc =3D qio_channel_tls_new_server(
             s->ioc, s->tls_creds,
-            NULL, /* XXX Use an ACL */
+            s->tls_authz,
             &err);
     } else {
         tioc =3D qio_channel_tls_new_client(
@@ -1055,6 +1056,7 @@ static void char_socket_finalize(Object *obj)
     if (s->tls_creds) {
         object_unref(OBJECT(s->tls_creds));
     }
+    g_free(s->tls_authz);
=20
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
@@ -1242,6 +1244,11 @@ static bool qmp_chardev_validate_socket(ChardevSoc=
ket *sock,
         break;
     }
=20
+    if (sock->has_tls_authz && !sock->has_tls_creds) {
+        error_setg(errp, "'tls_authz' option requires 'tls_creds' option=
");
+        return false;
+    }
+
     /* Validate any options which have a dependancy on client vs server =
*/
     if (!sock->has_server || sock->server) {
         if (sock->has_reconnect) {
@@ -1320,6 +1327,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
             }
         }
     }
+    s->tls_authz =3D g_strdup(sock->tls_authz);
=20
     s->addr =3D addr =3D socket_address_flatten(sock->addr);
=20
@@ -1399,6 +1407,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
     sock->reconnect =3D qemu_opt_get_number(opts, "reconnect", 0);
     sock->has_tls_creds =3D qemu_opt_get(opts, "tls-creds");
     sock->tls_creds =3D g_strdup(qemu_opt_get(opts, "tls-creds"));
+    sock->has_tls_authz =3D qemu_opt_get(opts, "tls-authz");
+    sock->tls_authz =3D g_strdup(qemu_opt_get(opts, "tls-authz"));
=20
     addr =3D g_new0(SocketAddressLegacy, 1);
     if (path) {
diff --git a/chardev/char.c b/chardev/char.c
index f6d61fa5f8..514cd6b0c3 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -880,6 +880,9 @@ QemuOptsList qemu_chardev_opts =3D {
         },{
             .name =3D "tls-creds",
             .type =3D QEMU_OPT_STRING,
+        },{
+            .name =3D "tls-authz",
+            .type =3D QEMU_OPT_STRING,
         },{
             .name =3D "websocket",
             .type =3D QEMU_OPT_BOOL,
diff --git a/qapi/char.json b/qapi/char.json
index 77ed847972..a6e81ac7bc 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -248,6 +248,11 @@
 # @addr: socket address to listen on (server=3Dtrue)
 #        or connect to (server=3Dfalse)
 # @tls-creds: the ID of the TLS credentials object (since 2.6)
+# @tls-authz: the ID of the QAuthZ authorization object against which
+#             the client's x509 distinguished name will be validated. Th=
is
+#             object is only resolved at time of use, so can be deleted
+#             and recreated on the fly while the chardev server is activ=
e.
+#             If missing, it will default to denying access (since 4.0)
 # @server: create server socket (default: true)
 # @wait: wait for incoming connection on server
 #        sockets (default: false).
@@ -268,6 +273,7 @@
 { 'struct': 'ChardevSocket',
   'data': { 'addr': 'SocketAddressLegacy',
             '*tls-creds': 'str',
+            '*tls-authz'  : 'str',
             '*server': 'bool',
             '*wait': 'bool',
             '*nodelay': 'bool',
diff --git a/qemu-options.hx b/qemu-options.hx
index 1cf9aac1fe..84f0e56702 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2413,7 +2413,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "-chardev null,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3D=
on|off]\n"
     "-chardev socket,id=3Did[,host=3Dhost],port=3Dport[,to=3Dto][,ipv4][=
,ipv6][,nodelay][,reconnect=3Dseconds]\n"
     "         [,server][,nowait][,telnet][,websocket][,reconnect=3Dsecon=
ds][,mux=3Don|off]\n"
-    "         [,logfile=3DPATH][,logappend=3Don|off][,tls-creds=3DID] (t=
cp)\n"
+    "         [,logfile=3DPATH][,logappend=3Don|off][,tls-creds=3DID][,t=
ls-authz=3DID] (tcp)\n"
     "-chardev socket,id=3Did,path=3Dpath[,server][,nowait][,telnet][,web=
socket][,reconnect=3Dseconds]\n"
     "         [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off] (uni=
x)\n"
     "-chardev udp,id=3Did[,host=3Dhost],port=3Dport[,localaddr=3Dlocalad=
dr]\n"
@@ -2542,7 +2542,7 @@ The available backends are:
 A void device. This device will not emit any data, and will drop any dat=
a it
 receives. The null backend does not take any options.
=20
-@item -chardev socket,id=3D@var{id}[,@var{TCP options} or @var{unix opti=
ons}][,server][,nowait][,telnet][,websocket][,reconnect=3D@var{seconds}][=
,tls-creds=3D@var{id}]
+@item -chardev socket,id=3D@var{id}[,@var{TCP options} or @var{unix opti=
ons}][,server][,nowait][,telnet][,websocket][,reconnect=3D@var{seconds}][=
,tls-creds=3D@var{id}][,tls-authz=3D@var{id}]
=20
 Create a two-way stream socket, which can be either a TCP or a unix sock=
et. A
 unix socket will be created if @option{path} is specified. Behaviour is
@@ -2568,6 +2568,12 @@ and specifies the id of the TLS credentials to use=
 for the handshake. The
 credentials must be previously created with the @option{-object tls-cred=
s}
 argument.
=20
+@option{tls-auth} provides the ID of the QAuthZ authorization object aga=
inst
+which the client's x509 distinguished name will be validated. This objec=
t is
+only resolved at time of use, so can be deleted and recreated on the fly
+while the chardev server is active. If missing, it will default to denyi=
ng
+access.
+
 TCP and unix socket options are given below:
=20
 @table @option
--=20
2.20.1
