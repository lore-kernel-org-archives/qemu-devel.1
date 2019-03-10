Received: from eggs.gnu.org ([209.51.188.92]:43518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpD-00025D-FD
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpC-00022Z-Na
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:51 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:27:01 +1100
Message-Id: <20190310082703.1245-59-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 58/60] target/ppc: Optimize xviexpdp() using
 deposit_i64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, David Gibson <david@gibson.dropbear.id.au>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The t0 tcg_temp register is now unused, remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20190309214255.9952-2-f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 95a269fff0..30d8aabd92 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1695,7 +1695,6 @@ static void gen_xviexpdp(DisasContext *ctx)
     TCGv_i64 xal;
     TCGv_i64 xbh;
     TCGv_i64 xbl;
-    TCGv_i64 t0;
=20
     if (unlikely(!ctx->vsx_enabled)) {
         gen_exception(ctx, POWERPC_EXCP_VSXU);
@@ -1711,20 +1710,13 @@ static void gen_xviexpdp(DisasContext *ctx)
     get_cpu_vsrl(xal, xA(ctx->opcode));
     get_cpu_vsrh(xbh, xB(ctx->opcode));
     get_cpu_vsrl(xbl, xB(ctx->opcode));
-    t0 =3D tcg_temp_new_i64();
=20
-    tcg_gen_andi_i64(xth, xah, 0x800FFFFFFFFFFFFF);
-    tcg_gen_andi_i64(t0, xbh, 0x7FF);
-    tcg_gen_shli_i64(t0, t0, 52);
-    tcg_gen_or_i64(xth, xth, t0);
+    tcg_gen_deposit_i64(xth, xah, xbh, 52, 11);
     set_cpu_vsrh(xT(ctx->opcode), xth);
-    tcg_gen_andi_i64(xtl, xal, 0x800FFFFFFFFFFFFF);
-    tcg_gen_andi_i64(t0, xbl, 0x7FF);
-    tcg_gen_shli_i64(t0, t0, 52);
-    tcg_gen_or_i64(xtl, xtl, t0);
+
+    tcg_gen_deposit_i64(xtl, xal, xbl, 52, 11);
     set_cpu_vsrl(xT(ctx->opcode), xtl);
=20
-    tcg_temp_free_i64(t0);
     tcg_temp_free_i64(xth);
     tcg_temp_free_i64(xtl);
     tcg_temp_free_i64(xah);
--=20
2.20.1
