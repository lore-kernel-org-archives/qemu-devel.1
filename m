Received: from eggs.gnu.org ([2001:4830:134:3::10]:53147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ930-0001m5-VU
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92t-0002vG-SF
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:06 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92t-0002fD-I8
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:59 -0500
Received: by mail-pg1-x543.google.com with SMTP id d72so7338573pga.9
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:39:02 -0800
Message-Id: <20181218063911.2112-26-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 25/34] target/ppc: convert xxsel to vector
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate/vsx-impl.inc.c | 55 ++++++++++++++---------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index a040038ed4..dc32471cd7 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1280,40 +1280,39 @@ static void glue(gen_, name)(DisasContext * ctx)            \
 VSX_XXMRG(xxmrghw, 1)
 VSX_XXMRG(xxmrglw, 0)
 
+static void xxsel_i64(TCGv_i64 t, TCGv_i64 a, TCGv_i64 b, TCGv_i64 c)
+{
+    tcg_gen_and_i64(b, b, c);
+    tcg_gen_andc_i64(a, a, c);
+    tcg_gen_or_i64(t, a, b);
+}
+
+static void xxsel_vec(unsigned vece, TCGv_vec t, TCGv_vec a,
+                      TCGv_vec b, TCGv_vec c)
+{
+    tcg_gen_and_vec(vece, b, b, c);
+    tcg_gen_andc_vec(vece, a, a, c);
+    tcg_gen_or_vec(vece, t, a, b);
+}
+
 static void gen_xxsel(DisasContext * ctx)
 {
-    TCGv_i64 a, b, c, tmp;
+    static const GVecGen4 g = {
+        .fni8 = xxsel_i64,
+        .fniv = xxsel_vec,
+        .vece = MO_64,
+    };
+    int rt = xT(ctx->opcode);
+    int ra = xA(ctx->opcode);
+    int rb = xB(ctx->opcode);
+    int rc = xC(ctx->opcode);
+
     if (unlikely(!ctx->vsx_enabled)) {
         gen_exception(ctx, POWERPC_EXCP_VSXU);
         return;
     }
-    a = tcg_temp_new_i64();
-    b = tcg_temp_new_i64();
-    c = tcg_temp_new_i64();
-    tmp = tcg_temp_new_i64();
-
-    get_cpu_vsrh(a, xA(ctx->opcode));
-    get_cpu_vsrh(b, xB(ctx->opcode));
-    get_cpu_vsrh(c, xC(ctx->opcode));
-
-    tcg_gen_and_i64(b, b, c);
-    tcg_gen_andc_i64(a, a, c);
-    tcg_gen_or_i64(tmp, a, b);
-    set_cpu_vsrh(xT(ctx->opcode), tmp);
-
-    get_cpu_vsrl(a, xA(ctx->opcode));
-    get_cpu_vsrl(b, xB(ctx->opcode));
-    get_cpu_vsrl(c, xC(ctx->opcode));
-
-    tcg_gen_and_i64(b, b, c);
-    tcg_gen_andc_i64(a, a, c);
-    tcg_gen_or_i64(tmp, a, b);
-    set_cpu_vsrl(xT(ctx->opcode), tmp);
-
-    tcg_temp_free_i64(a);
-    tcg_temp_free_i64(b);
-    tcg_temp_free_i64(c);
-    tcg_temp_free_i64(tmp);
+    tcg_gen_gvec_4(vsr_full_offset(rt), vsr_full_offset(ra),
+                   vsr_full_offset(rb), vsr_full_offset(rc), 16, 16, &g);
 }
 
 static void gen_xxspltw(DisasContext *ctx)
-- 
2.17.2
