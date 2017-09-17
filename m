Received: from eggs.gnu.org ([2001:4830:134:3::10]:52553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8z-00082C-BK
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8x-0008ET-Ce
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:01 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:56902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb8x-0008EG-78
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:59 -0400
Received: by mail-oi0-x22b.google.com with SMTP id y195so3686976oia.13
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:05:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:28 -0700
Message-Id: <20170917150535.8284-11-richard.henderson@linaro.org>
In-Reply-To: <20170917150535.8284-1-richard.henderson@linaro.org>
References: <20170917150535.8284-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/17] tcg: Remove tcg_regset_{or, and, andnot,
 not}
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 4 ----
 tcg/tcg.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 5bf67678d5..006e988788 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -190,10 +190,6 @@ typedef enum TCGOpcode {
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
index a4badcc85f..dff9999bc6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2216,7 +2216,7 @@ static TCGReg tcg_reg_alloc(TCGContext *s, TCGRegSet desired_regs,
     TCGReg reg;
     TCGRegSet reg_ct;
 
-    tcg_regset_andnot(reg_ct, desired_regs, allocated_regs);
+    reg_ct = desired_regs & ~allocated_regs;
     order = rev ? indirect_reg_alloc_order : tcg_target_reg_alloc_order;
 
     /* first try free registers */
-- 
2.13.5
