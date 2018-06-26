Received: from eggs.gnu.org ([2001:4830:134:3::10]:42399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqgk-0000tQ-CZ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqgj-0005sx-5E
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:30 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:41486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXqgi-0005sO-TN
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:29 -0400
Received: by mail-pf0-x22c.google.com with SMTP id a11-v6so8309022pff.8
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:19:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 09:19:11 -0700
Message-Id: <20180626161921.27941-4-richard.henderson@linaro.org>
In-Reply-To: <20180626161921.27941-1-richard.henderson@linaro.org>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 03/13] target/ppc: Use atomic store for STQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Section 1.4 of the Power ISA v3.0B states that this insn is
single-copy atomic.  As we cannot (yet) issue 128-bit loads
within TCG, use the generic helpers provided.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h     |  4 ++++
 target/ppc/mem_helper.c | 14 ++++++++++++++
 target/ppc/translate.c  | 35 +++++++++++++++++++++++++++--------
 3 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3f451a5d7e..cbc1228570 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -803,4 +803,8 @@ DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
 #if defined(TARGET_PPC64) && defined(CONFIG_ATOMIC128)
 DEF_HELPER_FLAGS_3(lq_le_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
 DEF_HELPER_FLAGS_3(lq_be_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
+DEF_HELPER_FLAGS_5(stq_le_parallel, TCG_CALL_NO_WG,
+                   void, env, tl, i64, i64, i32)
+DEF_HELPER_FLAGS_5(stq_be_parallel, TCG_CALL_NO_WG,
+                   void, env, tl, i64, i64, i32)
 #endif
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 44a8f3445a..57e301edc3 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -231,6 +231,20 @@ uint64_t helper_lq_be_parallel(CPUPPCState *env, target_ulong addr,
     env->retxh = int128_gethi(ret);
     return int128_getlo(ret);
 }
+
+void helper_stq_le_parallel(CPUPPCState *env, target_ulong addr,
+                            uint64_t lo, uint64_t hi, uint32_t opidx)
+{
+    Int128 val = int128_make128(lo, hi);
+    helper_atomic_sto_le_mmu(env, addr, val, opidx, GETPC());
+}
+
+void helper_stq_be_parallel(CPUPPCState *env, target_ulong addr,
+                            uint64_t lo, uint64_t hi, uint32_t opidx)
+{
+    Int128 val = int128_make128(lo, hi);
+    helper_atomic_sto_be_mmu(env, addr, val, opidx, GETPC());
+}
 #endif
 
 /*****************************************************************************/
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0923cc24e3..3d63a62269 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2760,6 +2760,7 @@ static void gen_std(DisasContext *ctx)
     if ((ctx->opcode & 0x3) == 0x2) { /* stq */
         bool legal_in_user_mode = (ctx->insns_flags2 & PPC2_LSQ_ISA207) != 0;
         bool le_is_supported = (ctx->insns_flags2 & PPC2_LSQ_ISA207) != 0;
+        TCGv hi, lo;
 
         if (!(ctx->insns_flags & PPC_64BX)) {
             gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
@@ -2783,20 +2784,38 @@ static void gen_std(DisasContext *ctx)
         EA = tcg_temp_new();
         gen_addr_imm_index(ctx, EA, 0x03);
 
-        /* We only need to swap high and low halves. gen_qemu_st64_i64 does
-           necessary 64-bit byteswap already. */
-        if (unlikely(ctx->le_mode)) {
-            gen_qemu_st64_i64(ctx, cpu_gpr[rs + 1], EA);
+        /* Note that the low part is always in RS+1, even in LE mode.  */
+        lo = cpu_gpr[rs + 1];
+        hi = cpu_gpr[rs];
+
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+#ifdef CONFIG_ATOMIC128
+            TCGv_i32 oi = tcg_temp_new_i32();
+            if (ctx->le_mode) {
+                tcg_gen_movi_i32(oi, make_memop_idx(MO_LEQ, ctx->mem_idx));
+                gen_helper_stq_le_parallel(cpu_env, EA, lo, hi, oi);
+            } else {
+                tcg_gen_movi_i32(oi, make_memop_idx(MO_BEQ, ctx->mem_idx));
+                gen_helper_stq_be_parallel(cpu_env, EA, lo, hi, oi);
+            }
+            tcg_temp_free_i32(oi);
+#else
+            /* Restart with exclusive lock.  */
+            gen_helper_exit_atomic(cpu_env);
+            ctx->base.is_jmp = DISAS_NORETURN;
+#endif
+        } else if (ctx->le_mode) {
+            tcg_gen_qemu_st_i64(lo, EA, ctx->mem_idx, MO_LEQ);
             gen_addr_add(ctx, EA, EA, 8);
-            gen_qemu_st64_i64(ctx, cpu_gpr[rs], EA);
+            tcg_gen_qemu_st_i64(hi, EA, ctx->mem_idx, MO_LEQ);
         } else {
-            gen_qemu_st64_i64(ctx, cpu_gpr[rs], EA);
+            tcg_gen_qemu_st_i64(hi, EA, ctx->mem_idx, MO_BEQ);
             gen_addr_add(ctx, EA, EA, 8);
-            gen_qemu_st64_i64(ctx, cpu_gpr[rs + 1], EA);
+            tcg_gen_qemu_st_i64(lo, EA, ctx->mem_idx, MO_BEQ);
         }
         tcg_temp_free(EA);
     } else {
-        /* std / stdu*/
+        /* std / stdu */
         if (Rc(ctx->opcode)) {
             if (unlikely(rA(ctx->opcode) == 0)) {
                 gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
-- 
2.17.1
