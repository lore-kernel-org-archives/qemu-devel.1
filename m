Received: from eggs.gnu.org ([2001:4830:134:3::10]:56452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmj1B-00019t-VL
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmj19-0001xi-40
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:10:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47124 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fmj18-0001uS-Jq
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:10:03 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  6 Aug 2018 18:59:50 +0200
Message-Id: <1533574847-19294-24-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 23/80] target/mips: Add emulation of
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of LWXS16, LB16, SB16, LBU16, LH16, SH16, LHU16, LW16, LWSP16,
LW4X4, SW4X4, LWGP16, SWSP16, SW16, and SWGP16 instructions.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7a3d45b..db07cfe 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16599,6 +16599,7 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
     int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD(ctx->opcode));
     int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
     int rd = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS1(ctx->opcode));
+    int offset;
     int imm;
 
     /* make sure instructions are on a halfword boundary */
@@ -16666,6 +16667,13 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
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
@@ -16737,24 +16745,97 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
     case NM_ANDI16:
         break;
     case NM_P16_LB:
+        switch (extract32(ctx->opcode, 2, 2)) {
+        case NM_LB16:
+            offset = extract32(ctx->opcode, 0, 2);
+            gen_ld(ctx, OPC_LB, rt, rs, offset);
+            break;
+        case NM_SB16:
+            offset = decode_gpr_gpr3_src_store(
+                         NANOMIPS_EXTRACT_RD(ctx->opcode));
+            gen_st(ctx, OPC_SB, rt, rs, offset);
+            break;
+        case NM_LBU16:
+            offset = extract32(ctx->opcode, 0, 2);
+            gen_ld(ctx, OPC_LBU, rt, rs, offset);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
         break;
     case NM_P16_LH:
+        switch ((extract32(ctx->opcode, 3, 1) << 1) | (ctx->opcode & 1)) {
+        case NM_LH16:
+            offset = extract32(ctx->opcode, 1, 2) << 1;
+            gen_ld(ctx, OPC_LH, rt, rs, offset);
+            break;
+        case NM_SH16:
+            offset = decode_gpr_gpr3_src_store(
+                         NANOMIPS_EXTRACT_RD(ctx->opcode));
+            gen_st(ctx, OPC_SH, rt, rs, offset);
+            break;
+        case NM_LHU16:
+            offset = extract32(ctx->opcode, 1, 2) << 1;
+            gen_ld(ctx, OPC_LHU, rt, rs, offset);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
         break;
     case NM_LW16:
+        offset = extract32(ctx->opcode, 0, 4) << 2;
+        gen_ld(ctx, OPC_LW, rt, rs, offset);
         break;
     case NM_LWSP16:
+        rt = NANOMIPS_EXTRACT_RD5(ctx->opcode);
+        offset = extract32(ctx->opcode, 0, 5) << 2;
+        gen_ld(ctx, OPC_LW, rt, 29, offset);
         break;
     case NM_LW4X4:
+        rt = (extract32(ctx->opcode, 9, 1) << 3) |
+             extract32(ctx->opcode, 5, 3);
+        rs = (extract32(ctx->opcode, 4, 1) << 3) |
+             extract32(ctx->opcode, 0, 3);
+        offset = (extract32(ctx->opcode, 3, 1) << 3) |
+                 (extract32(ctx->opcode, 8, 1) << 2);
+        rt = decode_gpr_gpr4(rt);
+        rs = decode_gpr_gpr4(rs);
+        gen_ld(ctx, OPC_LW, rt, rs, offset);
         break;
     case NM_SW4X4:
+        rt = (extract32(ctx->opcode, 9, 1) << 3) |
+             extract32(ctx->opcode, 5, 3);
+        rs = (extract32(ctx->opcode, 4, 1) << 3) |
+             extract32(ctx->opcode, 0, 3);
+        offset = (extract32(ctx->opcode, 3, 1) << 3) |
+                 (extract32(ctx->opcode, 8, 1) << 2);
+        rt = decode_gpr_gpr4_zero(rt);
+        rs = decode_gpr_gpr4(rs);
+        gen_st(ctx, OPC_SW, rt, rs, offset);
         break;
     case NM_LWGP16:
+        offset = extract32(ctx->opcode, 0, 7) << 2;
+        gen_ld(ctx, OPC_LW, rt, 28, offset);
         break;
     case NM_SWSP16:
+        rt = NANOMIPS_EXTRACT_RD5(ctx->opcode);
+        offset = extract32(ctx->opcode, 0, 5) << 2;
+        gen_st(ctx, OPC_SW, rt, 29, offset);
         break;
     case NM_SW16:
+        rt = decode_gpr_gpr3_src_store(
+                 NANOMIPS_EXTRACT_RD(ctx->opcode));
+        rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS(ctx->opcode));
+        offset = extract32(ctx->opcode, 0, 4) << 2;
+        gen_st(ctx, OPC_SW, rt, rs, offset);
         break;
     case NM_SWGP16:
+        rt = decode_gpr_gpr3_src_store(
+                 NANOMIPS_EXTRACT_RD(ctx->opcode));
+        offset = extract32(ctx->opcode, 0, 7) << 2;
+        gen_st(ctx, OPC_SW, rt, 28, offset);
         break;
     case NM_BC16:
         gen_compute_branch(ctx, OPC_BEQ, 2, 0, 0,
-- 
2.7.4
