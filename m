Received: from eggs.gnu.org ([209.51.188.92]:39588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyD-0006oM-E6
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxv-0003Ff-RV
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:23 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:39 +1100
Message-Id: <20190218143049.17142-34-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/43] target/ppc: convert xxspltw to vector
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
Message-Id: <20190215100058.20015-8-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 36 +++++++++--------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 944fc0608a..0e8cecb00a 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1359,38 +1359,24 @@ static void gen_xxsel(DisasContext * ctx)
=20
 static void gen_xxspltw(DisasContext *ctx)
 {
-    TCGv_i64 b, b2;
-    TCGv_i64 vsr;
+    int rt =3D xT(ctx->opcode);
+    int rb =3D xB(ctx->opcode);
+    int uim =3D UIM(ctx->opcode);
+    int tofs, bofs;
=20
     if (unlikely(!ctx->vsx_enabled)) {
         gen_exception(ctx, POWERPC_EXCP_VSXU);
         return;
     }
=20
-    vsr =3D tcg_temp_new_i64();
-    if (UIM(ctx->opcode) & 2) {
-        get_cpu_vsrl(vsr, xB(ctx->opcode));
-    } else {
-        get_cpu_vsrh(vsr, xB(ctx->opcode));
-    }
-
-    b =3D tcg_temp_new_i64();
-    b2 =3D tcg_temp_new_i64();
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
+    tofs =3D vsr_full_offset(rt);
+    bofs =3D vsr_full_offset(rb);
+    bofs +=3D uim << MO_32;
+#ifndef HOST_WORDS_BIG_ENDIAN
+    bofs ^=3D 8 | 4;
+#endif
=20
-    tcg_temp_free_i64(vsr);
-    tcg_temp_free_i64(b);
-    tcg_temp_free_i64(b2);
+    tcg_gen_gvec_dup_mem(MO_32, tofs, bofs, 16, 16);
 }
=20
 #define pattern(x) (((x) & 0xff) * (~(uint64_t)0 / 0xff))
--=20
2.20.1
