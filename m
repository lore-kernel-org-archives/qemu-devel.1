Received: from eggs.gnu.org ([2001:4830:134:3::10]:37938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmUJ1-0008QU-7M
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 21:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fmUJ0-0001Gm-Dh
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 21:27:31 -0400
Received: from mail-pl0-x232.google.com ([2607:f8b0:400e:c01::232]:44517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fmUJ0-0001GQ-7Z
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 21:27:30 -0400
Received: by mail-pl0-x232.google.com with SMTP id ba4-v6so4909042plb.11
	for <qemu-devel@nongnu.org>; Sun, 05 Aug 2018 18:27:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun,  5 Aug 2018 18:27:23 -0700
Message-Id: <20180806012723.5639-3-richard.henderson@linaro.org>
In-Reply-To: <20180806012723.5639-1-richard.henderson@linaro.org>
References: <20180806012723.5639-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] fixup! target/ppc: Use non-arithmetic
 conversions for fp load/store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, mark.cave-ayland@ilande.co.uk

---
 target/ppc/fpu_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index faea64020b..b9bb1b856e 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -61,7 +61,7 @@ uint64_t helper_todouble(uint32_t arg)
         /* Normalized operand, or Inf, or NaN.  */
         ret  = (uint64_t)extract32(arg, 30, 2) << 62;
         ret |= ((extract32(arg, 30, 1) ^ 1) * (uint64_t)7) << 59;
-        ret |= (uint64_t)extract32(arg, 0, 29) << 29;
+        ret |= (uint64_t)extract32(arg, 0, 30) << 29;
     } else {
         /* Zero or Denormalized operand.  */
         ret = (uint64_t)extract32(arg, 31, 1) << 63;
@@ -88,14 +88,14 @@ uint32_t helper_tosingle(uint64_t arg)
     if (likely(exp > 896)) {
         /* No denormalization required (includes Inf, NaN).  */
         ret  = extract64(arg, 62, 2) << 30;
-        ret |= extract64(arg, 29, 29);
+        ret |= extract64(arg, 29, 30);
     } else {
         /* Zero or Denormal result.  If the exponent is in bounds for
          * a single-precision denormal result, extract the proper bits.
          * If the input is not zero, and the exponent is out of bounds,
          * then the result is undefined; this underflows to zero.
          */
-        ret = extract64(arg, 63, 1) << 63;
+        ret = extract64(arg, 63, 1) << 31;
         if (unlikely(exp >= 874)) {
             /* Denormal result.  */
             ret |= ((1ULL << 52) | extract64(arg, 0, 52)) >> (896 + 30 - exp);
-- 
2.17.1
