Received: from eggs.gnu.org ([2001:4830:134:3::10]:55146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzijv-0002kO-Uo
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dziju-0005OA-N1
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dziju-0005Mx-DG
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:26 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  4 Oct 2017 13:25:08 +0100
Message-Id: <20171004122515.20627-5-berrange@redhat.com>
In-Reply-To: <20171004122515.20627-1-berrange@redhat.com>
References: <20171004122515.20627-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 04/11] ui: Always remove an old VNC channel
 watch before adding a new one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Brandon Carpenter <brandon.carpenter@cypherpath.com>

From: Brandon Carpenter <brandon.carpenter@cypherpath.com>

Also set saved handle to zero when removing without adding a new watch.

Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc-auth-vencrypt.c | 3 +++
 ui/vnc-ws.c            | 6 ++++++
 ui/vnc.c               | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/ui/vnc-auth-vencrypt.c b/ui/vnc-auth-vencrypt.c
index f0bec204b3..7833631275 100644
--- a/ui/vnc-auth-vencrypt.c
+++ b/ui/vnc-auth-vencrypt.c
@@ -75,6 +75,9 @@ static void vnc_tls_handshake_done(QIOTask *task,
         vnc_client_error(vs);
         error_free(err);
     } else {
+        if (vs->ioc_tag) {
+            g_source_remove(vs->ioc_tag);
+        }
         vs->ioc_tag = qio_channel_add_watch(
             vs->ioc, G_IO_IN | G_IO_OUT, vnc_client_io, vs, NULL);
         start_auth_vencrypt_subauth(vs);
diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
index aeaafe2c21..6ccad22cef 100644
--- a/ui/vnc-ws.c
+++ b/ui/vnc-ws.c
@@ -37,6 +37,9 @@ static void vncws_tls_handshake_done(QIOTask *task,
         error_free(err);
     } else {
         VNC_DEBUG("TLS handshake complete, starting websocket handshake\n");
+        if (vs->ioc_tag) {
+            g_source_remove(vs->ioc_tag);
+        }
         vs->ioc_tag = qio_channel_add_watch(
             QIO_CHANNEL(vs->ioc), G_IO_IN, vncws_handshake_io, vs, NULL);
     }
@@ -97,6 +100,9 @@ static void vncws_handshake_done(QIOTask *task,
     } else {
         VNC_DEBUG("Websock handshake complete, starting VNC protocol\n");
         vnc_start_protocol(vs);
+        if (vs->ioc_tag) {
+            g_source_remove(vs->ioc_tag);
+        }
         vs->ioc_tag = qio_channel_add_watch(
             vs->ioc, G_IO_IN, vnc_client_io, vs, NULL);
     }
diff --git a/ui/vnc.c b/ui/vnc.c
index af810f0547..9f8d5a1b1f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1122,6 +1122,7 @@ static void vnc_disconnect_start(VncState *vs)
     vnc_set_share_mode(vs, VNC_SHARE_MODE_DISCONNECTED);
     if (vs->ioc_tag) {
         g_source_remove(vs->ioc_tag);
+        vs->ioc_tag = 0;
     }
     qio_channel_close(vs->ioc, NULL);
     vs->disconnecting = TRUE;
@@ -2934,6 +2935,9 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
     VNC_DEBUG("New client on socket %p\n", vs->sioc);
     update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
     qio_channel_set_blocking(vs->ioc, false, NULL);
+    if (vs->ioc_tag) {
+        g_source_remove(vs->ioc_tag);
+    }
     if (websocket) {
         vs->websocket = 1;
         if (vd->tlscreds) {
-- 
2.13.5
