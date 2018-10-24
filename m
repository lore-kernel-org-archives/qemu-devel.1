Received: from eggs.gnu.org ([2001:4830:134:3::10]:60237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQh-0005GH-EP
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQb-000213-0c
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:35 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49950 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQY-0001ra-HF
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:28 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:33 +0200
Message-Id: <1540388447-27062-20-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 19/33] target/mips: Support R5900 DIV1 and
 DIVU1 instructions
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

Add support for DIV1 and DIVU1 instructions.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d7d7145..f2aeaf4 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4593,11 +4593,14 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
     gen_load_gpr(t1, rt);
 
     if (acc != 0) {
-        check_dsp(ctx);
+        if (!(ctx->insn_flags & INSN_R5900)) {
+            check_dsp(ctx);
+        }
     }
 
     switch (opc) {
     case OPC_DIV:
+    case TX79_MMI_DIV1:
         {
             TCGv t2 = tcg_temp_new();
             TCGv t3 = tcg_temp_new();
@@ -4619,6 +4622,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
         }
         break;
     case OPC_DIVU:
+    case TX79_MMI_DIVU1:
         {
             TCGv t2 = tcg_const_tl(0);
             TCGv t3 = tcg_const_tl(1);
@@ -24665,6 +24669,10 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_MULTU1:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
+    case TX79_MMI_DIV1:
+    case TX79_MMI_DIVU1:
+        gen_muldiv(ctx, opc, 1, rs, rt);
+        break;
     case TX79_MMI_MTLO1:
     case TX79_MMI_MTHI1:
         gen_HILO(ctx, opc, 1, rs);
@@ -24676,8 +24684,6 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
     case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
-    case TX79_MMI_DIV1:          /* TODO: TX79_MMI_DIV1 */
-    case TX79_MMI_DIVU1:         /* TODO: TX79_MMI_DIVU1 */
     case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
     case TX79_MMI_MADDU1:        /* TODO: TX79_MMI_MADDU1 */
     case TX79_MMI_PMFHL:         /* TODO: TX79_MMI_PMFHL */
-- 
2.7.4
