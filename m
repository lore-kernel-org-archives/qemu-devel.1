Received: from eggs.gnu.org ([2001:4830:134:3::10]:51753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fpNAs-0004us-Ru
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 20:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fpNAr-0000o1-SY
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 20:27:02 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:39699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fpNAr-0000mx-NI
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 20:27:01 -0400
Received: by mail-pg1-x52a.google.com with SMTP id a11-v6so8278914pgw.6
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 17:27:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 13 Aug 2018 17:26:52 -0700
Message-Id: <20180814002653.12828-4-richard.henderson@linaro.org>
In-Reply-To: <20180814002653.12828-1-richard.henderson@linaro.org>
References: <20180814002653.12828-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] target/arm: Use the int-to-float-scale
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 61454a77ec..38439a2ee8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11550,12 +11550,7 @@ float32 VFP_HELPER(fcvts, d)(float64 x, CPUARMState *env)
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
@@ -11608,38 +11603,24 @@ VFP_CONV_FIX_A64(uq, s, 32, 64, uint64)
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
2.17.1
