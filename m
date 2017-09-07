Received: from eggs.gnu.org ([2001:4830:134:3::10]:52272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5UB-0003CD-KM
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5U7-0008KH-07
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:23 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:35370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5U6-0008JY-R5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:18 -0400
Received: by mail-pf0-x230.google.com with SMTP id g13so1629864pfm.2
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:41:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:44 -0700
Message-Id: <20170907224051.21518-17-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 16/23] tcg/arm: Tighten tlb indexing offset test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

We are not going to use ldrd for loading the comparator
for 32-bit guests, so don't limit cmp_off to 8 bits then.
This eliminates one insn in the tlb load for some guests.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 66c369c239..6c12b169ce 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1202,7 +1202,9 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     }
 
     /* We checked that the offset is contained within 16 bits above.  */
-    if (add_off > 0xfff || (use_armv6_instructions && cmp_off > 0xff)) {
+    if (add_off > 0xfff
+        || (use_armv6_instructions && TARGET_LONG_BITS == 64
+            && cmp_off > 0xff)) {
         tcg_out_dat_imm(s, COND_AL, ARITH_ADD, TCG_REG_R2, base,
                         (24 << 7) | (cmp_off >> 8));
         base = TCG_REG_R2;
-- 
2.13.5
