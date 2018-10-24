Received: from eggs.gnu.org ([2001:4830:134:3::10]:60087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQb-00058k-3s
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQZ-0001zl-1o
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:28 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49948 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQY-0001rQ-Is
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:26 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:32 +0200
Message-Id: <1540388447-27062-19-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 18/33] target/mips: Support R5900 MFLO1, MTLO1,
 MFHI1 and MTHI1 instructions
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

Add support for MFLO1, MTLO1, MFHI1 and MTHI1 instructions.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6d89002..d7d7145 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4229,17 +4229,21 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
 /* Arithmetic on HI/LO registers */
 static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
 {
-    if (reg == 0 && (opc == OPC_MFHI || opc == OPC_MFLO)) {
+    if (reg == 0 && (opc == OPC_MFHI || opc == TX79_MMI_MFHI1 ||
+                     opc == OPC_MFLO || opc == TX79_MMI_MFLO1)) {
         /* Treat as NOP. */
         return;
     }
 
     if (acc != 0) {
-        check_dsp(ctx);
+        if (!(ctx->insn_flags & INSN_R5900)) {
+            check_dsp(ctx);
+        }
     }
 
     switch (opc) {
     case OPC_MFHI:
+    case TX79_MMI_MFHI1:
 #if defined(TARGET_MIPS64)
         if (acc != 0) {
             tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_HI[acc]);
@@ -4250,6 +4254,7 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MFLO:
+    case TX79_MMI_MFLO1:
 #if defined(TARGET_MIPS64)
         if (acc != 0) {
             tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_LO[acc]);
@@ -4260,6 +4265,7 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MTHI:
+    case TX79_MMI_MTHI1:
         if (reg != 0) {
 #if defined(TARGET_MIPS64)
             if (acc != 0) {
@@ -4274,6 +4280,7 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MTLO:
+    case TX79_MMI_MTLO1:
         if (reg != 0) {
 #if defined(TARGET_MIPS64)
             if (acc != 0) {
@@ -24658,13 +24665,17 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_MULTU1:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
+    case TX79_MMI_MTLO1:
+    case TX79_MMI_MTHI1:
+        gen_HILO(ctx, opc, 1, rs);
+        break;
+    case TX79_MMI_MFLO1:
+    case TX79_MMI_MFHI1:
+        gen_HILO(ctx, opc, 1, rd);
+        break;
     case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
     case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
-    case TX79_MMI_MFHI1:         /* TODO: TX79_MMI_MFHI1 */
-    case TX79_MMI_MTHI1:         /* TODO: TX79_MMI_MTHI1 */
-    case TX79_MMI_MFLO1:         /* TODO: TX79_MMI_MFLO1 */
-    case TX79_MMI_MTLO1:         /* TODO: TX79_MMI_MTLO1 */
     case TX79_MMI_DIV1:          /* TODO: TX79_MMI_DIV1 */
     case TX79_MMI_DIVU1:         /* TODO: TX79_MMI_DIVU1 */
     case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
-- 
2.7.4
