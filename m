Received: from eggs.gnu.org ([209.51.188.92]:41721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMJj-0002KX-8A
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMJh-0002TE-9A
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:27:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmMJf-0002Ro-9l
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:27:57 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 17:27:26 +0000
Message-Id: <20190123172740.32452-3-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-1-berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/16] io: add qio_task_wait_thread to join
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
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Yongji Xie <elohimes@gmail.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

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
---
 include/io/task.h | 29 ++++++++++++++++++++++++++++-
 io/task.c         | 41 ++++++++++++++++++++++++++++++++++++-----
 io/trace-events   |  2 ++
 3 files changed, 66 insertions(+), 6 deletions(-)

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
index d100a754d3..2eb70e934d 100644
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
@@ -77,6 +82,9 @@ static void qio_task_free(QIOTask *task)
     }
     object_unref(task->source);
=20
+    qemu_mutex_destroy(&task->thread_lock);
+    qemu_cond_destroy(&task->thread_cond);
+
     g_free(task);
 }
=20
@@ -86,7 +94,6 @@ static gboolean qio_task_thread_result(gpointer opaque)
     QIOTask *task =3D opaque;
=20
     trace_qio_task_thread_result(task);
-    qio_task_complete(task);
=20
     if (task->thread->destroy) {
         task->thread->destroy(task->thread->opaque);
@@ -98,6 +105,7 @@ static gboolean qio_task_thread_result(gpointer opaque=
)
=20
     g_free(task->thread);
     task->thread =3D NULL;
+    qio_task_complete(task);
=20
     return FALSE;
 }
@@ -106,7 +114,6 @@ static gboolean qio_task_thread_result(gpointer opaqu=
e)
 static gpointer qio_task_thread_worker(gpointer opaque)
 {
     QIOTask *task =3D opaque;
-    GSource *idle;
=20
     trace_qio_task_thread_run(task);
=20
@@ -119,9 +126,17 @@ static gpointer qio_task_thread_worker(gpointer opaq=
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
@@ -156,6 +171,22 @@ void qio_task_run_in_thread(QIOTask *task,
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
2.20.1
