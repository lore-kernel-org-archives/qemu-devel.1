Received: from eggs.gnu.org ([2001:4830:134:3::10]:38629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1Aml-0007am-QE
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1Amf-00033G-Lt
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:07 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Apr 2017 14:00:54 +0200
Message-Id: <20170420120058.28404-14-pbonzini@redhat.com>
In-Reply-To: <20170420120058.28404-1-pbonzini@redhat.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 13/17] coroutine-lock: introduce
 qemu_co_mutex_lock_unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

This primitive lets you lock/unlock a CoMutex, guaranteeing neither
blocking nor cacheline bouncing if there is no qemu_co_mutex_lock
critical section.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/coroutine.h   |  6 ++++++
 util/qemu-coroutine-lock.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index a4509bd..8d4416c 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -157,6 +157,12 @@ void qemu_co_mutex_init(CoMutex *mutex);
 void coroutine_fn qemu_co_mutex_lock(CoMutex *mutex);
 
 /**
+ * Locks the mutex and immediately unlock it.  This is faster than back-to-back
+ * lock/unlock if the mutex is not taken by anyone.
+ */
+void coroutine_fn qemu_co_mutex_lock_unlock(CoMutex *mutex);
+
+/**
  * Unlocks the mutex and schedules the next coroutine that was waiting for this
  * lock to be run.
  */
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 6328eed..86f56cd 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -287,6 +287,42 @@ retry_fast_path:
     self->locks_held++;
 }
 
+void coroutine_fn qemu_co_mutex_lock_unlock(CoMutex *mutex)
+{
+    AioContext *ctx = qemu_get_current_aio_context();
+    int waiters, i;
+
+retry_fast_path:
+    waiters = atomic_read(&mutex->locked);
+    if (waiters == 0) {
+        /* Provide same memory ordering semantics as mutex lock/unlock.  */
+        smp_mb_acquire();
+        smp_mb_release();
+        return;
+    }
+
+    i = 0;
+    while (waiters == 1 && ++i < 1000) {
+        if (atomic_read(&mutex->ctx) == ctx) {
+            break;
+        }
+        waiters = atomic_read(&mutex->locked);
+        if (waiters == 0) {
+            smp_mb_acquire();
+            smp_mb_release();
+            return;
+        }
+        cpu_relax();
+    }
+
+    if (atomic_cmpxchg(&mutex->locked, waiters, waiters + 1) != waiters) {
+        goto retry_fast_path;
+    }
+
+    qemu_co_mutex_lock_slowpath(ctx, mutex);
+    qemu_co_mutex_unlock(mutex);
+}
+
 void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex)
 {
     Coroutine *self = qemu_coroutine_self();
-- 
2.9.3
