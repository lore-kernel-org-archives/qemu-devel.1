Received: from eggs.gnu.org ([2001:4830:134:3::10]:52658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb94-00085r-KE
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb90-0008Fu-9Q
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:06 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:49537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb90-0008Fi-57
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:02 -0400
Received: by mail-oi0-x229.google.com with SMTP id t21so3682570oih.6
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:06:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:30 -0700
Message-Id: <20170917150535.8284-13-richard.henderson@linaro.org>
In-Reply-To: <20170917150535.8284-1-richard.henderson@linaro.org>
References: <20170917150535.8284-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 12/17] tcg: Fix types in tcg_regset_{set,
 reset}_reg
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

There was a potential problem here with an ILP32 host
with 64 host registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 50dfd7c77f..25662c36d4 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -186,9 +186,9 @@ typedef enum TCGOpcode {
     NB_OPS,
 } TCGOpcode;
 
-#define tcg_regset_set_reg(d, r) (d) |= 1L << (r)
-#define tcg_regset_reset_reg(d, r) (d) &= ~(1L << (r))
-#define tcg_regset_test_reg(d, r) (((d) >> (r)) & 1)
+#define tcg_regset_set_reg(d, r)   ((d) |= (TCGRegSet)1 << (r))
+#define tcg_regset_reset_reg(d, r) ((d) &= ~((TCGRegSet)1 << (r)))
+#define tcg_regset_test_reg(d, r)  (((d) >> (r)) & 1)
 
 #ifndef TCG_TARGET_INSN_UNIT_SIZE
 # error "Missing TCG_TARGET_INSN_UNIT_SIZE"
-- 
2.13.5
