Received: from eggs.gnu.org ([2001:4830:134:3::10]:33722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxn-0008Pw-8N
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxl-0000sk-Sv
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqtxl-0000sa-Ks
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51B8A87ABA
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:07:33 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Feb 2018 13:06:32 +0800
Message-Id: <20180228050633.7410-14-peterx@redhat.com>
In-Reply-To: <20180228050633.7410-1-peterx@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 13/14] qio: allow threaded qiotask to switch
 contexts
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

This is the part of work to allow the QIOTask to use a different
gcontext rather than the default main gcontext, by providing
qio_task_context_set() API.

We have done some work before on doing similar things to add non-default
gcontext support.  The general idea is that we delete the old GSource
from the main context, then re-add a new one to the new context when
context changed to a non-default one.  However this trick won't work
easily for threaded QIOTasks since we can't easily stop a real thread
and re-setup the whole thing from the very beginning.

But luckily, we don't need to do anything to the thread.  We just need
to keep an eye on the GSource that completes the QIOTask, which is
assigned to gcontext after the sync operation finished.

So when we setup a non-default GMainContext for a threaded QIO task, we
may face two cases:

- the thread is still running the sync task: then we don't need to do
  anything, only to update QIOTask.context to the new context

- the thread has finished the sync task and queued an idle task to main
  thread: then we destroy that old idle task, and re-create it on the
  new GMainContext.

Note that along the way when we modify either idle GSource or the
context, we need to take the mutex before hand, since the thread may be
modifying them at the same time.

Finally, call qio_task_context_set() in the tcp chardev update read
handler hook if QIOTask is running.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c |  4 +++
 include/io/task.h     |  1 +
 io/task.c             | 70 ++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 9d51b8da07..164a64ff34 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -585,6 +585,10 @@ static void tcp_chr_update_read_handler(Chardev *chr)
         tcp_chr_telnet_init(CHARDEV(s));
     }
 
+    if (s->thread_task) {
+        qio_task_context_set(s->thread_task, chr->gcontext);
+    }
+
     if (!s->connected) {
         return;
     }
diff --git a/include/io/task.h b/include/io/task.h
index c6acd6489c..87e0152d8a 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -324,5 +324,6 @@ Object *qio_task_get_source(QIOTask *task);
 
 void qio_task_ref(QIOTask *task);
 void qio_task_unref(QIOTask *task);
+void qio_task_context_set(QIOTask *task, GMainContext *context);
 
 #endif /* QIO_TASK_H */
diff --git a/io/task.c b/io/task.c
index 080f9560ea..59bc439bdf 100644
--- a/io/task.c
+++ b/io/task.c
@@ -42,6 +42,9 @@ struct QIOTask {
     uint32_t refcount;
 
     /* Threaded QIO task specific fields */
+    bool has_thread;
+    QemuThread thread;
+    QemuMutex mutex;       /* Protects threaded QIO task fields */
     GSource *idle_source;  /* The idle task to run complete routine */
     GMainContext *context; /* The context that idle task will run with */
     QIOTaskThreadData thread_data;
@@ -57,6 +60,8 @@ QIOTask *qio_task_new(Object *source,
 
     task = g_new0(QIOTask, 1);
 
+    qemu_mutex_init(&task->mutex);
+
     task->source = source;
     object_ref(source);
     task->func = func;
@@ -88,7 +93,16 @@ static void qio_task_free(QIOTask *task)
     if (task->context) {
         g_main_context_unref(task->context);
     }
+    /*
+     * Make sure the thread quitted before we destroy the mutex,
+     * otherwise the thread might still be using it.
+     */
+    if (task->has_thread) {
+        qemu_thread_join(&task->thread);
+    }
+
     object_unref(task->source);
+    qemu_mutex_destroy(&task->mutex);
 
     g_free(task);
 }
@@ -117,12 +131,28 @@ static gboolean qio_task_thread_result(gpointer opaque)
     return FALSE;
 }
 
+/* Must be with QIOTask.mutex held. */
+static void qio_task_thread_create_complete_job(QIOTask *task)
+{
+    GSource *idle;
+
+    /* Remove the old if there is */
+    if (task->idle_source) {
+        g_source_destroy(task->idle_source);
+        g_source_unref(task->idle_source);
+    }
+
+    idle = g_idle_source_new();
+    g_source_set_callback(idle, qio_task_thread_result, task, NULL);
+    g_source_attach(idle, task->context);
+
+    task->idle_source = idle;
+}
 
 static gpointer qio_task_thread_worker(gpointer opaque)
 {
     QIOTask *task = opaque;
     QIOTaskThreadData *data = &task->thread_data;
-    GSource *idle;
 
     trace_qio_task_thread_run(task);
     data->worker(task, data->opaque);
@@ -134,10 +164,9 @@ static gpointer qio_task_thread_worker(gpointer opaque)
      */
     trace_qio_task_thread_exit(task);
 
-    idle = g_idle_source_new();
-    g_source_set_callback(idle, qio_task_thread_result, data, NULL);
-    g_source_attach(idle, task->context);
-    task->idle_source = idle;
+    qemu_mutex_lock(&task->mutex);
+    qio_task_thread_create_complete_job(task);
+    qemu_mutex_unlock(&task->mutex);
 
     return NULL;
 }
@@ -149,24 +178,21 @@ void qio_task_run_in_thread(QIOTask *task,
                             GDestroyNotify destroy,
                             GMainContext *context)
 {
-    QemuThread thread;
     QIOTaskThreadData *data = &task->thread_data;
 
-    if (context) {
-        g_main_context_ref(context);
-        task->context = context;
-    }
+    qio_task_context_set(task, context);
 
     data->worker = worker;
     data->opaque = opaque;
     data->destroy = destroy;
 
     trace_qio_task_thread_start(task, worker, opaque);
-    qemu_thread_create(&thread,
+    qemu_thread_create(&task->thread,
                        "io-task-worker",
                        qio_task_thread_worker,
                        task,
-                       QEMU_THREAD_DETACHED);
+                       QEMU_THREAD_JOINABLE);
+    task->has_thread = true;
 }
 
 
@@ -235,3 +261,23 @@ void qio_task_unref(QIOTask *task)
         qio_task_free(task);
     }
 }
+
+void qio_task_context_set(QIOTask *task, GMainContext *context)
+{
+    qemu_mutex_lock(&task->mutex);
+    if (task->context) {
+        g_main_context_unref(task->context);
+    }
+    if (context) {
+        g_main_context_ref(task->context);
+        task->context = context;
+    }
+    if (task->idle_source) {
+        /*
+         * We have had an idle job on the old context. Firstly delete
+         * the old one, then create a new one on the new context.
+         */
+        qio_task_thread_create_complete_job(task);
+    }
+    qemu_mutex_unlock(&task->mutex);
+}
-- 
2.14.3
