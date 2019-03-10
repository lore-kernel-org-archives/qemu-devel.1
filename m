Received: from eggs.gnu.org ([209.51.188.92]:43615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpG-00027q-4W
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpF-00025J-7y
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:54 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:27:02 +1100
Message-Id: <20190310082703.1245-60-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 59/60] target/ppc: Optimize x[sv]xsigdp using
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20190309214255.9952-3-f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 30d8aabd92..508e9199c8 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1587,8 +1587,7 @@ static void gen_xsxsigdp(DisasContext *ctx)
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
     get_cpu_vsrh(t1, xB(ctx->opcode));
-    tcg_gen_andi_i64(rt, t1, 0x000FFFFFFFFFFFFF);
-    tcg_gen_or_i64(rt, rt, t0);
+    tcg_gen_deposit_i64(rt, t0, t1, 0, 52);
=20
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
@@ -1624,8 +1623,7 @@ static void gen_xsxsigqp(DisasContext *ctx)
     tcg_gen_movi_i64(t0, 0x0001000000000000);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
-    tcg_gen_andi_i64(xth, xbh, 0x0000FFFFFFFFFFFF);
-    tcg_gen_or_i64(xth, xth, t0);
+    tcg_gen_deposit_i64(xth, t0, xbh, 0, 48);
     set_cpu_vsrh(rD(ctx->opcode) + 32, xth);
     tcg_gen_mov_i64(xtl, xbl);
     set_cpu_vsrl(rD(ctx->opcode) + 32, xtl);
@@ -1814,16 +1812,14 @@ static void gen_xvxsigdp(DisasContext *ctx)
     tcg_gen_movi_i64(t0, 0x0010000000000000);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
-    tcg_gen_andi_i64(xth, xbh, 0x000FFFFFFFFFFFFF);
-    tcg_gen_or_i64(xth, xth, t0);
+    tcg_gen_deposit_i64(xth, t0, xbh, 0, 52);
     set_cpu_vsrh(xT(ctx->opcode), xth);
=20
     tcg_gen_extract_i64(exp, xbl, 52, 11);
     tcg_gen_movi_i64(t0, 0x0010000000000000);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
-    tcg_gen_andi_i64(xtl, xbl, 0x000FFFFFFFFFFFFF);
-    tcg_gen_or_i64(xtl, xtl, t0);
+    tcg_gen_deposit_i64(xth, t0, xbl, 0, 52);
     set_cpu_vsrl(xT(ctx->opcode), xtl);
=20
     tcg_temp_free_i64(t0);
--=20
2.20.1
