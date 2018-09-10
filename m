Received: from eggs.gnu.org ([2001:4830:134:3::10]:40237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVjt-0003UC-6n
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVbR-0005Ie-Vo
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzVbR-0005HW-MP
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 19:27:42 -0400
Message-Id: <20180910232752.31565-3-cota@braap.org>
In-Reply-To: <20180910232752.31565-1-cota@braap.org>
References: <20180910232752.31565-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 02/12] util: add atomic64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

This introduces read/set accessors for int64_t and uint64_t.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/atomic.h | 34 ++++++++++++++++++
 util/atomic64.c       | 83 +++++++++++++++++++++++++++++++++++++++++++
 util/cacheinfo.c      |  3 ++
 util/Makefile.objs    |  1 +
 4 files changed, 121 insertions(+)
 create mode 100644 util/atomic64.c

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index 9ed39effd3..c34c2f78c4 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -450,4 +450,38 @@
     _oldn;                                                              \
 })
 
+/* Abstractions to access atomically (i.e. "once") i64/u64 variables */
+#ifdef CONFIG_ATOMIC64
+static inline int64_t atomic_read_i64(const int64_t *ptr)
+{
+    /* use __nocheck because sizeof(void *) might be < sizeof(u64) */
+    return atomic_read__nocheck(ptr);
+}
+
+static inline uint64_t atomic_read_u64(const uint64_t *ptr)
+{
+    return atomic_read__nocheck(ptr);
+}
+
+static inline void atomic_set_i64(int64_t *ptr, int64_t val)
+{
+    atomic_set__nocheck(ptr, val);
+}
+
+static inline void atomic_set_u64(uint64_t *ptr, uint64_t val)
+{
+    atomic_set__nocheck(ptr, val);
+}
+
+static inline void atomic64_init(void)
+{
+}
+#else /* !CONFIG_ATOMIC64 */
+int64_t  atomic_read_i64(const int64_t *ptr);
+uint64_t atomic_read_u64(const uint64_t *ptr);
+void atomic_set_i64(int64_t *ptr, int64_t val);
+void atomic_set_u64(uint64_t *ptr, uint64_t val);
+void atomic64_init(void);
+#endif /* !CONFIG_ATOMIC64 */
+
 #endif /* QEMU_ATOMIC_H */
diff --git a/util/atomic64.c b/util/atomic64.c
new file mode 100644
index 0000000000..b198a6c9c8
--- /dev/null
+++ b/util/atomic64.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/atomic.h"
+#include "qemu/thread.h"
+
+#ifdef CONFIG_ATOMIC64
+#error This file must only be compiled if !CONFIG_ATOMIC64
+#endif
+
+/*
+ * When !CONFIG_ATOMIC64, we serialize both reads and writes with spinlocks.
+ * We use an array of spinlocks, with padding computed at run-time based on
+ * the host's dcache line size.
+ * We point to the array with a void * to simplify the padding's computation.
+ * Each spinlock is located every lock_size bytes.
+ */
+static void *lock_array;
+static size_t lock_size;
+
+/*
+ * Systems without CONFIG_ATOMIC64 are unlikely to have many cores, so we use a
+ * small array of locks.
+ */
+#define NR_LOCKS 16
+
+static QemuSpin *addr_to_lock(const void *addr)
+{
+    uintptr_t a = (uintptr_t)addr;
+    uintptr_t idx;
+
+    idx = a >> qemu_dcache_linesize_log;
+    idx ^= (idx >> 8) ^ (idx >> 16);
+    idx &= NR_LOCKS - 1;
+    return lock_array + idx * lock_size;
+}
+
+#define GEN_READ(name, type)                    \
+    type name(const type *ptr)                  \
+    {                                           \
+        QemuSpin *lock = addr_to_lock(ptr);     \
+        type ret;                               \
+                                                \
+        qemu_spin_lock(lock);                   \
+        ret = *ptr;                             \
+        qemu_spin_unlock(lock);                 \
+        return ret;                             \
+    }
+
+GEN_READ(atomic_read_i64, int64_t)
+GEN_READ(atomic_read_u64, uint64_t)
+#undef GEN_READ
+
+#define GEN_SET(name, type)                     \
+    void name(type *ptr, type val)              \
+    {                                           \
+        QemuSpin *lock = addr_to_lock(ptr);     \
+                                                \
+        qemu_spin_lock(lock);                   \
+        *ptr = val;                             \
+        qemu_spin_unlock(lock);                 \
+    }
+
+GEN_SET(atomic_set_i64, int64_t)
+GEN_SET(atomic_set_u64, uint64_t)
+#undef GEN_SET
+
+void atomic64_init(void)
+{
+    int i;
+
+    lock_size = ROUND_UP(sizeof(QemuSpin), qemu_dcache_linesize);
+    lock_array = qemu_memalign(qemu_dcache_linesize, lock_size * NR_LOCKS);
+    for (i = 0; i < NR_LOCKS; i++) {
+        QemuSpin *lock = lock_array + i * lock_size;
+
+        qemu_spin_init(lock);
+    }
+}
diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index 57c7d58159..6c6cbdb25d 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
+#include "qemu/atomic.h"
 
 int qemu_icache_linesize = 0;
 int qemu_icache_linesize_log;
@@ -179,4 +180,6 @@ static void __attribute__((constructor)) init_cache_info(void)
     qemu_icache_linesize_log = 31 - clz32(isize);
     qemu_dcache_linesize = dsize;
     qemu_dcache_linesize_log = 31 - clz32(dsize);
+
+    atomic64_init();
 }
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 0e88899011..0820923c18 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -3,6 +3,7 @@ util-obj-y += bufferiszero.o
 util-obj-y += lockcnt.o
 util-obj-y += aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
 util-obj-y += main-loop.o iohandler.o
+util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
 util-obj-$(CONFIG_POSIX) += aio-posix.o
 util-obj-$(CONFIG_POSIX) += compatfd.o
 util-obj-$(CONFIG_POSIX) += event_notifier-posix.o
-- 
2.17.1
