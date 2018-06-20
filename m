Received: from eggs.gnu.org ([2001:4830:134:3::10]:35092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbub-0003UR-Tp
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbua-000448-Bc
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:08:33 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:54729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbua-0003z5-5P
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:08:32 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:05:51 +0100
Message-ID: <20180620120620.12806-7-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 06/35] target/mips: Add nanoMIPS pool16c
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

Add nanoMIPS pool16c instructions

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/translate.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f5b7e14..c1a98da 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16232,6 +16232,27 @@ static int mmreg4z_nanomips(int r)
     return map[r & 0xf];
 }
 
+static void gen_pool16c_nanomips_insn(DisasContext *ctx)
+{
+    int rt = mmreg_nanomips(uMIPS_RD(ctx->opcode));
+    int rs = mmreg_nanomips(uMIPS_RS(ctx->opcode));
+
+    switch ((ctx->opcode >> 2) & 0x3) {
+    case NM_NOT16:
+        gen_logic(ctx, OPC_NOR, rt, rs, 0);
+        break;
+    case NM_AND16:
+        gen_logic(ctx, OPC_AND, rt, rt, rs);
+        break;
+    case NM_XOR16:
+        gen_logic(ctx, OPC_XOR, rt, rt, rs);
+        break;
+    case NM_OR16:
+        gen_logic(ctx, OPC_OR, rt, rt, rs);
+        break;
+    }
+}
+
 static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t op;
@@ -16302,6 +16323,7 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
     case NM_P16C:
         switch (ctx->opcode & 1) {
         case NM_POOL16C_0:
+            gen_pool16c_nanomips_insn(ctx);
             break;
         case NM_LWXS16:
             gen_ldxs(ctx, rt, rs, rd);
-- 
1.9.1
