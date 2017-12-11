Received: from eggs.gnu.org ([2001:4830:134:3::10]:51575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONe4-0002QN-Cv
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONe3-0007jL-Bs
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:20 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eONe3-0007iW-5f
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:19 -0500
Received: by mail-wr0-x244.google.com with SMTP id v105so17471258wrc.3
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 04:57:18 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Dec 2017 12:56:55 +0000
Message-Id: <20171211125705.16120-10-alex.bennee@linaro.org>
In-Reply-To: <20171211125705.16120-1-alex.bennee@linaro.org>
References: <20171211125705.16120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 09/19] fpu/softfloat: define decompose
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

These structures pave the way for generic softfloat helper routines
that will operate on fully decomposed numbers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0850a78149..fe443ff234 100644
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
@@ -185,6 +185,76 @@ static inline flag extractFloat64Sign(float64 a)
 {
     return float64_val(a) >> 63;
 }
+
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
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
-- 
2.15.1
