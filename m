Received: from eggs.gnu.org ([2001:4830:134:3::10]:42078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIyjx-0004gE-0b
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIyjw-000593-4D
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:21 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:39990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIyjv-00058r-Th
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:20 -0400
Received: by mail-pg0-x243.google.com with SMTP id l2-v6so468463pgc.7
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 08:53:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 08:52:38 -0700
Message-Id: <20180516155243.16937-24-richard.henderson@linaro.org>
In-Reply-To: <20180516155243.16937-1-richard.henderson@linaro.org>
References: <20180516155243.16937-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/28] fpu/softfloat: Make is_nan et al
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
Cc: peter.maydell@linaro.org

We will need these helpers within softfloat-specialize.h, so move
the definitions above the include.  After specialization, they will
not always be used so mark them to avoid the Werror.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 55e6701f26..ea252e0c84 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -181,6 +181,22 @@ typedef enum __attribute__ ((__packed__)) {
     float_class_snan,
 } FloatClass;
 
+/* Simple helpers for checking if, or what kind of, NaN we have */
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
