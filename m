Received: from eggs.gnu.org ([2001:4830:134:3::10]:40039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAVt-00066I-EO
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAVs-0000L3-Kd
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPAVs-0000Kk-FY
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:36 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A40A2C0ADB6F
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:03:36 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  5 Jan 2017 16:03:17 +0000
Message-Id: <20170105160321.21786-5-berrange@redhat.com>
In-Reply-To: <20170105160321.21786-1-berrange@redhat.com>
References: <20170105160321.21786-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 4/8] io: add ability to associate an opaque
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

Currently there is no data associated with a successful
task completion. This adds an opaque pointer to the task
to store an arbitrary result.

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
