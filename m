Received: from eggs.gnu.org ([2001:4830:134:3::10]:41602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejbos-00063d-HU
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejbor-0004Oe-9o
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ejboq-0004Nw-Oh
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:13 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu,  8 Feb 2018 10:19:41 +0800
Message-Id: <20180208021953.7354-5-famz@redhat.com>
In-Reply-To: <20180208021953.7354-1-famz@redhat.com>
References: <20180208021953.7354-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 04/16] coroutine-lock: convert CoQueue to use
 QemuLockable
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

There are cases in which a queued coroutine must be restarted from
non-coroutine context (with qemu_co_enter_next).  In this cases,
qemu_co_enter_next also needs to be thread-safe, but it cannot use
a CoMutex and so cannot qemu_co_queue_wait.  Use QemuLockable so
that the CoQueue can interchangeably use CoMutex or QemuMutex.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180203153935.8056-4-pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/qemu/coroutine.h   |  6 +++++-
 util/qemu-coroutine-lock.c | 12 +++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 8a5129741c..1e5f0957e6 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -183,7 +183,9 @@ void qemu_co_queue_init(CoQueue *queue);
  * caller of the coroutine.  The mutex is unlocked during the wait and
  * locked again afterwards.
  */
-void coroutine_fn qemu_co_queue_wait(CoQueue *queue, CoMutex *mutex);
+#define qemu_co_queue_wait(queue, lock) \
+    qemu_co_queue_wait_impl(queue, QEMU_MAKE_LOCKABLE(lock))
+void coroutine_fn qemu_co_queue_wait_impl(CoQueue *queue, QemuLockable *lock);
 
 /**
  * Restarts the next coroutine in the CoQueue and removes it from the queue.
@@ -271,4 +273,6 @@ void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
  */
 void coroutine_fn yield_until_fd_readable(int fd);
 
+#include "qemu/lockable.h"
+
 #endif /* QEMU_COROUTINE_H */
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 846ff9167f..2a66fc1467 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -40,13 +40,13 @@ void qemu_co_queue_init(CoQueue *queue)
     QSIMPLEQ_INIT(&queue->entries);
 }
 
-void coroutine_fn qemu_co_queue_wait(CoQueue *queue, CoMutex *mutex)
+void coroutine_fn qemu_co_queue_wait_impl(CoQueue *queue, QemuLockable *lock)
 {
     Coroutine *self = qemu_coroutine_self();
     QSIMPLEQ_INSERT_TAIL(&queue->entries, self, co_queue_next);
 
-    if (mutex) {
-        qemu_co_mutex_unlock(mutex);
+    if (lock) {
+        qemu_lockable_unlock(lock);
     }
 
     /* There is no race condition here.  Other threads will call
@@ -60,9 +60,11 @@ void coroutine_fn qemu_co_queue_wait(CoQueue *queue, CoMutex *mutex)
     /* TODO: OSv implements wait morphing here, where the wakeup
      * primitive automatically places the woken coroutine on the
      * mutex's queue.  This avoids the thundering herd effect.
+     * This could be implemented for CoMutexes, but not really for
+     * other cases of QemuLockable.
      */
-    if (mutex) {
-        qemu_co_mutex_lock(mutex);
+    if (lock) {
+        qemu_lockable_lock(lock);
     }
 }
 
-- 
2.14.3
