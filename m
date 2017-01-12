Received: from eggs.gnu.org ([2001:4830:134:3::10]:53684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRif9-00023o-M6
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRif3-0007rL-NJ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:55:43 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRif3-0007q9-8g
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:55:37 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so5007313wme.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 08:55:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Jan 2017 17:55:23 +0100
Message-Id: <20170112165531.11882-3-pbonzini@redhat.com>
In-Reply-To: <20170112165531.11882-1-pbonzini@redhat.com>
References: <20170112165531.11882-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 02/10] qemu-thread: introduce QemuLockCnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

A QemuLockCnt comprises a counter and a mutex, with primitives
to increment and decrement the counter, and to take and release the
mutex.  It can be used to do lock-free visits to a data structure
whenever mutexes would be too heavy-weight and the critical section
is too long for RCU.

This could be implemented simply by protecting the counter with the
mutex, but QemuLockCnt is harder to misuse and more efficient.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/lockcnt.txt      | 278 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/thread.h | 110 ++++++++++++++++++++
 util/Makefile.objs    |   1 +
 util/lockcnt.c        | 114 +++++++++++++++++++++
 4 files changed, 503 insertions(+)
 create mode 100644 docs/lockcnt.txt
 create mode 100644 util/lockcnt.c

diff --git a/docs/lockcnt.txt b/docs/lockcnt.txt
new file mode 100644
index 0000000..25a8091
--- /dev/null
+++ b/docs/lockcnt.txt
@@ -0,0 +1,278 @@
+DOCUMENTATION FOR LOCKED COUNTERS (aka QemuLockCnt)
+===================================================
+
+QEMU often uses reference counts to track data structures that are being
+accessed and should not be freed.  For example, a loop that invoke
+callbacks like this is not safe:
+
+    QLIST_FOREACH_SAFE(ioh, &io_handlers, next, pioh) {
+        if (ioh->revents & G_IO_OUT) {
+            ioh->fd_write(ioh->opaque);
+        }
+    }
+
+QLIST_FOREACH_SAFE protects against deletion of the current node (ioh)
+by stashing away its "next" pointer.  However, ioh->fd_write could
+actually delete the next node from the list.  The simplest way to
+avoid this is to mark the node as deleted, and remove it from the
+list in the above loop:
+
+    QLIST_FOREACH_SAFE(ioh, &io_handlers, next, pioh) {
+        if (ioh->deleted) {
+            QLIST_REMOVE(ioh, next);
+            g_free(ioh);
+        } else {
+            if (ioh->revents & G_IO_OUT) {
+                ioh->fd_write(ioh->opaque);
+            }
+        }
+    }
+
+If however this loop must also be reentrant, i.e. it is possible that
+ioh->fd_write invokes the loop again, some kind of counting is needed:
+
+    walking_handlers++;
+    QLIST_FOREACH_SAFE(ioh, &io_handlers, next, pioh) {
+        if (ioh->deleted) {
+            if (walking_handlers == 1) {
+                QLIST_REMOVE(ioh, next);
+                g_free(ioh);
+            }
+        } else {
+            if (ioh->revents & G_IO_OUT) {
+                ioh->fd_write(ioh->opaque);
+            }
+        }
+    }
+    walking_handlers--;
+
+One may think of using the RCU primitives, rcu_read_lock() and
+rcu_read_unlock(); effectively, the RCU nesting count would take
+the place of the walking_handlers global variable.  Indeed,
+reference counting and RCU have similar purposes, but their usage in
+general is complementary:
+
+- reference counting is fine-grained and limited to a single data
+  structure; RCU delays reclamation of *all* RCU-protected data
+  structures;
+
+- reference counting works even in the presence of code that keeps
+  a reference for a long time; RCU critical sections in principle
+  should be kept short;
+
+- reference counting is often applied to code that is not thread-safe
+  but is reentrant; in fact, usage of reference counting in QEMU predates
+  the introduction of threads by many years.  RCU is generally used to
+  protect readers from other threads freeing memory after concurrent
+  modifications to a data structure.
+
+- reclaiming data can be done by a separate thread in the case of RCU;
+  this can improve performance, but also delay reclamation undesirably.
+  With reference counting, reclamation is deterministic.
+
+This file documents QemuLockCnt, an abstraction for using reference
+counting in code that has to be both thread-safe and reentrant.
+
+
+QemuLockCnt concepts
+--------------------
+
+A QemuLockCnt comprises both a counter and a mutex; it has primitives
+to increment and decrement the counter, and to take and release the
+mutex.  The counter notes how many visits to the data structures are
+taking place (the visits could be from different threads, or there could
+be multiple reentrant visits from the same thread).  The basic rules
+governing the counter/mutex pair then are the following:
+
+- Data protected by the QemuLockCnt must not be freed unless the
+  counter is zero and the mutex is taken.
+
+- A new visit cannot be started while the counter is zero and the
+  mutex is taken.
+
+Most of the time, the mutex protects all writes to the data structure,
+not just frees, though there could be cases where this is not necessary.
+
+Reads, instead, can be done without taking the mutex, as long as the
+readers and writers use the same macros that are used for RCU, for
+example atomic_rcu_read, atomic_rcu_set, QLIST_FOREACH_RCU, etc.  This is
+because the reads are done outside a lock and a set or QLIST_INSERT_HEAD
+can happen concurrently with the read.  The RCU API ensures that the
+processor and the compiler see all required memory barriers.
+
+This could be implemented simply by protecting the counter with the
+mutex, for example:
+
+    // (1)
+    qemu_mutex_lock(&walking_handlers_mutex);
+    walking_handlers++;
+    qemu_mutex_unlock(&walking_handlers_mutex);
+
+    ...
+
+    // (2)
+    qemu_mutex_lock(&walking_handlers_mutex);
+    if (--walking_handlers == 0) {
+        QLIST_FOREACH_SAFE(ioh, &io_handlers, next, pioh) {
+            if (ioh->deleted) {
+                QLIST_REMOVE(ioh, next);
+                g_free(ioh);
+            }
+        }
+    }
+    qemu_mutex_unlock(&walking_handlers_mutex);
+
+Here, no frees can happen in the code represented by the ellipsis.
+If another thread is executing critical section (2), that part of
+the code cannot be entered, because the thread will not be able
+to increment the walking_handlers variable.  And of course
+during the visit any other thread will see a nonzero value for
+walking_handlers, as in the single-threaded code.
+
+Note that it is possible for multiple concurrent accesses to delay
+the cleanup arbitrarily; in other words, for the walking_handlers
+counter to never become zero.  For this reason, this technique is
+more easily applicable if concurrent access to the structure is rare.
+
+However, critical sections are easy to forget since you have to do
+them for each modification of the counter.  QemuLockCnt ensures that
+all modifications of the counter take the lock appropriately, and it
+can also be more efficient in two ways:
+
+- it avoids taking the lock for many operations (for example
+  incrementing the counter while it is non-zero);
+
+- on some platforms, one could implement QemuLockCnt to hold the
+  lock and the mutex in a single word, making it no more expensive
+  than simply managing a counter using atomic operations (see
+  docs/atomics.txt).  This is not implemented yet, but can be
+  very helpful if concurrent access to the data structure is
+  expected to be rare.
+
+
+Using the same mutex for frees and writes can still incur some small
+inefficiencies; for example, a visit can never start if the counter is
+zero and the mutex is taken---even if the mutex is taken by a write,
+which in principle need not block a visit of the data structure.
+However, these are usually not a problem if any of the following
+assumptions are valid:
+
+- concurrent access is possible but rare
+
+- writes are rare
+
+- writes are frequent, but this kind of write (e.g. appending to a
+  list) has a very small critical section.
+
+For example, QEMU uses QemuLockCnt to manage an AioContext's list of
+bottom halves and file descriptor handlers.  Modifications to the list
+of file descriptor handlers are rare.  Creation of a new bottom half is
+frequent and can happen on a fast path; however: 1) it is almost never
+concurrent with a visit to the list of bottom halves; 2) it only has
+three instructions in the critical path, two assignments and a smp_wmb().
+
+
+QemuLockCnt API
+---------------
+
+The QemuLockCnt API is described in include/qemu/thread.h.
+
+
+QemuLockCnt usage
+-----------------
+
+This section explains the typical usage patterns for QemuLockCnt functions.
+
+Setting a variable to a non-NULL value can be done between
+qemu_lockcnt_lock and qemu_lockcnt_unlock:
+
+    qemu_lockcnt_lock(&xyz_lockcnt);
+    if (!xyz) {
+        new_xyz = g_new(XYZ, 1);
+        ...
+        atomic_rcu_set(&xyz, new_xyz);
+    }
+    qemu_lockcnt_unlock(&xyz_lockcnt);
+
+Accessing the value can be done between qemu_lockcnt_inc and
+qemu_lockcnt_dec:
+
+    qemu_lockcnt_inc(&xyz_lockcnt);
+    if (xyz) {
+        XYZ *p = atomic_rcu_read(&xyz);
+        ...
+        /* Accesses can now be done through "p".  */
+    }
+    qemu_lockcnt_dec(&xyz_lockcnt);
+
+Freeing the object can similarly use qemu_lockcnt_lock and
+qemu_lockcnt_unlock, but you also need to ensure that the count
+is zero (i.e. there is no concurrent visit).  Because qemu_lockcnt_inc
+takes the QemuLockCnt's lock, the count cannot become non-zero while
+the object is being freed.  Freeing an object looks like this:
+
+    qemu_lockcnt_lock(&xyz_lockcnt);
+    if (!qemu_lockcnt_count(&xyz_lockcnt)) {
+        g_free(xyz);
+        xyz = NULL;
+    }
+    qemu_lockcnt_unlock(&xyz_lockcnt);
+
+If an object has to be freed right after a visit, you can combine
+the decrement, the locking and the check on count as follows:
+
+    qemu_lockcnt_inc(&xyz_lockcnt);
+    if (xyz) {
+        XYZ *p = atomic_rcu_read(&xyz);
+        ...
+        /* Accesses can now be done through "p".  */
+    }
+    if (qemu_lockcnt_dec_and_lock(&xyz_lockcnt)) {
+        g_free(xyz);
+        xyz = NULL;
+        qemu_lockcnt_unlock(&xyz_lockcnt);
+    }
+
+QemuLockCnt can also be used to access a list as follows:
+
+    qemu_lockcnt_inc(&io_handlers_lockcnt);
+    QLIST_FOREACH_RCU(ioh, &io_handlers, pioh) {
+        if (ioh->revents & G_IO_OUT) {
+            ioh->fd_write(ioh->opaque);
+        }
+    }
+
+    if (qemu_lockcnt_dec_and_lock(&io_handlers_lockcnt)) {
+        QLIST_FOREACH_SAFE(ioh, &io_handlers, next, pioh) {
+            if (ioh->deleted) {
+                QLIST_REMOVE(ioh, next);
+                g_free(ioh);
+            }
+        }
+        qemu_lockcnt_unlock(&io_handlers_lockcnt);
+    }
+
+Again, the RCU primitives are used because new items can be added to the
+list during the walk.  QLIST_FOREACH_RCU ensures that the processor and
+the compiler see the appropriate memory barriers.
+
+An alternative pattern uses qemu_lockcnt_dec_if_lock:
+
+    qemu_lockcnt_inc(&io_handlers_lockcnt);
+    QLIST_FOREACH_SAFE_RCU(ioh, &io_handlers, next, pioh) {
+        if (ioh->deleted) {
+            if (qemu_lockcnt_dec_if_lock(&io_handlers_lockcnt)) {
+                QLIST_REMOVE(ioh, next);
+                g_free(ioh);
+                qemu_lockcnt_inc_and_unlock(&io_handlers_lockcnt);
+            }
+        } else {
+            if (ioh->revents & G_IO_OUT) {
+                ioh->fd_write(ioh->opaque);
+            }
+        }
+    }
+    qemu_lockcnt_dec(&io_handlers_lockcnt);
+
+Here you can use qemu_lockcnt_dec instead of qemu_lockcnt_dec_and_lock,
+because there is no special task to do if the count goes from 1 to 0.
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index e8e665f..5f7de7b 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -8,6 +8,7 @@ typedef struct QemuMutex QemuMutex;
 typedef struct QemuCond QemuCond;
 typedef struct QemuSemaphore QemuSemaphore;
 typedef struct QemuEvent QemuEvent;
+typedef struct QemuLockCnt QemuLockCnt;
 typedef struct QemuThread QemuThread;
 
 #ifdef _WIN32
@@ -98,4 +99,113 @@ static inline void qemu_spin_unlock(QemuSpin *spin)
     __sync_lock_release(&spin->value);
 }
 
+struct QemuLockCnt {
+    QemuMutex mutex;
+    unsigned count;
+};
+
+/**
+ * qemu_lockcnt_init: initialize a QemuLockcnt
+ * @lockcnt: the lockcnt to initialize
+ *
+ * Initialize lockcnt's counter to zero and prepare its mutex
+ * for usage.
+ */
+void qemu_lockcnt_init(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_destroy: destroy a QemuLockcnt
+ * @lockcnt: the lockcnt to destruct
+ *
+ * Destroy lockcnt's mutex.
+ */
+void qemu_lockcnt_destroy(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_inc: increment a QemuLockCnt's counter
+ * @lockcnt: the lockcnt to operate on
+ *
+ * If the lockcnt's count is zero, wait for critical sections
+ * to finish and increment lockcnt's count to 1.  If the count
+ * is not zero, just increment it.
+ *
+ * Because this function can wait on the mutex, it must not be
+ * called while the lockcnt's mutex is held by the current thread.
+ * For the same reason, qemu_lockcnt_inc can also contribute to
+ * AB-BA deadlocks.  This is a sample deadlock scenario:
+ *
+ *            thread 1                      thread 2
+ *            -------------------------------------------------------
+ *            qemu_lockcnt_lock(&lc1);
+ *                                          qemu_lockcnt_lock(&lc2);
+ *            qemu_lockcnt_inc(&lc2);
+ *                                          qemu_lockcnt_inc(&lc1);
+ */
+void qemu_lockcnt_inc(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_dec: decrement a QemuLockCnt's counter
+ * @lockcnt: the lockcnt to operate on
+ */
+void qemu_lockcnt_dec(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_dec_and_lock: decrement a QemuLockCnt's counter and
+ * possibly lock it.
+ * @lockcnt: the lockcnt to operate on
+ *
+ * Decrement lockcnt's count.  If the new count is zero, lock
+ * the mutex and return true.  Otherwise, return false.
+ */
+bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_dec_if_lock: possibly decrement a QemuLockCnt's counter and
+ * lock it.
+ * @lockcnt: the lockcnt to operate on
+ *
+ * If the count is 1, decrement the count to zero, lock
+ * the mutex and return true.  Otherwise, return false.
+ */
+bool qemu_lockcnt_dec_if_lock(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_lock: lock a QemuLockCnt's mutex.
+ * @lockcnt: the lockcnt to operate on
+ *
+ * Remember that concurrent visits are not blocked unless the count is
+ * also zero.  You can use qemu_lockcnt_count to check for this inside a
+ * critical section.
+ */
+void qemu_lockcnt_lock(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_unlock: release a QemuLockCnt's mutex.
+ * @lockcnt: the lockcnt to operate on.
+ */
+void qemu_lockcnt_unlock(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_inc_and_unlock: combined unlock/increment on a QemuLockCnt.
+ * @lockcnt: the lockcnt to operate on.
+ *
+ * This is the same as
+ *
+ *     qemu_lockcnt_unlock(lockcnt);
+ *     qemu_lockcnt_inc(lockcnt);
+ *
+ * but more efficient.
+ */
+void qemu_lockcnt_inc_and_unlock(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_count: query a LockCnt's count.
+ * @lockcnt: the lockcnt to query.
+ *
+ * Note that the count can change at any time.  Still, while the
+ * lockcnt is locked, one can usefully check whether the count
+ * is non-zero.
+ */
+unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt);
+
 #endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index ad0f9c7..c1f247d 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -1,5 +1,6 @@
 util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
 util-obj-y += bufferiszero.o
+util-obj-y += lockcnt.o
 util-obj-$(CONFIG_POSIX) += compatfd.o
 util-obj-$(CONFIG_POSIX) += event_notifier-posix.o
 util-obj-$(CONFIG_POSIX) += mmap-alloc.o
diff --git a/util/lockcnt.c b/util/lockcnt.c
new file mode 100644
index 0000000..da1de77
--- /dev/null
+++ b/util/lockcnt.c
@@ -0,0 +1,114 @@
+/*
+ * QemuLockCnt implementation
+ *
+ * Copyright Red Hat, Inc. 2017
+ *
+ * Author:
+ *   Paolo Bonzini <pbonzini@redhat.com>
+ */
+#include "qemu/osdep.h"
+#include "qemu/thread.h"
+#include "qemu/atomic.h"
+
+void qemu_lockcnt_init(QemuLockCnt *lockcnt)
+{
+    qemu_mutex_init(&lockcnt->mutex);
+    lockcnt->count = 0;
+}
+
+void qemu_lockcnt_destroy(QemuLockCnt *lockcnt)
+{
+    qemu_mutex_destroy(&lockcnt->mutex);
+}
+
+void qemu_lockcnt_inc(QemuLockCnt *lockcnt)
+{
+    int old;
+    for (;;) {
+        old = atomic_read(&lockcnt->count);
+        if (old == 0) {
+            qemu_lockcnt_lock(lockcnt);
+            qemu_lockcnt_inc_and_unlock(lockcnt);
+            return;
+        } else {
+            if (atomic_cmpxchg(&lockcnt->count, old, old + 1) == old) {
+                return;
+            }
+        }
+    }
+}
+
+void qemu_lockcnt_dec(QemuLockCnt *lockcnt)
+{
+    atomic_dec(&lockcnt->count);
+}
+
+/* Decrement a counter, and return locked if it is decremented to zero.
+ * It is impossible for the counter to become nonzero while the mutex
+ * is taken.
+ */
+bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt)
+{
+    int val = atomic_read(&lockcnt->count);
+    while (val > 1) {
+        int old = atomic_cmpxchg(&lockcnt->count, val, val - 1);
+        if (old != val) {
+            val = old;
+            continue;
+        }
+
+        return false;
+    }
+
+    qemu_lockcnt_lock(lockcnt);
+    if (atomic_fetch_dec(&lockcnt->count) == 1) {
+        return true;
+    }
+
+    qemu_lockcnt_unlock(lockcnt);
+    return false;
+}
+
+/* Decrement a counter and return locked if it is decremented to zero.
+ * Otherwise do nothing.
+ *
+ * It is impossible for the counter to become nonzero while the mutex
+ * is taken.
+ */
+bool qemu_lockcnt_dec_if_lock(QemuLockCnt *lockcnt)
+{
+    /* No need for acquire semantics if we return false.  */
+    int val = atomic_read(&lockcnt->count);
+    if (val > 1) {
+        return false;
+    }
+
+    qemu_lockcnt_lock(lockcnt);
+    if (atomic_fetch_dec(&lockcnt->count) == 1) {
+        return true;
+    }
+
+    qemu_lockcnt_inc_and_unlock(lockcnt);
+    return false;
+}
+
+void qemu_lockcnt_lock(QemuLockCnt *lockcnt)
+{
+    qemu_mutex_lock(&lockcnt->mutex);
+}
+
+void qemu_lockcnt_inc_and_unlock(QemuLockCnt *lockcnt)
+{
+    atomic_inc(&lockcnt->count);
+    qemu_mutex_unlock(&lockcnt->mutex);
+}
+
+void qemu_lockcnt_unlock(QemuLockCnt *lockcnt)
+{
+    qemu_mutex_unlock(&lockcnt->mutex);
+}
+
+unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt)
+{
+    return atomic_read(&lockcnt->count);
+}
-- 
2.9.3
