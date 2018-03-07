Received: from eggs.gnu.org ([2001:4830:134:3::10]:38027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXCi-0002JY-4a
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXCg-0000Po-W5
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:25:52 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  7 Mar 2018 11:25:30 +0000
Message-Id: <20180307112532.24248-5-berrange@redhat.com>
In-Reply-To: <20180307112532.24248-1-berrange@redhat.com>
References: <20180307112532.24248-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/6] qio: non-default context for threaded qtask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

qio_task_run_in_thread() allows main thread to run blocking operations
in the background. However it has an assumption on that it's always
working with the default context. This patch tries to allow the threaded
QIO task framework to run with non-default gcontext.

Currently no functional change so far, so the QIOTasks are still always
running on main context.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 include/io/task.h    |  7 +++++--
 io/channel-socket.c  |  9 ++++++---
 io/dns-resolver.c    |  3 ++-
 io/task.c            | 20 ++++++++++++++++++--
 tests/test-io-task.c |  2 ++
 5 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/io/task.h b/include/io/task.h
index 6021f51336..9e09b95b2e 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -227,15 +227,18 @@ QIOTask *qio_task_new(Object *source,
  * @worker: the function to invoke in a thread
  * @opaque: opaque data to pass to @worker
  * @destroy: function to free @opaque
+ * @context: the context to run the complete hook. If %NULL, the
+ *           default context will be used.
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
=20
 /**
  * qio_task_complete:
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 8359b6683a..b4d914b767 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -188,7 +188,8 @@ void qio_channel_socket_connect_async(QIOChannelSocke=
t *ioc,
     qio_task_run_in_thread(task,
                            qio_channel_socket_connect_worker,
                            addrCopy,
-                           (GDestroyNotify)qapi_free_SocketAddress);
+                           (GDestroyNotify)qapi_free_SocketAddress,
+                           NULL);
 }
=20
=20
@@ -246,7 +247,8 @@ void qio_channel_socket_listen_async(QIOChannelSocket=
 *ioc,
     qio_task_run_in_thread(task,
                            qio_channel_socket_listen_worker,
                            addrCopy,
-                           (GDestroyNotify)qapi_free_SocketAddress);
+                           (GDestroyNotify)qapi_free_SocketAddress,
+                           NULL);
 }
=20
=20
@@ -322,7 +324,8 @@ void qio_channel_socket_dgram_async(QIOChannelSocket =
*ioc,
     qio_task_run_in_thread(task,
                            qio_channel_socket_dgram_worker,
                            data,
-                           qio_channel_socket_dgram_worker_free);
+                           qio_channel_socket_dgram_worker_free,
+                           NULL);
 }
=20
=20
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index 8c924071c4..187f725665 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -234,7 +234,8 @@ void qio_dns_resolver_lookup_async(QIODNSResolver *re=
solver,
     qio_task_run_in_thread(task,
                            qio_dns_resolver_lookup_worker,
                            data,
-                           qio_dns_resolver_lookup_data_free);
+                           qio_dns_resolver_lookup_data_free,
+                           NULL);
 }
=20
=20
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
=20
=20
@@ -91,6 +92,10 @@ static gboolean qio_task_thread_result(gpointer opaque=
)
         data->destroy(data->opaque);
     }
=20
+    if (data->context) {
+        g_main_context_unref(data->context);
+    }
+
     g_free(data);
=20
     return FALSE;
@@ -100,6 +105,7 @@ static gboolean qio_task_thread_result(gpointer opaqu=
e)
 static gpointer qio_task_thread_worker(gpointer opaque)
 {
     struct QIOTaskThreadData *data =3D opaque;
+    GSource *idle;
=20
     trace_qio_task_thread_run(data->task);
     data->worker(data->task, data->opaque);
@@ -110,7 +116,11 @@ static gpointer qio_task_thread_worker(gpointer opaq=
ue)
      * the worker results
      */
     trace_qio_task_thread_exit(data->task);
-    g_idle_add(qio_task_thread_result, data);
+
+    idle =3D g_idle_source_new();
+    g_source_set_callback(idle, qio_task_thread_result, data, NULL);
+    g_source_attach(idle, data->context);
+
     return NULL;
 }
=20
@@ -118,15 +128,21 @@ static gpointer qio_task_thread_worker(gpointer opa=
que)
 void qio_task_run_in_thread(QIOTask *task,
                             QIOTaskWorker worker,
                             gpointer opaque,
-                            GDestroyNotify destroy)
+                            GDestroyNotify destroy,
+                            GMainContext *context)
 {
     struct QIOTaskThreadData *data =3D g_new0(struct QIOTaskThreadData, =
1);
     QemuThread thread;
=20
+    if (context) {
+        g_main_context_ref(context);
+    }
+
     data->task =3D task;
     data->worker =3D worker;
     data->opaque =3D opaque;
     data->destroy =3D destroy;
+    data->context =3D context;
=20
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
=20
     g_main_loop_run(data.loop);
@@ -228,6 +229,7 @@ static void test_task_thread_failure(void)
     qio_task_run_in_thread(task,
                            test_task_thread_worker,
                            &data,
+                           NULL,
                            NULL);
=20
     g_main_loop_run(data.loop);
--=20
2.14.3
