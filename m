Received: from eggs.gnu.org ([2001:4830:134:3::10]:59573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH3B-0005UW-QE
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH35-00076g-3p
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55770 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH34-00073n-Hq
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:34 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:52:57 +0200
Message-Id: <1534182832-554-33-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 32/87] target/mips: Add emulation of some
 common nanoMIPS 32-bit instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of SIGRIE, SYSCALL, BREAK, SDBBP, ADDIU, ADDIUPC,
ADDIUGP.W, LWGP, SWGP, ORI, XORI, ANDI, and other instructions.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 270 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 269 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 868535c..6cd8cec 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16768,6 +16768,274 @@ static void gen_pool16c_nanomips_insn(DisasContext *ctx)
     }
 }
 
+static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint16_t insn;
+    uint32_t op;
+    int rt, rs;
+    int offset;
+    int imm;
+
+    insn = cpu_lduw_code(env, ctx->base.pc_next + 2);
+    ctx->opcode = (ctx->opcode << 16) | insn;
+
+    rt = extract32(ctx->opcode, 21, 5);
+    rs = extract32(ctx->opcode, 16, 5);
+
+    op = extract32(ctx->opcode, 26, 6);
+    switch (op) {
+    case NM_P_ADDIU:
+        if (rt == 0) {
+            /* P.RI */
+            switch (extract32(ctx->opcode, 19, 2)) {
+            case NM_SIGRIE:
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            case NM_P_SYSCALL:
+                if ((extract32(ctx->opcode, 18, 1)) == NM_SYSCALL) {
+                    generate_exception_end(ctx, EXCP_SYSCALL);
+                } else {
+                    generate_exception_end(ctx, EXCP_RI);
+                }
+                break;
+            case NM_BREAK:
+                generate_exception_end(ctx, EXCP_BREAK);
+                break;
+            case NM_SDBBP:
+                if (is_uhi(extract32(ctx->opcode, 0, 19))) {
+                    gen_helper_do_semihosting(cpu_env);
+                } else {
+                    if (ctx->hflags & MIPS_HFLAG_SBRI) {
+                        generate_exception_end(ctx, EXCP_RI);
+                    } else {
+                        generate_exception_end(ctx, EXCP_DBp);
+                    }
+                }
+                break;
+            }
+        } else {
+            imm = extract32(ctx->opcode, 0, 16);
+            if (rs != 0) {
+                tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[rs], imm);
+                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
+            } else {
+                tcg_gen_movi_tl(cpu_gpr[rt], imm);
+            }
+        }
+        break;
+    case NM_ADDIUPC:
+        if (rt != 0) {
+            offset = sextract32(ctx->opcode, 0, 1) << 21 |
+                     extract32(ctx->opcode, 1, 20) << 1;
+            target_long addr = addr_add(ctx, ctx->base.pc_next + 4, offset);
+            tcg_gen_movi_tl(cpu_gpr[rt], addr);
+        }
+        break;
+    case NM_POOL32A:
+        break;
+    case NM_P_GP_W:
+        switch (ctx->opcode & 0x03) {
+        case NM_ADDIUGP_W:
+            if (rt != 0) {
+                offset = extract32(ctx->opcode, 0, 21);
+                gen_op_addr_addi(ctx, cpu_gpr[rt], cpu_gpr[28], offset);
+            }
+            break;
+        case NM_LWGP:
+            gen_ld(ctx, OPC_LW, rt, 28, extract32(ctx->opcode, 2, 19) << 2);
+            break;
+        case NM_SWGP:
+            gen_st(ctx, OPC_SW, rt, 28, extract32(ctx->opcode, 2, 19) << 2);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_P48I:
+        return 6;
+    case NM_P_U12:
+        switch (extract32(ctx->opcode, 12, 4)) {
+        case NM_ORI:
+            gen_logic_imm(ctx, OPC_ORI, rt, rs, extract32(ctx->opcode, 0, 12));
+            break;
+        case NM_XORI:
+            gen_logic_imm(ctx, OPC_XORI, rt, rs, extract32(ctx->opcode, 0, 12));
+            break;
+        case NM_ANDI:
+            gen_logic_imm(ctx, OPC_ANDI, rt, rs, extract32(ctx->opcode, 0, 12));
+            break;
+        case NM_P_SR:
+            switch (extract32(ctx->opcode, 20, 1)) {
+            case NM_PP_SR:
+                switch (ctx->opcode & 3) {
+                case NM_SAVE:
+                    gen_save(ctx, rt, extract32(ctx->opcode, 16, 4),
+                             extract32(ctx->opcode, 2, 1),
+                             extract32(ctx->opcode, 3, 9) << 3);
+                    break;
+                case NM_RESTORE:
+                case NM_RESTORE_JRC:
+                    gen_restore(ctx, rt, extract32(ctx->opcode, 16, 4),
+                                extract32(ctx->opcode, 2, 1),
+                                extract32(ctx->opcode, 3, 9) << 3);
+                    if ((ctx->opcode & 3) == NM_RESTORE_JRC) {
+                        gen_compute_branch(ctx, OPC_JR, 2, 31, 0, 0, 0);
+                    }
+                    break;
+                default:
+                    generate_exception_end(ctx, EXCP_RI);
+                    break;
+                }
+                break;
+            case NM_P_SR_F:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+            break;
+        case NM_SLTI:
+            gen_slt_imm(ctx, OPC_SLTI, rt, rs, extract32(ctx->opcode, 0, 12));
+            break;
+        case NM_SLTIU:
+            gen_slt_imm(ctx, OPC_SLTIU, rt, rs, extract32(ctx->opcode, 0, 12));
+            break;
+        case NM_SEQI:
+            {
+                TCGv t0 = tcg_temp_new();
+
+                imm = extract32(ctx->opcode, 0, 12);
+                gen_load_gpr(t0, rs);
+                tcg_gen_setcondi_tl(TCG_COND_EQ, t0, t0, imm);
+                gen_store_gpr(t0, rt);
+
+                tcg_temp_free(t0);
+            }
+            break;
+        case NM_ADDIUNEG:
+            imm = (int16_t) extract32(ctx->opcode, 0, 12);
+            gen_arith_imm(ctx, OPC_ADDIU, rt, rs, -imm);
+            break;
+        case NM_P_SHIFT:
+            {
+                int shift = extract32(ctx->opcode, 0, 5);
+                switch (extract32(ctx->opcode, 5, 4)) {
+                case NM_P_SLL:
+                    if (rt == 0 && shift == 0) {
+                        /* NOP */
+                    } else if (rt == 0 && shift == 3) {
+                        /* EHB treat as NOP */
+                    } else if (rt == 0 && shift == 5) {
+                        /* PAUSE */
+                        if (ctx->hflags & MIPS_HFLAG_BMASK) {
+                            generate_exception_end(ctx, EXCP_RI);
+                        }
+                    } else if (rt == 0 && shift == 6) {
+                        /* SYNC */
+                        gen_sync(extract32(ctx->opcode, 16, 5));
+                    } else {
+                        /* SLL */
+                        gen_shift_imm(ctx, OPC_SLL, rt, rs,
+                                      extract32(ctx->opcode, 0, 5));
+                    }
+                    break;
+                case NM_SRL:
+                    gen_shift_imm(ctx, OPC_SRL, rt, rs,
+                                  extract32(ctx->opcode, 0, 5));
+                    break;
+                case NM_SRA:
+                    gen_shift_imm(ctx, OPC_SRA, rt, rs,
+                                  extract32(ctx->opcode, 0, 5));
+                    break;
+                case NM_ROTR:
+                    gen_shift_imm(ctx, OPC_ROTR, rt, rs,
+                                  extract32(ctx->opcode, 0, 5));
+                    break;
+                }
+            }
+            break;
+        case NM_P_ROTX:
+            break;
+        case NM_P_INS:
+            switch (((ctx->opcode >> 10) & 2) |
+                    (extract32(ctx->opcode, 5, 1))) {
+            case NM_INS:
+                gen_bitops(ctx, OPC_INS, rt, rs, extract32(ctx->opcode, 0, 5),
+                           extract32(ctx->opcode, 6, 5));
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+            break;
+        case NM_P_EXT:
+            switch (((ctx->opcode >> 10) & 2) |
+                    (extract32(ctx->opcode, 5, 1))) {
+            case NM_EXT:
+                gen_bitops(ctx, OPC_EXT, rt, rs, extract32(ctx->opcode, 0, 5),
+                           extract32(ctx->opcode, 6, 5));
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case NM_POOL32F:
+        break;
+    case NM_POOL32S:
+        break;
+    case NM_P_LUI:
+        switch (extract32(ctx->opcode, 1, 1)) {
+        case NM_LUI:
+            if (rt != 0) {
+                tcg_gen_movi_tl(cpu_gpr[rt],
+                                sextract32(ctx->opcode, 0, 1) << 31 |
+                                extract32(ctx->opcode, 2, 10) << 21 |
+                                extract32(ctx->opcode, 12, 9) << 12);
+            }
+            break;
+        case NM_ALUIPC:
+            if (rt != 0) {
+                offset = sextract32(ctx->opcode, 0, 1) << 31 |
+                         extract32(ctx->opcode, 2, 10) << 21 |
+                         extract32(ctx->opcode, 12, 9) << 12;
+                target_long addr;
+                addr = ~0xFFF & addr_add(ctx, ctx->base.pc_next + 4, offset);
+                tcg_gen_movi_tl(cpu_gpr[rt], addr);
+            }
+            break;
+        }
+        break;
+    case NM_P_GP_BH:
+        break;
+    case NM_P_LS_U12:
+        break;
+    case NM_P_LS_S9:
+        break;
+    case NM_MOVE_BALC:
+        break;
+    case NM_P_BAL:
+        break;
+    case NM_P_J:
+        break;
+    case NM_P_BR1:
+        break;
+    case NM_P_BR2:
+        break;
+    case NM_P_BRI:
+        break;
+    default:
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+    return 4;
+}
+
 static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t op;
@@ -17085,7 +17353,7 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
     case NM_MOVEPREV:
         break;
     default:
-        break;
+        return decode_nanomips_32_48_opc(env, ctx);
     }
 
     return 2;
-- 
2.7.4
