Received: from eggs.gnu.org ([2001:4830:134:3::10]:36171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVh0f-00052W-CN
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVh0e-0006SR-2e
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:58:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVh0d-0006SF-Sc
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:58:19 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 23 Jan 2017 15:57:34 +0000
Message-Id: <20170123155737.3793-6-berrange@redhat.com>
In-Reply-To: <20170123155737.3793-1-berrange@redhat.com>
References: <20170123155737.3793-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 5/8] io: add ability to associate an error
 with a task
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

Currently when a task fails, the error is never explicitly
associated with the task object, it is just passed along
through the completion callback. This adds the ability to
explicitly associate an error with the task.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/task.h | 32 ++++++++++++++++++++++++++++++++
 io/task.c         | 23 +++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/io/task.h b/include/io/task.h
index ece1372..47daba9 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -240,6 +240,38 @@ void qio_task_abort(QIOTask *task,
 
 
 /**
+ * qio_task_set_error:
+ * @task: the task struct
+ * @err: pointer to the error, or NULL
+ *
+ * Associate an error with the task, which can later
+ * be retrieved with the qio_task_propagate_error()
+ * method. This method takes ownership of @err, so
+ * it is not valid to access it after this call
+ * completes. If @err is NULL this is a no-op. If
+ * this is call multiple times, only the first
+ * provided @err will be recorded, later ones will
+ * be discarded and freed.
+ */
+void qio_task_set_error(QIOTask *task,
+                        Error *err);
+
+
+/**
+ * qio_task_propagate_error:
+ * @task: the task struct
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Propagate the error associated with @task
+ * into @errp.
+ *
+ * Returns: true if an error was propagated, false otherwise
+ */
+bool qio_task_propagate_error(QIOTask *task,
+                              Error **errp);
+
+
+/**
  * qio_task_set_result_pointer:
  * @task: the task struct
  * @result: pointer to the result data
diff --git a/io/task.c b/io/task.c
index 675e196..1394e05 100644
--- a/io/task.c
+++ b/io/task.c
@@ -29,6 +29,7 @@ struct QIOTask {
     QIOTaskFunc func;
     gpointer opaque;
     GDestroyNotify destroy;
+    Error *err;
     gpointer result;
     GDestroyNotify destroyResult;
 };
@@ -62,6 +63,9 @@ static void qio_task_free(QIOTask *task)
     if (task->destroyResult) {
         task->destroyResult(task->result);
     }
+    if (task->err) {
+        error_free(task->err);
+    }
     object_unref(task->source);
 
     g_free(task);
@@ -159,6 +163,25 @@ void qio_task_abort(QIOTask *task,
 }
 
 
+void qio_task_set_error(QIOTask *task,
+                        Error *err)
+{
+    error_propagate(&task->err, err);
+}
+
+
+bool qio_task_propagate_error(QIOTask *task,
+                              Error **errp)
+{
+    if (task->err) {
+        error_propagate(errp, task->err);
+        return true;
+    }
+
+    return false;
+}
+
+
 void qio_task_set_result_pointer(QIOTask *task,
                                  gpointer result,
                                  GDestroyNotify destroy)
-- 
2.9.3
