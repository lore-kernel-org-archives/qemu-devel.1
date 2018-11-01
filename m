Received: from eggs.gnu.org ([2001:4830:134:3::10]:35396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gI8Iz-0007r8-Hw
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gI8Ix-0006QL-VR
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:26:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gI8Ix-0006Hk-Fy
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:26:15 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Nov 2018 12:24:21 +0400
Message-Id: <20181101082423.26424-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181101082423.26424-1-marcandre.lureau@redhat.com>
References: <20181101082423.26424-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 5/7] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Julia Suvorova <jusual@mail.ru>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Julia Suvorova <jusual@mail.ru>

New option "websocket" added to allow using WebSocket protocol for
chardev socket backend.
Example:
    -chardev socket,websocket,server,id=3D...

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Message-Id: <20181018223501.21683-3-jusual@mail.ru>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/char.json        |  3 ++
 chardev/char-socket.c | 64 ++++++++++++++++++++++++++++++++++++++-----
 chardev/char.c        |  8 +++++-
 qemu-options.hx       | 13 +++++++--
 4 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index b7b2a05766..79bac598a0 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -251,6 +251,8 @@
 #          sockets (default: false)
 # @tn3270: enable tn3270 protocol on server
 #          sockets (default: false) (Since: 2.10)
+# @websocket: enable websocket protocol on server
+#           sockets (default: false) (Since: 3.1)
 # @reconnect: For a client socket, if a socket is disconnected,
 #          then attempt a reconnect after the given number of seconds.
 #          Setting this to zero disables this function. (default: 0)
@@ -265,6 +267,7 @@
                                      '*nodelay'   : 'bool',
                                      '*telnet'    : 'bool',
                                      '*tn3270'    : 'bool',
+                                     '*websocket' : 'bool',
                                      '*reconnect' : 'int' },
   'base': 'ChardevCommon' }
=20
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 0bbeb83ceb..eaa8e8b68f 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -26,6 +26,7 @@
 #include "chardev/char.h"
 #include "io/channel-socket.h"
 #include "io/channel-tls.h"
+#include "io/channel-websock.h"
 #include "io/net-listener.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
@@ -68,6 +69,8 @@ typedef struct {
     GSource *telnet_source;
     TCPChardevTelnetInit *telnet_init;
=20
+    bool is_websock;
+
     GSource *reconnect_timer;
     int64_t reconnect_time;
     bool connect_err_reported;
@@ -394,7 +397,7 @@ static const char *qemu_chr_socket_protocol(SocketCha=
rdev *s)
     if (s->is_telnet) {
         return "telnet";
     }
-    return "tcp";
+    return s->is_websock ? "websocket" : "tcp";
 }
=20
 static char *qemu_chr_socket_address(SocketChardev *s, const char *prefi=
x)
@@ -714,6 +717,41 @@ cont:
 }
=20
=20
+static void tcp_chr_websock_handshake(QIOTask *task, gpointer user_data)
+{
+    Chardev *chr =3D user_data;
+    SocketChardev *s =3D user_data;
+
+    if (qio_task_propagate_error(task, NULL)) {
+        tcp_chr_disconnect(chr);
+    } else {
+        if (s->do_telnetopt) {
+            tcp_chr_telnet_init(chr);
+        } else {
+            tcp_chr_connect(chr);
+        }
+    }
+}
+
+
+static void tcp_chr_websock_init(Chardev *chr)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
+    QIOChannelWebsock *wioc =3D NULL;
+    gchar *name;
+
+    wioc =3D qio_channel_websock_new_server(s->ioc);
+
+    name =3D g_strdup_printf("chardev-websocket-server-%s", chr->label);
+    qio_channel_set_name(QIO_CHANNEL(wioc), name);
+    g_free(name);
+    object_unref(OBJECT(s->ioc));
+    s->ioc =3D QIO_CHANNEL(wioc);
+
+    qio_channel_websock_handshake(wioc, tcp_chr_websock_handshake, chr, =
NULL);
+}
+
+
 static void tcp_chr_tls_handshake(QIOTask *task,
                                   gpointer user_data)
 {
@@ -723,7 +761,9 @@ static void tcp_chr_tls_handshake(QIOTask *task,
     if (qio_task_propagate_error(task, NULL)) {
         tcp_chr_disconnect(chr);
     } else {
-        if (s->do_telnetopt) {
+        if (s->is_websock) {
+            tcp_chr_websock_init(chr);
+        } else if (s->do_telnetopt) {
             tcp_chr_telnet_init(chr);
         } else {
             tcp_chr_connect(chr);
@@ -809,12 +849,12 @@ static int tcp_chr_new_client(Chardev *chr, QIOChan=
nelSocket *sioc)
=20
     if (s->tls_creds) {
         tcp_chr_tls_init(chr);
+    } else if (s->is_websock) {
+        tcp_chr_websock_init(chr);
+    } else if (s->do_telnetopt) {
+        tcp_chr_telnet_init(chr);
     } else {
-        if (s->do_telnetopt) {
-            tcp_chr_telnet_init(chr);
-        } else {
-            tcp_chr_connect(chr);
-        }
+        tcp_chr_connect(chr);
     }
=20
     return 0;
@@ -959,13 +999,20 @@ static void qmp_chardev_open_socket(Chardev *chr,
     bool is_telnet      =3D sock->has_telnet  ? sock->telnet  : false;
     bool is_tn3270      =3D sock->has_tn3270  ? sock->tn3270  : false;
     bool is_waitconnect =3D sock->has_wait    ? sock->wait    : false;
+    bool is_websock     =3D sock->has_websocket ? sock->websocket : fals=
e;
     int64_t reconnect   =3D sock->has_reconnect ? sock->reconnect : 0;
     QIOChannelSocket *sioc =3D NULL;
     SocketAddress *addr;
=20
+    if (!is_listen && is_websock) {
+        error_setg(errp, "%s", "Websocket client is not implemented");
+        goto error;
+    }
+
     s->is_listen =3D is_listen;
     s->is_telnet =3D is_telnet;
     s->is_tn3270 =3D is_tn3270;
+    s->is_websock =3D is_websock;
     s->do_nodelay =3D do_nodelay;
     if (sock->tls_creds) {
         Object *creds;
@@ -1076,6 +1123,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
     bool is_waitconnect =3D is_listen && qemu_opt_get_bool(opts, "wait",=
 true);
     bool is_telnet      =3D qemu_opt_get_bool(opts, "telnet", false);
     bool is_tn3270      =3D qemu_opt_get_bool(opts, "tn3270", false);
+    bool is_websock     =3D qemu_opt_get_bool(opts, "websocket", false);
     bool do_nodelay     =3D !qemu_opt_get_bool(opts, "delay", true);
     int64_t reconnect   =3D qemu_opt_get_number(opts, "reconnect", 0);
     const char *path =3D qemu_opt_get(opts, "path");
@@ -1124,6 +1172,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
     sock->telnet =3D is_telnet;
     sock->has_tn3270 =3D true;
     sock->tn3270 =3D is_tn3270;
+    sock->has_websocket =3D true;
+    sock->websocket =3D is_websock;
     sock->has_wait =3D true;
     sock->wait =3D is_waitconnect;
     sock->has_reconnect =3D qemu_opt_find(opts, "reconnect");
diff --git a/chardev/char.c b/chardev/char.c
index 7f07a1bfbd..79b05fb7b7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -409,7 +409,8 @@ QemuOpts *qemu_chr_parse_compat(const char *label, co=
nst char *filename,
     }
     if (strstart(filename, "tcp:", &p) ||
         strstart(filename, "telnet:", &p) ||
-        strstart(filename, "tn3270:", &p)) {
+        strstart(filename, "tn3270:", &p) ||
+        strstart(filename, "websocket:", &p)) {
         if (sscanf(p, "%64[^:]:%32[^,]%n", host, port, &pos) < 2) {
             host[0] =3D 0;
             if (sscanf(p, ":%32[^,]%n", port, &pos) < 1)
@@ -429,6 +430,8 @@ QemuOpts *qemu_chr_parse_compat(const char *label, co=
nst char *filename,
             qemu_opt_set(opts, "telnet", "on", &error_abort);
         } else if (strstart(filename, "tn3270:", &p)) {
             qemu_opt_set(opts, "tn3270", "on", &error_abort);
+        } else if (strstart(filename, "websocket:", &p)) {
+            qemu_opt_set(opts, "websocket", "on", &error_abort);
         }
         return opts;
     }
@@ -860,6 +863,9 @@ QemuOptsList qemu_chardev_opts =3D {
         },{
             .name =3D "tls-creds",
             .type =3D QEMU_OPT_STRING,
+        },{
+            .name =3D "websocket",
+            .type =3D QEMU_OPT_BOOL,
         },{
             .name =3D "width",
             .type =3D QEMU_OPT_NUMBER,
diff --git a/qemu-options.hx b/qemu-options.hx
index 08f8516a9a..38c7a978c1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2414,9 +2414,9 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "-chardev help\n"
     "-chardev null,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3D=
on|off]\n"
     "-chardev socket,id=3Did[,host=3Dhost],port=3Dport[,to=3Dto][,ipv4][=
,ipv6][,nodelay][,reconnect=3Dseconds]\n"
-    "         [,server][,nowait][,telnet][,reconnect=3Dseconds][,mux=3Do=
n|off]\n"
+    "         [,server][,nowait][,telnet][,websocket][,reconnect=3Dsecon=
ds][,mux=3Don|off]\n"
     "         [,logfile=3DPATH][,logappend=3Don|off][,tls-creds=3DID] (t=
cp)\n"
-    "-chardev socket,id=3Did,path=3Dpath[,server][,nowait][,telnet][,rec=
onnect=3Dseconds]\n"
+    "-chardev socket,id=3Did,path=3Dpath[,server][,nowait][,telnet][,web=
socket][,reconnect=3Dseconds]\n"
     "         [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off] (uni=
x)\n"
     "-chardev udp,id=3Did[,host=3Dhost],port=3Dport[,localaddr=3Dlocalad=
dr]\n"
     "         [,localport=3Dlocalport][,ipv4][,ipv6][,mux=3Don|off]\n"
@@ -2544,7 +2544,7 @@ The available backends are:
 A void device. This device will not emit any data, and will drop any dat=
a it
 receives. The null backend does not take any options.
=20
-@item -chardev socket,id=3D@var{id}[,@var{TCP options} or @var{unix opti=
ons}][,server][,nowait][,telnet][,reconnect=3D@var{seconds}][,tls-creds=3D=
@var{id}]
+@item -chardev socket,id=3D@var{id}[,@var{TCP options} or @var{unix opti=
ons}][,server][,nowait][,telnet][,websocket][,reconnect=3D@var{seconds}][=
,tls-creds=3D@var{id}]
=20
 Create a two-way stream socket, which can be either a TCP or a unix sock=
et. A
 unix socket will be created if @option{path} is specified. Behaviour is
@@ -2558,6 +2558,9 @@ connect to a listening socket.
 @option{telnet} specifies that traffic on the socket should interpret te=
lnet
 escape sequences.
=20
+@option{websocket} specifies that the socket uses WebSocket protocol for
+communication.
+
 @option{reconnect} sets the timeout for reconnecting on non-server socke=
ts when
 the remote end goes away.  qemu will delay this many seconds and then at=
tempt
 to reconnect.  Zero disables reconnecting, and is the default.
@@ -3106,6 +3109,10 @@ MAGIC_SYSRQ sequence if you use a telnet that supp=
orts sending the break
 sequence.  Typically in unix telnet you do it with Control-] and then
 type "send break" followed by pressing the enter key.
=20
+@item websocket:@var{host}:@var{port},server[,nowait][,nodelay]
+The WebSocket protocol is used instead of raw tcp socket. The port acts =
as
+a WebSocket server. Client mode is not supported.
+
 @item unix:@var{path}[,server][,nowait][,reconnect=3D@var{seconds}]
 A unix domain socket is used instead of a tcp socket.  The option works =
the
 same as if you had specified @code{-serial tcp} except the unix domain s=
ocket
--=20
2.19.1.708.g4ede3d42df
