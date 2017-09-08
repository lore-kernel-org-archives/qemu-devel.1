Received: from eggs.gnu.org ([2001:4830:134:3::10]:40096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dqNFQ-0000KJ-6R
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dqNFM-0008Hn-4g
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:39:20 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:35051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dqNFL-0008Gr-UQ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:39:16 -0400
Received: by mail-pg0-x235.google.com with SMTP id 188so5918520pgb.2
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 10:39:15 -0700 (PDT)
MIME-Version: 1.0
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Date: Fri,  8 Sep 2017 10:37:56 -0700
Message-Id: <20170908173801.15205-2-brandon.carpenter@cypherpath.com>
In-Reply-To: <20170908173801.15205-1-brandon.carpenter@cypherpath.com>
References: <20170908173801.15205-1-brandon.carpenter@cypherpath.com>
In-Reply-To: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
	<20170724181544.20292-1-brandon.carpenter@cypherpath.com>
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH v2 1/6] io: Always remove an old channel watch
 before adding a new one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, brandon.carpenter@cypherpath.com

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
index ffaab57550..c3eece4fa7 100644
--- a/ui/vnc-auth-vencrypt.c
+++ b/ui/vnc-auth-vencrypt.c
@@ -77,6 +77,9 @@ static void vnc_tls_handshake_done(QIOTask *task,
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
index f530cd5474..eaf309553c 100644
--- a/ui/vnc-ws.c
+++ b/ui/vnc-ws.c
@@ -36,6 +36,9 @@ static void vncws_tls_handshake_done(QIOTask *task,
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
index 0b5dbc62e4..62f7a3f30a 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1121,6 +1121,7 @@ static void vnc_disconnect_start(VncState *vs)
     vnc_set_share_mode(vs, VNC_SHARE_MODE_DISCONNECTED);
     if (vs->ioc_tag) {
         g_source_remove(vs->ioc_tag);
+        vs->ioc_tag = 0;
     }
     qio_channel_close(vs->ioc, NULL);
     vs->disconnecting = TRUE;
@@ -2931,6 +2932,9 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
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
2.14.1


-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.
