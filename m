Received: from eggs.gnu.org ([2001:4830:134:3::10]:56421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebCve-0007Mn-RI
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 17:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebCvd-0006AZ-4I
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 17:08:30 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 Jan 2018 23:08:20 +0100
Message-Id: <20180115220822.10156-3-pbonzini@redhat.com>
In-Reply-To: <20180115220822.10156-1-pbonzini@redhat.com>
References: <20180115220822.10156-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] coroutine-lock: convert CoQueue to use
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
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

There are cases in which a queued coroutine must be restarted from
non-coroutine context (with qemu_co_enter_next).  In this cases,
qemu_co_enter_next also needs to be thread-safe, but it cannot use
a CoMutex and so cannot qemu_co_queue_wait.  Use QemuLockable so
that the CoQueue can interchangeably use CoMutex or QemuMutex.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
