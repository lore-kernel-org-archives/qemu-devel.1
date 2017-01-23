Received: from eggs.gnu.org ([2001:4830:134:3::10]:43744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVfZu-0000oq-VB
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVfZu-0006IU-1v
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:26:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVfZt-0006IB-QJ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:26:37 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 23 Jan 2017 14:26:23 +0000
Message-Id: <20170123142629.11110-3-berrange@redhat.com>
In-Reply-To: <20170123142629.11110-1-berrange@redhat.com>
References: <20170123142629.11110-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 2/8] io: stop incrementing reference in
 qio_task_get_source
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

Incrementing the reference in qio_task_get_source is
not necessary, since we're not running concurrently
with any other code touching the QIOTask. This
minimizes chances of further memory leaks.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/task.h    | 7 ++++---
 io/channel-socket.c  | 3 ---
 io/channel-tls.c     | 2 --
 io/task.c            | 1 -
 tests/test-io-task.c | 1 -
 5 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/io/task.h b/include/io/task.h
index 42028cb..c268eb0 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -244,9 +244,10 @@ void qio_task_abort(QIOTask *task,
  * @task: the task struct
  *
  * Get the source object associated with the background
- * task. This returns a new reference to the object,
- * which the caller must released with object_unref()
- * when no longer required.
+ * task. The caller does not own a reference on the
+ * returned Object, and so should call object_ref()
+ * if it wants to keep the object pointer outside the
+ * lifetime of the QIOTask object.
  *
  * Returns: the source object
  */
diff --git a/io/channel-socket.c b/io/channel-socket.c
index d7e03f6..45df819 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -168,7 +168,6 @@ static int qio_channel_socket_connect_worker(QIOTask *task,
                                           addr,
                                           errp);
 
-    object_unref(OBJECT(ioc));
     return ret;
 }
 
@@ -231,7 +230,6 @@ static int qio_channel_socket_listen_worker(QIOTask *task,
                                          addr,
                                          errp);
 
-    object_unref(OBJECT(ioc));
     return ret;
 }
 
@@ -309,7 +307,6 @@ static int qio_channel_socket_dgram_worker(QIOTask *task,
                                         data->remoteAddr,
                                         errp);
 
-    object_unref(OBJECT(ioc));
     return ret;
 }
 
diff --git a/io/channel-tls.c b/io/channel-tls.c
index d24dc8c..cf3bcca 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -200,8 +200,6 @@ static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
     qio_channel_tls_handshake_task(
        tioc, task);
 
-    object_unref(OBJECT(tioc));
-
     return FALSE;
 }
 
diff --git a/io/task.c b/io/task.c
index c7f97a9..a763990 100644
--- a/io/task.c
+++ b/io/task.c
@@ -156,6 +156,5 @@ void qio_task_abort(QIOTask *task,
 
 Object *qio_task_get_source(QIOTask *task)
 {
-    object_ref(task->source);
     return task->source;
 }
diff --git a/tests/test-io-task.c b/tests/test-io-task.c
index e091c12..024eb58 100644
--- a/tests/test-io-task.c
+++ b/tests/test-io-task.c
@@ -76,7 +76,6 @@ static void test_task_complete(void)
     g_assert(obj == src);
 
     object_unref(obj);
-    object_unref(src);
 
     g_assert(data.source == obj);
     g_assert(data.err == NULL);
-- 
2.9.3
