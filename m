Received: from eggs.gnu.org ([2001:4830:134:3::10]:33518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdP-0004kj-Bn
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdO-0002xg-Ci
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:39 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHIdO-0002xN-6x
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:38 -0400
Received: by mail-pf0-x242.google.com with SMTP id x9-v6so3436894pfm.2
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:43:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:43:00 -0700
Message-Id: <20180512004311.9299-17-richard.henderson@linaro.org>
In-Reply-To: <20180512004311.9299-1-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 16/27] target/arm: Remove
 floatX_maybe_silence_nan from conversions
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

This is now handled properly by the generic softfloat code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c |  1 -
 target/arm/helper.c     | 12 ++----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 6f0eb83661..f92bdea732 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -466,7 +466,6 @@ float32 HELPER(fcvtx_f64_to_f32)(float64 a, CPUARMState *env)
     set_float_rounding_mode(float_round_to_zero, &tstat);
     set_float_exception_flags(0, &tstat);
     r = float64_to_float32(a, &tstat);
-    r = float32_maybe_silence_nan(r, &tstat);
     exflags = get_float_exception_flags(&tstat);
     if (exflags & float_flag_inexact) {
         r = make_float32(float32_val(r) | 1);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e05c7230d4..db8bbe52a6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11348,20 +11348,12 @@ FLOAT_CONVS(ui, d, 64, u)
 /* floating point conversion */
 float64 VFP_HELPER(fcvtd, s)(float32 x, CPUARMState *env)
 {
-    float64 r = float32_to_float64(x, &env->vfp.fp_status);
-    /* ARM requires that S<->D conversion of any kind of NaN generates
-     * a quiet NaN by forcing the most significant frac bit to 1.
-     */
-    return float64_maybe_silence_nan(r, &env->vfp.fp_status);
+    return float32_to_float64(x, &env->vfp.fp_status);
 }
 
 float32 VFP_HELPER(fcvts, d)(float64 x, CPUARMState *env)
 {
-    float32 r =  float64_to_float32(x, &env->vfp.fp_status);
-    /* ARM requires that S<->D conversion of any kind of NaN generates
-     * a quiet NaN by forcing the most significant frac bit to 1.
-     */
-    return float32_maybe_silence_nan(r, &env->vfp.fp_status);
+    return float64_to_float32(x, &env->vfp.fp_status);
 }
 
 /* VFP3 fixed point conversion.  */
-- 
2.17.0
