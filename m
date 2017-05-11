Received: from eggs.gnu.org ([2001:4830:134:3::10]:42297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8pIV-0001i7-Ly
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8pIU-0004Gl-43
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:42:31 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 May 2017 16:42:00 +0200
Message-Id: <20170511144208.24075-11-pbonzini@redhat.com>
In-Reply-To: <20170511144208.24075-1-pbonzini@redhat.com>
References: <20170511144208.24075-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/18] util: add stats64 module
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

This module provides fast paths for 64-bit atomic operations on machines
that only have 32-bit atomic access.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: use CONFIG_ATOMIC64 [Paolo]
                fix compilation on 32-bit machines [patchew]
                simplify "fast" version of stat64_min/stat64_max [Paolo]
                fix typo [Roman]
                use cpu_relax [Fam]

 include/qemu/stats64.h | 193 +++++++++++++++++++++++++++++++++++++++++++++++++
 util/Makefile.objs     |   1 +
 util/stats64.c         | 136 ++++++++++++++++++++++++++++++++++
 3 files changed, 330 insertions(+)
 create mode 100644 include/qemu/stats64.h
 create mode 100644 util/stats64.c

diff --git a/include/qemu/stats64.h b/include/qemu/stats64.h
new file mode 100644
index 0000000000..f9baf9b159
--- /dev/null
+++ b/include/qemu/stats64.h
@@ -0,0 +1,193 @@
+/*
+ * Atomic operations on 64-bit quantities.
+ *
+ * Copyright (C) 2017 Red Hat, Inc.
+ *
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_STATS64_H
+#define QEMU_STATS64_H 1
+
+#include "qemu/atomic.h"
+
+/* This provides atomic operations on 64-bit type, using a reader-writer
+ * spinlock on architectures that do not have 64-bit accesses.  However
+ * it tries hard not to take the lock.
+ */
+
+typedef struct Stat64 {
+#ifdef CONFIG_ATOMIC64
+    uint64_t value;
+#else
+    uint32_t low, high;
+    uint32_t lock;
+#endif
+} Stat64;
+
+#ifdef CONFIG_ATOMIC64
+static inline void stat64_init(Stat64 *s, uint64_t value)
+{
+    /* This is not guaranteed to be atomic! */
+    *s = (Stat64) { value };
+}
+
+static inline uint64_t stat64_get(const Stat64 *s)
+{
+    return atomic_read(&s->value);
+}
+
+static inline void stat64_add(Stat64 *s, uint64_t value)
+{
+    atomic_add(&s->value, value);
+}
+
+static inline void stat64_min(Stat64 *s, uint64_t value)
+{
+    uint64_t orig = atomic_read(&s->value);
+    while (orig > value) {
+        orig = atomic_cmpxchg(&s->value, orig, value);
+    }
+}
+
+static inline void stat64_max(Stat64 *s, uint64_t value)
+{
+    uint64_t orig = atomic_read(&s->value);
+    while (orig < value) {
+        orig = atomic_cmpxchg(&s->value, orig, value);
+    }
+}
+#else
+uint64_t stat64_get(const Stat64 *s);
+bool stat64_min_slow(Stat64 *s, uint64_t value);
+bool stat64_max_slow(Stat64 *s, uint64_t value);
+bool stat64_add32_carry(Stat64 *s, uint32_t low, uint32_t high);
+
+static inline void stat64_init(Stat64 *s, uint64_t value)
+{
+    /* This is not guaranteed to be atomic! */
+    *s = (Stat64) { .low = value, .high = value >> 32, .lock = 0 };
+}
+
+static inline void stat64_add(Stat64 *s, uint64_t value)
+{
+    uint32_t low, high;
+    high = value >> 32;
+    low = (uint32_t) value;
+    if (!low) {
+        if (high) {
+            atomic_add(&s->high, high);
+        }
+        return;
+    }
+
+    for (;;) {
+        uint32_t orig = s->low;
+        uint32_t result = orig + low;
+        uint32_t old;
+
+        if (result < low || high) {
+            /* If the high part is affected, take the lock.  */
+            if (stat64_add32_carry(s, low, high)) {
+                return;
+            }
+            continue;
+        }
+
+        /* No carry, try with a 32-bit cmpxchg.  The result is independent of
+         * the high 32 bits, so it can race just fine with stat64_add32_carry
+         * and even stat64_get!
+         */
+        old = atomic_cmpxchg(&s->low, orig, result);
+        if (orig == old) {
+            return;
+        }
+    }
+}
+
+static inline void stat64_min(Stat64 *s, uint64_t value)
+{
+    uint32_t low, high;
+    uint32_t orig_low, orig_high;
+
+    high = value >> 32;
+    low = (uint32_t) value;
+    do {
+        orig_high = atomic_read(&s->high);
+        if (orig_high < high) {
+            return;
+        }
+
+        if (orig_high == high) {
+            /* High 32 bits are equal.  Read low after high, otherwise we
+             * can get a false positive (e.g. 0x1235,0x0000 changes to
+             * 0x1234,0x8000 and we read it as 0x1234,0x0000). Pairs with
+             * the write barrier in stat64_min_slow.
+             */
+            smp_rmb();
+            orig_low = atomic_read(&s->low);
+            if (orig_low <= low) {
+                return;
+            }
+
+            /* See if we were lucky and a writer raced against us.  The
+             * barrier is theoretically unnecessary, but if we remove it
+             * we may miss being lucky.
+             */
+            smp_rmb();
+            orig_high = atomic_read(&s->high);
+            if (orig_high < high) {
+                return;
+            }
+        }
+
+        /* If the value changes in any way, we have to take the lock.  */
+    } while (!stat64_min_slow(s, value));
+}
+
+static inline void stat64_max(Stat64 *s, uint64_t value)
+{
+    uint32_t low, high;
+    uint32_t orig_low, orig_high;
+
+    high = value >> 32;
+    low = (uint32_t) value;
+    do {
+        orig_high = atomic_read(&s->high);
+        if (orig_high > high) {
+            return;
+        }
+
+        if (orig_high == high) {
+            /* High 32 bits are equal.  Read low after high, otherwise we
+             * can get a false positive (e.g. 0x1234,0x8000 changes to
+             * 0x1235,0x0000 and we read it as 0x1235,0x8000). Pairs with
+             * the write barrier in stat64_max_slow.
+             */
+            smp_rmb();
+            orig_low = atomic_read(&s->low);
+            if (orig_low >= low) {
+                return;
+            }
+
+            /* See if we were lucky and a writer raced against us.  The
+             * barrier is theoretically unnecessary, but if we remove it
+             * we may miss being lucky.
+             */
+            smp_rmb();
+            orig_high = atomic_read(&s->high);
+            if (orig_high > high) {
+                return;
+            }
+        }
+
+        /* If the value changes in any way, we have to take the lock.  */
+    } while (!stat64_max_slow(s, value));
+}
+
+#endif
+
+#endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index c6205ebf86..8a333d3dd7 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -42,4 +42,5 @@ util-obj-y += log.o
 util-obj-y += qdist.o
 util-obj-y += qht.o
 util-obj-y += range.o
+util-obj-y += stats64.o
 util-obj-y += systemd.o
diff --git a/util/stats64.c b/util/stats64.c
new file mode 100644
index 0000000000..ac236e3840
--- /dev/null
+++ b/util/stats64.c
@@ -0,0 +1,136 @@
+/*
+ * Atomic operations on 64-bit quantities.
+ *
+ * Copyright (C) 2017 Red Hat, Inc.
+ *
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/atomic.h"
+#include "qemu/stats64.h"
+
+#ifndef CONFIG_ATOMIC64
+static inline void stat64_rdlock(Stat64 *s)
+{
+    /* Keep out incoming writers to avoid them starving us. */
+    atomic_add(&s->lock, 2);
+
+    /* If there is a concurrent writer, wait for it.  */
+    while (atomic_read(&s->lock) & 1) {
+        cpu_relax();
+    }
+}
+
+static inline void stat64_rdunlock(Stat64 *s)
+{
+    atomic_sub(&s->lock, 2);
+}
+
+static inline bool stat64_wrtrylock(Stat64 *s)
+{
+    return atomic_cmpxchg(&s->lock, 0, 1) == 0;
+}
+
+static inline void stat64_wrunlock(Stat64 *s)
+{
+    atomic_dec(&s->lock);
+}
+
+uint64_t stat64_get(const Stat64 *s)
+{
+    uint32_t high, low;
+
+    stat64_rdlock((Stat64 *)s);
+
+    /* 64-bit writes always take the lock, so we can read in
+     * any order.
+     */
+    high = atomic_read(&s->high);
+    low = atomic_read(&s->low);
+    stat64_rdunlock((Stat64 *)s);
+
+    return ((uint64_t)high << 32) | low;
+}
+
+bool stat64_add32_carry(Stat64 *s, uint32_t low, uint32_t high)
+{
+    uint32_t old;
+
+    if (!stat64_wrtrylock(s)) {
+        cpu_relax();
+        return false;
+    }
+
+    /* 64-bit reads always take the lock, so they don't care about the
+     * order of our update.  By updating s->low first, we can check
+     * whether we have to carry into s->high.
+     */
+    old = atomic_fetch_add(&s->low, low);
+    high += (old + low) < old;
+    atomic_add(&s->high, high);
+    stat64_wrunlock(s);
+    return true;
+}
+
+bool stat64_min_slow(Stat64 *s, uint64_t value)
+{
+    uint32_t high, low;
+    uint64_t orig;
+
+    if (!stat64_wrtrylock(s)) {
+        cpu_relax();
+        return false;
+    }
+
+    high = atomic_read(&s->high);
+    low = atomic_read(&s->low);
+
+    orig = ((uint64_t)high << 32) | low;
+    if (orig < value) {
+        /* We have to set low before high, just like stat64_min reads
+         * high before low.  The value may become higher temporarily, but
+         * stat64_get does not notice (it takes the lock) and the only ill
+         * effect on stat64_min is that the slow path may be triggered
+         * unnecessarily.
+         */
+        atomic_set(&s->low, (uint32_t)value);
+        smp_wmb();
+        atomic_set(&s->high, value >> 32);
+    }
+    stat64_wrunlock(s);
+    return true;
+}
+
+bool stat64_max_slow(Stat64 *s, uint64_t value)
+{
+    uint32_t high, low;
+    uint64_t orig;
+
+    if (!stat64_wrtrylock(s)) {
+        cpu_relax();
+        return false;
+    }
+
+    high = atomic_read(&s->high);
+    low = atomic_read(&s->low);
+
+    orig = ((uint64_t)high << 32) | low;
+    if (orig > value) {
+        /* We have to set low before high, just like stat64_max reads
+         * high before low.  The value may become lower temporarily, but
+         * stat64_get does not notice (it takes the lock) and the only ill
+         * effect on stat64_max is that the slow path may be triggered
+         * unnecessarily.
+         */
+        atomic_set(&s->low, (uint32_t)value);
+        smp_wmb();
+        atomic_set(&s->high, value >> 32);
+    }
+    stat64_wrunlock(s);
+    return true;
+}
+#endif
-- 
2.12.2
