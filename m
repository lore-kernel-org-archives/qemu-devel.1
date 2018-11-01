Received: from eggs.gnu.org ([2001:4830:134:3::10]:40790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIGrf-0002Bp-1S
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIGra-0000dr-2b
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:34:39 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:3354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gIGrZ-0000d3-NZ
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:34:34 -0400
Date: Thu, 1 Nov 2018 18:34:16 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <39be355b02734df4ec0e4ee4d400a25b982e5387.1541093316.git.noring@nocrew.org>
References: <cover.1541093316.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1541093316.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v2 01/12] target/mips: Generate R5900 MFLO1,
 MFHI1, MTLO1 and MTHI1 in gen_HILO1_tx79
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

MFLO1, MFHI1, MTLO1 and MTHI1 are generated in gen_HILO1_tx79 instead of
the generic gen_HILO.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 67 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 60320cbe69..f3993cf7d7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4359,24 +4359,72 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t1);
 }
 
+/* Move to and from TX79 HI1/LO1 registers. */
+static void gen_HILO1_tx79(DisasContext *ctx, uint32_t opc, int reg)
+{
+    if (reg == 0 && (opc == TX79_MMI_MFHI1 || opc == TX79_MMI_MFLO1)) {
+        /* Treat as NOP. */
+        return;
+    }
+
+    switch (opc) {
+    case TX79_MMI_MFHI1:
+#if defined(TARGET_MIPS64)
+        tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_HI[1]);
+#else
+        tcg_gen_mov_tl(cpu_gpr[reg], cpu_HI[1]);
+#endif
+        break;
+    case TX79_MMI_MFLO1:
+#if defined(TARGET_MIPS64)
+        tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_LO[1]);
+#else
+        tcg_gen_mov_tl(cpu_gpr[reg], cpu_LO[1]);
+#endif
+        break;
+    case TX79_MMI_MTHI1:
+        if (reg != 0) {
+#if defined(TARGET_MIPS64)
+            tcg_gen_ext32s_tl(cpu_HI[1], cpu_gpr[reg]);
+#else
+            tcg_gen_mov_tl(cpu_HI[1], cpu_gpr[reg]);
+#endif
+        } else {
+            tcg_gen_movi_tl(cpu_HI[1], 0);
+        }
+        break;
+    case TX79_MMI_MTLO1:
+        if (reg != 0) {
+#if defined(TARGET_MIPS64)
+            tcg_gen_ext32s_tl(cpu_LO[1], cpu_gpr[reg]);
+#else
+            tcg_gen_mov_tl(cpu_LO[1], cpu_gpr[reg]);
+#endif
+        } else {
+            tcg_gen_movi_tl(cpu_LO[1], 0);
+        }
+        break;
+    default:
+        MIPS_INVAL("MFTHILO TX79");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 /* Arithmetic on HI/LO registers */
 static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
 {
-    if (reg == 0 && (opc == OPC_MFHI || opc == TX79_MMI_MFHI1 ||
-                     opc == OPC_MFLO || opc == TX79_MMI_MFLO1)) {
+    if (reg == 0 && (opc == OPC_MFHI || opc == OPC_MFLO)) {
         /* Treat as NOP. */
         return;
     }
 
     if (acc != 0) {
-        if (!(ctx->insn_flags & INSN_R5900)) {
-            check_dsp(ctx);
-        }
+        check_dsp(ctx);
     }
 
     switch (opc) {
     case OPC_MFHI:
-    case TX79_MMI_MFHI1:
 #if defined(TARGET_MIPS64)
         if (acc != 0) {
             tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_HI[acc]);
@@ -4387,7 +4435,6 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MFLO:
-    case TX79_MMI_MFLO1:
 #if defined(TARGET_MIPS64)
         if (acc != 0) {
             tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_LO[acc]);
@@ -4398,7 +4445,6 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MTHI:
-    case TX79_MMI_MTHI1:
         if (reg != 0) {
 #if defined(TARGET_MIPS64)
             if (acc != 0) {
@@ -4413,7 +4459,6 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MTLO:
-    case TX79_MMI_MTLO1:
         if (reg != 0) {
 #if defined(TARGET_MIPS64)
             if (acc != 0) {
@@ -26500,11 +26545,11 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
         break;
     case TX79_MMI_MTLO1:
     case TX79_MMI_MTHI1:
-        gen_HILO(ctx, opc, 1, rs);
+        gen_HILO1_tx79(ctx, opc, rs);
         break;
     case TX79_MMI_MFLO1:
     case TX79_MMI_MFHI1:
-        gen_HILO(ctx, opc, 1, rd);
+        gen_HILO1_tx79(ctx, opc, rd);
         break;
     case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
     case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
-- 
2.18.1
