Received: from eggs.gnu.org ([2001:4830:134:3::10]:52578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJqZ-0008Rh-Mr
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJqU-0007Jr-PI
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erJqU-0007Ja-Jr
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24A454084FEC
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 08:45:46 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  1 Mar 2018 16:44:32 +0800
Message-Id: <20180301084438.13594-10-peterx@redhat.com>
In-Reply-To: <20180301084438.13594-1-peterx@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/15] qio: non-default context for threaded
 qtask
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

qio_task_run_in_thread() allows main thread to run blocking operations
in the background. However it has an assumption on that it's always
working with the default context. This patch tries to allow the threaded
QIO task framework to run with non-default gcontext.

Currently no functional change so far, so the QIOTasks are still always
running on main context.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/task.h    |  6 ++++--
 io/channel-socket.c  |  9 ++++++---
 io/dns-resolver.c    |  3 ++-
 io/task.c            | 20 ++++++++++++++++++--
 tests/test-io-task.c |  2 ++
 5 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/include/io/task.h b/include/io/task.h
index 6021f51336..9dbe3758d7 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -227,15 +227,17 @@ QIOTask *qio_task_new(Object *source,
  * @worker: the function to invoke in a thread
  * @opaque: opaque data to pass to @worker
  * @destroy: function to free @opaque
+ * @context: the context to run the complete hook
  *
  * Run a task in a background thread. When @worker
  * returns it will call qio_task_complete() in
- * the main event thread context.
+ * the event thread context that provided.
  */
 void qio_task_run_in_thread(QIOTask *task,
                             QIOTaskWorker worker,
                             gpointer opaque,
-                            GDestroyNotify destroy);
+                            GDestroyNotify destroy,
+                            GMainContext *context);
 
 /**
  * qio_task_complete:
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 563e297357..4224ce323a 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -187,7 +187,8 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
     qio_task_run_in_thread(task,
                            qio_channel_socket_connect_worker,
                            addrCopy,
-                           (GDestroyNotify)qapi_free_SocketAddress);
+                           (GDestroyNotify)qapi_free_SocketAddress,
+                           NULL);
 }
 
 
@@ -245,7 +246,8 @@ void qio_channel_socket_listen_async(QIOChannelSocket *ioc,
     qio_task_run_in_thread(task,
                            qio_channel_socket_listen_worker,
                            addrCopy,
-                           (GDestroyNotify)qapi_free_SocketAddress);
+                           (GDestroyNotify)qapi_free_SocketAddress,
+                           NULL);
 }
 
 
@@ -321,7 +323,8 @@ void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
     qio_task_run_in_thread(task,
                            qio_channel_socket_dgram_worker,
                            data,
-                           qio_channel_socket_dgram_worker_free);
+                           qio_channel_socket_dgram_worker_free,
+                           NULL);
 }
 
 
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index c072d121c3..75c2ca9c4a 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -233,7 +233,8 @@ void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
     qio_task_run_in_thread(task,
                            qio_dns_resolver_lookup_worker,
                            data,
-                           qio_dns_resolver_lookup_data_free);
+                           qio_dns_resolver_lookup_data_free,
+                           NULL);
 }
 
 
diff --git a/io/task.c b/io/task.c
index 1a0a1c7185..2886a2c1bc 100644
--- a/io/task.c
+++ b/io/task.c
@@ -77,6 +77,7 @@ struct QIOTaskThreadData {
     QIOTaskWorker worker;
     gpointer opaque;
     GDestroyNotify destroy;
+    GMainContext *context;
 };
 
 
@@ -91,6 +92,10 @@ static gboolean qio_task_thread_result(gpointer opaque)
         data->destroy(data->opaque);
     }
 
+    if (data->context) {
+        g_main_context_unref(data->context);
+    }
+
     g_free(data);
 
     return FALSE;
@@ -100,6 +105,7 @@ static gboolean qio_task_thread_result(gpointer opaque)
 static gpointer qio_task_thread_worker(gpointer opaque)
 {
     struct QIOTaskThreadData *data = opaque;
+    GSource *idle;
 
     trace_qio_task_thread_run(data->task);
     data->worker(data->task, data->opaque);
@@ -110,7 +116,11 @@ static gpointer qio_task_thread_worker(gpointer opaque)
      * the worker results
      */
     trace_qio_task_thread_exit(data->task);
-    g_idle_add(qio_task_thread_result, data);
+
+    idle = g_idle_source_new();
+    g_source_set_callback(idle, qio_task_thread_result, data, NULL);
+    g_source_attach(idle, data->context);
+
     return NULL;
 }
 
@@ -118,15 +128,21 @@ static gpointer qio_task_thread_worker(gpointer opaque)
 void qio_task_run_in_thread(QIOTask *task,
                             QIOTaskWorker worker,
                             gpointer opaque,
-                            GDestroyNotify destroy)
+                            GDestroyNotify destroy,
+                            GMainContext *context)
 {
     struct QIOTaskThreadData *data = g_new0(struct QIOTaskThreadData, 1);
     QemuThread thread;
 
+    if (context) {
+        g_main_context_ref(context);
+    }
+
     data->task = task;
     data->worker = worker;
     data->opaque = opaque;
     data->destroy = destroy;
+    data->context = context;
 
     trace_qio_task_thread_start(task, worker, opaque);
     qemu_thread_create(&thread,
diff --git a/tests/test-io-task.c b/tests/test-io-task.c
index 141aa2c55d..bac1bb4e7a 100644
--- a/tests/test-io-task.c
+++ b/tests/test-io-task.c
@@ -187,6 +187,7 @@ static void test_task_thread_complete(void)
     qio_task_run_in_thread(task,
                            test_task_thread_worker,
                            &data,
+                           NULL,
                            NULL);
 
     g_main_loop_run(data.loop);
@@ -228,6 +229,7 @@ static void test_task_thread_failure(void)
     qio_task_run_in_thread(task,
                            test_task_thread_worker,
                            &data,
+                           NULL,
                            NULL);
 
     g_main_loop_run(data.loop);
-- 
2.14.3
