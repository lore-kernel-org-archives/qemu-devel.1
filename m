Received: from eggs.gnu.org ([209.51.188.92]:33381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil3H-0003zG-FK
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil3G-0004IT-7L
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:04:07 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:38768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gil3G-0004I0-0z
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:04:06 -0500
Date: Sun, 13 Jan 2019 20:03:59 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <b05a382fc4a444e74b3787052248b1f9fda5ab88.1547403692.git.noring@nocrew.org>
References: <cover.1547403692.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1547403692.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 3/9] target/mips: Support the R5900 PCPYLD
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
index 9d5150ec8b..40faf9cb36 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -27293,11 +27293,34 @@ static void decode_mmi1(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void gen_mmi_pcpyld(DisasContext *ctx, int rd, int rs, int rt)
+{
+    if (rd != 0) {
+        if (rs != 0) {
+            tcg_gen_mov_i64(cpu_mmr[rd], cpu_gpr[rs]);
+        } else {
+            tcg_gen_movi_i64(cpu_mmr[rd], 0);
+        }
+
+        if (rt != 0) {
+            tcg_gen_mov_i64(cpu_gpr[rd], cpu_gpr[rt]);
+        } else {
+            tcg_gen_movi_i64(cpu_gpr[rd], 0);
+        }
+    }
+}
+
 static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc = MASK_MMI2(ctx->opcode);
+    int rs = extract32(ctx->opcode, 21, 5);
+    int rt = extract32(ctx->opcode, 16, 5);
+    int rd = extract32(ctx->opcode, 11, 5);
 
     switch (opc) {
+    case MMI_OPC_2_PCPYLD:
+        gen_mmi_pcpyld(ctx, rd, rs, rt);
+        break;
     case MMI_OPC_2_PMADDW:    /* TODO: MMI_OPC_2_PMADDW */
     case MMI_OPC_2_PSLLVW:    /* TODO: MMI_OPC_2_PSLLVW */
     case MMI_OPC_2_PSRLVW:    /* TODO: MMI_OPC_2_PSRLVW */
@@ -27307,7 +27330,6 @@ static void decode_mmi2(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_2_PINTH:     /* TODO: MMI_OPC_2_PINTH */
     case MMI_OPC_2_PMULTW:    /* TODO: MMI_OPC_2_PMULTW */
     case MMI_OPC_2_PDIVW:     /* TODO: MMI_OPC_2_PDIVW */
-    case MMI_OPC_2_PCPYLD:    /* TODO: MMI_OPC_2_PCPYLD */
     case MMI_OPC_2_PMADDH:    /* TODO: MMI_OPC_2_PMADDH */
     case MMI_OPC_2_PHMADH:    /* TODO: MMI_OPC_2_PHMADH */
     case MMI_OPC_2_PAND:      /* TODO: MMI_OPC_2_PAND */
-- 
2.19.2
