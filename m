Received: from eggs.gnu.org ([2001:4830:134:3::10]:33320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdC-0004KD-PY
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdC-0002rI-2U
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:26 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHIdB-0002r3-St
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:25 -0400
Received: by mail-pf0-x241.google.com with SMTP id a14-v6so3439047pfi.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:43:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:42:51 -0700
Message-Id: <20180512004311.9299-8-richard.henderson@linaro.org>
In-Reply-To: <20180512004311.9299-1-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 07/27] fpu/softfloat: Introduce
 parts_is_snan_frac
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 15 +++++++++++++++
 fpu/softfloat.c            | 12 ++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 4fc9ea4ac0..515cb12cfa 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -86,6 +86,21 @@ this code that are retained.
 #define NO_SIGNALING_NANS 1
 #endif
 
+/*----------------------------------------------------------------------------
+| For the deconstructed floating-point with fraction FRAC, return true
+| if the fraction represents a signalling NaN; otherwise false.
+*----------------------------------------------------------------------------*/
+
+static bool parts_is_snan_frac(uint64_t frac, float_status *status)
+{
+#ifdef NO_SIGNALING_NANS
+    return false;
+#else
+    flag msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
+    return msb == status->snan_bit_is_one;
+#endif
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index a56d3d975b..cb68f2eb20 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -331,16 +331,8 @@ static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
             part.cls = float_class_inf;
         } else {
             part.frac <<= parm->frac_shift;
-#ifdef NO_SIGNALING_NANS
-            part.cls = float_class_qnan;
-#else
-            int64_t msb = part.frac << 2;
-            if ((msb < 0) == status->snan_bit_is_one) {
-                part.cls = float_class_snan;
-            } else {
-                part.cls = float_class_qnan;
-            }
-#endif
+            part.cls = (parts_is_snan_frac(part.frac, status)
+                        ? float_class_snan : float_class_qnan);
         }
     } else if (part.exp == 0) {
         if (likely(part.frac == 0)) {
-- 
2.17.0
