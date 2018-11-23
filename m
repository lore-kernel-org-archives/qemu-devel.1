Received: from eggs.gnu.org ([2001:4830:134:3::10]:43767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCif-0007yS-Qu
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCia-00036F-Pu
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:09 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCia-00035H-35
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:04 -0500
Received: by mail-wm1-x344.google.com with SMTP id u13-v6so12247957wmc.4
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:22 +0100
Message-Id: <20181123144558.5048-2-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 01/37] tcg/i386: Always use %ebp for
 TCG_AREG0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

For x86_64, this can result in smaller code when manipulating
TCG_TYPE_I32, as we can omit a REX prefix.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 9fdf37f23c..7488c3d869 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -84,6 +84,8 @@ typedef enum {
     TCG_REG_RBP = TCG_REG_EBP,
     TCG_REG_RSI = TCG_REG_ESI,
     TCG_REG_RDI = TCG_REG_EDI,
+
+    TCG_AREG0 = TCG_REG_EBP,
 } TCGReg;
 
 /* used for function call generation */
@@ -194,12 +196,6 @@ extern bool have_avx2;
 #define TCG_TARGET_extract_i64_valid(ofs, len) \
     (((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
 
-#if TCG_TARGET_REG_BITS == 64
-# define TCG_AREG0 TCG_REG_R14
-#else
-# define TCG_AREG0 TCG_REG_EBP
-#endif
-
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
 }
-- 
2.17.2
