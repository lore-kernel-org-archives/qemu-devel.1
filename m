Received: from eggs.gnu.org ([2001:4830:134:3::10]:50455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fq8RB-0002IX-Dv
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fq8RA-0006kW-BL
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:55:01 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:36055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fq8RA-0006jm-31
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:55:00 -0400
Received: by mail-pg1-x52a.google.com with SMTP id h12-v6so1361009pgs.3
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 19:54:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 15 Aug 2018 19:54:50 -0700
Message-Id: <20180816025452.21358-4-richard.henderson@linaro.org>
In-Reply-To: <20180816025452.21358-1-richard.henderson@linaro.org>
References: <20180816025452.21358-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/5] target/s390x: Convert to HAVE_CMPXCHG128
 and HAVE_ATOMIC128
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mem_helper.c | 87 +++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 50 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e21a47fb4d..908b1254c8 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -25,6 +25,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
+#include "qemu/atomic128.h"
 
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/s390x/storage-keys.h"
@@ -1375,7 +1376,7 @@ static void do_cdsg(CPUS390XState *env, uint64_t addr,
     bool fail;
 
     if (parallel) {
-#ifndef CONFIG_ATOMIC128
+#if !HAVE_CMPXCHG128
         cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
 #else
         int mem_idx = cpu_mmu_index(env, false);
@@ -1421,12 +1422,10 @@ void HELPER(cdsg_parallel)(CPUS390XState *env, uint64_t addr,
 static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
                         uint64_t a2, bool parallel)
 {
-#if !defined(CONFIG_USER_ONLY) || defined(CONFIG_ATOMIC128)
     uint32_t mem_idx = cpu_mmu_index(env, false);
-#endif
     uintptr_t ra = GETPC();
-    uint32_t fc = extract32(env->regs[0], 0, 8);
-    uint32_t sc = extract32(env->regs[0], 8, 8);
+    uint32_t fc = extract32(env->regs[0], 0, 8), fsize = 4 << fc;
+    uint32_t sc = extract32(env->regs[0], 8, 8), ssize = 1 << sc;
     uint64_t pl = get_address(env, 1) & -16;
     uint64_t svh, svl;
     uint32_t cc;
@@ -1442,7 +1441,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
     }
 
     /* Sanity check the alignments.  */
-    if (extract32(a1, 0, 4 << fc) || extract32(a2, 0, 1 << sc)) {
+    if (extract32(a1, 0, fsize) || extract32(a2, 0, ssize)) {
         goto spec_exception;
     }
 
@@ -1456,13 +1455,12 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
        context in order to implement this.  That said, restart early if we can't
        support either operation that is supposed to be atomic.  */
     if (parallel) {
-        int mask = 0;
-#if !defined(CONFIG_ATOMIC64)
-        mask = -8;
-#elif !defined(CONFIG_ATOMIC128)
-        mask = -16;
+        uint32_t max = 4;
+#ifdef CONFIG_ATOMIC64
+        max = 8;
 #endif
-        if (((4 << fc) | (1 << sc)) & mask) {
+        if ((HAVE_CMPXCHG128 ? 0 : fsize > max) ||
+            (HAVE_ATOMIC128  ? 0 : ssize > max)) {
             cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
         }
     }
@@ -1532,16 +1530,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
             Int128 cv = int128_make128(env->regs[r3 + 1], env->regs[r3]);
             Int128 ov;
 
-            if (parallel) {
-#ifdef CONFIG_ATOMIC128
-                TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
-                ov = helper_atomic_cmpxchgo_be_mmu(env, a1, cv, nv, oi, ra);
-                cc = !int128_eq(ov, cv);
-#else
-                /* Note that we asserted !parallel above.  */
-                g_assert_not_reached();
-#endif
-            } else {
+            if (!parallel) {
                 uint64_t oh = cpu_ldq_data_ra(env, a1 + 0, ra);
                 uint64_t ol = cpu_ldq_data_ra(env, a1 + 8, ra);
 
@@ -1553,6 +1542,13 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
 
                 cpu_stq_data_ra(env, a1 + 0, int128_gethi(nv), ra);
                 cpu_stq_data_ra(env, a1 + 8, int128_getlo(nv), ra);
+            } else if (HAVE_CMPXCHG128) {
+                TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
+                ov = helper_atomic_cmpxchgo_be_mmu(env, a1, cv, nv, oi, ra);
+                cc = !int128_eq(ov, cv);
+            } else {
+                /* Note that we asserted !parallel above.  */
+                g_assert_not_reached();
             }
 
             env->regs[r3 + 0] = int128_gethi(ov);
@@ -1582,18 +1578,16 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
             cpu_stq_data_ra(env, a2, svh, ra);
             break;
         case 4:
-            if (parallel) {
-#ifdef CONFIG_ATOMIC128
+            if (!parallel) {
+                cpu_stq_data_ra(env, a2 + 0, svh, ra);
+                cpu_stq_data_ra(env, a2 + 8, svl, ra);
+            } else if (HAVE_ATOMIC128) {
                 TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
                 Int128 sv = int128_make128(svl, svh);
                 helper_atomic_sto_be_mmu(env, a2, sv, oi, ra);
-#else
+            } else {
                 /* Note that we asserted !parallel above.  */
                 g_assert_not_reached();
-#endif
-            } else {
-                cpu_stq_data_ra(env, a2 + 0, svh, ra);
-                cpu_stq_data_ra(env, a2 + 8, svl, ra);
             }
             break;
         default:
@@ -2091,21 +2085,18 @@ static uint64_t do_lpq(CPUS390XState *env, uint64_t addr, bool parallel)
     uintptr_t ra = GETPC();
     uint64_t hi, lo;
 
-    if (parallel) {
-#ifndef CONFIG_ATOMIC128
-        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
-#else
+    if (!parallel) {
+        check_alignment(env, addr, 16, ra);
+        hi = cpu_ldq_data_ra(env, addr + 0, ra);
+        lo = cpu_ldq_data_ra(env, addr + 8, ra);
+    } else if (HAVE_ATOMIC128) {
         int mem_idx = cpu_mmu_index(env, false);
         TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
         Int128 v = helper_atomic_ldo_be_mmu(env, addr, oi, ra);
         hi = int128_gethi(v);
         lo = int128_getlo(v);
-#endif
     } else {
-        check_alignment(env, addr, 16, ra);
-
-        hi = cpu_ldq_data_ra(env, addr + 0, ra);
-        lo = cpu_ldq_data_ra(env, addr + 8, ra);
+        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
     }
 
     env->retxl = lo;
@@ -2128,21 +2119,17 @@ static void do_stpq(CPUS390XState *env, uint64_t addr,
 {
     uintptr_t ra = GETPC();
 
-    if (parallel) {
-#ifndef CONFIG_ATOMIC128
-        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
-#else
-        int mem_idx = cpu_mmu_index(env, false);
-        TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
-
-        Int128 v = int128_make128(low, high);
-        helper_atomic_sto_be_mmu(env, addr, v, oi, ra);
-#endif
-    } else {
+    if (!parallel) {
         check_alignment(env, addr, 16, ra);
-
         cpu_stq_data_ra(env, addr + 0, high, ra);
         cpu_stq_data_ra(env, addr + 8, low, ra);
+    } else if (HAVE_ATOMIC128) {
+        int mem_idx = cpu_mmu_index(env, false);
+        TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
+        Int128 v = int128_make128(low, high);
+        helper_atomic_sto_be_mmu(env, addr, v, oi, ra);
+    } else {
+        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
     }
 }
 
-- 
2.17.1
