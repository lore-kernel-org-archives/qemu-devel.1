Received: from eggs.gnu.org ([2001:4830:134:3::10]:51134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fs7cv-0003g7-VI
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fs7cm-0000cx-Jc
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:27:20 -0400
Received: from mail-pl0-x235.google.com ([2607:f8b0:400e:c01::235]:37696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fs7cm-0000c2-6K
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:27:12 -0400
Received: by mail-pl0-x235.google.com with SMTP id c6-v6so4043754pls.4
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:27:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 21 Aug 2018 07:27:02 -0700
Message-Id: <20180821142704.18783-4-richard.henderson@linaro.org>
In-Reply-To: <20180821142704.18783-1-richard.henderson@linaro.org>
References: <20180821142704.18783-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 3/5] target/arm: Convert to HAVE_CMPXCHG128
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

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c | 259 +++++++++++++++++++++-------------------
 1 file changed, 133 insertions(+), 126 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 7f6ad3000b..6e4e1b8a19 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -30,6 +30,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
+#include "qemu/atomic128.h"
 #include "tcg.h"
 #include "fpu/softfloat.h"
 #include <zlib.h> /* For crc32 */
@@ -509,189 +510,195 @@ uint64_t HELPER(crc32c_64)(uint64_t acc, uint64_t val, uint32_t bytes)
     return crc32c(acc, buf, bytes) ^ 0xffffffff;
 }
 
-/* Returns 0 on success; 1 otherwise.  */
-static uint64_t do_paired_cmpxchg64_le(CPUARMState *env, uint64_t addr,
-                                       uint64_t new_lo, uint64_t new_hi,
-                                       bool parallel, uintptr_t ra)
+uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
+                                     uint64_t new_lo, uint64_t new_hi)
 {
-    Int128 oldv, cmpv, newv;
+    Int128 cmpv = int128_make128(env->exclusive_val, env->exclusive_high);
+    Int128 newv = int128_make128(new_lo, new_hi);
+    Int128 oldv;
+    uintptr_t ra = GETPC();
+    uint64_t o0, o1;
     bool success;
 
-    cmpv = int128_make128(env->exclusive_val, env->exclusive_high);
-    newv = int128_make128(new_lo, new_hi);
-
-    if (parallel) {
-#ifndef CONFIG_ATOMIC128
-        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
-#else
-        int mem_idx = cpu_mmu_index(env, false);
-        TCGMemOpIdx oi = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
-        oldv = helper_atomic_cmpxchgo_le_mmu(env, addr, cmpv, newv, oi, ra);
-        success = int128_eq(oldv, cmpv);
-#endif
-    } else {
-        uint64_t o0, o1;
-
 #ifdef CONFIG_USER_ONLY
-        /* ??? Enforce alignment.  */
-        uint64_t *haddr = g2h(addr);
+    /* ??? Enforce alignment.  */
+    uint64_t *haddr = g2h(addr);
 
-        helper_retaddr = ra;
-        o0 = ldq_le_p(haddr + 0);
-        o1 = ldq_le_p(haddr + 1);
-        oldv = int128_make128(o0, o1);
+    helper_retaddr = ra;
+    o0 = ldq_le_p(haddr + 0);
+    o1 = ldq_le_p(haddr + 1);
+    oldv = int128_make128(o0, o1);
 
-        success = int128_eq(oldv, cmpv);
-        if (success) {
-            stq_le_p(haddr + 0, int128_getlo(newv));
-            stq_le_p(haddr + 1, int128_gethi(newv));
-        }
-        helper_retaddr = 0;
-#else
-        int mem_idx = cpu_mmu_index(env, false);
-        TCGMemOpIdx oi0 = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
-        TCGMemOpIdx oi1 = make_memop_idx(MO_LEQ, mem_idx);
-
-        o0 = helper_le_ldq_mmu(env, addr + 0, oi0, ra);
-        o1 = helper_le_ldq_mmu(env, addr + 8, oi1, ra);
-        oldv = int128_make128(o0, o1);
-
-        success = int128_eq(oldv, cmpv);
-        if (success) {
-            helper_le_stq_mmu(env, addr + 0, int128_getlo(newv), oi1, ra);
-            helper_le_stq_mmu(env, addr + 8, int128_gethi(newv), oi1, ra);
-        }
-#endif
+    success = int128_eq(oldv, cmpv);
+    if (success) {
+        stq_le_p(haddr + 0, int128_getlo(newv));
+        stq_le_p(haddr + 1, int128_gethi(newv));
     }
+    helper_retaddr = 0;
+#else
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOpIdx oi0 = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
+    TCGMemOpIdx oi1 = make_memop_idx(MO_LEQ, mem_idx);
+
+    o0 = helper_le_ldq_mmu(env, addr + 0, oi0, ra);
+    o1 = helper_le_ldq_mmu(env, addr + 8, oi1, ra);
+    oldv = int128_make128(o0, o1);
+
+    success = int128_eq(oldv, cmpv);
+    if (success) {
+        helper_le_stq_mmu(env, addr + 0, int128_getlo(newv), oi1, ra);
+        helper_le_stq_mmu(env, addr + 8, int128_gethi(newv), oi1, ra);
+    }
+#endif
 
     return !success;
 }
 
-uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
-                                              uint64_t new_lo, uint64_t new_hi)
-{
-    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, false, GETPC());
-}
-
 uint64_t HELPER(paired_cmpxchg64_le_parallel)(CPUARMState *env, uint64_t addr,
                                               uint64_t new_lo, uint64_t new_hi)
-{
-    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, true, GETPC());
-}
-
-static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
-                                       uint64_t new_lo, uint64_t new_hi,
-                                       bool parallel, uintptr_t ra)
 {
     Int128 oldv, cmpv, newv;
+    uintptr_t ra = GETPC();
     bool success;
+    int mem_idx;
+    TCGMemOpIdx oi;
 
-    /* high and low need to be switched here because this is not actually a
-     * 128bit store but two doublewords stored consecutively
-     */
-    cmpv = int128_make128(env->exclusive_high, env->exclusive_val);
-    newv = int128_make128(new_hi, new_lo);
-
-    if (parallel) {
-#ifndef CONFIG_ATOMIC128
+    if (!HAVE_CMPXCHG128) {
         cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
-#else
-        int mem_idx = cpu_mmu_index(env, false);
-        TCGMemOpIdx oi = make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx);
-        oldv = helper_atomic_cmpxchgo_be_mmu(env, addr, cmpv, newv, oi, ra);
-        success = int128_eq(oldv, cmpv);
-#endif
-    } else {
-        uint64_t o0, o1;
-
-#ifdef CONFIG_USER_ONLY
-        /* ??? Enforce alignment.  */
-        uint64_t *haddr = g2h(addr);
-
-        helper_retaddr = ra;
-        o1 = ldq_be_p(haddr + 0);
-        o0 = ldq_be_p(haddr + 1);
-        oldv = int128_make128(o0, o1);
-
-        success = int128_eq(oldv, cmpv);
-        if (success) {
-            stq_be_p(haddr + 0, int128_gethi(newv));
-            stq_be_p(haddr + 1, int128_getlo(newv));
-        }
-        helper_retaddr = 0;
-#else
-        int mem_idx = cpu_mmu_index(env, false);
-        TCGMemOpIdx oi0 = make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx);
-        TCGMemOpIdx oi1 = make_memop_idx(MO_BEQ, mem_idx);
-
-        o1 = helper_be_ldq_mmu(env, addr + 0, oi0, ra);
-        o0 = helper_be_ldq_mmu(env, addr + 8, oi1, ra);
-        oldv = int128_make128(o0, o1);
-
-        success = int128_eq(oldv, cmpv);
-        if (success) {
-            helper_be_stq_mmu(env, addr + 0, int128_gethi(newv), oi1, ra);
-            helper_be_stq_mmu(env, addr + 8, int128_getlo(newv), oi1, ra);
-        }
-#endif
     }
 
+    mem_idx = cpu_mmu_index(env, false);
+    oi = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
+
+    cmpv = int128_make128(env->exclusive_val, env->exclusive_high);
+    newv = int128_make128(new_lo, new_hi);
+    oldv = helper_atomic_cmpxchgo_le_mmu(env, addr, cmpv, newv, oi, ra);
+
+    success = int128_eq(oldv, cmpv);
     return !success;
 }
 
 uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
                                      uint64_t new_lo, uint64_t new_hi)
 {
-    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, false, GETPC());
+    /*
+     * High and low need to be switched here because this is not actually a
+     * 128bit store but two doublewords stored consecutively
+     */
+    Int128 cmpv = int128_make128(env->exclusive_val, env->exclusive_high);
+    Int128 newv = int128_make128(new_lo, new_hi);
+    Int128 oldv;
+    uintptr_t ra = GETPC();
+    uint64_t o0, o1;
+    bool success;
+
+#ifdef CONFIG_USER_ONLY
+    /* ??? Enforce alignment.  */
+    uint64_t *haddr = g2h(addr);
+
+    helper_retaddr = ra;
+    o1 = ldq_be_p(haddr + 0);
+    o0 = ldq_be_p(haddr + 1);
+    oldv = int128_make128(o0, o1);
+
+    success = int128_eq(oldv, cmpv);
+    if (success) {
+        stq_be_p(haddr + 0, int128_gethi(newv));
+        stq_be_p(haddr + 1, int128_getlo(newv));
+    }
+    helper_retaddr = 0;
+#else
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOpIdx oi0 = make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx);
+    TCGMemOpIdx oi1 = make_memop_idx(MO_BEQ, mem_idx);
+
+    o1 = helper_be_ldq_mmu(env, addr + 0, oi0, ra);
+    o0 = helper_be_ldq_mmu(env, addr + 8, oi1, ra);
+    oldv = int128_make128(o0, o1);
+
+    success = int128_eq(oldv, cmpv);
+    if (success) {
+        helper_be_stq_mmu(env, addr + 0, int128_gethi(newv), oi1, ra);
+        helper_be_stq_mmu(env, addr + 8, int128_getlo(newv), oi1, ra);
+    }
+#endif
+
+    return !success;
 }
 
 uint64_t HELPER(paired_cmpxchg64_be_parallel)(CPUARMState *env, uint64_t addr,
-                                     uint64_t new_lo, uint64_t new_hi)
+                                              uint64_t new_lo, uint64_t new_hi)
 {
-    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, true, GETPC());
+    Int128 oldv, cmpv, newv;
+    uintptr_t ra = GETPC();
+    bool success;
+    int mem_idx;
+    TCGMemOpIdx oi;
+
+    if (!HAVE_CMPXCHG128) {
+        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+    }
+
+    mem_idx = cpu_mmu_index(env, false);
+    oi = make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx);
+
+    /*
+     * High and low need to be switched here because this is not actually a
+     * 128bit store but two doublewords stored consecutively
+     */
+    cmpv = int128_make128(env->exclusive_high, env->exclusive_val);
+    newv = int128_make128(new_hi, new_lo);
+    oldv = helper_atomic_cmpxchgo_be_mmu(env, addr, cmpv, newv, oi, ra);
+
+    success = int128_eq(oldv, cmpv);
+    return !success;
 }
 
 /* Writes back the old data into Rs.  */
 void HELPER(casp_le_parallel)(CPUARMState *env, uint32_t rs, uint64_t addr,
                               uint64_t new_lo, uint64_t new_hi)
 {
-    uintptr_t ra = GETPC();
-#ifndef CONFIG_ATOMIC128
-    cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
-#else
     Int128 oldv, cmpv, newv;
+    uintptr_t ra = GETPC();
+    int mem_idx;
+    TCGMemOpIdx oi;
+
+    if (!HAVE_CMPXCHG128) {
+        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+    }
+
+    mem_idx = cpu_mmu_index(env, false);
+    oi = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
 
     cmpv = int128_make128(env->xregs[rs], env->xregs[rs + 1]);
     newv = int128_make128(new_lo, new_hi);
-
-    int mem_idx = cpu_mmu_index(env, false);
-    TCGMemOpIdx oi = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
     oldv = helper_atomic_cmpxchgo_le_mmu(env, addr, cmpv, newv, oi, ra);
 
     env->xregs[rs] = int128_getlo(oldv);
     env->xregs[rs + 1] = int128_gethi(oldv);
-#endif
 }
 
 void HELPER(casp_be_parallel)(CPUARMState *env, uint32_t rs, uint64_t addr,
                               uint64_t new_hi, uint64_t new_lo)
 {
-    uintptr_t ra = GETPC();
-#ifndef CONFIG_ATOMIC128
-    cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
-#else
     Int128 oldv, cmpv, newv;
+    uintptr_t ra = GETPC();
+    int mem_idx;
+    TCGMemOpIdx oi;
+
+    if (!HAVE_CMPXCHG128) {
+        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+    }
+
+    mem_idx = cpu_mmu_index(env, false);
+    oi = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
 
     cmpv = int128_make128(env->xregs[rs + 1], env->xregs[rs]);
     newv = int128_make128(new_lo, new_hi);
-
-    int mem_idx = cpu_mmu_index(env, false);
-    TCGMemOpIdx oi = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
     oldv = helper_atomic_cmpxchgo_be_mmu(env, addr, cmpv, newv, oi, ra);
 
     env->xregs[rs + 1] = int128_getlo(oldv);
     env->xregs[rs] = int128_gethi(oldv);
-#endif
 }
 
 /*
-- 
2.17.1
