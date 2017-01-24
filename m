Received: from eggs.gnu.org ([2001:4830:134:3::10]:44869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnW-0000ta-Tl
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnT-0005V4-LA
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33475)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVxnT-0005Un-Ci
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:51 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B5196330C
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:53:51 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 09:53:29 +0000
Message-Id: <20170124095332.23955-6-berrange@redhat.com>
In-Reply-To: <20170124095332.23955-1-berrange@redhat.com>
References: <20170124095332.23955-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/8] ui: extract code to connect/listen from
 vnc_display_open
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

The code which takes a SocketAddress and connects/listens on the
network is going to get more complicated to deal with multiple
listeners. Pull it out into a separate method to avoid making the
vnc_display_open method even more complex.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 122 +++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 80 insertions(+), 42 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index f0335d8..8e05c33 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3695,6 +3695,84 @@ static int vnc_display_get_addresses(QemuOpts *opts,
     return -1;
 }
 
+static int vnc_display_connect(VncDisplay *vd,
+                               SocketAddress *saddr,
+                               SocketAddress *wsaddr,
+                               Error **errp)
+{
+    /* connect to viewer */
+    QIOChannelSocket *sioc = NULL;
+    if (wsaddr) {
+        error_setg(errp, "Cannot use websockets in reverse mode");
+        return -1;
+    }
+    vd->is_unix = saddr->type == SOCKET_ADDRESS_KIND_UNIX;
+    sioc = qio_channel_socket_new();
+    qio_channel_set_name(QIO_CHANNEL(sioc), "vnc-reverse");
+    if (qio_channel_socket_connect_sync(sioc, saddr, errp) < 0) {
+        return -1;
+    }
+    vnc_connect(vd, sioc, false, false);
+    object_unref(OBJECT(sioc));
+    return 0;
+}
+
+
+static int vnc_display_listen_addr(VncDisplay *vd,
+                                   SocketAddress *addr,
+                                   const char *name,
+                                   QIOChannelSocket ***lsock,
+                                   guint **lsock_tag,
+                                   size_t *nlsock,
+                                   Error **errp)
+{
+    *nlsock = 1;
+    *lsock = g_new0(QIOChannelSocket *, 1);
+    *lsock_tag = g_new0(guint, 1);
+
+    (*lsock)[0] = qio_channel_socket_new();
+    qio_channel_set_name(QIO_CHANNEL((*lsock)[0]), name);
+    if (qio_channel_socket_listen_sync((*lsock)[0], addr, errp) < 0) {
+        return -1;
+    }
+
+    (*lsock_tag)[0] = qio_channel_add_watch(
+        QIO_CHANNEL((*lsock)[0]),
+        G_IO_IN, vnc_listen_io, vd, NULL);
+
+    return 0;
+}
+
+
+static int vnc_display_listen(VncDisplay *vd,
+                              SocketAddress *saddr,
+                              SocketAddress *wsaddr,
+                              Error **errp)
+{
+    vd->is_unix = saddr->type == SOCKET_ADDRESS_KIND_UNIX;
+
+    if (vnc_display_listen_addr(vd, saddr,
+                                "vnc-listen",
+                                &vd->lsock,
+                                &vd->lsock_tag,
+                                &vd->nlsock,
+                                errp) < 0) {
+        return -1;
+    }
+    if (wsaddr &&
+        vnc_display_listen_addr(vd, wsaddr,
+                                "vnc-ws-listen",
+                                &vd->lwebsock,
+                                &vd->lwebsock_tag,
+                                &vd->nlwebsock,
+                                errp) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
+
 void vnc_display_open(const char *id, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
@@ -3913,53 +3991,13 @@ void vnc_display_open(const char *id, Error **errp)
     }
 
     if (reverse) {
-        /* connect to viewer */
-        QIOChannelSocket *sioc = NULL;
-        if (wsaddr) {
-            error_setg(errp, "Cannot use websockets in reverse mode");
-            goto fail;
-        }
-        vd->is_unix = saddr->type == SOCKET_ADDRESS_KIND_UNIX;
-        sioc = qio_channel_socket_new();
-        qio_channel_set_name(QIO_CHANNEL(sioc), "vnc-reverse");
-        if (qio_channel_socket_connect_sync(sioc, saddr, errp) < 0) {
+        if (vnc_display_connect(vd, saddr, wsaddr, errp) < 0) {
             goto fail;
         }
-        vnc_connect(vd, sioc, false, false);
-        object_unref(OBJECT(sioc));
     } else {
-        vd->nlsock = 1;
-        vd->lsock = g_new0(QIOChannelSocket *, 1);
-        vd->lsock_tag = g_new0(guint, 1);
-
-        vd->lsock[0] = qio_channel_socket_new();
-        qio_channel_set_name(QIO_CHANNEL(vd->lsock[0]), "vnc-listen");
-        if (qio_channel_socket_listen_sync(vd->lsock[0], saddr, errp) < 0) {
+        if (vnc_display_listen(vd, saddr, wsaddr, errp) < 0) {
             goto fail;
         }
-        vd->is_unix = saddr->type == SOCKET_ADDRESS_KIND_UNIX;
-
-        if (wsaddr) {
-            vd->nlwebsock = 1;
-            vd->lwebsock = g_new0(QIOChannelSocket *, 1);
-            vd->lwebsock_tag = g_new0(guint, 1);
-
-            vd->lwebsock[0] = qio_channel_socket_new();
-            qio_channel_set_name(QIO_CHANNEL(vd->lwebsock[0]), "vnc-ws-listen");
-            if (qio_channel_socket_listen_sync(vd->lwebsock[0],
-                                               wsaddr, errp) < 0) {
-                goto fail;
-            }
-        }
-
-        vd->lsock_tag[0] = qio_channel_add_watch(
-            QIO_CHANNEL(vd->lsock[0]),
-            G_IO_IN, vnc_listen_io, vd, NULL);
-        if (wsaddr) {
-            vd->lwebsock_tag[0] = qio_channel_add_watch(
-                QIO_CHANNEL(vd->lwebsock[0]),
-                G_IO_IN, vnc_listen_io, vd, NULL);
-        }
     }
 
     if (qemu_opt_get(opts, "to")) {
-- 
2.9.3
