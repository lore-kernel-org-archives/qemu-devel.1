Received: from eggs.gnu.org ([2001:4830:134:3::10]:35149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddKbm-0006OA-BK
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddKbk-0003BO-7X
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:12:30 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddKbk-0003AT-1m
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:12:28 -0400
Received: by mail-pg0-x242.google.com with SMTP id 123so2155625pga.5
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 11:12:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 11:12:22 -0700
Message-Id: <20170803181224.21748-2-rth@twiddle.net>
In-Reply-To: <20170803181224.21748-1-rth@twiddle.net>
References: <20170803181224.21748-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL for-2.10 1/3] tcg/arm: Fix runtime overalignment
 test
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

Patch 85aa80813dd changed the IF emitting the TST instruction,
but failed to change the ?: converting CMP to CMPEQ, so the
result of the TST is ignored.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index d1793ec77d..37efcf06af 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1223,7 +1223,7 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     /* Load the tlb addend.  */
     tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R2, add_off);
 
-    tcg_out_dat_reg(s, (s_bits ? COND_EQ : COND_AL), ARITH_CMP, 0,
+    tcg_out_dat_reg(s, (a_bits ? COND_EQ : COND_AL), ARITH_CMP, 0,
                     TCG_REG_R0, TCG_REG_TMP, SHIFT_IMM_LSL(TARGET_PAGE_BITS));
 
     if (TARGET_LONG_BITS == 64) {
-- 
2.13.3
