Received: from eggs.gnu.org ([209.51.188.92]:53521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJq-0006mn-27
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJm-0000OR-6r
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:04 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Feb 2019 10:00:47 +0000
Message-Id: <20190215100058.20015-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
References: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 06/17] target/ppc: convert xxspltib to vector
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 2576d81ac5..944fc0608a 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1397,9 +1397,10 @@ static void gen_xxspltw(DisasContext *ctx)
 
 static void gen_xxspltib(DisasContext *ctx)
 {
-    unsigned char uim8 = IMM8(ctx->opcode);
-    TCGv_i64 vsr;
-    if (xS(ctx->opcode) < 32) {
+    uint8_t uim8 = IMM8(ctx->opcode);
+    int rt = xT(ctx->opcode);
+
+    if (rt < 32) {
         if (unlikely(!ctx->altivec_enabled)) {
             gen_exception(ctx, POWERPC_EXCP_VPU);
             return;
@@ -1410,11 +1411,7 @@ static void gen_xxspltib(DisasContext *ctx)
             return;
         }
     }
-    vsr = tcg_temp_new_i64();
-    tcg_gen_movi_i64(vsr, pattern(uim8));
-    set_cpu_vsrh(xT(ctx->opcode), vsr);
-    set_cpu_vsrl(xT(ctx->opcode), vsr);
-    tcg_temp_free_i64(vsr);
+    tcg_gen_gvec_dup8i(vsr_full_offset(rt), 16, 16, uim8);
 }
 
 static void gen_xxsldwi(DisasContext *ctx)
-- 
2.11.0
