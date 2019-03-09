Received: from eggs.gnu.org ([209.51.188.92]:51358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2jkG-0003YM-6V
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 16:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2jkF-0003nP-AV
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 16:43:04 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  9 Mar 2019 22:42:55 +0100
Message-Id: <20190309214255.9952-3-f4bug@amsat.org>
In-Reply-To: <20190309214255.9952-1-f4bug@amsat.org>
References: <20190309214255.9952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] target/ppc: Optimize x[sv]xsigdp using
 deposit_i64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/ppc/translate/vsx-impl.inc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 48c58deb14..3203165f49 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1618,8 +1618,7 @@ static void gen_xsxsigdp(DisasContext *ctx)
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
     get_cpu_vsrh(t1, xB(ctx->opcode));
-    tcg_gen_andi_i64(rt, t1, 0x000FFFFFFFFFFFFF);
-    tcg_gen_or_i64(rt, rt, t0);
+    tcg_gen_deposit_i64(rt, t0, t1, 0, 52);
 
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
@@ -1655,8 +1654,7 @@ static void gen_xsxsigqp(DisasContext *ctx)
     tcg_gen_movi_i64(t0, 0x0001000000000000);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
-    tcg_gen_andi_i64(xth, xbh, 0x0000FFFFFFFFFFFF);
-    tcg_gen_or_i64(xth, xth, t0);
+    tcg_gen_deposit_i64(xth, t0, xbh, 0, 48);
     set_cpu_vsrh(rD(ctx->opcode) + 32, xth);
     tcg_gen_mov_i64(xtl, xbl);
     set_cpu_vsrl(rD(ctx->opcode) + 32, xtl);
@@ -1845,16 +1843,14 @@ static void gen_xvxsigdp(DisasContext *ctx)
     tcg_gen_movi_i64(t0, 0x0010000000000000);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
-    tcg_gen_andi_i64(xth, xbh, 0x000FFFFFFFFFFFFF);
-    tcg_gen_or_i64(xth, xth, t0);
+    tcg_gen_deposit_i64(xth, t0, xbh, 0, 52);
     set_cpu_vsrh(xT(ctx->opcode), xth);
 
     tcg_gen_extract_i64(exp, xbl, 52, 11);
     tcg_gen_movi_i64(t0, 0x0010000000000000);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
-    tcg_gen_andi_i64(xtl, xbl, 0x000FFFFFFFFFFFFF);
-    tcg_gen_or_i64(xtl, xtl, t0);
+    tcg_gen_deposit_i64(xth, t0, xbl, 0, 52);
     set_cpu_vsrl(xT(ctx->opcode), xtl);
 
     tcg_temp_free_i64(t0);
-- 
2.19.1
