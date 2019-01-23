Received: from eggs.gnu.org ([209.51.188.92]:41706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMJh-0002JH-94
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMJf-0002SK-Bg
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:27:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmMJd-0002Qj-D4
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:27:55 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 17:27:25 +0000
Message-Id: <20190123172740.32452-2-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-1-berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/16] io: store reference to thread
 information in the QIOTask struct
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

Currently the struct QIOTaskThreadData is only needed by the worker
thread, but a subsequent patch will need to access it from another
context.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 io/task.c | 53 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/io/task.c b/io/task.c
index 2886a2c1bc..d100a754d3 100644
--- a/io/task.c
+++ b/io/task.c
@@ -24,6 +24,14 @@
 #include "qemu/thread.h"
 #include "trace.h"
=20
+struct QIOTaskThreadData {
+    QIOTaskWorker worker;
+    gpointer opaque;
+    GDestroyNotify destroy;
+    GMainContext *context;
+};
+
+
 struct QIOTask {
     Object *source;
     QIOTaskFunc func;
@@ -32,6 +40,7 @@ struct QIOTask {
     Error *err;
     gpointer result;
     GDestroyNotify destroyResult;
+    struct QIOTaskThreadData *thread;
 };
=20
=20
@@ -72,31 +81,23 @@ static void qio_task_free(QIOTask *task)
 }
=20
=20
-struct QIOTaskThreadData {
-    QIOTask *task;
-    QIOTaskWorker worker;
-    gpointer opaque;
-    GDestroyNotify destroy;
-    GMainContext *context;
-};
-
-
 static gboolean qio_task_thread_result(gpointer opaque)
 {
-    struct QIOTaskThreadData *data =3D opaque;
+    QIOTask *task =3D opaque;
=20
-    trace_qio_task_thread_result(data->task);
-    qio_task_complete(data->task);
+    trace_qio_task_thread_result(task);
+    qio_task_complete(task);
=20
-    if (data->destroy) {
-        data->destroy(data->opaque);
+    if (task->thread->destroy) {
+        task->thread->destroy(task->thread->opaque);
     }
=20
-    if (data->context) {
-        g_main_context_unref(data->context);
+    if (task->thread->context) {
+        g_main_context_unref(task->thread->context);
     }
=20
-    g_free(data);
+    g_free(task->thread);
+    task->thread =3D NULL;
=20
     return FALSE;
 }
@@ -104,22 +105,23 @@ static gboolean qio_task_thread_result(gpointer opa=
que)
=20
 static gpointer qio_task_thread_worker(gpointer opaque)
 {
-    struct QIOTaskThreadData *data =3D opaque;
+    QIOTask *task =3D opaque;
     GSource *idle;
=20
-    trace_qio_task_thread_run(data->task);
-    data->worker(data->task, data->opaque);
+    trace_qio_task_thread_run(task);
+
+    task->thread->worker(task, task->thread->opaque);
=20
     /* We're running in the background thread, and must only
      * ever report the task results in the main event loop
      * thread. So we schedule an idle callback to report
      * the worker results
      */
-    trace_qio_task_thread_exit(data->task);
+    trace_qio_task_thread_exit(task);
=20
     idle =3D g_idle_source_new();
-    g_source_set_callback(idle, qio_task_thread_result, data, NULL);
-    g_source_attach(idle, data->context);
+    g_source_set_callback(idle, qio_task_thread_result, task, NULL);
+    g_source_attach(idle, task->thread->context);
=20
     return NULL;
 }
@@ -138,17 +140,18 @@ void qio_task_run_in_thread(QIOTask *task,
         g_main_context_ref(context);
     }
=20
-    data->task =3D task;
     data->worker =3D worker;
     data->opaque =3D opaque;
     data->destroy =3D destroy;
     data->context =3D context;
=20
+    task->thread =3D data;
+
     trace_qio_task_thread_start(task, worker, opaque);
     qemu_thread_create(&thread,
                        "io-task-worker",
                        qio_task_thread_worker,
-                       data,
+                       task,
                        QEMU_THREAD_DETACHED);
 }
=20
--=20
2.20.1
