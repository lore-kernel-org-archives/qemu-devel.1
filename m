Received: from eggs.gnu.org ([2001:4830:134:3::10]:58652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0i-0005pX-0h
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0f-0006C5-DM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:31 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:40816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0f-0006A9-87
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:29 -0500
Received: by mail-oi1-x234.google.com with SMTP id t204so3457298oie.7
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:18:52 -0600
Message-Id: <20181214031923.29527-3-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/32] tcg/i386: Always use %ebp for TCG_AREG0
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

For x86_64, this can remove a REX prefix resulting in smaller code
when manipulating globals of type i32, as we move them between backing
store via cpu_env, aka TCG_AREG0.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
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
