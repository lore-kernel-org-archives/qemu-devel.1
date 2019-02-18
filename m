Received: from eggs.gnu.org ([209.51.188.92]:39908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyY-00078D-69
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyW-0003Ys-Hz
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:54 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:38 +1100
Message-Id: <20190218143049.17142-33-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/43] target/ppc: convert xxspltib to vector
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
Message-Id: <20190215100058.20015-7-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 2576d81ac5..944fc0608a 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1397,9 +1397,10 @@ static void gen_xxspltw(DisasContext *ctx)
=20
 static void gen_xxspltib(DisasContext *ctx)
 {
-    unsigned char uim8 =3D IMM8(ctx->opcode);
-    TCGv_i64 vsr;
-    if (xS(ctx->opcode) < 32) {
+    uint8_t uim8 =3D IMM8(ctx->opcode);
+    int rt =3D xT(ctx->opcode);
+
+    if (rt < 32) {
         if (unlikely(!ctx->altivec_enabled)) {
             gen_exception(ctx, POWERPC_EXCP_VPU);
             return;
@@ -1410,11 +1411,7 @@ static void gen_xxspltib(DisasContext *ctx)
             return;
         }
     }
-    vsr =3D tcg_temp_new_i64();
-    tcg_gen_movi_i64(vsr, pattern(uim8));
-    set_cpu_vsrh(xT(ctx->opcode), vsr);
-    set_cpu_vsrl(xT(ctx->opcode), vsr);
-    tcg_temp_free_i64(vsr);
+    tcg_gen_gvec_dup8i(vsr_full_offset(rt), 16, 16, uim8);
 }
=20
 static void gen_xxsldwi(DisasContext *ctx)
--=20
2.20.1
