Received: from eggs.gnu.org ([2001:4830:134:3::10]:46709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpzP-0006Xg-MC
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpzN-0003wM-Vq
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:07:15 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 17:04:50 +0100
Message-Id: <20170810160451.32723-8-berrange@redhat.com>
In-Reply-To: <20170810160451.32723-1-berrange@redhat.com>
References: <20170810160451.32723-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 7/8] ui: convert VNC server to QIONetListener
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

The VNC server already has the ability to listen on multiple sockets.
Converting it to use the QIONetListener APIs though, will reduce the
amount of code in the VNC server and improve the clarity of what is
left.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 194 ++++++++++++++++++---------------------------------------------
 ui/vnc.h |   9 +--
 2 files changed, 57 insertions(+), 146 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 651cbb8606..5b78541575 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -227,12 +227,12 @@ static VncServerInfo *vnc_server_info_get(VncDisplay *vd)
     VncServerInfo *info;
     Error *err = NULL;
 
-    if (!vd->nlsock) {
+    if (!vd->listener || !vd->listener->nsioc) {
         return NULL;
     }
 
     info = g_malloc0(sizeof(*info));
-    vnc_init_basic_info_from_server_addr(vd->lsock[0],
+    vnc_init_basic_info_from_server_addr(vd->listener->sioc[0],
                                          qapi_VncServerInfo_base(info), &err);
     info->has_auth = true;
     info->auth = g_strdup(vnc_auth_name(vd));
@@ -378,7 +378,7 @@ VncInfo *qmp_query_vnc(Error **errp)
     VncDisplay *vd = vnc_display_find(NULL);
     SocketAddress *addr = NULL;
 
-    if (vd == NULL || !vd->nlsock) {
+    if (vd == NULL || !vd->listener || !vd->listener->nsioc) {
         info->enabled = false;
     } else {
         info->enabled = true;
@@ -387,11 +387,7 @@ VncInfo *qmp_query_vnc(Error **errp)
         info->has_clients = true;
         info->clients = qmp_query_client_list(vd);
 
-        if (vd->lsock == NULL) {
-            return info;
-        }
-
-        addr = qio_channel_socket_get_local_address(vd->lsock[0], errp);
+        addr = qio_channel_socket_get_local_address(vd->listener->sioc[0], errp);
         if (!addr) {
             goto out_error;
         }
@@ -571,13 +567,14 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
             info->has_display = true;
             info->display = g_strdup(dev->id);
         }
-        for (i = 0; i < vd->nlsock; i++) {
+        for (i = 0; vd->listener != NULL && i < vd->listener->nsioc; i++) {
             info->server = qmp_query_server_entry(
-                vd->lsock[i], false, vd->auth, vd->subauth, info->server);
+                vd->listener->sioc[i], false, vd->auth, vd->subauth,
+                info->server);
         }
-        for (i = 0; i < vd->nlwebsock; i++) {
+        for (i = 0; vd->wslistener != NULL && i < vd->wslistener->nsioc; i++) {
             info->server = qmp_query_server_entry(
-                vd->lwebsock[i], true, vd->ws_auth,
+                vd->wslistener->sioc[i], true, vd->ws_auth,
                 vd->ws_subauth, info->server);
         }
 
@@ -2991,36 +2988,18 @@ void vnc_start_protocol(VncState *vs)
     qemu_add_mouse_mode_change_notifier(&vs->mouse_mode_notifier);
 }
 
-static gboolean vnc_listen_io(QIOChannel *ioc,
-                              GIOCondition condition,
-                              void *opaque)
+static void vnc_listen_io(QIONetListener *listener,
+                          QIOChannelSocket *cioc,
+                          void *opaque)
 {
     VncDisplay *vd = opaque;
-    QIOChannelSocket *sioc = NULL;
-    Error *err = NULL;
-    bool isWebsock = false;
-    size_t i;
-
-    for (i = 0; i < vd->nlwebsock; i++) {
-        if (ioc == QIO_CHANNEL(vd->lwebsock[i])) {
-            isWebsock = true;
-            break;
-        }
-    }
-
-    sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc), &err);
-    if (sioc != NULL) {
-        qio_channel_set_name(QIO_CHANNEL(sioc),
-                             isWebsock ? "vnc-ws-server" : "vnc-server");
-        qio_channel_set_delay(QIO_CHANNEL(sioc), false);
-        vnc_connect(vd, sioc, false, isWebsock);
-        object_unref(OBJECT(sioc));
-    } else {
-        /* client probably closed connection before we got there */
-        error_free(err);
-    }
+    bool isWebsock = listener == vd->wslistener;
 
-    return TRUE;
+    qio_channel_set_name(QIO_CHANNEL(cioc),
+                         isWebsock ? "vnc-ws-server" : "vnc-server");
+    qio_channel_set_delay(QIO_CHANNEL(cioc), false);
+    vnc_connect(vd, cioc, false, isWebsock);
+    object_unref(OBJECT(cioc));
 }
 
 static const DisplayChangeListenerOps dcl_ops = {
@@ -3072,34 +3051,22 @@ void vnc_display_init(const char *id)
 
 static void vnc_display_close(VncDisplay *vd)
 {
-    size_t i;
     if (!vd) {
         return;
     }
     vd->is_unix = false;
-    for (i = 0; i < vd->nlsock; i++) {
-        if (vd->lsock_tag[i]) {
-            g_source_remove(vd->lsock_tag[i]);
-        }
-        object_unref(OBJECT(vd->lsock[i]));
+
+    if (vd->listener) {
+        qio_net_listener_disconnect(vd->listener);
+        object_unref(OBJECT(vd->listener));
     }
-    g_free(vd->lsock);
-    g_free(vd->lsock_tag);
-    vd->lsock = NULL;
-    vd->lsock_tag = NULL;
-    vd->nlsock = 0;
+    vd->listener = NULL;
 
-    for (i = 0; i < vd->nlwebsock; i++) {
-        if (vd->lwebsock_tag[i]) {
-            g_source_remove(vd->lwebsock_tag[i]);
-        }
-        object_unref(OBJECT(vd->lwebsock[i]));
+    if (vd->wslistener) {
+        qio_net_listener_disconnect(vd->wslistener);
+        object_unref(OBJECT(vd->wslistener));
     }
-    g_free(vd->lwebsock);
-    g_free(vd->lwebsock_tag);
-    vd->lwebsock = NULL;
-    vd->lwebsock_tag = NULL;
-    vd->nlwebsock = 0;
+    vd->wslistener = NULL;
 
     vd->auth = VNC_AUTH_INVALID;
     vd->subauth = VNC_AUTH_INVALID;
@@ -3151,11 +3118,11 @@ static void vnc_display_print_local_addr(VncDisplay *vd)
     SocketAddress *addr;
     Error *err = NULL;
 
-    if (!vd->nlsock) {
+    if (!vd->listener || !vd->listener->nsioc) {
         return;
     }
 
-    addr = qio_channel_socket_get_local_address(vd->lsock[0], &err);
+    addr = qio_channel_socket_get_local_address(vd->listener->sioc[0], &err);
     if (!addr) {
         return;
     }
@@ -3663,68 +3630,6 @@ static int vnc_display_connect(VncDisplay *vd,
 }
 
 
-static int vnc_display_listen_addr(VncDisplay *vd,
-                                   SocketAddress *addr,
-                                   const char *name,
-                                   QIOChannelSocket ***lsock,
-                                   guint **lsock_tag,
-                                   size_t *nlsock,
-                                   Error **errp)
-{
-    QIODNSResolver *resolver = qio_dns_resolver_get_instance();
-    SocketAddress **rawaddrs = NULL;
-    size_t nrawaddrs = 0;
-    Error *listenerr = NULL;
-    bool listening = false;
-    size_t i;
-
-    if (qio_dns_resolver_lookup_sync(resolver, addr, &nrawaddrs,
-                                     &rawaddrs, errp) < 0) {
-        return -1;
-    }
-
-    for (i = 0; i < nrawaddrs; i++) {
-        QIOChannelSocket *sioc = qio_channel_socket_new();
-
-        qio_channel_set_name(QIO_CHANNEL(sioc), name);
-        if (qio_channel_socket_listen_sync(
-                sioc, rawaddrs[i], listenerr == NULL ? &listenerr : NULL) < 0) {
-            object_unref(OBJECT(sioc));
-            continue;
-        }
-        listening = true;
-        (*nlsock)++;
-        *lsock = g_renew(QIOChannelSocket *, *lsock, *nlsock);
-        *lsock_tag = g_renew(guint, *lsock_tag, *nlsock);
-
-        (*lsock)[*nlsock - 1] = sioc;
-        (*lsock_tag)[*nlsock - 1] = 0;
-    }
-
-    for (i = 0; i < nrawaddrs; i++) {
-        qapi_free_SocketAddress(rawaddrs[i]);
-    }
-    g_free(rawaddrs);
-
-    if (listenerr) {
-        if (!listening) {
-            error_propagate(errp, listenerr);
-            return -1;
-        } else {
-            error_free(listenerr);
-        }
-    }
-
-    for (i = 0; i < *nlsock; i++) {
-        (*lsock_tag)[i] = qio_channel_add_watch(
-            QIO_CHANNEL((*lsock)[i]),
-            G_IO_IN, vnc_listen_io, vd, NULL);
-    }
-
-    return 0;
-}
-
-
 static int vnc_display_listen(VncDisplay *vd,
                               SocketAddress **saddr,
                               size_t nsaddr,
@@ -3734,25 +3639,34 @@ static int vnc_display_listen(VncDisplay *vd,
 {
     size_t i;
 
-    for (i = 0; i < nsaddr; i++) {
-        if (vnc_display_listen_addr(vd, saddr[i],
-                                    "vnc-listen",
-                                    &vd->lsock,
-                                    &vd->lsock_tag,
-                                    &vd->nlsock,
-                                    errp) < 0) {
-            return -1;
+    if (nsaddr) {
+        vd->listener = qio_net_listener_new();
+        qio_net_listener_set_name(vd->listener, "vnc-listen");
+        for (i = 0; i < nsaddr; i++) {
+            if (qio_net_listener_open_sync(vd->listener,
+                                           saddr[i],
+                                           errp) < 0)  {
+                return -1;
+            }
         }
+
+        qio_net_listener_set_client_func(vd->listener,
+                                         vnc_listen_io, vd, NULL);
     }
-    for (i = 0; i < nwsaddr; i++) {
-        if (vnc_display_listen_addr(vd, wsaddr[i],
-                                    "vnc-ws-listen",
-                                    &vd->lwebsock,
-                                    &vd->lwebsock_tag,
-                                    &vd->nlwebsock,
-                                    errp) < 0) {
-            return -1;
+
+    if (nwsaddr) {
+        vd->wslistener = qio_net_listener_new();
+        qio_net_listener_set_name(vd->wslistener, "vnc-ws-listen");
+        for (i = 0; i < nwsaddr; i++) {
+            if (qio_net_listener_open_sync(vd->wslistener,
+                                           wsaddr[i],
+                                           errp) < 0)  {
+                return -1;
+            }
         }
+
+        qio_net_listener_set_client_func(vd->wslistener,
+                                         vnc_listen_io, vd, NULL);
     }
 
     return 0;
diff --git a/ui/vnc.h b/ui/vnc.h
index 694cf32ca9..d6f685b473 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -37,6 +37,7 @@
 #include "qemu/buffer.h"
 #include "io/channel-socket.h"
 #include "io/channel-tls.h"
+#include "io/net-listener.h"
 #include <zlib.h>
 
 #include "keymaps.h"
@@ -146,12 +147,8 @@ struct VncDisplay
     int num_exclusive;
     int connections_limit;
     VncSharePolicy share_policy;
-    size_t nlsock;
-    QIOChannelSocket **lsock;
-    guint *lsock_tag;
-    size_t nlwebsock;
-    QIOChannelSocket **lwebsock;
-    guint *lwebsock_tag;
+    QIONetListener *listener;
+    QIONetListener *wslistener;
     DisplaySurface *ds;
     DisplayChangeListener dcl;
     kbd_layout_t *kbd_layout;
-- 
2.13.3
