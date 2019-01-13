Received: from eggs.gnu.org ([209.51.188.92]:33111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil1h-0002wr-PW
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil1Z-0003QJ-Rg
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:02:25 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:55162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gil1X-0003Ng-1o
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:02:19 -0500
Date: Sun, 13 Jan 2019 20:02:06 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <781155aaf175ea20903c12e26316ea40085457bb.1547403692.git.noring@nocrew.org>
References: <cover.1547403692.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1547403692.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 1/9] target/mips: Require TARGET_MIPS64 for
 R5900 multimedia instructions
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

The R5900 MMIs operate on 128-bit registers that will be split into
two halves: lower 64-bit GPRs and upper 64-bit MMRs. The MMIs will
therefore be left unimplemented in 32-bit mode with the o32 ABI.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 057aaf9a44..a538351032 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -27218,6 +27218,7 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+#if defined(TARGET_MIPS64)
 static void decode_mmi0(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc = MASK_MMI0(ctx->opcode);
@@ -27351,6 +27352,7 @@ static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
         break;
     }
 }
+#endif /* defined(TARGET_MIPS64) */
 
 static void decode_mmi(CPUMIPSState *env, DisasContext *ctx)
 {
@@ -27360,18 +27362,6 @@ static void decode_mmi(CPUMIPSState *env, DisasContext *ctx)
     int rd = extract32(ctx->opcode, 11, 5);
 
     switch (opc) {
-    case MMI_OPC_CLASS_MMI0:
-        decode_mmi0(env, ctx);
-        break;
-    case MMI_OPC_CLASS_MMI1:
-        decode_mmi1(env, ctx);
-        break;
-    case MMI_OPC_CLASS_MMI2:
-        decode_mmi2(env, ctx);
-        break;
-    case MMI_OPC_CLASS_MMI3:
-        decode_mmi3(env, ctx);
-        break;
     case MMI_OPC_MULT1:
     case MMI_OPC_MULTU1:
     case MMI_OPC_MADD:
@@ -27392,6 +27382,7 @@ static void decode_mmi(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_MFHI1:
         gen_HILO1_tx79(ctx, opc, rd);
         break;
+#if defined(TARGET_MIPS64)
     case MMI_OPC_PLZCW:         /* TODO: MMI_OPC_PLZCW */
     case MMI_OPC_PMFHL:         /* TODO: MMI_OPC_PMFHL */
     case MMI_OPC_PMTHL:         /* TODO: MMI_OPC_PMTHL */
@@ -27403,6 +27394,19 @@ static void decode_mmi(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_PSRAW:         /* TODO: MMI_OPC_PSRAW */
         generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_OPC_CLASS_MMI */
         break;
+    case MMI_OPC_CLASS_MMI0:
+        decode_mmi0(env, ctx);
+        break;
+    case MMI_OPC_CLASS_MMI1:
+        decode_mmi1(env, ctx);
+        break;
+    case MMI_OPC_CLASS_MMI2:
+        decode_mmi2(env, ctx);
+        break;
+    case MMI_OPC_CLASS_MMI3:
+        decode_mmi3(env, ctx);
+        break;
+#endif
     default:
         MIPS_INVAL("TX79 MMI class");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.19.2
