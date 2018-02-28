Received: from eggs.gnu.org ([2001:4830:134:3::10]:33674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxf-0008Hu-8V
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxe-0000ox-5f
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqtxe-0000oq-0B
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA5C387ABA
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:07:25 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Feb 2018 13:06:30 +0800
Message-Id: <20180228050633.7410-12-peterx@redhat.com>
In-Reply-To: <20180228050633.7410-1-peterx@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 11/14] qio/chardev: return QIOTask when connect
 async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Let qio_channel_socket_connect_async() return the created QIOTask object
for the async connection.  In tcp chardev, cache that in SocketChardev
for further use.  With the QIOTask refcount, this is pretty safe.

Since at it, generalize out tcp_chr_socket_connect_async() since the
logic is used in both initial phase and reconnect timeout.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c       | 33 ++++++++++++++++++++++-----------
 include/io/channel-socket.h | 14 +++++++++-----
 io/channel-socket.c         | 12 +++++++-----
 3 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a16d894c40..9d51b8da07 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -64,6 +64,7 @@ typedef struct {
     GSource *reconnect_timer;
     int64_t reconnect_time;
     bool connect_err_reported;
+    QIOTask *thread_task;
 } SocketChardev;
 
 #define SOCKET_CHARDEV(obj)                                     \
@@ -879,14 +880,32 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
     tcp_chr_new_client(chr, sioc);
 
 cleanup:
+    assert(s->thread_task == task);
+    qio_task_unref(task);
+    s->thread_task = NULL;
     object_unref(OBJECT(sioc));
 }
 
+static void tcp_chr_socket_connect_async(SocketChardev *s)
+{
+    QIOChannelSocket *sioc = qio_channel_socket_new();
+    Chardev *chr = CHARDEV(s);
+    QIOTask *task;
+
+    assert(s->thread_task == NULL);
+
+    tcp_chr_set_client_ioc_name(chr, sioc);
+    task = qio_channel_socket_connect_async(sioc, s->addr,
+                                            qemu_chr_socket_connected,
+                                            chr, NULL);
+    qio_task_ref(task);
+    s->thread_task = task;
+}
+
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
     Chardev *chr = CHARDEV(opaque);
     SocketChardev *s = SOCKET_CHARDEV(opaque);
-    QIOChannelSocket *sioc;
 
     g_source_unref(s->reconnect_timer);
     s->reconnect_timer = NULL;
@@ -895,11 +914,7 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
         return false;
     }
 
-    sioc = qio_channel_socket_new();
-    tcp_chr_set_client_ioc_name(chr, sioc);
-    qio_channel_socket_connect_async(sioc, s->addr,
-                                     qemu_chr_socket_connected,
-                                     chr, NULL);
+    tcp_chr_socket_connect_async(s);
 
     return false;
 }
@@ -979,11 +994,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     }
 
     if (s->reconnect_time) {
-        sioc = qio_channel_socket_new();
-        tcp_chr_set_client_ioc_name(chr, sioc);
-        qio_channel_socket_connect_async(sioc, s->addr,
-                                         qemu_chr_socket_connected,
-                                         chr, NULL);
+        tcp_chr_socket_connect_async(s);
     } else {
         if (s->is_listen) {
             char *name;
diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index 53801f6042..5cfa9e2b7c 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -108,12 +108,16 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
  * will be invoked on completion or failure. The @addr
  * parameter will be copied, so may be freed as soon
  * as this function returns without waiting for completion.
+ *
+ * Returns the IOTask created.  NOTE: if the caller is going to use
+ * the returned QIOTask, the caller is responsible to reference the
+ * task and unref it when it's not needed any more.
  */
-void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
-                                      SocketAddress *addr,
-                                      QIOTaskFunc callback,
-                                      gpointer opaque,
-                                      GDestroyNotify destroy);
+QIOTask *qio_channel_socket_connect_async(QIOChannelSocket *ioc,
+                                          SocketAddress *addr,
+                                          QIOTaskFunc callback,
+                                          gpointer opaque,
+                                          GDestroyNotify destroy);
 
 
 /**
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 4224ce323a..f420502290 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -169,11 +169,11 @@ static void qio_channel_socket_connect_worker(QIOTask *task,
 }
 
 
-void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
-                                      SocketAddress *addr,
-                                      QIOTaskFunc callback,
-                                      gpointer opaque,
-                                      GDestroyNotify destroy)
+QIOTask *qio_channel_socket_connect_async(QIOChannelSocket *ioc,
+                                          SocketAddress *addr,
+                                          QIOTaskFunc callback,
+                                          gpointer opaque,
+                                          GDestroyNotify destroy)
 {
     QIOTask *task = qio_task_new(
         OBJECT(ioc), callback, opaque, destroy);
@@ -189,6 +189,8 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
                            addrCopy,
                            (GDestroyNotify)qapi_free_SocketAddress,
                            NULL);
+
+    return task;
 }
 
 
-- 
2.14.3
