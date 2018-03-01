Received: from eggs.gnu.org ([2001:4830:134:3::10]:52650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJqt-0000Im-BO
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJqs-0007Ud-Cs
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:46:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erJqs-0007UT-7T
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:46:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C643287ABA
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 08:46:09 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  1 Mar 2018 16:44:36 +0800
Message-Id: <20180301084438.13594-14-peterx@redhat.com>
In-Reply-To: <20180301084438.13594-1-peterx@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/15] char: use chardev's gcontext for
 async connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Generalize the function to create the async QIO task connection.  Also,
fix the context pointer to use the chardev's gcontext.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index bd90680f5c..cd9db123f2 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -894,11 +894,22 @@ cleanup:
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
@@ -907,11 +918,7 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
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
@@ -991,11 +998,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
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
