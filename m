Received: from eggs.gnu.org ([2001:4830:134:3::10]:33661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdd-0005Et-Vh
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIda-00031R-UO
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:54 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHIda-00031G-Nz
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:50 -0400
Received: by mail-pg0-x244.google.com with SMTP id n1-v6so3086681pgs.2
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:43:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:43:09 -0700
Message-Id: <20180512004311.9299-26-richard.henderson@linaro.org>
In-Reply-To: <20180512004311.9299-1-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 25/27] fpu/softfloat: Make is_nan et al
 available to softfloat-specialize.h
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

We will need these helpers within softfloat-specialize.h, so move
the definitions above the include.  After specialization, they will
not always be used so mark them to avoid the Werror.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 15a272759d..bafb3b17ec 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -181,6 +181,22 @@ typedef enum __attribute__ ((__packed__)) {
     float_class_snan,
 } FloatClass;
 
+/* Simple helpers for checking if what NaN we have */
+static inline __attribute__((unused)) bool is_nan(FloatClass c)
+{
+    return unlikely(c >= float_class_qnan);
+}
+
+static inline __attribute__((unused)) bool is_snan(FloatClass c)
+{
+    return c == float_class_snan;
+}
+
+static inline __attribute__((unused)) bool is_qnan(FloatClass c)
+{
+    return c == float_class_qnan;
+}
+
 /*
  * Structure holding all of the decomposed parts of a float. The
  * exponent is unbiased and the fraction is normalized. All
@@ -536,20 +552,6 @@ static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
     return float64_pack_raw(round_canonical(p, s, &float64_params));
 }
 
-/* Simple helpers for checking if what NaN we have */
-static bool is_nan(FloatClass c)
-{
-    return unlikely(c >= float_class_qnan);
-}
-static bool is_snan(FloatClass c)
-{
-    return c == float_class_snan;
-}
-static bool is_qnan(FloatClass c)
-{
-    return c == float_class_qnan;
-}
-
 static FloatParts return_nan(FloatParts a, float_status *s)
 {
     switch (a.cls) {
-- 
2.17.0
