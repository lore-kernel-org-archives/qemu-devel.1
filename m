Received: from eggs.gnu.org ([2001:4830:134:3::10]:53270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9s02-000662-71
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9s00-0004Qr-Rz
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:24:34 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  9 Oct 2018 14:23:28 +0100
Message-Id: <20181009132330.7549-5-berrange@redhat.com>
In-Reply-To: <20181009132330.7549-1-berrange@redhat.com>
References: <20181009132330.7549-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/6] chardev: add support for authorization
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Currently any client which can complete the TLS handshake is able to use
a chardev server. The server admin can turn on the 'verify-peer' option
for the x509 creds to require the client to provide a x509
certificate. This means the client will have to acquire a certificate
from the CA before they are permitted to use the chardev server. This is
still a fairly low bar.

This adds a 'tls-authz=OBJECT-ID' option to the socket chardev backend
which takes the ID of a previously added 'QAuthZ' object instance. This
will be used to validate the client's x509 distinguished name. Clients
failing the check will not be permitted to use the chardev server.

For example to setup authorization that only allows connection from a
client whose x509 certificate distinguished name contains 'CN=fred', you
would use:

  $QEMU -object tls-creds-x509,id=tls0,dir=/home/berrange/qemutls,\
                endpoint=server,verify-peer=yes \
        -object authz-simple,id=authz0,identity=CN=laptop.example.com,,\
                O=Example Org,,L=London,,ST=London,,C=GB \
        -chardev socket,host=127.0.0.1,port=9000,server,\
	         tls-creds=tls0,tls-authz=authz0 \
        ...other qemu args...

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 chardev/char-socket.c | 11 ++++++++++-
 chardev/char.c        |  3 +++
 qapi/char.json        |  6 ++++++
 qemu-options.hx       |  9 +++++++--
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a75b46d9fe..ab121e1e30 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -52,6 +52,7 @@ typedef struct {
     QIONetListener *listener;
     GSource *hup_source;
     QCryptoTLSCreds *tls_creds;
+    char *tls_authz;
     int connected;
     int max_size;
     int do_telnetopt;
@@ -737,7 +738,7 @@ static void tcp_chr_tls_init(Chardev *chr)
     if (s->is_listen) {
         tioc = qio_channel_tls_new_server(
             s->ioc, s->tls_creds,
-            NULL, /* XXX Use an ACL */
+            s->tls_authz,
             &err);
     } else {
         tioc = qio_channel_tls_new_client(
@@ -889,6 +890,7 @@ static void char_socket_finalize(Object *obj)
     if (s->tls_creds) {
         object_unref(OBJECT(s->tls_creds));
     }
+    g_free(s->tls_authz);
 
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
@@ -994,6 +996,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
             }
         }
     }
+    s->tls_authz = g_strdup(sock->tls_authz);
 
     s->addr = addr = socket_address_flatten(sock->addr);
 
@@ -1075,6 +1078,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     const char *fd = qemu_opt_get(opts, "fd");
     const char *tls_creds = qemu_opt_get(opts, "tls-creds");
     SocketAddressLegacy *addr;
+    const char *tls_authz = qemu_opt_get(opts, "tls-authz");
     ChardevSocket *sock;
 
     if ((!!path + !!fd + !!host) != 1) {
@@ -1103,6 +1107,10 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     } else {
         g_assert_not_reached();
     }
+    if (tls_authz && !tls_creds) {
+        error_setg(errp, "Authorization can only be used when TLS is enabled");
+        return;
+    }
 
     sock = backend->u.socket.data = g_new0(ChardevSocket, 1);
     qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
@@ -1120,6 +1128,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     sock->has_reconnect = true;
     sock->reconnect = reconnect;
     sock->tls_creds = g_strdup(tls_creds);
+    sock->tls_authz = g_strdup(tls_authz);
 
     addr = g_new0(SocketAddressLegacy, 1);
     if (path) {
diff --git a/chardev/char.c b/chardev/char.c
index e115166995..987474a950 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -860,6 +860,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "tls-creds",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "tls-authz",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "width",
             .type = QEMU_OPT_NUMBER,
diff --git a/qapi/char.json b/qapi/char.json
index b7b2a05766..244213c075 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -243,6 +243,11 @@
 # @addr: socket address to listen on (server=true)
 #        or connect to (server=false)
 # @tls-creds: the ID of the TLS credentials object (since 2.6)
+# @tls-authz: the ID of the QAuthZ authorization object against which
+#             the client's x509 distinguished name will validated. This
+#             object is only resolved at time of use, so can be deleted
+#             and recreated on the fly while the chardev server is active.
+#             If missing, it will default to denying access (since 3.1)
 # @server: create server socket (default: true)
 # @wait: wait for incoming connection on server
 #        sockets (default: false).
@@ -260,6 +265,7 @@
 ##
 { 'struct': 'ChardevSocket', 'data': { 'addr'       : 'SocketAddressLegacy',
                                      '*tls-creds'  : 'str',
+                                     '*tls-authz'  : 'str',
                                      '*server'    : 'bool',
                                      '*wait'      : 'bool',
                                      '*nodelay'   : 'bool',
diff --git a/qemu-options.hx b/qemu-options.hx
index cc61512db7..5079074088 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2410,7 +2410,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "-chardev null,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
     "-chardev socket,id=id[,host=host],port=port[,to=to][,ipv4][,ipv6][,nodelay][,reconnect=seconds]\n"
     "         [,server][,nowait][,telnet][,reconnect=seconds][,mux=on|off]\n"
-    "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID] (tcp)\n"
+    "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID][,tls-authz=ID], (tcp)\n"
     "-chardev socket,id=id,path=path[,server][,nowait][,telnet][,reconnect=seconds]\n"
     "         [,mux=on|off][,logfile=PATH][,logappend=on|off] (unix)\n"
     "-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr]\n"
@@ -2539,7 +2539,7 @@ The available backends are:
 A void device. This device will not emit any data, and will drop any data it
 receives. The null backend does not take any options.
 
-@item -chardev socket,id=@var{id}[,@var{TCP options} or @var{unix options}][,server][,nowait][,telnet][,reconnect=@var{seconds}][,tls-creds=@var{id}]
+@item -chardev socket,id=@var{id}[,@var{TCP options} or @var{unix options}][,server][,nowait][,telnet][,reconnect=@var{seconds}][,tls-creds=@var{id}][,tls-authz=@var{id}]
 
 Create a two-way stream socket, which can be either a TCP or a unix socket. A
 unix socket will be created if @option{path} is specified. Behaviour is
@@ -2562,6 +2562,11 @@ and specifies the id of the TLS credentials to use for the handshake. The
 credentials must be previously created with the @option{-object tls-creds}
 argument.
 
+@option{tls-auth} provides the ID of the QAuthZ authorization object against
+which the client's x509 distinguished name will validated. This object is only
+resolved at time of use, so can be deleted and recreated on the fly while the
+chardev server is active. If missing, it will default to denying access.
+
 TCP and unix socket options are given below:
 
 @table @option
-- 
2.17.1
