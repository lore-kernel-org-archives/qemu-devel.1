Received: from eggs.gnu.org ([2001:4830:134:3::10]:47903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYUhf-0000U9-S8
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYUhd-0003mj-Gd
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:03:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59894 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYUhd-0003ly-Bl
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:03:05 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 28 Jun 2018 12:02:54 +0100
Message-Id: <20180628110254.6725-3-berrange@redhat.com>
In-Reply-To: <20180628110254.6725-1-berrange@redhat.com>
References: <20180628110254.6725-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] Delete AF_UNIX socket after close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Pavel Balaev <mail@void.so>

From: Pavel Balaev <mail@void.so>

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
2.17.1
