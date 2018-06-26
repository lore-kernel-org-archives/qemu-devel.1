Received: from eggs.gnu.org ([2001:4830:134:3::10]:42456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqgo-0000vU-EW
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqgh-0005s1-M8
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:34 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:32934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXqgh-0005rX-Dl
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:27 -0400
Received: by mail-pl0-x243.google.com with SMTP id 6-v6so8787020plb.0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:19:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 09:19:10 -0700
Message-Id: <20180626161921.27941-3-richard.henderson@linaro.org>
In-Reply-To: <20180626161921.27941-1-richard.henderson@linaro.org>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/13] target/ppc: Use atomic load for LQ and
 LQARX
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

Section 1.4 of the Power ISA v3.0B states that both of these
instructions are single-copy atomic.  As we cannot (yet) issue
128-bit loads within TCG, use the generic helpers provided.

Since TCG cannot (yet) return a 128-bit value, add a slot within
CPUPPCState for returning the high half of a 128-bit return value.
This solution is preferred to the helper assigning to architectural
registers directly, as it avoids clobbering all TCG live values.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h        |  3 ++
 target/ppc/helper.h     |  5 +++
 target/ppc/mem_helper.c | 20 ++++++++-
 target/ppc/translate.c  | 93 ++++++++++++++++++++++++++++++-----------
 4 files changed, 95 insertions(+), 26 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c7f3fb6b73..973cf44cda 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1015,6 +1015,9 @@ struct CPUPPCState {
     /* Next instruction pointer */
     target_ulong nip;
 
+    /* High part of 128-bit helper return.  */
+    uint64_t retxh;
+
     int access_type; /* when a memory exception occurs, the access
                         type is stored here */
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index d751f0e219..3f451a5d7e 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -799,3 +799,8 @@ DEF_HELPER_4(dscliq, void, env, fprp, fprp, i32)
 
 DEF_HELPER_1(tbegin, void, env)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
+
+#if defined(TARGET_PPC64) && defined(CONFIG_ATOMIC128)
+DEF_HELPER_FLAGS_3(lq_le_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
+DEF_HELPER_FLAGS_3(lq_be_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
+#endif
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index a34e604db3..44a8f3445a 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -21,9 +21,9 @@
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
-
 #include "helper_regs.h"
 #include "exec/cpu_ldst.h"
+#include "tcg.h"
 #include "internal.h"
 
 //#define DEBUG_OP
@@ -215,6 +215,24 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
     return i;
 }
 
+#if defined(TARGET_PPC64) && defined(CONFIG_ATOMIC128)
+uint64_t helper_lq_le_parallel(CPUPPCState *env, target_ulong addr,
+                               uint32_t opidx)
+{
+    Int128 ret = helper_atomic_ldo_le_mmu(env, addr, opidx, GETPC());
+    env->retxh = int128_gethi(ret);
+    return int128_getlo(ret);
+}
+
+uint64_t helper_lq_be_parallel(CPUPPCState *env, target_ulong addr,
+                               uint32_t opidx)
+{
+    Int128 ret = helper_atomic_ldo_be_mmu(env, addr, opidx, GETPC());
+    env->retxh = int128_gethi(ret);
+    return int128_getlo(ret);
+}
+#endif
+
 /*****************************************************************************/
 /* Altivec extension helpers */
 #if defined(HOST_WORDS_BIGENDIAN)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3a215a1dc6..0923cc24e3 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2607,7 +2607,7 @@ static void gen_ld(DisasContext *ctx)
 static void gen_lq(DisasContext *ctx)
 {
     int ra, rd;
-    TCGv EA;
+    TCGv EA, hi, lo;
 
     /* lq is a legal user mode instruction starting in ISA 2.07 */
     bool legal_in_user_mode = (ctx->insns_flags2 & PPC2_LSQ_ISA207) != 0;
@@ -2633,16 +2633,35 @@ static void gen_lq(DisasContext *ctx)
     EA = tcg_temp_new();
     gen_addr_imm_index(ctx, EA, 0x0F);
 
-    /* We only need to swap high and low halves. gen_qemu_ld64_i64 does
-       necessary 64-bit byteswap already. */
-    if (unlikely(ctx->le_mode)) {
-        gen_qemu_ld64_i64(ctx, cpu_gpr[rd + 1], EA);
+    /* Note that the low part is always in RD+1, even in LE mode.  */
+    lo = cpu_gpr[rd + 1];
+    hi = cpu_gpr[rd];
+
+    if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+#ifdef CONFIG_ATOMIC128
+        TCGv_i32 oi = tcg_temp_new_i32();
+        if (ctx->le_mode) {
+            tcg_gen_movi_i32(oi, make_memop_idx(MO_LEQ, ctx->mem_idx));
+            gen_helper_lq_le_parallel(lo, cpu_env, EA, oi);
+        } else {
+            tcg_gen_movi_i32(oi, make_memop_idx(MO_BEQ, ctx->mem_idx));
+            gen_helper_lq_be_parallel(lo, cpu_env, EA, oi);
+        }
+        tcg_temp_free_i32(oi);
+        tcg_gen_ld_i64(hi, cpu_env, offsetof(CPUPPCState, retxh));
+#else
+        /* Restart with exclusive lock.  */
+        gen_helper_exit_atomic(cpu_env);
+        ctx->base.is_jmp = DISAS_NORETURN;
+#endif
+    } else if (ctx->le_mode) {
+        tcg_gen_qemu_ld_i64(lo, EA, ctx->mem_idx, MO_LEQ);
         gen_addr_add(ctx, EA, EA, 8);
-        gen_qemu_ld64_i64(ctx, cpu_gpr[rd], EA);
+        tcg_gen_qemu_ld_i64(hi, EA, ctx->mem_idx, MO_LEQ);
     } else {
-        gen_qemu_ld64_i64(ctx, cpu_gpr[rd], EA);
+        tcg_gen_qemu_ld_i64(hi, EA, ctx->mem_idx, MO_BEQ);
         gen_addr_add(ctx, EA, EA, 8);
-        gen_qemu_ld64_i64(ctx, cpu_gpr[rd + 1], EA);
+        tcg_gen_qemu_ld_i64(lo, EA, ctx->mem_idx, MO_BEQ);
     }
     tcg_temp_free(EA);
 }
@@ -3236,9 +3255,8 @@ STCX(stdcx_, DEF_MEMOP(MO_Q))
 /* lqarx */
 static void gen_lqarx(DisasContext *ctx)
 {
-    TCGv EA;
     int rd = rD(ctx->opcode);
-    TCGv gpr1, gpr2;
+    TCGv EA, hi, lo;
 
     if (unlikely((rd & 1) || (rd == rA(ctx->opcode)) ||
                  (rd == rB(ctx->opcode)))) {
@@ -3247,24 +3265,49 @@ static void gen_lqarx(DisasContext *ctx)
     }
 
     gen_set_access_type(ctx, ACCESS_RES);
-    EA = tcg_temp_local_new();
+    EA = tcg_temp_new();
     gen_addr_reg_index(ctx, EA);
-    gen_check_align(ctx, EA, 15);
-    if (unlikely(ctx->le_mode)) {
-        gpr1 = cpu_gpr[rd+1];
-        gpr2 = cpu_gpr[rd];
-    } else {
-        gpr1 = cpu_gpr[rd];
-        gpr2 = cpu_gpr[rd+1];
-    }
-    tcg_gen_qemu_ld_i64(gpr1, EA, ctx->mem_idx, DEF_MEMOP(MO_Q));
-    tcg_gen_mov_tl(cpu_reserve, EA);
-    gen_addr_add(ctx, EA, EA, 8);
-    tcg_gen_qemu_ld_i64(gpr2, EA, ctx->mem_idx, DEF_MEMOP(MO_Q));
 
-    tcg_gen_st_tl(gpr1, cpu_env, offsetof(CPUPPCState, reserve_val));
-    tcg_gen_st_tl(gpr2, cpu_env, offsetof(CPUPPCState, reserve_val2));
+    /* Note that the low part is always in RD+1, even in LE mode.  */
+    lo = cpu_gpr[rd + 1];
+    hi = cpu_gpr[rd];
+
+    if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+#ifdef CONFIG_ATOMIC128
+        TCGv_i32 oi = tcg_temp_new_i32();
+        if (ctx->le_mode) {
+            tcg_gen_movi_i32(oi, make_memop_idx(MO_LEQ | MO_ALIGN_16,
+                                                ctx->mem_idx));
+            gen_helper_lq_le_parallel(lo, cpu_env, EA, oi);
+        } else {
+            tcg_gen_movi_i32(oi, make_memop_idx(MO_BEQ | MO_ALIGN_16,
+                                                ctx->mem_idx));
+            gen_helper_lq_be_parallel(lo, cpu_env, EA, oi);
+        }
+        tcg_temp_free_i32(oi);
+        tcg_gen_ld_i64(hi, cpu_env, offsetof(CPUPPCState, retxh));
+#else
+        /* Restart with exclusive lock.  */
+        gen_helper_exit_atomic(cpu_env);
+        ctx->base.is_jmp = DISAS_NORETURN;
+        tcg_temp_free(EA);
+        return;
+#endif
+    } else if (ctx->le_mode) {
+        tcg_gen_qemu_ld_i64(lo, EA, ctx->mem_idx, MO_LEQ | MO_ALIGN_16);
+        tcg_gen_mov_tl(cpu_reserve, EA);
+        gen_addr_add(ctx, EA, EA, 8);
+        tcg_gen_qemu_ld_i64(hi, EA, ctx->mem_idx, MO_LEQ);
+    } else {
+        tcg_gen_qemu_ld_i64(hi, EA, ctx->mem_idx, MO_BEQ | MO_ALIGN_16);
+        tcg_gen_mov_tl(cpu_reserve, EA);
+        gen_addr_add(ctx, EA, EA, 8);
+        tcg_gen_qemu_ld_i64(lo, EA, ctx->mem_idx, MO_BEQ);
+    }
     tcg_temp_free(EA);
+
+    tcg_gen_st_tl(hi, cpu_env, offsetof(CPUPPCState, reserve_val));
+    tcg_gen_st_tl(lo, cpu_env, offsetof(CPUPPCState, reserve_val2));
 }
 
 /* stqcx. */
-- 
2.17.1
