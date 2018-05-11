Received: from eggs.gnu.org ([2001:4830:134:3::10]:51965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwA8-00079c-7Q
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwA7-0004pF-DI
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:56 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGwA7-0004ot-8E
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:55 -0400
Received: by mail-pg0-x242.google.com with SMTP id n9-v6so1676603pgq.5
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 17:43:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 17:43:30 -0700
Message-Id: <20180511004345.26708-5-richard.henderson@linaro.org>
In-Reply-To: <20180511004345.26708-1-richard.henderson@linaro.org>
References: <20180511004345.26708-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/19] fpu/softfloat: Canonicalize NaN fraction
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
 fpu/softfloat.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5e4982b035..df377b6314 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -329,10 +329,11 @@ static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
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
@@ -498,6 +499,7 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
     case float_class_qnan:
     case float_class_snan:
         exp = exp_max;
+        frac >>= parm->frac_shift;
         break;
 
     default:
@@ -1264,13 +1266,10 @@ static FloatParts float_to_float(FloatParts a,
         }
 
         /*
-         * Our only option now is to "re-pack" the NaN. As the
-         * canonilization process doesn't mess with fraction bits for
-         * NaNs we do it all here. We also reset a.exp to the
-         * destination format exp_max as the maybe_silence_nan code
-         * assumes it is correct (which is would be for non-conversions).
+         * Reset a.exp to the destination format exp_max as
+         * the maybe_silence_nan code assumes it is correct
+         * (which it would be for non-conversions).
          */
-        a.frac = a.frac << (64 - srcf->frac_size) >> (64 - dstf->frac_size);
         a.exp = dstf->exp_max;
         a.cls = float_class_msnan;
     }
-- 
2.17.0
