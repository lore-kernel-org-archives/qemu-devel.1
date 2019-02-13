Received: from eggs.gnu.org ([209.51.188.92]:39187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxG5-00044v-Nv
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxG2-0005Jz-4T
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtxG1-0005C4-F5
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:33 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 17:18:52 +0100
Message-Id: <20190213161913.22107-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190213161913.22107-1-marcandre.lureau@redhat.com>
References: <20190213161913.22107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 04/25] io: add qio_task_wait_thread to join
 with a background thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Add the ability for a caller to wait for completion of the
background thread to synchronously dispatch its result, without
needing to wait for the main loop to run the idle callback.

This method needs very careful usage to avoid a dangerous
race condition with the free'ing of the task. The completion
callback is normally invoked from an idle callback registered
with the main loop context. The qio_task_wait_thread method
must only be called if the completion callback has not yet
run. The only safe way to achieve this is to run the
qio_task_wait_thread method from the thread that executes
the main loop.

It is generally a bad idea to use this method since it will
block execution of the main loop, however, the design of
the character devices and its usage from vhostuser already
requires blocking execution.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190211182442.8542-3-berrange@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/io/task.h | 29 ++++++++++++++++++++++++++++-
 io/task.c         | 41 +++++++++++++++++++++++++++++++++++++----
 io/trace-events   |  2 ++
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/include/io/task.h b/include/io/task.h
index 9e09b95b2e..57d8ba835e 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -232,7 +232,8 @@ QIOTask *qio_task_new(Object *source,
  *
  * Run a task in a background thread. When @worker
  * returns it will call qio_task_complete() in
- * the event thread context that provided.
+ * the thread that is running the main loop associated
+ * with @context.
  */
 void qio_task_run_in_thread(QIOTask *task,
                             QIOTaskWorker worker,
@@ -240,6 +241,32 @@ void qio_task_run_in_thread(QIOTask *task,
                             GDestroyNotify destroy,
                             GMainContext *context);
=20
+
+/**
+ * qio_task_wait_thread:
+ * @task: the task struct
+ *
+ * Wait for completion of a task that was previously
+ * invoked using qio_task_run_in_thread. This MUST
+ * ONLY be invoked if the task has not already
+ * completed, since after the completion callback
+ * is invoked, @task will have been freed.
+ *
+ * To avoid racing with execution of the completion
+ * callback provided with qio_task_new, this method
+ * MUST ONLY be invoked from the thread that is
+ * running the main loop associated with @context
+ * parameter to qio_task_run_in_thread.
+ *
+ * When the thread has completed, the completion
+ * callback provided to qio_task_new will be invoked.
+ * When that callback returns @task will be freed,
+ * so @task must not be referenced after this
+ * method completes.
+ */
+void qio_task_wait_thread(QIOTask *task);
+
+
 /**
  * qio_task_complete:
  * @task: the task struct
diff --git a/io/task.c b/io/task.c
index 396866b10f..64c4c7126a 100644
--- a/io/task.c
+++ b/io/task.c
@@ -29,6 +29,7 @@ struct QIOTaskThreadData {
     gpointer opaque;
     GDestroyNotify destroy;
     GMainContext *context;
+    GSource *completion;
 };
=20
=20
@@ -40,6 +41,8 @@ struct QIOTask {
     Error *err;
     gpointer result;
     GDestroyNotify destroyResult;
+    QemuMutex thread_lock;
+    QemuCond thread_cond;
     struct QIOTaskThreadData *thread;
 };
=20
@@ -58,6 +61,8 @@ QIOTask *qio_task_new(Object *source,
     task->func =3D func;
     task->opaque =3D opaque;
     task->destroy =3D destroy;
+    qemu_mutex_init(&task->thread_lock);
+    qemu_cond_init(&task->thread_cond);
=20
     trace_qio_task_new(task, source, func, opaque);
=20
@@ -66,6 +71,7 @@ QIOTask *qio_task_new(Object *source,
=20
 static void qio_task_free(QIOTask *task)
 {
+    qemu_mutex_lock(&task->thread_lock);
     if (task->thread) {
         if (task->thread->destroy) {
             task->thread->destroy(task->thread->opaque);
@@ -89,6 +95,10 @@ static void qio_task_free(QIOTask *task)
     }
     object_unref(task->source);
=20
+    qemu_mutex_unlock(&task->thread_lock);
+    qemu_mutex_destroy(&task->thread_lock);
+    qemu_cond_destroy(&task->thread_cond);
+
     g_free(task);
 }
=20
@@ -107,7 +117,6 @@ static gboolean qio_task_thread_result(gpointer opaqu=
e)
 static gpointer qio_task_thread_worker(gpointer opaque)
 {
     QIOTask *task =3D opaque;
-    GSource *idle;
=20
     trace_qio_task_thread_run(task);
=20
@@ -120,9 +129,17 @@ static gpointer qio_task_thread_worker(gpointer opaq=
ue)
      */
     trace_qio_task_thread_exit(task);
=20
-    idle =3D g_idle_source_new();
-    g_source_set_callback(idle, qio_task_thread_result, task, NULL);
-    g_source_attach(idle, task->thread->context);
+    qemu_mutex_lock(&task->thread_lock);
+
+    task->thread->completion =3D g_idle_source_new();
+    g_source_set_callback(task->thread->completion,
+                          qio_task_thread_result, task, NULL);
+    g_source_attach(task->thread->completion,
+                    task->thread->context);
+    trace_qio_task_thread_source_attach(task, task->thread->completion);
+
+    qemu_cond_signal(&task->thread_cond);
+    qemu_mutex_unlock(&task->thread_lock);
=20
     return NULL;
 }
@@ -157,6 +174,22 @@ void qio_task_run_in_thread(QIOTask *task,
 }
=20
=20
+void qio_task_wait_thread(QIOTask *task)
+{
+    qemu_mutex_lock(&task->thread_lock);
+    g_assert(task->thread !=3D NULL);
+    while (task->thread->completion =3D=3D NULL) {
+        qemu_cond_wait(&task->thread_cond, &task->thread_lock);
+    }
+
+    trace_qio_task_thread_source_cancel(task, task->thread->completion);
+    g_source_destroy(task->thread->completion);
+    qemu_mutex_unlock(&task->thread_lock);
+
+    qio_task_thread_result(task);
+}
+
+
 void qio_task_complete(QIOTask *task)
 {
     task->func(task, task->opaque);
diff --git a/io/trace-events b/io/trace-events
index f70bad7cbe..07a7bbec6a 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -7,6 +7,8 @@ qio_task_thread_start(void *task, void *worker, void *opa=
que) "Task thread start
 qio_task_thread_run(void *task) "Task thread run task=3D%p"
 qio_task_thread_exit(void *task) "Task thread exit task=3D%p"
 qio_task_thread_result(void *task) "Task thread result task=3D%p"
+qio_task_thread_source_attach(void *task, void *source) "Task thread sou=
rce attach task=3D%p source=3D%p"
+qio_task_thread_source_cancel(void *task, void *source) "Task thread sou=
rce cancel task=3D%p source=3D%p"
=20
 # io/channel-socket.c
 qio_channel_socket_new(void *ioc) "Socket new ioc=3D%p"
--=20
2.21.0.rc0.1.g036caf7885
