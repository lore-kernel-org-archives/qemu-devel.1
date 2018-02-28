Received: from eggs.gnu.org ([2001:4830:134:3::10]:33629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxZ-0008F8-Mk
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxW-0000md-GE
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49528 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqtxW-0000mV-B9
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02B09402290A
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:07:18 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Feb 2018 13:06:28 +0800
Message-Id: <20180228050633.7410-10-peterx@redhat.com>
In-Reply-To: <20180228050633.7410-1-peterx@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 09/14] qio: basic non-default context support
 for thread
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

qio_task_run_in_thread() allows main thread to run blocking operations
in the background. However it has an assumption on that it's always
working with the default context. This patch tries to allow the QIO task
framework to run with non-default gcontext.

Currently no functional change so far, so the QIOTasks are still always
running on main context.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/task.h    |  6 ++++--
 io/channel-socket.c  |  9 ++++++---
 io/dns-resolver.c    |  3 ++-
 io/task.c            | 28 ++++++++++++++++++++++++++--
 tests/test-io-task.c |  2 ++
 5 files changed, 40 insertions(+), 8 deletions(-)

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
index 1a0a1c7185..204c0be286 100644
--- a/io/task.c
+++ b/io/task.c
@@ -32,6 +32,10 @@ struct QIOTask {
     Error *err;
     gpointer result;
     GDestroyNotify destroyResult;
+
+    /* Threaded QIO task specific fields */
+    GSource *idle_source;  /* The idle task to run complete routine */
+    GMainContext *context; /* The context that idle task will run with */
 };
 
 
@@ -49,6 +53,7 @@ QIOTask *qio_task_new(Object *source,
     task->func = func;
     task->opaque = opaque;
     task->destroy = destroy;
+    task->idle_source = NULL;
 
     trace_qio_task_new(task, source, func, opaque);
 
@@ -66,6 +71,12 @@ static void qio_task_free(QIOTask *task)
     if (task->err) {
         error_free(task->err);
     }
+    if (task->idle_source) {
+        g_source_unref(task->idle_source);
+    }
+    if (task->context) {
+        g_main_context_unref(task->context);
+    }
     object_unref(task->source);
 
     g_free(task);
@@ -100,6 +111,8 @@ static gboolean qio_task_thread_result(gpointer opaque)
 static gpointer qio_task_thread_worker(gpointer opaque)
 {
     struct QIOTaskThreadData *data = opaque;
+    QIOTask *task = data->task;
+    GSource *idle;
 
     trace_qio_task_thread_run(data->task);
     data->worker(data->task, data->opaque);
@@ -110,7 +123,12 @@ static gpointer qio_task_thread_worker(gpointer opaque)
      * the worker results
      */
     trace_qio_task_thread_exit(data->task);
-    g_idle_add(qio_task_thread_result, data);
+
+    idle = g_idle_source_new();
+    g_source_set_callback(idle, qio_task_thread_result, data, NULL);
+    g_source_attach(idle, task->context);
+    task->idle_source = idle;
+
     return NULL;
 }
 
@@ -118,11 +136,17 @@ static gpointer qio_task_thread_worker(gpointer opaque)
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
+        task->context = context;
+    }
+
     data->task = task;
     data->worker = worker;
     data->opaque = opaque;
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
