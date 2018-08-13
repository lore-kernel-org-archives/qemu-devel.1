Received: from eggs.gnu.org ([2001:4830:134:3::10]:45719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fp9y5-00042I-05
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fp9y1-0004sH-R6
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:20:56 -0400
Received: from smtp35.i.mail.ru ([94.100.177.95]:33126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fp9y1-0004qt-9R
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:20:53 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Mon, 13 Aug 2018 13:20:37 +0300
Message-Id: <20180813102037.12097-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

New option "websock" added to allow using websocket protocol for
chardev socket backend.
Example:
    -chardev socket,websock,id=...

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 chardev/char-socket.c | 75 ++++++++++++++++++++++++++++++++++++-------
 chardev/char.c        |  3 ++
 qapi/char.json        |  3 ++
 3 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index efbad6ee7c..4464446511 100644
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
@@ -69,6 +70,8 @@ typedef struct {
     GSource *telnet_source;
     TCPChardevTelnetInit *telnet_init;
 
+    bool is_websock;
+
     GSource *reconnect_timer;
     int64_t reconnect_time;
     bool connect_err_reported;
@@ -386,12 +389,14 @@ static void tcp_chr_free_connection(Chardev *chr)
 }
 
 static char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
-                                  bool is_listen, bool is_telnet)
+                                  bool is_listen, bool is_telnet,
+                                  bool is_websock)
 {
     switch (addr->type) {
     case SOCKET_ADDRESS_TYPE_INET:
         return g_strdup_printf("%s%s:%s:%s%s", prefix,
-                               is_telnet ? "telnet" : "tcp",
+                               is_telnet ? "telnet"
+                                         : (is_websock ? "websock" : "tcp"),
                                addr->u.inet.host,
                                addr->u.inet.port,
                                is_listen ? ",server" : "");
@@ -420,7 +425,8 @@ static void update_disconnected_filename(SocketChardev *s)
 
     g_free(chr->filename);
     chr->filename = SocketAddress_to_str("disconnected:", s->addr,
-                                         s->is_listen, s->is_telnet);
+                                         s->is_listen, s->is_telnet,
+                                         s->is_websock);
 }
 
 /* NB may be called even if tcp_chr_connect has not been
@@ -508,7 +514,7 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 
 static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_len,
                              struct sockaddr_storage *ps, socklen_t ps_len,
-                             bool is_listen, bool is_telnet)
+                             bool is_listen, bool is_telnet, bool is_websock)
 {
     char shost[NI_MAXHOST], sserv[NI_MAXSERV];
     char phost[NI_MAXHOST], pserv[NI_MAXSERV];
@@ -531,7 +537,8 @@ static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_len,
         getnameinfo((struct sockaddr *) ps, ps_len, phost, sizeof(phost),
                     pserv, sizeof(pserv), NI_NUMERICHOST | NI_NUMERICSERV);
         return g_strdup_printf("%s:%s%s%s:%s%s <-> %s%s%s:%s",
-                               is_telnet ? "telnet" : "tcp",
+                               is_telnet ? "telnet"
+                                         : (is_websock ? "websock" : "tcp"),
                                left, shost, right, sserv,
                                is_listen ? ",server" : "",
                                left, phost, right, pserv);
@@ -550,7 +557,7 @@ static void tcp_chr_connect(void *opaque)
     chr->filename = sockaddr_to_str(
         &s->sioc->localAddr, s->sioc->localAddrLen,
         &s->sioc->remoteAddr, s->sioc->remoteAddrLen,
-        s->is_listen, s->is_telnet);
+        s->is_listen, s->is_telnet, s->is_websock);
 
     s->connected = 1;
     chr->gsource = io_add_watch_poll(chr, s->ioc,
@@ -699,6 +706,45 @@ cont:
 }
 
 
+static void tcp_chr_websock_handshake(QIOTask *task, gpointer user_data)
+{
+    Chardev *chr = user_data;
+
+    if (qio_task_propagate_error(task, NULL)) {
+        tcp_chr_disconnect(chr);
+    } else {
+        tcp_chr_connect(chr);
+    }
+}
+
+
+static void tcp_chr_websock_init(Chardev *chr)
+{
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+    QIOChannelWebsock *wioc;
+    gchar *name;
+
+    if (s->is_listen) {
+        wioc = qio_channel_websock_new_server(s->ioc);
+    } else {
+        /* Websocket client is not yet implemented */
+        return;
+    }
+    if (wioc == NULL) {
+        tcp_chr_disconnect(chr);
+        return;
+    }
+
+    name = g_strdup_printf("chardev-websock-server-%s", chr->label);
+    qio_channel_set_name(QIO_CHANNEL(wioc), name);
+    g_free(name);
+    object_unref(OBJECT(s->ioc));
+    s->ioc = QIO_CHANNEL(wioc);
+
+    qio_channel_websock_handshake(wioc, tcp_chr_websock_handshake, chr, NULL);
+}
+
+
 static void tcp_chr_tls_handshake(QIOTask *task,
                                   gpointer user_data)
 {
@@ -710,6 +756,8 @@ static void tcp_chr_tls_handshake(QIOTask *task,
     } else {
         if (s->do_telnetopt) {
             tcp_chr_telnet_init(chr);
+        } else if (s->is_websock) {
+            tcp_chr_websock_init(chr);
         } else {
             tcp_chr_connect(chr);
         }
@@ -799,12 +847,12 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
 
     if (s->tls_creds) {
         tcp_chr_tls_init(chr);
+    } else if (s->do_telnetopt) {
+        tcp_chr_telnet_init(chr);
+    } else if (s->is_websock) {
+        tcp_chr_websock_init(chr);
     } else {
-        if (s->do_telnetopt) {
-            tcp_chr_telnet_init(chr);
-        } else {
-            tcp_chr_connect(chr);
-        }
+        tcp_chr_connect(chr);
     }
 
     return 0;
@@ -948,6 +996,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     bool is_listen      = sock->has_server  ? sock->server  : true;
     bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;
     bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
+    bool is_websock     = sock->has_websock ? sock->websock : false;
     bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
     int64_t reconnect   = sock->has_reconnect ? sock->reconnect : 0;
     QIOChannelSocket *sioc = NULL;
@@ -956,6 +1005,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     s->is_listen = is_listen;
     s->is_telnet = is_telnet;
     s->is_tn3270 = is_tn3270;
+    s->is_websock = is_websock;
     s->do_nodelay = do_nodelay;
     if (sock->tls_creds) {
         Object *creds;
@@ -1061,6 +1111,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     bool is_waitconnect = is_listen && qemu_opt_get_bool(opts, "wait", true);
     bool is_telnet      = qemu_opt_get_bool(opts, "telnet", false);
     bool is_tn3270      = qemu_opt_get_bool(opts, "tn3270", false);
+    bool is_websock     = qemu_opt_get_bool(opts, "websock", false);
     bool do_nodelay     = !qemu_opt_get_bool(opts, "delay", true);
     int64_t reconnect   = qemu_opt_get_number(opts, "reconnect", 0);
     const char *path = qemu_opt_get(opts, "path");
@@ -1109,6 +1160,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     sock->telnet = is_telnet;
     sock->has_tn3270 = true;
     sock->tn3270 = is_tn3270;
+    sock->has_websock = true;
+    sock->websock = is_websock;
     sock->has_wait = true;
     sock->wait = is_waitconnect;
     sock->has_reconnect = true;
diff --git a/chardev/char.c b/chardev/char.c
index 1ab80e0f68..d90e113428 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -837,6 +837,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "tls-creds",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "websock",
+            .type = QEMU_OPT_BOOL,
         },{
             .name = "width",
             .type = QEMU_OPT_NUMBER,
diff --git a/qapi/char.json b/qapi/char.json
index b7b2a05766..135ccddaf7 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -251,6 +251,8 @@
 #          sockets (default: false)
 # @tn3270: enable tn3270 protocol on server
 #          sockets (default: false) (Since: 2.10)
+# @websock: enable websocket protocol on server
+#           sockets (default: false)
 # @reconnect: For a client socket, if a socket is disconnected,
 #          then attempt a reconnect after the given number of seconds.
 #          Setting this to zero disables this function. (default: 0)
@@ -265,6 +267,7 @@
                                      '*nodelay'   : 'bool',
                                      '*telnet'    : 'bool',
                                      '*tn3270'    : 'bool',
+                                     '*websock'   : 'bool',
                                      '*reconnect' : 'int' },
   'base': 'ChardevCommon' }
 
-- 
2.17.1
