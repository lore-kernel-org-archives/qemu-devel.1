Received: from eggs.gnu.org ([2001:4830:134:3::10]:39823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIiOn-0003n4-JP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIiOl-0000H5-K3
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:25 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:37956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIiOl-0000BB-B8
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:23 -0400
Received: by mail-pl0-x244.google.com with SMTP id c11-v6so869410plr.5
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 15:26:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 15 May 2018 15:25:39 -0700
Message-Id: <20180515222540.9988-28-richard.henderson@linaro.org>
In-Reply-To: <20180515222540.9988-1-richard.henderson@linaro.org>
References: <20180515222540.9988-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 27/28] fpu/softfloat: Clean up
 parts_default_nan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Reduce the number of ifdefs.  Correct the result for OpenRISC
and TriCore (although TriCore fixed in target-specific code).

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
