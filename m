Received: from eggs.gnu.org ([209.51.188.92]:53614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJs-0006nK-GY
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1guaJm-0000P5-Au
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:02:08 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Feb 2019 10:00:49 +0000
Message-Id: <20190215100058.20015-9-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
References: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 08/17] target/ppc: convert xxsel to vector
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
 target/ppc/translate/vsx-impl.inc.c | 55 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 0e8cecb00a..e73197e717 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1321,40 +1321,39 @@ static void glue(gen_, name)(DisasContext * ctx)            \
 VSX_XXMRG(xxmrghw, 1)
 VSX_XXMRG(xxmrglw, 0)
 
-static void gen_xxsel(DisasContext * ctx)
+static void xxsel_i64(TCGv_i64 t, TCGv_i64 a, TCGv_i64 b, TCGv_i64 c)
 {
-    TCGv_i64 a, b, c, tmp;
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
-    a = tcg_temp_new_i64();
-    b = tcg_temp_new_i64();
-    c = tcg_temp_new_i64();
-    tmp = tcg_temp_new_i64();
-
-    get_cpu_vsrh(a, xA(ctx->opcode));
-    get_cpu_vsrh(b, xB(ctx->opcode));
-    get_cpu_vsrh(c, xC(ctx->opcode));
-
     tcg_gen_and_i64(b, b, c);
     tcg_gen_andc_i64(a, a, c);
-    tcg_gen_or_i64(tmp, a, b);
-    set_cpu_vsrh(xT(ctx->opcode), tmp);
+    tcg_gen_or_i64(t, a, b);
+}
 
-    get_cpu_vsrl(a, xA(ctx->opcode));
-    get_cpu_vsrl(b, xB(ctx->opcode));
-    get_cpu_vsrl(c, xC(ctx->opcode));
+static void xxsel_vec(unsigned vece, TCGv_vec t, TCGv_vec a,
+                      TCGv_vec b, TCGv_vec c)
+{
+    tcg_gen_and_vec(vece, b, b, c);
+    tcg_gen_andc_vec(vece, a, a, c);
+    tcg_gen_or_vec(vece, t, a, b);
+}
 
-    tcg_gen_and_i64(b, b, c);
-    tcg_gen_andc_i64(a, a, c);
-    tcg_gen_or_i64(tmp, a, b);
-    set_cpu_vsrl(xT(ctx->opcode), tmp);
+static void gen_xxsel(DisasContext *ctx)
+{
+    static const GVecGen4 g = {
+        .fni8 = xxsel_i64,
+        .fniv = xxsel_vec,
+        .vece = MO_64,
+    };
+    int rt = xT(ctx->opcode);
+    int ra = xA(ctx->opcode);
+    int rb = xB(ctx->opcode);
+    int rc = xC(ctx->opcode);
 
-    tcg_temp_free_i64(a);
-    tcg_temp_free_i64(b);
-    tcg_temp_free_i64(c);
-    tcg_temp_free_i64(tmp);
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    tcg_gen_gvec_4(vsr_full_offset(rt), vsr_full_offset(ra),
+                   vsr_full_offset(rb), vsr_full_offset(rc), 16, 16, &g);
 }
 
 static void gen_xxspltw(DisasContext *ctx)
-- 
2.11.0
