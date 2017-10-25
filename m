Received: from eggs.gnu.org ([2001:4830:134:3::10]:45811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6l-0008W0-F3
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6j-0008Qf-Nm
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:19 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6j-0008Q6-Dz
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:17 -0400
Received: by mail-wm0-x243.google.com with SMTP id u138so596539wmu.5
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:14 +0200
Message-Id: <20171025093535.10175-31-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 30/51] target/s390x: check CF_PARALLEL instead
 of parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Thereby decoupling the resulting translated code from the current state
of the system.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/helper.h     |  4 +++
 target/s390x/mem_helper.c | 80 +++++++++++++++++++++++++++++++++++++----------
 target/s390x/translate.c  | 26 ++++++++++++---
 3 files changed, 88 insertions(+), 22 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 81c5727168..9459b73c73 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -34,7 +34,9 @@ DEF_HELPER_3(celgb, i64, env, i64, i32)
 DEF_HELPER_3(cdlgb, i64, env, i64, i32)
 DEF_HELPER_3(cxlgb, i64, env, i64, i32)
 DEF_HELPER_4(cdsg, void, env, i64, i32, i32)
+DEF_HELPER_4(cdsg_parallel, void, env, i64, i32, i32)
 DEF_HELPER_4(csst, i32, env, i32, i64, i64)
+DEF_HELPER_4(csst_parallel, i32, env, i32, i64, i64)
 DEF_HELPER_FLAGS_3(aeb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(adb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_5(axb, TCG_CALL_NO_WG, i64, env, i64, i64, i64, i64)
@@ -106,7 +108,9 @@ DEF_HELPER_FLAGS_2(sfas, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(stfle, i32, env, i64)
 DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(lpq_parallel, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_4(stpq, TCG_CALL_NO_WG, void, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(stpq_parallel, TCG_CALL_NO_WG, void, env, i64, i64, i64)
 DEF_HELPER_4(mvcos, i32, env, i64, i64, i64)
 DEF_HELPER_4(cu12, i32, env, i32, i32, i32)
 DEF_HELPER_4(cu14, i32, env, i32, i32, i32)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 69a16867d4..a1652d4849 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1361,8 +1361,8 @@ uint32_t HELPER(trXX)(CPUS390XState *env, uint32_t r1, uint32_t r2,
     return cc;
 }
 
-void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
-                  uint32_t r1, uint32_t r3)
+static void do_cdsg(CPUS390XState *env, uint64_t addr,
+                    uint32_t r1, uint32_t r3, bool parallel)
 {
     uintptr_t ra = GETPC();
     Int128 cmpv = int128_make128(env->regs[r1 + 1], env->regs[r1]);
@@ -1370,7 +1370,7 @@ void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
     Int128 oldv;
     bool fail;
 
-    if (parallel_cpus) {
+    if (parallel) {
 #ifndef CONFIG_ATOMIC128
         cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
 #else
@@ -1402,7 +1402,20 @@ void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
     env->regs[r1 + 1] = int128_getlo(oldv);
 }
 
-uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
+void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
+                  uint32_t r1, uint32_t r3)
+{
+    do_cdsg(env, addr, r1, r3, false);
+}
+
+void HELPER(cdsg_parallel)(CPUS390XState *env, uint64_t addr,
+                           uint32_t r1, uint32_t r3)
+{
+    do_cdsg(env, addr, r1, r3, true);
+}
+
+static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
+                        uint64_t a2, bool parallel)
 {
 #if !defined(CONFIG_USER_ONLY) || defined(CONFIG_ATOMIC128)
     uint32_t mem_idx = cpu_mmu_index(env, false);
@@ -1438,7 +1451,7 @@ uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
        the complete operation is not.  Therefore we do not need to assert serial
        context in order to implement this.  That said, restart early if we can't
        support either operation that is supposed to be atomic.  */
-    if (parallel_cpus) {
+    if (parallel) {
         int mask = 0;
 #if !defined(CONFIG_ATOMIC64)
         mask = -8;
@@ -1462,7 +1475,7 @@ uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
             uint32_t cv = env->regs[r3];
             uint32_t ov;
 
-            if (parallel_cpus) {
+            if (parallel) {
 #ifdef CONFIG_USER_ONLY
                 uint32_t *haddr = g2h(a1);
                 ov = atomic_cmpxchg__nocheck(haddr, cv, nv);
@@ -1485,7 +1498,7 @@ uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
             uint64_t cv = env->regs[r3];
             uint64_t ov;
 
-            if (parallel_cpus) {
+            if (parallel) {
 #ifdef CONFIG_ATOMIC64
 # ifdef CONFIG_USER_ONLY
                 uint64_t *haddr = g2h(a1);
@@ -1495,7 +1508,7 @@ uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
                 ov = helper_atomic_cmpxchgq_be_mmu(env, a1, cv, nv, oi, ra);
 # endif
 #else
-                /* Note that we asserted !parallel_cpus above.  */
+                /* Note that we asserted !parallel above.  */
                 g_assert_not_reached();
 #endif
             } else {
@@ -1515,13 +1528,13 @@ uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
             Int128 cv = int128_make128(env->regs[r3 + 1], env->regs[r3]);
             Int128 ov;
 
-            if (parallel_cpus) {
+            if (parallel) {
 #ifdef CONFIG_ATOMIC128
                 TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
                 ov = helper_atomic_cmpxchgo_be_mmu(env, a1, cv, nv, oi, ra);
                 cc = !int128_eq(ov, cv);
 #else
-                /* Note that we asserted !parallel_cpus above.  */
+                /* Note that we asserted !parallel above.  */
                 g_assert_not_reached();
 #endif
             } else {
@@ -1565,13 +1578,13 @@ uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
             cpu_stq_data_ra(env, a2, svh, ra);
             break;
         case 4:
-            if (parallel_cpus) {
+            if (parallel) {
 #ifdef CONFIG_ATOMIC128
                 TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
                 Int128 sv = int128_make128(svl, svh);
                 helper_atomic_sto_be_mmu(env, a2, sv, oi, ra);
 #else
-                /* Note that we asserted !parallel_cpus above.  */
+                /* Note that we asserted !parallel above.  */
                 g_assert_not_reached();
 #endif
             } else {
@@ -1592,6 +1605,17 @@ uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
     g_assert_not_reached();
 }
 
+uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
+{
+    return do_csst(env, r3, a1, a2, false);
+}
+
+uint32_t HELPER(csst_parallel)(CPUS390XState *env, uint32_t r3, uint64_t a1,
+                               uint64_t a2)
+{
+    return do_csst(env, r3, a1, a2, true);
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
@@ -2011,12 +2035,12 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 #endif
 
 /* load pair from quadword */
-uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
+static uint64_t do_lpq(CPUS390XState *env, uint64_t addr, bool parallel)
 {
     uintptr_t ra = GETPC();
     uint64_t hi, lo;
 
-    if (parallel_cpus) {
+    if (parallel) {
 #ifndef CONFIG_ATOMIC128
         cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
 #else
@@ -2037,13 +2061,23 @@ uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
     return hi;
 }
 
+uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
+{
+    return do_lpq(env, addr, false);
+}
+
+uint64_t HELPER(lpq_parallel)(CPUS390XState *env, uint64_t addr)
+{
+    return do_lpq(env, addr, true);
+}
+
 /* store pair to quadword */
-void HELPER(stpq)(CPUS390XState *env, uint64_t addr,
-                  uint64_t low, uint64_t high)
+static void do_stpq(CPUS390XState *env, uint64_t addr,
+                    uint64_t low, uint64_t high, bool parallel)
 {
     uintptr_t ra = GETPC();
 
-    if (parallel_cpus) {
+    if (parallel) {
 #ifndef CONFIG_ATOMIC128
         cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
 #else
@@ -2061,6 +2095,18 @@ void HELPER(stpq)(CPUS390XState *env, uint64_t addr,
     }
 }
 
+void HELPER(stpq)(CPUS390XState *env, uint64_t addr,
+                  uint64_t low, uint64_t high)
+{
+    do_stpq(env, addr, low, high, false);
+}
+
+void HELPER(stpq_parallel)(CPUS390XState *env, uint64_t addr,
+                           uint64_t low, uint64_t high)
+{
+    do_stpq(env, addr, low, high, true);
+}
+
 /* Execute instruction.  This instruction executes an insn modified with
    the contents of r1.  It does not change the executed instruction in memory;
    it does not change the program counter.
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d589fb2459..241b708502 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1966,7 +1966,11 @@ static ExitStatus op_cdsg(DisasContext *s, DisasOps *o)
     addr = get_address(s, 0, b2, d2);
     t_r1 = tcg_const_i32(r1);
     t_r3 = tcg_const_i32(r3);
-    gen_helper_cdsg(cpu_env, addr, t_r1, t_r3);
+    if (tb_cflags(s->tb) & CF_PARALLEL) {
+        gen_helper_cdsg_parallel(cpu_env, addr, t_r1, t_r3);
+    } else {
+        gen_helper_cdsg(cpu_env, addr, t_r1, t_r3);
+    }
     tcg_temp_free_i64(addr);
     tcg_temp_free_i32(t_r1);
     tcg_temp_free_i32(t_r3);
@@ -1980,7 +1984,11 @@ static ExitStatus op_csst(DisasContext *s, DisasOps *o)
     int r3 = get_field(s->fields, r3);
     TCGv_i32 t_r3 = tcg_const_i32(r3);
 
-    gen_helper_csst(cc_op, cpu_env, t_r3, o->in1, o->in2);
+    if (tb_cflags(s->tb) & CF_PARALLEL) {
+        gen_helper_csst_parallel(cc_op, cpu_env, t_r3, o->in1, o->in2);
+    } else {
+        gen_helper_csst(cc_op, cpu_env, t_r3, o->in1, o->in2);
+    }
     tcg_temp_free_i32(t_r3);
 
     set_cc_static(s);
@@ -2939,7 +2947,7 @@ static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
     TCGMemOp mop = s->insn->data;
 
     /* In a parallel context, stop the world and single step.  */
-    if (parallel_cpus) {
+    if (tb_cflags(s->tb) & CF_PARALLEL) {
         potential_page_fault(s);
         gen_exception(EXCP_ATOMIC);
         return EXIT_NORETURN;
@@ -2960,7 +2968,11 @@ static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_lpq(DisasContext *s, DisasOps *o)
 {
-    gen_helper_lpq(o->out, cpu_env, o->in2);
+    if (tb_cflags(s->tb) & CF_PARALLEL) {
+        gen_helper_lpq_parallel(o->out, cpu_env, o->in2);
+    } else {
+        gen_helper_lpq(o->out, cpu_env, o->in2);
+    }
     return_low128(o->out2);
     return NO_EXIT;
 }
@@ -4281,7 +4293,11 @@ static ExitStatus op_stmh(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_stpq(DisasContext *s, DisasOps *o)
 {
-    gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
+    if (tb_cflags(s->tb) & CF_PARALLEL) {
+        gen_helper_stpq_parallel(cpu_env, o->in2, o->out2, o->out);
+    } else {
+        gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
+    }
     return NO_EXIT;
 }
 
-- 
2.13.6
