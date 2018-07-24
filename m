Received: from eggs.gnu.org ([2001:4830:134:3::10]:41265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1NK-0004JA-Lp
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1NH-0002mm-I3
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:45:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46310 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi1NH-0002lO-2V
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:45:27 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:31:18 +0200
Message-Id: <1532453527-22911-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 06/55] target/mips: Add emulation of misc
 nanoMIPS 16-bit instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of misc nanoMIPS 16-bit instructions from instruction
pools P16, P16.BR, P16.BRI, P16.4X4 and other related pools.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 260 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 260 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2ddc6c9..076637c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16512,6 +16512,266 @@ static inline int decode_gpr_gpr4_zero(int r)
 
 static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
 {
+    uint32_t op;
+    int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD(ctx->opcode));
+    int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
+    int rd = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS1(ctx->opcode));
+
+    /* make sure instructions are on a halfword boundary */
+    if (ctx->base.pc_next & 0x1) {
+        TCGv tmp = tcg_const_tl(ctx->base.pc_next);
+        tcg_gen_st_tl(tmp, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
+        tcg_temp_free(tmp);
+        return 2;
+    }
+
+    op = extract32(ctx->opcode, 10, 6);
+    switch (op) {
+    case NM_P16_MV:
+        {
+            int rt1 = NANOMIPS_EXTRACT_RD5(ctx->opcode);
+            if (rt1 != 0) {
+                /* MOVE */
+                int rs1 = NANOMIPS_EXTRACT_RS5(ctx->opcode);
+                gen_arith(ctx, OPC_ADDU, rt1, rs1, 0);
+            } else {
+                /* P16.RI */
+                switch (extract32(ctx->opcode, 3, 2)) {
+                case NM_P16_SYSCALL:
+                    if (extract32(ctx->opcode, 2, 1) == 0) {
+                        generate_exception_end(ctx, EXCP_SYSCALL);
+                    } else {
+                        generate_exception_end(ctx, EXCP_RI);
+                    }
+                    break;
+                case NM_BREAK16:
+                    generate_exception_end(ctx, EXCP_BREAK);
+                    break;
+                case NM_SDBBP16:
+                    if (is_uhi(extract32(ctx->opcode, 0, 3))) {
+                        gen_helper_do_semihosting(cpu_env);
+                    } else {
+                        if (ctx->hflags & MIPS_HFLAG_SBRI) {
+                            generate_exception_end(ctx, EXCP_RI);
+                        } else {
+                            generate_exception_end(ctx, EXCP_DBp);
+                        }
+                    }
+                    break;
+                default:
+                    generate_exception_end(ctx, EXCP_RI);
+                    break;
+                }
+            }
+        }
+        break;
+    case NM_P16_SHIFT:
+        {
+            int shift = extract32(ctx->opcode, 0, 3);
+            uint32_t opc = 0;
+            shift = (shift == 0) ? 8 : shift;
+
+            switch (extract32(ctx->opcode, 3, 1)) {
+            case NM_SLL16:
+                opc = OPC_SLL;
+                break;
+            case NM_SRL16:
+                opc = OPC_SRL;
+                break;
+            }
+            gen_shift_imm(ctx, opc, rt, rs, shift);
+        }
+        break;
+    case NM_P16C:
+        break;
+    case NM_P16_A1:
+        switch (extract32(ctx->opcode, 6, 1)) {
+        case NM_ADDIUR1SP:
+            gen_arith_imm(ctx, OPC_ADDIU, rt, 29,
+                          extract32(ctx->opcode, 0, 6) << 2);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_P16_A2:
+        switch (extract32(ctx->opcode, 3, 1)) {
+        case NM_ADDIUR2:
+            {
+                uint8_t u = extract32(ctx->opcode, 0, 3) << 2;
+                gen_arith_imm(ctx, OPC_ADDIU, rt, rs, u);
+            }
+            break;
+        case NM_P_ADDIURS5:
+            {
+                int rt1 = extract32(ctx->opcode, 5, 5);
+                if (rt1 != 0) {
+                    int s = (sextract32(ctx->opcode, 4, 1) << 3) |
+                            extract32(ctx->opcode, 0, 3);
+                    /* s = sign_extend( s[3] . s[2:0] , from_nbits = 4)*/
+                    gen_arith_imm(ctx, OPC_ADDIU, rt1, rt1, s);
+                }
+            }
+            break;
+        }
+        break;
+    case NM_P16_ADDU:
+        switch (ctx->opcode & 0x1) {
+        case NM_ADDU16:
+            gen_arith(ctx, OPC_ADDU, rd, rs, rt);
+            break;
+        case NM_SUBU16:
+            gen_arith(ctx, OPC_SUBU, rd, rs, rt);
+            break;
+        }
+        break;
+    case NM_P16_4X4:
+        {
+            int rt1 = (extract32(ctx->opcode, 9, 1) << 3) |
+                      extract32(ctx->opcode, 5, 3);
+            int rs1 = (extract32(ctx->opcode, 4, 1) << 3) |
+                      extract32(ctx->opcode, 0, 3);
+            rt1 = decode_gpr_gpr4(rt1);
+            rs1 = decode_gpr_gpr4(rs1);
+
+            switch (((ctx->opcode >> 7) & 0x2) | ((ctx->opcode >> 3) & 0x1)) {
+            case NM_ADDU4X4:
+                gen_arith(ctx, OPC_ADDU, rt1, rs1, rt1);
+                break;
+            case NM_MUL4X4:
+                gen_r6_muldiv(ctx, R6_OPC_MUL, rt1, rs1, rt1);
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+        }
+        break;
+    case NM_LI16:
+        {
+            int imm = extract32(ctx->opcode, 0, 7);
+            imm = (imm == 0x7f ? -1 : imm);
+            if (rt != 0) {
+                tcg_gen_movi_tl(cpu_gpr[rt], imm);
+            }
+        }
+        break;
+    case NM_ANDI16:
+        {
+            uint32_t u = extract32(ctx->opcode, 0, 4);
+            u = (u == 12) ? 0xff :
+                (u == 13) ? 0xffff : u;
+            gen_logic_imm(ctx, OPC_ANDI, rt, rs, u);
+        }
+        break;
+    case NM_P16_LB:
+        break;
+    case NM_P16_LH:
+        break;
+    case NM_LW16:
+        break;
+    case NM_LWSP16:
+        break;
+    case NM_LW4X4:
+        break;
+    case NM_SW4X4:
+        break;
+    case NM_LWGP16:
+        break;
+    case NM_SWSP16:
+        break;
+    case NM_SW16:
+        break;
+    case NM_SWGP16:
+        break;
+    case NM_BC16:
+        gen_compute_branch(ctx, OPC_BEQ, 2, 0, 0,
+                           (sextract32(ctx->opcode, 0, 1) << 10) |
+                           (extract32(ctx->opcode, 1, 9) << 1), 0);
+        break;
+    case NM_BALC16:
+        gen_compute_branch(ctx, OPC_BGEZAL, 2, 0, 0,
+                           (sextract32(ctx->opcode, 0, 1) << 10) |
+                           (extract32(ctx->opcode, 1, 9) << 1), 0);
+        break;
+    case NM_BEQZC16:
+    case NM_BNEZC16:
+        gen_compute_branch(ctx, op == NM_BNEZC16 ? OPC_BNE : OPC_BEQ, 2,
+                           rt, 0,
+                           (sextract32(ctx->opcode, 0, 1) << 7) |
+                           (extract32(ctx->opcode, 1, 6) << 1), 0);
+        break;
+    case NM_P16_BR:
+        switch (ctx->opcode & 0xf) {
+        case 0:
+            /* P16.JRC */
+            switch (extract32(ctx->opcode, 4, 1)) {
+            case NM_JRC:
+                gen_compute_branch(ctx, OPC_JR, 2,
+                                   extract32(ctx->opcode, 5, 5), 0, 0, 0);
+                break;
+            case NM_JALRC16:
+                gen_compute_branch(ctx, OPC_JALR, 2,
+                                   extract32(ctx->opcode, 5, 5), 31, 0, 0);
+                break;
+            }
+            break;
+        default:
+            /* P16.BRI */
+            if (extract32(ctx->opcode, 4, 3) < extract32(ctx->opcode, 7, 3)) {
+                /* BEQC16 */
+                gen_compute_branch(ctx, OPC_BEQ, 2, rs, rt,
+                                   extract32(ctx->opcode, 0, 4) << 1, 0);
+            } else {
+                /* BNEC16 */
+                gen_compute_branch(ctx, OPC_BNE, 2, rs, rt,
+                                   extract32(ctx->opcode, 0, 4) << 1, 0);
+            }
+            break;
+        }
+        break;
+    case NM_P16_SR:
+        break;
+    case NM_MOVEP:
+    case NM_MOVEPREV:
+        {
+            static const int gpr2reg1[] = {4, 5, 6, 7};
+            static const int gpr2reg2[] = {5, 6, 7, 8};
+            int re;
+            int rd2 = extract32(ctx->opcode, 3, 1) << 1 |
+                      extract32(ctx->opcode, 8, 1);
+            int r1 = gpr2reg1[rd2];
+            int r2 = gpr2reg2[rd2];
+            int r3 = extract32(ctx->opcode, 4, 1) << 3 |
+                     extract32(ctx->opcode, 0, 3);
+            int r4 = extract32(ctx->opcode, 9, 1) << 3 |
+                     extract32(ctx->opcode, 5, 3);
+            TCGv t0 = tcg_temp_new();
+            TCGv t1 = tcg_temp_new();
+            if (op == NM_MOVEP) {
+                rd = r1;
+                re = r2;
+                rs = decode_gpr_gpr4_zero(r3);
+                rt = decode_gpr_gpr4_zero(r4);
+            } else {
+                rd = decode_gpr_gpr4(r3);
+                re = decode_gpr_gpr4(r4);
+                rs = r1;
+                rt = r2;
+            }
+            gen_load_gpr(t0, rs);
+            gen_load_gpr(t1, rt);
+            tcg_gen_mov_tl(cpu_gpr[rd], t0);
+            tcg_gen_mov_tl(cpu_gpr[re], t1);
+            tcg_temp_free(t0);
+            tcg_temp_free(t1);
+        }
+        break;
+    default:
+        break;
+    }
+
     return 2;
 }
 
-- 
2.7.4
