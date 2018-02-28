Received: from eggs.gnu.org ([2001:4830:134:3::10]:33650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxb-0008G2-4H
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxa-0000nl-9X
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqtxa-0000nf-5U
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D399887ABA
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:07:21 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Feb 2018 13:06:29 +0800
Message-Id: <20180228050633.7410-11-peterx@redhat.com>
In-Reply-To: <20180228050633.7410-1-peterx@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 10/14] qio: refcount QIOTask
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

It will be used in multiple threads in follow-up patches.  Let it start
to have refcounts.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/task.h |  3 +++
 io/task.c         | 23 ++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/io/task.h b/include/io/task.h
index 9dbe3758d7..c6acd6489c 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -322,4 +322,7 @@ gpointer qio_task_get_result_pointer(QIOTask *task);
  */
 Object *qio_task_get_source(QIOTask *task);
 
+void qio_task_ref(QIOTask *task);
+void qio_task_unref(QIOTask *task);
+
 #endif /* QIO_TASK_H */
diff --git a/io/task.c b/io/task.c
index 204c0be286..00d3a5096a 100644
--- a/io/task.c
+++ b/io/task.c
@@ -32,6 +32,7 @@ struct QIOTask {
     Error *err;
     gpointer result;
     GDestroyNotify destroyResult;
+    uint32_t refcount;
 
     /* Threaded QIO task specific fields */
     GSource *idle_source;  /* The idle task to run complete routine */
@@ -57,6 +58,8 @@ QIOTask *qio_task_new(Object *source,
 
     trace_qio_task_new(task, source, func, opaque);
 
+    qio_task_ref(task);
+
     return task;
 }
 
@@ -165,7 +168,7 @@ void qio_task_complete(QIOTask *task)
 {
     task->func(task, task->opaque);
     trace_qio_task_complete(task);
-    qio_task_free(task);
+    qio_task_unref(task);
 }
 
 
@@ -208,3 +211,21 @@ Object *qio_task_get_source(QIOTask *task)
 {
     return task->source;
 }
+
+void qio_task_ref(QIOTask *task)
+{
+    if (!task) {
+        return;
+    }
+    atomic_inc(&task->refcount);
+}
+
+void qio_task_unref(QIOTask *task)
+{
+    if (!task) {
+        return;
+    }
+    if (atomic_fetch_dec(&task->refcount) == 1) {
+        qio_task_free(task);
+    }
+}
-- 
2.14.3
