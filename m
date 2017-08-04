Received: from eggs.gnu.org ([2001:4830:134:3::10]:59846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPi-00043G-HD
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPh-0003c4-Hg
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:46 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPh-0003aE-7L
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:45 -0400
Received: by mail-pf0-x242.google.com with SMTP id h75so859905pfh.5
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:45 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:19 -0700
Message-Id: <20170804054426.10590-17-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 16/23] tcg/arm: Tighten tlb indexing
 offset test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
2.13.3
