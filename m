Received: from eggs.gnu.org ([2001:4830:134:3::10]:44833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnS-0000pg-MW
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnR-0005U5-12
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVxnQ-0005T4-Nr
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:48 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D58A1C04B320
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:53:48 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 09:53:28 +0000
Message-Id: <20170124095332.23955-5-berrange@redhat.com>
In-Reply-To: <20170124095332.23955-1-berrange@redhat.com>
References: <20170124095332.23955-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/8] ui: refactor code for populating
 SocketAddress from vnc_display_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The code which interprets the CLI args to populate the SocketAddress
objects for plain & websockets VNC is quite complex already and will
need further enhancements shortly. Refactor it into separate methods
to avoid vnc_display_open getting even larger. As a side effect of
the refactoring, it is now possible to specify a listen address for
the websocket server explicitly. e.g,

  -vnc localhost:5900,websockets=0.0.0.0:8080

will listen on localhost for the plain VNC server, but expose the
websockets VNC server on the public interface. This refactoring
also removes the restriction that prevents enabling websockets
when the plain VNC server is listening on a UNIX socket.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-options.hx |  12 ++-
 ui/vnc.c        | 282 ++++++++++++++++++++++++++++++++++++--------------------
 2 files changed, 189 insertions(+), 105 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 80df526..c1c2903 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1297,10 +1297,14 @@ is a TCP port number, not a display number.
 @item websocket
 
 Opens an additional TCP listening port dedicated to VNC Websocket connections.
-By definition the Websocket port is 5700+@var{display}. If @var{host} is
-specified connections will only be allowed from this host.
-As an alternative the Websocket port could be specified by using
-@code{websocket}=@var{port}.
+If a bare @var{websocket} option is given, the Websocket port is
+5700+@var{display}. An alternative port can be specified with the
+syntax @code{websocket}=@var{port}.
+
+If @var{host} is specified connections will only be allowed from this host.
+It is possible to control the websocket listen address independently, using
+the syntax @code{websocket}=@var{host}:@var{port}.
+
 If no TLS credentials are provided, the websocket connection runs in
 unencrypted mode. If TLS credentials are provided, the websocket connection
 requires encrypted client connections.
diff --git a/ui/vnc.c b/ui/vnc.c
index 9b9682d..f0335d8 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3523,6 +3523,178 @@ vnc_display_create_creds(bool x509,
 }
 
 
+static int vnc_display_get_address(const char *addrstr,
+                                   bool websocket,
+                                   int displaynum,
+                                   int to,
+                                   bool has_ipv4,
+                                   bool has_ipv6,
+                                   bool ipv4,
+                                   bool ipv6,
+                                   SocketAddress **retaddr,
+                                   Error **errp)
+{
+    int ret = -1;
+    SocketAddress *addr = NULL;
+
+    addr = g_new0(SocketAddress, 1);
+
+    if (strncmp(addrstr, "unix:", 5) == 0) {
+        addr->type = SOCKET_ADDRESS_KIND_UNIX;
+        addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
+        addr->u.q_unix.data->path = g_strdup(addrstr + 5);
+
+        if (websocket) {
+            error_setg(errp, "UNIX sockets not supported with websock");
+            goto cleanup;
+        }
+
+        if (to) {
+            error_setg(errp, "Port range not support with UNIX socket");
+            goto cleanup;
+        }
+        ret = 0;
+    } else {
+        const char *port;
+        size_t hostlen;
+        unsigned long long baseport;
+        InetSocketAddress *inet;
+
+        port = strrchr(addrstr, ':');
+        if (!port) {
+            if (websocket) {
+                hostlen = 0;
+                port = addrstr;
+            } else {
+                error_setg(errp, "no vnc port specified");
+                goto cleanup;
+            }
+        } else {
+            hostlen = port - addrstr;
+            port++;
+            if (*port == '\0') {
+                error_setg(errp, "vnc port cannot be empty");
+                goto cleanup;
+            }
+        }
+
+        addr->type = SOCKET_ADDRESS_KIND_INET;
+        inet = addr->u.inet.data = g_new0(InetSocketAddress, 1);
+        if (addrstr[0] == '[' && addrstr[hostlen - 1] == ']') {
+            inet->host = g_strndup(addrstr + 1, hostlen - 2);
+        } else {
+            inet->host = g_strndup(addrstr, hostlen);
+        }
+        /* plain VNC port is just an offset, for websocket
+         * port is absolute */
+        if (websocket) {
+            if (g_str_equal(addrstr, "") ||
+                g_str_equal(addrstr, "on")) {
+                inet->port = g_strdup_printf(
+                    "%d", displaynum + 5700);
+                if (to) {
+                    inet->has_to = true;
+                    inet->to = to + 5700;
+                }
+            } else {
+                inet->port = g_strdup(port);
+            }
+        } else {
+            if (parse_uint_full(port, &baseport, 10) < 0) {
+                error_setg(errp, "can't convert to a number: %s", port);
+                goto cleanup;
+            }
+            if (baseport > 65535 ||
+                baseport + 5900 > 65535) {
+                error_setg(errp, "port %s out of range", port);
+                goto cleanup;
+            }
+            inet->port = g_strdup_printf(
+                "%d", (int)baseport + 5900);
+
+            if (to) {
+                inet->has_to = true;
+                inet->to = to + 5900;
+            }
+        }
+
+        inet->ipv4 = ipv4;
+        inet->has_ipv4 = has_ipv4;
+        inet->ipv6 = ipv6;
+        inet->has_ipv6 = has_ipv6;
+
+        ret = baseport;
+    }
+
+    *retaddr = addr;
+
+ cleanup:
+    if (ret < 0) {
+        qapi_free_SocketAddress(addr);
+    }
+    return ret;
+}
+
+static int vnc_display_get_addresses(QemuOpts *opts,
+                                     SocketAddress **retsaddr,
+                                     SocketAddress **retwsaddr,
+                                     Error **errp)
+{
+    SocketAddress *saddr = NULL;
+    SocketAddress *wsaddr = NULL;
+    const char *saddrstr = qemu_opt_get(opts, "vnc");
+    const char *wsaddrstr = qemu_opt_get(opts, "websocket");
+    int to = qemu_opt_get_number(opts, "to", 0);
+    bool has_ipv4 = qemu_opt_get(opts, "ipv4");
+    bool has_ipv6 = qemu_opt_get(opts, "ipv6");
+    bool ipv4 = qemu_opt_get_bool(opts, "ipv4", false);
+    bool ipv6 = qemu_opt_get_bool(opts, "ipv6", false);
+
+    if (!saddrstr || strcmp(saddrstr, "none") == 0) {
+        *retsaddr = NULL;
+        *retwsaddr = NULL;
+        return 0;
+    }
+
+    if (wsaddrstr &&
+        !qcrypto_hash_supports(QCRYPTO_HASH_ALG_SHA1)) {
+        error_setg(errp,
+                   "SHA1 hash support is required for websockets");
+        goto error;
+    }
+
+    int displaynum = vnc_display_get_address(saddrstr, false, 0, to,
+                                             has_ipv4, has_ipv6,
+                                             ipv4, ipv6,
+                                             &saddr, errp);
+    if (displaynum < 0) {
+        goto error;
+    }
+    if (wsaddrstr) {
+        if (vnc_display_get_address(wsaddrstr, true, displaynum, to,
+                                    has_ipv4, has_ipv6,
+                                    ipv4, ipv6,
+                                    &wsaddr, errp) < 0) {
+            goto error;
+        }
+        if (saddr->type == SOCKET_ADDRESS_KIND_INET &&
+            wsaddr->type == SOCKET_ADDRESS_KIND_INET &&
+            g_str_equal(wsaddr->u.inet.data->host, "") &&
+            !g_str_equal(saddr->u.inet.data->host, "")) {
+            g_free(wsaddr->u.inet.data->host);
+            wsaddr->u.inet.data->host = g_strdup(saddr->u.inet.data->host);
+        }
+    }
+    *retsaddr = saddr;
+    *retwsaddr = wsaddr;
+    return 0;
+
+ error:
+    qapi_free_SocketAddress(saddr);
+    qapi_free_SocketAddress(wsaddr);
+    return -1;
+}
+
 void vnc_display_open(const char *id, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
@@ -3532,10 +3704,7 @@ void vnc_display_open(const char *id, Error **errp)
     QemuConsole *con;
     bool password = false;
     bool reverse = false;
-    const char *vnc;
-    char *h;
     const char *credid;
-    int show_vnc_port = 0;
     bool sasl = false;
 #ifdef CONFIG_VNC_SASL
     int saslErr;
@@ -3543,7 +3712,6 @@ void vnc_display_open(const char *id, Error **errp)
     int acl = 0;
     int lock_key_sync = 1;
     int key_delay_ms;
-    bool ws_enabled = false;
 
     if (!vd) {
         error_setg(errp, "VNC display not active");
@@ -3554,102 +3722,15 @@ void vnc_display_open(const char *id, Error **errp)
     if (!opts) {
         return;
     }
-    vnc = qemu_opt_get(opts, "vnc");
-    if (!vnc || strcmp(vnc, "none") == 0) {
-        return;
-    }
-
-    h = strrchr(vnc, ':');
-    if (h) {
-        size_t hlen = h - vnc;
 
-        const char *websocket = qemu_opt_get(opts, "websocket");
-        int to = qemu_opt_get_number(opts, "to", 0);
-        bool has_ipv4 = qemu_opt_get(opts, "ipv4");
-        bool has_ipv6 = qemu_opt_get(opts, "ipv6");
-        bool ipv4 = qemu_opt_get_bool(opts, "ipv4", false);
-        bool ipv6 = qemu_opt_get_bool(opts, "ipv6", false);
-
-        saddr = g_new0(SocketAddress, 1);
-        if (websocket) {
-            if (!qcrypto_hash_supports(QCRYPTO_HASH_ALG_SHA1)) {
-                error_setg(errp,
-                           "SHA1 hash support is required for websockets");
-                goto fail;
-            }
-
-            wsaddr = g_new0(SocketAddress, 1);
-            ws_enabled = true;
-        }
-
-        if (strncmp(vnc, "unix:", 5) == 0) {
-            saddr->type = SOCKET_ADDRESS_KIND_UNIX;
-            saddr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
-            saddr->u.q_unix.data->path = g_strdup(vnc + 5);
-
-            if (ws_enabled) {
-                error_setg(errp, "UNIX sockets not supported with websock");
-                goto fail;
-            }
-        } else {
-            unsigned long long baseport;
-            InetSocketAddress *inet;
-            saddr->type = SOCKET_ADDRESS_KIND_INET;
-            inet = saddr->u.inet.data = g_new0(InetSocketAddress, 1);
-            if (vnc[0] == '[' && vnc[hlen - 1] == ']') {
-                inet->host = g_strndup(vnc + 1, hlen - 2);
-            } else {
-                inet->host = g_strndup(vnc, hlen);
-            }
-            if (parse_uint_full(h + 1, &baseport, 10) < 0) {
-                error_setg(errp, "can't convert to a number: %s", h + 1);
-                goto fail;
-            }
-            if (baseport > 65535 ||
-                baseport + 5900 > 65535) {
-                error_setg(errp, "port %s out of range", h + 1);
-                goto fail;
-            }
-            inet->port = g_strdup_printf(
-                "%d", (int)baseport + 5900);
-
-            if (to) {
-                inet->has_to = true;
-                inet->to = to + 5900;
-                show_vnc_port = 1;
-            }
-            inet->ipv4 = ipv4;
-            inet->has_ipv4 = has_ipv4;
-            inet->ipv6 = ipv6;
-            inet->has_ipv6 = has_ipv6;
-
-            if (ws_enabled) {
-                wsaddr->type = SOCKET_ADDRESS_KIND_INET;
-                inet = wsaddr->u.inet.data = g_new0(InetSocketAddress, 1);
-                inet->host = g_strdup(saddr->u.inet.data->host);
-                if (g_str_equal(websocket, "") ||
-                    g_str_equal(websocket, "on")) {
-                    inet->port = g_strdup_printf(
-                        "%d", (int)baseport + 5700);
-                } else {
-                    inet->port = g_strdup(websocket);
-                }
-
-                if (to) {
-                    inet->has_to = true;
-                    inet->to = to;
-                }
-                inet->ipv4 = ipv4;
-                inet->has_ipv4 = has_ipv4;
-                inet->ipv6 = ipv6;
-                inet->has_ipv6 = has_ipv6;
-            }
-        }
-    } else {
-        error_setg(errp, "no vnc port specified");
+    if (vnc_display_get_addresses(opts, &saddr, &wsaddr, errp) < 0) {
         goto fail;
     }
 
+    if (saddr == NULL) {
+        return;
+    }
+
     password = qemu_opt_get_bool(opts, "password", false);
     if (password) {
         if (fips_get_state()) {
@@ -3834,7 +3915,7 @@ void vnc_display_open(const char *id, Error **errp)
     if (reverse) {
         /* connect to viewer */
         QIOChannelSocket *sioc = NULL;
-        if (ws_enabled) {
+        if (wsaddr) {
             error_setg(errp, "Cannot use websockets in reverse mode");
             goto fail;
         }
@@ -3858,7 +3939,7 @@ void vnc_display_open(const char *id, Error **errp)
         }
         vd->is_unix = saddr->type == SOCKET_ADDRESS_KIND_UNIX;
 
-        if (ws_enabled) {
+        if (wsaddr) {
             vd->nlwebsock = 1;
             vd->lwebsock = g_new0(QIOChannelSocket *, 1);
             vd->lwebsock_tag = g_new0(guint, 1);
@@ -3874,14 +3955,14 @@ void vnc_display_open(const char *id, Error **errp)
         vd->lsock_tag[0] = qio_channel_add_watch(
             QIO_CHANNEL(vd->lsock[0]),
             G_IO_IN, vnc_listen_io, vd, NULL);
-        if (ws_enabled) {
+        if (wsaddr) {
             vd->lwebsock_tag[0] = qio_channel_add_watch(
                 QIO_CHANNEL(vd->lwebsock[0]),
                 G_IO_IN, vnc_listen_io, vd, NULL);
         }
     }
 
-    if (show_vnc_port) {
+    if (qemu_opt_get(opts, "to")) {
         vnc_display_print_local_addr(vd);
     }
 
@@ -3893,7 +3974,6 @@ fail:
     vnc_display_close(vd);
     qapi_free_SocketAddress(saddr);
     qapi_free_SocketAddress(wsaddr);
-    ws_enabled = false;
 }
 
 void vnc_display_add_client(const char *id, int csock, bool skipauth)
-- 
2.9.3
