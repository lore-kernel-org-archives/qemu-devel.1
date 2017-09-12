Received: from eggs.gnu.org ([2001:4830:134:3::10]:38153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0F-0001rP-Vx
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0F-00079m-1m
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:35 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:33036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dro0E-000799-T2
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:34 -0400
Received: by mail-pf0-x232.google.com with SMTP id y29so18669343pff.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:25:10 -0700
Message-Id: <20170912162513.21694-14-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 13/16] tcg: Remove tcg_regset_{or, and,
 andnot, not}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 4 ----
 tcg/tcg.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index e168bd2c44..8b4208ea03 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -214,10 +214,6 @@ typedef enum TCGOpcode {
 #define tcg_regset_set_reg(d, r) (d) |= 1L << (r)
 #define tcg_regset_reset_reg(d, r) (d) &= ~(1L << (r))
 #define tcg_regset_test_reg(d, r) (((d) >> (r)) & 1)
-#define tcg_regset_or(d, a, b) (d) = (a) | (b)
-#define tcg_regset_and(d, a, b) (d) = (a) & (b)
-#define tcg_regset_andnot(d, a, b) (d) = (a) & ~(b)
-#define tcg_regset_not(d, a) (d) = ~(a)
 
 #ifndef TCG_TARGET_INSN_UNIT_SIZE
 # error "Missing TCG_TARGET_INSN_UNIT_SIZE"
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 873915925f..a19767b5ef 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2306,7 +2306,7 @@ static TCGReg tcg_reg_alloc(TCGContext *s, TCGRegSet desired_regs,
     TCGReg reg;
     TCGRegSet reg_ct;
 
-    tcg_regset_andnot(reg_ct, desired_regs, allocated_regs);
+    reg_ct = desired_regs & ~allocated_regs;
     order = rev ? indirect_reg_alloc_order : tcg_target_reg_alloc_order;
 
     /* first try free registers */
-- 
2.13.5
