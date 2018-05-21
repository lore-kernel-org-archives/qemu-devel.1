Received: from eggs.gnu.org ([2001:4830:134:3::10]:34047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@void.so>) id 1fKiiH-0006q1-9s
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@void.so>) id 1fKiiE-0001CC-3S
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:10:49 -0400
Received: from forward106j.mail.yandex.net ([5.45.198.249]:49040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mail@void.so>) id 1fKiiD-0001AB-H3
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:10:46 -0400
Received: from mxback3j.mail.yandex.net (mxback3j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::10c])
	by forward106j.mail.yandex.net (Yandex) with ESMTP id 1C7821802FD9
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 14:10:41 +0300 (MSK)
Date: Mon, 21 May 2018 14:10:18 +0300
From: Pavel Balaev <mail@void.so>
Message-ID: <20180521111015.GA26731@rnd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] Delete AF_UNIX socket after close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

Since version 2.12.0 AF_UNIX socket created for QMP exchange is not
deleted on instance shutdown.

This is due to the fact that function qio_channel_socket_finalize() is
called after qio_channel_socket_close().


Signed-off-by: Pavel Balaev <mail@void.so>
---
 include/qemu/sockets.h |  1 -
 io/channel-socket.c    | 40 +++++++++++++++-------------------------
 util/qemu-sockets.c    | 21 ---------------------
 3 files changed, 15 insertions(+), 47 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 8140fea685..a786bd76d7 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -42,7 +42,6 @@ int unix_connect(const char *path, Error **errp);
 SocketAddress *socket_parse(const char *str, Error **errp);
 int socket_connect(SocketAddress *addr, Error **errp);
 int socket_listen(SocketAddress *addr, Error **errp);
-void socket_listen_cleanup(int fd, Error **errp);
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
 
 /* Old, ipv4 only bits.  Don't use for new code. */
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 57cfb4d3a6..3c88ca4130 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -383,30 +383,6 @@ static void qio_channel_socket_init(Object *obj)
     ioc->fd = -1;
 }
 
-static void qio_channel_socket_finalize(Object *obj)
-{
-    QIOChannelSocket *ioc = QIO_CHANNEL_SOCKET(obj);
-
-    if (ioc->fd != -1) {
-        QIOChannel *ioc_local = QIO_CHANNEL(ioc);
-        if (qio_channel_has_feature(ioc_local, QIO_CHANNEL_FEATURE_LISTEN)) {
-            Error *err = NULL;
-
-            socket_listen_cleanup(ioc->fd, &err);
-            if (err) {
-                error_report_err(err);
-                err = NULL;
-            }
-        }
-#ifdef WIN32
-        WSAEventSelect(ioc->fd, NULL, 0);
-#endif
-        closesocket(ioc->fd);
-        ioc->fd = -1;
-    }
-}
-
-
 #ifndef WIN32
 static void qio_channel_socket_copy_fds(struct msghdr *msg,
                                         int **fds, size_t *nfds)
@@ -687,6 +663,8 @@ qio_channel_socket_close(QIOChannel *ioc,
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
 
     if (sioc->fd != -1) {
+        SocketAddress *addr = socket_local_address(sioc->fd, errp);
+
 #ifdef WIN32
         WSAEventSelect(sioc->fd, NULL, 0);
 #endif
@@ -697,6 +675,19 @@ qio_channel_socket_close(QIOChannel *ioc,
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
+            }
+        }
+
+        if (addr) {
+            qapi_free_SocketAddress(addr);
+        }
     }
     return 0;
 }
@@ -770,7 +761,6 @@ static const TypeInfo qio_channel_socket_info = {
     .name = TYPE_QIO_CHANNEL_SOCKET,
     .instance_size = sizeof(QIOChannelSocket),
     .instance_init = qio_channel_socket_init,
-    .instance_finalize = qio_channel_socket_finalize,
     .class_init = qio_channel_socket_class_init,
 };
 
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 8bd8bb64eb..aedcb5b9c0 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1120,27 +1120,6 @@ int socket_listen(SocketAddress *addr, Error **errp)
     return fd;
 }
 
-void socket_listen_cleanup(int fd, Error **errp)
-{
-    SocketAddress *addr;
-
-    addr = socket_local_address(fd, errp);
-    if (!addr) {
-        return;
-    }
-
-    if (addr->type == SOCKET_ADDRESS_TYPE_UNIX
-        && addr->u.q_unix.path) {
-        if (unlink(addr->u.q_unix.path) < 0 && errno != ENOENT) {
-            error_setg_errno(errp, errno,
-                             "Failed to unlink socket %s",
-                             addr->u.q_unix.path);
-        }
-    }
-
-    qapi_free_SocketAddress(addr);
-}
-
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp)
 {
     int fd;
-- 
2.16.1
