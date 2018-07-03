Received: from eggs.gnu.org ([2001:4830:134:3::10]:39646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKR-0002nS-Mt
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKP-0006uq-VA
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:43 +1000
Message-Id: <20180703055804.13449-15-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/35] target/ppc: Use atomic cmpxchg for STQCX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

When running in a parallel context, we must use a helper in order
to perform the 128-bit atomic operation.  When running in a serial
context, do the compare before the store.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h     |  2 +
 target/ppc/mem_helper.c | 38 +++++++++++++++++
 target/ppc/translate.c  | 93 ++++++++++++++++++++++++++---------------
 3 files changed, 100 insertions(+), 33 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index cbc1228570..5706c2497f 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -807,4 +807,6 @@ DEF_HELPER_FLAGS_5(stq_le_parallel, TCG_CALL_NO_WG,
                    void, env, tl, i64, i64, i32)
 DEF_HELPER_FLAGS_5(stq_be_parallel, TCG_CALL_NO_WG,
                    void, env, tl, i64, i64, i32)
+DEF_HELPER_5(stqcx_le_parallel, i32, env, tl, i64, i64, i32)
+DEF_HELPER_5(stqcx_be_parallel, i32, env, tl, i64, i64, i32)
 #endif
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 57e301edc3..8f0d86d104 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -245,6 +245,44 @@ void helper_stq_be_parallel(CPUPPCState *env, target_ulong addr,
     Int128 val = int128_make128(lo, hi);
     helper_atomic_sto_be_mmu(env, addr, val, opidx, GETPC());
 }
+
+uint32_t helper_stqcx_le_parallel(CPUPPCState *env, target_ulong addr,
+                                  uint64_t new_lo, uint64_t new_hi,
+                                  uint32_t opidx)
+{
+    bool success = false;
+
+    if (likely(addr == env->reserve_addr)) {
+        Int128 oldv, cmpv, newv;
+
+        cmpv = int128_make128(env->reserve_val2, env->reserve_val);
+        newv = int128_make128(new_lo, new_hi);
+        oldv = helper_atomic_cmpxchgo_le_mmu(env, addr, cmpv, newv,
+                                             opidx, GETPC());
+        success = int128_eq(oldv, cmpv);
+    }
+    env->reserve_addr = -1;
+    return env->so + success * CRF_EQ_BIT;
+}
+
+uint32_t helper_stqcx_be_parallel(CPUPPCState *env, target_ulong addr,
+                                  uint64_t new_lo, uint64_t new_hi,
+                                  uint32_t opidx)
+{
+    bool success = false;
+
+    if (likely(addr == env->reserve_addr)) {
+        Int128 oldv, cmpv, newv;
+
+        cmpv = int128_make128(env->reserve_val2, env->reserve_val);
+        newv = int128_make128(new_lo, new_hi);
+        oldv = helper_atomic_cmpxchgo_be_mmu(env, addr, cmpv, newv,
+                                             opidx, GETPC());
+        success = int128_eq(oldv, cmpv);
+    }
+    env->reserve_addr = -1;
+    return env->so + success * CRF_EQ_BIT;
+}
 #endif
 
 /*****************************************************************************/
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3d63a62269..c7b9d226eb 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3332,50 +3332,77 @@ static void gen_lqarx(DisasContext *ctx)
 /* stqcx. */
 static void gen_stqcx_(DisasContext *ctx)
 {
-    TCGv EA;
-    int reg = rS(ctx->opcode);
-    int len = 16;
-#if !defined(CONFIG_USER_ONLY)
-    TCGLabel *l1;
-    TCGv gpr1, gpr2;
-#endif
+    int rs = rS(ctx->opcode);
+    TCGv EA, hi, lo;
 
-    if (unlikely((rD(ctx->opcode) & 1))) {
+    if (unlikely(rs & 1)) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
     }
+
     gen_set_access_type(ctx, ACCESS_RES);
-    EA = tcg_temp_local_new();
+    EA = tcg_temp_new();
     gen_addr_reg_index(ctx, EA);
-    if (len > 1) {
-        gen_check_align(ctx, EA, (len) - 1);
-    }
 
-#if defined(CONFIG_USER_ONLY)
-    gen_conditional_store(ctx, EA, reg, 16);
-#else
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
-    l1 = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
-    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
+    /* Note that the low part is always in RS+1, even in LE mode.  */
+    lo = cpu_gpr[rs + 1];
+    hi = cpu_gpr[rs];
 
-    if (unlikely(ctx->le_mode)) {
-        gpr1 = cpu_gpr[reg + 1];
-        gpr2 = cpu_gpr[reg];
+    if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+        TCGv_i32 oi = tcg_const_i32(DEF_MEMOP(MO_Q) | MO_ALIGN_16);
+#ifdef CONFIG_ATOMIC128
+        if (ctx->le_mode) {
+            gen_helper_stqcx_le_parallel(cpu_crf[0], cpu_env, EA, lo, hi, oi);
+        } else {
+            gen_helper_stqcx_le_parallel(cpu_crf[0], cpu_env, EA, lo, hi, oi);
+        }
+#else
+        /* Restart with exclusive lock.  */
+        gen_helper_exit_atomic(cpu_env);
+        ctx->base.is_jmp = DISAS_NORETURN;
+#endif
+        tcg_temp_free(EA);
+        tcg_temp_free_i32(oi);
     } else {
-        gpr1 = cpu_gpr[reg];
-        gpr2 = cpu_gpr[reg + 1];
-    }
-    tcg_gen_qemu_st_tl(gpr1, EA, ctx->mem_idx, DEF_MEMOP(MO_Q));
-    gen_addr_add(ctx, EA, EA, 8);
-    tcg_gen_qemu_st_tl(gpr2, EA, ctx->mem_idx, DEF_MEMOP(MO_Q));
+        TCGLabel *lab_fail = gen_new_label();
+        TCGLabel *lab_over = gen_new_label();
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        TCGv_i64 t1 = tcg_temp_new_i64();
 
-    gen_set_label(l1);
-    tcg_gen_movi_tl(cpu_reserve, -1);
-#endif
-    tcg_temp_free(EA);
-}
+        tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lab_fail);
+        tcg_temp_free(EA);
+
+        gen_qemu_ld64_i64(ctx, t0, cpu_reserve);
+        tcg_gen_ld_i64(t1, cpu_env, (ctx->le_mode
+                                     ? offsetof(CPUPPCState, reserve_val2)
+                                     : offsetof(CPUPPCState, reserve_val)));
+        tcg_gen_brcond_i64(TCG_COND_NE, t0, t1, lab_fail);
+
+        tcg_gen_addi_i64(t0, cpu_reserve, 8);
+        gen_qemu_ld64_i64(ctx, t0, t0);
+        tcg_gen_ld_i64(t1, cpu_env, (ctx->le_mode
+                                     ? offsetof(CPUPPCState, reserve_val)
+                                     : offsetof(CPUPPCState, reserve_val2)));
+        tcg_gen_brcond_i64(TCG_COND_NE, t0, t1, lab_fail);
+
+        /* Success */
+        gen_qemu_st64_i64(ctx, ctx->le_mode ? lo : hi, cpu_reserve);
+        tcg_gen_addi_i64(t0, cpu_reserve, 8);
+        gen_qemu_st64_i64(ctx, ctx->le_mode ? hi : lo, t0);
+
+        tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+        tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
+        tcg_gen_br(lab_over);
 
+        gen_set_label(lab_fail);
+        tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+
+        gen_set_label(lab_over);
+        tcg_gen_movi_tl(cpu_reserve, -1);
+        tcg_temp_free_i64(t0);
+        tcg_temp_free_i64(t1);
+    }
+}
 #endif /* defined(TARGET_PPC64) */
 
 /* sync */
-- 
2.17.1
