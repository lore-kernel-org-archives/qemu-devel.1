Received: from eggs.gnu.org ([2001:4830:134:3::10]:41215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VO-00085T-Fb
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VM-0003kA-7J
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT7VL-0003k2-UO
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:24 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jan 2017 13:39:05 +0000
Message-Id: <20170116133911.21684-6-stefanha@redhat.com>
In-Reply-To: <20170116133911.21684-1-stefanha@redhat.com>
References: <20170116133911.21684-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 05/11] qemu-thread: optimize QemuLockCnt with
 futexes on Linux
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

This is complex, but I think it is reasonably documented in the source.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170112180800.21085-5-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/lockcnt.txt         |   9 +-
 include/qemu/futex.h     |  36 ++++++
 include/qemu/thread.h    |   2 +
 util/lockcnt.c           | 283 +++++++++++++++++++++++++++++++++++++++++++++++
 util/qemu-thread-posix.c |  35 +-----
 util/qemu-thread-win32.c |   2 +-
 util/trace-events        |  10 ++
 7 files changed, 342 insertions(+), 35 deletions(-)
 create mode 100644 include/qemu/futex.h

diff --git a/docs/lockcnt.txt b/docs/lockcnt.txt
index 25a8091..2a79b32 100644
--- a/docs/lockcnt.txt
+++ b/docs/lockcnt.txt
@@ -142,12 +142,11 @@ can also be more efficient in two ways:
 - it avoids taking the lock for many operations (for example
   incrementing the counter while it is non-zero);
 
-- on some platforms, one could implement QemuLockCnt to hold the
-  lock and the mutex in a single word, making it no more expensive
+- on some platforms, one can implement QemuLockCnt to hold the lock
+  and the mutex in a single word, making the fast path no more expensive
   than simply managing a counter using atomic operations (see
-  docs/atomics.txt).  This is not implemented yet, but can be
-  very helpful if concurrent access to the data structure is
-  expected to be rare.
+  docs/atomics.txt).  This can be very helpful if concurrent access to
+  the data structure is expected to be rare.
 
 
 Using the same mutex for frees and writes can still incur some small
diff --git a/include/qemu/futex.h b/include/qemu/futex.h
new file mode 100644
index 0000000..bb7dc9e
--- /dev/null
+++ b/include/qemu/futex.h
@@ -0,0 +1,36 @@
+/*
+ * Wrappers around Linux futex syscall
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
+
+#include <sys/syscall.h>
+#include <linux/futex.h>
+
+#define qemu_futex(...)              syscall(__NR_futex, __VA_ARGS__)
+
+static inline void qemu_futex_wake(void *f, int n)
+{
+    qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
+}
+
+static inline void qemu_futex_wait(void *f, unsigned val)
+{
+    while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
+        switch (errno) {
+        case EWOULDBLOCK:
+            return;
+        case EINTR:
+            break; /* get out of switch and retry */
+        default:
+            abort();
+        }
+    }
+}
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 5f7de7b..9910f49 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -100,7 +100,9 @@ static inline void qemu_spin_unlock(QemuSpin *spin)
 }
 
 struct QemuLockCnt {
+#ifndef CONFIG_LINUX
     QemuMutex mutex;
+#endif
     unsigned count;
 };
 
diff --git a/util/lockcnt.c b/util/lockcnt.c
index da1de77..4f88dcf 100644
--- a/util/lockcnt.c
+++ b/util/lockcnt.c
@@ -9,7 +9,289 @@
 #include "qemu/osdep.h"
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
+#include "trace.h"
 
+#ifdef CONFIG_LINUX
+#include "qemu/futex.h"
+
+/* On Linux, bits 0-1 are a futex-based lock, bits 2-31 are the counter.
+ * For the mutex algorithm see Ulrich Drepper's "Futexes Are Tricky" (ok,
+ * this is not the most relaxing citation I could make...).  It is similar
+ * to mutex2 in the paper.
+ */
+
+#define QEMU_LOCKCNT_STATE_MASK    3
+#define QEMU_LOCKCNT_STATE_FREE    0   /* free, uncontended */
+#define QEMU_LOCKCNT_STATE_LOCKED  1   /* locked, uncontended */
+#define QEMU_LOCKCNT_STATE_WAITING 2   /* locked, contended */
+
+#define QEMU_LOCKCNT_COUNT_STEP    4
+#define QEMU_LOCKCNT_COUNT_SHIFT   2
+
+void qemu_lockcnt_init(QemuLockCnt *lockcnt)
+{
+    lockcnt->count = 0;
+}
+
+void qemu_lockcnt_destroy(QemuLockCnt *lockcnt)
+{
+}
+
+/* *val is the current value of lockcnt->count.
+ *
+ * If the lock is free, try a cmpxchg from *val to new_if_free; return
+ * true and set *val to the old value found by the cmpxchg in
+ * lockcnt->count.
+ *
+ * If the lock is taken, wait for it to be released and return false
+ * *without trying again to take the lock*.  Again, set *val to the
+ * new value of lockcnt->count.
+ *
+ * If *waited is true on return, new_if_free's bottom two bits must not
+ * be QEMU_LOCKCNT_STATE_LOCKED on subsequent calls, because the caller
+ * does not know if there are other waiters.  Furthermore, after *waited
+ * is set the caller has effectively acquired the lock.  If it returns
+ * with the lock not taken, it must wake another futex waiter.
+ */
+static bool qemu_lockcnt_cmpxchg_or_wait(QemuLockCnt *lockcnt, int *val,
+                                         int new_if_free, bool *waited)
+{
+    /* Fast path for when the lock is free.  */
+    if ((*val & QEMU_LOCKCNT_STATE_MASK) == QEMU_LOCKCNT_STATE_FREE) {
+        int expected = *val;
+
+        trace_lockcnt_fast_path_attempt(lockcnt, expected, new_if_free);
+        *val = atomic_cmpxchg(&lockcnt->count, expected, new_if_free);
+        if (*val == expected) {
+            trace_lockcnt_fast_path_success(lockcnt, expected, new_if_free);
+            *val = new_if_free;
+            return true;
+        }
+    }
+
+    /* The slow path moves from locked to waiting if necessary, then
+     * does a futex wait.  Both steps can be repeated ad nauseam,
+     * only getting out of the loop if we can have another shot at the
+     * fast path.  Once we can, get out to compute the new destination
+     * value for the fast path.
+     */
+    while ((*val & QEMU_LOCKCNT_STATE_MASK) != QEMU_LOCKCNT_STATE_FREE) {
+        if ((*val & QEMU_LOCKCNT_STATE_MASK) == QEMU_LOCKCNT_STATE_LOCKED) {
+            int expected = *val;
+            int new = expected - QEMU_LOCKCNT_STATE_LOCKED + QEMU_LOCKCNT_STATE_WAITING;
+
+            trace_lockcnt_futex_wait_prepare(lockcnt, expected, new);
+            *val = atomic_cmpxchg(&lockcnt->count, expected, new);
+            if (*val == expected) {
+                *val = new;
+            }
+            continue;
+        }
+
+        if ((*val & QEMU_LOCKCNT_STATE_MASK) == QEMU_LOCKCNT_STATE_WAITING) {
+            *waited = true;
+            trace_lockcnt_futex_wait(lockcnt, *val);
+            qemu_futex_wait(&lockcnt->count, *val);
+            *val = atomic_read(&lockcnt->count);
+            trace_lockcnt_futex_wait_resume(lockcnt, *val);
+            continue;
+        }
+
+        abort();
+    }
+    return false;
+}
+
+static void lockcnt_wake(QemuLockCnt *lockcnt)
+{
+    trace_lockcnt_futex_wake(lockcnt);
+    qemu_futex_wake(&lockcnt->count, 1);
+}
+
+void qemu_lockcnt_inc(QemuLockCnt *lockcnt)
+{
+    int val = atomic_read(&lockcnt->count);
+    bool waited = false;
+
+    for (;;) {
+        if (val >= QEMU_LOCKCNT_COUNT_STEP) {
+            int expected = val;
+            val = atomic_cmpxchg(&lockcnt->count, val, val + QEMU_LOCKCNT_COUNT_STEP);
+            if (val == expected) {
+                break;
+            }
+        } else {
+            /* The fast path is (0, unlocked)->(1, unlocked).  */
+            if (qemu_lockcnt_cmpxchg_or_wait(lockcnt, &val, QEMU_LOCKCNT_COUNT_STEP,
+                                             &waited)) {
+                break;
+            }
+        }
+    }
+
+    /* If we were woken by another thread, we should also wake one because
+     * we are effectively releasing the lock that was given to us.  This is
+     * the case where qemu_lockcnt_lock would leave QEMU_LOCKCNT_STATE_WAITING
+     * in the low bits, and qemu_lockcnt_inc_and_unlock would find it and
+     * wake someone.
+     */
+    if (waited) {
+        lockcnt_wake(lockcnt);
+    }
+}
+
+void qemu_lockcnt_dec(QemuLockCnt *lockcnt)
+{
+    atomic_sub(&lockcnt->count, QEMU_LOCKCNT_COUNT_STEP);
+}
+
+/* Decrement a counter, and return locked if it is decremented to zero.
+ * If the function returns true, it is impossible for the counter to
+ * become nonzero until the next qemu_lockcnt_unlock.
+ */
+bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt)
+{
+    int val = atomic_read(&lockcnt->count);
+    int locked_state = QEMU_LOCKCNT_STATE_LOCKED;
+    bool waited = false;
+
+    for (;;) {
+        if (val >= 2 * QEMU_LOCKCNT_COUNT_STEP) {
+            int expected = val;
+            val = atomic_cmpxchg(&lockcnt->count, val, val - QEMU_LOCKCNT_COUNT_STEP);
+            if (val == expected) {
+                break;
+            }
+        } else {
+            /* If count is going 1->0, take the lock. The fast path is
+             * (1, unlocked)->(0, locked) or (1, unlocked)->(0, waiting).
+             */
+            if (qemu_lockcnt_cmpxchg_or_wait(lockcnt, &val, locked_state, &waited)) {
+                return true;
+            }
+
+            if (waited) {
+                /* At this point we do not know if there are more waiters.  Assume
+                 * there are.
+                 */
+                locked_state = QEMU_LOCKCNT_STATE_WAITING;
+            }
+        }
+    }
+
+    /* If we were woken by another thread, but we're returning in unlocked
+     * state, we should also wake a thread because we are effectively
+     * releasing the lock that was given to us.  This is the case where
+     * qemu_lockcnt_lock would leave QEMU_LOCKCNT_STATE_WAITING in the low
+     * bits, and qemu_lockcnt_unlock would find it and wake someone.
+     */
+    if (waited) {
+        lockcnt_wake(lockcnt);
+    }
+    return false;
+}
+
+/* If the counter is one, decrement it and return locked.  Otherwise do
+ * nothing.
+ *
+ * If the function returns true, it is impossible for the counter to
+ * become nonzero until the next qemu_lockcnt_unlock.
+ */
+bool qemu_lockcnt_dec_if_lock(QemuLockCnt *lockcnt)
+{
+    int val = atomic_read(&lockcnt->count);
+    int locked_state = QEMU_LOCKCNT_STATE_LOCKED;
+    bool waited = false;
+
+    while (val < 2 * QEMU_LOCKCNT_COUNT_STEP) {
+        /* If count is going 1->0, take the lock. The fast path is
+         * (1, unlocked)->(0, locked) or (1, unlocked)->(0, waiting).
+         */
+        if (qemu_lockcnt_cmpxchg_or_wait(lockcnt, &val, locked_state, &waited)) {
+            return true;
+        }
+
+        if (waited) {
+            /* At this point we do not know if there are more waiters.  Assume
+             * there are.
+             */
+            locked_state = QEMU_LOCKCNT_STATE_WAITING;
+        }
+    }
+
+    /* If we were woken by another thread, but we're returning in unlocked
+     * state, we should also wake a thread because we are effectively
+     * releasing the lock that was given to us.  This is the case where
+     * qemu_lockcnt_lock would leave QEMU_LOCKCNT_STATE_WAITING in the low
+     * bits, and qemu_lockcnt_inc_and_unlock would find it and wake someone.
+     */
+    if (waited) {
+        lockcnt_wake(lockcnt);
+    }
+    return false;
+}
+
+void qemu_lockcnt_lock(QemuLockCnt *lockcnt)
+{
+    int val = atomic_read(&lockcnt->count);
+    int step = QEMU_LOCKCNT_STATE_LOCKED;
+    bool waited = false;
+
+    /* The third argument is only used if the low bits of val are 0
+     * (QEMU_LOCKCNT_STATE_FREE), so just blindly mix in the desired
+     * state.
+     */
+    while (!qemu_lockcnt_cmpxchg_or_wait(lockcnt, &val, val + step, &waited)) {
+        if (waited) {
+            /* At this point we do not know if there are more waiters.  Assume
+             * there are.
+             */
+            step = QEMU_LOCKCNT_STATE_WAITING;
+        }
+    }
+}
+
+void qemu_lockcnt_inc_and_unlock(QemuLockCnt *lockcnt)
+{
+    int expected, new, val;
+
+    val = atomic_read(&lockcnt->count);
+    do {
+        expected = val;
+        new = (val + QEMU_LOCKCNT_COUNT_STEP) & ~QEMU_LOCKCNT_STATE_MASK;
+        trace_lockcnt_unlock_attempt(lockcnt, val, new);
+        val = atomic_cmpxchg(&lockcnt->count, val, new);
+    } while (val != expected);
+
+    trace_lockcnt_unlock_success(lockcnt, val, new);
+    if (val & QEMU_LOCKCNT_STATE_WAITING) {
+        lockcnt_wake(lockcnt);
+    }
+}
+
+void qemu_lockcnt_unlock(QemuLockCnt *lockcnt)
+{
+    int expected, new, val;
+
+    val = atomic_read(&lockcnt->count);
+    do {
+        expected = val;
+        new = val & ~QEMU_LOCKCNT_STATE_MASK;
+        trace_lockcnt_unlock_attempt(lockcnt, val, new);
+        val = atomic_cmpxchg(&lockcnt->count, val, new);
+    } while (val != expected);
+
+    trace_lockcnt_unlock_success(lockcnt, val, new);
+    if (val & QEMU_LOCKCNT_STATE_WAITING) {
+        lockcnt_wake(lockcnt);
+    }
+}
+
+unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt)
+{
+    return atomic_read(&lockcnt->count) >> QEMU_LOCKCNT_COUNT_SHIFT;
+}
+#else
 void qemu_lockcnt_init(QemuLockCnt *lockcnt)
 {
     qemu_mutex_init(&lockcnt->mutex);
@@ -112,3 +394,4 @@ unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt)
 {
     return atomic_read(&lockcnt->count);
 }
+#endif
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index d20cdde..37cd8ba 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -11,10 +11,6 @@
  *
  */
 #include "qemu/osdep.h"
-#ifdef __linux__
-#include <sys/syscall.h>
-#include <linux/futex.h>
-#endif
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
@@ -294,28 +290,9 @@ void qemu_sem_wait(QemuSemaphore *sem)
 }
 
 #ifdef __linux__
-#define futex(...)              syscall(__NR_futex, __VA_ARGS__)
-
-static inline void futex_wake(QemuEvent *ev, int n)
-{
-    futex(ev, FUTEX_WAKE, n, NULL, NULL, 0);
-}
-
-static inline void futex_wait(QemuEvent *ev, unsigned val)
-{
-    while (futex(ev, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
-        switch (errno) {
-        case EWOULDBLOCK:
-            return;
-        case EINTR:
-            break; /* get out of switch and retry */
-        default:
-            abort();
-        }
-    }
-}
+#include "qemu/futex.h"
 #else
-static inline void futex_wake(QemuEvent *ev, int n)
+static inline void qemu_futex_wake(QemuEvent *ev, int n)
 {
     pthread_mutex_lock(&ev->lock);
     if (n == 1) {
@@ -326,7 +303,7 @@ static inline void futex_wake(QemuEvent *ev, int n)
     pthread_mutex_unlock(&ev->lock);
 }
 
-static inline void futex_wait(QemuEvent *ev, unsigned val)
+static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
 {
     pthread_mutex_lock(&ev->lock);
     if (ev->value == val) {
@@ -338,7 +315,7 @@ static inline void futex_wait(QemuEvent *ev, unsigned val)
 
 /* Valid transitions:
  * - free->set, when setting the event
- * - busy->set, when setting the event, followed by futex_wake
+ * - busy->set, when setting the event, followed by qemu_futex_wake
  * - set->free, when resetting the event
  * - free->busy, when waiting
  *
@@ -381,7 +358,7 @@ void qemu_event_set(QemuEvent *ev)
     if (atomic_read(&ev->value) != EV_SET) {
         if (atomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
             /* There were waiters, wake them up.  */
-            futex_wake(ev, INT_MAX);
+            qemu_futex_wake(ev, INT_MAX);
         }
     }
 }
@@ -419,7 +396,7 @@ void qemu_event_wait(QemuEvent *ev)
                 return;
             }
         }
-        futex_wait(ev, EV_BUSY);
+        qemu_futex_wait(ev, EV_BUSY);
     }
 }
 
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 728e76b..178e016 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -269,7 +269,7 @@ void qemu_sem_wait(QemuSemaphore *sem)
  *
  * Valid transitions:
  * - free->set, when setting the event
- * - busy->set, when setting the event, followed by futex_wake
+ * - busy->set, when setting the event, followed by SetEvent
  * - set->free, when resetting the event
  * - free->busy, when waiting
  *
diff --git a/util/trace-events b/util/trace-events
index ed06aee..2b8aa30 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -30,3 +30,13 @@ qemu_anon_ram_free(void *ptr, size_t size) "ptr %p size %zu"
 hbitmap_iter_skip_words(const void *hb, void *hbi, uint64_t pos, unsigned long cur) "hb %p hbi %p pos %"PRId64" cur 0x%lx"
 hbitmap_reset(void *hb, uint64_t start, uint64_t count, uint64_t sbit, uint64_t ebit) "hb %p items %"PRIu64",%"PRIu64" bits %"PRIu64"..%"PRIu64
 hbitmap_set(void *hb, uint64_t start, uint64_t count, uint64_t sbit, uint64_t ebit) "hb %p items %"PRIu64",%"PRIu64" bits %"PRIu64"..%"PRIu64
+
+# util/lockcnt.c
+lockcnt_fast_path_attempt(const void *lockcnt, int expected, int new) "lockcnt %p fast path %d->%d"
+lockcnt_fast_path_success(const void *lockcnt, int expected, int new) "lockcnt %p fast path %d->%d succeeded"
+lockcnt_unlock_attempt(const void *lockcnt, int expected, int new) "lockcnt %p unlock %d->%d"
+lockcnt_unlock_success(const void *lockcnt, int expected, int new) "lockcnt %p unlock %d->%d succeeded"
+lockcnt_futex_wait_prepare(const void *lockcnt, int expected, int new) "lockcnt %p preparing slow path %d->%d"
+lockcnt_futex_wait(const void *lockcnt, int val) "lockcnt %p waiting on %d"
+lockcnt_futex_wait_resume(const void *lockcnt, int new) "lockcnt %p after wait: %d"
+lockcnt_futex_wake(const void *lockcnt) "lockcnt %p waking up one waiter"
-- 
2.9.3
