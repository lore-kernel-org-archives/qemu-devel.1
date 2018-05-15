Received: from eggs.gnu.org ([2001:4830:134:3::10]:39511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIiOI-0003JZ-Sw
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIiOG-00044g-Jt
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:25:54 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:40241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIiOG-0003yh-Ck
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:25:52 -0400
Received: by mail-pf0-x241.google.com with SMTP id f189-v6so736075pfa.7
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 15:25:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 15 May 2018 15:25:17 -0700
Message-Id: <20180515222540.9988-6-richard.henderson@linaro.org>
In-Reply-To: <20180515222540.9988-1-richard.henderson@linaro.org>
References: <20180515222540.9988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 05/28] fpu/softfloat: Canonicalize NaN
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

Shift the NaN fraction to a canonical position, much like we
do for the fraction of normal numbers.  This will facilitate
manipulation of NaNs within the shared code paths.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0d17027379..607c4a78d5 100644
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
