Received: from eggs.gnu.org ([2001:4830:134:3::10]:37549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1famD8-000731-4X
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1famD3-0003cd-Dc
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:09:01 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54541 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1famD2-0003OC-SP
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:08:57 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed,  4 Jul 2018 20:08:24 +0200
Message-Id: <1530727708-5416-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530727708-5416-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1530727708-5416-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 4/8] target/mips: Avoid case statements
 formulated by ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, aleksandar.markovic@wavecomp.com, petar.jovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove "range style" case statements to make code analysis easier.

This is needed also for some upcoming nanoMIPS-related refactorings.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 257 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 208 insertions(+), 49 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 20b43c0..91ac32e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5494,7 +5494,14 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case 18:
         switch (sel) {
-        case 0 ... 7:
+        case 0:
+        case 1:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
             gen_helper_1e0i(mfc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -5504,7 +5511,14 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case 19:
         switch (sel) {
-        case 0 ...7:
+        case 0:
+        case 1:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -5630,7 +5644,10 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case 27:
         switch (sel) {
-        case 0 ... 3:
+        case 0:
+        case 1:
+        case 2:
+        case 3:
             tcg_gen_movi_tl(arg, 0); /* unimplemented */
             rn = "CacheErr";
             break;
@@ -5701,7 +5718,12 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DESAVE));
             rn = "DESAVE";
             break;
-        case 2 ... 7:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_ld_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
@@ -6167,7 +6189,14 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case 18:
         switch (sel) {
-        case 0 ... 7:
+        case 0:
+        case 1:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
             gen_helper_0e1i(mtc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -6177,7 +6206,14 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case 19:
         switch (sel) {
-        case 0 ... 7:
+        case 0:
+        case 1:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -6315,7 +6351,10 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case 27:
         switch (sel) {
-        case 0 ... 3:
+        case 0:
+        case 1:
+        case 2:
+        case 3:
             /* ignored */
             rn = "CacheErr";
             break;
@@ -6381,7 +6420,12 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_DESAVE));
             rn = "DESAVE";
             break;
-        case 2 ... 7:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
@@ -6842,7 +6886,14 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case 18:
         switch (sel) {
-        case 0 ... 7:
+        case 0:
+        case 1:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
             gen_helper_1e0i(dmfc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -6852,7 +6903,14 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case 19:
         switch (sel) {
-        case 0 ... 7:
+        case 0:
+        case 1:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -6975,7 +7033,10 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     case 27:
         switch (sel) {
         /* ignored */
-        case 0 ... 3:
+        case 0:
+        case 1:
+        case 2:
+        case 3:
             tcg_gen_movi_tl(arg, 0); /* unimplemented */
             rn = "CacheErr";
             break;
@@ -7040,7 +7101,12 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DESAVE));
             rn = "DESAVE";
             break;
-        case 2 ... 7:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_ld_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
@@ -7497,7 +7563,14 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case 18:
         switch (sel) {
-        case 0 ... 7:
+        case 0:
+        case 1:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
             gen_helper_0e1i(mtc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -7507,7 +7580,14 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case 19:
         switch (sel) {
-        case 0 ... 7:
+        case 0:
+        case 1:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -7641,7 +7721,10 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case 27:
         switch (sel) {
-        case 0 ... 3:
+        case 0:
+        case 1:
+        case 2:
+        case 3:
             /* ignored */
             rn = "CacheErr";
             break;
@@ -7707,7 +7790,12 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_DESAVE));
             rn = "DESAVE";
             break;
-        case 2 ... 7:
+        case 2:
+        case 3:
+        case 4:
+        case 5:
+        case 6:
+        case 7:
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
@@ -7843,7 +7931,14 @@ static void gen_mftr(CPUMIPSState *env, DisasContext *ctx, int rt, int rd,
             break;
         case 16:
             switch (sel) {
-            case 0 ... 7:
+            case 0:
+            case 1:
+            case 2:
+            case 3:
+            case 4:
+            case 5:
+            case 6:
+            case 7:
                 gen_helper_mftc0_configx(t0, cpu_env, tcg_const_tl(sel));
                 break;
             default:
@@ -17231,7 +17326,10 @@ static void decode_opc_special_r6(CPUMIPSState *env, DisasContext *ctx)
     case OPC_LSA:
         gen_lsa(ctx, op1, rd, rs, rt, extract32(ctx->opcode, 6, 2));
         break;
-    case OPC_MULT ... OPC_DIVU:
+    case OPC_MULT:
+    case OPC_MULTU:
+    case OPC_DIV:
+    case OPC_DIVU:
         op2 = MASK_R6_MULDIV(ctx->opcode);
         switch (op2) {
         case R6_OPC_MUL:
@@ -17291,7 +17389,15 @@ static void decode_opc_special_r6(CPUMIPSState *env, DisasContext *ctx)
             generate_exception_end(ctx, EXCP_RI);
         }
         break;
-    case OPC_DMULT ... OPC_DDIVU:
+    case OPC_MULT:
+    case OPC_MULTU:
+    case OPC_DIV:
+    case OPC_DIVU:
+    case OPC_DMULT:
+    case OPC_DMULTU:
+    case OPC_DDIV:
+    case OPC_DDIVU:
+
         op2 = MASK_R6_MULDIV(ctx->opcode);
         switch (op2) {
         case R6_OPC_DMUL:
@@ -17370,7 +17476,14 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
         gen_muldiv(ctx, op1, 0, rs, rt);
         break;
 #if defined(TARGET_MIPS64)
-    case OPC_DMULT ... OPC_DDIVU:
+    case OPC_MULT:
+    case OPC_MULTU:
+    case OPC_DIV:
+    case OPC_DIVU:
+    case OPC_DMULT:
+    case OPC_DMULTU:
+    case OPC_DDIV:
+    case OPC_DDIVU:
         check_insn(ctx, ISA_MIPS3);
         check_mips_64(ctx);
         gen_muldiv(ctx, op1, 0, rs, rt);
@@ -17437,7 +17550,10 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
-    case OPC_ADD ... OPC_SUBU:
+    case OPC_ADD:
+    case OPC_ADDU:
+    case OPC_SUB:
+    case OPC_SUBU:
         gen_arith(ctx, op1, rd, rs, rt);
         break;
     case OPC_SLLV:         /* Shifts */
@@ -17473,7 +17589,11 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
     case OPC_JALR:
         gen_compute_branch(ctx, op1, 4, rs, rd, sa, 4);
         break;
-    case OPC_TGE ... OPC_TEQ: /* Traps */
+    case OPC_TGE: /* Traps */
+    case OPC_TGEU:
+    case OPC_TLT:
+    case OPC_TLTU:
+    case OPC_TEQ:
     case OPC_TNE:
         check_insn(ctx, ISA_MIPS2);
         gen_trap(ctx, op1, rs, rt, -1);
@@ -17549,7 +17669,10 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
-    case OPC_DADD ... OPC_DSUBU:
+    case OPC_DADD:
+    case OPC_DADDU:
+    case OPC_DSUB:
+    case OPC_DSUBU:
         check_insn(ctx, ISA_MIPS3);
         check_mips_64(ctx);
         gen_arith(ctx, op1, rd, rs, rt);
@@ -17607,8 +17730,10 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     op1 = MASK_SPECIAL2(ctx->opcode);
     switch (op1) {
-    case OPC_MADD ... OPC_MADDU: /* Multiply and add/sub */
-    case OPC_MSUB ... OPC_MSUBU:
+    case OPC_MADD: /* Multiply and add/sub */
+    case OPC_MADDU:
+    case OPC_MSUB:
+    case OPC_MSUBU
         check_insn(ctx, ISA_MIPS32);
         gen_muldiv(ctx, op1, rd & 3, rs, rt);
         break;
@@ -17705,7 +17830,8 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
             }
             op2 = MASK_BSHFL(ctx->opcode);
             switch (op2) {
-            case OPC_ALIGN ... OPC_ALIGN_END:
+            case OPC_ALIGN:
+            case OPC_ALIGN_END:
                 gen_align(ctx, OPC_ALIGN, rd, rs, rt, sa & 3);
                 break;
             case OPC_BITSWAP:
@@ -17730,7 +17856,8 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
             }
             op2 = MASK_DBSHFL(ctx->opcode);
             switch (op2) {
-            case OPC_DALIGN ... OPC_DALIGN_END:
+            case OPC_DALIGN:
+            case OPC_DALIGN_END:
                 gen_align(ctx, OPC_DALIGN, rd, rs, rt, sa & 7);
                 break;
             case OPC_DBITSWAP:
@@ -17759,9 +17886,12 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     op1 = MASK_SPECIAL3(ctx->opcode);
     switch (op1) {
-    case OPC_DIV_G_2E ... OPC_DIVU_G_2E:
-    case OPC_MOD_G_2E ... OPC_MODU_G_2E:
-    case OPC_MULT_G_2E ... OPC_MULTU_G_2E:
+    case OPC_DIV_G_2E:
+    case OPC_DIVU_G_2E:
+    case OPC_MOD_G_2E:
+    case OPC_MODU_G_2E:
+    case OPC_MULT_G_2E:
+    case OPC_MULTU_G_2E:
         /* OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
          * the same mask and op1. */
         if ((ctx->insn_flags & ASE_DSPR2) && (op1 == OPC_MULT_G_2E)) {
@@ -18025,9 +18155,12 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
 #if defined(TARGET_MIPS64)
-    case OPC_DDIV_G_2E ... OPC_DDIVU_G_2E:
-    case OPC_DMULT_G_2E ... OPC_DMULTU_G_2E:
-    case OPC_DMOD_G_2E ... OPC_DMODU_G_2E:
+    case OPC_DDIV_G_2E:
+    case OPC_DDIVU_G_2E:
+    case OPC_DMULT_G_2E:
+    case OPC_DMULTU_G_2E:
+    case OPC_DMOD_G_2E:
+    case OPC_DMODU_G_2E:
         check_insn(ctx, INSN_LOONGSON2E);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
@@ -18289,18 +18422,25 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
      */
     if (ctx->eva) {
         switch (op1) {
-        case OPC_LWLE ... OPC_LWRE:
+        case OPC_LWLE:
+        case OPC_LWRE:
             check_insn_opc_removed(ctx, ISA_MIPS32R6);
             /* fall through */
-        case OPC_LBUE ... OPC_LHUE:
-        case OPC_LBE ... OPC_LWE:
+        case OPC_LBUE:
+        case OPC_LHUE:
+        case OPC_LBE:
+        case OPC_LHE:
+        case OPC_LLE:
+        case OPC_LWE:
             check_cp0_enabled(ctx);
             gen_ld(ctx, op1, rt, rs, imm);
             return;
-        case OPC_SWLE ... OPC_SWRE:
+        case OPC_SWLE:
+        case OPC_SWRE:
             check_insn_opc_removed(ctx, ISA_MIPS32R6);
             /* fall through */
-        case OPC_SBE ... OPC_SHE:
+        case OPC_SBE:
+        case OPC_SHE:
         case OPC_SWE:
             check_cp0_enabled(ctx);
             gen_st(ctx, op1, rt, rs, imm);
@@ -18332,7 +18472,8 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
     case OPC_BSHFL:
         op2 = MASK_BSHFL(ctx->opcode);
         switch (op2) {
-        case OPC_ALIGN ... OPC_ALIGN_END:
+        case OPC_ALIGN:
+        case OPC_ALIGN_END:
         case OPC_BITSWAP:
             check_insn(ctx, ISA_MIPS32R6);
             decode_opc_special3_r6(env, ctx);
@@ -18344,8 +18485,12 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
 #if defined(TARGET_MIPS64)
-    case OPC_DEXTM ... OPC_DEXT:
-    case OPC_DINSM ... OPC_DINS:
+    case OPC_DEXTM:
+    case OPC_DEXTU:
+    case OPC_DEXT:
+    case OPC_DINSM:
+    case OPC_DINSU:
+    case OPC_DINS:
         check_insn(ctx, ISA_MIPS64R2);
         check_mips_64(ctx);
         gen_bitops(ctx, op1, rt, rs, sa, rd);
@@ -18353,7 +18498,8 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
     case OPC_DBSHFL:
         op2 = MASK_DBSHFL(ctx->opcode);
         switch (op2) {
-        case OPC_DALIGN ... OPC_DALIGN_END:
+        case OPC_DALIGN:
+        case OPC_DALIGN_END:
         case OPC_DBITSWAP:
             check_insn(ctx, ISA_MIPS32R6);
             decode_opc_special3_r6(env, ctx);
@@ -19584,7 +19730,12 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
                 gen_compute_branch(ctx, op1, 4, rs, -1, imm << 2, 4);
             }
             break;
-        case OPC_TGEI ... OPC_TEQI: /* REGIMM traps */
+        case OPC_TGEI: /* REGIMM traps */
+        case OPC_TGEIU:
+        case OPC_TLTI:
+        case OPC_TLTIU:
+        case OPC_TEQI:
+
         case OPC_TNEI:
             check_insn(ctx, ISA_MIPS2);
             check_insn_opc_removed(ctx, ISA_MIPS32R6);
@@ -19759,7 +19910,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     case OPC_XORI:
          gen_logic_imm(ctx, op, rt, rs, imm);
          break;
-    case OPC_J ... OPC_JAL: /* Jump */
+    case OPC_J: /* Jump */
+    case OPC_JAL: /* Jump */
          offset = (int32_t)(ctx->opcode & 0x3FFFFFF) << 2;
          gen_compute_branch(ctx, op, 4, rs, rt, offset, 4);
          break;
@@ -19826,15 +19978,20 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     case OPC_LWR:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
          /* Fallthrough */
-    case OPC_LB ... OPC_LH:
-    case OPC_LW ... OPC_LHU:
+    case OPC_LB:
+    case OPC_LH:
+    case OPC_LW:
+    case OPC_LWPC:
+    case OPC_LBU:
+    case OPC_LHU:
          gen_ld(ctx, op, rt, rs, imm);
          break;
     case OPC_SWL:
     case OPC_SWR:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         /* fall through */
-    case OPC_SB ... OPC_SH:
+    case OPC_SB:
+    case OPC_SH:
     case OPC_SW:
          gen_st(ctx, op, rt, rs, imm);
          break;
@@ -20105,7 +20262,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
 
 #if defined(TARGET_MIPS64)
     /* MIPS64 opcodes */
-    case OPC_LDL ... OPC_LDR:
+    case OPC_LDL:
+    case OPC_LDR:
     case OPC_LLD:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         /* fall through */
@@ -20115,7 +20273,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         check_mips_64(ctx);
         gen_ld(ctx, op, rt, rs, imm);
         break;
-    case OPC_SDL ... OPC_SDR:
+    case OPC_SDL:
+    case OPC_SDR:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
         /* fall through */
     case OPC_SD:
-- 
2.7.4
