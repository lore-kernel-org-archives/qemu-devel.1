Received: from eggs.gnu.org ([2001:4830:134:3::10]:57926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshq-0005W4-22
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshp-00031G-BR
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:42 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshp-000301-4A
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:41 -0400
Received: by mail-wr0-x241.google.com with SMTP id h2so2479341wre.12
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:40 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:25 +0100
Message-Id: <20180313224719.4954-16-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/69] chardev: use chardev's gcontext for async
 connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Generalize the function to create the async QIO task connection.  Also,
fix the context pointer to use the chardev's gcontext.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180306053320.15401-7-peterx@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 82c7d7a323..09aa345869 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -902,11 +902,22 @@ cleanup:
     object_unref(OBJECT(sioc));
 }
 
+static void tcp_chr_connect_async(Chardev *chr)
+{
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+    QIOChannelSocket *sioc;
+
+    sioc = qio_channel_socket_new();
+    tcp_chr_set_client_ioc_name(chr, sioc);
+    qio_channel_socket_connect_async(sioc, s->addr,
+                                     qemu_chr_socket_connected,
+                                     chr, NULL, chr->gcontext);
+}
+
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
     Chardev *chr = CHARDEV(opaque);
     SocketChardev *s = SOCKET_CHARDEV(opaque);
-    QIOChannelSocket *sioc;
 
     g_source_unref(s->reconnect_timer);
     s->reconnect_timer = NULL;
@@ -915,11 +926,7 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
         return false;
     }
 
-    sioc = qio_channel_socket_new();
-    tcp_chr_set_client_ioc_name(chr, sioc);
-    qio_channel_socket_connect_async(sioc, s->addr,
-                                     qemu_chr_socket_connected,
-                                     chr, NULL, NULL);
+    tcp_chr_connect_async(chr);
 
     return false;
 }
@@ -999,11 +1006,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     }
 
     if (s->reconnect_time) {
-        sioc = qio_channel_socket_new();
-        tcp_chr_set_client_ioc_name(chr, sioc);
-        qio_channel_socket_connect_async(sioc, s->addr,
-                                         qemu_chr_socket_connected,
-                                         chr, NULL, NULL);
+        tcp_chr_connect_async(chr);
     } else {
         if (s->is_listen) {
             char *name;
-- 
2.14.3
