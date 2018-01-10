Received: from eggs.gnu.org ([2001:4830:134:3::10]:50296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZBEq-0005lC-2e
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZBEn-0000fO-FI
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:55:56 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:41245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZBEn-0000en-8i
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:55:53 -0500
Received: by mail-pl0-x242.google.com with SMTP id q3so1477351plr.8
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 23:55:53 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	h80sm15740147pfj.12.2018.01.09.23.55.50 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Jan 2018 23:55:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  9 Jan 2018 23:55:46 -0800
Message-Id: <20180110075547.15841-2-richard.henderson@linaro.org>
In-Reply-To: <20180110075547.15841-1-richard.henderson@linaro.org>
References: <20180110075547.15841-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] tcg/ppc: Support tlb offsets larger than
 64k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

AArch64 with SVE has an offset of 80k to the 8th TLB.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 879885b68b..74f9b4aa34 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1524,16 +1524,15 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGMemOp opc,
 
     /* Compensate for very large offsets.  */
     if (add_off >= 0x8000) {
-        /* Most target env are smaller than 32k; none are larger than 64k.
-           Simplify the logic here merely to offset by 0x7ff0, giving us a
-           range just shy of 64k.  Check this assumption.  */
-        QEMU_BUILD_BUG_ON(offsetof(CPUArchState,
-                                   tlb_table[NB_MMU_MODES - 1][1])
-                          > 0x7ff0 + 0x7fff);
-        tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, base, 0x7ff0));
+        int low = (int16_t)cmp_off;
+        int high = cmp_off - low;
+        assert((high & 0xffff) == 0);
+        assert(cmp_off - high == (int16_t)(cmp_off - high));
+        assert(add_off - high == (int16_t)(add_off - high));
+        tcg_out32(s, ADDIS | TAI(TCG_REG_TMP1, base, high >> 16));
         base = TCG_REG_TMP1;
-        cmp_off -= 0x7ff0;
-        add_off -= 0x7ff0;
+        cmp_off -= high;
+        add_off -= high;
     }
 
     /* Extraction and shifting, part 2.  */
-- 
2.14.3
