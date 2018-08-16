Received: from eggs.gnu.org ([2001:4830:134:3::10]:50451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fq8RB-0002IW-5e
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fq8R7-0006i2-RW
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:55:01 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fq8R7-0006hX-HQ
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:54:57 -0400
Received: by mail-pf1-x443.google.com with SMTP id e13-v6so1330792pff.7
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 19:54:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 15 Aug 2018 19:54:48 -0700
Message-Id: <20180816025452.21358-2-richard.henderson@linaro.org>
In-Reply-To: <20180816025452.21358-1-richard.henderson@linaro.org>
References: <20180816025452.21358-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/5] tcg: Split CONFIG_ATOMIC128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, pbonzini@redhat.com

GCC7+ will no longer advertise support for 16-byte __atomic operations
if only cmpxchg is supported, as for x86_64.  Fortunately, x86_64 still
has support for __sync_compare_and_swap_16 and we can make use of that.
AArch64 does not have, nor ever has had such support, so open-code it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h |  22 +++--
 include/qemu/atomic128.h    | 162 ++++++++++++++++++++++++++++++++++++
 tcg/tcg.h                   |  29 ++++---
 accel/tcg/cputlb.c          |   3 +-
 accel/tcg/user-exec.c       |   5 +-
 configure                   |  19 +++++
 6 files changed, 219 insertions(+), 21 deletions(-)
 create mode 100644 include/qemu/atomic128.h

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index d751bcba48..a056b7b408 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -100,19 +100,24 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     DATA_TYPE ret;
 
     ATOMIC_TRACE_RMW;
-    ret = atomic_cmpxchg__nocheck(haddr, cmpv, newv);
+#if DATA_SIZE == 16
+    ret = atomic16_cmpxchg(haddr, cmpv, newv);
+#else
+    ret = atomic_cmpxchg(haddr, cmpv, newv);
+#endif
     ATOMIC_MMU_CLEANUP;
     return ret;
 }
 
 #if DATA_SIZE >= 16
+#if HAVE_ATOMIC128
 ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
 
     ATOMIC_TRACE_LD;
-    __atomic_load(haddr, &val, __ATOMIC_RELAXED);
+    val = atomic16_read(haddr);
     ATOMIC_MMU_CLEANUP;
     return val;
 }
@@ -124,9 +129,10 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
 
     ATOMIC_TRACE_ST;
-    __atomic_store(haddr, &val, __ATOMIC_RELAXED);
+    atomic16_set(haddr, val);
     ATOMIC_MMU_CLEANUP;
 }
+#endif
 #else
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
                            ABI_TYPE val EXTRA_ARGS)
@@ -228,19 +234,24 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     DATA_TYPE ret;
 
     ATOMIC_TRACE_RMW;
+#if DATA_SIZE == 16
+    ret = atomic16_cmpxchg(haddr, BSWAP(cmpv), BSWAP(newv));
+#else
     ret = atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
+#endif
     ATOMIC_MMU_CLEANUP;
     return BSWAP(ret);
 }
 
 #if DATA_SIZE >= 16
+#if HAVE_ATOMIC128
 ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
 
     ATOMIC_TRACE_LD;
-    __atomic_load(haddr, &val, __ATOMIC_RELAXED);
+    val = atomic16_read(haddr);
     ATOMIC_MMU_CLEANUP;
     return BSWAP(val);
 }
@@ -253,9 +264,10 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 
     ATOMIC_TRACE_ST;
     val = BSWAP(val);
-    __atomic_store(haddr, &val, __ATOMIC_RELAXED);
+    atomic16_set(haddr, val);
     ATOMIC_MMU_CLEANUP;
 }
+#endif
 #else
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
                            ABI_TYPE val EXTRA_ARGS)
diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
new file mode 100644
index 0000000000..2613ebd352
--- /dev/null
+++ b/include/qemu/atomic128.h
@@ -0,0 +1,162 @@
+/*
+ * Simple interface for 128-bit atomic operations.
+ *
+ * Copyright (C) 2018 Linaro, Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * See docs/devel/atomics.txt for discussion about the guarantees each
+ * atomic primitive is meant to provide.
+ */
+
+#ifndef QEMU_ATOMIC128_H
+#define QEMU_ATOMIC128_H
+
+/*
+ * GCC is a house divided about supporting large atomic operations.
+ *
+ * For hosts that only have large compare-and-swap, a legalistic reading
+ * of the C++ standard means that one cannot implement __atomic_read on
+ * read-only memory, and thus all atomic operations must synchronize
+ * through libatomic.
+ *
+ * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80878
+ *
+ * This interpretation is not especially helpful for QEMU.
+ * For softmmu, all RAM is always read/write from the hypervisor.
+ * For user-only, if the guest doesn't implement such an __atomic_read
+ * then the host need not worry about it either.
+ *
+ * Moreover, using libatomic is not an option, because its interface is
+ * built for std::atomic<T>, and requires that *all* accesses to such an
+ * object go through the library.  In our case we do not have an object
+ * in the C/C++ sense, but a view of memory as seen by the guest.
+ * The guest may issue a large atomic operation and then access those
+ * pieces using word-sized accesses.  From the hypervisor, we have no
+ * way to connect those two actions.
+ *
+ * Therefore, special case each platform.
+ */
+
+#if defined(CONFIG_ATOMIC128)
+static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
+{
+    return atomic_cmpxchg__nocheck(ptr, cmp, new);
+}
+# define HAVE_CMPXCHG128 1
+#elif defined(CONFIG_CMPXCHG128)
+static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
+{
+    return __sync_val_compare_and_swap_16(ptr, cmp, new);
+}
+# define HAVE_CMPXCHG128 1
+#elif defined(__aarch64__)
+/* Through gcc 8, aarch64 has no support for 128-bit at all.  */
+static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
+{
+    uint64_t cmpl = cmp, cmph = cmp >> 64;
+    uint64_t newl = new, newh = new >> 64;
+    uint64_t oldl, oldh;
+    uint32_t tmp;
+
+    asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
+        "cmp %[oldl], %[cmpl]\n\t"
+        "ccmp %[oldh], %[cmph], #0, eq\n\t"
+        "b.ne 1f\n\t"
+        "stlxp %w[tmp], %[newl], %[newh], %[mem]\n\t"
+        "cbz %w[tmp], 0b\n"
+        "1:"
+        : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
+          [oldl] "=&r"(oldl), [oldh] "=r"(oldh)
+        : [cmpl] "r"(cmpl), [cmph] "r"(cmph),
+          [newl] "r"(newl), [newh] "r"(newh)
+        : "memory", "cc");
+
+    return int128_make128(oldl, oldh);
+}
+# define HAVE_CMPXCHG128 1
+#endif /* Some definition for HAVE_CMPXCHG128 */
+
+
+#if defined(CONFIG_ATOMIC128)
+static inline Int128 atomic16_read(Int128 *ptr)
+{
+    return atomic_read__nocheck(ptr);
+}
+
+static inline void atomic16_set(Int128 *ptr, Int128 val)
+{
+    atomic_set__nocheck(ptr, val);
+}
+
+# define HAVE_ATOMIC128 1
+#elif !defined(CONFIG_USER_ONLY)
+# ifdef __aarch64__
+/* We can do better than cmpxchg for AArch64.  */
+static inline Int128 atomic16_read(Int128 *ptr)
+{
+    uint64_t l, h;
+    uint32_t tmp;
+
+    /* The load must be paired with the store to guarantee not tearing.  */
+    asm("0: ldxp %[l], %[h], %[mem]\n\t"
+        "stxp %w[tmp], %[l], %[h], %[mem]\n\t"
+        "cbz %w[tmp], 0b"
+        : [mem] "+m"(*ptr), [tmp] "=r"(tmp), [l] "=r"(l), [h] "=r"(h));
+
+    return int128_make128(l, h);
+}
+
+static inline void atomic16_set(Int128 *ptr, Int128 val)
+{
+    uint64_t l = val, h = val >> 64, t1, t2;
+
+    /* Load into temporaries to acquire the exclusive access lock.  */
+    asm("0: ldxp %[t1], %[t2], %[mem]\n\t"
+        "stxp %w[t1], %[l], %[h], %[mem]\n\t"
+        "cbz %w[t1], 0b"
+        : [mem] "+m"(*ptr), [t1] "=&r"(t1), [t2] "=&r"(t2)
+        : [l] "r"(l), [h] "r"(h));
+}
+
+#  define HAVE_ATOMIC128 1
+# elif HAVE_CMPXCHG128
+static inline Int128 atomic16_read(Int128 *ptr)
+{
+    /* Maybe replace 0 with 0, returning the old value.  */
+    return atomic16_cmpxchg(ptr, 0, 0);
+}
+
+static inline void atomic16_set(Int128 *ptr, Int128 val)
+{
+    Int128 old = *ptr, cmp;
+    do {
+        cmp = old;
+        old = atomic16_cmpxchg(ptr, cmp, val);
+    } while (old != cmp);
+}
+
+#  define HAVE_ATOMIC128 1
+# endif
+#endif
+
+/*
+ * Fallback definitions that must be optimized away, or error.
+ */
+
+#ifndef HAVE_CMPXCHG128
+Int128 __attribute__((error("unsupported cmpxchg")))
+    atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new);
+# define HAVE_CMPXCHG128 0
+#endif
+
+#ifndef HAVE_ATOMIC128
+Int128 __attribute__((error("unsupported atomic16_read")))
+    atomic16_read(Int128 *ptr, Int128 cmp, Int128 new);
+Int128 __attribute__((error("unsupported atomic16_set")))
+    atomic16_set(Int128 *ptr, Int128 cmp, Int128 new);
+# define HAVE_ATOMIC128 0
+#endif
+
+#endif /* QEMU_ATOMIC128_H */
diff --git a/tcg/tcg.h b/tcg/tcg.h
index f9f12378e9..297b3f06ee 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -32,6 +32,8 @@
 #include "qemu/queue.h"
 #include "tcg-mo.h"
 #include "tcg-target.h"
+#include "qemu/atomic.h"
+#include "qemu/int128.h"
 
 /* XXX: make safe guess about sizes */
 #define MAX_OP_PER_INSTR 266
@@ -1454,27 +1456,28 @@ GEN_ATOMIC_HELPER_ALL(xchg)
 #undef GEN_ATOMIC_HELPER
 #endif /* CONFIG_SOFTMMU */
 
-#ifdef CONFIG_ATOMIC128
-#include "qemu/int128.h"
-
-/* These aren't really a "proper" helpers because TCG cannot manage Int128.
-   However, use the same format as the others, for use by the backends. */
+/*
+ * These aren't really a "proper" helpers because TCG cannot manage Int128.
+ * However, use the same format as the others, for use by the backends.
+ *
+ * The cmpxchg functions are only defined if HAVE_CMPXCHG128;
+ * the ld/st functions are only defined if HAVE_ATOMIC128,
+ * as defined by <qemu/atomic128.h>.
+ */
 Int128 helper_atomic_cmpxchgo_le_mmu(CPUArchState *env, target_ulong addr,
                                      Int128 cmpv, Int128 newv,
-                                     TCGMemOpIdx oi, uintptr_t retaddr);
+                                     TCGMemOpIdx oi, uintptr_t ra);
 Int128 helper_atomic_cmpxchgo_be_mmu(CPUArchState *env, target_ulong addr,
                                      Int128 cmpv, Int128 newv,
-                                     TCGMemOpIdx oi, uintptr_t retaddr);
+                                     TCGMemOpIdx oi, uintptr_t ra);
 
 Int128 helper_atomic_ldo_le_mmu(CPUArchState *env, target_ulong addr,
-                                TCGMemOpIdx oi, uintptr_t retaddr);
+                                TCGMemOpIdx oi, uintptr_t ra);
 Int128 helper_atomic_ldo_be_mmu(CPUArchState *env, target_ulong addr,
-                                TCGMemOpIdx oi, uintptr_t retaddr);
+                                TCGMemOpIdx oi, uintptr_t ra);
 void helper_atomic_sto_le_mmu(CPUArchState *env, target_ulong addr, Int128 val,
-                              TCGMemOpIdx oi, uintptr_t retaddr);
+                              TCGMemOpIdx oi, uintptr_t ra);
 void helper_atomic_sto_be_mmu(CPUArchState *env, target_ulong addr, Int128 val,
-                              TCGMemOpIdx oi, uintptr_t retaddr);
-
-#endif /* CONFIG_ATOMIC128 */
+                              TCGMemOpIdx oi, uintptr_t ra);
 
 #endif /* TCG_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 563fa30117..a7ea35a9e9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -32,6 +32,7 @@
 #include "exec/log.h"
 #include "exec/helper-proto.h"
 #include "qemu/atomic.h"
+#include "qemu/atomic128.h"
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
@@ -1188,7 +1189,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #include "atomic_template.h"
 #endif
 
-#ifdef CONFIG_ATOMIC128
+#if HAVE_CMPXCHG128 || HAVE_ATOMIC128
 #define DATA_SIZE 16
 #include "atomic_template.h"
 #endif
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 26a3ffbba1..cd75829cf2 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -25,6 +25,7 @@
 #include "exec/cpu_ldst.h"
 #include "translate-all.h"
 #include "exec/helper-proto.h"
+#include "qemu/atomic128.h"
 
 #undef EAX
 #undef ECX
@@ -615,7 +616,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 /* The following is only callable from other helpers, and matches up
    with the softmmu version.  */
 
-#ifdef CONFIG_ATOMIC128
+#if HAVE_ATOMIC128 || HAVE_CMPXCHG128
 
 #undef EXTRA_ARGS
 #undef ATOMIC_NAME
@@ -628,4 +629,4 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 
 #define DATA_SIZE 16
 #include "atomic_template.h"
-#endif /* CONFIG_ATOMIC128 */
+#endif
diff --git a/configure b/configure
index 2a7796ea80..7e24d89843 100755
--- a/configure
+++ b/configure
@@ -5117,6 +5117,21 @@ EOF
   fi
 fi
 
+cmpxchg128=no
+if test "$int128" = yes -a "$atomic128" = no; then
+  cat > $TMPC << EOF
+int main(void)
+{
+  unsigned __int128 x = 0, y = 0;
+  __sync_val_compare_and_swap_16(&x, y, x);
+  return 0;
+}
+EOF
+  if compile_prog "" "" ; then
+    cmpxchg128=yes
+  fi
+fi
+
 #########################################
 # See if 64-bit atomic operations are supported.
 # Note that without __atomic builtins, we can only
@@ -6610,6 +6625,10 @@ if test "$atomic128" = "yes" ; then
   echo "CONFIG_ATOMIC128=y" >> $config_host_mak
 fi
 
+if test "$cmpxchg128" = "yes" ; then
+  echo "CONFIG_CMPXCHG128=y" >> $config_host_mak
+fi
+
 if test "$atomic64" = "yes" ; then
   echo "CONFIG_ATOMIC64=y" >> $config_host_mak
 fi
-- 
2.17.1
