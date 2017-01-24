Received: from eggs.gnu.org ([2001:4830:134:3::10]:44868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnW-0000tX-TZ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnV-0005VO-6V
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVxnU-0005VF-Uq
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:53 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 062997E9C5
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:53:53 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 09:53:30 +0000
Message-Id: <20170124095332.23955-7-berrange@redhat.com>
In-Reply-To: <20170124095332.23955-1-berrange@redhat.com>
References: <20170124095332.23955-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/8] ui: let VNC server listen on all
 resolved IP addresses
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

Remove the limitation that the VNC server can only listen on
a single resolved IP address. This uses the new DNS resolver
API to resolve a SocketAddress struct into an array of
SocketAddress structs containing raw IP addresses. The VNC
server will then attempt to listen on all resolved IP addresses.
The server must successfully listen on at least one of the
resolved IP addresses, otherwise an error will be reported.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 52 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 8e05c33..82759c6 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -45,6 +45,7 @@
 #include "crypto/tlscredsx509.h"
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
+#include "io/dns-resolver.h"
 
 #define VNC_REFRESH_INTERVAL_BASE GUI_REFRESH_INTERVAL_DEFAULT
 #define VNC_REFRESH_INTERVAL_INC  50
@@ -3726,19 +3727,52 @@ static int vnc_display_listen_addr(VncDisplay *vd,
                                    size_t *nlsock,
                                    Error **errp)
 {
-    *nlsock = 1;
-    *lsock = g_new0(QIOChannelSocket *, 1);
-    *lsock_tag = g_new0(guint, 1);
+    QIODNSResolver *resolver = qio_dns_resolver_get_instance();
+    SocketAddress **rawaddrs = NULL;
+    size_t nrawaddrs = 0;
+    Error *listenerr = NULL;
+    size_t i;
 
-    (*lsock)[0] = qio_channel_socket_new();
-    qio_channel_set_name(QIO_CHANNEL((*lsock)[0]), name);
-    if (qio_channel_socket_listen_sync((*lsock)[0], addr, errp) < 0) {
+    if (qio_dns_resolver_lookup_sync(resolver, addr, &nrawaddrs,
+                                     &rawaddrs, errp) < 0) {
         return -1;
     }
 
-    (*lsock_tag)[0] = qio_channel_add_watch(
-        QIO_CHANNEL((*lsock)[0]),
-        G_IO_IN, vnc_listen_io, vd, NULL);
+    for (i = 0; i < nrawaddrs; i++) {
+        QIOChannelSocket *sioc = qio_channel_socket_new();
+
+        qio_channel_set_name(QIO_CHANNEL(sioc), name);
+        if (qio_channel_socket_listen_sync(
+                sioc, rawaddrs[i], listenerr == NULL ? &listenerr : NULL) < 0) {
+            continue;
+        }
+        (*nlsock)++;
+        *lsock = g_renew(QIOChannelSocket *, *lsock, *nlsock);
+        *lsock_tag = g_renew(guint, *lsock_tag, *nlsock);
+
+        (*lsock)[*nlsock - 1] = sioc;
+        (*lsock_tag)[*nlsock - 1] = 0;
+    }
+
+    for (i = 0; i < nrawaddrs; i++) {
+        qapi_free_SocketAddress(rawaddrs[i]);
+    }
+    g_free(rawaddrs);
+
+    if (listenerr) {
+        if (*nlsock == 0) {
+            error_propagate(errp, listenerr);
+            return -1;
+        } else {
+            error_free(listenerr);
+        }
+    }
+
+    for (i = 0; i < *nlsock; i++) {
+        (*lsock_tag)[i] = qio_channel_add_watch(
+            QIO_CHANNEL((*lsock)[i]),
+            G_IO_IN, vnc_listen_io, vd, NULL);
+    }
 
     return 0;
 }
-- 
2.9.3
