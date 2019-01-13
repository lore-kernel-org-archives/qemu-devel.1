Received: from eggs.gnu.org ([209.51.188.92]:33648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil44-0004VJ-Av
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil43-0004eX-0T
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:04:56 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gil42-0004e1-Pa
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:04:54 -0500
Date: Sun, 13 Jan 2019 20:04:47 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <25ac8b01ff9243ab79efdc6912ec165b12831531.1547403692.git.noring@nocrew.org>
References: <cover.1547403692.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1547403692.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 4/9] target/mips: Support the R5900 PCPYUD
 multimedia instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 40faf9cb36..8c350729bc 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -27351,11 +27351,34 @@ static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void gen_mmi_pcpyud(DisasContext *ctx, int rd, int rs, int rt)
+{
+    if (rd != 0) {
+        if (rs != 0) {
+            tcg_gen_mov_i64(cpu_gpr[rd], cpu_mmr[rs]);
+        } else {
+            tcg_gen_movi_i64(cpu_gpr[rd], 0);
+        }
+
+        if (rt != 0) {
+            tcg_gen_mov_i64(cpu_mmr[rd], cpu_mmr[rt]);
+        } else {
+            tcg_gen_movi_i64(cpu_mmr[rd], 0);
+        }
+    }
+}
+
 static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc = MASK_MMI3(ctx->opcode);
+    int rs = extract32(ctx->opcode, 21, 5);
+    int rt = extract32(ctx->opcode, 16, 5);
+    int rd = extract32(ctx->opcode, 11, 5);
 
     switch (opc) {
+    case MMI_OPC_3_PCPYUD:
+        gen_mmi_pcpyud(ctx, rd, rs, rt);
+        break;
     case MMI_OPC_3_PMADDUW:    /* TODO: MMI_OPC_3_PMADDUW */
     case MMI_OPC_3_PSRAVW:     /* TODO: MMI_OPC_3_PSRAVW */
     case MMI_OPC_3_PMTHI:      /* TODO: MMI_OPC_3_PMTHI */
@@ -27363,7 +27386,6 @@ static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_3_PINTEH:     /* TODO: MMI_OPC_3_PINTEH */
     case MMI_OPC_3_PMULTUW:    /* TODO: MMI_OPC_3_PMULTUW */
     case MMI_OPC_3_PDIVUW:     /* TODO: MMI_OPC_3_PDIVUW */
-    case MMI_OPC_3_PCPYUD:     /* TODO: MMI_OPC_3_PCPYUD */
     case MMI_OPC_3_POR:        /* TODO: MMI_OPC_3_POR */
     case MMI_OPC_3_PNOR:       /* TODO: MMI_OPC_3_PNOR */
     case MMI_OPC_3_PEXCH:      /* TODO: MMI_OPC_3_PEXCH */
-- 
2.19.2
