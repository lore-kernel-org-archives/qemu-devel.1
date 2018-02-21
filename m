Received: from eggs.gnu.org ([2001:4830:134:3::10]:37224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSK0-000134-IJ
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSJz-0002Iw-Ag
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:12:24 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoSJz-0002IZ-4I
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:12:23 -0500
Received: by mail-wr0-x244.google.com with SMTP id p104so3309610wrc.12
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 03:12:23 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Feb 2018 11:05:11 +0000
Message-Id: <20180221110523.859-12-alex.bennee@linaro.org>
In-Reply-To: <20180221110523.859-1-alex.bennee@linaro.org>
References: <20180221110523.859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/22] fpu/softfloat: define decompose structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

These structures pave the way for generic softfloat helper routines
that will operate on fully decomposed numbers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 297e48f5c9..568d555595 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -83,7 +83,6 @@ this code that are retained.
  * target-dependent and needs the TARGET_* macros.
  */
 #include "qemu/osdep.h"
-
 #include "fpu/softfloat.h"
 
 /* We only need stdlib for abort() */
@@ -186,6 +185,91 @@ static inline flag extractFloat64Sign(float64 a)
     return float64_val(a) >> 63;
 }
 
+/*
+ * Classify a floating point number. Everything above float_class_qnan
+ * is a NaN so cls >= float_class_qnan is any NaN.
+ */
+
+typedef enum __attribute__ ((__packed__)) {
+    float_class_unclassified,
+    float_class_zero,
+    float_class_normal,
+    float_class_inf,
+    float_class_qnan,  /* all NaNs from here */
+    float_class_snan,
+    float_class_dnan,
+    float_class_msnan, /* maybe silenced */
+} FloatClass;
+
+/*
+ * Structure holding all of the decomposed parts of a float. The
+ * exponent is unbiased and the fraction is normalized. All
+ * calculations are done with a 64 bit fraction and then rounded as
+ * appropriate for the final format.
+ *
+ * Thanks to the packed FloatClass a decent compiler should be able to
+ * fit the whole structure into registers and avoid using the stack
+ * for parameter passing.
+ */
+
+typedef struct {
+    uint64_t frac;
+    int32_t  exp;
+    FloatClass cls;
+    bool sign;
+} FloatParts;
+
+#define DECOMPOSED_BINARY_POINT    (64 - 2)
+#define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
+#define DECOMPOSED_OVERFLOW_BIT    (DECOMPOSED_IMPLICIT_BIT << 1)
+
+/* Structure holding all of the relevant parameters for a format.
+ *   exp_size: the size of the exponent field
+ *   exp_bias: the offset applied to the exponent field
+ *   exp_max: the maximum normalised exponent
+ *   frac_size: the size of the fraction field
+ *   frac_shift: shift to normalise the fraction with DECOMPOSED_BINARY_POINT
+ * The following are computed based the size of fraction
+ *   frac_lsb: least significant bit of fraction
+ *   fram_lsbm1: the bit bellow the least significant bit (for rounding)
+ *   round_mask/roundeven_mask: masks used for rounding
+ */
+typedef struct {
+    int exp_size;
+    int exp_bias;
+    int exp_max;
+    int frac_size;
+    int frac_shift;
+    uint64_t frac_lsb;
+    uint64_t frac_lsbm1;
+    uint64_t round_mask;
+    uint64_t roundeven_mask;
+} FloatFmt;
+
+/* Expand fields based on the size of exponent and fraction */
+#define FLOAT_PARAMS(E, F)                                           \
+    .exp_size       = E,                                             \
+    .exp_bias       = ((1 << E) - 1) >> 1,                           \
+    .exp_max        = (1 << E) - 1,                                  \
+    .frac_size      = F,                                             \
+    .frac_shift     = DECOMPOSED_BINARY_POINT - F,                   \
+    .frac_lsb       = 1ull << (DECOMPOSED_BINARY_POINT - F),         \
+    .frac_lsbm1     = 1ull << ((DECOMPOSED_BINARY_POINT - F) - 1),   \
+    .round_mask     = (1ull << (DECOMPOSED_BINARY_POINT - F)) - 1,   \
+    .roundeven_mask = (2ull << (DECOMPOSED_BINARY_POINT - F)) - 1
+
+static const FloatFmt float16_params = {
+    FLOAT_PARAMS(5, 10)
+};
+
+static const FloatFmt float32_params = {
+    FLOAT_PARAMS(8, 23)
+};
+
+static const FloatFmt float64_params = {
+    FLOAT_PARAMS(11, 52)
+};
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
-- 
2.15.1
