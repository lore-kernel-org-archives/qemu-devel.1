Received: from eggs.gnu.org ([2001:4830:134:3::10]:56178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJlA-0005Uq-6W
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJkv-0000hW-Dc
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:20 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43521 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJku-0000e3-NI
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:09 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:57:32 +0200
Message-Id: <1534431497-1385-40-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v9 39/84] target/mips: Add emulation of
 nanoMIPS 32-bit branch instructions
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

From: Stefan Markovic <smarkovic@wavecomp.com>

Add emulation of various flavors of nanoMIPS 32-bit branch
instructions.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 397 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 397 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3648079..dcb3d25 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17081,6 +17081,290 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+/* Immediate Value Compact Branches */
+static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
+                                   int rt, int32_t imm, int32_t offset)
+{
+    TCGCond cond;
+    int bcond_compute = 0;
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+    gen_load_gpr(t0, rt);
+    tcg_gen_movi_tl(t1, imm);
+    ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
+
+    /* Load needed operands and calculate btarget */
+    switch (opc) {
+    case NM_BEQIC:
+        if (rt == 0 && imm == 0) {
+            /* Unconditional branch */
+        } else if (rt == 0 && imm != 0) {
+            /* Treat as NOP */
+            goto out;
+        } else {
+            bcond_compute = 1;
+            cond = TCG_COND_EQ;
+        }
+        break;
+    case NM_BBEQZC:
+    case NM_BBNEZC:
+        if (imm >= 32 && !(ctx->hflags & MIPS_HFLAG_64)) {
+            generate_exception_end(ctx, EXCP_RI);
+            goto out;
+        } else if (rt == 0 && opc == NM_BBEQZC) {
+            /* Unconditional branch */
+        } else if (rt == 0 && opc == NM_BBNEZC) {
+            /* Treat as NOP */
+            goto out;
+        } else {
+            tcg_gen_shri_tl(t0, t0, imm);
+            tcg_gen_andi_tl(t0, t0, 1);
+            tcg_gen_movi_tl(t1, 0);
+            bcond_compute = 1;
+            if (opc == NM_BBEQZC) {
+                cond = TCG_COND_EQ;
+            } else {
+                cond = TCG_COND_NE;
+            }
+        }
+        break;
+    case NM_BNEIC:
+        if (rt == 0 && imm == 0) {
+            /* Treat as NOP */
+            goto out;
+        } else if (rt == 0 && imm != 0) {
+            /* Unconditional branch */
+        } else {
+            bcond_compute = 1;
+            cond = TCG_COND_NE;
+        }
+        break;
+    case NM_BGEIC:
+        if (rt == 0 && imm == 0) {
+            /* Unconditional branch */
+        } else  {
+            bcond_compute = 1;
+            cond = TCG_COND_GE;
+        }
+        break;
+    case NM_BLTIC:
+        bcond_compute = 1;
+        cond = TCG_COND_LT;
+        break;
+    case NM_BGEIUC:
+        if (rt == 0 && imm == 0) {
+            /* Unconditional branch */
+        } else  {
+            bcond_compute = 1;
+            cond = TCG_COND_GEU;
+        }
+        break;
+    case NM_BLTIUC:
+        bcond_compute = 1;
+        cond = TCG_COND_LTU;
+        break;
+    default:
+        MIPS_INVAL("Immediate Value Compact branch");
+        generate_exception_end(ctx, EXCP_RI);
+        goto out;
+    }
+
+    if (bcond_compute == 0) {
+        /* Uncoditional compact branch */
+        gen_goto_tb(ctx, 0, ctx->btarget);
+    } else {
+        /* Conditional compact branch */
+        TCGLabel *fs = gen_new_label();
+        save_cpu_state(ctx, 0);
+
+        tcg_gen_brcond_tl(tcg_invert_cond(cond), t0, t1, fs);
+
+        gen_goto_tb(ctx, 1, ctx->btarget);
+        gen_set_label(fs);
+
+        gen_goto_tb(ctx, 0, ctx->base.pc_next + 4);
+    }
+
+out:
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
+/* P.BALRSC type nanoMIPS R6 branches: BALRSC and BRSC */
+static void gen_compute_nanomips_pbalrsc_branch(DisasContext *ctx, int rs,
+                                                int rt)
+{
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+    /* load rs */
+    gen_load_gpr(t0, rs);
+
+    /* link */
+    if (rt != 0) {
+        tcg_gen_movi_tl(cpu_gpr[rt], ctx->base.pc_next + 4);
+    }
+
+    /* calculate btarget */
+    tcg_gen_shli_tl(t0, t0, 1);
+    tcg_gen_movi_tl(t1, ctx->base.pc_next + 4);
+    gen_op_addr_add(ctx, btarget, t1, t0);
+
+    /* unconditional branch to register */
+    tcg_gen_mov_tl(cpu_PC, btarget);
+    if (ctx->base.singlestep_enabled) {
+        save_cpu_state(ctx, 0);
+        gen_helper_raise_exception_debug(cpu_env);
+    }
+    tcg_gen_lookup_and_goto_ptr();
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
+/* nanoMIPS Branches */
+static void gen_compute_compact_branch_nm(DisasContext *ctx, uint32_t opc,
+                                       int rs, int rt, int32_t offset)
+{
+    int bcond_compute = 0;
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+    /* Load needed operands and calculate btarget */
+    switch (opc) {
+    /* compact branch */
+    case OPC_BGEC:
+    case OPC_BLTC:
+        gen_load_gpr(t0, rs);
+        gen_load_gpr(t1, rt);
+        bcond_compute = 1;
+        ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
+        break;
+    case OPC_BGEUC:
+    case OPC_BLTUC:
+        if (rs == 0 || rs == rt) {
+            /* OPC_BLEZALC, OPC_BGEZALC */
+            /* OPC_BGTZALC, OPC_BLTZALC */
+            tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4);
+        }
+        gen_load_gpr(t0, rs);
+        gen_load_gpr(t1, rt);
+        bcond_compute = 1;
+        ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
+        break;
+    case OPC_BC:
+        ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
+        break;
+    case OPC_BEQZC:
+        if (rs != 0) {
+            /* OPC_BEQZC, OPC_BNEZC */
+            gen_load_gpr(t0, rs);
+            bcond_compute = 1;
+            ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
+        } else {
+            /* OPC_JIC, OPC_JIALC */
+            TCGv tbase = tcg_temp_new();
+            TCGv toffset = tcg_temp_new();
+
+            gen_load_gpr(tbase, rt);
+            tcg_gen_movi_tl(toffset, offset);
+            gen_op_addr_add(ctx, btarget, tbase, toffset);
+            tcg_temp_free(tbase);
+            tcg_temp_free(toffset);
+        }
+        break;
+    default:
+        MIPS_INVAL("Compact branch/jump");
+        generate_exception_end(ctx, EXCP_RI);
+        goto out;
+    }
+
+    if (bcond_compute == 0) {
+        /* Uncoditional compact branch */
+        switch (opc) {
+        case OPC_BC:
+            gen_goto_tb(ctx, 0, ctx->btarget);
+            break;
+        default:
+            MIPS_INVAL("Compact branch/jump");
+            generate_exception_end(ctx, EXCP_RI);
+            goto out;
+        }
+    } else {
+        /* Conditional compact branch */
+        TCGLabel *fs = gen_new_label();
+        save_cpu_state(ctx, 0);
+
+        switch (opc) {
+        case OPC_BGEUC:
+            if (rs == 0 && rt != 0) {
+                /* OPC_BLEZALC */
+                tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_LE), t1, 0, fs);
+            } else if (rs != 0 && rt != 0 && rs == rt) {
+                /* OPC_BGEZALC */
+                tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_GE), t1, 0, fs);
+            } else {
+                /* OPC_BGEUC */
+                tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_GEU), t0, t1, fs);
+            }
+            break;
+        case OPC_BLTUC:
+            if (rs == 0 && rt != 0) {
+                /* OPC_BGTZALC */
+                tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_GT), t1, 0, fs);
+            } else if (rs != 0 && rt != 0 && rs == rt) {
+                /* OPC_BLTZALC */
+                tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_LT), t1, 0, fs);
+            } else {
+                /* OPC_BLTUC */
+                tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_LTU), t0, t1, fs);
+            }
+            break;
+        case OPC_BGEC:
+            if (rs == 0 && rt != 0) {
+                /* OPC_BLEZC */
+                tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_LE), t1, 0, fs);
+            } else if (rs != 0 && rt != 0 && rs == rt) {
+                /* OPC_BGEZC */
+                tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_GE), t1, 0, fs);
+            } else {
+                /* OPC_BGEC */
+                tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_GE), t0, t1, fs);
+            }
+            break;
+        case OPC_BLTC:
+            if (rs == 0 && rt != 0) {
+                /* OPC_BGTZC */
+                tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_GT), t1, 0, fs);
+            } else if (rs != 0 && rt != 0 && rs == rt) {
+                /* OPC_BLTZC */
+                tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_LT), t1, 0, fs);
+            } else {
+                /* OPC_BLTC */
+                tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_LT), t0, t1, fs);
+            }
+            break;
+        case OPC_BEQZC:
+            tcg_gen_brcondi_tl(tcg_invert_cond(TCG_COND_EQ), t0, 0, fs);
+            break;
+        default:
+            MIPS_INVAL("Compact conditional branch/jump");
+            generate_exception_end(ctx, EXCP_RI);
+            goto out;
+        }
+
+        /* Generating branch here as compact branches don't have delay slot */
+        gen_goto_tb(ctx, 1, ctx->btarget);
+        gen_set_label(fs);
+
+        gen_goto_tb(ctx, 0, ctx->base.pc_next + 4);
+    }
+
+out:
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
 
 static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
 {
@@ -18142,16 +18426,129 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_MOVE_BALC:
+        {
+            TCGv t0 = tcg_temp_new();
+            int32_t s = sextract32(ctx->opcode, 0, 1) << 21 |
+                        extract32(ctx->opcode, 1, 20) << 1;
+            rd = (extract32(ctx->opcode, 24, 1)) == 0 ? 4 : 5;
+            rt = decode_gpr_gpr4_zero(extract32(ctx->opcode, 25, 1) << 3 |
+                            extract32(ctx->opcode, 21, 3));
+            gen_load_gpr(t0, rt);
+            tcg_gen_mov_tl(cpu_gpr[rd], t0);
+            gen_compute_branch(ctx, OPC_BGEZAL, 4, 0, 0, s, 0);
+            tcg_temp_free(t0);
+        }
         break;
     case NM_P_BAL:
+        {
+            int32_t s = sextract32(ctx->opcode, 0, 1) << 25 |
+                        extract32(ctx->opcode, 1, 24) << 1;
+
+            if ((extract32(ctx->opcode, 25, 1)) == 0) {
+                /* BC */
+                gen_compute_branch(ctx, OPC_BEQ, 4, 0, 0, s, 0);
+            } else {
+                /* BALC */
+                gen_compute_branch(ctx, OPC_BGEZAL, 4, 0, 0, s, 0);
+            }
+        }
         break;
     case NM_P_J:
+        switch (extract32(ctx->opcode, 12, 4)) {
+        case NM_JALRC:
+        case NM_JALRC_HB:
+            gen_compute_branch(ctx, OPC_JALR, 4, rs, rt, 0, 0);
+            break;
+        case NM_P_BALRSC:
+            gen_compute_nanomips_pbalrsc_branch(ctx, rs, rt);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
         break;
     case NM_P_BR1:
+        {
+            int32_t s = sextract32(ctx->opcode, 0, 1) << 14 |
+                        extract32(ctx->opcode, 1, 13) << 1;
+            switch (extract32(ctx->opcode, 14, 2)) {
+            case NM_BEQC:
+                gen_compute_branch(ctx, OPC_BEQ, 4, rs, rt, s, 0);
+                break;
+            case NM_P_BR3A:
+                s = sextract32(ctx->opcode, 0, 1) << 14 |
+                    extract32(ctx->opcode, 1, 13) << 1;
+                check_cp1_enabled(ctx);
+                switch (extract32(ctx->opcode, 16, 5)) {
+                case NM_BC1EQZC:
+                    gen_compute_branch1_r6(ctx, OPC_BC1EQZ, rt, s, 0);
+                    break;
+                case NM_BC1NEZC:
+                    gen_compute_branch1_r6(ctx, OPC_BC1NEZ, rt, s, 0);
+                    break;
+                default:
+                    generate_exception_end(ctx, EXCP_RI);
+                    break;
+                }
+                break;
+            case NM_BGEC:
+                if (rs == rt) {
+                    gen_compute_compact_branch_nm(ctx, OPC_BC, rs, rt, s);
+                } else {
+                    gen_compute_compact_branch_nm(ctx, OPC_BGEC, rs, rt, s);
+                }
+                break;
+            case NM_BGEUC:
+                if (rs == rt || rt == 0) {
+                    gen_compute_compact_branch_nm(ctx, OPC_BC, 0, 0, s);
+                } else if (rs == 0) {
+                    gen_compute_compact_branch_nm(ctx, OPC_BEQZC, rt, 0, s);
+                } else {
+                    gen_compute_compact_branch_nm(ctx, OPC_BGEUC, rs, rt, s);
+                }
+                break;
+            }
+        }
         break;
     case NM_P_BR2:
+        {
+            int32_t s = sextract32(ctx->opcode, 0, 1) << 14 |
+                        extract32(ctx->opcode, 1, 13) << 1;
+            switch (extract32(ctx->opcode, 14, 2)) {
+            case NM_BNEC:
+                gen_compute_branch(ctx, OPC_BNE, 4, rs, rt, s, 0);
+                break;
+            case NM_BLTC:
+                if (rs != 0 && rt != 0 && rs == rt) {
+                    /* NOP */
+                    ctx->hflags |= MIPS_HFLAG_FBNSLOT;
+                } else {
+                    gen_compute_compact_branch_nm(ctx, OPC_BLTC, rs, rt, s);
+                }
+                break;
+            case NM_BLTUC:
+                if (rs == 0 || rs == rt) {
+                    /* NOP */
+                    ctx->hflags |= MIPS_HFLAG_FBNSLOT;
+                } else {
+                    gen_compute_compact_branch_nm(ctx, OPC_BLTUC, rs, rt, s);
+                }
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+        }
         break;
     case NM_P_BRI:
+        {
+            int32_t s = sextract32(ctx->opcode, 0, 1) << 11 |
+                        extract32(ctx->opcode, 1, 10) << 1;
+            uint32_t u = extract32(ctx->opcode, 11, 7);
+
+            gen_compute_imm_branch(ctx, extract32(ctx->opcode, 18, 3),
+                                   rt, u, s);
+        }
         break;
     default:
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4
