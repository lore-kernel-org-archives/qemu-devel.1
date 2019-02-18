Received: from eggs.gnu.org ([209.51.188.92]:40112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjye-0007Fe-P4
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:33:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyd-0003es-UY
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:33:00 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:40 +1100
Message-Id: <20190218143049.17142-35-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/43] target/ppc: convert xxsel to vector
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215100058.20015-9-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 55 ++++++++++++++---------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 0e8cecb00a..e73197e717 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1321,40 +1321,39 @@ static void glue(gen_, name)(DisasContext * ctx) =
           \
 VSX_XXMRG(xxmrghw, 1)
 VSX_XXMRG(xxmrglw, 0)
=20
-static void gen_xxsel(DisasContext * ctx)
+static void xxsel_i64(TCGv_i64 t, TCGv_i64 a, TCGv_i64 b, TCGv_i64 c)
 {
-    TCGv_i64 a, b, c, tmp;
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
-    a =3D tcg_temp_new_i64();
-    b =3D tcg_temp_new_i64();
-    c =3D tcg_temp_new_i64();
-    tmp =3D tcg_temp_new_i64();
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
=20
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
=20
-    tcg_gen_and_i64(b, b, c);
-    tcg_gen_andc_i64(a, a, c);
-    tcg_gen_or_i64(tmp, a, b);
-    set_cpu_vsrl(xT(ctx->opcode), tmp);
+static void gen_xxsel(DisasContext *ctx)
+{
+    static const GVecGen4 g =3D {
+        .fni8 =3D xxsel_i64,
+        .fniv =3D xxsel_vec,
+        .vece =3D MO_64,
+    };
+    int rt =3D xT(ctx->opcode);
+    int ra =3D xA(ctx->opcode);
+    int rb =3D xB(ctx->opcode);
+    int rc =3D xC(ctx->opcode);
=20
-    tcg_temp_free_i64(a);
-    tcg_temp_free_i64(b);
-    tcg_temp_free_i64(c);
-    tcg_temp_free_i64(tmp);
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+    tcg_gen_gvec_4(vsr_full_offset(rt), vsr_full_offset(ra),
+                   vsr_full_offset(rb), vsr_full_offset(rc), 16, 16, &g)=
;
 }
=20
 static void gen_xxspltw(DisasContext *ctx)
--=20
2.20.1
