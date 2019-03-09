Received: from eggs.gnu.org ([209.51.188.92]:51333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2jkF-0003YC-0F
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 16:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2jkE-0003kv-4I
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 16:43:02 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  9 Mar 2019 22:42:54 +0100
Message-Id: <20190309214255.9952-2-f4bug@amsat.org>
In-Reply-To: <20190309214255.9952-1-f4bug@amsat.org>
References: <20190309214255.9952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] target/ppc: Optimize xviexpdp() using
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

The t0 tcg_temp register is now unused, remove it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/ppc/translate/vsx-impl.inc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index e73197e717..48c58deb14 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1726,7 +1726,6 @@ static void gen_xviexpdp(DisasContext *ctx)
     TCGv_i64 xal;
     TCGv_i64 xbh;
     TCGv_i64 xbl;
-    TCGv_i64 t0;
 
     if (unlikely(!ctx->vsx_enabled)) {
         gen_exception(ctx, POWERPC_EXCP_VSXU);
@@ -1742,20 +1741,13 @@ static void gen_xviexpdp(DisasContext *ctx)
     get_cpu_vsrl(xal, xA(ctx->opcode));
     get_cpu_vsrh(xbh, xB(ctx->opcode));
     get_cpu_vsrl(xbl, xB(ctx->opcode));
-    t0 = tcg_temp_new_i64();
 
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
 
-    tcg_temp_free_i64(t0);
     tcg_temp_free_i64(xth);
     tcg_temp_free_i64(xtl);
     tcg_temp_free_i64(xah);
-- 
2.19.1
