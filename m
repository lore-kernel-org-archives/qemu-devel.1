Received: from eggs.gnu.org ([2001:4830:134:3::10]:41643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Nt-0004mR-MJ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Nr-0003OF-4d
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:46:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46538 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi1Nq-0003Lo-PJ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:46:03 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:31:19 +0200
Message-Id: <1532453527-22911-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 07/55] target/mips: Add emulation of
 nanoMIPS 16-bit load and store instructions
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

Add emulation of LWXS16, LB16, SB16, LBU16, LH16, SH16, LHU16, LW16, LWSP16,
LW4X4, SW4X4, LWGP16, SWSP16, SW16, and SWGP16 instructions.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 076637c..191bb15 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16583,6 +16583,13 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_P16C:
+        switch (ctx->opcode & 1) {
+        case NM_POOL16C_0:
+            break;
+        case NM_LWXS16:
+            gen_ldxs(ctx, rt, rs, rd);
+            break;
+        }
         break;
     case NM_P16_A1:
         switch (extract32(ctx->opcode, 6, 1)) {
@@ -16666,24 +16673,123 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_P16_LB:
+        {
+            uint32_t u = extract32(ctx->opcode, 0, 2);
+            switch (((ctx->opcode) >> 2) & 0x03) {
+            case NM_LB16:
+                gen_ld(ctx, OPC_LB, rt, rs, u);
+                break;
+            case NM_SB16:
+                {
+                    int rt = decode_gpr_gpr3_src_store(
+                                 NANOMIPS_EXTRACT_RD(ctx->opcode));
+                    gen_st(ctx, OPC_SB, rt, rs, u);
+                }
+                break;
+            case NM_LBU16:
+                gen_ld(ctx, OPC_LBU, rt, rs, u);
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+        }
         break;
     case NM_P16_LH:
+        {
+            uint32_t u = extract32(ctx->opcode, 1, 2) << 1;
+            switch ((((ctx->opcode >> 3) & 1) << 1) | (ctx->opcode & 1)) {
+            case NM_LH16:
+                gen_ld(ctx, OPC_LH, rt, rs, u);
+                break;
+            case NM_SH16:
+                {
+                    int rt = decode_gpr_gpr3_src_store(
+                                 NANOMIPS_EXTRACT_RD(ctx->opcode));
+                    gen_st(ctx, OPC_SH, rt, rs, u);
+                }
+                break;
+            case NM_LHU16:
+                gen_ld(ctx, OPC_LHU, rt, rs, u);
+                break;
+            default:
+                generate_exception_end(ctx, EXCP_RI);
+                break;
+            }
+        }
         break;
     case NM_LW16:
+        {
+            int u = extract32(ctx->opcode, 0, 4) << 2;
+            gen_ld(ctx, OPC_LW, rt, rs, u);
+        }
         break;
     case NM_LWSP16:
+        {
+            int rt = NANOMIPS_EXTRACT_RD5(ctx->opcode);
+            int u = extract32(ctx->opcode, 0, 5) << 2;
+
+            gen_ld(ctx, OPC_LW, rt, 29, u);
+        }
         break;
     case NM_LW4X4:
+        {
+            int rt = (extract32(ctx->opcode, 9, 1) << 3) |
+                     extract32(ctx->opcode, 5, 3);
+            int rs = (extract32(ctx->opcode, 4, 1) << 3) |
+                     extract32(ctx->opcode, 0, 3);
+            int u = (extract32(ctx->opcode, 3, 1) << 3) |
+                    (extract32(ctx->opcode, 8, 1) << 2);
+            rt = decode_gpr_gpr4(rt);
+            rs = decode_gpr_gpr4(rs);
+            gen_ld(ctx, OPC_LW, rt, rs, u);
+        }
         break;
     case NM_SW4X4:
+        {
+            int rt = (extract32(ctx->opcode, 9, 1) << 3) |
+                     extract32(ctx->opcode, 5, 3);
+            int rs = (extract32(ctx->opcode, 4, 1) << 3) |
+                     extract32(ctx->opcode, 0, 3);
+            int u = (extract32(ctx->opcode, 3, 1) << 3) |
+                    (extract32(ctx->opcode, 8, 1) << 2);
+            rt = decode_gpr_gpr4_zero(rt);
+            rs = decode_gpr_gpr4(rs);
+            gen_st(ctx, OPC_SW, rt, rs, u);
+        }
         break;
     case NM_LWGP16:
+        {
+            int u = extract32(ctx->opcode, 0, 7) << 2;
+            gen_ld(ctx, OPC_LW, rt, 28, u);
+        }
         break;
     case NM_SWSP16:
+        {
+            int rt = NANOMIPS_EXTRACT_RD5(ctx->opcode);
+            int u = extract32(ctx->opcode, 0, 5) << 2;
+
+            gen_st(ctx, OPC_SW, rt, 29, u);
+        }
         break;
     case NM_SW16:
+        {
+            int rt = decode_gpr_gpr3_src_store(
+                         NANOMIPS_EXTRACT_RD(ctx->opcode));
+            int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
+            int u = extract32(ctx->opcode, 0, 4) << 2;
+
+            gen_st(ctx, OPC_SW, rt, rs, u);
+        }
         break;
     case NM_SWGP16:
+        {
+            int rt = decode_gpr_gpr3_src_store(
+                         NANOMIPS_EXTRACT_RD(ctx->opcode));
+            int u = extract32(ctx->opcode, 0, 7) << 2;
+
+            gen_st(ctx, OPC_SW, rt, 28, u);
+        }
         break;
     case NM_BC16:
         gen_compute_branch(ctx, OPC_BEQ, 2, 0, 0,
-- 
2.7.4
