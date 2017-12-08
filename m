Received: from eggs.gnu.org ([2001:4830:134:3::10]:47567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eNGK8-00011H-08
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eNGK6-0001mA-KT
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:08 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eNGK6-0001lx-BA
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:06 -0500
Received: by mail-wm0-x243.google.com with SMTP id i11so2546206wmf.4
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 02:56:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  8 Dec 2017 11:55:50 +0100
Message-Id: <20171208105553.12249-3-pbonzini@redhat.com>
In-Reply-To: <20171208105553.12249-1-pbonzini@redhat.com>
References: <20171208105553.12249-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] lock-guard: add scoped lock implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/coroutine.h  |  4 ++
 include/qemu/lock-guard.h | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/thread.h     |  7 ++++
 util/Makefile.objs        |  1 +
 util/qemu-thread.c        | 17 ++++++++
 5 files changed, 128 insertions(+)
 create mode 100644 include/qemu/lock-guard.h
 create mode 100644 util/qemu-thread.c

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 9aff9a735e..8b48803fa8 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -17,6 +17,7 @@
 
 #include "qemu/queue.h"
 #include "qemu/timer.h"
+#include "qemu/lock-guard.h"
 
 /**
  * Coroutines are a mechanism for stack switching and can be used for
@@ -162,6 +163,9 @@ void coroutine_fn qemu_co_mutex_lock(CoMutex *mutex);
  */
 void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex);
 
+#define QEMU_LOCK_GUARD_FUNCS_CoMutex \
+    QEMU_INIT_LOCK_GUARD(CoMutex, qemu_co_mutex_lock, qemu_co_mutex_unlock)
+
 
 /**
  * CoQueues are a mechanism to queue coroutines in order to continue executing
diff --git a/include/qemu/lock-guard.h b/include/qemu/lock-guard.h
new file mode 100644
index 0000000000..e6a83bf9ee
--- /dev/null
+++ b/include/qemu/lock-guard.h
@@ -0,0 +1,103 @@
+#ifndef QEMU_LOCK_GUARD_H
+#define QEMU_LOCK_GUARD_H 1
+
+typedef void QemuLockGuardFunc(void *);
+typedef struct QemuLockGuard {
+    QemuLockGuardFunc *p_lock_fn, *p_unlock_fn;
+    void *lock;
+    int locked;
+} QemuLockGuard;
+
+static inline void qemu_lock_guard_lock(QemuLockGuard *lock_guard)
+{
+    assert(!lock_guard->locked);
+    lock_guard->p_lock_fn(lock_guard->lock);
+    lock_guard->locked = true;
+}
+
+static inline void qemu_lock_guard_unlock(QemuLockGuard *lock_guard)
+{
+    assert(lock_guard->locked);
+    lock_guard->locked = false;
+    lock_guard->p_unlock_fn(lock_guard->lock);
+}
+
+static inline bool qemu_lock_guard_is_taken(QemuLockGuard *lock_guard)
+{
+    return lock_guard->locked;
+}
+
+static inline void qemu_lock_guard_release(QemuLockGuard *lock_guard)
+{
+    lock_guard->lock = NULL;
+    lock_guard->locked = false;
+}
+
+inline void qemu_lock_guard_pass(void *ptr)
+{
+    QemuLockGuard *lock_guard = ptr;
+    assert(lock_guard->locked || !lock_guard->lock);
+}
+
+inline void qemu_lock_guard_cleanup(void *ptr)
+{
+    QemuLockGuard *lock_guard = ptr;
+    if (likely(lock_guard->locked)) {
+        lock_guard->p_unlock_fn(lock_guard->lock);
+    }
+}
+
+static inline QemuLockGuard qemu_lock_guard_init(QemuLockGuard lock_guard)
+{
+    qemu_lock_guard_lock(&lock_guard);
+    return lock_guard;
+}
+
+#define QEMU_INIT_LOCK_GUARD(type, lock_fn, unlock_fn)                     \
+    .p_lock_fn   = (QemuLockGuardFunc *) (void (*) (type *)) lock_fn,      \
+    .p_unlock_fn = (QemuLockGuardFunc *) (void (*) (type *)) unlock_fn
+
+#define QEMU_LOCK_GUARD_(type, lock, locked)                               \
+    (QemuLockGuard) {                                                      \
+        QEMU_LOCK_GUARD_FUNCS_##type,                                      \
+        lock + type_check(typeof(*lock), type),                            \
+        locked                                                             \
+    }
+
+/* Take a lock that will be unlocked on returning */
+#define QEMU_LOCK_GUARD(type, name, lock)                                  \
+    QemuLockGuard __attribute__((cleanup(qemu_lock_guard_cleanup))) name = \
+        qemu_lock_guard_init(QEMU_LOCK_GUARD_(type, lock, false))
+
+#define QEMU_WITH_LOCK(type, name, lock)                                   \
+    for (QEMU_LOCK_GUARD(type, name, lock);                                \
+         qemu_lock_guard_is_taken(&name);                                  \
+         qemu_lock_guard_unlock(&name))
+
+/* Create a QemuLockGuard for a lock that is taken and will be unlocked on
+ * returning
+ */
+#define QEMU_ADOPT_LOCK(type, name, lock)                                  \
+    QemuLockGuard __attribute__((cleanup(qemu_lock_guard_cleanup))) name = \
+        QEMU_LOCK_GUARD_(type, lock, true)
+
+#define QEMU_WITH_ADOPTED_LOCK(type, name, lock)                           \
+    for (QEMU_ADOPT_LOCK(type, name, lock);                                \
+         qemu_lock_guard_is_taken(&name);                                  \
+         qemu_lock_guard_unlock(&name))
+
+/* Take a lock and create a QemuLockGuard for it, asserting that it will
+ * be locked when returning.
+ */
+#define QEMU_RETURN_LOCK(type, name, lock)                                 \
+    QemuLockGuard __attribute__((cleanup(qemu_lock_guard_pass))) name =    \
+        qemu_lock_guard_init(QEMU_LOCK_GUARD_(type, lock, false))
+
+/* Create a QemuLockGuard for a lock that is taken and must be locked
+ * when returning
+ */
+#define QEMU_TAKEN_LOCK(type, name, lock)                                  \
+    QemuLockGuard __attribute__((cleanup(qemu_lock_guard_pass))) name =    \
+        QEMU_LOCK_GUARD_(type, lock, true)
+
+#endif
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 9910f49b3a..4066702d0c 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -3,6 +3,7 @@
 
 #include "qemu/processor.h"
 #include "qemu/atomic.h"
+#include "qemu/lock-guard.h"
 
 typedef struct QemuMutex QemuMutex;
 typedef struct QemuCond QemuCond;
@@ -26,6 +27,9 @@ void qemu_mutex_lock(QemuMutex *mutex);
 int qemu_mutex_trylock(QemuMutex *mutex);
 void qemu_mutex_unlock(QemuMutex *mutex);
 
+#define QEMU_LOCK_GUARD_FUNCS_QemuMutex \
+    QEMU_INIT_LOCK_GUARD(QemuMutex, qemu_mutex_lock, qemu_mutex_unlock)
+
 /* Prototypes for other functions are in thread-posix.h/thread-win32.h.  */
 void qemu_rec_mutex_init(QemuRecMutex *mutex);
 
@@ -99,6 +103,9 @@ static inline void qemu_spin_unlock(QemuSpin *spin)
     __sync_lock_release(&spin->value);
 }
 
+#define QEMU_LOCK_GUARD_FUNCS_QemuSpin \
+    QEMU_INIT_LOCK_GUARD(QemuSpin, qemu_spin_lock, qemu_spin_lock)
+
 struct QemuLockCnt {
 #ifndef CONFIG_LINUX
     QemuMutex mutex;
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 2973b0a323..cb0591f750 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -3,6 +3,7 @@ util-obj-y += bufferiszero.o
 util-obj-y += lockcnt.o
 util-obj-y += aiocb.o async.o thread-pool.o qemu-timer.o
 util-obj-y += main-loop.o iohandler.o
+util-obj-y += qemu-thread.o
 util-obj-$(CONFIG_POSIX) += aio-posix.o
 util-obj-$(CONFIG_POSIX) += compatfd.o
 util-obj-$(CONFIG_POSIX) += event_notifier-posix.o
diff --git a/util/qemu-thread.c b/util/qemu-thread.c
new file mode 100644
index 0000000000..bb06b5f58b
--- /dev/null
+++ b/util/qemu-thread.c
@@ -0,0 +1,17 @@
+/*
+ * Extern inline functions for QemuLockGuard.
+ *
+ * Copyright Red Hat, Inc. 2017
+ *
+ * Author:
+ *  Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#include "qemu/osdep.h"
+#include "qemu/thread.h"
+
+QEMU_EXTERN_INLINE(qemu_lock_guard_cleanup)
+QEMU_EXTERN_INLINE(qemu_lock_guard_pass)
-- 
2.14.3
