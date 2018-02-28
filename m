Received: from eggs.gnu.org ([2001:4830:134:3::10]:33697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxi-0008LV-Vc
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxh-0000rT-Un
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49542 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqtxh-0000qO-QI
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D3D1402290A
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:07:29 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Feb 2018 13:06:31 +0800
Message-Id: <20180228050633.7410-13-peterx@redhat.com>
In-Reply-To: <20180228050633.7410-1-peterx@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 12/14] qio: move QIOTaskThreadData into QIOTask
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

The major reason to do this is that, after the upper level can cache the
QIOTask, it should also be able to further manage the QIOTask.  And, it
can't if it does not have the information in QIOTaskThreadData.  So
let's just merge this struct with QIOTask.  Actually by doing this,
it'll simplify the code a bit too.

This will be needed in the next patch, when we want to rebuild the
completion GSource when the GMainContext changed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 io/task.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/io/task.c b/io/task.c
index 00d3a5096a..080f9560ea 100644
--- a/io/task.c
+++ b/io/task.c
@@ -24,6 +24,13 @@
 #include "qemu/thread.h"
 #include "trace.h"
 
+struct QIOTaskThreadData {
+    QIOTaskWorker worker;
+    gpointer opaque;
+    GDestroyNotify destroy;
+};
+typedef struct QIOTaskThreadData QIOTaskThreadData;
+
 struct QIOTask {
     Object *source;
     QIOTaskFunc func;
@@ -37,6 +44,7 @@ struct QIOTask {
     /* Threaded QIO task specific fields */
     GSource *idle_source;  /* The idle task to run complete routine */
     GMainContext *context; /* The context that idle task will run with */
+    QIOTaskThreadData thread_data;
 };
 
 
@@ -86,26 +94,25 @@ static void qio_task_free(QIOTask *task)
 }
 
 
-struct QIOTaskThreadData {
-    QIOTask *task;
-    QIOTaskWorker worker;
-    gpointer opaque;
-    GDestroyNotify destroy;
-};
-
-
 static gboolean qio_task_thread_result(gpointer opaque)
 {
-    struct QIOTaskThreadData *data = opaque;
+    QIOTask *task = opaque;
+    QIOTaskThreadData *data = &task->thread_data;
 
-    trace_qio_task_thread_result(data->task);
-    qio_task_complete(data->task);
+    /*
+     * Take one more refcount since qio_task_complete() may otherwise
+     * release the last refcount and free, then "data" may be invalid.
+     */
+    qio_task_ref(task);
+
+    trace_qio_task_thread_result(task);
+    qio_task_complete(task);
 
     if (data->destroy) {
         data->destroy(data->opaque);
     }
 
-    g_free(data);
+    qio_task_unref(task);
 
     return FALSE;
 }
@@ -113,19 +120,19 @@ static gboolean qio_task_thread_result(gpointer opaque)
 
 static gpointer qio_task_thread_worker(gpointer opaque)
 {
-    struct QIOTaskThreadData *data = opaque;
-    QIOTask *task = data->task;
+    QIOTask *task = opaque;
+    QIOTaskThreadData *data = &task->thread_data;
     GSource *idle;
 
-    trace_qio_task_thread_run(data->task);
-    data->worker(data->task, data->opaque);
+    trace_qio_task_thread_run(task);
+    data->worker(task, data->opaque);
 
     /* We're running in the background thread, and must only
      * ever report the task results in the main event loop
      * thread. So we schedule an idle callback to report
      * the worker results
      */
-    trace_qio_task_thread_exit(data->task);
+    trace_qio_task_thread_exit(task);
 
     idle = g_idle_source_new();
     g_source_set_callback(idle, qio_task_thread_result, data, NULL);
@@ -142,15 +149,14 @@ void qio_task_run_in_thread(QIOTask *task,
                             GDestroyNotify destroy,
                             GMainContext *context)
 {
-    struct QIOTaskThreadData *data = g_new0(struct QIOTaskThreadData, 1);
     QemuThread thread;
+    QIOTaskThreadData *data = &task->thread_data;
 
     if (context) {
         g_main_context_ref(context);
         task->context = context;
     }
 
-    data->task = task;
     data->worker = worker;
     data->opaque = opaque;
     data->destroy = destroy;
@@ -159,7 +165,7 @@ void qio_task_run_in_thread(QIOTask *task,
     qemu_thread_create(&thread,
                        "io-task-worker",
                        qio_task_thread_worker,
-                       data,
+                       task,
                        QEMU_THREAD_DETACHED);
 }
 
-- 
2.14.3
