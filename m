Received: from eggs.gnu.org ([2001:4830:134:3::10]:50694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8WM-0003JS-7X
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Tb-0004g7-Ne
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:59:02 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56653 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8Tb-0004dy-1y
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:56:11 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:54:39 +0200
Message-Id: <1532004912-13899-8-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 07/40] target/mips: Add emulation of
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
 target/mips/translate.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 798f977..1a839be 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16472,6 +16472,14 @@ static int decode_gpr_gpr3(int r)
     return map[r & 0x7];
 }
 
+/* Used for 16-bit store instructions.  */
+static int decode_gpr_gpr3_src_store(int r)
+{
+    static const int map[] = { 0, 17, 18, 19, 4, 5, 6, 7 };
+
+    return map[r & 0x7];
+}
+
 static int decode_gpr_gpr4(int r)
 {
     static const int map[] = { 8, 9, 10, 11, 4, 5, 6, 7,
@@ -16568,6 +16576,13 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
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
         switch ((ctx->opcode >> 6) & 1) {
@@ -16651,24 +16666,123 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
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
