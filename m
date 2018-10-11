Received: from eggs.gnu.org ([2001:4830:134:3::10]:53288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ6S-0007Ff-9U
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gAZ6N-0008Ey-5j
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:26:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60929 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gAZ6M-0008E3-Gk
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:25:58 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 11 Oct 2018 13:22:22 +0200
Message-Id: <1539256947-22807-18-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539256947-22807-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 17/22] target/mips: Implement emulation of
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
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Dimitrije Nikolic <dnikolic@wavecomp.com>

Implement emulation of nanoMIPS EVA instructions. They are all
part of P.LS.E0 instruction pool, or one of its subpools.

Signed-off-by: Dimitrije Nikolic <dnikolic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f77becb..f631930 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1991,6 +1991,17 @@ static inline void check_nms(DisasContext *ctx)
     }
 }
 
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
@@ -20216,6 +20227,74 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                     break;
                 }
                 break;
+            case NM_P_LS_E0:
+                check_eva(ctx);
+                switch (extract32(ctx->opcode, 11, 4)) {
+                case NM_LBE:
+                    gen_ld(ctx, OPC_LBE, rt, rs, s);
+                    break;
+                case NM_SBE:
+                    gen_st(ctx, OPC_SBE, rt, rs, s);
+                    break;
+                case NM_LBUE:
+                    gen_ld(ctx, OPC_LBUE, rt, rs, s);
+                    break;
+                case NM_P_PREFE:
+                    if (rt == 31) {
+                        /* SYNCIE */
+                        /* Break the TB to be able to sync copied instructions
+                           immediately */
+                        ctx->base.is_jmp = DISAS_STOP;
+                    } else {
+                        /* PREF */
+                        /* Treat as NOP. */
+                    }
+                    break;
+                case NM_LHE:
+                    gen_ld(ctx, OPC_LHE, rt, rs, s);
+                    break;
+                case NM_SHE:
+                    gen_st(ctx, OPC_SHE, rt, rs, s);
+                    break;
+                case NM_LHUE:
+                    gen_ld(ctx, OPC_LHUE, rt, rs, s);
+                    break;
+                case NM_CACHEE:
+                    /* Treat as no-op */
+                    if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
+                        gen_cache_operation(ctx, rt, rs, s);
+                    }
+                    break;
+                case NM_LWE:
+                    gen_ld(ctx, OPC_LWE, rt, rs, s);
+                    break;
+                case NM_SWE:
+                    gen_st(ctx, OPC_SWE, rt, rs, s);
+                    break;
+                case NM_P_LLE:
+                    switch (extract32(ctx->opcode, 2, 2)) {
+                    case NM_LL:
+                        gen_ld(ctx, OPC_LLE, rt, rs, s);
+                        break;
+                    case NM_LLWP:
+                    default:
+                        generate_exception_end(ctx, EXCP_RI);
+                        break;
+                    }
+                    break;
+                case NM_P_SCE:
+                    switch (extract32(ctx->opcode, 2, 2)) {
+                    case NM_SC:
+                        gen_st_cond(ctx, OPC_SCE, rt, rs, s);
+                        break;
+                    case NM_SCWP:
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
