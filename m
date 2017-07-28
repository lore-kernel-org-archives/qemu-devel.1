Received: from eggs.gnu.org ([2001:4830:134:3::10]:32912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dbAMD-0004Tu-N2
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dbAM8-00042K-Oa
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:51:29 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dbAM8-000426-KN
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:51:24 -0400
Received: by mail-qt0-x242.google.com with SMTP id p3so13530756qtg.5
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 11:51:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 28 Jul 2017 11:50:49 -0700
Message-Id: <20170728185050.20395-2-rth@twiddle.net>
In-Reply-To: <20170728185050.20395-1-rth@twiddle.net>
References: <20170728185050.20395-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.10 1/2] tcg/arm: Fix runtime
 overalignment test
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
