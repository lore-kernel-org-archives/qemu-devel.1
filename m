Received: from eggs.gnu.org ([2001:4830:134:3::10]:50804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8WP-0003Jn-Fe
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8VL-0006IW-FJ
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:59:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57353 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8VK-0006HR-So
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:57:59 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:54:51 +0200
Message-Id: <1532004912-13899-20-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 19/40] target/mips: Add emulation of
 nanoMIPS branch instructions
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

Add emulation of various flavors of nanoMIPS branch instructions.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 277 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 5dc6582..50b31de 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16871,6 +16871,168 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+/* Immediate Value Compact Branches */
+static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
+                                   int rt, int32_t imm, int32_t offset)
+{
+    int bcond_compute = 0;
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+
+    if (ctx->hflags & MIPS_HFLAG_BMASK) {
+#ifdef MIPS_DEBUG_DISAS
+        LOG_DISAS("Branch in delay / forbidden slot at PC 0x" TARGET_FMT_lx
+                  "\n", ctx->base.pc_next);
+#endif
+        generate_exception_end(ctx, EXCP_RI);
+        goto out;
+    }
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
+        }
+        break;
+    case NM_BGEIC:
+        if (rt == 0 && imm == 0) {
+            /* Unconditional branch */
+        } else  {
+            bcond_compute = 1;
+        }
+        break;
+    case NM_BLTIC:
+        bcond_compute = 1;
+        break;
+    case NM_BGEIUC:
+        if (rt == 0 && imm == 0) {
+            /* Unconditional branch */
+        } else  {
+            bcond_compute = 1;
+        }
+        break;
+    case NM_BLTIUC:
+        bcond_compute = 1;
+        break;
+    default:
+        MIPS_INVAL("Immediate Value Compact branch");
+        generate_exception_end(ctx, EXCP_RI);
+        goto out;
+    }
+
+    if (bcond_compute == 0) {
+        /* Uncoditional compact branch */
+        ctx->hflags |= MIPS_HFLAG_B;
+        /* Generating branch here as compact branches don't have delay slot */
+        gen_branch(ctx, 4);
+    } else {
+        /* Conditional compact branch */
+        TCGLabel *fs = gen_new_label();
+        save_cpu_state(ctx, 0);
+
+        switch (opc) {
+        case NM_BEQIC:
+            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_EQ), t0, t1, fs);
+            break;
+        case NM_BBEQZC:
+            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_EQ), t0, t1, fs);
+            break;
+        case NM_BNEIC:
+            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_NE), t0, t1, fs);
+            break;
+        case NM_BBNEZC:
+            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_NE), t0, t1, fs);
+            break;
+        case NM_BGEIC:
+            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_GE), t0, t1, fs);
+            break;
+        case NM_BLTIC:
+            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_LT), t0, t1, fs);
+            break;
+        case NM_BGEIUC:
+            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_GEU), t0, t1, fs);
+            break;
+        case NM_BLTIUC:
+            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_LTU), t0, t1, fs);
+            break;
+        }
+
+        /* Generating branch here as compact branches don't have delay slot */
+        gen_goto_tb(ctx, 1, ctx->btarget);
+        gen_set_label(fs);
+
+        ctx->hflags |= MIPS_HFLAG_FBNSLOT;
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
+    ctx->hflags |= MIPS_HFLAG_BR;
+    /* Generating branch here as compact branches don't have delay slot */
+    gen_branch(ctx, 4);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
 
 static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
 {
@@ -17945,16 +18107,131 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
     }
         break;
     case NM_MOVE_BALC:
+    {
+        TCGv t0 = tcg_temp_new();
+        int32_t s = sextract32(ctx->opcode, 0, 1) << 21 |
+                    extract32(ctx->opcode, 1, 20) << 1;
+        rd = ((ctx->opcode >> 24) & 1) == 0 ? 4 : 5;
+        rt = decode_gpr_gpr4_zero(extract32(ctx->opcode, 25, 1) << 3 |
+                        extract32(ctx->opcode, 21, 3));
+        gen_load_gpr(t0, rt);
+        tcg_gen_mov_tl(cpu_gpr[rd], t0);
+        gen_compute_branch(ctx, OPC_BGEZAL, 4, 0, 0, s, 0);
+        tcg_temp_free(t0);
+    }
         break;
     case NM_P_BAL:
+        {
+            int32_t s = sextract32(ctx->opcode, 0, 1) << 25 |
+                        extract32(ctx->opcode, 1, 24) << 1;
+
+            if (((ctx->opcode >> 25) & 1) == 0) {
+                /* BC */
+                gen_compute_branch(ctx, OPC_BEQ, 4, 0, 0, s, 0);
+            } else {
+                /* BALC */
+                gen_compute_branch(ctx, OPC_BGEZAL, 4, 0, 0, s, 0);
+            }
+        }
         break;
     case NM_P_J:
+        switch ((ctx->opcode >> 12) & 0x0f) {
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
+    {
+        int32_t s = sextract32(ctx->opcode, 0, 1) << 14 |
+                    extract32(ctx->opcode, 1, 13) << 1;
+        switch ((ctx->opcode >> 14) & 0x03) {
+        case NM_BEQC:
+            gen_compute_branch(ctx, OPC_BEQ, 4, rs, rt, s, 0);
+            break;
+        case NM_P_BR3A:
+        {
+            int32_t s = sextract32(ctx->opcode, 0, 1) << 14 |
+                        extract32(ctx->opcode, 1, 13) << 1;
+            check_cp1_enabled(ctx);
+            switch ((ctx->opcode >> 16) & 0x1f) {
+            case NM_BC1EQZC:
+                gen_compute_branch1_r6(ctx, OPC_BC1EQZ, rt, s, 0);
+                break;
+            case NM_BC1NEZC:
+                gen_compute_branch1_r6(ctx, OPC_BC1NEZ, rt, s, 0);
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+        }
+            break;
+        case NM_BGEC:
+            if (rs == rt) {
+                gen_compute_compact_branch(ctx, OPC_BC, rs, rt, s);
+            } else {
+                gen_compute_compact_branch(ctx, OPC_BGEC, rs, rt, s);
+            }
+            break;
+        case NM_BGEUC:
+            if (rs == rt || rt == 0) {
+                gen_compute_compact_branch(ctx, OPC_BC, 0, 0, s);
+            } else if (rs == 0) {
+                gen_compute_compact_branch(ctx, OPC_BEQZC, rt, 0, s);
+            } else {
+                gen_compute_compact_branch(ctx, OPC_BGEUC, rs, rt, s);
+            }
+            break;
+        }
+    }
         break;
     case NM_P_BR2:
+    {
+        int32_t s = sextract32(ctx->opcode, 0, 1) << 14 |
+                    extract32(ctx->opcode, 1, 13) << 1;
+        switch ((ctx->opcode >> 14) & 0x03) {
+        case NM_BNEC:
+            gen_compute_branch(ctx, OPC_BNE, 4, rs, rt, s, 0);
+            break;
+        case NM_BLTC:
+            if (rs != 0 && rt != 0 && rs == rt) {
+                /* NOP */
+                ctx->hflags |= MIPS_HFLAG_FBNSLOT;
+            } else {
+                gen_compute_compact_branch(ctx, OPC_BLTC, rs, rt, s);
+            }
+            break;
+        case NM_BLTUC:
+            if (rs == 0 || rs == rt) {
+                /* NOP */
+                ctx->hflags |= MIPS_HFLAG_FBNSLOT;
+            } else {
+                gen_compute_compact_branch(ctx, OPC_BLTUC, rs, rt, s);
+            }
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+    }
         break;
     case NM_P_BRI:
+    {
+        int32_t s = sextract32(ctx->opcode, 0, 1) << 11 |
+                    extract32(ctx->opcode, 1, 10) << 1;
+        uint32_t u = extract32(ctx->opcode, 11, 7);
+
+        gen_compute_imm_branch(ctx, extract32(ctx->opcode, 18, 3),
+                               rt, u, s);
+    }
         break;
     default:
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4
