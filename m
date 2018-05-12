Received: from eggs.gnu.org ([2001:4830:134:3::10]:33291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdB-0004Ef-4v
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdA-0002qY-Fe
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:25 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:42718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHIdA-0002q6-BD
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:24 -0400
Received: by mail-pg0-x242.google.com with SMTP id p9-v6so3076393pgc.9
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:43:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:42:50 -0700
Message-Id: <20180512004311.9299-7-richard.henderson@linaro.org>
In-Reply-To: <20180512004311.9299-1-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 06/27] fpu/softfloat: Canonicalize NaN
 fraction
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

Shift the NaN fraction to a canonical position, much like we do
for the fraction of normal numbers.  Immediately, this simplifies
the float-to-float conversion.  Later, this will facilitate
manipulation of NaNs within the shared code paths.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 353893aaea..a56d3d975b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -330,10 +330,11 @@ static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
         if (part.frac == 0) {
             part.cls = float_class_inf;
         } else {
+            part.frac <<= parm->frac_shift;
 #ifdef NO_SIGNALING_NANS
             part.cls = float_class_qnan;
 #else
-            int64_t msb = part.frac << (parm->frac_shift + 2);
+            int64_t msb = part.frac << 2;
             if ((msb < 0) == status->snan_bit_is_one) {
                 part.cls = float_class_snan;
             } else {
@@ -480,6 +481,7 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
     case float_class_qnan:
     case float_class_snan:
         exp = exp_max;
+        frac >>= parm->frac_shift;
         break;
 
     default:
@@ -503,6 +505,7 @@ static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
     case float_class_dnan:
         return float16_default_nan(s);
     case float_class_msnan:
+        p.frac >>= float16_params.frac_shift;
         return float16_maybe_silence_nan(float16_pack_raw(p), s);
     default:
         p = round_canonical(p, s, &float16_params);
@@ -521,6 +524,7 @@ static float32 float32_round_pack_canonical(FloatParts p, float_status *s)
     case float_class_dnan:
         return float32_default_nan(s);
     case float_class_msnan:
+        p.frac >>= float32_params.frac_shift;
         return float32_maybe_silence_nan(float32_pack_raw(p), s);
     default:
         p = round_canonical(p, s, &float32_params);
@@ -539,6 +543,7 @@ static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
     case float_class_dnan:
         return float64_default_nan(s);
     case float_class_msnan:
+        p.frac >>= float64_params.frac_shift;
         return float64_maybe_silence_nan(float64_pack_raw(p), s);
     default:
         p = round_canonical(p, s, &float64_params);
-- 
2.17.0
