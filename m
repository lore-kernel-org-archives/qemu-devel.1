Received: from eggs.gnu.org ([2001:4830:134:3::10]:44377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eelod-0000BK-Ab
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eelob-0004PB-Qa
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:59:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eelob-0004Of-Hl
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:59:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B34F94B703
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 17:59:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Jan 2018 18:59:46 +0100
Message-Id: <20180125175949.7780-3-pbonzini@redhat.com>
In-Reply-To: <20180125175949.7780-1-pbonzini@redhat.com>
References: <20180125175949.7780-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] lockable: add QemuLockable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

QemuLockable is a polymorphic lock type that takes an object and
knows which function to use for locking and unlocking.  The
implementation could use C11 _Generic, but since the support is
not very widespread I am instead using __builtin_choose_expr and
__builtin_types_compatible_p, which are already used by
include/qemu/atomic.h.

QemuLockable can be used to implement lock guards, or to pass around
a lock in such a way that a function can release it and re-acquire it.
The next patch will do this for CoQueue.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v2->v3: now it works :(  Also, QEMU_MAKE_LOCKABLE(NULL) returns NULL.
                The argument of QEMU_MAKE_LOCKABLE is expected to be a constant,
                so the test is optimized away.

 include/qemu/compiler.h  | 40 ++++++++++++++++++++++
 include/qemu/coroutine.h |  4 +--
 include/qemu/lockable.h  | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/thread.h    |  5 ++-
 include/qemu/typedefs.h  |  4 +++
 tests/test-coroutine.c   | 25 ++++++++++++++
 6 files changed, 161 insertions(+), 5 deletions(-)
 create mode 100644 include/qemu/lockable.h

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 340e5fdc09..5179bedb1e 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -111,4 +111,44 @@
 #define GCC_FMT_ATTR(n, m)
 #endif
 
+/* Implement C11 _Generic via GCC builtins.  Example:
+ *
+ *    QEMU_GENERIC(x, (float, sinf), (long double, sinl), sin) (x)
+ *
+ * The first argument is the discriminator.  The last is the default value.
+ * The middle ones are tuples in "(type, expansion)" format.
+ */
+
+/* First, find out the number of generic cases.  */
+#define QEMU_GENERIC(x, ...) \
+    QEMU_GENERIC_(typeof(x), __VA_ARGS__, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+
+/* There will be extra arguments, but they are not used.  */
+#define QEMU_GENERIC_(x, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, count, ...) \
+    QEMU_GENERIC##count(x, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9)
+
+/* Two more helper macros, this time to extract items from a parenthesized
+ * list.
+ */
+#define QEMU_FIRST_(a, b) a
+#define QEMU_SECOND_(a, b) b
+
+/* ... and a final one for the common part of the "recursion".  */
+#define QEMU_GENERIC_IF(x, type_then, else_)                                   \
+    __builtin_choose_expr(__builtin_types_compatible_p(x,                      \
+                                                       QEMU_FIRST_ type_then), \
+                          QEMU_SECOND_ type_then, else_)
+
+/* CPP poor man's "recursion".  */
+#define QEMU_GENERIC1(x, a0, ...) (a0)
+#define QEMU_GENERIC2(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC1(x, __VA_ARGS__))
+#define QEMU_GENERIC3(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC2(x, __VA_ARGS__))
+#define QEMU_GENERIC4(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC3(x, __VA_ARGS__))
+#define QEMU_GENERIC5(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC4(x, __VA_ARGS__))
+#define QEMU_GENERIC6(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC5(x, __VA_ARGS__))
+#define QEMU_GENERIC7(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC6(x, __VA_ARGS__))
+#define QEMU_GENERIC8(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC7(x, __VA_ARGS__))
+#define QEMU_GENERIC9(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC8(x, __VA_ARGS__))
+#define QEMU_GENERIC10(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC9(x, __VA_ARGS__))
+
 #endif /* COMPILER_H */
diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index ce2eb73670..8a5129741c 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -121,7 +121,7 @@ bool qemu_coroutine_entered(Coroutine *co);
  * Provides a mutex that can be used to synchronise coroutines
  */
 struct CoWaitRecord;
-typedef struct CoMutex {
+struct CoMutex {
     /* Count of pending lockers; 0 for a free mutex, 1 for an
      * uncontended mutex.
      */
@@ -142,7 +142,7 @@ typedef struct CoMutex {
     unsigned handoff, sequence;
 
     Coroutine *holder;
-} CoMutex;
+};
 
 /**
  * Initialises a CoMutex. This must be called before any other operation is used
diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
new file mode 100644
index 0000000000..f527d0ddb2
--- /dev/null
+++ b/include/qemu/lockable.h
@@ -0,0 +1,88 @@
+/*
+ * Polymorphic locking functions (aka poor man templates)
+ *
+ * Copyright Red Hat, Inc. 2017
+ *
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_LOCKABLE_H
+#define QEMU_LOCKABLE_H
+
+#include "qemu/coroutine.h"
+#include "qemu/thread.h"
+
+typedef void QemuLockUnlockFunc(void *);
+
+struct QemuLockable {
+    void *object;
+    QemuLockUnlockFunc *lock;
+    QemuLockUnlockFunc *unlock;
+};
+
+/* This function gives link-time errors if an invalid, non-NULL
+ * pointer type is passed to QEMU_MAKE_LOCKABLE.
+ */
+void unknown_lock_type(void *);
+
+static inline __attribute__((__always_inline__)) QemuLockable *
+qemu_make_lockable(void *x, QemuLockable *lockable)
+{
+    /* We cannot test this in a macro, otherwise we get * compiler
+     * warnings like "the address of 'm' will always evaluate as 'true'".
+     */
+    return x ? lockable : NULL;
+}
+
+/* Auxiliary macros to simplify QEMU_MAKE_LOCABLE.  */
+#define QEMU_LOCK_FUNC(x) ((QemuLockUnlockFunc *)    \
+    QEMU_GENERIC(x,                                  \
+                 (QemuMutex *, qemu_mutex_lock),     \
+                 (CoMutex *, qemu_co_mutex_lock),    \
+                 (QemuSpin *, qemu_spin_lock),       \
+                 unknown_lock_type))
+
+#define QEMU_UNLOCK_FUNC(x) ((QemuLockUnlockFunc *)  \
+    QEMU_GENERIC(x,                                  \
+                 (QemuMutex *, qemu_mutex_unlock),   \
+                 (CoMutex *, qemu_co_mutex_unlock),  \
+                 (QemuSpin *, qemu_spin_unlock),     \
+                 unknown_lock_type))
+
+/* In C, compound literals have the lifetime of an automatic variable.
+ * In C++ it would be different, but then C++ wouldn't need QemuLockable
+ * either...
+ */
+#define QEMU_MAKE_LOCKABLE_(x) qemu_make_lockable((x), &(QemuLockable) {    \
+        .object = (x),                               \
+        .lock = QEMU_LOCK_FUNC(x),                   \
+        .unlock = QEMU_UNLOCK_FUNC(x),               \
+    })
+
+/* QEMU_MAKE_LOCKABLE - Make a polymorphic QemuLockable
+ *
+ * @x: a lock object (currently one of QemuMutex, CoMutex, QemuSpin).
+ *
+ * Returns a QemuLockable object that can be passed around
+ * to a function that can operate with locks of any kind.
+ */
+#define QEMU_MAKE_LOCKABLE(x)                        \
+    QEMU_GENERIC(x,                                  \
+                 (QemuLockable *, (x)),              \
+                 QEMU_MAKE_LOCKABLE_(x))
+
+static inline void qemu_lockable_lock(QemuLockable *x)
+{
+    x->lock(x->object);
+}
+
+static inline void qemu_lockable_unlock(QemuLockable *x)
+{
+    x->unlock(x->object);
+}
+
+#endif
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 9af4e945aa..ef7bd16123 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -4,7 +4,6 @@
 #include "qemu/processor.h"
 #include "qemu/atomic.h"
 
-typedef struct QemuMutex QemuMutex;
 typedef struct QemuCond QemuCond;
 typedef struct QemuSemaphore QemuSemaphore;
 typedef struct QemuEvent QemuEvent;
@@ -97,9 +96,9 @@ struct Notifier;
 void qemu_thread_atexit_add(struct Notifier *notifier);
 void qemu_thread_atexit_remove(struct Notifier *notifier);
 
-typedef struct QemuSpin {
+struct QemuSpin {
     int value;
-} QemuSpin;
+};
 
 static inline void qemu_spin_init(QemuSpin *spin)
 {
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 9bd7a834ba..5923849cdd 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -19,6 +19,7 @@ typedef struct BusClass BusClass;
 typedef struct BusState BusState;
 typedef struct Chardev Chardev;
 typedef struct CompatProperty CompatProperty;
+typedef struct CoMutex CoMutex;
 typedef struct CPUAddressSpace CPUAddressSpace;
 typedef struct CPUState CPUState;
 typedef struct DeviceListener DeviceListener;
@@ -86,9 +87,12 @@ typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
 typedef struct QemuDmaBuf QemuDmaBuf;
 typedef struct QEMUFile QEMUFile;
+typedef struct QemuLockable QemuLockable;
+typedef struct QemuMutex QemuMutex;
 typedef struct QemuOpt QemuOpt;
 typedef struct QemuOpts QemuOpts;
 typedef struct QemuOptsList QemuOptsList;
+typedef struct QemuSpin QemuSpin;
 typedef struct QEMUSGList QEMUSGList;
 typedef struct QEMUTimer QEMUTimer;
 typedef struct QEMUTimerListGroup QEMUTimerListGroup;
diff --git a/tests/test-coroutine.c b/tests/test-coroutine.c
index 010cb95ad6..6e4842bfda 100644
--- a/tests/test-coroutine.c
+++ b/tests/test-coroutine.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/coroutine.h"
 #include "qemu/coroutine_int.h"
+#include "qemu/lockable.h"
 
 /*
  * Check that qemu_in_coroutine() works
@@ -210,6 +211,18 @@ static void coroutine_fn mutex_fn(void *opaque)
     done++;
 }
 
+static void coroutine_fn lockable_fn(void *opaque)
+{
+    QemuLockable *x = opaque;
+    qemu_lockable_lock(x);
+    assert(!locked);
+    locked = true;
+    qemu_coroutine_yield();
+    locked = false;
+    qemu_lockable_unlock(x);
+    done++;
+}
+
 static void do_test_co_mutex(CoroutineEntry *entry, void *opaque)
 {
     Coroutine *c1 = qemu_coroutine_create(entry, opaque);
@@ -240,6 +253,17 @@ static void test_co_mutex(void)
     do_test_co_mutex(mutex_fn, &m);
 }
 
+static void test_co_mutex_lockable(void)
+{
+    CoMutex m;
+    CoMutex *null_pointer = NULL;
+
+    qemu_co_mutex_init(&m);
+    do_test_co_mutex(lockable_fn, QEMU_MAKE_LOCKABLE(&m));
+
+    g_assert(QEMU_MAKE_LOCKABLE(null_pointer) == NULL);
+}
+
 /*
  * Check that creation, enter, and return work
  */
@@ -478,6 +502,7 @@ int main(int argc, char **argv)
     g_test_add_func("/basic/in_coroutine", test_in_coroutine);
     g_test_add_func("/basic/order", test_order);
     g_test_add_func("/locking/co-mutex", test_co_mutex);
+    g_test_add_func("/locking/co-mutex/lockable", test_co_mutex_lockable);
     if (g_test_perf()) {
         g_test_add_func("/perf/lifecycle", perf_lifecycle);
         g_test_add_func("/perf/nesting", perf_nesting);
-- 
2.14.3
