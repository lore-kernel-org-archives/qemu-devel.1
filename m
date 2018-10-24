Received: from eggs.gnu.org ([2001:4830:134:3::10]:36579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFMyt-0004B6-Qw
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFMys-0001Jc-0L
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:30:07 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56219 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFMyr-0001Ir-K5
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:30:05 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 19:29:49 +0200
Message-Id: <1540402190-26289-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540402190-26289-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540402190-26289-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/3] target/mips: Implement emulation of
 nanoMIPS EVA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Dimitrije Nikolic <dnikolic@wavecomp.com>

Implement emulation of nanoMIPS EVA instructions. They are all
part of P.LS.E0 instruction pool, or one of its subpools.

Signed-off-by: Dimitrije Nikolic <dnikolic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4338b9a..60964c9 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2989,6 +2989,35 @@ static inline void check_nms(DisasContext *ctx)
     }
 }
 
+/*
+ * This code generates a "reserved instruction" exception if the
+ * Config5 NMS bit is set, and Config1 DL, Config1 IL, Config2 SL,
+ * Config2 TL, and Config5 L2C are unset.
+ */
+static inline void check_nms_dl_il_sl_tl_l2c(DisasContext *ctx)
+{
+    if (unlikely(ctx->CP0_Config5 & (1 << CP0C5_NMS)) &&
+        !(ctx->CP0_Config1 & (1 << CP0C1_DL)) &&
+        !(ctx->CP0_Config1 & (1 << CP0C1_IL)) &&
+        !(ctx->CP0_Config2 & (1 << CP0C2_SL)) &&
+        !(ctx->CP0_Config2 & (1 << CP0C2_TL)) &&
+        !(ctx->CP0_Config5 & (1 << CP0C5_L2C)))
+    {
+        generate_exception_end(ctx, EXCP_RI);
+    }
+}
+
+/*
+ * This code generates a "reserved instruction" exception if the
+ * Config5 EVA bit is NOT set.
+ */
+static inline void check_eva(DisasContext *ctx)
+{
+    if (!unlikely(ctx->CP0_Config5 & (1 << CP0C5_EVA))) {
+        generate_exception_end(ctx, EXCP_RI);
+    }
+}
+
 
 /* Define small wrappers for gen_load_fpr* so that we have a uniform
    calling interface for 32 and 64-bit FPRs.  No sense in changing
@@ -21218,6 +21247,105 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                     break;
                 }
                 break;
+            case NM_P_LS_E0:
+                switch (extract32(ctx->opcode, 11, 4)) {
+                case NM_LBE:
+                    check_eva(ctx);
+                    check_cp0_enabled(ctx);
+                    gen_ld(ctx, OPC_LBE, rt, rs, s);
+                    break;
+                case NM_SBE:
+                    check_eva(ctx);
+                    check_cp0_enabled(ctx);
+                    gen_st(ctx, OPC_SBE, rt, rs, s);
+                    break;
+                case NM_LBUE:
+                    check_eva(ctx);
+                    check_cp0_enabled(ctx);
+                    gen_ld(ctx, OPC_LBUE, rt, rs, s);
+                    break;
+                case NM_P_PREFE:
+                    if (rt == 31) {
+                        /* case NM_SYNCIE */
+                        check_eva(ctx);
+                        check_cp0_enabled(ctx);
+                        /* Break the TB to be able to sync copied instructions
+                           immediately */
+                        ctx->base.is_jmp = DISAS_STOP;
+                    } else {
+                        /* case NM_PREFE */
+                        check_eva(ctx);
+                        check_cp0_enabled(ctx);
+                        /* Treat as NOP. */
+                    }
+                    break;
+                case NM_LHE:
+                    check_eva(ctx);
+                    check_cp0_enabled(ctx);
+                    gen_ld(ctx, OPC_LHE, rt, rs, s);
+                    break;
+                case NM_SHE:
+                    check_eva(ctx);
+                    check_cp0_enabled(ctx);
+                    gen_st(ctx, OPC_SHE, rt, rs, s);
+                    break;
+                case NM_LHUE:
+                    check_eva(ctx);
+                    check_cp0_enabled(ctx);
+                    gen_ld(ctx, OPC_LHUE, rt, rs, s);
+                    break;
+                case NM_CACHEE:
+                    check_nms_dl_il_sl_tl_l2c(ctx);
+                    gen_cache_operation(ctx, rt, rs, s);
+                    break;
+                case NM_LWE:
+                    check_eva(ctx);
+                    check_cp0_enabled(ctx);
+                    gen_ld(ctx, OPC_LWE, rt, rs, s);
+                    break;
+                case NM_SWE:
+                    check_eva(ctx);
+                    check_cp0_enabled(ctx);
+                    gen_st(ctx, OPC_SWE, rt, rs, s);
+                    break;
+                case NM_P_LLE:
+                    switch (extract32(ctx->opcode, 2, 2)) {
+                    case NM_LLE:
+                        check_xnp(ctx);
+                        check_eva(ctx);
+                        check_cp0_enabled(ctx);
+                        gen_ld(ctx, OPC_LLE, rt, rs, s);
+                        break;
+                    case NM_LLWPE:
+                        check_xnp(ctx);
+                        check_eva(ctx);
+                        check_cp0_enabled(ctx);
+                        gen_llwp(ctx, rs, 0, rt, extract32(ctx->opcode, 3, 5));
+                    default:
+                        generate_exception_end(ctx, EXCP_RI);
+                        break;
+                    }
+                    break;
+                case NM_P_SCE:
+                    switch (extract32(ctx->opcode, 2, 2)) {
+                    case NM_SCE:
+                        check_xnp(ctx);
+                        check_eva(ctx);
+                        check_cp0_enabled(ctx);
+                        gen_st_cond(ctx, OPC_SCE, rt, rs, s);
+                        break;
+                    case NM_SCWPE:
+                        check_xnp(ctx);
+                        check_eva(ctx);
+                        check_cp0_enabled(ctx);
+                        gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode, 3, 5));
+                    default:
+                        generate_exception_end(ctx, EXCP_RI);
+                        break;
+                    }
+                    break;
+                }
+                break;
             case NM_P_LS_WM:
             case NM_P_LS_UAWM:
                 check_nms(ctx);
-- 
2.7.4
