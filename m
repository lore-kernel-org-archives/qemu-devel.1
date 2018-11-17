Received: from eggs.gnu.org ([2001:4830:134:3::10]:44450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO2x0-0003xF-KR
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO2wx-0000g6-Ac
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:56:02 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60340 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gO2ww-00077R-UW
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:55:59 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Sat, 17 Nov 2018 16:54:31 +0100
Message-Id: <1542470080-5797-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1542470080-5797-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1542470080-5797-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 02/11] target/mips: Fix decoding mechanism of
 R5900 MFLO1, MFHI1, MTLO1 and MTHI1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Fredrik Noring <noring@nocrew.org>

MFLO1, MFHI1, MTLO1 and MTHI1 are generated in gen_HILO1_tx79 instead of
the generic gen_HILO.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 51 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 60320cb..8601333 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4359,24 +4359,56 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t1);
 }
 
+/* Copy GPR to and from TX79 HI1/LO1 register. */
+static void gen_HILO1_tx79(DisasContext *ctx, uint32_t opc, int reg)
+{
+    if (reg == 0 && (opc == TX79_MMI_MFHI1 || opc == TX79_MMI_MFLO1)) {
+        /* Treat as NOP. */
+        return;
+    }
+
+    switch (opc) {
+    case TX79_MMI_MFHI1:
+        tcg_gen_mov_tl(cpu_gpr[reg], cpu_HI[1]);
+        break;
+    case TX79_MMI_MFLO1:
+        tcg_gen_mov_tl(cpu_gpr[reg], cpu_LO[1]);
+        break;
+    case TX79_MMI_MTHI1:
+        if (reg != 0) {
+            tcg_gen_mov_tl(cpu_HI[1], cpu_gpr[reg]);
+        } else {
+            tcg_gen_movi_tl(cpu_HI[1], 0);
+        }
+        break;
+    case TX79_MMI_MTLO1:
+        if (reg != 0) {
+            tcg_gen_mov_tl(cpu_LO[1], cpu_gpr[reg]);
+        } else {
+            tcg_gen_movi_tl(cpu_LO[1], 0);
+        }
+        break;
+    default:
+        MIPS_INVAL("mfthilo1 TX79");
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
@@ -4387,7 +4419,6 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MFLO:
-    case TX79_MMI_MFLO1:
 #if defined(TARGET_MIPS64)
         if (acc != 0) {
             tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_LO[acc]);
@@ -4398,7 +4429,6 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MTHI:
-    case TX79_MMI_MTHI1:
         if (reg != 0) {
 #if defined(TARGET_MIPS64)
             if (acc != 0) {
@@ -4413,7 +4443,6 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MTLO:
-    case TX79_MMI_MTLO1:
         if (reg != 0) {
 #if defined(TARGET_MIPS64)
             if (acc != 0) {
@@ -26500,11 +26529,11 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
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
2.7.4
