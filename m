Received: from eggs.gnu.org ([2001:4830:134:3::10]:37923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXMAG-0002Hu-Dw
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXMAF-0003zS-7v
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:39:24 -0400
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 17 Jul 2017 20:39:07 -1000
Message-Id: <20170718063907.23525-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH] target/arm: Optimize aa64 rev16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, f4bug@amsat.org

It is much shorter to reverse all 4 half-words in parallel
than extract, reverse, and deposit each in turn.

Suggested-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e55547d..6b247a7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4042,25 +4042,13 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
     TCGv_i64 tcg_rd = cpu_reg(s, rd);
     TCGv_i64 tcg_tmp = tcg_temp_new_i64();
     TCGv_i64 tcg_rn = read_cpu_reg(s, rn, sf);
+    TCGv_i64 mask = tcg_const_i64(sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff);
 
-    tcg_gen_andi_i64(tcg_tmp, tcg_rn, 0xffff);
-    tcg_gen_bswap16_i64(tcg_rd, tcg_tmp);
-
-    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 16);
-    tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
-    tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
-    tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 16, 16);
-
-    if (sf) {
-        tcg_gen_shri_i64(tcg_tmp, tcg_rn, 32);
-        tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
-        tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
-        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 32, 16);
-
-        tcg_gen_shri_i64(tcg_tmp, tcg_rn, 48);
-        tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
-        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 48, 16);
-    }
+    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
+    tcg_gen_and_i64(tcg_rd, tcg_rn, mask);
+    tcg_gen_and_i64(tcg_tmp, tcg_tmp, mask);
+    tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);
+    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_tmp);
 
     tcg_temp_free_i64(tcg_tmp);
 }
-- 
2.9.4
