Received: from eggs.gnu.org ([209.51.188.92]:53536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJq-0006mr-5t
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJm-0000PU-Bo
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:06 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Feb 2019 10:00:48 +0000
Message-Id: <20190215100058.20015-8-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
References: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 07/17] target/ppc: convert xxspltw to vector
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
 target/ppc/translate/vsx-impl.inc.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 944fc0608a..0e8cecb00a 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1359,38 +1359,24 @@ static void gen_xxsel(DisasContext * ctx)
 
 static void gen_xxspltw(DisasContext *ctx)
 {
-    TCGv_i64 b, b2;
-    TCGv_i64 vsr;
+    int rt = xT(ctx->opcode);
+    int rb = xB(ctx->opcode);
+    int uim = UIM(ctx->opcode);
+    int tofs, bofs;
 
     if (unlikely(!ctx->vsx_enabled)) {
         gen_exception(ctx, POWERPC_EXCP_VSXU);
         return;
     }
 
-    vsr = tcg_temp_new_i64();
-    if (UIM(ctx->opcode) & 2) {
-        get_cpu_vsrl(vsr, xB(ctx->opcode));
-    } else {
-        get_cpu_vsrh(vsr, xB(ctx->opcode));
-    }
-
-    b = tcg_temp_new_i64();
-    b2 = tcg_temp_new_i64();
-
-    if (UIM(ctx->opcode) & 1) {
-        tcg_gen_ext32u_i64(b, vsr);
-    } else {
-        tcg_gen_shri_i64(b, vsr, 32);
-    }
-
-    tcg_gen_shli_i64(b2, b, 32);
-    tcg_gen_or_i64(vsr, b, b2);
-    set_cpu_vsrh(xT(ctx->opcode), vsr);
-    set_cpu_vsrl(xT(ctx->opcode), vsr);
+    tofs = vsr_full_offset(rt);
+    bofs = vsr_full_offset(rb);
+    bofs += uim << MO_32;
+#ifndef HOST_WORDS_BIG_ENDIAN
+    bofs ^= 8 | 4;
+#endif
 
-    tcg_temp_free_i64(vsr);
-    tcg_temp_free_i64(b);
-    tcg_temp_free_i64(b2);
+    tcg_gen_gvec_dup_mem(MO_32, tofs, bofs, 16, 16);
 }
 
 #define pattern(x) (((x) & 0xff) * (~(uint64_t)0 / 0xff))
-- 
2.11.0
