Received: from eggs.gnu.org ([2001:4830:134:3::10]:52441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8XA-0003ZG-3n
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8U5-0005GJ-Lg
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:59:52 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56851 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8U4-0005Dd-Sx
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:56:41 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:54:42 +0200
Message-Id: <1532004912-13899-11-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 10/40] target/mips: Add emulation of some
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of SIGRIE, SYSCALL, BREAK, SDBBP, ADDIU, ADDIUPC,
ADDIUGP.W, LWGP, SWGP, ORI, XORI, ANDI, and other instructions.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 285 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 284 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2237597..201baf1 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16588,6 +16588,289 @@ static void gen_pool16c_nanomips_insn(DisasContext *ctx)
     }
 }
 
+static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint16_t insn;
+    int rt, rs;
+    uint32_t op;
+
+    insn = cpu_lduw_code(env, ctx->base.pc_next + 2);
+    ctx->opcode = (ctx->opcode << 16) | insn;
+
+    rt = (ctx->opcode >> 21) & 0x1f;
+    rs = (ctx->opcode >> 16) & 0x1f;
+
+    op = (ctx->opcode >> 26) & 0x3f;
+    switch (op) {
+    case NM_P_ADDIU:
+        if (rt == 0) {
+            /* P.RI */
+            switch ((ctx->opcode >> 19) & 0x03) {
+            case NM_SIGRIE:
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            case NM_P_SYSCALL:
+                if (((ctx->opcode >> 18) & 0x01) == NM_SYSCALL) {
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
+            uint16_t imm;
+            imm = (uint16_t) extract32(ctx->opcode, 0, 16);
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
+            int32_t offset = sextract32(ctx->opcode, 0, 1) << 21
+                            | extract32(ctx->opcode, 1, 20) << 1;
+            target_long addr = addr_add(ctx, ctx->base.pc_next + 4, offset);
+            tcg_gen_movi_tl(cpu_gpr[rt], addr);
+            tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
+        }
+        break;
+    case NM_POOL32A:
+        break;
+    case NM_P_GP_W:
+        switch (ctx->opcode & 0x03) {
+        case NM_ADDIUGP_W:
+            if (rt != 0) {
+                uint32_t offset = extract32(ctx->opcode, 0, 21);
+                if (offset == 0) {
+                    gen_load_gpr(cpu_gpr[rt], 28);
+                } else {
+                    TCGv t0;
+                    t0 = tcg_temp_new();
+                    tcg_gen_movi_tl(t0, offset);
+                    gen_op_addr_add(ctx, cpu_gpr[rt], cpu_gpr[28], t0);
+                    tcg_temp_free(t0);
+                }
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
+        switch ((ctx->opcode >> 12) & 0x0f) {
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
+            switch ((ctx->opcode >> 20) & 1) {
+            case NM_PP_SR:
+                switch (ctx->opcode & 3) {
+                case NM_SAVE:
+                    gen_save(ctx, rt, extract32(ctx->opcode, 16, 4),
+                             (ctx->opcode >> 2) & 1,
+                             extract32(ctx->opcode, 3, 9) << 3);
+                    break;
+                case NM_RESTORE:
+                case NM_RESTORE_JRC:
+                    gen_restore(ctx, rt, extract32(ctx->opcode, 16, 4),
+                                (ctx->opcode >> 2) & 1,
+                                extract32(ctx->opcode, 3, 9) << 3);
+                    if ((ctx->opcode & 3) == NM_RESTORE_JRC) {
+                        gen_compute_branch(ctx, OPC_JR, 2, 31, 0, 0, 0);
+                    }
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
+                TCGv t1 = tcg_temp_new();
+                TCGv t2 = tcg_temp_local_new();
+                TCGLabel *l1 = gen_new_label();
+
+                gen_load_gpr(t0, rs);
+                tcg_gen_movi_tl(t1, extract32(ctx->opcode, 0, 12));
+                tcg_gen_movi_tl(t2, 0);
+                tcg_gen_brcond_tl(TCG_COND_NE, t0, t1, l1);
+                tcg_gen_movi_tl(t2, 1);
+                gen_set_label(l1);
+                gen_store_gpr(t2, rt);
+
+                tcg_temp_free(t0);
+                tcg_temp_free(t1);
+                tcg_temp_free(t2);
+            }
+            break;
+        case NM_ADDIUNEG:
+            {
+                int16_t imm;
+                imm = (int16_t) extract32(ctx->opcode, 0, 12);
+                gen_arith_imm(ctx, OPC_ADDIU, rt, rs, -imm);
+            }
+            break;
+        case NM_P_SHIFT:
+            {
+                int shift = extract32(ctx->opcode, 0, 5);
+                switch ((ctx->opcode >> 5) & 0x0f) {
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
+                        check_insn(ctx, ISA_MIPS2);
+                        /* Treat as NOP. */
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
+            switch (((ctx->opcode >> 10) & 2) | ((ctx->opcode >> 5) & 1)) {
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
+            switch (((ctx->opcode >> 10) & 2) | ((ctx->opcode >> 5) & 1)) {
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
+        switch ((ctx->opcode >> 1) & 1) {
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
+                int offset = sextract32(ctx->opcode, 0, 1) << 31 |
+                             extract32(ctx->opcode, 2, 10) << 21 |
+                             extract32(ctx->opcode, 12, 9) << 12;
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
@@ -16966,7 +17249,7 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     default:
-        break;
+        return decode_nanomips_32_48_opc(env, ctx);
     }
 
     return 2;
-- 
2.7.4
