Received: from eggs.gnu.org ([2001:4830:134:3::10]:39591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIiOR-0003S9-2d
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIiOP-0005Hu-45
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:03 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIiOO-0005Ah-Py
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:00 -0400
Received: by mail-pf0-x241.google.com with SMTP id a20-v6so745323pfo.0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 15:26:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 15 May 2018 15:25:23 -0700
Message-Id: <20180515222540.9988-12-richard.henderson@linaro.org>
In-Reply-To: <20180515222540.9988-1-richard.henderson@linaro.org>
References: <20180515222540.9988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 11/28] fpu/softfloat: Partial support for
 ARM Alternative half-precision
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

From: Alex Bennée <alex.bennee@linaro.org>

For float16 ARM supports an alternative half-precision format which
sacrifices the ability to represent NaN/Inf in return for a higher
dynamic range.  The new FloatFmt flag, arm_althp, is then used to
modify the behaviour of canonicalize and round_canonical with respect
to representation and exception raising.

Usage of this new flag waits until we re-factor float-to-float conversions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
v3
  - squash NaN to 0 if destination is AHP F16
v4
  - handle inf -> ahp max in float_to_float not round_canonical
  - assert no nan and inf for ahp in round_canonical
  - check ahp before snan in float_to_float
v5
  - split out canonicalize and round_canonical changes from the rest
---
 fpu/softfloat.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 41253c6749..64e1ad4f98 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -220,8 +220,10 @@ typedef struct {
  *   frac_shift: shift to normalise the fraction with DECOMPOSED_BINARY_POINT
  * The following are computed based the size of fraction
  *   frac_lsb: least significant bit of fraction
- *   fram_lsbm1: the bit bellow the least significant bit (for rounding)
+ *   frac_lsbm1: the bit below the least significant bit (for rounding)
  *   round_mask/roundeven_mask: masks used for rounding
+ * The following optional modifiers are available:
+ *   arm_althp: handle ARM Alternative Half Precision
  */
 typedef struct {
     int exp_size;
@@ -233,6 +235,7 @@ typedef struct {
     uint64_t frac_lsbm1;
     uint64_t round_mask;
     uint64_t roundeven_mask;
+    bool arm_althp;
 } FloatFmt;
 
 /* Expand fields based on the size of exponent and fraction */
@@ -324,7 +327,7 @@ static inline float64 float64_pack_raw(FloatParts p)
 static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
                                float_status *status)
 {
-    if (part.exp == parm->exp_max) {
+    if (part.exp == parm->exp_max && !parm->arm_althp) {
         if (part.frac == 0) {
             part.cls = float_class_inf;
         } else {
@@ -413,7 +416,15 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
             }
             frac >>= frac_shift;
 
-            if (unlikely(exp >= exp_max)) {
+            if (parm->arm_althp) {
+                /* ARM Alt HP eschews Inf and NaN for a wider exponent.  */
+                if (unlikely(exp > exp_max)) {
+                    /* Overflow.  Return the maximum normal.  */
+                    flags = float_flag_invalid;
+                    exp = exp_max;
+                    frac = -1;
+                }
+            } else if (unlikely(exp >= exp_max)) {
                 flags |= float_flag_overflow | float_flag_inexact;
                 if (overflow_norm) {
                     exp = exp_max - 1;
@@ -464,12 +475,14 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
 
     case float_class_inf:
     do_inf:
+        assert(!parm->arm_althp);
         exp = exp_max;
         frac = 0;
         break;
 
     case float_class_qnan:
     case float_class_snan:
+        assert(!parm->arm_althp);
         exp = exp_max;
         frac >>= parm->frac_shift;
         break;
-- 
2.17.0
