Received: from eggs.gnu.org ([2001:4830:134:3::10]:33279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4T-0001mC-TF
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4K-0006Vp-G5
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4A-0005u1-OB
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id v90-v6so13315608wrc.0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:50 +0200
Message-Id: <1534870966-9287-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/74] qsp: QEMU's Synchronization Profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

The goal of this module is to profile synchronization primitives (i.e.
mutexes, recursive mutexes and condition variables) so that scalability
issues can be quickly diagnosed.

Sync primitives are profiled by QSP based on the vaddr of the object accessed
as well as the call site (file:line_nr). That means the same object called
from two different call sites will be tracked in separate entries, which
might be reported together or separately (see subsequent commit on
call site coalescing).

Some perf numbers:

Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
Command: taskset -c 0 tests/atomic_add-bench -d 5 -m

- Before: 54.80 Mops/s
- After:  54.75 Mops/s

That is, a negligible slowdown due to the now indirect call to
qemu_mutex_lock. Note that using a branch instead of an indirect
call introduces a more severe slowdown (53.65 Mops/s, i.e. 2% slowdown).

Enabling the profiler (with -p, added in this series) is more interesting:

- No profiling: 54.75 Mops/s
- W/ profiling: 12.53 Mops/s

That is, a 4.36X slowdown.

We can break down this slowdown by removing the get_clock calls or
the entry lookup:

- No profiling:     54.75 Mops/s
- W/o get_clock:    25.37 Mops/s
- W/o entry lookup: 19.30 Mops/s
- W/ profiling:     12.53 Mops/s

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/qht.h          |   1 +
 include/qemu/qsp.h          |  22 ++
 include/qemu/thread-posix.h |   4 +-
 include/qemu/thread-win32.h |   5 +-
 include/qemu/thread.h       |  65 ++++-
 util/Makefile.objs          |   1 +
 util/qemu-thread-win32.c    |   4 +-
 util/qht.c                  |  47 +++-
 util/qsp.c                  | 633 ++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 759 insertions(+), 23 deletions(-)
 create mode 100644 include/qemu/qsp.h
 create mode 100644 util/qsp.c

diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index 1fb9116..c9a11cc 100644
--- a/include/qemu/qht.h
+++ b/include/qemu/qht.h
@@ -46,6 +46,7 @@ typedef bool (*qht_lookup_func_t)(const void *obj, const void *userp);
 typedef void (*qht_iter_func_t)(struct qht *ht, void *p, uint32_t h, void *up);
 
 #define QHT_MODE_AUTO_RESIZE 0x1 /* auto-resize when heavily loaded */
+#define QHT_MODE_RAW_MUTEXES 0x2 /* bypass the profiler (QSP) */
 
 /**
  * qht_init - Initialize a QHT
diff --git a/include/qemu/qsp.h b/include/qemu/qsp.h
new file mode 100644
index 0000000..9c2bb60
--- /dev/null
+++ b/include/qemu/qsp.h
@@ -0,0 +1,22 @@
+/*
+ * qsp.c - QEMU Synchronization Profiler
+ *
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * Note: this header file can *only* be included from thread.h.
+ */
+#ifndef QEMU_QSP_H
+#define QEMU_QSP_H
+
+#include "qemu/fprintf-fn.h"
+
+void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max);
+
+bool qsp_is_enabled(void);
+void qsp_enable(void);
+void qsp_disable(void);
+
+#endif /* QEMU_QSP_H */
diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index fd27b34..c903525 100644
--- a/include/qemu/thread-posix.h
+++ b/include/qemu/thread-posix.h
@@ -6,8 +6,8 @@
 
 typedef QemuMutex QemuRecMutex;
 #define qemu_rec_mutex_destroy qemu_mutex_destroy
-#define qemu_rec_mutex_lock qemu_mutex_lock
-#define qemu_rec_mutex_trylock qemu_mutex_trylock
+#define qemu_rec_mutex_lock_impl    qemu_mutex_lock_impl
+#define qemu_rec_mutex_trylock_impl qemu_mutex_trylock_impl
 #define qemu_rec_mutex_unlock qemu_mutex_unlock
 
 struct QemuMutex {
diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
index d668d78..50af5dd 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -19,8 +19,9 @@ struct QemuRecMutex {
 };
 
 void qemu_rec_mutex_destroy(QemuRecMutex *mutex);
-void qemu_rec_mutex_lock(QemuRecMutex *mutex);
-int qemu_rec_mutex_trylock(QemuRecMutex *mutex);
+void qemu_rec_mutex_lock_impl(QemuRecMutex *mutex, const char *file, int line);
+int qemu_rec_mutex_trylock_impl(QemuRecMutex *mutex, const char *file,
+                                int line);
 void qemu_rec_mutex_unlock(QemuRecMutex *mutex);
 
 struct QemuCond {
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index ef7bd16..c90ea47 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -16,6 +16,9 @@ typedef struct QemuThread QemuThread;
 #include "qemu/thread-posix.h"
 #endif
 
+/* include QSP header once QemuMutex, QemuCond etc. are defined */
+#include "qemu/qsp.h"
+
 #define QEMU_THREAD_JOINABLE 0
 #define QEMU_THREAD_DETACHED 1
 
@@ -25,10 +28,51 @@ int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line);
 void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line);
 void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line);
 
-#define qemu_mutex_lock(mutex) \
-        qemu_mutex_lock_impl(mutex, __FILE__, __LINE__)
-#define qemu_mutex_trylock(mutex) \
-        qemu_mutex_trylock_impl(mutex, __FILE__, __LINE__)
+typedef void (*QemuMutexLockFunc)(QemuMutex *m, const char *f, int l);
+typedef int (*QemuMutexTrylockFunc)(QemuMutex *m, const char *f, int l);
+typedef void (*QemuRecMutexLockFunc)(QemuRecMutex *m, const char *f, int l);
+typedef int (*QemuRecMutexTrylockFunc)(QemuRecMutex *m, const char *f, int l);
+typedef void (*QemuCondWaitFunc)(QemuCond *c, QemuMutex *m, const char *f,
+                                 int l);
+
+extern QemuMutexLockFunc qemu_mutex_lock_func;
+extern QemuMutexTrylockFunc qemu_mutex_trylock_func;
+extern QemuRecMutexLockFunc qemu_rec_mutex_lock_func;
+extern QemuRecMutexTrylockFunc qemu_rec_mutex_trylock_func;
+extern QemuCondWaitFunc qemu_cond_wait_func;
+
+/* convenience macros to bypass the profiler */
+#define qemu_mutex_lock__raw(m)                         \
+        qemu_mutex_lock_impl(m, __FILE__, __LINE__)
+#define qemu_mutex_trylock__raw(m)                      \
+        qemu_mutex_trylock_impl(m, __FILE__, __LINE__)
+
+#define qemu_mutex_lock(m) ({                                           \
+            QemuMutexLockFunc _f = atomic_read(&qemu_mutex_lock_func);  \
+            _f(m, __FILE__, __LINE__);                                  \
+        })
+
+#define qemu_mutex_trylock(m) ({                                        \
+            QemuMutexTrylockFunc _f = atomic_read(&qemu_mutex_trylock_func); \
+            _f(m, __FILE__, __LINE__);                                  \
+        })
+
+#define qemu_rec_mutex_lock(m) ({                                       \
+            QemuRecMutexLockFunc _f = atomic_read(&qemu_rec_mutex_lock_func); \
+            _f(m, __FILE__, __LINE__);                                  \
+        })
+
+#define qemu_rec_mutex_trylock(m) ({                            \
+            QemuRecMutexTrylockFunc _f;                         \
+            _f = atomic_read(&qemu_rec_mutex_trylock_func);     \
+            _f(m, __FILE__, __LINE__);                          \
+        })
+
+#define qemu_cond_wait(c, m) ({                                         \
+            QemuCondWaitFunc _f = atomic_read(&qemu_cond_wait_func);    \
+            _f(c, m, __FILE__, __LINE__);                               \
+        })
+
 #define qemu_mutex_unlock(mutex) \
         qemu_mutex_unlock_impl(mutex, __FILE__, __LINE__)
 
@@ -47,6 +91,16 @@ static inline void (qemu_mutex_unlock)(QemuMutex *mutex)
     qemu_mutex_unlock(mutex);
 }
 
+static inline void (qemu_rec_mutex_lock)(QemuRecMutex *mutex)
+{
+    qemu_rec_mutex_lock(mutex);
+}
+
+static inline int (qemu_rec_mutex_trylock)(QemuRecMutex *mutex)
+{
+    return qemu_rec_mutex_trylock(mutex);
+}
+
 /* Prototypes for other functions are in thread-posix.h/thread-win32.h.  */
 void qemu_rec_mutex_init(QemuRecMutex *mutex);
 
@@ -63,9 +117,6 @@ void qemu_cond_broadcast(QemuCond *cond);
 void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex,
                          const char *file, const int line);
 
-#define qemu_cond_wait(cond, mutex) \
-        qemu_cond_wait_impl(cond, mutex, __FILE__, __LINE__)
-
 static inline void (qemu_cond_wait)(QemuCond *cond, QemuMutex *mutex)
 {
     qemu_cond_wait(cond, mutex);
diff --git a/util/Makefile.objs b/util/Makefile.objs
index e1c3fed..e958116 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -44,6 +44,7 @@ util-obj-y += log.o
 util-obj-y += pagesize.o
 util-obj-y += qdist.o
 util-obj-y += qht.o
+util-obj-y += qsp.o
 util-obj-y += range.o
 util-obj-y += stats64.o
 util-obj-y += systemd.o
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index b303188..4a363ca 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -97,13 +97,13 @@ void qemu_rec_mutex_destroy(QemuRecMutex *mutex)
     DeleteCriticalSection(&mutex->lock);
 }
 
-void qemu_rec_mutex_lock(QemuRecMutex *mutex)
+void qemu_rec_mutex_lock_impl(QemuRecMutex *mutex, const char *file, int line)
 {
     assert(mutex->initialized);
     EnterCriticalSection(&mutex->lock);
 }
 
-int qemu_rec_mutex_trylock(QemuRecMutex *mutex)
+int qemu_rec_mutex_trylock_impl(QemuRecMutex *mutex, const char *file, int line)
 {
     assert(mutex->initialized);
     return !TryEnterCriticalSection(&mutex->lock);
diff --git a/util/qht.c b/util/qht.c
index c138777..1e3a072 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -90,6 +90,33 @@
 #endif
 
 /*
+ * Do _not_ use qemu_mutex_[try]lock directly! Use these macros, otherwise
+ * the profiler (QSP) will deadlock.
+ */
+static inline void qht_lock(struct qht *ht)
+{
+    if (ht->mode & QHT_MODE_RAW_MUTEXES) {
+        qemu_mutex_lock__raw(&ht->lock);
+    } else {
+        qemu_mutex_lock(&ht->lock);
+    }
+}
+
+static inline int qht_trylock(struct qht *ht)
+{
+    if (ht->mode & QHT_MODE_RAW_MUTEXES) {
+        return qemu_mutex_trylock__raw(&(ht)->lock);
+    }
+    return qemu_mutex_trylock(&(ht)->lock);
+}
+
+/* this inline is not really necessary, but it helps keep code consistent */
+static inline void qht_unlock(struct qht *ht)
+{
+    qemu_mutex_unlock(&ht->lock);
+}
+
+/*
  * Note: reading partially-updated pointers in @pointers could lead to
  * segfaults. We thus access them with atomic_read/set; this guarantees
  * that the compiler makes all those accesses atomic. We also need the
@@ -254,10 +281,10 @@ void qht_map_lock_buckets__no_stale(struct qht *ht, struct qht_map **pmap)
     qht_map_unlock_buckets(map);
 
     /* we raced with a resize; acquire ht->lock to see the updated ht->map */
-    qemu_mutex_lock(&ht->lock);
+    qht_lock(ht);
     map = ht->map;
     qht_map_lock_buckets(map);
-    qemu_mutex_unlock(&ht->lock);
+    qht_unlock(ht);
     *pmap = map;
     return;
 }
@@ -288,11 +315,11 @@ struct qht_bucket *qht_bucket_lock__no_stale(struct qht *ht, uint32_t hash,
     qemu_spin_unlock(&b->lock);
 
     /* we raced with a resize; acquire ht->lock to see the updated ht->map */
-    qemu_mutex_lock(&ht->lock);
+    qht_lock(ht);
     map = ht->map;
     b = qht_map_to_bucket(map, hash);
     qemu_spin_lock(&b->lock);
-    qemu_mutex_unlock(&ht->lock);
+    qht_unlock(ht);
     *pmap = map;
     return b;
 }
@@ -430,13 +457,13 @@ bool qht_reset_size(struct qht *ht, size_t n_elems)
 
     n_buckets = qht_elems_to_buckets(n_elems);
 
-    qemu_mutex_lock(&ht->lock);
+    qht_lock(ht);
     map = ht->map;
     if (n_buckets != map->n_buckets) {
         new = qht_map_create(n_buckets);
     }
     qht_do_resize_and_reset(ht, new);
-    qemu_mutex_unlock(&ht->lock);
+    qht_unlock(ht);
 
     return !!new;
 }
@@ -565,7 +592,7 @@ static __attribute__((noinline)) void qht_grow_maybe(struct qht *ht)
      * If the lock is taken it probably means there's an ongoing resize,
      * so bail out.
      */
-    if (qemu_mutex_trylock(&ht->lock)) {
+    if (qht_trylock(ht)) {
         return;
     }
     map = ht->map;
@@ -575,7 +602,7 @@ static __attribute__((noinline)) void qht_grow_maybe(struct qht *ht)
 
         qht_do_resize(ht, new);
     }
-    qemu_mutex_unlock(&ht->lock);
+    qht_unlock(ht);
 }
 
 bool qht_insert(struct qht *ht, void *p, uint32_t hash, void **existing)
@@ -788,7 +815,7 @@ bool qht_resize(struct qht *ht, size_t n_elems)
     size_t n_buckets = qht_elems_to_buckets(n_elems);
     size_t ret = false;
 
-    qemu_mutex_lock(&ht->lock);
+    qht_lock(ht);
     if (n_buckets != ht->map->n_buckets) {
         struct qht_map *new;
 
@@ -796,7 +823,7 @@ bool qht_resize(struct qht *ht, size_t n_elems)
         qht_do_resize(ht, new);
         ret = true;
     }
-    qemu_mutex_unlock(&ht->lock);
+    qht_unlock(ht);
 
     return ret;
 }
diff --git a/util/qsp.c b/util/qsp.c
new file mode 100644
index 0000000..c5fce4b
--- /dev/null
+++ b/util/qsp.c
@@ -0,0 +1,633 @@
+/*
+ * qsp.c - QEMU Synchronization Profiler
+ *
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * QSP profiles the time spent in synchronization primitives, which can
+ * help diagnose performance problems, e.g. scalability issues when
+ * contention is high.
+ *
+ * The primitives currently supported are mutexes, recursive mutexes and
+ * condition variables. Note that not all related functions are intercepted;
+ * instead we profile only those functions that can have a performance impact,
+ * either due to blocking (e.g. cond_wait, mutex_lock) or cache line
+ * contention (e.g. mutex_lock, mutex_trylock).
+ *
+ * QSP's design focuses on speed and scalability. This is achieved
+ * by having threads do their profiling entirely on thread-local data.
+ * The appropriate thread-local data is found via a QHT, i.e. a concurrent hash
+ * table. To aggregate data in order to generate a report, we iterate over
+ * all entries in the hash table. Depending on the number of threads and
+ * synchronization objects this might be expensive, but note that it is
+ * very rarely called -- reports are generated only when requested by users.
+ *
+ * Reports are generated as a table where each row represents a call site. A
+ * call site is the triplet formed by the __file__ and __LINE__ of the caller
+ * as well as the address of the "object" (i.e. mutex, rec. mutex or condvar)
+ * being operated on. Focusing on call sites instead of just on objects might
+ * seem puzzling. However, it is a sensible choice since otherwise dealing with
+ * dynamically-allocated objects becomes difficult (e.g. what to do when an
+ * object is destroyed, or reused?). Furthermore, the call site info is of most
+ * importance, since it is callers, and not objects, what cause wait time.
+ *
+ * Alternative designs considered:
+ *
+ * - Use an off-the-shelf profiler such as mutrace. This is not a viable option
+ *   for us because QEMU has __malloc_hook set (by one of the libraries it
+ *   uses); leaving this hook unset is required to avoid deadlock in mutrace.
+ *
+ * - Use a glib HT for each thread, protecting each HT with its own lock.
+ *   This isn't simpler than the current design, and is 10% slower in the
+ *   atomic_add-bench microbenchmark (-m option).
+ *
+ * - For reports, just use a binary tree as we aggregate data, instead of having
+ *   an intermediate hash table. This would simplify the code only slightly, but
+ *   would perform badly if there were many threads and objects to track.
+ *
+ * Related Work:
+ * - Lennart Poettering's mutrace: http://0pointer.de/blog/projects/mutrace.html
+ * - Lozi, David, Thomas, Lawall and Muller. "Remote Core Locking: Migrating
+ *   Critical-Section Execution to Improve the Performance of Multithreaded
+ *   Applications", USENIX ATC'12.
+ */
+#include "qemu/osdep.h"
+#include "qemu/thread.h"
+#include "qemu/timer.h"
+#include "qemu/qht.h"
+#include "exec/tb-hash-xx.h"
+
+enum QSPType {
+    QSP_MUTEX,
+    QSP_REC_MUTEX,
+    QSP_CONDVAR,
+};
+
+struct QSPCallSite {
+    const void *obj;
+    const char *file; /* i.e. __FILE__; shortened later */
+    int line;
+    enum QSPType type;
+};
+typedef struct QSPCallSite QSPCallSite;
+
+struct QSPEntry {
+    void *thread_ptr;
+    const QSPCallSite *callsite;
+    uint64_t n_acqs;
+    uint64_t ns;
+#ifndef CONFIG_ATOMIC64
+    /*
+     * If we cannot update the counts atomically, then use a seqlock.
+     * We don't need an associated lock because the updates are thread-local.
+     */
+    QemuSeqLock sequence;
+#endif
+};
+typedef struct QSPEntry QSPEntry;
+
+/* initial sizing for hash tables */
+#define QSP_INITIAL_SIZE 64
+
+/* If this file is moved, QSP_REL_PATH should be updated accordingly */
+#define QSP_REL_PATH "util/qsp.c"
+
+/* this file's full path. Used to present all call sites with relative paths */
+static size_t qsp_qemu_path_len;
+
+/* the address of qsp_thread gives us a unique 'thread ID' */
+static __thread int qsp_thread;
+
+/*
+ * Call sites are the same for all threads, so we track them in a separate hash
+ * table to save memory.
+ */
+static struct qht qsp_callsite_ht;
+
+static struct qht qsp_ht;
+static bool qsp_initialized, qsp_initializing;
+
+static const char * const qsp_typenames[] = {
+    [QSP_MUTEX]     = "mutex",
+    [QSP_REC_MUTEX] = "rec_mutex",
+    [QSP_CONDVAR]   = "condvar",
+};
+
+QemuMutexLockFunc qemu_mutex_lock_func = qemu_mutex_lock_impl;
+QemuMutexTrylockFunc qemu_mutex_trylock_func = qemu_mutex_trylock_impl;
+QemuRecMutexLockFunc qemu_rec_mutex_lock_func = qemu_rec_mutex_lock_impl;
+QemuRecMutexTrylockFunc qemu_rec_mutex_trylock_func =
+    qemu_rec_mutex_trylock_impl;
+QemuCondWaitFunc qemu_cond_wait_func = qemu_cond_wait_impl;
+
+/*
+ * It pays off to _not_ hash callsite->file; hashing a string is slow, and
+ * without it we still get a pretty unique hash.
+ */
+static inline
+uint32_t do_qsp_callsite_hash(const QSPCallSite *callsite, uint64_t a)
+{
+    uint64_t b = (uint64_t)(uintptr_t)callsite->obj;
+    uint32_t e = callsite->line;
+    uint32_t f = callsite->type;
+
+    return tb_hash_func7(a, b, e, f, 0);
+}
+
+static inline
+uint32_t qsp_callsite_hash(const QSPCallSite *callsite)
+{
+    return do_qsp_callsite_hash(callsite, 0);
+}
+
+static inline uint32_t do_qsp_entry_hash(const QSPEntry *entry, uint64_t a)
+{
+    return do_qsp_callsite_hash(entry->callsite, a);
+}
+
+static uint32_t qsp_entry_hash(const QSPEntry *entry)
+{
+    return do_qsp_entry_hash(entry, (uint64_t)(uintptr_t)entry->thread_ptr);
+}
+
+static uint32_t qsp_entry_no_thread_hash(const QSPEntry *entry)
+{
+    return do_qsp_entry_hash(entry, 0);
+}
+
+static bool qsp_callsite_cmp(const void *ap, const void *bp)
+{
+    const QSPCallSite *a = ap;
+    const QSPCallSite *b = bp;
+
+    return a == b ||
+        (a->obj == b->obj &&
+         a->line == b->line &&
+         a->type == b->type &&
+         (a->file == b->file || !strcmp(a->file, b->file)));
+}
+
+static bool qsp_entry_no_thread_cmp(const void *ap, const void *bp)
+{
+    const QSPEntry *a = ap;
+    const QSPEntry *b = bp;
+
+    return qsp_callsite_cmp(a->callsite, b->callsite);
+}
+
+static bool qsp_entry_cmp(const void *ap, const void *bp)
+{
+    const QSPEntry *a = ap;
+    const QSPEntry *b = bp;
+
+    return a->thread_ptr == b->thread_ptr &&
+        qsp_callsite_cmp(a->callsite, b->callsite);
+}
+
+/*
+ * Normally we'd call this from a constructor function, but we want it to work
+ * via libutil as well.
+ */
+static void qsp_do_init(void)
+{
+    /* make sure this file's path in the tree is up to date with QSP_REL_PATH */
+    g_assert(strstr(__FILE__, QSP_REL_PATH));
+    qsp_qemu_path_len = strlen(__FILE__) - strlen(QSP_REL_PATH);
+
+    qht_init(&qsp_ht, qsp_entry_cmp, QSP_INITIAL_SIZE,
+             QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
+    qht_init(&qsp_callsite_ht, qsp_callsite_cmp, QSP_INITIAL_SIZE,
+             QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
+}
+
+static __attribute__((noinline)) void qsp_init__slowpath(void)
+{
+    if (atomic_cmpxchg(&qsp_initializing, false, true) == false) {
+        qsp_do_init();
+        atomic_set(&qsp_initialized, true);
+    } else {
+        while (!atomic_read(&qsp_initialized)) {
+            cpu_relax();
+        }
+    }
+}
+
+/* qsp_init() must be called from _all_ exported functions */
+static inline void qsp_init(void)
+{
+    if (likely(atomic_read(&qsp_initialized))) {
+        return;
+    }
+    qsp_init__slowpath();
+}
+
+static QSPCallSite *qsp_callsite_find(const QSPCallSite *orig)
+{
+    QSPCallSite *callsite;
+    uint32_t hash;
+
+    hash = qsp_callsite_hash(orig);
+    callsite = qht_lookup(&qsp_callsite_ht, orig, hash);
+    if (callsite == NULL) {
+        void *existing = NULL;
+
+        callsite = g_new(QSPCallSite, 1);
+        memcpy(callsite, orig, sizeof(*callsite));
+        qht_insert(&qsp_callsite_ht, callsite, hash, &existing);
+        if (unlikely(existing)) {
+            g_free(callsite);
+            callsite = existing;
+        }
+    }
+    return callsite;
+}
+
+static QSPEntry *
+qsp_entry_create(struct qht *ht, const QSPEntry *entry, uint32_t hash)
+{
+    QSPEntry *e;
+    void *existing = NULL;
+
+    e = g_new0(QSPEntry, 1);
+    e->thread_ptr = entry->thread_ptr;
+    e->callsite = qsp_callsite_find(entry->callsite);
+
+    qht_insert(ht, e, hash, &existing);
+    if (unlikely(existing)) {
+        g_free(e);
+        e = existing;
+    }
+    return e;
+}
+
+static QSPEntry *
+qsp_entry_find(struct qht *ht, const QSPEntry *entry, uint32_t hash)
+{
+    QSPEntry *e;
+
+    e = qht_lookup(ht, entry, hash);
+    if (e == NULL) {
+        e = qsp_entry_create(ht, entry, hash);
+    }
+    return e;
+}
+
+/*
+ * Note: Entries are never removed, so callers do not have to be in an RCU
+ * read-side critical section.
+ */
+static QSPEntry *qsp_entry_get(const void *obj, const char *file, int line,
+                               enum QSPType type)
+{
+    QSPCallSite callsite = {
+        .obj = obj,
+        .file = file,
+        .line = line,
+        .type = type,
+    };
+    QSPEntry orig;
+    uint32_t hash;
+
+    qsp_init();
+
+    orig.thread_ptr = &qsp_thread;
+    orig.callsite = &callsite;
+
+    hash = qsp_entry_hash(&orig);
+    return qsp_entry_find(&qsp_ht, &orig, hash);
+}
+
+/*
+ * @from is in the global hash table; read it atomically if the host
+ * supports it, otherwise use the seqlock.
+ */
+static void qsp_entry_aggregate(QSPEntry *to, const QSPEntry *from)
+{
+#ifdef CONFIG_ATOMIC64
+    to->ns += atomic_read__nocheck(&from->ns);
+    to->n_acqs += atomic_read__nocheck(&from->n_acqs);
+#else
+    unsigned int version;
+    uint64_t ns, n_acqs;
+
+    do {
+        version = seqlock_read_begin(&from->sequence);
+        ns = atomic_read__nocheck(&from->ns);
+        n_acqs = atomic_read__nocheck(&from->n_acqs);
+    } while (seqlock_read_retry(&from->sequence, version));
+
+    to->ns += ns;
+    to->n_acqs += n_acqs;
+#endif
+}
+
+/*
+ * @e is in the global hash table; it is only written to by the current thread,
+ * so we write to it atomically (as in "write once") to prevent torn reads.
+ * If the host doesn't support u64 atomics, use the seqlock.
+ */
+static inline void do_qsp_entry_record(QSPEntry *e, int64_t delta, bool acq)
+{
+#ifndef CONFIG_ATOMIC64
+    seqlock_write_begin(&e->sequence);
+#endif
+    atomic_set__nocheck(&e->ns, e->ns + delta);
+    if (acq) {
+        atomic_set__nocheck(&e->n_acqs, e->n_acqs + 1);
+    }
+#ifndef CONFIG_ATOMIC64
+    seqlock_write_end(&e->sequence);
+#endif
+}
+
+static inline void qsp_entry_record(QSPEntry *e, int64_t delta)
+{
+    do_qsp_entry_record(e, delta, true);
+}
+
+#define QSP_GEN_VOID(type_, qsp_t_, func_, impl_)                       \
+    static void func_(type_ *obj, const char *file, int line)           \
+    {                                                                   \
+        QSPEntry *e;                                                    \
+        int64_t t0, t1;                                                 \
+                                                                        \
+        t0 = get_clock();                                               \
+        impl_(obj, file, line);                                         \
+        t1 = get_clock();                                               \
+                                                                        \
+        e = qsp_entry_get(obj, file, line, qsp_t_);                     \
+        qsp_entry_record(e, t1 - t0);                                   \
+    }
+
+#define QSP_GEN_RET1(type_, qsp_t_, func_, impl_)                       \
+    static int func_(type_ *obj, const char *file, int line)            \
+    {                                                                   \
+        QSPEntry *e;                                                    \
+        int64_t t0, t1;                                                 \
+        int err;                                                        \
+                                                                        \
+        t0 = get_clock();                                               \
+        err = impl_(obj, file, line);                                   \
+        t1 = get_clock();                                               \
+                                                                        \
+        e = qsp_entry_get(obj, file, line, qsp_t_);                     \
+        do_qsp_entry_record(e, t1 - t0, !err);                          \
+        return err;                                                     \
+    }
+
+QSP_GEN_VOID(QemuMutex, QSP_MUTEX, qsp_mutex_lock, qemu_mutex_lock_impl)
+QSP_GEN_RET1(QemuMutex, QSP_MUTEX, qsp_mutex_trylock, qemu_mutex_trylock_impl)
+
+QSP_GEN_VOID(QemuRecMutex, QSP_REC_MUTEX, qsp_rec_mutex_lock,
+             qemu_rec_mutex_lock_impl)
+QSP_GEN_RET1(QemuRecMutex, QSP_REC_MUTEX, qsp_rec_mutex_trylock,
+             qemu_rec_mutex_trylock_impl)
+
+#undef QSP_GEN_RET1
+#undef QSP_GEN_VOID
+
+static void
+qsp_cond_wait(QemuCond *cond, QemuMutex *mutex, const char *file, int line)
+{
+    QSPEntry *e;
+    int64_t t0, t1;
+
+    t0 = get_clock();
+    qemu_cond_wait_impl(cond, mutex, file, line);
+    t1 = get_clock();
+
+    e = qsp_entry_get(cond, file, line, QSP_CONDVAR);
+    qsp_entry_record(e, t1 - t0);
+}
+
+bool qsp_is_enabled(void)
+{
+    return atomic_read(&qemu_mutex_lock_func) == qsp_mutex_lock;
+}
+
+void qsp_enable(void)
+{
+    atomic_set(&qemu_mutex_lock_func, qsp_mutex_lock);
+    atomic_set(&qemu_mutex_trylock_func, qsp_mutex_trylock);
+    atomic_set(&qemu_rec_mutex_lock_func, qsp_rec_mutex_lock);
+    atomic_set(&qemu_rec_mutex_trylock_func, qsp_rec_mutex_trylock);
+    atomic_set(&qemu_cond_wait_func, qsp_cond_wait);
+}
+
+void qsp_disable(void)
+{
+    atomic_set(&qemu_mutex_lock_func, qemu_mutex_lock_impl);
+    atomic_set(&qemu_mutex_trylock_func, qemu_mutex_trylock_impl);
+    atomic_set(&qemu_rec_mutex_lock_func, qemu_rec_mutex_lock_impl);
+    atomic_set(&qemu_rec_mutex_trylock_func, qemu_rec_mutex_trylock_impl);
+    atomic_set(&qemu_cond_wait_func, qemu_cond_wait_impl);
+}
+
+static gint qsp_tree_cmp(gconstpointer ap, gconstpointer bp, gpointer up)
+{
+    const QSPEntry *a = ap;
+    const QSPEntry *b = bp;
+    const QSPCallSite *ca;
+    const QSPCallSite *cb;
+
+    if (a->ns > b->ns) {
+        return -1;
+    } else if (a->ns < b->ns) {
+        return 1;
+    }
+    ca = a->callsite;
+    cb = b->callsite;
+    /* Break the tie with the object's address */
+    if (ca->obj < cb->obj) {
+        return -1;
+    } else if (ca->obj > cb->obj) {
+        return 1;
+    } else {
+        int cmp;
+
+        /* same obj. Break the tie with the callsite's file */
+        cmp = strcmp(ca->file, cb->file);
+        if (cmp) {
+            return cmp;
+        }
+        /* same callsite file. Break the tie with the callsite's line */
+        g_assert(ca->line != cb->line);
+        if (ca->line < cb->line) {
+            return -1;
+        } else if (ca->line > cb->line) {
+            return 1;
+        } else {
+            /* break the tie with the callsite's type */
+            return cb->type - ca->type;
+        }
+    }
+}
+
+static void qsp_sort(struct qht *ht, void *p, uint32_t h, void *userp)
+{
+    QSPEntry *e = p;
+    GTree *tree = userp;
+
+    g_tree_insert(tree, e, NULL);
+}
+
+static void qsp_aggregate(struct qht *global_ht, void *p, uint32_t h, void *up)
+{
+    struct qht *ht = up;
+    const QSPEntry *e = p;
+    QSPEntry *agg;
+    uint32_t hash;
+
+    hash = qsp_entry_no_thread_hash(e);
+    agg = qsp_entry_find(ht, e, hash);
+    qsp_entry_aggregate(agg, e);
+}
+
+static void qsp_mktree(GTree *tree)
+{
+    struct qht ht;
+
+    /* Aggregate all results from the global hash table into a local one */
+    qht_init(&ht, qsp_entry_no_thread_cmp, QSP_INITIAL_SIZE,
+             QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
+    qht_iter(&qsp_ht, qsp_aggregate, &ht);
+
+    /* sort the hash table elements by using a tree */
+    qht_iter(&ht, qsp_sort, tree);
+
+    /* free the hash table, but keep the elements (those are in the tree now) */
+    qht_destroy(&ht);
+}
+
+/* free string with g_free */
+static char *qsp_at(const QSPCallSite *callsite)
+{
+    GString *s = g_string_new(NULL);
+    const char *shortened;
+
+    /* remove the absolute path to qemu */
+    if (unlikely(strlen(callsite->file) < qsp_qemu_path_len)) {
+        shortened = callsite->file;
+    } else {
+        shortened = callsite->file + qsp_qemu_path_len;
+    }
+    g_string_append_printf(s, "%s:%u", shortened, callsite->line);
+    return g_string_free(s, FALSE);
+}
+
+struct QSPReportEntry {
+    const void *obj;
+    char *callsite_at;
+    const char *typename;
+    double time_s;
+    double ns_avg;
+    uint64_t n_acqs;
+};
+typedef struct QSPReportEntry QSPReportEntry;
+
+struct QSPReport {
+    QSPReportEntry *entries;
+    size_t n_entries;
+    size_t max_n_entries;
+};
+typedef struct QSPReport QSPReport;
+
+static gboolean qsp_tree_report(gpointer key, gpointer value, gpointer udata)
+{
+    const QSPEntry *e = key;
+    QSPReport *report = udata;
+    QSPReportEntry *entry;
+
+    if (report->n_entries == report->max_n_entries) {
+        return TRUE;
+    }
+    entry = &report->entries[report->n_entries];
+    report->n_entries++;
+
+    entry->obj = e->callsite->obj;
+    entry->callsite_at = qsp_at(e->callsite);
+    entry->typename = qsp_typenames[e->callsite->type];
+    entry->time_s = e->ns * 1e-9;
+    entry->n_acqs = e->n_acqs;
+    entry->ns_avg = e->n_acqs ? e->ns / e->n_acqs : 0;
+    return FALSE;
+}
+
+static void
+pr_report(const QSPReport *rep, FILE *f, fprintf_function pr)
+{
+    char *dashes;
+    size_t max_len = 0;
+    int callsite_len = 0;
+    int callsite_rspace;
+    int n_dashes;
+    size_t i;
+
+    /* find out the maximum length of all 'callsite' fields */
+    for (i = 0; i < rep->n_entries; i++) {
+        const QSPReportEntry *e = &rep->entries[i];
+        size_t len = strlen(e->callsite_at);
+
+        if (len > max_len) {
+            max_len = len;
+        }
+    }
+
+    callsite_len = MAX(max_len, strlen("Call site"));
+    /* white space to leave to the right of "Call site" */
+    callsite_rspace = callsite_len - strlen("Call site");
+
+    pr(f, "Type               Object  Call site%*s  Wait Time (s)  "
+       "       Count  Average (us)\n", callsite_rspace, "");
+
+    /* build a horizontal rule with dashes */
+    n_dashes = 79 + callsite_rspace;
+    dashes = g_malloc(n_dashes + 1);
+    memset(dashes, '-', n_dashes);
+    dashes[n_dashes] = '\0';
+    pr(f, "%s\n", dashes);
+
+    for (i = 0; i < rep->n_entries; i++) {
+        const QSPReportEntry *e = &rep->entries[i];
+
+        pr(f, "%-9s  %14p  %s%*s  %13.5f  %12" PRIu64 "  %12.2f\n", e->typename,
+           e->obj, e->callsite_at, callsite_len - (int)strlen(e->callsite_at),
+           "", e->time_s, e->n_acqs, e->ns_avg * 1e-3);
+    }
+
+    pr(f, "%s\n", dashes);
+    g_free(dashes);
+}
+
+static void report_destroy(QSPReport *rep)
+{
+    size_t i;
+
+    for (i = 0; i < rep->n_entries; i++) {
+        QSPReportEntry *e = &rep->entries[i];
+
+        g_free(e->callsite_at);
+    }
+    g_free(rep->entries);
+}
+
+void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max)
+{
+    GTree *tree = g_tree_new_full(qsp_tree_cmp, NULL, g_free, NULL);
+    QSPReport rep;
+
+    qsp_init();
+
+    rep.entries = g_new0(QSPReportEntry, max);
+    rep.n_entries = 0;
+    rep.max_n_entries = max;
+
+    qsp_mktree(tree);
+    g_tree_foreach(tree, qsp_tree_report, &rep);
+    g_tree_destroy(tree);
+
+    pr_report(&rep, f, cpu_fprintf);
+    report_destroy(&rep);
+}
-- 
1.8.3.1
