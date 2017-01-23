Received: from eggs.gnu.org ([2001:4830:134:3::10]:36170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVh0f-00052T-C7
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVh0c-0006SA-7s
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:58:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVh0c-0006S1-1n
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:58:18 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 23 Jan 2017 15:57:33 +0000
Message-Id: <20170123155737.3793-5-berrange@redhat.com>
In-Reply-To: <20170123155737.3793-1-berrange@redhat.com>
References: <20170123155737.3793-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 4/8] io: add ability to associate an opaque
 "result" with with a task
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

Currently there is no data associated with a successful
task completion. This adds an opaque pointer to the task
to store an arbitrary result.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/task.h | 27 +++++++++++++++++++++++++++
 io/task.c         | 20 ++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/io/task.h b/include/io/task.h
index 1407747..ece1372 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -240,6 +240,33 @@ void qio_task_abort(QIOTask *task,
 
 
 /**
+ * qio_task_set_result_pointer:
+ * @task: the task struct
+ * @result: pointer to the result data
+ *
+ * Associate an opaque result with the task,
+ * which can later be retrieved with the
+ * qio_task_get_result_pointer() method
+ *
+ */
+void qio_task_set_result_pointer(QIOTask *task,
+                                 gpointer result,
+                                 GDestroyNotify notify);
+
+
+/**
+ * qio_task_get_result_pointer:
+ * @task: the task struct
+ *
+ * Retrieve the opaque result data associated
+ * with the task, if any.
+ *
+ * Returns: the task result, or NULL
+ */
+gpointer qio_task_get_result_pointer(QIOTask *task);
+
+
+/**
  * qio_task_get_source:
  * @task: the task struct
  *
diff --git a/io/task.c b/io/task.c
index a763990..675e196 100644
--- a/io/task.c
+++ b/io/task.c
@@ -29,6 +29,8 @@ struct QIOTask {
     QIOTaskFunc func;
     gpointer opaque;
     GDestroyNotify destroy;
+    gpointer result;
+    GDestroyNotify destroyResult;
 };
 
 
@@ -57,6 +59,9 @@ static void qio_task_free(QIOTask *task)
     if (task->destroy) {
         task->destroy(task->opaque);
     }
+    if (task->destroyResult) {
+        task->destroyResult(task->result);
+    }
     object_unref(task->source);
 
     g_free(task);
@@ -154,6 +159,21 @@ void qio_task_abort(QIOTask *task,
 }
 
 
+void qio_task_set_result_pointer(QIOTask *task,
+                                 gpointer result,
+                                 GDestroyNotify destroy)
+{
+    task->result = result;
+    task->destroyResult = destroy;
+}
+
+
+gpointer qio_task_get_result_pointer(QIOTask *task)
+{
+    return task->result;
+}
+
+
 Object *qio_task_get_source(QIOTask *task)
 {
     return task->source;
-- 
2.9.3
