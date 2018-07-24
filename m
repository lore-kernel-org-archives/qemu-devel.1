Received: from eggs.gnu.org ([2001:4830:134:3::10]:44655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1SA-0001nY-Bg
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1S8-00084Y-Cc
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:50:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50971 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi1S7-00081R-ET
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:50:27 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:31:30 +0200
Message-Id: <1532453527-22911-19-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 18/55] target/mips: Add emulation of
 nanoMIPS 32-bit load and store instructions
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

Add emulation of various nanoMIPS load and store instructions.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 271 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 0977fab..b87a29e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17671,10 +17671,281 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_P_GP_BH:
+        {
+            uint32_t u = extract32(ctx->opcode, 0, 18);
+            switch ((ctx->opcode >> 18) & 0x7) {
+            case NM_LBGP:
+                gen_ld(ctx, OPC_LB, rt, 28, u);
+                break;
+            case NM_SBGP:
+                gen_st(ctx, OPC_SB, rt, 28, u);
+                break;
+            case NM_LBUGP:
+                gen_ld(ctx, OPC_LBU, rt, 28, u);
+                break;
+            case NM_ADDIUGP_B:
+                gen_arith_imm(ctx, OPC_ADDIU, rt, 28, u);
+                break;
+            case NM_P_GP_LH:
+                u &= ~1;
+                switch (ctx->opcode & 1) {
+                case NM_LHGP:
+                    gen_ld(ctx, OPC_LH, rt, 28, u);
+                    break;
+                case NM_LHUGP:
+                    gen_ld(ctx, OPC_LHU, rt, 28, u);
+                    break;
+                }
+                break;
+            case NM_P_GP_SH:
+                u &= ~1;
+                switch (ctx->opcode & 1) {
+                case NM_SHGP:
+                    gen_st(ctx, OPC_SH, rt, 28, u);
+                    break;
+                default:
+                    generate_exception_end(ctx, EXCP_RI);
+                    break;
+                }
+                break;
+            case NM_P_GP_CP1:
+                u &= ~0x3;
+                switch ((ctx->opcode & 0x3)) {
+                case NM_LWC1GP:
+                    gen_cop1_ldst(ctx, OPC_LWC1, rt, 28, u);
+                    break;
+                case NM_LDC1GP:
+                    gen_cop1_ldst(ctx, OPC_LDC1, rt, 28, u);
+                    break;
+                case NM_SWC1GP:
+                    gen_cop1_ldst(ctx, OPC_SWC1, rt, 28, u);
+                    break;
+                case NM_SDC1GP:
+                    gen_cop1_ldst(ctx, OPC_SDC1, rt, 28, u);
+                    break;
+                }
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+        }
         break;
     case NM_P_LS_U12:
+        {
+            uint32_t u = extract32(ctx->opcode, 0, 12);
+            switch ((ctx->opcode >> 12) & 0x0f) {
+            case NM_P_PREFU12:
+                if (rt == 31) {
+                    /* SYNCI */
+                    /* Break the TB to be able to sync copied instructions
+                       immediately */
+                    ctx->base.is_jmp = DISAS_STOP;
+                } else {
+                    /* PREF */
+                    /* Treat as NOP. */
+                }
+                break;
+            case NM_LB:
+                gen_ld(ctx, OPC_LB, rt, rs, u);
+                break;
+            case NM_LH:
+                gen_ld(ctx, OPC_LH, rt, rs, u);
+                break;
+            case NM_LW:
+                gen_ld(ctx, OPC_LW, rt, rs, u);
+                break;
+            case NM_LBU:
+                gen_ld(ctx, OPC_LBU, rt, rs, u);
+                break;
+            case NM_LHU:
+                gen_ld(ctx, OPC_LHU, rt, rs, u);
+                break;
+            case NM_SB:
+                gen_st(ctx, OPC_SB, rt, rs, u);
+                break;
+            case NM_SH:
+                gen_st(ctx, OPC_SH, rt, rs, u);
+                break;
+            case NM_SW:
+                gen_st(ctx, OPC_SW, rt, rs, u);
+                break;
+            case NM_LWC1:
+                gen_cop1_ldst(ctx, OPC_LWC1, rt, rs, u);
+                break;
+            case NM_LDC1:
+                gen_cop1_ldst(ctx, OPC_LDC1, rt, rs, u);
+                break;
+            case NM_SWC1:
+                gen_cop1_ldst(ctx, OPC_SWC1, rt, rs, u);
+                break;
+            case NM_SDC1:
+                gen_cop1_ldst(ctx, OPC_SDC1, rt, rs, u);
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+        }
         break;
     case NM_P_LS_S9:
+        {
+            int32_t s = (sextract32(ctx->opcode, 15, 1) << 8) |
+                        extract32(ctx->opcode, 0, 8);
+            switch ((ctx->opcode >> 8) & 0x07) {
+            case NM_P_LS_S0:
+                switch ((ctx->opcode >> 11) & 0x0f) {
+                case NM_LBS9:
+                    gen_ld(ctx, OPC_LB, rt, rs, s);
+                    break;
+                case NM_LHS9:
+                    gen_ld(ctx, OPC_LH, rt, rs, s);
+                    break;
+                case NM_LWS9:
+                    gen_ld(ctx, OPC_LW, rt, rs, s);
+                    break;
+                case NM_LBUS9:
+                    gen_ld(ctx, OPC_LBU, rt, rs, s);
+                    break;
+                case NM_LHUS9:
+                    gen_ld(ctx, OPC_LHU, rt, rs, s);
+                    break;
+                case NM_SBS9:
+                    gen_st(ctx, OPC_SB, rt, rs, s);
+                    break;
+                case NM_SHS9:
+                    gen_st(ctx, OPC_SH, rt, rs, s);
+                    break;
+                case NM_SWS9:
+                    gen_st(ctx, OPC_SW, rt, rs, s);
+                    break;
+                case NM_LWC1S9:
+                    gen_cop1_ldst(ctx, OPC_LWC1, rt, rs, s);
+                    break;
+                case NM_LDC1S9:
+                    gen_cop1_ldst(ctx, OPC_LDC1, rt, rs, s);
+                    break;
+                case NM_SWC1S9:
+                    gen_cop1_ldst(ctx, OPC_SWC1, rt, rs, s);
+                    break;
+                case NM_SDC1S9:
+                    gen_cop1_ldst(ctx, OPC_SDC1, rt, rs, s);
+                    break;
+                case NM_P_PREFS9:
+                    if (rt == 31) {
+                        /* SYNCI */
+                        /* Break the TB to be able to sync copied instructions
+                           immediately */
+                        ctx->base.is_jmp = DISAS_STOP;
+                    } else {
+                        /* PREF */
+                        /* Treat as NOP. */
+                    }
+                    break;
+                default:
+                    generate_exception_end(ctx, EXCP_RI);
+                    break;
+                }
+                break;
+            case NM_P_LS_S1:
+                switch ((ctx->opcode >> 11) & 0x0f) {
+                case NM_UALH:
+                case NM_UASH:
+                    {
+                        TCGv t0 = tcg_temp_new();
+                        TCGv t1 = tcg_temp_new();
+
+                        gen_base_offset_addr(ctx, t0, rs, s);
+
+                        switch ((ctx->opcode >> 11) & 0x0f) {
+                        case NM_UALH:
+                            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW |
+                                               MO_UNALN);
+                            gen_store_gpr(t0, rt);
+                            break;
+                        case NM_UASH:
+                            gen_load_gpr(t1, rt);
+                            tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUW |
+                                               MO_UNALN);
+                            break;
+                        }
+                        tcg_temp_free(t0);
+                        tcg_temp_free(t1);
+                    }
+                    break;
+                case NM_P_LL:
+                    switch (ctx->opcode & 0x03) {
+                    case NM_LL:
+                        gen_ld(ctx, OPC_LL, rt, rs, s);
+                        break;
+                    case NM_LLWP:
+                        break;
+                    }
+                    break;
+                case NM_P_SC:
+                    switch (ctx->opcode & 0x03) {
+                    case NM_SC:
+                        gen_st_cond(ctx, OPC_SC, rt, rs, s);
+                        break;
+                    case NM_SCWP:
+                        break;
+                    }
+                    break;
+                case NM_CACHE:
+                    check_cp0_enabled(ctx);
+                    if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
+                        gen_cache_operation(ctx, rt, rs, s);
+                    }
+                    break;
+                }
+                break;
+            case NM_P_LS_WM:
+            case NM_P_LS_UAWM:
+            {
+                int32_t offset = sextract32(ctx->opcode, 15, 1) << 8 |
+                                extract32(ctx->opcode, 0, 8);
+                int count = extract32(ctx->opcode, 12, 3);
+                int counter = 0;
+                TCGv va = tcg_temp_new();
+                TCGv t1 = tcg_temp_new();
+                TCGMemOp memop = ((ctx->opcode >> 8) & 0x07) == NM_P_LS_UAWM ?
+                                MO_UNALN : 0;
+
+                count = (count == 0) ? 8 : count;
+                while (counter != count) {
+                    int this_rt = ((rt + counter) & 0x1f) | (rt & 0x10);
+                    int32_t this_offset = offset + (counter << 2);
+
+                    gen_base_offset_addr(ctx, va, rs, this_offset);
+
+                    switch (extract32(ctx->opcode, 11, 1)) {
+                    case NM_LWM:
+                        tcg_gen_qemu_ld_tl(t1, va, ctx->mem_idx,
+                                           memop | MO_TESL);
+                        gen_store_gpr(t1, this_rt);
+                        if ((this_rt == rs) &&
+                            (counter != (count - 1))) {
+                            /* UNPREDICTABLE */
+                        }
+                        break;
+                    case NM_SWM:
+                        this_rt = (rt == 0) ? 0 : this_rt;
+                        gen_load_gpr(t1, this_rt);
+                        tcg_gen_qemu_st_tl(t1, va, ctx->mem_idx,
+                                           memop | MO_TEUL);
+                        break;
+                    }
+                    counter++;
+                }
+                tcg_temp_free(va);
+                tcg_temp_free(t1);
+            }
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+        }
         break;
     case NM_MOVE_BALC:
         break;
-- 
2.7.4
