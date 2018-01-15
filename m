Received: from eggs.gnu.org ([2001:4830:134:3::10]:56422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebCve-0007Mo-RR
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 17:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebCvc-00069z-4z
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 17:08:30 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 Jan 2018 23:08:19 +0100
Message-Id: <20180115220822.10156-2-pbonzini@redhat.com>
In-Reply-To: <20180115220822.10156-1-pbonzini@redhat.com>
References: <20180115220822.10156-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] lockable: add QemuLockable
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
 include/qemu/compiler.h  | 40 ++++++++++++++++++++++++++
 include/qemu/coroutine.h |  4 +--
 include/qemu/lockable.h  | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/thread.h    |  5 ++--
 include/qemu/typedefs.h  |  4 +++
 5 files changed, 123 insertions(+), 5 deletions(-)
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
+#define QEMU_GENERIC_IF_(x, type_then, else_)                                  \
+    __builtin_choose_expr(__builtin_types_compatible_p(x,                      \
+                                                       QEMU_FIRST_ type_then), \
+                          QEMU_SECOND_ type_then, else_)
+
+/* CPP poor man's "recursion".  */
+#define QEMU_GENERIC1(x, a0, ...) (a0)
+#define QEMU_GENERIC2(x, a0, ...) QEMU_GENERIC_IF_(x, a0, QEMU_GENERIC1(x, __VA_ARGS__))
+#define QEMU_GENERIC3(x, a0, ...) QEMU_GENERIC_IF_(x, a0, QEMU_GENERIC2(x, __VA_ARGS__))
+#define QEMU_GENERIC4(x, a0, ...) QEMU_GENERIC_IF_(x, a0, QEMU_GENERIC3(x, __VA_ARGS__))
+#define QEMU_GENERIC5(x, a0, ...) QEMU_GENERIC_IF_(x, a0, QEMU_GENERIC4(x, __VA_ARGS__))
+#define QEMU_GENERIC6(x, a0, ...) QEMU_GENERIC_IF_(x, a0, QEMU_GENERIC5(x, __VA_ARGS__))
+#define QEMU_GENERIC7(x, a0, ...) QEMU_GENERIC_IF_(x, a0, QEMU_GENERIC6(x, __VA_ARGS__))
+#define QEMU_GENERIC8(x, a0, ...) QEMU_GENERIC_IF_(x, a0, QEMU_GENERIC7(x, __VA_ARGS__))
+#define QEMU_GENERIC9(x, a0, ...) QEMU_GENERIC_IF_(x, a0, QEMU_GENERIC8(x, __VA_ARGS__))
+#define QEMU_GENERIC10(x, a0, ...) QEMU_GENERIC_IF_(x, a0, QEMU_GENERIC9(x, __VA_ARGS__))
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
index 0000000000..e280431290
--- /dev/null
+++ b/include/qemu/lockable.h
@@ -0,0 +1,75 @@
+/*
+ * Polymorphic locking functions (like templates, but in C)
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
+/* This function is used to give link-time errors if an invalid, non-NULL
+ * pointer type is passed to QEMU_MAKE_LOCKABLE.
+ */
+void unknown_lock_type(void *);
+
+/* Auxiliary macros to simplify QEMU_MAKE_LOCABLE.  */
+#define QEMU_LOCK_FUNC(x) ((QemuLockUnlockFunc *)    \
+    QEMU_GENERIC(x,                                  \
+                 (QemuMutex *, qemu_mutex_lock),     \
+                 (CoMutex *, qemu_co_mutex_lock),    \
+                 (QemuSpin *, qemu_spin_lock),       \
+                 ((x) ? unknown_lock_type : NULL)))
+
+#define QEMU_UNLOCK_FUNC(x) ((QemuLockUnlockFunc *)  \
+    QEMU_GENERIC(x,                                  \
+                 (QemuMutex *, qemu_mutex_unlock),   \
+                 (CoMutex *, qemu_co_mutex_unlock),  \
+                 (QemuSpin *, qemu_spin_unlock),     \
+                 ((x) ? unknown_lock_type : NULL)))
+
+#define QEMU_MAKE_LOCKABLE_(x) (&(QemuLockable) {    \
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
+                 (QemuLockable *, x),                \
+                 QEMU_MAKE_LOCKABLE_(x))
+
+static inline void qemu_lockable_lock(QemuLockable *x)
+{
+    x->lock(x);
+}
+
+static inline void qemu_lockable_unlock(QemuLockable *x)
+{
+    x->unlock(x);
+}
+
+#endif
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 9910f49b3a..a3bc056d89 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -4,7 +4,6 @@
 #include "qemu/processor.h"
 #include "qemu/atomic.h"
 
-typedef struct QemuMutex QemuMutex;
 typedef struct QemuCond QemuCond;
 typedef struct QemuSemaphore QemuSemaphore;
 typedef struct QemuEvent QemuEvent;
@@ -66,9 +65,9 @@ struct Notifier;
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
-- 
2.14.3
