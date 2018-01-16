Received: from eggs.gnu.org ([2001:4830:134:3::10]:52384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebS96-0007pH-8F
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebS95-0007ea-2P
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:23:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ebS94-0007di-SK
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:23:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABFF5C052422
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 14:23:21 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-234.ams2.redhat.com
	[10.36.116.234])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E98345C8AF
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 14:23:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 15:23:14 +0100
Message-Id: <20180116142316.30486-3-pbonzini@redhat.com>
In-Reply-To: <20180116142316.30486-1-pbonzini@redhat.com>
References: <20180116142316.30486-1-pbonzini@redhat.com>
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
