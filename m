Received: from eggs.gnu.org ([2001:4830:134:3::10]:41570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3X-0003Q5-AN
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3W-000297-Cd
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:51 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXh3W-00028t-1J
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:50 -0400
Received: by mail-pg0-x244.google.com with SMTP id y129so5429015pgy.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:57:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:57:14 -1000
Message-Id: <20170719045722.25492-7-rth@twiddle.net>
In-Reply-To: <20170719045722.25492-1-rth@twiddle.net>
References: <20170719045722.25492-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 06/14] target/arm: Optimize aarch64 rev16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

It is much shorter to reverse all 4 half-words in parallel
than extract, reverse, and deposit each in turn.

Suggested-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3fa3902..5bb0f8e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4043,25 +4043,13 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
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
