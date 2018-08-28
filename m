Received: from eggs.gnu.org ([2001:4830:134:3::10]:50691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudca-0002kA-MU
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudc5-0000aw-NS
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:00:58 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:52006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fudc5-0000Zw-Hb
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:00:53 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Tue, 28 Aug 2018 09:00:35 -0400
Message-Id: <20180828130041.26445-3-jancraig@amazon.com>
In-Reply-To: <20180828130041.26445-1-jancraig@amazon.com>
References: <20180828130041.26445-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v3 2/8] target/mips: Add all MXU opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, aurelien@aurel32.net, Craig Janeczek <jancraig@amazon.com>

Adds all MXU opcodes to the opcode enum. The MXU opcodes overlap with
existing misc and Loongson 2F copcodes. The enums were updated to
reflect the multiple possible meanings where applicable.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 v1
    - NA
 v2
    - NA
 v3
    - Initial patch, split out from prior first patch

 target/mips/translate.c | 190 +++++++++++++++++++++++++++-------------
 1 file changed, 128 insertions(+), 62 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 416488b383..ae6b16ecd7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -340,30 +340,80 @@ enum {
 #define MASK_SPECIAL2(op)  MASK_OP_MAJOR(op) | (op & 0x3F)
 
 enum {
+    /* Multiply & xxx operations / MXU */
+    OPC_MADD_MXU_S32MADD   = 0x00 | OPC_SPECIAL2,
+    OPC_MADDU_MXU_S32MADDU = 0x01 | OPC_SPECIAL2,
     /* Multiply & xxx operations */
-    OPC_MADD     = 0x00 | OPC_SPECIAL2,
-    OPC_MADDU    = 0x01 | OPC_SPECIAL2,
-    OPC_MUL      = 0x02 | OPC_SPECIAL2,
-    OPC_MSUB     = 0x04 | OPC_SPECIAL2,
-    OPC_MSUBU    = 0x05 | OPC_SPECIAL2,
+    OPC_MUL                = 0x02 | OPC_SPECIAL2,
+    /* MXU */
+    OPC_MXU_D16MAX         = 0x03 | OPC_SPECIAL2,
+    /* Multiply & xxx operations / MXU */
+    OPC_MSUB_MXU_S32MSUB   = 0x04 | OPC_SPECIAL2,
+    OPC_MSUBU_MXU_S32MSUBU = 0x05 | OPC_SPECIAL2,
+    /* MXU */
+    OPC_MXU_D16AVG  = 0x6 | OPC_SPECIAL2,
+    OPC_MXU_D16CPS  = 0x7 | OPC_SPECIAL2,
+    OPC_MXU_D16MUL  = 0x8 | OPC_SPECIAL2,
+    OPC_MXU_D16MULF = 0x9 | OPC_SPECIAL2,
+    OPC_MXU_D16MAC  = 0xA | OPC_SPECIAL2,
+    OPC_MXU_D16MACF = 0xB | OPC_SPECIAL2,
+    OPC_MXU_D16MADL = 0xC | OPC_SPECIAL2,
+    OPC_MXU_S16MAD  = 0xD | OPC_SPECIAL2,
+    OPC_MXU_Q16ADD  = 0xE | OPC_SPECIAL2,
+    OPC_MXU_D16MACE = 0xF | OPC_SPECIAL2,
+    /* Loongson 2F / MXU */
+    OPC_MULT_G_2F_MXU_S32LDD   = 0x10 | OPC_SPECIAL2,
+    OPC_DMULT_G_2F_MXU_S32STD  = 0x11 | OPC_SPECIAL2,
+    OPC_MULTU_G_2F_MXU_S32LDDV  = 0x12 | OPC_SPECIAL2,
+    OPC_DMULTU_G_2F_MXU_S32STDV = 0x13 | OPC_SPECIAL2,
+    OPC_DIV_G_2F_MXU_S32LDI    = 0x14 | OPC_SPECIAL2,
+    OPC_DDIV_G_2F_MXU_S32SDI   = 0x15 | OPC_SPECIAL2,
+    OPC_DIVU_G_2F_MXU_S32LDIV   = 0x16 | OPC_SPECIAL2,
+    OPC_DDIVU_G_2F_MXU_S32SDIV  = 0x17 | OPC_SPECIAL2,
+    /* MXU */
+    OPC_MXU_D32ADD  = 0x18 | OPC_SPECIAL2,
+    OPC_MXU_D32ACC  = 0x19 | OPC_SPECIAL2,
+    OPC_MXU_Q16ACC  = 0x1B | OPC_SPECIAL2,
+    /* Loongson 2F / MXU */
+    OPC_MOD_G_2F_MXU_Q8ADDE    = 0x1c | OPC_SPECIAL2,
+    OPC_DMOD_G_2F_MXU_Q8ACCE   = 0x1d | OPC_SPECIAL2,
     /* Loongson 2F */
-    OPC_MULT_G_2F   = 0x10 | OPC_SPECIAL2,
-    OPC_DMULT_G_2F  = 0x11 | OPC_SPECIAL2,
-    OPC_MULTU_G_2F  = 0x12 | OPC_SPECIAL2,
-    OPC_DMULTU_G_2F = 0x13 | OPC_SPECIAL2,
-    OPC_DIV_G_2F    = 0x14 | OPC_SPECIAL2,
-    OPC_DDIV_G_2F   = 0x15 | OPC_SPECIAL2,
-    OPC_DIVU_G_2F   = 0x16 | OPC_SPECIAL2,
-    OPC_DDIVU_G_2F  = 0x17 | OPC_SPECIAL2,
-    OPC_MOD_G_2F    = 0x1c | OPC_SPECIAL2,
-    OPC_DMOD_G_2F   = 0x1d | OPC_SPECIAL2,
     OPC_MODU_G_2F   = 0x1e | OPC_SPECIAL2,
     OPC_DMODU_G_2F  = 0x1f | OPC_SPECIAL2,
     /* Misc */
     OPC_CLZ      = 0x20 | OPC_SPECIAL2,
     OPC_CLO      = 0x21 | OPC_SPECIAL2,
-    OPC_DCLZ     = 0x24 | OPC_SPECIAL2,
-    OPC_DCLO     = 0x25 | OPC_SPECIAL2,
+    /* MXU */
+    OPC_MXU_S8LDD = 0x22 | OPC_SPECIAL2,
+    OPC_MXU_S8STD = 0x23 | OPC_SPECIAL2,
+    /* Misc / MXU */
+    OPC_DCLZ_MXU_S8LDI     = 0x24 | OPC_SPECIAL2,
+    OPC_DCLO_MXU_S8SDI     = 0x25 | OPC_SPECIAL2,
+    /* MXU */
+    OPC_MXU_S32EXTR   = 0x26 | OPC_SPECIAL2,
+    OPC_MXU_D32SARW   = 0x27 | OPC_SPECIAL2,
+    OPC_MXU_LXB       = 0x28 | OPC_SPECIAL2,
+    OPC_MXU_S16LDD    = 0x2A | OPC_SPECIAL2,
+    OPC_MXU_S16STD    = 0x2B | OPC_SPECIAL2,
+    OPC_MXU_S16LDI    = 0x2C | OPC_SPECIAL2,
+    OPC_MXU_S16SDI    = 0x2D | OPC_SPECIAL2,
+    OPC_MXU_S32M2I    = 0x2E | OPC_SPECIAL2,
+    OPC_MXU_S32I2M    = 0x2F | OPC_SPECIAL2,
+    OPC_MXU_D32SLL    = 0x30 | OPC_SPECIAL2,
+    OPC_MXU_D32SLR    = 0x31 | OPC_SPECIAL2,
+    OPC_MXU_D32SARL   = 0x32 | OPC_SPECIAL2,
+    OPC_MXU_D32SAR    = 0x33 | OPC_SPECIAL2,
+    OPC_MXU_Q16SLL    = 0x34 | OPC_SPECIAL2,
+    OPC_MXU_Q16SLR    = 0x35 | OPC_SPECIAL2,
+    OPC_MXU_D32SLLV   = 0x36 | OPC_SPECIAL2,
+    OPC_MXU_Q16SAR    = 0x37 | OPC_SPECIAL2,
+    OPC_MXU_Q8MUL     = 0x38 | OPC_SPECIAL2,
+    OPC_MXU_Q8MOVZ    = 0x39 | OPC_SPECIAL2,
+    OPC_MXU_Q8MAC     = 0x3A | OPC_SPECIAL2,
+    OPC_MXU_Q16SCOP   = 0x3B | OPC_SPECIAL2,
+    OPC_MXU_Q8MADL    = 0x3C | OPC_SPECIAL2,
+    OPC_MXU_S32SFL    = 0x3D | OPC_SPECIAL2,
+    OPC_MXU_Q8SAD     = 0x3E | OPC_SPECIAL2,
     /* Special */
     OPC_SDBBP    = 0x3F | OPC_SPECIAL2,
 };
@@ -3563,7 +3613,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
         tcg_gen_mulu2_i64(cpu_LO[acc], cpu_HI[acc], t0, t1);
         break;
 #endif
-    case OPC_MADD:
+    case OPC_MADD_MXU_S32MADD:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
             TCGv_i64 t3 = tcg_temp_new_i64();
@@ -3579,7 +3629,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i64(t2);
         }
         break;
-    case OPC_MADDU:
+    case OPC_MADDU_MXU_S32MADDU:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
             TCGv_i64 t3 = tcg_temp_new_i64();
@@ -3597,7 +3647,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i64(t2);
         }
         break;
-    case OPC_MSUB:
+    case OPC_MSUB_MXU_S32MSUB:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
             TCGv_i64 t3 = tcg_temp_new_i64();
@@ -3613,7 +3663,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i64(t2);
         }
         break;
-    case OPC_MSUBU:
+    case OPC_MSUBU_MXU_S32MSUBU:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
             TCGv_i64 t3 = tcg_temp_new_i64();
@@ -3721,7 +3771,7 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
     case OPC_CLO:
     case R6_OPC_CLO:
 #if defined(TARGET_MIPS64)
-    case OPC_DCLO:
+    case OPC_DCLO_MXU_S8SDI:
     case R6_OPC_DCLO:
 #endif
         tcg_gen_not_tl(t0, t0);
@@ -3738,9 +3788,9 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
         tcg_gen_subi_tl(t0, t0, TARGET_LONG_BITS - 32);
         break;
 #if defined(TARGET_MIPS64)
-    case OPC_DCLO:
+    case OPC_DCLO_MXU_S8SDI:
     case R6_OPC_DCLO:
-    case OPC_DCLZ:
+    case OPC_DCLZ_MXU_S8LDI:
     case R6_OPC_DCLZ:
         tcg_gen_clzi_i64(t0, t0, 64);
         break;
@@ -3761,14 +3811,14 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
 
     switch (opc) {
     case OPC_MULT_G_2E:
-    case OPC_MULT_G_2F:
+    case OPC_MULT_G_2F_MXU_S32LDD:
     case OPC_MULTU_G_2E:
-    case OPC_MULTU_G_2F:
+    case OPC_MULTU_G_2F_MXU_S32LDDV:
 #if defined(TARGET_MIPS64)
     case OPC_DMULT_G_2E:
-    case OPC_DMULT_G_2F:
+    case OPC_DMULT_G_2F_MXU_S32STD:
     case OPC_DMULTU_G_2E:
-    case OPC_DMULTU_G_2F:
+    case OPC_DMULTU_G_2F_MXU_S32STDV:
 #endif
         t0 = tcg_temp_new();
         t1 = tcg_temp_new();
@@ -3784,19 +3834,19 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
 
     switch (opc) {
     case OPC_MULT_G_2E:
-    case OPC_MULT_G_2F:
+    case OPC_MULT_G_2F_MXU_S32LDD:
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
     case OPC_MULTU_G_2E:
-    case OPC_MULTU_G_2F:
+    case OPC_MULTU_G_2F_MXU_S32LDDV:
         tcg_gen_ext32u_tl(t0, t0);
         tcg_gen_ext32u_tl(t1, t1);
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
     case OPC_DIV_G_2E:
-    case OPC_DIV_G_2F:
+    case OPC_DIV_G_2F_MXU_S32LDI:
         {
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
@@ -3818,7 +3868,7 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         }
         break;
     case OPC_DIVU_G_2E:
-    case OPC_DIVU_G_2F:
+    case OPC_DIVU_G_2F_MXU_S32LDIV:
         {
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
@@ -3834,7 +3884,7 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         }
         break;
     case OPC_MOD_G_2E:
-    case OPC_MOD_G_2F:
+    case OPC_MOD_G_2F_MXU_Q8ADDE:
         {
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
@@ -3871,15 +3921,15 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         break;
 #if defined(TARGET_MIPS64)
     case OPC_DMULT_G_2E:
-    case OPC_DMULT_G_2F:
+    case OPC_DMULT_G_2F_MXU_S32STD:
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         break;
     case OPC_DMULTU_G_2E:
-    case OPC_DMULTU_G_2F:
+    case OPC_DMULTU_G_2F_MXU_S32STDV:
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         break;
     case OPC_DDIV_G_2E:
-    case OPC_DDIV_G_2F:
+    case OPC_DDIV_G_2F_MXU_S32SDI:
         {
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
@@ -3898,7 +3948,7 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         }
         break;
     case OPC_DDIVU_G_2E:
-    case OPC_DDIVU_G_2F:
+    case OPC_DDIVU_G_2F_MXU_S32SDIV:
         {
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
@@ -3911,7 +3961,7 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         }
         break;
     case OPC_DMOD_G_2E:
-    case OPC_DMOD_G_2F:
+    case OPC_DMOD_G_2F_MXU_Q8ACCE:
         {
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
@@ -13541,16 +13591,32 @@ static void gen_pool32axf (CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
     case 0x2a:
         switch (minor & 3) {
         case MADD_ACC:
-            gen_muldiv(ctx, OPC_MADD, (ctx->opcode >> 14) & 3, rs, rt);
+            gen_muldiv(ctx,
+                       OPC_MADD_MXU_S32MADD,
+                       (ctx->opcode >> 14) & 3,
+                       rs,
+                       rt);
             break;
         case MADDU_ACC:
-            gen_muldiv(ctx, OPC_MADDU, (ctx->opcode >> 14) & 3, rs, rt);
+            gen_muldiv(ctx,
+                       OPC_MADDU_MXU_S32MADDU,
+                       (ctx->opcode >> 14) & 3,
+                       rs,
+                       rt);
             break;
         case MSUB_ACC:
-            gen_muldiv(ctx, OPC_MSUB, (ctx->opcode >> 14) & 3, rs, rt);
+            gen_muldiv(ctx,
+                       OPC_MSUB_MXU_S32MSUB,
+                       (ctx->opcode >> 14) & 3,
+                       rs,
+                       rt);
             break;
         case MSUBU_ACC:
-            gen_muldiv(ctx, OPC_MSUBU, (ctx->opcode >> 14) & 3, rs, rt);
+            gen_muldiv(ctx,
+                       OPC_MSUBU_MXU_S32MSUBU,
+                       (ctx->opcode >> 14) & 3,
+                       rs,
+                       rt);
             break;
         default:
             goto pool32axf_invalid;
@@ -13618,19 +13684,19 @@ static void gen_pool32axf (CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
             break;
         case MADD:
             check_insn_opc_removed(ctx, ISA_MIPS32R6);
-            mips32_op = OPC_MADD;
+            mips32_op = OPC_MADD_MXU_S32MADD;
             goto do_mul;
         case MADDU:
             check_insn_opc_removed(ctx, ISA_MIPS32R6);
-            mips32_op = OPC_MADDU;
+            mips32_op = OPC_MADDU_MXU_S32MADDU;
             goto do_mul;
         case MSUB:
             check_insn_opc_removed(ctx, ISA_MIPS32R6);
-            mips32_op = OPC_MSUB;
+            mips32_op = OPC_MSUB_MXU_S32MSUB;
             goto do_mul;
         case MSUBU:
             check_insn_opc_removed(ctx, ISA_MIPS32R6);
-            mips32_op = OPC_MSUBU;
+            mips32_op = OPC_MSUBU_MXU_S32MSUBU;
         do_mul:
             check_insn(ctx, ISA_MIPS32);
             gen_muldiv(ctx, mips32_op, 0, rs, rt);
@@ -17809,21 +17875,21 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     op1 = MASK_SPECIAL2(ctx->opcode);
     switch (op1) {
-    case OPC_MADD: /* Multiply and add/sub */
-    case OPC_MADDU:
-    case OPC_MSUB:
-    case OPC_MSUBU:
+    case OPC_MADD_MXU_S32MADD: /* Multiply and add/sub */
+    case OPC_MADDU_MXU_S32MADDU:
+    case OPC_MSUB_MXU_S32MSUB:
+    case OPC_MSUBU_MXU_S32MSUBU:
         check_insn(ctx, ISA_MIPS32);
         gen_muldiv(ctx, op1, rd & 3, rs, rt);
         break;
     case OPC_MUL:
         gen_arith(ctx, op1, rd, rs, rt);
         break;
-    case OPC_DIV_G_2F:
-    case OPC_DIVU_G_2F:
-    case OPC_MULT_G_2F:
-    case OPC_MULTU_G_2F:
-    case OPC_MOD_G_2F:
+    case OPC_DIV_G_2F_MXU_S32LDI:
+    case OPC_DIVU_G_2F_MXU_S32LDIV:
+    case OPC_MULT_G_2F_MXU_S32LDD:
+    case OPC_MULTU_G_2F_MXU_S32LDDV:
+    case OPC_MOD_G_2F_MXU_Q8ADDE:
     case OPC_MODU_G_2F:
         check_insn(ctx, INSN_LOONGSON2F);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
@@ -17845,17 +17911,17 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
 #if defined(TARGET_MIPS64)
-    case OPC_DCLO:
-    case OPC_DCLZ:
+    case OPC_DCLO_MXU_S8SDI:
+    case OPC_DCLZ_MXU_S8LDI:
         check_insn(ctx, ISA_MIPS64);
         check_mips_64(ctx);
         gen_cl(ctx, op1, rd, rs);
         break;
-    case OPC_DMULT_G_2F:
-    case OPC_DMULTU_G_2F:
-    case OPC_DDIV_G_2F:
-    case OPC_DDIVU_G_2F:
-    case OPC_DMOD_G_2F:
+    case OPC_DMULT_G_2F_MXU_S32STD:
+    case OPC_DMULTU_G_2F_MXU_S32STDV:
+    case OPC_DDIV_G_2F_MXU_S32SDI:
+    case OPC_DDIVU_G_2F_MXU_S32SDIV:
+    case OPC_DMOD_G_2F_MXU_Q8ACCE:
     case OPC_DMODU_G_2F:
         check_insn(ctx, INSN_LOONGSON2F);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
-- 
2.18.0
