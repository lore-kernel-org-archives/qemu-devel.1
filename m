Received: from eggs.gnu.org ([2001:4830:134:3::10]:40144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAW1-0006Bt-An
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAVx-0000Q0-E8
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPAVx-0000Pm-53
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:41 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EFE1C056793
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:03:41 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  5 Jan 2017 16:03:20 +0000
Message-Id: <20170105160321.21786-8-berrange@redhat.com>
In-Reply-To: <20170105160321.21786-1-berrange@redhat.com>
References: <20170105160321.21786-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 7/8] io: remove Error parameter from QIOTask
 thread worker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now that task objects have a directly associated error,
there's no need for an an Error **errp parameter to
the QIOTask thread worker function. It already has a
QIOTask object, so can directly set the error on it.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/task.h    | 19 +++++++++----------
 io/channel-socket.c  | 47 ++++++++++++++++++++++-------------------------
 io/task.c            | 10 +---------
 tests/test-io-task.c | 12 +++++-------
 4 files changed, 37 insertions(+), 51 deletions(-)

diff --git a/include/io/task.h b/include/io/task.h
index 7b5bc43..dca57dc 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -29,9 +29,8 @@ typedef struct QIOTask QIOTask;
 typedef void (*QIOTaskFunc)(QIOTask *task,
                             gpointer opaque);
 
-typedef int (*QIOTaskWorker)(QIOTask *task,
-                             Error **errp,
-                             gpointer opaque);
+typedef void (*QIOTaskWorker)(QIOTask *task,
+                              gpointer opaque);
 
 /**
  * QIOTask:
@@ -163,18 +162,18 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
  * socket listen using QIOTask would require:
  *
  * <example>
- *    static int myobject_listen_worker(QIOTask *task,
- *                                      Error **errp,
- *                                      gpointer opaque)
+ *    static void myobject_listen_worker(QIOTask *task,
+ *                                       gpointer opaque)
  *    {
  *       QMyObject obj = QMY_OBJECT(qio_task_get_source(task));
  *       SocketAddress *addr = opaque;
+ *       Error *err = NULL;
  *
- *       obj->fd = socket_listen(addr, errp);
- *       if (obj->fd < 0) {
- *          return -1;
+ *       obj->fd = socket_listen(addr, &err);
+ *
+ *       if (err) {
+ *           qio_task_set_error(task, err);
  *       }
- *       return 0;
  *    }
  *
  *    void myobject_listen_async(QMyObject *obj,
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 45df819..8d32a0b 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -156,19 +156,18 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
 }
 
 
-static int qio_channel_socket_connect_worker(QIOTask *task,
-                                             Error **errp,
-                                             gpointer opaque)
+static void qio_channel_socket_connect_worker(QIOTask *task,
+                                              gpointer opaque)
 {
     QIOChannelSocket *ioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
     SocketAddress *addr = opaque;
-    int ret;
+    Error *err = NULL;
 
-    ret = qio_channel_socket_connect_sync(ioc,
-                                          addr,
-                                          errp);
+    qio_channel_socket_connect_sync(ioc, addr, &err);
 
-    return ret;
+    if (err) {
+        qio_task_set_error(task, err);
+    }
 }
 
 
@@ -218,19 +217,18 @@ int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
 }
 
 
-static int qio_channel_socket_listen_worker(QIOTask *task,
-                                            Error **errp,
-                                            gpointer opaque)
+static void qio_channel_socket_listen_worker(QIOTask *task,
+                                             gpointer opaque)
 {
     QIOChannelSocket *ioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
     SocketAddress *addr = opaque;
-    int ret;
+    Error *err = NULL;
 
-    ret = qio_channel_socket_listen_sync(ioc,
-                                         addr,
-                                         errp);
+    qio_channel_socket_listen_sync(ioc, addr, &err);
 
-    return ret;
+    if (err) {
+        qio_task_set_error(task, err);
+    }
 }
 
 
@@ -293,21 +291,20 @@ static void qio_channel_socket_dgram_worker_free(gpointer opaque)
     g_free(data);
 }
 
-static int qio_channel_socket_dgram_worker(QIOTask *task,
-                                           Error **errp,
-                                           gpointer opaque)
+static void qio_channel_socket_dgram_worker(QIOTask *task,
+                                            gpointer opaque)
 {
     QIOChannelSocket *ioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
     struct QIOChannelSocketDGramWorkerData *data = opaque;
-    int ret;
+    Error *err = NULL;
 
     /* socket_dgram() blocks in DNS lookups, so we must use a thread */
-    ret = qio_channel_socket_dgram_sync(ioc,
-                                        data->localAddr,
-                                        data->remoteAddr,
-                                        errp);
+    qio_channel_socket_dgram_sync(ioc, data->localAddr,
+                                  data->remoteAddr, &err);
 
-    return ret;
+    if (err) {
+        qio_task_set_error(task, err);
+    }
 }
 
 
diff --git a/io/task.c b/io/task.c
index 7da6bdd..448ec67 100644
--- a/io/task.c
+++ b/io/task.c
@@ -77,8 +77,6 @@ struct QIOTaskThreadData {
     QIOTaskWorker worker;
     gpointer opaque;
     GDestroyNotify destroy;
-    Error *err;
-    int ret;
 };
 
 
@@ -87,9 +85,6 @@ static gboolean gio_task_thread_result(gpointer opaque)
     struct QIOTaskThreadData *data = opaque;
 
     trace_qio_task_thread_result(data->task);
-    if (data->err) {
-        qio_task_set_error(data->task, data->err);
-    }
     qio_task_complete(data->task);
 
     if (data->destroy) {
@@ -107,10 +102,7 @@ static gpointer qio_task_thread_worker(gpointer opaque)
     struct QIOTaskThreadData *data = opaque;
 
     trace_qio_task_thread_run(data->task);
-    data->ret = data->worker(data->task, &data->err, data->opaque);
-    if (data->ret < 0 && data->err == NULL) {
-        error_setg(&data->err, "Task worker failed but did not set an error");
-    }
+    data->worker(data->task, data->opaque);
 
     /* We're running in the background thread, and must only
      * ever report the task results in the main event loop
diff --git a/tests/test-io-task.c b/tests/test-io-task.c
index 84144c9..ff62272 100644
--- a/tests/test-io-task.c
+++ b/tests/test-io-task.c
@@ -140,20 +140,18 @@ struct TestThreadWorkerData {
     GMainLoop *loop;
 };
 
-static int test_task_thread_worker(QIOTask *task,
-                                   Error **errp,
-                                   gpointer opaque)
+static void test_task_thread_worker(QIOTask *task,
+                                    gpointer opaque)
 {
     struct TestThreadWorkerData *data = opaque;
 
     data->worker = g_thread_self();
 
     if (data->fail) {
-        error_setg(errp, "Testing fail");
-        return -1;
+        Error *err = NULL;
+        error_setg(&err, "Testing fail");
+        qio_task_set_error(task, err);
     }
-
-    return 0;
 }
 
 
-- 
2.9.3
