Received: from eggs.gnu.org ([2001:4830:134:3::10]:50495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fq8RE-0002K8-Dd
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fq8RD-0006nA-2A
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:55:04 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:35051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fq8RC-0006mZ-O4
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:55:02 -0400
Received: by mail-pg1-x535.google.com with SMTP id w10-v6so1361376pgv.2
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 19:55:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 15 Aug 2018 19:54:52 -0700
Message-Id: <20180816025452.21358-6-richard.henderson@linaro.org>
In-Reply-To: <20180816025452.21358-1-richard.henderson@linaro.org>
References: <20180816025452.21358-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/5] target/ppc: Convert to HAVE_CMPXCHG128 and
 HAVE_ATOMIC128
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
 target/ppc/helper.h     |   2 +-
 target/ppc/mem_helper.c |  33 ++++++++++--
 target/ppc/translate.c  | 115 +++++++++++++++++++++-------------------
 3 files changed, 88 insertions(+), 62 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5706c2497f..039f755eae 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -800,7 +800,7 @@ DEF_HELPER_4(dscliq, void, env, fprp, fprp, i32)
 DEF_HELPER_1(tbegin, void, env)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
 
-#if defined(TARGET_PPC64) && defined(CONFIG_ATOMIC128)
+#ifdef TARGET_PPC64
 DEF_HELPER_FLAGS_3(lq_le_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
 DEF_HELPER_FLAGS_3(lq_be_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
 DEF_HELPER_FLAGS_5(stq_le_parallel, TCG_CALL_NO_WG,
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 8f0d86d104..a1485fad9b 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -25,6 +25,7 @@
 #include "exec/cpu_ldst.h"
 #include "tcg.h"
 #include "internal.h"
+#include "qemu/atomic128.h"
 
 //#define DEBUG_OP
 
@@ -215,11 +216,15 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
     return i;
 }
 
-#if defined(TARGET_PPC64) && defined(CONFIG_ATOMIC128)
+#ifdef TARGET_PPC64
 uint64_t helper_lq_le_parallel(CPUPPCState *env, target_ulong addr,
                                uint32_t opidx)
 {
-    Int128 ret = helper_atomic_ldo_le_mmu(env, addr, opidx, GETPC());
+    Int128 ret;
+
+    /* We will have raised EXCP_ATOMIC from the translator.  */
+    assert(HAVE_ATOMIC128);
+    ret = helper_atomic_ldo_le_mmu(env, addr, opidx, GETPC());
     env->retxh = int128_gethi(ret);
     return int128_getlo(ret);
 }
@@ -227,7 +232,11 @@ uint64_t helper_lq_le_parallel(CPUPPCState *env, target_ulong addr,
 uint64_t helper_lq_be_parallel(CPUPPCState *env, target_ulong addr,
                                uint32_t opidx)
 {
-    Int128 ret = helper_atomic_ldo_be_mmu(env, addr, opidx, GETPC());
+    Int128 ret;
+
+    /* We will have raised EXCP_ATOMIC from the translator.  */
+    assert(HAVE_ATOMIC128);
+    ret = helper_atomic_ldo_be_mmu(env, addr, opidx, GETPC());
     env->retxh = int128_gethi(ret);
     return int128_getlo(ret);
 }
@@ -235,14 +244,22 @@ uint64_t helper_lq_be_parallel(CPUPPCState *env, target_ulong addr,
 void helper_stq_le_parallel(CPUPPCState *env, target_ulong addr,
                             uint64_t lo, uint64_t hi, uint32_t opidx)
 {
-    Int128 val = int128_make128(lo, hi);
+    Int128 val;
+
+    /* We will have raised EXCP_ATOMIC from the translator.  */
+    assert(HAVE_ATOMIC128);
+    val = int128_make128(lo, hi);
     helper_atomic_sto_le_mmu(env, addr, val, opidx, GETPC());
 }
 
 void helper_stq_be_parallel(CPUPPCState *env, target_ulong addr,
                             uint64_t lo, uint64_t hi, uint32_t opidx)
 {
-    Int128 val = int128_make128(lo, hi);
+    Int128 val;
+
+    /* We will have raised EXCP_ATOMIC from the translator.  */
+    assert(HAVE_ATOMIC128);
+    val = int128_make128(lo, hi);
     helper_atomic_sto_be_mmu(env, addr, val, opidx, GETPC());
 }
 
@@ -252,6 +269,9 @@ uint32_t helper_stqcx_le_parallel(CPUPPCState *env, target_ulong addr,
 {
     bool success = false;
 
+    /* We will have raised EXCP_ATOMIC from the translator.  */
+    assert(HAVE_CMPXCHG128);
+
     if (likely(addr == env->reserve_addr)) {
         Int128 oldv, cmpv, newv;
 
@@ -271,6 +291,9 @@ uint32_t helper_stqcx_be_parallel(CPUPPCState *env, target_ulong addr,
 {
     bool success = false;
 
+    /* We will have raised EXCP_ATOMIC from the translator.  */
+    assert(HAVE_CMPXCHG128);
+
     if (likely(addr == env->reserve_addr)) {
         Int128 oldv, cmpv, newv;
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 9eaa10b421..c3c8b91729 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -33,6 +33,7 @@
 #include "trace-tcg.h"
 #include "exec/translator.h"
 #include "exec/log.h"
+#include "qemu/atomic128.h"
 
 
 #define CPU_SINGLE_STEP 0x1
@@ -2621,22 +2622,22 @@ static void gen_lq(DisasContext *ctx)
     hi = cpu_gpr[rd];
 
     if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-#ifdef CONFIG_ATOMIC128
-        TCGv_i32 oi = tcg_temp_new_i32();
-        if (ctx->le_mode) {
-            tcg_gen_movi_i32(oi, make_memop_idx(MO_LEQ, ctx->mem_idx));
-            gen_helper_lq_le_parallel(lo, cpu_env, EA, oi);
+        if (HAVE_ATOMIC128) {
+            TCGv_i32 oi = tcg_temp_new_i32();
+            if (ctx->le_mode) {
+                tcg_gen_movi_i32(oi, make_memop_idx(MO_LEQ, ctx->mem_idx));
+                gen_helper_lq_le_parallel(lo, cpu_env, EA, oi);
+            } else {
+                tcg_gen_movi_i32(oi, make_memop_idx(MO_BEQ, ctx->mem_idx));
+                gen_helper_lq_be_parallel(lo, cpu_env, EA, oi);
+            }
+            tcg_temp_free_i32(oi);
+            tcg_gen_ld_i64(hi, cpu_env, offsetof(CPUPPCState, retxh));
         } else {
-            tcg_gen_movi_i32(oi, make_memop_idx(MO_BEQ, ctx->mem_idx));
-            gen_helper_lq_be_parallel(lo, cpu_env, EA, oi);
+            /* Restart with exclusive lock.  */
+            gen_helper_exit_atomic(cpu_env);
+            ctx->base.is_jmp = DISAS_NORETURN;
         }
-        tcg_temp_free_i32(oi);
-        tcg_gen_ld_i64(hi, cpu_env, offsetof(CPUPPCState, retxh));
-#else
-        /* Restart with exclusive lock.  */
-        gen_helper_exit_atomic(cpu_env);
-        ctx->base.is_jmp = DISAS_NORETURN;
-#endif
     } else if (ctx->le_mode) {
         tcg_gen_qemu_ld_i64(lo, EA, ctx->mem_idx, MO_LEQ);
         gen_addr_add(ctx, EA, EA, 8);
@@ -2772,21 +2773,21 @@ static void gen_std(DisasContext *ctx)
         hi = cpu_gpr[rs];
 
         if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-#ifdef CONFIG_ATOMIC128
-            TCGv_i32 oi = tcg_temp_new_i32();
-            if (ctx->le_mode) {
-                tcg_gen_movi_i32(oi, make_memop_idx(MO_LEQ, ctx->mem_idx));
-                gen_helper_stq_le_parallel(cpu_env, EA, lo, hi, oi);
+            if (HAVE_ATOMIC128) {
+                TCGv_i32 oi = tcg_temp_new_i32();
+                if (ctx->le_mode) {
+                    tcg_gen_movi_i32(oi, make_memop_idx(MO_LEQ, ctx->mem_idx));
+                    gen_helper_stq_le_parallel(cpu_env, EA, lo, hi, oi);
+                } else {
+                    tcg_gen_movi_i32(oi, make_memop_idx(MO_BEQ, ctx->mem_idx));
+                    gen_helper_stq_be_parallel(cpu_env, EA, lo, hi, oi);
+                }
+                tcg_temp_free_i32(oi);
             } else {
-                tcg_gen_movi_i32(oi, make_memop_idx(MO_BEQ, ctx->mem_idx));
-                gen_helper_stq_be_parallel(cpu_env, EA, lo, hi, oi);
+                /* Restart with exclusive lock.  */
+                gen_helper_exit_atomic(cpu_env);
+                ctx->base.is_jmp = DISAS_NORETURN;
             }
-            tcg_temp_free_i32(oi);
-#else
-            /* Restart with exclusive lock.  */
-            gen_helper_exit_atomic(cpu_env);
-            ctx->base.is_jmp = DISAS_NORETURN;
-#endif
         } else if (ctx->le_mode) {
             tcg_gen_qemu_st_i64(lo, EA, ctx->mem_idx, MO_LEQ);
             gen_addr_add(ctx, EA, EA, 8);
@@ -3371,26 +3372,26 @@ static void gen_lqarx(DisasContext *ctx)
     hi = cpu_gpr[rd];
 
     if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-#ifdef CONFIG_ATOMIC128
-        TCGv_i32 oi = tcg_temp_new_i32();
-        if (ctx->le_mode) {
-            tcg_gen_movi_i32(oi, make_memop_idx(MO_LEQ | MO_ALIGN_16,
-                                                ctx->mem_idx));
-            gen_helper_lq_le_parallel(lo, cpu_env, EA, oi);
+        if (HAVE_ATOMIC128) {
+            TCGv_i32 oi = tcg_temp_new_i32();
+            if (ctx->le_mode) {
+                tcg_gen_movi_i32(oi, make_memop_idx(MO_LEQ | MO_ALIGN_16,
+                                                    ctx->mem_idx));
+                gen_helper_lq_le_parallel(lo, cpu_env, EA, oi);
+            } else {
+                tcg_gen_movi_i32(oi, make_memop_idx(MO_BEQ | MO_ALIGN_16,
+                                                    ctx->mem_idx));
+                gen_helper_lq_be_parallel(lo, cpu_env, EA, oi);
+            }
+            tcg_temp_free_i32(oi);
+            tcg_gen_ld_i64(hi, cpu_env, offsetof(CPUPPCState, retxh));
         } else {
-            tcg_gen_movi_i32(oi, make_memop_idx(MO_BEQ | MO_ALIGN_16,
-                                                ctx->mem_idx));
-            gen_helper_lq_be_parallel(lo, cpu_env, EA, oi);
+            /* Restart with exclusive lock.  */
+            gen_helper_exit_atomic(cpu_env);
+            ctx->base.is_jmp = DISAS_NORETURN;
+            tcg_temp_free(EA);
+            return;
         }
-        tcg_temp_free_i32(oi);
-        tcg_gen_ld_i64(hi, cpu_env, offsetof(CPUPPCState, retxh));
-#else
-        /* Restart with exclusive lock.  */
-        gen_helper_exit_atomic(cpu_env);
-        ctx->base.is_jmp = DISAS_NORETURN;
-        tcg_temp_free(EA);
-        return;
-#endif
     } else if (ctx->le_mode) {
         tcg_gen_qemu_ld_i64(lo, EA, ctx->mem_idx, MO_LEQ | MO_ALIGN_16);
         tcg_gen_mov_tl(cpu_reserve, EA);
@@ -3428,20 +3429,22 @@ static void gen_stqcx_(DisasContext *ctx)
     hi = cpu_gpr[rs];
 
     if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-        TCGv_i32 oi = tcg_const_i32(DEF_MEMOP(MO_Q) | MO_ALIGN_16);
-#ifdef CONFIG_ATOMIC128
-        if (ctx->le_mode) {
-            gen_helper_stqcx_le_parallel(cpu_crf[0], cpu_env, EA, lo, hi, oi);
+        if (HAVE_CMPXCHG128) {
+            TCGv_i32 oi = tcg_const_i32(DEF_MEMOP(MO_Q) | MO_ALIGN_16);
+            if (ctx->le_mode) {
+                gen_helper_stqcx_le_parallel(cpu_crf[0], cpu_env,
+                                             EA, lo, hi, oi);
+            } else {
+                gen_helper_stqcx_be_parallel(cpu_crf[0], cpu_env,
+                                             EA, lo, hi, oi);
+            }
+            tcg_temp_free_i32(oi);
         } else {
-            gen_helper_stqcx_le_parallel(cpu_crf[0], cpu_env, EA, lo, hi, oi);
+            /* Restart with exclusive lock.  */
+            gen_helper_exit_atomic(cpu_env);
+            ctx->base.is_jmp = DISAS_NORETURN;
         }
-#else
-        /* Restart with exclusive lock.  */
-        gen_helper_exit_atomic(cpu_env);
-        ctx->base.is_jmp = DISAS_NORETURN;
-#endif
         tcg_temp_free(EA);
-        tcg_temp_free_i32(oi);
     } else {
         TCGLabel *lab_fail = gen_new_label();
         TCGLabel *lab_over = gen_new_label();
-- 
2.17.1
