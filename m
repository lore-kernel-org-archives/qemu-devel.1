Received: from eggs.gnu.org ([2001:4830:134:3::10]:53727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6Ny-0001Fk-I5
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6No-0008S0-83
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35489 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs6Nn-0008Ox-P1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:40 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 15:07:17 +0200
Message-Id: <1534856848-12102-36-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534856848-12102-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534856848-12102-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 35/46] target/mips: Add availability control
 via bit NMS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Dimitrije Nikolic <dnikolic@wavecomp.com>

A set of nanoMIPS instructions is not available if Config5 bit NMS
is set.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 89ccb95..6143d11 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1955,6 +1955,16 @@ static inline void check_cp0_mt(DisasContext *ctx)
     }
 }
 
+/*
+ * This code generates a "reserved instruction" exception if the
+ * Config5 NMS bit is set.
+ */
+static inline void check_nms(DisasContext *ctx)
+{
+    if (unlikely(ctx->CP0_Config5 & (1 << CP0C5_NMS))) {
+        generate_exception_end(ctx, EXCP_RI);
+    }
+}
 
 
 /* Define small wrappers for gen_load_fpr* so that we have a uniform
@@ -16998,17 +17008,21 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
     case NM_P_TRAP:
         switch (extract32(ctx->opcode, 10, 1)) {
         case NM_TEQ:
+            check_nms(ctx);
             gen_trap(ctx, OPC_TEQ, rs, rt, -1);
             break;
         case NM_TNE:
+            check_nms(ctx);
             gen_trap(ctx, OPC_TNE, rs, rt, -1);
             break;
         }
         break;
     case NM_RDHWR:
+        check_nms(ctx);
         gen_rdhwr(ctx, rt, rs, extract32(ctx->opcode, 11, 3));
         break;
     case NM_SEB:
+        check_nms(ctx);
         gen_bshfl(ctx, OPC_SEB, rs, rt);
         break;
     case NM_SEH:
@@ -17033,6 +17047,7 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
         gen_arith(ctx, OPC_ADDU, rd, rs, rt);
         break;
     case NM_SUB:
+        check_nms(ctx);
         gen_arith(ctx, OPC_SUB, rd, rs, rt);
         break;
     case NM_SUBU:
@@ -17894,9 +17909,11 @@ static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
         gen_bitswap(ctx, OPC_BITSWAP, ret, rs);
         break;
     case NM_CLO:
+        check_nms(ctx);
         gen_cl(ctx, OPC_CLO, ret, rs);
         break;
     case NM_CLZ:
+        check_nms(ctx);
         gen_cl(ctx, OPC_CLZ, ret, rs);
         break;
     case NM_WSBH:
@@ -18099,6 +18116,7 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
         break;
     case NM_BBEQZC:
     case NM_BBNEZC:
+        check_nms(ctx);
         if (imm >= 32 && !(ctx->hflags & MIPS_HFLAG_64)) {
             generate_exception_end(ctx, EXCP_RI);
             goto out;
@@ -18399,13 +18417,15 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
     if ((extract32(ctx->opcode, 6, 1)) == 1) {
         /* PP.LSXS instructions require shifting */
         switch (extract32(ctx->opcode, 7, 4)) {
-        case NM_LHXS:
         case NM_SHXS:
+            check_nms(ctx);
+        case NM_LHXS:
         case NM_LHUXS:
             tcg_gen_shli_tl(t0, t0, 1);
             break;
-        case NM_LWXS:
         case NM_SWXS:
+            check_nms(ctx);
+        case NM_LWXS:
         case NM_LWC1XS:
         case NM_SWC1XS:
             tcg_gen_shli_tl(t0, t0, 2);
@@ -18448,18 +18468,21 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
         gen_store_gpr(t0, rd);
         break;
     case NM_SBX:
+        check_nms(ctx);
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
                            MO_8);
         break;
     case NM_SHX:
     /*case NM_SHXS:*/
+        check_nms(ctx);
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
                            MO_TEUW);
         break;
     case NM_SWX:
     /*case NM_SWXS:*/
+        check_nms(ctx);
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
                            MO_TEUL);
@@ -19482,22 +19505,26 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             target_long addr_off = extract32(ctx->opcode, 0, 16) | insn << 16;
             switch (extract32(ctx->opcode, 16, 5)) {
             case NM_LI48:
+                check_nms(ctx);
                 if (rt != 0) {
                     tcg_gen_movi_tl(cpu_gpr[rt], addr_off);
                 }
                 break;
             case NM_ADDIU48:
+                check_nms(ctx);
                 if (rt != 0) {
                     tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[rt], addr_off);
                     tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
                 }
                 break;
             case NM_ADDIUGP48:
+                check_nms(ctx);
                 if (rt != 0) {
                     gen_op_addr_addi(ctx, cpu_gpr[rt], cpu_gpr[28], addr_off);
                 }
                 break;
             case NM_ADDIUPC48:
+                check_nms(ctx);
                 if (rt != 0) {
                     target_long addr = addr_add(ctx, ctx->base.pc_next + 6,
                                                 addr_off);
@@ -19506,6 +19533,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 }
                 break;
             case NM_LWPC48:
+                check_nms(ctx);
                 if (rt != 0) {
                     TCGv t0;
                     t0 = tcg_temp_new();
@@ -19519,6 +19547,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 }
                 break;
             case NM_SWPC48:
+                check_nms(ctx);
                 {
                     TCGv t0, t1;
                     t0 = tcg_temp_new();
@@ -19639,6 +19668,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             }
             break;
         case NM_P_ROTX:
+            check_nms(ctx);
             if (rt != 0) {
                 TCGv t0 = tcg_temp_new();
                 TCGv_i32 shift = tcg_const_i32(extract32(ctx->opcode, 0, 5));
@@ -19659,6 +19689,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             switch (((ctx->opcode >> 10) & 2) |
                     (extract32(ctx->opcode, 5, 1))) {
             case NM_INS:
+                check_nms(ctx);
                 gen_bitops(ctx, OPC_INS, rt, rs, extract32(ctx->opcode, 0, 5),
                            extract32(ctx->opcode, 6, 5));
                 break;
@@ -19671,6 +19702,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             switch (((ctx->opcode >> 10) & 2) |
                     (extract32(ctx->opcode, 5, 1))) {
             case NM_EXT:
+                check_nms(ctx);
                 gen_bitops(ctx, OPC_EXT, rt, rs, extract32(ctx->opcode, 0, 5),
                            extract32(ctx->opcode, 6, 5));
                 break;
@@ -19897,6 +19929,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 switch (extract32(ctx->opcode, 11, 4)) {
                 case NM_UALH:
                 case NM_UASH:
+                    check_nms(ctx);
                     {
                         TCGv t0 = tcg_temp_new();
                         TCGv t1 = tcg_temp_new();
@@ -19951,6 +19984,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 break;
             case NM_P_LS_WM:
             case NM_P_LS_UAWM:
+                check_nms(ctx);
                 {
                     int count = extract32(ctx->opcode, 12, 3);
                     int counter = 0;
@@ -19999,6 +20033,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_MOVE_BALC:
+        check_nms(ctx);
         {
             TCGv t0 = tcg_temp_new();
             int32_t s = sextract32(ctx->opcode, 0, 1) << 21 |
@@ -20046,6 +20081,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         extract32(ctx->opcode, 1, 13) << 1;
             switch (extract32(ctx->opcode, 14, 2)) {
             case NM_BEQC:
+                check_nms(ctx);
                 gen_compute_branch_nm(ctx, OPC_BEQ, 4, rs, rt, s);
                 break;
             case NM_P_BR3A:
@@ -20099,6 +20135,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         extract32(ctx->opcode, 1, 13) << 1;
             switch (extract32(ctx->opcode, 14, 2)) {
             case NM_BNEC:
+                check_nms(ctx);
                 gen_compute_branch_nm(ctx, OPC_BNE, 4, rs, rt, s);
                 break;
             case NM_BLTC:
@@ -20271,9 +20308,11 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         switch ((extract32(ctx->opcode, 7, 2) & 0x2) |
                 (extract32(ctx->opcode, 3, 1))) {
         case NM_ADDU4X4:
+            check_nms(ctx);
             gen_arith(ctx, OPC_ADDU, rt, rs, rt);
             break;
         case NM_MUL4X4:
+            check_nms(ctx);
             gen_r6_muldiv(ctx, R6_OPC_MUL, rt, rs, rt);
             break;
         default:
@@ -20346,6 +20385,7 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         gen_ld(ctx, OPC_LW, rt, 29, offset);
         break;
     case NM_LW4X4:
+        check_nms(ctx);
         rt = (extract32(ctx->opcode, 9, 1) << 3) |
              extract32(ctx->opcode, 5, 3);
         rs = (extract32(ctx->opcode, 4, 1) << 3) |
@@ -20357,6 +20397,7 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         gen_ld(ctx, OPC_LW, rt, rs, offset);
         break;
     case NM_SW4X4:
+        check_nms(ctx);
         rt = (extract32(ctx->opcode, 9, 1) << 3) |
              extract32(ctx->opcode, 5, 3);
         rs = (extract32(ctx->opcode, 4, 1) << 3) |
@@ -20454,6 +20495,7 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         break;
     case NM_MOVEP:
     case NM_MOVEPREV:
+        check_nms(ctx);
         {
             static const int gpr2reg1[] = {4, 5, 6, 7};
             static const int gpr2reg2[] = {5, 6, 7, 8};
-- 
2.7.4
