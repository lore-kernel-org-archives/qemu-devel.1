Received: from eggs.gnu.org ([2001:4830:134:3::10]:35251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8TZ-00072u-GX
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8TY-0002g1-JF
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:53 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8TY-0002N1-BY
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:52 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8TX-0006MM-3z
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:33:51 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:32:54 +0100
Message-Id: <20180824093343.11346-4-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/52] target/arm: Use the int-to-float-scale
 softfloat routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180814002653.12828-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c9bce1efcb2..456bb9cc113 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11564,12 +11564,7 @@ float32 VFP_HELPER(fcvts, d)(float64 x, CPUARMState *env)
 #define VFP_CONV_FIX_FLOAT(name, p, fsz, isz, itype) \
 float##fsz HELPER(vfp_##name##to##p)(uint##isz##_t  x, uint32_t shift, \
                                      void *fpstp) \
-{ \
-    float_status *fpst = fpstp; \
-    float##fsz tmp; \
-    tmp = itype##_to_##float##fsz(x, fpst); \
-    return float##fsz##_scalbn(tmp, -(int)shift, fpst); \
-}
+{ return itype##_to_##float##fsz##_scalbn(x, -shift, fpstp); }
 
 /* Notice that we want only input-denormal exception flags from the
  * scalbn operation: the other possible flags (overflow+inexact if
@@ -11622,38 +11617,24 @@ VFP_CONV_FIX_A64(uq, s, 32, 64, uint64)
 #undef VFP_CONV_FLOAT_FIX_ROUND
 #undef VFP_CONV_FIX_A64
 
-/* Conversion to/from f16 can overflow to infinity before/after scaling.
- * Therefore we convert to f64, scale, and then convert f64 to f16; or
- * vice versa for conversion to integer.
- *
- * For 16- and 32-bit integers, the conversion to f64 never rounds.
- * For 64-bit integers, any integer that would cause rounding will also
- * overflow to f16 infinity, so there is no double rounding problem.
- */
-
-static float16 do_postscale_fp16(float64 f, int shift, float_status *fpst)
-{
-    return float64_to_float16(float64_scalbn(f, -shift, fpst), true, fpst);
-}
-
 uint32_t HELPER(vfp_sltoh)(uint32_t x, uint32_t shift, void *fpst)
 {
-    return do_postscale_fp16(int32_to_float64(x, fpst), shift, fpst);
+    return int32_to_float16_scalbn(x, -shift, fpst);
 }
 
 uint32_t HELPER(vfp_ultoh)(uint32_t x, uint32_t shift, void *fpst)
 {
-    return do_postscale_fp16(uint32_to_float64(x, fpst), shift, fpst);
+    return uint32_to_float16_scalbn(x, -shift, fpst);
 }
 
 uint32_t HELPER(vfp_sqtoh)(uint64_t x, uint32_t shift, void *fpst)
 {
-    return do_postscale_fp16(int64_to_float64(x, fpst), shift, fpst);
+    return int64_to_float16_scalbn(x, -shift, fpst);
 }
 
 uint32_t HELPER(vfp_uqtoh)(uint64_t x, uint32_t shift, void *fpst)
 {
-    return do_postscale_fp16(uint64_to_float64(x, fpst), shift, fpst);
+    return uint64_to_float16_scalbn(x, -shift, fpst);
 }
 
 static float64 do_prescale_fp16(float16 f, int shift, float_status *fpst)
-- 
2.18.0
