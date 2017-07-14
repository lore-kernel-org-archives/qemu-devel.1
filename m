Received: from eggs.gnu.org ([2001:4830:134:3::10]:43164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJc-0003EH-1s
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJa-00006t-C2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:40 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVoJa-00006J-79
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:38 -0400
Received: by mail-qk0-x243.google.com with SMTP id q66so10270541qki.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:18:36 -0700 (PDT)
Received: from bigtime.twiddle.net.com (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	v47sm5647206qtb.11.2017.07.13.17.18.34 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Jul 2017 17:18:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 13 Jul 2017 14:18:12 -1000
Message-Id: <20170714001819.1660-2-rth@twiddle.net>
In-Reply-To: <20170714001819.1660-1-rth@twiddle.net>
References: <20170714001819.1660-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 1/8] target/alpha: Remove amask from tb->flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This value is constant for the cpu and does not need
to be stored within the TB.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/alpha/cpu.h       |  9 -------
 target/alpha/translate.c | 70 ++++++++++++++++++++++++++----------------------
 2 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 691ac00..aa83417 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -487,14 +487,6 @@ enum {
     TB_FLAGS_PAL_MODE = 1,
     TB_FLAGS_FEN = 2,
     TB_FLAGS_USER_MODE = 8,
-
-    TB_FLAGS_AMASK_SHIFT = 4,
-    TB_FLAGS_AMASK_BWX = AMASK_BWX << TB_FLAGS_AMASK_SHIFT,
-    TB_FLAGS_AMASK_FIX = AMASK_FIX << TB_FLAGS_AMASK_SHIFT,
-    TB_FLAGS_AMASK_CIX = AMASK_CIX << TB_FLAGS_AMASK_SHIFT,
-    TB_FLAGS_AMASK_MVI = AMASK_MVI << TB_FLAGS_AMASK_SHIFT,
-    TB_FLAGS_AMASK_TRAP = AMASK_TRAP << TB_FLAGS_AMASK_SHIFT,
-    TB_FLAGS_AMASK_PREFETCH = AMASK_PREFETCH << TB_FLAGS_AMASK_SHIFT,
 };
 
 static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, target_ulong *pc,
@@ -513,7 +505,6 @@ static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, target_ulong *pc,
     if (env->fen) {
         flags |= TB_FLAGS_FEN;
     }
-    flags |= env->amask << TB_FLAGS_AMASK_SHIFT;
 
     *pflags = flags;
 }
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 232af9e..4a627fc 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -51,14 +51,15 @@ struct DisasContext {
 #endif
     int mem_idx;
 
+    /* implver and amask values for this CPU.  */
+    int implver;
+    int amask;
+
     /* Current rounding mode for this TB.  */
     int tb_rm;
     /* Current flush-to-zero setting for this TB.  */
     int tb_ftz;
 
-    /* implver value for this CPU.  */
-    int implver;
-
     /* The set of registers active in the current context.  */
     TCGv *ir;
 
@@ -1442,6 +1443,13 @@ static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
         }                                       \
     } while (0)
 
+#define REQUIRE_AMASK(FLAG)                     \
+    do {                                        \
+        if ((ctx->amask & AMASK_##FLAG) == 0) { \
+            goto invalid_opc;                   \
+        }                                       \
+    } while (0)
+
 #define REQUIRE_TB_FLAG(FLAG)                   \
     do {                                        \
         if ((ctx->tb->flags & (FLAG)) == 0) {   \
@@ -1532,7 +1540,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
 
     case 0x0A:
         /* LDBU */
-        REQUIRE_TB_FLAG(TB_FLAGS_AMASK_BWX);
+        REQUIRE_AMASK(BWX);
         gen_load_mem(ctx, &tcg_gen_qemu_ld8u, ra, rb, disp16, 0, 0);
         break;
     case 0x0B:
@@ -1541,17 +1549,17 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         break;
     case 0x0C:
         /* LDWU */
-        REQUIRE_TB_FLAG(TB_FLAGS_AMASK_BWX);
+        REQUIRE_AMASK(BWX);
         gen_load_mem(ctx, &tcg_gen_qemu_ld16u, ra, rb, disp16, 0, 0);
         break;
     case 0x0D:
         /* STW */
-        REQUIRE_TB_FLAG(TB_FLAGS_AMASK_BWX);
+        REQUIRE_AMASK(BWX);
         gen_store_mem(ctx, &tcg_gen_qemu_st16, ra, rb, disp16, 0, 0);
         break;
     case 0x0E:
         /* STB */
-        REQUIRE_TB_FLAG(TB_FLAGS_AMASK_BWX);
+        REQUIRE_AMASK(BWX);
         gen_store_mem(ctx, &tcg_gen_qemu_st8, ra, rb, disp16, 0, 0);
         break;
     case 0x0F:
@@ -1832,10 +1840,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         case 0x61:
             /* AMASK */
             REQUIRE_REG_31(ra);
-            {
-                uint64_t amask = ctx->tb->flags >> TB_FLAGS_AMASK_SHIFT;
-                tcg_gen_andi_i64(vc, vb, ~amask);
-            }
+            tcg_gen_andi_i64(vc, vb, ~ctx->amask);
             break;
         case 0x64:
             /* CMOVLE */
@@ -2048,7 +2053,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         break;
 
     case 0x14:
-        REQUIRE_TB_FLAG(TB_FLAGS_AMASK_FIX);
+        REQUIRE_AMASK(FIX);
         vc = dest_fpr(ctx, rc);
         switch (fpfn) { /* fn11 & 0x3F */
         case 0x04:
@@ -2525,14 +2530,14 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         vc = dest_gpr(ctx, rc);
         if (fn7 == 0x70) {
             /* FTOIT */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_FIX);
+            REQUIRE_AMASK(FIX);
             REQUIRE_REG_31(rb);
             va = load_fpr(ctx, ra);
             tcg_gen_mov_i64(vc, va);
             break;
         } else if (fn7 == 0x78) {
             /* FTOIS */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_FIX);
+            REQUIRE_AMASK(FIX);
             REQUIRE_REG_31(rb);
             t32 = tcg_temp_new_i32();
             va = load_fpr(ctx, ra);
@@ -2546,117 +2551,117 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         switch (fn7) {
         case 0x00:
             /* SEXTB */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_BWX);
+            REQUIRE_AMASK(BWX);
             REQUIRE_REG_31(ra);
             tcg_gen_ext8s_i64(vc, vb);
             break;
         case 0x01:
             /* SEXTW */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_BWX);
+            REQUIRE_AMASK(BWX);
             REQUIRE_REG_31(ra);
             tcg_gen_ext16s_i64(vc, vb);
             break;
         case 0x30:
             /* CTPOP */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_CIX);
+            REQUIRE_AMASK(CIX);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             tcg_gen_ctpop_i64(vc, vb);
             break;
         case 0x31:
             /* PERR */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             REQUIRE_NO_LIT;
             va = load_gpr(ctx, ra);
             gen_helper_perr(vc, va, vb);
             break;
         case 0x32:
             /* CTLZ */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_CIX);
+            REQUIRE_AMASK(CIX);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             tcg_gen_clzi_i64(vc, vb, 64);
             break;
         case 0x33:
             /* CTTZ */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_CIX);
+            REQUIRE_AMASK(CIX);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             tcg_gen_ctzi_i64(vc, vb, 64);
             break;
         case 0x34:
             /* UNPKBW */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             gen_helper_unpkbw(vc, vb);
             break;
         case 0x35:
             /* UNPKBL */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             gen_helper_unpkbl(vc, vb);
             break;
         case 0x36:
             /* PKWB */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             gen_helper_pkwb(vc, vb);
             break;
         case 0x37:
             /* PKLB */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             REQUIRE_REG_31(ra);
             REQUIRE_NO_LIT;
             gen_helper_pklb(vc, vb);
             break;
         case 0x38:
             /* MINSB8 */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_minsb8(vc, va, vb);
             break;
         case 0x39:
             /* MINSW4 */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_minsw4(vc, va, vb);
             break;
         case 0x3A:
             /* MINUB8 */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_minub8(vc, va, vb);
             break;
         case 0x3B:
             /* MINUW4 */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_minuw4(vc, va, vb);
             break;
         case 0x3C:
             /* MAXUB8 */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_maxub8(vc, va, vb);
             break;
         case 0x3D:
             /* MAXUW4 */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_maxuw4(vc, va, vb);
             break;
         case 0x3E:
             /* MAXSB8 */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_maxsb8(vc, va, vb);
             break;
         case 0x3F:
             /* MAXSW4 */
-            REQUIRE_TB_FLAG(TB_FLAGS_AMASK_MVI);
+            REQUIRE_AMASK(MVI);
             va = load_gpr(ctx, ra);
             gen_helper_maxsw4(vc, va, vb);
             break;
@@ -2929,6 +2934,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
     ctx.pc = pc_start;
     ctx.mem_idx = cpu_mmu_index(env, false);
     ctx.implver = env->implver;
+    ctx.amask = env->amask;
     ctx.singlestep_enabled = cs->singlestep_enabled;
 
 #ifdef CONFIG_USER_ONLY
-- 
2.9.4
