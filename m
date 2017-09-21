Received: from eggs.gnu.org ([2001:4830:134:3::10]:41172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dv0OI-0006ZP-Fi
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dv0OG-0008BB-Cd
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:15:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dv0OG-00089v-4i
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:15:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45817806B6
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 12:15:35 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 21 Sep 2017 13:15:27 +0100
Message-Id: <20170921121528.23935-2-berrange@redhat.com>
In-Reply-To: <20170921121528.23935-1-berrange@redhat.com>
References: <20170921121528.23935-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] ui: add tracing of VNC operations related
 to QIOChannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Trace anything which opens/closes/wraps a QIOChannel in the
VNC server.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/trace-events        |  6 ++++++
 ui/vnc-auth-vencrypt.c |  2 ++
 ui/vnc-ws.c            |  6 +++---
 ui/vnc.c               | 11 ++++++++---
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/ui/trace-events b/ui/trace-events
index 34c2213700..e4c02e47f5 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -29,6 +29,12 @@ vnc_key_event_ext(bool down, int sym, int keycode, const char *name) "down %d, s
 vnc_key_event_map(bool down, int sym, int keycode, const char *name) "down %d, sym 0x%x -> keycode 0x%x [%s]"
 vnc_key_sync_numlock(bool on) "%d"
 vnc_key_sync_capslock(bool on) "%d"
+vnc_client_eof(void *state, void *ioc) "VNC client EOF state=%p ioc=%p"
+vnc_client_io_error(void *state, void *ioc, const char *msg) "VNC client I/O error state=%p ioc=%p errmsg=%s"
+vnc_client_connect(void *state, void *ioc) "VNC client connect state=%p ioc=%p"
+vnc_client_disconnect_start(void *state, void *ioc) "VNC client disconnect start state=%p ioc=%p"
+vnc_client_disconnect_finish(void *state, void *ioc) "VNC client disconnect finish state=%p ioc=%p"
+vnc_client_io_wrap(void *state, void *ioc, const char *type) "VNC client I/O wrap state=%p ioc=%p type=%s"
 
 # ui/input.c
 input_event_key_number(int conidx, int number, const char *qcode, bool down) "con %d, key number 0x%x [%s], down %d"
diff --git a/ui/vnc-auth-vencrypt.c b/ui/vnc-auth-vencrypt.c
index c3eece4fa7..2a3766aa64 100644
--- a/ui/vnc-auth-vencrypt.c
+++ b/ui/vnc-auth-vencrypt.c
@@ -28,6 +28,7 @@
 #include "vnc.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
+#include "trace.h"
 
 static void start_auth_vencrypt_subauth(VncState *vs)
 {
@@ -124,6 +125,7 @@ static int protocol_client_vencrypt_auth(VncState *vs, uint8_t *data, size_t len
         VNC_DEBUG("Start TLS VeNCrypt handshake process\n");
         object_unref(OBJECT(vs->ioc));
         vs->ioc = QIO_CHANNEL(tls);
+        trace_vnc_client_io_wrap(vs, vs->ioc, "tls");
         vs->tls = qio_channel_tls_get_session(tls);
 
         qio_channel_tls_handshake(tls,
diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
index eaf309553c..6ccad22cef 100644
--- a/ui/vnc-ws.c
+++ b/ui/vnc-ws.c
@@ -23,6 +23,7 @@
 #include "vnc.h"
 #include "io/channel-websock.h"
 #include "qemu/bswap.h"
+#include "trace.h"
 
 static void vncws_tls_handshake_done(QIOTask *task,
                                      gpointer user_data)
@@ -53,7 +54,6 @@ gboolean vncws_tls_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
     QIOChannelTLS *tls;
     Error *err = NULL;
 
-    VNC_DEBUG("TLS Websocket connection required\n");
     if (vs->ioc_tag) {
         g_source_remove(vs->ioc_tag);
         vs->ioc_tag = 0;
@@ -73,9 +73,9 @@ gboolean vncws_tls_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
 
     qio_channel_set_name(QIO_CHANNEL(tls), "vnc-ws-server-tls");
 
-    VNC_DEBUG("Start TLS WS handshake process\n");
     object_unref(OBJECT(vs->ioc));
     vs->ioc = QIO_CHANNEL(tls);
+    trace_vnc_client_io_wrap(vs, vs->ioc, "tls");
     vs->tls = qio_channel_tls_get_session(tls);
 
     qio_channel_tls_handshake(tls,
@@ -116,7 +116,6 @@ gboolean vncws_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
     VncState *vs = opaque;
     QIOChannelWebsock *wioc;
 
-    VNC_DEBUG("Websocket negotiate starting\n");
     if (vs->ioc_tag) {
         g_source_remove(vs->ioc_tag);
         vs->ioc_tag = 0;
@@ -127,6 +126,7 @@ gboolean vncws_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
 
     object_unref(OBJECT(vs->ioc));
     vs->ioc = QIO_CHANNEL(wioc);
+    trace_vnc_client_io_wrap(vs, vs->ioc, "websock");
 
     qio_channel_websock_handshake(wioc,
                                   vncws_handshake_done,
diff --git a/ui/vnc.c b/ui/vnc.c
index 62f7a3f30a..47dacc47b6 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1118,6 +1118,7 @@ static void vnc_disconnect_start(VncState *vs)
     if (vs->disconnecting) {
         return;
     }
+    trace_vnc_client_disconnect_start(vs, vs->ioc);
     vnc_set_share_mode(vs, VNC_SHARE_MODE_DISCONNECTED);
     if (vs->ioc_tag) {
         g_source_remove(vs->ioc_tag);
@@ -1131,6 +1132,8 @@ void vnc_disconnect_finish(VncState *vs)
 {
     int i;
 
+    trace_vnc_client_disconnect_finish(vs, vs->ioc);
+
     vnc_jobs_join(vs); /* Wait encoding jobs */
 
     vnc_lock_output(vs);
@@ -1184,11 +1187,12 @@ ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
 {
     if (ret <= 0) {
         if (ret == 0) {
-            VNC_DEBUG("Closing down client sock: EOF\n");
+            trace_vnc_client_eof(vs, vs->ioc);
             vnc_disconnect_start(vs);
         } else if (ret != QIO_CHANNEL_ERR_BLOCK) {
-            VNC_DEBUG("Closing down client sock: ret %zd (%s)\n",
-                      ret, errp ? error_get_pretty(*errp) : "Unknown");
+            trace_vnc_client_io_error(vs, vs->ioc,
+                                      errp ? error_get_pretty(*errp) :
+                                      "Unknown");
             vnc_disconnect_start(vs);
         }
 
@@ -2885,6 +2889,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
     bool first_client = QTAILQ_EMPTY(&vd->clients);
     int i;
 
+    trace_vnc_client_connect(vs, sioc);
     vs->sioc = sioc;
     object_ref(OBJECT(vs->sioc));
     vs->ioc = QIO_CHANNEL(sioc);
-- 
2.13.5
