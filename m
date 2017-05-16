Received: from eggs.gnu.org ([2001:4830:134:3::10]:50527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlTo-0007yL-67
	for qemu-devel@nongnu.org; Tue, 16 May 2017 19:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlTn-0002dn-7v
	for qemu-devel@nongnu.org; Tue, 16 May 2017 19:02:12 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 17 May 2017 01:01:57 +0200
Message-Id: <20170516230159.4195-3-aurelien@aurel32.net>
In-Reply-To: <20170516230159.4195-1-aurelien@aurel32.net>
References: <20170516230159.4195-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 2/4] target/arm: simplify and optimize aarch64
 rev16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Instead of byteswapping individual 16-bit words one by one, work on the
whole register at the same time using shifts and mask. This is the same
strategy than the aarch32 version of rev16 and is much more efficient
in the case sf=1.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/arm/translate-a64.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 24de30d92c..ed15d21655 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4035,24 +4035,12 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
     TCGv_i64 tcg_tmp = tcg_temp_new_i64();
     TCGv_i64 tcg_rn = read_cpu_reg(s, rn, sf);
 
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
+    TCGv mask = tcg_const_i64(sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff);
+    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
+    tcg_gen_and_i64(tcg_rd, tcg_rn, mask);
+    tcg_gen_and_i64(tcg_tmp, tcg_tmp, mask);
+    tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);
+    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_tmp);
 
     tcg_temp_free_i64(tcg_tmp);
 }
-- 
2.11.0
