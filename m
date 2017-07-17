Received: from eggs.gnu.org ([2001:4830:134:3::10]:42417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1P-0000Qa-1i
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1N-0004WO-T8
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1N-0004Vx-Kq
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:33 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:12 +0800
Message-Id: <20170717034825.1524-3-famz@redhat.com>
In-Reply-To: <20170717034825.1524-1-famz@redhat.com>
References: <20170717034825.1524-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 02/15] coroutine-lock: add
 qemu_co_rwlock_downgrade and qemu_co_rwlock_upgrade
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

These functions are more efficient in the presence of contention.
qemu_co_rwlock_downgrade also guarantees not to block, which may
be useful in some algorithms too.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170629132749.997-3-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/qemu/coroutine.h   | 18 ++++++++++++++++++
 util/qemu-coroutine-lock.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index a4509bd..9aff9a7 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -229,6 +229,24 @@ void qemu_co_rwlock_init(CoRwlock *lock);
 void qemu_co_rwlock_rdlock(CoRwlock *lock);
 
 /**
+ * Write Locks the CoRwlock from a reader.  This is a bit more efficient than
+ * @qemu_co_rwlock_unlock followed by a separate @qemu_co_rwlock_wrlock.
+ * However, if the lock cannot be upgraded immediately, control is transferred
+ * to the caller of the current coroutine.  Also, @qemu_co_rwlock_upgrade
+ * only overrides CoRwlock fairness if there are no concurrent readers, so
+ * another writer might run while @qemu_co_rwlock_upgrade blocks.
+ */
+void qemu_co_rwlock_upgrade(CoRwlock *lock);
+
+/**
+ * Downgrades a write-side critical section to a reader.  Downgrading with
+ * @qemu_co_rwlock_downgrade never blocks, unlike @qemu_co_rwlock_unlock
+ * followed by @qemu_co_rwlock_rdlock.  This makes it more efficient, but
+ * may also sometimes be necessary for correctness.
+ */
+void qemu_co_rwlock_downgrade(CoRwlock *lock);
+
+/**
  * Write Locks the mutex. If the lock cannot be taken immediately because
  * of a parallel reader, control is transferred to the caller of the current
  * coroutine.
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index b44b5d5..846ff91 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -402,6 +402,21 @@ void qemu_co_rwlock_unlock(CoRwlock *lock)
     qemu_co_mutex_unlock(&lock->mutex);
 }
 
+void qemu_co_rwlock_downgrade(CoRwlock *lock)
+{
+    Coroutine *self = qemu_coroutine_self();
+
+    /* lock->mutex critical section started in qemu_co_rwlock_wrlock or
+     * qemu_co_rwlock_upgrade.
+     */
+    assert(lock->reader == 0);
+    lock->reader++;
+    qemu_co_mutex_unlock(&lock->mutex);
+
+    /* The rest of the read-side critical section is run without the mutex.  */
+    self->locks_held++;
+}
+
 void qemu_co_rwlock_wrlock(CoRwlock *lock)
 {
     qemu_co_mutex_lock(&lock->mutex);
@@ -416,3 +431,23 @@ void qemu_co_rwlock_wrlock(CoRwlock *lock)
      * There is no need to update self->locks_held.
      */
 }
+
+void qemu_co_rwlock_upgrade(CoRwlock *lock)
+{
+    Coroutine *self = qemu_coroutine_self();
+
+    qemu_co_mutex_lock(&lock->mutex);
+    assert(lock->reader > 0);
+    lock->reader--;
+    lock->pending_writer++;
+    while (lock->reader) {
+        qemu_co_queue_wait(&lock->queue, &lock->mutex);
+    }
+    lock->pending_writer--;
+
+    /* The rest of the write-side critical section is run with
+     * the mutex taken, similar to qemu_co_rwlock_wrlock.  Do
+     * not account for the lock twice in self->locks_held.
+     */
+    self->locks_held--;
+}
-- 
2.9.4
