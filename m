Received: from eggs.gnu.org ([2001:4830:134:3::10]:42144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIyk3-0004ix-45
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIyk1-0005Bl-UN
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:27 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:34318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIyk1-0005BX-OJ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:25 -0400
Received: by mail-pl0-x241.google.com with SMTP id ay10-v6so676886plb.1
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 08:53:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 08:52:42 -0700
Message-Id: <20180516155243.16937-28-richard.henderson@linaro.org>
In-Reply-To: <20180516155243.16937-1-richard.henderson@linaro.org>
References: <20180516155243.16937-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/28] fpu/softfloat: Clean up parts_default_nan
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

Reduce the number of ifdefs.  Correct the result for OpenRISC
and TriCore (although TriCore fixed in target-specific code).

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 9d562ed504..ec4fb6ba8b 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -129,22 +129,29 @@ static FloatParts parts_default_nan(float_status *status)
     uint64_t frac;
 
 #if defined(TARGET_SPARC) || defined(TARGET_M68K)
+    /* !snan_bit_is_one, set all bits */
     frac = (1ULL << DECOMPOSED_BINARY_POINT) - 1;
-#elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA) || \
-      defined(TARGET_S390X) || defined(TARGET_RISCV)
+#elif defined(TARGET_I386) || defined(TARGET_X86_64) \
+    || defined(TARGET_MICROBLAZE)
+    /* !snan_bit_is_one, set sign and msb */
     frac = 1ULL << (DECOMPOSED_BINARY_POINT - 1);
+    sign = 1;
 #elif defined(TARGET_HPPA)
+    /* snan_bit_is_one, set msb-1.  */
     frac = 1ULL << (DECOMPOSED_BINARY_POINT - 2);
 #else
+    /* This case is true for Alpha, ARM, MIPS, OpenRISC, PPC, RISC-V,
+     * S390, SH4, TriCore, and Xtensa.  I cannot find documentation
+     * for Unicore32; the choice from the original commit is unchanged.
+     * Our other supported targets, CRIS, LM32, Moxie, Nios2, and Tile,
+     * do not have floating-point.
+     */
     if (snan_bit_is_one(status)) {
+        /* set all bits other than msb */
         frac = (1ULL << (DECOMPOSED_BINARY_POINT - 1)) - 1;
     } else {
-#if defined(TARGET_MIPS)
+        /* set msb */
         frac = 1ULL << (DECOMPOSED_BINARY_POINT - 1);
-#else
-        frac = 1ULL << (DECOMPOSED_BINARY_POINT - 1);
-        sign = 1;
-#endif
     }
 #endif
 
-- 
2.17.0
