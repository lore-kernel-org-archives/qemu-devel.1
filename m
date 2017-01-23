Received: from eggs.gnu.org ([2001:4830:134:3::10]:43831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVfa4-00018l-Fg
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVfa2-0006LQ-2c
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:26:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVfa1-0006Ku-Ql
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:26:46 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 23 Jan 2017 14:26:27 +0000
Message-Id: <20170123142629.11110-7-berrange@redhat.com>
In-Reply-To: <20170123142629.11110-1-berrange@redhat.com>
References: <20170123142629.11110-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 6/8] io: change the QIOTask callback signature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

Currently the QIOTaskFunc signature takes an Object * for
the source, and an Error * for any error. We also need to
be able to provide a result pointer. Rather than continue
to add parameters to QIOTaskFunc, remove the existing
ones and simply pass the QIOTask object instead. This
has methods to access all the other data items required
in the callback impl.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/task.h              | 73 ++++++++++++++++++++++++------------------
 io/channel-tls.c               | 14 ++++----
 io/channel-websock.c           |  8 ++---
 io/task.c                      | 18 +++--------
 io/trace-events                |  1 -
 migration/socket.c             | 11 ++++---
 migration/tls.c                | 19 +++++------
 nbd/common.c                   |  8 ++---
 nbd/nbd-internal.h             |  3 +-
 qemu-char.c                    | 18 ++++++-----
 tests/test-io-channel-socket.c |  5 ++-
 tests/test-io-channel-tls.c    |  5 ++-
 tests/test-io-task.c           | 18 +++++------
 ui/vnc-auth-vencrypt.c         |  7 ++--
 ui/vnc-ws.c                    | 14 ++++----
 15 files changed, 110 insertions(+), 112 deletions(-)

diff --git a/include/io/task.h b/include/io/task.h
index 47daba9..ad90970 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -26,8 +26,7 @@
 
 typedef struct QIOTask QIOTask;
 
-typedef void (*QIOTaskFunc)(Object *source,
-                            Error *err,
+typedef void (*QIOTaskFunc)(QIOTask *task,
                             gpointer opaque);
 
 typedef int (*QIOTaskWorker)(QIOTask *task,
@@ -44,7 +43,7 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
  * a public API which accepts a task callback:
  *
  * <example>
- *   <title>Task callback function signature</title>
+ *   <title>Task function signature</title>
  *   <programlisting>
  *  void myobject_operation(QMyObject *obj,
  *                          QIOTaskFunc *func,
@@ -57,12 +56,36 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
  * is data to pass to it. The optional 'notify' function is used
  * to free 'opaque' when no longer needed.
  *
- * Now, lets say the implementation of this method wants to set
- * a timer to run once a second checking for completion of some
- * activity. It would do something like
+ * When the operation completes, the 'func' callback will be
+ * invoked, allowing the calling code to determine the result
+ * of the operation. An example QIOTaskFunc implementation may
+ * look like
  *
  * <example>
- *   <title>Task callback function implementation</title>
+ *   <title>Task callback implementation</title>
+ *   <programlisting>
+ *  static void myobject_operation_notify(QIOTask *task,
+ *                                        gpointer opaque)
+ *  {
+ *      Error *err = NULL;
+ *      if (qio_task_propagate_error(task, &err)) {
+ *          ...deal with the failure...
+ *          error_free(err);
+ *      } else {
+ *          QMyObject *src = QMY_OBJECT(qio_task_get_source(task));
+ *          ...deal with the completion...
+ *      }
+ *  }
+ *   </programlisting>
+ * </example>
+ *
+ * Now, lets say the implementation of the method using the
+ * task wants to set a timer to run once a second checking
+ * for completion of some activity. It would do something
+ * like
+ *
+ * <example>
+ *   <title>Task function implementation</title>
  *   <programlisting>
  *    void myobject_operation(QMyObject *obj,
  *                            QIOTaskFunc *func,
@@ -102,8 +125,8 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
  *
  *      ...check something important...
  *       if (err) {
- *           qio_task_abort(task, err);
- *           error_free(task);
+ *           qio_task_set_error(task, err);
+ *           qio_task_complete(task);
  *           return FALSE;
  *       } else if (...work is completed ...) {
  *           qio_task_complete(task);
@@ -115,6 +138,10 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
  *   </programlisting>
  * </example>
  *
+ * The 'qio_task_complete' call in this method will trigger
+ * the callback func 'myobject_operation_notify' shown
+ * earlier to deal with the results.
+ *
  * Once this function returns false, object_unref will be called
  * automatically on the task causing it to be released and the
  * ref on QMyObject dropped too.
@@ -187,8 +214,8 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
  * 'err' attribute in the task object to determine if
  * the operation was successful or not.
  *
- * The returned task will be released when one of
- * qio_task_abort() or qio_task_complete() are invoked.
+ * The returned task will be released when qio_task_complete()
+ * is invoked.
  *
  * Returns: the task struct
  */
@@ -204,10 +231,8 @@ QIOTask *qio_task_new(Object *source,
  * @opaque: opaque data to pass to @worker
  * @destroy: function to free @opaque
  *
- * Run a task in a background thread. If @worker
- * returns 0 it will call qio_task_complete() in
- * the main event thread context. If @worker
- * returns -1 it will call qio_task_abort() in
+ * Run a task in a background thread. When @worker
+ * returns it will call qio_task_complete() in
  * the main event thread context.
  */
 void qio_task_run_in_thread(QIOTask *task,
@@ -219,25 +244,11 @@ void qio_task_run_in_thread(QIOTask *task,
  * qio_task_complete:
  * @task: the task struct
  *
- * Mark the operation as successfully completed
- * and free the memory for @task.
+ * Invoke the completion callback for @task and
+ * then free its memory.
  */
 void qio_task_complete(QIOTask *task);
 
-/**
- * qio_task_abort:
- * @task: the task struct
- * @err: the error to record for the operation
- *
- * Mark the operation as failed, with @err providing
- * details about the failure. The @err may be freed
- * afer the function returns, as the notification
- * callback is invoked synchronously. The @task will
- * be freed when this call completes.
- */
-void qio_task_abort(QIOTask *task,
-                    Error *err);
-
 
 /**
  * qio_task_set_error:
diff --git a/io/channel-tls.c b/io/channel-tls.c
index cf3bcca..f25ab0a 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -153,8 +153,9 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
 
     if (qcrypto_tls_session_handshake(ioc->session, &err) < 0) {
         trace_qio_channel_tls_handshake_fail(ioc);
-        qio_task_abort(task, err);
-        goto cleanup;
+        qio_task_set_error(task, err);
+        qio_task_complete(task);
+        return;
     }
 
     status = qcrypto_tls_session_get_handshake_status(ioc->session);
@@ -163,10 +164,10 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
         if (qcrypto_tls_session_check_credentials(ioc->session,
                                                   &err) < 0) {
             trace_qio_channel_tls_credentials_deny(ioc);
-            qio_task_abort(task, err);
-            goto cleanup;
+            qio_task_set_error(task, err);
+        } else {
+            trace_qio_channel_tls_credentials_allow(ioc);
         }
-        trace_qio_channel_tls_credentials_allow(ioc);
         qio_task_complete(task);
     } else {
         GIOCondition condition;
@@ -183,9 +184,6 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
                               task,
                               NULL);
     }
-
- cleanup:
-    error_free(err);
 }
 
 
diff --git a/io/channel-websock.c b/io/channel-websock.c
index f45bced..e47279a 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -279,8 +279,8 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
 
     if (ret < 0) {
         trace_qio_channel_websock_handshake_fail(ioc);
-        qio_task_abort(task, err);
-        error_free(err);
+        qio_task_set_error(task, err);
+        qio_task_complete(task);
         return FALSE;
     }
 
@@ -307,8 +307,8 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
     ret = qio_channel_websock_handshake_read(wioc, &err);
     if (ret < 0) {
         trace_qio_channel_websock_handshake_fail(ioc);
-        qio_task_abort(task, err);
-        error_free(err);
+        qio_task_set_error(task, err);
+        qio_task_complete(task);
         return FALSE;
     }
     if (ret == 0) {
diff --git a/io/task.c b/io/task.c
index 1394e05..42e1a75 100644
--- a/io/task.c
+++ b/io/task.c
@@ -87,13 +87,11 @@ static gboolean gio_task_thread_result(gpointer opaque)
     struct QIOTaskThreadData *data = opaque;
 
     trace_qio_task_thread_result(data->task);
-    if (data->ret == 0) {
-        qio_task_complete(data->task);
-    } else {
-        qio_task_abort(data->task, data->err);
+    if (data->err) {
+        qio_task_set_error(data->task, data->err);
     }
+    qio_task_complete(data->task);
 
-    error_free(data->err);
     if (data->destroy) {
         data->destroy(data->opaque);
     }
@@ -149,19 +147,11 @@ void qio_task_run_in_thread(QIOTask *task,
 
 void qio_task_complete(QIOTask *task)
 {
-    task->func(task->source, NULL, task->opaque);
+    task->func(task, task->opaque);
     trace_qio_task_complete(task);
     qio_task_free(task);
 }
 
-void qio_task_abort(QIOTask *task,
-                    Error *err)
-{
-    task->func(task->source, err, task->opaque);
-    trace_qio_task_abort(task);
-    qio_task_free(task);
-}
-
 
 void qio_task_set_error(QIOTask *task,
                         Error *err)
diff --git a/io/trace-events b/io/trace-events
index e31b596..ff993be 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -3,7 +3,6 @@
 # io/task.c
 qio_task_new(void *task, void *source, void *func, void *opaque) "Task new task=%p source=%p func=%p opaque=%p"
 qio_task_complete(void *task) "Task complete task=%p"
-qio_task_abort(void *task) "Task abort task=%p"
 qio_task_thread_start(void *task, void *worker, void *opaque) "Task thread start task=%p worker=%p opaque=%p"
 qio_task_thread_run(void *task) "Task thread run task=%p"
 qio_task_thread_exit(void *task) "Task thread exit task=%p"
diff --git a/migration/socket.c b/migration/socket.c
index 11f80b1..13966f1 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -70,22 +70,23 @@ static void socket_connect_data_free(void *opaque)
     g_free(data);
 }
 
-static void socket_outgoing_migration(Object *src,
-                                      Error *err,
+static void socket_outgoing_migration(QIOTask *task,
                                       gpointer opaque)
 {
     struct SocketConnectData *data = opaque;
-    QIOChannel *sioc = QIO_CHANNEL(src);
+    QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
+    Error *err = NULL;
 
-    if (err) {
+    if (qio_task_propagate_error(task, &err)) {
         trace_migration_socket_outgoing_error(error_get_pretty(err));
         data->s->to_dst_file = NULL;
         migrate_fd_error(data->s, err);
+        error_free(err);
     } else {
         trace_migration_socket_outgoing_connected(data->hostname);
         migration_channel_connect(data->s, sioc, data->hostname);
     }
-    object_unref(src);
+    object_unref(OBJECT(sioc));
 }
 
 static void socket_start_outgoing_migration(MigrationState *s,
diff --git a/migration/tls.c b/migration/tls.c
index 49ca9a8..203c11d 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -61,15 +61,15 @@ migration_tls_get_creds(MigrationState *s,
 }
 
 
-static void migration_tls_incoming_handshake(Object *src,
-                                             Error *err,
+static void migration_tls_incoming_handshake(QIOTask *task,
                                              gpointer opaque)
 {
-    QIOChannel *ioc = QIO_CHANNEL(src);
+    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
+    Error *err = NULL;
 
-    if (err) {
+    if (qio_task_propagate_error(task, &err)) {
         trace_migration_tls_incoming_handshake_error(error_get_pretty(err));
-        error_report("%s", error_get_pretty(err));
+        error_report_err(err);
     } else {
         trace_migration_tls_incoming_handshake_complete();
         migration_channel_process_incoming(migrate_get_current(), ioc);
@@ -107,17 +107,18 @@ void migration_tls_channel_process_incoming(MigrationState *s,
 }
 
 
-static void migration_tls_outgoing_handshake(Object *src,
-                                             Error *err,
+static void migration_tls_outgoing_handshake(QIOTask *task,
                                              gpointer opaque)
 {
     MigrationState *s = opaque;
-    QIOChannel *ioc = QIO_CHANNEL(src);
+    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
+    Error *err = NULL;
 
-    if (err) {
+    if (qio_task_propagate_error(task, &err)) {
         trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
         s->to_dst_file = NULL;
         migrate_fd_error(s, err);
+        error_free(err);
     } else {
         trace_migration_tls_outgoing_handshake_complete();
         migration_channel_connect(s, ioc, NULL);
diff --git a/nbd/common.c b/nbd/common.c
index b583a4f..a5f39ea 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -78,15 +78,13 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
 }
 
 
-void nbd_tls_handshake(Object *src,
-                       Error *err,
+void nbd_tls_handshake(QIOTask *task,
                        void *opaque)
 {
     struct NBDTLSHandshakeData *data = opaque;
 
-    if (err) {
-        TRACE("TLS failed %s", error_get_pretty(err));
-        data->error = error_copy(err);
+    if (qio_task_propagate_error(task, &data->error)) {
+        TRACE("TLS failed %s", error_get_pretty(data->error));
     }
     data->complete = true;
     g_main_loop_quit(data->loop);
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index eee20ab..f43d990 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -120,8 +120,7 @@ struct NBDTLSHandshakeData {
 };
 
 
-void nbd_tls_handshake(Object *src,
-                       Error *err,
+void nbd_tls_handshake(QIOTask *task,
                        void *opaque);
 
 #endif
diff --git a/qemu-char.c b/qemu-char.c
index 676944a..d8da167 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -3277,14 +3277,13 @@ static void tcp_chr_telnet_init(CharDriverState *chr)
 }
 
 
-static void tcp_chr_tls_handshake(Object *source,
-                                  Error *err,
+static void tcp_chr_tls_handshake(QIOTask *task,
                                   gpointer user_data)
 {
     CharDriverState *chr = user_data;
     TCPCharDriver *s = chr->opaque;
 
-    if (err) {
+    if (qio_task_propagate_error(task, NULL)) {
         tcp_chr_disconnect(chr);
     } else {
         if (s->do_telnetopt) {
@@ -3492,20 +3491,23 @@ static void tcp_chr_free(CharDriverState *chr)
 }
 
 
-static void qemu_chr_socket_connected(Object *src, Error *err, void *opaque)
+static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
 {
-    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(src);
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
     CharDriverState *chr = opaque;
     TCPCharDriver *s = chr->opaque;
+    Error *err = NULL;
 
-    if (err) {
+    if (qio_task_propagate_error(task, &err)) {
         check_report_connect_error(chr, err);
-        object_unref(src);
-        return;
+        error_free(err);
+        goto cleanup;
     }
 
     s->connect_err_reported = false;
     tcp_chr_new_client(chr, sioc);
+
+ cleanup:
     object_unref(OBJECT(sioc));
 }
 
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
index aa88c3c..aaa9116 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -156,12 +156,11 @@ struct TestIOChannelData {
 };
 
 
-static void test_io_channel_complete(Object *src,
-                                     Error *err,
+static void test_io_channel_complete(QIOTask *task,
                                      gpointer opaque)
 {
     struct TestIOChannelData *data = opaque;
-    data->err = err != NULL;
+    data->err = qio_task_propagate_error(task, NULL);
     g_main_loop_quit(data->loop);
 }
 
diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index bd3ae2b..8eaa208 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -53,14 +53,13 @@ struct QIOChannelTLSHandshakeData {
     bool failed;
 };
 
-static void test_tls_handshake_done(Object *source,
-                                    Error *err,
+static void test_tls_handshake_done(QIOTask *task,
                                     gpointer opaque)
 {
     struct QIOChannelTLSHandshakeData *data = opaque;
 
     data->finished = true;
-    data->failed = err != NULL;
+    data->failed = qio_task_propagate_error(task, NULL);
 }
 
 
diff --git a/tests/test-io-task.c b/tests/test-io-task.c
index 024eb58..84144c9 100644
--- a/tests/test-io-task.c
+++ b/tests/test-io-task.c
@@ -50,14 +50,13 @@ struct TestTaskData {
 };
 
 
-static void task_callback(Object *source,
-                          Error *err,
+static void task_callback(QIOTask *task,
                           gpointer opaque)
 {
     struct TestTaskData *data = opaque;
 
-    data->source = source;
-    data->err = err;
+    data->source = qio_task_get_source(task);
+    qio_task_propagate_error(task, &data->err);
 }
 
 
@@ -120,9 +119,9 @@ static void test_task_failure(void)
 
     error_setg(&err, "Some error");
 
-    qio_task_abort(task, err);
+    qio_task_set_error(task, err);
+    qio_task_complete(task);
 
-    error_free(err);
     object_unref(obj);
 
     g_assert(data.source == obj);
@@ -158,14 +157,13 @@ static int test_task_thread_worker(QIOTask *task,
 }
 
 
-static void test_task_thread_callback(Object *source,
-                                      Error *err,
+static void test_task_thread_callback(QIOTask *task,
                                       gpointer opaque)
 {
     struct TestThreadWorkerData *data = opaque;
 
-    data->source = source;
-    data->err = err;
+    data->source = qio_task_get_source(task);
+    qio_task_propagate_error(task, &data->err);
 
     data->complete = g_thread_self();
 
diff --git a/ui/vnc-auth-vencrypt.c b/ui/vnc-auth-vencrypt.c
index c0c29a5..ffaab57 100644
--- a/ui/vnc-auth-vencrypt.c
+++ b/ui/vnc-auth-vencrypt.c
@@ -65,16 +65,17 @@ static void start_auth_vencrypt_subauth(VncState *vs)
     }
 }
 
-static void vnc_tls_handshake_done(Object *source,
-                                   Error *err,
+static void vnc_tls_handshake_done(QIOTask *task,
                                    gpointer user_data)
 {
     VncState *vs = user_data;
+    Error *err = NULL;
 
-    if (err) {
+    if (qio_task_propagate_error(task, &err)) {
         VNC_DEBUG("Handshake failed %s\n",
                   error_get_pretty(err));
         vnc_client_error(vs);
+        error_free(err);
     } else {
         vs->ioc_tag = qio_channel_add_watch(
             vs->ioc, G_IO_IN | G_IO_OUT, vnc_client_io, vs, NULL);
diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
index bffb484..f530cd5 100644
--- a/ui/vnc-ws.c
+++ b/ui/vnc-ws.c
@@ -24,15 +24,16 @@
 #include "io/channel-websock.h"
 #include "qemu/bswap.h"
 
-static void vncws_tls_handshake_done(Object *source,
-                                     Error *err,
+static void vncws_tls_handshake_done(QIOTask *task,
                                      gpointer user_data)
 {
     VncState *vs = user_data;
+    Error *err = NULL;
 
-    if (err) {
+    if (qio_task_propagate_error(task, &err)) {
         VNC_DEBUG("Handshake failed %s\n", error_get_pretty(err));
         vnc_client_error(vs);
+        error_free(err);
     } else {
         VNC_DEBUG("TLS handshake complete, starting websocket handshake\n");
         vs->ioc_tag = qio_channel_add_watch(
@@ -83,15 +84,16 @@ gboolean vncws_tls_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
 }
 
 
-static void vncws_handshake_done(Object *source,
-                                 Error *err,
+static void vncws_handshake_done(QIOTask *task,
                                  gpointer user_data)
 {
     VncState *vs = user_data;
+    Error *err = NULL;
 
-    if (err) {
+    if (qio_task_propagate_error(task, &err)) {
         VNC_DEBUG("Websock handshake failed %s\n", error_get_pretty(err));
         vnc_client_error(vs);
+        error_free(err);
     } else {
         VNC_DEBUG("Websock handshake complete, starting VNC protocol\n");
         vnc_start_protocol(vs);
-- 
2.9.3
