Received: from eggs.gnu.org ([2001:4830:134:3::10]:41626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejbot-00064w-Pr
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejbos-0004Pk-Je
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ejbos-0004PO-CO
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:14 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu,  8 Feb 2018 10:19:42 +0800
Message-Id: <20180208021953.7354-6-famz@redhat.com>
In-Reply-To: <20180208021953.7354-1-famz@redhat.com>
References: <20180208021953.7354-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 05/16] coroutine-lock: make qemu_co_enter_next
 thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

qemu_co_queue_next does not need to release and re-acquire the mutex,
because the queued coroutine does not run immediately.  However, this
does not hold for qemu_co_enter_next.  Now that qemu_co_queue_wait
can synchronize (via QemuLockable) with code that is not running in
coroutine context, it's important that code using qemu_co_enter_next
can easily use a standardized locking idiom.

First of all, qemu_co_enter_next must use aio_co_wake to restart the
coroutine.  Second, the function gains a second argument, a QemuLockable*,
and the comments of qemu_co_queue_next and qemu_co_queue_restart_all
are adjusted to clarify the difference.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180203153935.8056-5-pbonzini@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 fsdev/qemu-fsdev-throttle.c |  4 ++--
 include/qemu/coroutine.h    | 19 +++++++++++++------
 util/qemu-coroutine-lock.c  | 10 ++++++++--
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 49eebb5412..1dc07fbc12 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -20,13 +20,13 @@
 static void fsdev_throttle_read_timer_cb(void *opaque)
 {
     FsThrottle *fst = opaque;
-    qemu_co_enter_next(&fst->throttled_reqs[false]);
+    qemu_co_enter_next(&fst->throttled_reqs[false], NULL);
 }
 
 static void fsdev_throttle_write_timer_cb(void *opaque)
 {
     FsThrottle *fst = opaque;
-    qemu_co_enter_next(&fst->throttled_reqs[true]);
+    qemu_co_enter_next(&fst->throttled_reqs[true], NULL);
 }
 
 void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 1e5f0957e6..6f8a487041 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -188,21 +188,28 @@ void qemu_co_queue_init(CoQueue *queue);
 void coroutine_fn qemu_co_queue_wait_impl(CoQueue *queue, QemuLockable *lock);
 
 /**
- * Restarts the next coroutine in the CoQueue and removes it from the queue.
- *
- * Returns true if a coroutine was restarted, false if the queue is empty.
+ * Removes the next coroutine from the CoQueue, and wake it up.
+ * Returns true if a coroutine was removed, false if the queue is empty.
  */
 bool coroutine_fn qemu_co_queue_next(CoQueue *queue);
 
 /**
- * Restarts all coroutines in the CoQueue and leaves the queue empty.
+ * Empties the CoQueue; all coroutines are woken up.
  */
 void coroutine_fn qemu_co_queue_restart_all(CoQueue *queue);
 
 /**
- * Enter the next coroutine in the queue
+ * Removes the next coroutine from the CoQueue, and wake it up.  Unlike
+ * qemu_co_queue_next, this function releases the lock during aio_co_wake
+ * because it is meant to be used outside coroutine context; in that case, the
+ * coroutine is entered immediately, before qemu_co_enter_next returns.
+ *
+ * If used in coroutine context, qemu_co_enter_next is equivalent to
+ * qemu_co_queue_next.
  */
-bool qemu_co_enter_next(CoQueue *queue);
+#define qemu_co_enter_next(queue, lock) \
+    qemu_co_enter_next_impl(queue, QEMU_MAKE_LOCKABLE(lock))
+bool qemu_co_enter_next_impl(CoQueue *queue, QemuLockable *lock);
 
 /**
  * Checks if the CoQueue is empty.
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 2a66fc1467..78fb79acf8 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -132,7 +132,7 @@ void coroutine_fn qemu_co_queue_restart_all(CoQueue *queue)
     qemu_co_queue_do_restart(queue, false);
 }
 
-bool qemu_co_enter_next(CoQueue *queue)
+bool qemu_co_enter_next_impl(CoQueue *queue, QemuLockable *lock)
 {
     Coroutine *next;
 
@@ -142,7 +142,13 @@ bool qemu_co_enter_next(CoQueue *queue)
     }
 
     QSIMPLEQ_REMOVE_HEAD(&queue->entries, co_queue_next);
-    qemu_coroutine_enter(next);
+    if (lock) {
+        qemu_lockable_unlock(lock);
+    }
+    aio_co_wake(next);
+    if (lock) {
+        qemu_lockable_lock(lock);
+    }
     return true;
 }
 
-- 
2.14.3
