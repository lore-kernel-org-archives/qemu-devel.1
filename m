Received: from eggs.gnu.org ([2001:4830:134:3::10]:60210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cfkMN-0007L0-MT
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cfkMI-0007Tw-Lb
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:34:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cfkM8-0007PR-7q
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:34:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 20 Feb 2017 09:33:02 +0000
Message-Id: <20170220093304.20515-23-stefanha@redhat.com>
In-Reply-To: <20170220093304.20515-1-stefanha@redhat.com>
References: <20170220093304.20515-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 22/24] coroutine-lock: place CoMutex before
 CoQueue in header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

This will avoid forward references in the next patch.  It is also
more logical because CoQueue is not anymore the basic primitive.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170213181244.16297-5-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/coroutine.h | 89 ++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 45 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 12ce8e1..9f68579 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -112,51 +112,6 @@ bool qemu_in_coroutine(void);
  */
 bool qemu_coroutine_entered(Coroutine *co);
 
-
-/**
- * CoQueues are a mechanism to queue coroutines in order to continue executing
- * them later. They provide the fundamental primitives on which coroutine locks
- * are built.
- */
-typedef struct CoQueue {
-    QSIMPLEQ_HEAD(, Coroutine) entries;
-} CoQueue;
-
-/**
- * Initialise a CoQueue. This must be called before any other operation is used
- * on the CoQueue.
- */
-void qemu_co_queue_init(CoQueue *queue);
-
-/**
- * Adds the current coroutine to the CoQueue and transfers control to the
- * caller of the coroutine.
- */
-void coroutine_fn qemu_co_queue_wait(CoQueue *queue);
-
-/**
- * Restarts the next coroutine in the CoQueue and removes it from the queue.
- *
- * Returns true if a coroutine was restarted, false if the queue is empty.
- */
-bool coroutine_fn qemu_co_queue_next(CoQueue *queue);
-
-/**
- * Restarts all coroutines in the CoQueue and leaves the queue empty.
- */
-void coroutine_fn qemu_co_queue_restart_all(CoQueue *queue);
-
-/**
- * Enter the next coroutine in the queue
- */
-bool qemu_co_enter_next(CoQueue *queue);
-
-/**
- * Checks if the CoQueue is empty.
- */
-bool qemu_co_queue_empty(CoQueue *queue);
-
-
 /**
  * Provides a mutex that can be used to synchronise coroutines
  */
@@ -202,6 +157,50 @@ void coroutine_fn qemu_co_mutex_lock(CoMutex *mutex);
  */
 void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex);
 
+
+/**
+ * CoQueues are a mechanism to queue coroutines in order to continue executing
+ * them later.
+ */
+typedef struct CoQueue {
+    QSIMPLEQ_HEAD(, Coroutine) entries;
+} CoQueue;
+
+/**
+ * Initialise a CoQueue. This must be called before any other operation is used
+ * on the CoQueue.
+ */
+void qemu_co_queue_init(CoQueue *queue);
+
+/**
+ * Adds the current coroutine to the CoQueue and transfers control to the
+ * caller of the coroutine.
+ */
+void coroutine_fn qemu_co_queue_wait(CoQueue *queue);
+
+/**
+ * Restarts the next coroutine in the CoQueue and removes it from the queue.
+ *
+ * Returns true if a coroutine was restarted, false if the queue is empty.
+ */
+bool coroutine_fn qemu_co_queue_next(CoQueue *queue);
+
+/**
+ * Restarts all coroutines in the CoQueue and leaves the queue empty.
+ */
+void coroutine_fn qemu_co_queue_restart_all(CoQueue *queue);
+
+/**
+ * Enter the next coroutine in the queue
+ */
+bool qemu_co_enter_next(CoQueue *queue);
+
+/**
+ * Checks if the CoQueue is empty.
+ */
+bool qemu_co_queue_empty(CoQueue *queue);
+
+
 typedef struct CoRwlock {
     bool writer;
     int reader;
-- 
2.9.3
