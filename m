Received: from eggs.gnu.org ([2001:4830:134:3::10]:50630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYtfe-00015Z-Or
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYtfd-0002Ig-0r
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:05:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cYtfc-0002IY-OB
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:05:52 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED979C04B92A
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 12:05:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  1 Feb 2017 04:05:20 -0800
Message-Id: <20170201120533.13838-6-pbonzini@redhat.com>
In-Reply-To: <20170201120533.13838-1-pbonzini@redhat.com>
References: <20170201120533.13838-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/18] io: add methods to set I/O handlers on
 AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

This is in preparation for making qio_channel_yield work on
AioContexts other than the main one.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/io/channel.h | 25 +++++++++++++++++++++++++
 io/channel-command.c | 13 +++++++++++++
 io/channel-file.c    | 11 +++++++++++
 io/channel-socket.c  | 16 +++++++++++-----
 io/channel-tls.c     | 12 ++++++++++++
 io/channel-watch.c   |  6 ++++++
 io/channel.c         | 11 +++++++++++
 7 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 32a9470..0bc7c3f 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -23,6 +23,7 @@
 
 #include "qemu-common.h"
 #include "qom/object.h"
+#include "block/aio.h"
 
 #define TYPE_QIO_CHANNEL "qio-channel"
 #define QIO_CHANNEL(obj)                                    \
@@ -132,6 +133,11 @@ struct QIOChannelClass {
                      off_t offset,
                      int whence,
                      Error **errp);
+    void (*io_set_aio_fd_handler)(QIOChannel *ioc,
+                                  AioContext *ctx,
+                                  IOHandler *io_read,
+                                  IOHandler *io_write,
+                                  void *opaque);
 };
 
 /* General I/O handling functions */
@@ -525,4 +531,23 @@ void qio_channel_yield(QIOChannel *ioc,
 void qio_channel_wait(QIOChannel *ioc,
                       GIOCondition condition);
 
+/**
+ * qio_channel_set_aio_fd_handler:
+ * @ioc: the channel object
+ * @ctx: the AioContext to set the handlers on
+ * @io_read: the read handler
+ * @io_write: the write handler
+ * @opaque: the opaque value passed to the handler
+ *
+ * This is used internally by qio_channel_yield().  It can
+ * be used by channel implementations to forward the handlers
+ * to another channel (e.g. from #QIOChannelTLS to the
+ * underlying socket).
+ */
+void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
+                                    AioContext *ctx,
+                                    IOHandler *io_read,
+                                    IOHandler *io_write,
+                                    void *opaque);
+
 #endif /* QIO_CHANNEL_H */
diff --git a/io/channel-command.c b/io/channel-command.c
index ad25313..319c5ed 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -328,6 +328,18 @@ static int qio_channel_command_close(QIOChannel *ioc,
 }
 
 
+static void qio_channel_command_set_aio_fd_handler(QIOChannel *ioc,
+                                                   AioContext *ctx,
+                                                   IOHandler *io_read,
+                                                   IOHandler *io_write,
+                                                   void *opaque)
+{
+    QIOChannelCommand *cioc = QIO_CHANNEL_COMMAND(ioc);
+    aio_set_fd_handler(ctx, cioc->readfd, false, io_read, NULL, NULL, opaque);
+    aio_set_fd_handler(ctx, cioc->writefd, false, NULL, io_write, NULL, opaque);
+}
+
+
 static GSource *qio_channel_command_create_watch(QIOChannel *ioc,
                                                  GIOCondition condition)
 {
@@ -349,6 +361,7 @@ static void qio_channel_command_class_init(ObjectClass *klass,
     ioc_klass->io_set_blocking = qio_channel_command_set_blocking;
     ioc_klass->io_close = qio_channel_command_close;
     ioc_klass->io_create_watch = qio_channel_command_create_watch;
+    ioc_klass->io_set_aio_fd_handler = qio_channel_command_set_aio_fd_handler;
 }
 
 static const TypeInfo qio_channel_command_info = {
diff --git a/io/channel-file.c b/io/channel-file.c
index e1da243..b383273 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -186,6 +186,16 @@ static int qio_channel_file_close(QIOChannel *ioc,
 }
 
 
+static void qio_channel_file_set_aio_fd_handler(QIOChannel *ioc,
+                                                AioContext *ctx,
+                                                IOHandler *io_read,
+                                                IOHandler *io_write,
+                                                void *opaque)
+{
+    QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
+    aio_set_fd_handler(ctx, fioc->fd, false, io_read, io_write, NULL, opaque);
+}
+
 static GSource *qio_channel_file_create_watch(QIOChannel *ioc,
                                               GIOCondition condition)
 {
@@ -206,6 +216,7 @@ static void qio_channel_file_class_init(ObjectClass *klass,
     ioc_klass->io_seek = qio_channel_file_seek;
     ioc_klass->io_close = qio_channel_file_close;
     ioc_klass->io_create_watch = qio_channel_file_create_watch;
+    ioc_klass->io_set_aio_fd_handler = qio_channel_file_set_aio_fd_handler;
 }
 
 static const TypeInfo qio_channel_file_info = {
diff --git a/io/channel-socket.c b/io/channel-socket.c
index f385233..f546c68 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -649,11 +649,6 @@ qio_channel_socket_set_blocking(QIOChannel *ioc,
         qemu_set_block(sioc->fd);
     } else {
         qemu_set_nonblock(sioc->fd);
-#ifdef WIN32
-        WSAEventSelect(sioc->fd, ioc->event,
-                       FD_READ | FD_ACCEPT | FD_CLOSE |
-                       FD_CONNECT | FD_WRITE | FD_OOB);
-#endif
     }
     return 0;
 }
@@ -733,6 +728,16 @@ qio_channel_socket_shutdown(QIOChannel *ioc,
     return 0;
 }
 
+static void qio_channel_socket_set_aio_fd_handler(QIOChannel *ioc,
+                                                  AioContext *ctx,
+                                                  IOHandler *io_read,
+                                                  IOHandler *io_write,
+                                                  void *opaque)
+{
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    aio_set_fd_handler(ctx, sioc->fd, false, io_read, io_write, NULL, opaque);
+}
+
 static GSource *qio_channel_socket_create_watch(QIOChannel *ioc,
                                                 GIOCondition condition)
 {
@@ -755,6 +760,7 @@ static void qio_channel_socket_class_init(ObjectClass *klass,
     ioc_klass->io_set_cork = qio_channel_socket_set_cork;
     ioc_klass->io_set_delay = qio_channel_socket_set_delay;
     ioc_klass->io_create_watch = qio_channel_socket_create_watch;
+    ioc_klass->io_set_aio_fd_handler = qio_channel_socket_set_aio_fd_handler;
 }
 
 static const TypeInfo qio_channel_socket_info = {
diff --git a/io/channel-tls.c b/io/channel-tls.c
index f25ab0a..6182702 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -345,6 +345,17 @@ static int qio_channel_tls_close(QIOChannel *ioc,
     return qio_channel_close(tioc->master, errp);
 }
 
+static void qio_channel_tls_set_aio_fd_handler(QIOChannel *ioc,
+                                               AioContext *ctx,
+                                               IOHandler *io_read,
+                                               IOHandler *io_write,
+                                               void *opaque)
+{
+    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
+
+    qio_channel_set_aio_fd_handler(tioc->master, ctx, io_read, io_write, opaque);
+}
+
 static GSource *qio_channel_tls_create_watch(QIOChannel *ioc,
                                              GIOCondition condition)
 {
@@ -372,6 +383,7 @@ static void qio_channel_tls_class_init(ObjectClass *klass,
     ioc_klass->io_close = qio_channel_tls_close;
     ioc_klass->io_shutdown = qio_channel_tls_shutdown;
     ioc_klass->io_create_watch = qio_channel_tls_create_watch;
+    ioc_klass->io_set_aio_fd_handler = qio_channel_tls_set_aio_fd_handler;
 }
 
 static const TypeInfo qio_channel_tls_info = {
diff --git a/io/channel-watch.c b/io/channel-watch.c
index cf1cdff..8640d1c 100644
--- a/io/channel-watch.c
+++ b/io/channel-watch.c
@@ -285,6 +285,12 @@ GSource *qio_channel_create_socket_watch(QIOChannel *ioc,
     GSource *source;
     QIOChannelSocketSource *ssource;
 
+#ifdef WIN32
+    WSAEventSelect(socket, ioc->event,
+                   FD_READ | FD_ACCEPT | FD_CLOSE |
+                   FD_CONNECT | FD_WRITE | FD_OOB);
+#endif
+
     source = g_source_new(&qio_channel_socket_source_funcs,
                           sizeof(QIOChannelSocketSource));
     ssource = (QIOChannelSocketSource *)source;
diff --git a/io/channel.c b/io/channel.c
index 80924c1..ce470d7 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -154,6 +154,17 @@ GSource *qio_channel_create_watch(QIOChannel *ioc,
 }
 
 
+void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
+                                    AioContext *ctx,
+                                    IOHandler *io_read,
+                                    IOHandler *io_write,
+                                    void *opaque)
+{
+    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+
+    klass->io_set_aio_fd_handler(ioc, ctx, io_read, io_write, opaque);
+}
+
 guint qio_channel_add_watch(QIOChannel *ioc,
                             GIOCondition condition,
                             QIOChannelFunc func,
-- 
2.9.3
