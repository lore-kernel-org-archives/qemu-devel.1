Received: from eggs.gnu.org ([209.51.188.92]:51598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghC1X-0000k9-54
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghC1W-0004Dx-1h
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:27:51 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:40784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1ghC1V-0004DT-Po
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:27:49 -0500
Received: by mail-pf1-x433.google.com with SMTP id i12so3528419pfo.7
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 03:27:49 -0800 (PST)
From: elohimes@gmail.com
Date: Wed,  9 Jan 2019 19:27:22 +0800
Message-Id: <20190109112728.9214-2-xieyongji@baidu.com>
In-Reply-To: <20190109112728.9214-1-xieyongji@baidu.com>
References: <20190109112728.9214-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v4 for-4.0 1/7] char-socket: Enable "nowait"
 option on client sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

Enable "nowait" option to make QEMU not do a connect
on client sockets during initialization of the chardev.
Then we can use qemu_chr_fe_wait_connected() to connect
when necessary. Now it would be used for unix domain
socket of vhost-user-blk device to support reconnect.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 chardev/char-socket.c | 56 +++++++++++++++++++++----------------------
 qapi/char.json        |  3 +--
 qemu-options.hx       |  9 ++++---
 3 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index eaa8e8b68f..f803f4f7d3 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1072,37 +1072,37 @@ static void qmp_chardev_open_socket(Chardev *chr,
         s->reconnect_time = reconnect;
     }
 
-    if (s->reconnect_time) {
-        tcp_chr_connect_async(chr);
-    } else {
-        if (s->is_listen) {
-            char *name;
-            s->listener = qio_net_listener_new();
+    if (s->is_listen) {
+        char *name;
+        s->listener = qio_net_listener_new();
 
-            name = g_strdup_printf("chardev-tcp-listener-%s", chr->label);
-            qio_net_listener_set_name(s->listener, name);
-            g_free(name);
+        name = g_strdup_printf("chardev-tcp-listener-%s", chr->label);
+        qio_net_listener_set_name(s->listener, name);
+        g_free(name);
 
-            if (qio_net_listener_open_sync(s->listener, s->addr, errp) < 0) {
-                object_unref(OBJECT(s->listener));
-                s->listener = NULL;
-                goto error;
-            }
+        if (qio_net_listener_open_sync(s->listener, s->addr, errp) < 0) {
+            object_unref(OBJECT(s->listener));
+            s->listener = NULL;
+            goto error;
+        }
 
-            qapi_free_SocketAddress(s->addr);
-            s->addr = socket_local_address(s->listener->sioc[0]->fd, errp);
-            update_disconnected_filename(s);
+        qapi_free_SocketAddress(s->addr);
+        s->addr = socket_local_address(s->listener->sioc[0]->fd, errp);
+        update_disconnected_filename(s);
 
-            if (is_waitconnect &&
-                qemu_chr_wait_connected(chr, errp) < 0) {
-                return;
-            }
-            if (!s->ioc) {
-                qio_net_listener_set_client_func_full(s->listener,
-                                                      tcp_chr_accept,
-                                                      chr, NULL,
-                                                      chr->gcontext);
-            }
+        if (is_waitconnect &&
+            qemu_chr_wait_connected(chr, errp) < 0) {
+            return;
+        }
+        if (!s->ioc) {
+            qio_net_listener_set_client_func_full(s->listener,
+                                                  tcp_chr_accept,
+                                                  chr, NULL,
+                                                  chr->gcontext);
+        }
+    } else if (is_waitconnect) {
+        if (s->reconnect_time) {
+            tcp_chr_connect_async(chr);
         } else if (qemu_chr_wait_connected(chr, errp) < 0) {
             goto error;
         }
@@ -1120,7 +1120,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
                                   Error **errp)
 {
     bool is_listen      = qemu_opt_get_bool(opts, "server", false);
-    bool is_waitconnect = is_listen && qemu_opt_get_bool(opts, "wait", true);
+    bool is_waitconnect = qemu_opt_get_bool(opts, "wait", true);
     bool is_telnet      = qemu_opt_get_bool(opts, "telnet", false);
     bool is_tn3270      = qemu_opt_get_bool(opts, "tn3270", false);
     bool is_websock     = qemu_opt_get_bool(opts, "websocket", false);
diff --git a/qapi/char.json b/qapi/char.json
index 77ed847972..6a3b5bcd71 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -249,8 +249,7 @@
 #        or connect to (server=false)
 # @tls-creds: the ID of the TLS credentials object (since 2.6)
 # @server: create server socket (default: true)
-# @wait: wait for incoming connection on server
-#        sockets (default: false).
+# @wait: wait for being connected or connecting to (default: false)
 # @nodelay: set TCP_NODELAY socket option (default: false)
 # @telnet: enable telnet protocol on server
 #          sockets (default: false)
diff --git a/qemu-options.hx b/qemu-options.hx
index d4f3564b78..ebd11220c4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2556,8 +2556,9 @@ undefined if TCP options are specified for a unix socket.
 
 @option{server} specifies that the socket shall be a listening socket.
 
-@option{nowait} specifies that QEMU should not block waiting for a client to
-connect to a listening socket.
+@option{nowait} specifies that QEMU should not wait for being connected on
+server sockets or try to do a sync/async connect on client sockets during
+initialization of the chardev.
 
 @option{telnet} specifies that traffic on the socket should interpret telnet
 escape sequences.
@@ -3093,7 +3094,9 @@ I/O to a location or wait for a connection from a location.  By default
 the TCP Net Console is sent to @var{host} at the @var{port}.  If you use
 the @var{server} option QEMU will wait for a client socket application
 to connect to the port before continuing, unless the @code{nowait}
-option was specified.  The @code{nodelay} option disables the Nagle buffering
+option was specified. And the @code{nowait} option could also be
+used when @var{noserver} is set to disallow QEMU to connect during
+initialization.  The @code{nodelay} option disables the Nagle buffering
 algorithm.  The @code{reconnect} option only applies if @var{noserver} is
 set, if the connection goes down it will attempt to reconnect at the
 given interval.  If @var{host} is omitted, 0.0.0.0 is assumed. Only
-- 
2.17.1
