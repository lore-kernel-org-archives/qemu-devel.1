Received: from eggs.gnu.org ([2001:4830:134:3::10]:51451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvp-0006fS-Nm
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvo-0006g2-Nl
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:05 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:47022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYsvo-0006eU-Hl
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:04 -0500
Received: by mail-wr0-x241.google.com with SMTP id g21so8109645wrb.13
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:23:04 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:42 +0000
Message-Id: <20180109122252.17670-11-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/20] fpu/softfloat: define decompose
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

These structures pave the way for generic softfloat helper routines
that will operate on fully decomposed numbers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 59afe81d06..fcba28d3f8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -83,7 +83,7 @@ this code that are retained.
  * target-dependent and needs the TARGET_* macros.
  */
 #include "qemu/osdep.h"
-
+#include "qemu/bitops.h"
 #include "fpu/softfloat.h"
 
 /* We only need stdlib for abort() */
@@ -186,6 +186,74 @@ static inline flag extractFloat64Sign(float64 a)
     return float64_val(a) >> 63;
 }
 
+/*----------------------------------------------------------------------------
+| Classify a floating point number.
+*----------------------------------------------------------------------------*/
+
+typedef enum {
+    float_class_unclassified,
+    float_class_zero,
+    float_class_normal,
+    float_class_inf,
+    float_class_qnan,
+    float_class_snan,
+    float_class_dnan,
+    float_class_msnan, /* maybe silenced */
+} float_class;
+
+/*----------------------------------------------------------------------------
+| Structure holding all of the decomposed parts of a float.
+| The exponent is unbiased and the fraction is normalized.
+*----------------------------------------------------------------------------*/
+
+typedef struct {
+    uint64_t frac   : 64;
+    int exp         : 32;
+    float_class cls : 8;
+    int             : 23;
+    bool sign       : 1;
+} decomposed_parts;
+
+#define DECOMPOSED_BINARY_POINT    (64 - 2)
+#define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
+#define DECOMPOSED_OVERFLOW_BIT    (DECOMPOSED_IMPLICIT_BIT << 1)
+
+/* Structure holding all of the relevant parameters for a format.  */
+typedef struct {
+    int exp_bias;
+    int exp_max;
+    int frac_shift;
+    uint64_t frac_lsb;
+    uint64_t frac_lsbm1;
+    uint64_t round_mask;
+    uint64_t roundeven_mask;
+} decomposed_params;
+
+#define FRAC_PARAMS(F)                     \
+    .frac_shift     = F,                   \
+    .frac_lsb       = 1ull << (F),         \
+    .frac_lsbm1     = 1ull << ((F) - 1),   \
+    .round_mask     = (1ull << (F)) - 1,   \
+    .roundeven_mask = (2ull << (F)) - 1
+
+static const decomposed_params float16_params = {
+    .exp_bias       = 0x0f,
+    .exp_max        = 0x1f,
+    FRAC_PARAMS(DECOMPOSED_BINARY_POINT - 10)
+};
+
+static const decomposed_params float32_params = {
+    .exp_bias       = 0x7f,
+    .exp_max        = 0xff,
+    FRAC_PARAMS(DECOMPOSED_BINARY_POINT - 23)
+};
+
+static const decomposed_params float64_params = {
+    .exp_bias       = 0x3ff,
+    .exp_max        = 0x7ff,
+    FRAC_PARAMS(DECOMPOSED_BINARY_POINT - 52)
+};
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
-- 
2.15.1
