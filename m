Received: from eggs.gnu.org ([2001:4830:134:3::10]:35050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbuM-0003Ec-L6
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbuI-0003xL-Lg
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:08:18 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:35087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbuI-0003sq-FF
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:08:14 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:05:50 +0100
Message-ID: <20180620120620.12806-6-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 05/35] target/mips: Add nanoMIPS 16bit ld/st
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

Add nanoMIPS 16bit load and store instructions

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/translate.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 633d0b4..f5b7e14 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16207,6 +16207,14 @@ static int mmreg_nanomips(int r)
     return map[r & 0x7];
 }
 
+/* Used for 16-bit store instructions.  */
+static int mmreg2_nanomips(int r)
+{
+    static const int map[] = { 0, 17, 18, 19, 4, 5, 6, 7 };
+
+    return map[r & 0x7];
+}
+
 static int mmreg4_nanomips(int r)
 {
     static const int map[] = { 8, 9, 10, 11, 4, 5, 6, 7,
@@ -16292,6 +16300,13 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
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
@@ -16375,24 +16390,119 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
     }
         break;
     case NM_P16_LB:
+    {
+        uint32_t u = extract32(ctx->opcode, 0, 2);
+        switch (((ctx->opcode) >> 2) & 0x03) {
+        case NM_LB16:
+            gen_ld(ctx, OPC_LB, rt, rs, u);
+            break;
+        case NM_SB16:
+            {
+                int rt = mmreg2_nanomips(uMIPS_RD(ctx->opcode));
+                gen_st(ctx, OPC_SB, rt, rs, u);
+            }
+            break;
+        case NM_LBU16:
+            gen_ld(ctx, OPC_LBU, rt, rs, u);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+    }
         break;
     case NM_P16_LH:
+    {
+        uint32_t u = extract32(ctx->opcode, 1, 2) << 1;
+        switch ((((ctx->opcode >> 3) & 1) << 1) | (ctx->opcode & 1)) {
+        case NM_LH16:
+            gen_ld(ctx, OPC_LH, rt, rs, u);
+            break;
+        case NM_SH16:
+            {
+                int rt = mmreg2_nanomips(uMIPS_RD(ctx->opcode));
+                gen_st(ctx, OPC_SH, rt, rs, u);
+            }
+            break;
+        case NM_LHU16:
+            gen_ld(ctx, OPC_LHU, rt, rs, u);
+            break;
+        default:
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+    }
         break;
     case NM_LW16:
+    {
+        int u = extract32(ctx->opcode, 0, 4) << 2;
+        gen_ld(ctx, OPC_LW, rt, rs, u);
+    }
         break;
     case NM_LWSP16:
+    {
+        int rt = uMIPS_RD5(ctx->opcode);
+        int u = extract32(ctx->opcode, 0, 5) << 2;
+
+        gen_ld(ctx, OPC_LW, rt, 29, u);
+    }
         break;
     case NM_LW4X4:
+    {
+        int rt = (extract32(ctx->opcode, 9, 1) << 3) |
+                 extract32(ctx->opcode, 5, 3);
+        int rs = (extract32(ctx->opcode, 4, 1) << 3) |
+                 extract32(ctx->opcode, 0, 3);
+        int u = (extract32(ctx->opcode, 3, 1) << 3) |
+                (extract32(ctx->opcode, 8, 1) << 2);
+        rt = mmreg4_nanomips(rt);
+        rs = mmreg4_nanomips(rs);
+        gen_ld(ctx, OPC_LW, rt, rs, u);
+    }
         break;
     case NM_SW4X4:
+    {
+        int rt = (extract32(ctx->opcode, 9, 1) << 3) |
+                 extract32(ctx->opcode, 5, 3);
+        int rs = (extract32(ctx->opcode, 4, 1) << 3) |
+                 extract32(ctx->opcode, 0, 3);
+        int u = (extract32(ctx->opcode, 3, 1) << 3) |
+                (extract32(ctx->opcode, 8, 1) << 2);
+        rt = mmreg4z_nanomips(rt);
+        rs = mmreg4_nanomips(rs);
+        gen_st(ctx, OPC_SW, rt, rs, u);
+    }
         break;
     case NM_LWGP16:
+    {
+        int u = extract32(ctx->opcode, 0, 7) << 2;
+        gen_ld(ctx, OPC_LW, rt, 28, u);
+    }
         break;
     case NM_SWSP16:
+    {
+        int rt = uMIPS_RD5(ctx->opcode);
+        int u = extract32(ctx->opcode, 0, 5) << 2;
+
+        gen_st(ctx, OPC_SW, rt, 29, u);
+    }
         break;
     case NM_SW16:
+    {
+        int rt = mmreg2_nanomips(uMIPS_RD(ctx->opcode));
+        int rs = mmreg_nanomips(uMIPS_RS(ctx->opcode));
+        int u = extract32(ctx->opcode, 0, 4) << 2;
+
+        gen_st(ctx, OPC_SW, rt, rs, u);
+    }
         break;
     case NM_SWGP16:
+    {
+        int rt = mmreg2_nanomips(uMIPS_RD(ctx->opcode));
+        int u = extract32(ctx->opcode, 0, 7) << 2;
+
+        gen_st(ctx, OPC_SW, rt, 28, u);
+    }
         break;
     case NM_BC16:
         gen_compute_branch(ctx, OPC_BEQ, 2, 0, 0,
-- 
1.9.1
