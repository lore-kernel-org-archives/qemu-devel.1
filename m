Received: from eggs.gnu.org ([2001:4830:134:3::10]:44795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnP-0000l6-B9
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnO-0005Sa-2v
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVxnN-0005SD-QC
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:45 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E447A624A4
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:53:45 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 09:53:27 +0000
Message-Id: <20170124095332.23955-4-berrange@redhat.com>
In-Reply-To: <20170124095332.23955-1-berrange@redhat.com>
References: <20170124095332.23955-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/8] ui: refactor VncDisplay to allow
 multiple listening sockets
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

Currently there is only a single listener for plain VNC and
a single listener for websockets VNC. This means that if
getaddrinfo() returns multiple IP addresses, for a hostname,
the VNC server can only listen on one of them. This is
just bearable if listening on wildcard interface, or if
the host only has a single network interface to listen on,
but if there are multiple NICs and the VNC server needs
to listen on 2 or more specific IP addresses, it can't be
done.

This refactors the VncDisplay state so that it holds an
array of listening sockets, but still only listens on
one socket.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 103 +++++++++++++++++++++++++++++++++++++++++----------------------
 ui/vnc.h |  10 ++++---
 2 files changed, 73 insertions(+), 40 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index bd81922..9b9682d 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -224,8 +224,12 @@ static VncServerInfo *vnc_server_info_get(VncDisplay *vd)
     VncServerInfo *info;
     Error *err = NULL;
 
+    if (!vd->nlsock) {
+        return NULL;
+    }
+
     info = g_malloc0(sizeof(*info));
-    vnc_init_basic_info_from_server_addr(vd->lsock,
+    vnc_init_basic_info_from_server_addr(vd->lsock[0],
                                          qapi_VncServerInfo_base(info), &err);
     info->has_auth = true;
     info->auth = g_strdup(vnc_auth_name(vd));
@@ -371,7 +375,7 @@ VncInfo *qmp_query_vnc(Error **errp)
     VncDisplay *vd = vnc_display_find(NULL);
     SocketAddress *addr = NULL;
 
-    if (vd == NULL || !vd->lsock) {
+    if (vd == NULL || !vd->nlsock) {
         info->enabled = false;
     } else {
         info->enabled = true;
@@ -384,7 +388,7 @@ VncInfo *qmp_query_vnc(Error **errp)
             return info;
         }
 
-        addr = qio_channel_socket_get_local_address(vd->lsock, errp);
+        addr = qio_channel_socket_get_local_address(vd->lsock[0], errp);
         if (!addr) {
             goto out_error;
         }
@@ -547,6 +551,7 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
     VncInfo2 *info;
     VncDisplay *vd;
     DeviceState *dev;
+    size_t i;
 
     QTAILQ_FOREACH(vd, &vnc_displays, next) {
         info = g_new0(VncInfo2, 1);
@@ -560,13 +565,14 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
             info->has_display = true;
             info->display = g_strdup(dev->id);
         }
-        if (vd->lsock != NULL) {
+        for (i = 0; i < vd->nlsock; i++) {
             info->server = qmp_query_server_entry(
-                vd->lsock, false, vd->auth, vd->subauth, info->server);
+                vd->lsock[i], false, vd->auth, vd->subauth, info->server);
         }
-        if (vd->lwebsock != NULL) {
+        for (i = 0; i < vd->nlwebsock; i++) {
             info->server = qmp_query_server_entry(
-                vd->lwebsock, true, vd->ws_auth, vd->ws_subauth, info->server);
+                vd->lwebsock[i], true, vd->ws_auth,
+                vd->ws_subauth, info->server);
         }
 
         item = g_new0(VncInfo2List, 1);
@@ -3116,15 +3122,22 @@ static gboolean vnc_listen_io(QIOChannel *ioc,
     VncDisplay *vd = opaque;
     QIOChannelSocket *sioc = NULL;
     Error *err = NULL;
+    bool isWebsock = false;
+    size_t i;
+
+    for (i = 0; i < vd->nlwebsock; i++) {
+        if (ioc == QIO_CHANNEL(vd->lwebsock[i])) {
+            isWebsock = true;
+            break;
+        }
+    }
 
     sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc), &err);
     if (sioc != NULL) {
         qio_channel_set_name(QIO_CHANNEL(sioc),
-                             ioc != QIO_CHANNEL(vd->lsock) ?
-                             "vnc-ws-server" : "vnc-server");
+                             isWebsock ? "vnc-ws-server" : "vnc-server");
         qio_channel_set_delay(QIO_CHANNEL(sioc), false);
-        vnc_connect(vd, sioc, false,
-                    ioc != QIO_CHANNEL(vd->lsock));
+        vnc_connect(vd, sioc, false, isWebsock);
         object_unref(OBJECT(sioc));
     } else {
         /* client probably closed connection before we got there */
@@ -3184,24 +3197,33 @@ void vnc_display_init(const char *id)
 
 static void vnc_display_close(VncDisplay *vd)
 {
+    size_t i;
     if (!vd) {
         return;
     }
     vd->is_unix = false;
-    if (vd->lsock != NULL) {
-        if (vd->lsock_tag) {
-            g_source_remove(vd->lsock_tag);
+    for (i = 0; i < vd->nlsock; i++) {
+        if (vd->lsock_tag[i]) {
+            g_source_remove(vd->lsock_tag[i]);
         }
-        object_unref(OBJECT(vd->lsock));
-        vd->lsock = NULL;
+        object_unref(OBJECT(vd->lsock[i]));
     }
-    if (vd->lwebsock != NULL) {
-        if (vd->lwebsock_tag) {
-            g_source_remove(vd->lwebsock_tag);
+    g_free(vd->lsock);
+    g_free(vd->lsock_tag);
+    vd->lsock = NULL;
+    vd->nlsock = 0;
+
+    for (i = 0; i < vd->nlwebsock; i++) {
+        if (vd->lwebsock_tag[i]) {
+            g_source_remove(vd->lwebsock_tag[i]);
         }
-        object_unref(OBJECT(vd->lwebsock));
-        vd->lwebsock = NULL;
+        object_unref(OBJECT(vd->lwebsock[i]));
     }
+    g_free(vd->lwebsock);
+    g_free(vd->lwebsock_tag);
+    vd->lwebsock = NULL;
+    vd->nlwebsock = 0;
+
     vd->auth = VNC_AUTH_INVALID;
     vd->subauth = VNC_AUTH_INVALID;
     if (vd->tlscreds) {
@@ -3248,7 +3270,11 @@ static void vnc_display_print_local_addr(VncDisplay *vd)
     SocketAddress *addr;
     Error *err = NULL;
 
-    addr = qio_channel_socket_get_local_address(vd->lsock, &err);
+    if (!vd->nlsock) {
+        return;
+    }
+
+    addr = qio_channel_socket_get_local_address(vd->lsock[0], &err);
     if (!addr) {
         return;
     }
@@ -3808,8 +3834,6 @@ void vnc_display_open(const char *id, Error **errp)
     if (reverse) {
         /* connect to viewer */
         QIOChannelSocket *sioc = NULL;
-        vd->lsock = NULL;
-        vd->lwebsock = NULL;
         if (ws_enabled) {
             error_setg(errp, "Cannot use websockets in reverse mode");
             goto fail;
@@ -3823,30 +3847,36 @@ void vnc_display_open(const char *id, Error **errp)
         vnc_connect(vd, sioc, false, false);
         object_unref(OBJECT(sioc));
     } else {
-        vd->lsock = qio_channel_socket_new();
-        qio_channel_set_name(QIO_CHANNEL(vd->lsock), "vnc-listen");
-        if (qio_channel_socket_listen_sync(vd->lsock, saddr, errp) < 0) {
+        vd->nlsock = 1;
+        vd->lsock = g_new0(QIOChannelSocket *, 1);
+        vd->lsock_tag = g_new0(guint, 1);
+
+        vd->lsock[0] = qio_channel_socket_new();
+        qio_channel_set_name(QIO_CHANNEL(vd->lsock[0]), "vnc-listen");
+        if (qio_channel_socket_listen_sync(vd->lsock[0], saddr, errp) < 0) {
             goto fail;
         }
         vd->is_unix = saddr->type == SOCKET_ADDRESS_KIND_UNIX;
 
         if (ws_enabled) {
-            vd->lwebsock = qio_channel_socket_new();
-            qio_channel_set_name(QIO_CHANNEL(vd->lwebsock), "vnc-ws-listen");
-            if (qio_channel_socket_listen_sync(vd->lwebsock,
+            vd->nlwebsock = 1;
+            vd->lwebsock = g_new0(QIOChannelSocket *, 1);
+            vd->lwebsock_tag = g_new0(guint, 1);
+
+            vd->lwebsock[0] = qio_channel_socket_new();
+            qio_channel_set_name(QIO_CHANNEL(vd->lwebsock[0]), "vnc-ws-listen");
+            if (qio_channel_socket_listen_sync(vd->lwebsock[0],
                                                wsaddr, errp) < 0) {
-                object_unref(OBJECT(vd->lsock));
-                vd->lsock = NULL;
                 goto fail;
             }
         }
 
-        vd->lsock_tag = qio_channel_add_watch(
-            QIO_CHANNEL(vd->lsock),
+        vd->lsock_tag[0] = qio_channel_add_watch(
+            QIO_CHANNEL(vd->lsock[0]),
             G_IO_IN, vnc_listen_io, vd, NULL);
         if (ws_enabled) {
-            vd->lwebsock_tag = qio_channel_add_watch(
-                QIO_CHANNEL(vd->lwebsock),
+            vd->lwebsock_tag[0] = qio_channel_add_watch(
+                QIO_CHANNEL(vd->lwebsock[0]),
                 G_IO_IN, vnc_listen_io, vd, NULL);
         }
     }
@@ -3860,6 +3890,7 @@ void vnc_display_open(const char *id, Error **errp)
     return;
 
 fail:
+    vnc_display_close(vd);
     qapi_free_SocketAddress(saddr);
     qapi_free_SocketAddress(wsaddr);
     ws_enabled = false;
diff --git a/ui/vnc.h b/ui/vnc.h
index d20b154..453695a 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -146,10 +146,12 @@ struct VncDisplay
     int num_exclusive;
     int connections_limit;
     VncSharePolicy share_policy;
-    QIOChannelSocket *lsock;
-    guint lsock_tag;
-    QIOChannelSocket *lwebsock;
-    guint lwebsock_tag;
+    size_t nlsock;
+    QIOChannelSocket **lsock;
+    guint *lsock_tag;
+    size_t nlwebsock;
+    QIOChannelSocket **lwebsock;
+    guint *lwebsock_tag;
     DisplaySurface *ds;
     DisplayChangeListener dcl;
     kbd_layout_t *kbd_layout;
-- 
2.9.3
