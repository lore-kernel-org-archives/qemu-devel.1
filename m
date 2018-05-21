Received: from eggs.gnu.org ([2001:4830:134:3::10]:44507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@void.so>) id 1fKnVf-0001pI-4W
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@void.so>) id 1fKnVa-0007A1-Fx
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:18:06 -0400
Received: from forward105o.mail.yandex.net ([2a02:6b8:0:1a2d::608]:46550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mail@void.so>) id 1fKnVa-00078V-3U
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:18:02 -0400
Date: Mon, 21 May 2018 19:17:35 +0300
From: Pavel Balaev <mail@void.so>
Message-ID: <20180521161733.GA16751@rnd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2] Delete AF_UNIX socket after close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org

This is a second attempt at sending this patch:

http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg04697.html

Signed-off-by: Pavel Balaev <mail@void.so>
---
 io/channel-socket.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 57cfb4d3a6..b50e63a053 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -685,8 +685,10 @@ qio_channel_socket_close(QIOChannel *ioc,
                          Error **errp)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    int rc = 0;
 
     if (sioc->fd != -1) {
+        SocketAddress *addr = socket_local_address(sioc->fd, errp);
 #ifdef WIN32
         WSAEventSelect(sioc->fd, NULL, 0);
 #endif
@@ -697,8 +699,22 @@ qio_channel_socket_close(QIOChannel *ioc,
             return -1;
         }
         sioc->fd = -1;
+
+        if (addr && addr->type == SOCKET_ADDRESS_TYPE_UNIX
+            && addr->u.q_unix.path) {
+            if (unlink(addr->u.q_unix.path) < 0 && errno != ENOENT) {
+                error_setg_errno(errp, errno,
+                                 "Failed to unlink socket %s",
+                                 addr->u.q_unix.path);
+                rc = -1;
+            }
+        }
+
+        if (addr) {
+            qapi_free_SocketAddress(addr);
+        }
     }
-    return 0;
+    return rc;
 }
 
 static int
-- 
2.16.1
