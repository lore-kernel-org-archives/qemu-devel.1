Received: from eggs.gnu.org ([2001:4830:134:3::10]:52640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILiC-0008FG-4q
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILiA-0008OR-Ss
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:56 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:39314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILiA-0008Mh-N0
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:54 -0400
Received: by mail-pl0-x241.google.com with SMTP id c19-v6so8153578pls.6
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:12:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:12:14 -0700
Message-Id: <20180514221219.7091-24-richard.henderson@linaro.org>
In-Reply-To: <20180514221219.7091-1-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 23/28] fpu/softfloat: Make is_nan et al
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
index e9e421728b..9934adbae5 100644
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
