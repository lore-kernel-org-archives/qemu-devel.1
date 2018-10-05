Received: from eggs.gnu.org ([2001:4830:134:3::10]:38625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UQg-0000Wu-DL
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UQZ-0004CC-7V
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:22 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8UQY-00045D-L2
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:15 -0400
Received: by mail-oi1-x243.google.com with SMTP id e17-v6so11080552oig.12
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 11:02:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Oct 2018 13:01:56 -0500
Message-Id: <20181005180201.11387-4-richard.henderson@linaro.org>
In-Reply-To: <20181005180201.11387-1-richard.henderson@linaro.org>
References: <20181005180201.11387-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 3/8] tests/fp/fp-test: add floating point tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

By leveraging berkeley's softfloat and testfloat.

With this we get decent coverage of softfloat.c:

$ ./fp-test -r even:	67.22% coverage
$ ./fp-test -r all:	73.11% coverage

Note that we do not yet test parts of softfloat.c that aren't
in the original softfloat library, namely:

- denormal inputs
- *_to_int16/uint16 conversions
- scalbn for fixed point
- muladd variants
- min/max
- exp2
- log2
- float*_compare (except float16_compare)

Signed-off-by: Emilio G. Cota <cota@braap.org>
[rth: Add the new modules to git_submodules.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/fp/platform.h    |  41 ++
 tests/fp/fp-test.c     | 992 +++++++++++++++++++++++++++++++++++++++++
 tests/fp/wrap.inc.c    | 653 +++++++++++++++++++++++++++
 configure              |   4 +
 tests/Makefile.include |   3 +
 tests/fp/.gitignore    |   1 +
 tests/fp/Makefile      | 597 +++++++++++++++++++++++++
 7 files changed, 2291 insertions(+)
 create mode 100644 tests/fp/platform.h
 create mode 100644 tests/fp/fp-test.c
 create mode 100644 tests/fp/wrap.inc.c
 create mode 100644 tests/fp/.gitignore
 create mode 100644 tests/fp/Makefile

diff --git a/tests/fp/platform.h b/tests/fp/platform.h
new file mode 100644
index 0000000000..c20ba70baa
--- /dev/null
+++ b/tests/fp/platform.h
@@ -0,0 +1,41 @@
+#ifndef QEMU_TESTFLOAT_PLATFORM_H
+#define QEMU_TESTFLOAT_PLATFORM_H
+/*
+ * Copyright 2011, 2012, 2013, 2014, 2015, 2016 The Regents of the University of
+ * California.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ *  1. Redistributions of source code must retain the above copyright notice,
+ *     this list of conditions, and the following disclaimer.
+ *
+ *  2. Redistributions in binary form must reproduce the above copyright notice,
+ *     this list of conditions, and the following disclaimer in the
+ *     documentation and/or other materials provided with the distribution.
+ *
+ *  3. Neither the name of the University nor the names of its contributors may
+ *     be used to endorse or promote products derived from this software without
+ *     specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS "AS IS", AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ARE
+ * DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+#include "config-host.h"
+
+#ifndef HOST_WORDS_BIGENDIAN
+#define LITTLEENDIAN 1
+/* otherwise do not define it */
+#endif
+
+#define INLINE static inline
+
+#endif /* QEMU_TESTFLOAT_PLATFORM_H */
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
new file mode 100644
index 0000000000..fca576309c
--- /dev/null
+++ b/tests/fp/fp-test.c
@@ -0,0 +1,992 @@
+/*
+ * fp-test.c - test QEMU's softfloat implementation using Berkeley's Testfloat
+ *
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * This file is derived from testfloat/source/testsoftfloat.c. Its copyright
+ * info follows:
+ *
+ * Copyright 2011, 2012, 2013, 2014, 2015, 2016, 2017 The Regents of the
+ * University of California.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ *  1. Redistributions of source code must retain the above copyright notice,
+ *     this list of conditions, and the following disclaimer.
+ *
+ *  2. Redistributions in binary form must reproduce the above copyright notice,
+ *     this list of conditions, and the following disclaimer in the
+ *     documentation and/or other materials provided with the distribution.
+ *
+ *  3. Neither the name of the University nor the names of its contributors may
+ *     be used to endorse or promote products derived from this software without
+ *     specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS "AS IS", AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ARE
+ * DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+#ifndef HW_POISON_H
+#error Must define HW_POISON_H to work around TARGET_* poisoning
+#endif
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include <math.h>
+#include "fpu/softfloat.h"
+#include "platform.h"
+
+#include "fail.h"
+#include "slowfloat.h"
+#include "functions.h"
+#include "genCases.h"
+#include "verCases.h"
+#include "writeCase.h"
+#include "testLoops.h"
+
+typedef float16_t (*abz_f16)(float16_t, float16_t);
+typedef bool (*ab_f16_z_bool)(float16_t, float16_t);
+typedef float32_t (*abz_f32)(float32_t, float32_t);
+typedef bool (*ab_f32_z_bool)(float32_t, float32_t);
+typedef float64_t (*abz_f64)(float64_t, float64_t);
+typedef bool (*ab_f64_z_bool)(float64_t, float64_t);
+typedef void (*abz_extF80M)(const extFloat80_t *, const extFloat80_t *,
+                            extFloat80_t *);
+typedef bool (*ab_extF80M_z_bool)(const extFloat80_t *, const extFloat80_t *);
+typedef void (*abz_f128M)(const float128_t *, const float128_t *, float128_t *);
+typedef bool (*ab_f128M_z_bool)(const float128_t *, const float128_t *);
+
+static const char * const round_mode_names[] = {
+    [ROUND_NEAR_EVEN] = "even",
+    [ROUND_MINMAG] = "zero",
+    [ROUND_MIN] = "down",
+    [ROUND_MAX] = "up",
+    [ROUND_NEAR_MAXMAG] = "tieaway",
+    [ROUND_ODD] = "odd",
+};
+static unsigned int *test_ops;
+static unsigned int n_test_ops;
+static unsigned int n_max_errors = 20;
+static unsigned int test_round_mode = ROUND_NEAR_EVEN;
+static unsigned int *round_modes;
+static unsigned int n_round_modes;
+static int test_level = 1;
+static uint8_t slow_init_flags;
+static uint8_t qemu_init_flags;
+
+/* qemu softfloat status */
+static float_status qsf;
+
+static const char commands_string[] =
+    "operations:\n"
+    "    <int>_to_<float>            <float>_add      <float>_eq\n"
+    "    <float>_to_<int>            <float>_sub      <float>_le\n"
+    "    <float>_to_<int>_r_minMag   <float>_mul      <float>_lt\n"
+    "    <float>_to_<float>          <float>_mulAdd   <float>_eq_signaling\n"
+    "    <float>_roundToInt          <float>_div      <float>_le_quiet\n"
+    "                                <float>_rem      <float>_lt_quiet\n"
+    "                                <float>_sqrt\n"
+    "    Where <int>: ui32, ui64, i32, i64\n"
+    "          <float>: f16, f32, f64, extF80, f128\n"
+    "    If no operation is provided, all the above are tested\n"
+    "options:\n"
+    " -e = max error count per test. Default: 20. Set no limit with 0\n"
+    " -f = initial FP exception flags (vioux). Default: none\n"
+    " -l = thoroughness level (1 (default), 2)\n"
+    " -r = rounding mode (even (default), zero, down, up, tieaway, odd)\n"
+    "      Set to 'all' to test all rounding modes, if applicable\n"
+    " -s = stop when a test fails";
+
+static void usage_complete(int argc, char *argv[])
+{
+    fprintf(stderr, "Usage: %s [options] [operation1 ...]\n", argv[0]);
+    fprintf(stderr, "%s\n", commands_string);
+    exit(EXIT_FAILURE);
+}
+
+/* keep wrappers separate but do not bother defining headers for all of them */
+#include "wrap.inc.c"
+
+static void not_implemented(void)
+{
+    fprintf(stderr, "Not implemented.\n");
+}
+
+static bool blacklisted(unsigned op, int rmode)
+{
+    /* odd has only been implemented for a few 128-bit ops */
+    if (rmode == softfloat_round_odd) {
+        switch (op) {
+        case F128_ADD:
+        case F128_SUB:
+        case F128_MUL:
+        case F128_DIV:
+        case F128_TO_F64:
+        case F128_SQRT:
+            return false;
+        default:
+            return true;
+        }
+    }
+    return false;
+}
+
+static void do_testfloat(int op, int rmode, bool exact)
+{
+    abz_f16 true_abz_f16;
+    abz_f16 subj_abz_f16;
+    ab_f16_z_bool true_f16_z_bool;
+    ab_f16_z_bool subj_f16_z_bool;
+    abz_f32 true_abz_f32;
+    abz_f32 subj_abz_f32;
+    ab_f32_z_bool true_ab_f32_z_bool;
+    ab_f32_z_bool subj_ab_f32_z_bool;
+    abz_f64 true_abz_f64;
+    abz_f64 subj_abz_f64;
+    ab_f64_z_bool true_ab_f64_z_bool;
+    ab_f64_z_bool subj_ab_f64_z_bool;
+    abz_extF80M true_abz_extF80M;
+    abz_extF80M subj_abz_extF80M;
+    ab_extF80M_z_bool true_ab_extF80M_z_bool;
+    ab_extF80M_z_bool subj_ab_extF80M_z_bool;
+    abz_f128M true_abz_f128M;
+    abz_f128M subj_abz_f128M;
+    ab_f128M_z_bool true_ab_f128M_z_bool;
+    ab_f128M_z_bool subj_ab_f128M_z_bool;
+
+    fputs(">> Testing ", stderr);
+    verCases_writeFunctionName(stderr);
+    fputs("\n", stderr);
+
+    if (blacklisted(op, rmode)) {
+        not_implemented();
+        return;
+    }
+
+    switch (op) {
+    case UI32_TO_F16:
+        test_a_ui32_z_f16(slow_ui32_to_f16, qemu_ui32_to_f16);
+        break;
+    case UI32_TO_F32:
+        test_a_ui32_z_f32(slow_ui32_to_f32, qemu_ui32_to_f32);
+        break;
+    case UI32_TO_F64:
+        test_a_ui32_z_f64(slow_ui32_to_f64, qemu_ui32_to_f64);
+        break;
+    case UI32_TO_EXTF80:
+        not_implemented();
+        break;
+    case UI32_TO_F128:
+        not_implemented();
+        break;
+    case UI64_TO_F16:
+        test_a_ui64_z_f16(slow_ui64_to_f16, qemu_ui64_to_f16);
+        break;
+    case UI64_TO_F32:
+        test_a_ui64_z_f32(slow_ui64_to_f32, qemu_ui64_to_f32);
+        break;
+    case UI64_TO_F64:
+        test_a_ui64_z_f64(slow_ui64_to_f64, qemu_ui64_to_f64);
+        break;
+    case UI64_TO_EXTF80:
+        not_implemented();
+        break;
+    case UI64_TO_F128:
+        test_a_ui64_z_f128(slow_ui64_to_f128M, qemu_ui64_to_f128M);
+        break;
+    case I32_TO_F16:
+        test_a_i32_z_f16(slow_i32_to_f16, qemu_i32_to_f16);
+        break;
+    case I32_TO_F32:
+        test_a_i32_z_f32(slow_i32_to_f32, qemu_i32_to_f32);
+        break;
+    case I32_TO_F64:
+        test_a_i32_z_f64(slow_i32_to_f64, qemu_i32_to_f64);
+        break;
+    case I32_TO_EXTF80:
+        test_a_i32_z_extF80(slow_i32_to_extF80M, qemu_i32_to_extF80M);
+        break;
+    case I32_TO_F128:
+        test_a_i32_z_f128(slow_i32_to_f128M, qemu_i32_to_f128M);
+        break;
+    case I64_TO_F16:
+        test_a_i64_z_f16(slow_i64_to_f16, qemu_i64_to_f16);
+        break;
+    case I64_TO_F32:
+        test_a_i64_z_f32(slow_i64_to_f32, qemu_i64_to_f32);
+        break;
+    case I64_TO_F64:
+        test_a_i64_z_f64(slow_i64_to_f64, qemu_i64_to_f64);
+        break;
+    case I64_TO_EXTF80:
+        test_a_i64_z_extF80(slow_i64_to_extF80M, qemu_i64_to_extF80M);
+        break;
+    case I64_TO_F128:
+        test_a_i64_z_f128(slow_i64_to_f128M, qemu_i64_to_f128M);
+        break;
+    case F16_TO_UI32:
+        test_a_f16_z_ui32_rx(slow_f16_to_ui32, qemu_f16_to_ui32, rmode, exact);
+        break;
+    case F16_TO_UI64:
+        test_a_f16_z_ui64_rx(slow_f16_to_ui64, qemu_f16_to_ui64, rmode, exact);
+        break;
+    case F16_TO_I32:
+        test_a_f16_z_i32_rx(slow_f16_to_i32, qemu_f16_to_i32, rmode, exact);
+        break;
+    case F16_TO_I64:
+        test_a_f16_z_i64_rx(slow_f16_to_i64, qemu_f16_to_i64, rmode, exact);
+        break;
+    case F16_TO_UI32_R_MINMAG:
+        test_a_f16_z_ui32_x(slow_f16_to_ui32_r_minMag,
+                            qemu_f16_to_ui32_r_minMag, exact);
+        break;
+    case F16_TO_UI64_R_MINMAG:
+        test_a_f16_z_ui64_x(slow_f16_to_ui64_r_minMag,
+                            qemu_f16_to_ui64_r_minMag, exact);
+        break;
+    case F16_TO_I32_R_MINMAG:
+        test_a_f16_z_i32_x(slow_f16_to_i32_r_minMag, qemu_f16_to_i32_r_minMag,
+                           exact);
+        break;
+    case F16_TO_I64_R_MINMAG:
+        test_a_f16_z_i64_x(slow_f16_to_i64_r_minMag, qemu_f16_to_i64_r_minMag,
+                           exact);
+        break;
+    case F16_TO_F32:
+        test_a_f16_z_f32(slow_f16_to_f32, qemu_f16_to_f32);
+        break;
+    case F16_TO_F64:
+        test_a_f16_z_f64(slow_f16_to_f64, qemu_f16_to_f64);
+        break;
+    case F16_TO_EXTF80:
+        not_implemented();
+        break;
+    case F16_TO_F128:
+        not_implemented();
+        break;
+    case F16_ROUNDTOINT:
+        test_az_f16_rx(slow_f16_roundToInt, qemu_f16_roundToInt, rmode, exact);
+        break;
+    case F16_ADD:
+        true_abz_f16 = slow_f16_add;
+        subj_abz_f16 = qemu_f16_add;
+        goto test_abz_f16;
+    case F16_SUB:
+        true_abz_f16 = slow_f16_sub;
+        subj_abz_f16 = qemu_f16_sub;
+        goto test_abz_f16;
+    case F16_MUL:
+        true_abz_f16 = slow_f16_mul;
+        subj_abz_f16 = qemu_f16_mul;
+        goto test_abz_f16;
+    case F16_DIV:
+        true_abz_f16 = slow_f16_div;
+        subj_abz_f16 = qemu_f16_div;
+        goto test_abz_f16;
+    case F16_REM:
+        not_implemented();
+        break;
+    test_abz_f16:
+        test_abz_f16(true_abz_f16, subj_abz_f16);
+        break;
+    case F16_MULADD:
+        test_abcz_f16(slow_f16_mulAdd, qemu_f16_mulAdd);
+        break;
+    case F16_SQRT:
+        test_az_f16(slow_f16_sqrt, qemu_f16_sqrt);
+        break;
+    case F16_EQ:
+        true_f16_z_bool = slow_f16_eq;
+        subj_f16_z_bool = qemu_f16_eq;
+        goto test_ab_f16_z_bool;
+    case F16_LE:
+        true_f16_z_bool = slow_f16_le;
+        subj_f16_z_bool = qemu_f16_le;
+        goto test_ab_f16_z_bool;
+    case F16_LT:
+        true_f16_z_bool = slow_f16_lt;
+        subj_f16_z_bool = qemu_f16_lt;
+        goto test_ab_f16_z_bool;
+    case F16_EQ_SIGNALING:
+        true_f16_z_bool = slow_f16_eq_signaling;
+        subj_f16_z_bool = qemu_f16_eq_signaling;
+        goto test_ab_f16_z_bool;
+    case F16_LE_QUIET:
+        true_f16_z_bool = slow_f16_le_quiet;
+        subj_f16_z_bool = qemu_f16_le_quiet;
+        goto test_ab_f16_z_bool;
+    case F16_LT_QUIET:
+        true_f16_z_bool = slow_f16_lt_quiet;
+        subj_f16_z_bool = qemu_f16_lt_quiet;
+    test_ab_f16_z_bool:
+        test_ab_f16_z_bool(true_f16_z_bool, subj_f16_z_bool);
+        break;
+    case F32_TO_UI32:
+        test_a_f32_z_ui32_rx(slow_f32_to_ui32, qemu_f32_to_ui32, rmode, exact);
+        break;
+    case F32_TO_UI64:
+        test_a_f32_z_ui64_rx(slow_f32_to_ui64, qemu_f32_to_ui64, rmode, exact);
+        break;
+    case F32_TO_I32:
+        test_a_f32_z_i32_rx(slow_f32_to_i32, qemu_f32_to_i32, rmode, exact);
+        break;
+    case F32_TO_I64:
+        test_a_f32_z_i64_rx(slow_f32_to_i64, qemu_f32_to_i64, rmode, exact);
+        break;
+    case F32_TO_UI32_R_MINMAG:
+        test_a_f32_z_ui32_x(slow_f32_to_ui32_r_minMag,
+                            qemu_f32_to_ui32_r_minMag, exact);
+        break;
+    case F32_TO_UI64_R_MINMAG:
+        test_a_f32_z_ui64_x(slow_f32_to_ui64_r_minMag,
+                            qemu_f32_to_ui64_r_minMag, exact);
+        break;
+    case F32_TO_I32_R_MINMAG:
+        test_a_f32_z_i32_x(slow_f32_to_i32_r_minMag, qemu_f32_to_i32_r_minMag,
+                           exact);
+        break;
+    case F32_TO_I64_R_MINMAG:
+        test_a_f32_z_i64_x(slow_f32_to_i64_r_minMag, qemu_f32_to_i64_r_minMag,
+                           exact);
+        break;
+    case F32_TO_F16:
+        test_a_f32_z_f16(slow_f32_to_f16, qemu_f32_to_f16);
+        break;
+    case F32_TO_F64:
+        test_a_f32_z_f64(slow_f32_to_f64, qemu_f32_to_f64);
+        break;
+    case F32_TO_EXTF80:
+        test_a_f32_z_extF80(slow_f32_to_extF80M, qemu_f32_to_extF80M);
+        break;
+    case F32_TO_F128:
+        test_a_f32_z_f128(slow_f32_to_f128M, qemu_f32_to_f128M);
+        break;
+    case F32_ROUNDTOINT:
+        test_az_f32_rx(slow_f32_roundToInt, qemu_f32_roundToInt, rmode, exact);
+        break;
+    case F32_ADD:
+        true_abz_f32 = slow_f32_add;
+        subj_abz_f32 = qemu_f32_add;
+        goto test_abz_f32;
+    case F32_SUB:
+        true_abz_f32 = slow_f32_sub;
+        subj_abz_f32 = qemu_f32_sub;
+        goto test_abz_f32;
+    case F32_MUL:
+        true_abz_f32 = slow_f32_mul;
+        subj_abz_f32 = qemu_f32_mul;
+        goto test_abz_f32;
+    case F32_DIV:
+        true_abz_f32 = slow_f32_div;
+        subj_abz_f32 = qemu_f32_div;
+        goto test_abz_f32;
+    case F32_REM:
+        true_abz_f32 = slow_f32_rem;
+        subj_abz_f32 = qemu_f32_rem;
+    test_abz_f32:
+        test_abz_f32(true_abz_f32, subj_abz_f32);
+        break;
+    case F32_MULADD:
+        test_abcz_f32(slow_f32_mulAdd, qemu_f32_mulAdd);
+        break;
+    case F32_SQRT:
+        test_az_f32(slow_f32_sqrt, qemu_f32_sqrt);
+        break;
+    case F32_EQ:
+        true_ab_f32_z_bool = slow_f32_eq;
+        subj_ab_f32_z_bool = qemu_f32_eq;
+        goto test_ab_f32_z_bool;
+    case F32_LE:
+        true_ab_f32_z_bool = slow_f32_le;
+        subj_ab_f32_z_bool = qemu_f32_le;
+        goto test_ab_f32_z_bool;
+    case F32_LT:
+        true_ab_f32_z_bool = slow_f32_lt;
+        subj_ab_f32_z_bool = qemu_f32_lt;
+        goto test_ab_f32_z_bool;
+    case F32_EQ_SIGNALING:
+        true_ab_f32_z_bool = slow_f32_eq_signaling;
+        subj_ab_f32_z_bool = qemu_f32_eq_signaling;
+        goto test_ab_f32_z_bool;
+    case F32_LE_QUIET:
+        true_ab_f32_z_bool = slow_f32_le_quiet;
+        subj_ab_f32_z_bool = qemu_f32_le_quiet;
+        goto test_ab_f32_z_bool;
+    case F32_LT_QUIET:
+        true_ab_f32_z_bool = slow_f32_lt_quiet;
+        subj_ab_f32_z_bool = qemu_f32_lt_quiet;
+    test_ab_f32_z_bool:
+        test_ab_f32_z_bool(true_ab_f32_z_bool, subj_ab_f32_z_bool);
+        break;
+    case F64_TO_UI32:
+        test_a_f64_z_ui32_rx(slow_f64_to_ui32, qemu_f64_to_ui32, rmode, exact);
+        break;
+    case F64_TO_UI64:
+        test_a_f64_z_ui64_rx(slow_f64_to_ui64, qemu_f64_to_ui64, rmode, exact);
+        break;
+    case F64_TO_I32:
+        test_a_f64_z_i32_rx(slow_f64_to_i32, qemu_f64_to_i32, rmode, exact);
+        break;
+    case F64_TO_I64:
+        test_a_f64_z_i64_rx(slow_f64_to_i64, qemu_f64_to_i64, rmode, exact);
+        break;
+    case F64_TO_UI32_R_MINMAG:
+        test_a_f64_z_ui32_x(slow_f64_to_ui32_r_minMag,
+                            qemu_f64_to_ui32_r_minMag, exact);
+        break;
+    case F64_TO_UI64_R_MINMAG:
+        test_a_f64_z_ui64_x(slow_f64_to_ui64_r_minMag,
+                            qemu_f64_to_ui64_r_minMag, exact);
+        break;
+    case F64_TO_I32_R_MINMAG:
+        test_a_f64_z_i32_x(slow_f64_to_i32_r_minMag, qemu_f64_to_i32_r_minMag,
+                           exact);
+        break;
+    case F64_TO_I64_R_MINMAG:
+        test_a_f64_z_i64_x(slow_f64_to_i64_r_minMag, qemu_f64_to_i64_r_minMag,
+                           exact);
+        break;
+    case F64_TO_F16:
+        test_a_f64_z_f16(slow_f64_to_f16, qemu_f64_to_f16);
+        break;
+    case F64_TO_F32:
+        test_a_f64_z_f32(slow_f64_to_f32, qemu_f64_to_f32);
+        break;
+    case F64_TO_EXTF80:
+        test_a_f64_z_extF80(slow_f64_to_extF80M, qemu_f64_to_extF80M);
+        break;
+    case F64_TO_F128:
+        test_a_f64_z_f128(slow_f64_to_f128M, qemu_f64_to_f128M);
+        break;
+    case F64_ROUNDTOINT:
+        test_az_f64_rx(slow_f64_roundToInt, qemu_f64_roundToInt, rmode, exact);
+        break;
+    case F64_ADD:
+        true_abz_f64 = slow_f64_add;
+        subj_abz_f64 = qemu_f64_add;
+        goto test_abz_f64;
+    case F64_SUB:
+        true_abz_f64 = slow_f64_sub;
+        subj_abz_f64 = qemu_f64_sub;
+        goto test_abz_f64;
+    case F64_MUL:
+        true_abz_f64 = slow_f64_mul;
+        subj_abz_f64 = qemu_f64_mul;
+        goto test_abz_f64;
+    case F64_DIV:
+        true_abz_f64 = slow_f64_div;
+        subj_abz_f64 = qemu_f64_div;
+        goto test_abz_f64;
+    case F64_REM:
+        true_abz_f64 = slow_f64_rem;
+        subj_abz_f64 = qemu_f64_rem;
+    test_abz_f64:
+        test_abz_f64(true_abz_f64, subj_abz_f64);
+        break;
+    case F64_MULADD:
+        test_abcz_f64(slow_f64_mulAdd, qemu_f64_mulAdd);
+        break;
+    case F64_SQRT:
+        test_az_f64(slow_f64_sqrt, qemu_f64_sqrt);
+        break;
+    case F64_EQ:
+        true_ab_f64_z_bool = slow_f64_eq;
+        subj_ab_f64_z_bool = qemu_f64_eq;
+        goto test_ab_f64_z_bool;
+    case F64_LE:
+        true_ab_f64_z_bool = slow_f64_le;
+        subj_ab_f64_z_bool = qemu_f64_le;
+        goto test_ab_f64_z_bool;
+    case F64_LT:
+        true_ab_f64_z_bool = slow_f64_lt;
+        subj_ab_f64_z_bool = qemu_f64_lt;
+        goto test_ab_f64_z_bool;
+    case F64_EQ_SIGNALING:
+        true_ab_f64_z_bool = slow_f64_eq_signaling;
+        subj_ab_f64_z_bool = qemu_f64_eq_signaling;
+        goto test_ab_f64_z_bool;
+    case F64_LE_QUIET:
+        true_ab_f64_z_bool = slow_f64_le_quiet;
+        subj_ab_f64_z_bool = qemu_f64_le_quiet;
+        goto test_ab_f64_z_bool;
+    case F64_LT_QUIET:
+        true_ab_f64_z_bool = slow_f64_lt_quiet;
+        subj_ab_f64_z_bool = qemu_f64_lt_quiet;
+    test_ab_f64_z_bool:
+        test_ab_f64_z_bool(true_ab_f64_z_bool, subj_ab_f64_z_bool);
+        break;
+    case EXTF80_TO_UI32:
+        not_implemented();
+        break;
+    case EXTF80_TO_UI64:
+        not_implemented();
+        break;
+    case EXTF80_TO_I32:
+        test_a_extF80_z_i32_rx(slow_extF80M_to_i32, qemu_extF80M_to_i32, rmode,
+                               exact);
+        break;
+    case EXTF80_TO_I64:
+        test_a_extF80_z_i64_rx(slow_extF80M_to_i64, qemu_extF80M_to_i64, rmode,
+                               exact);
+        break;
+    case EXTF80_TO_UI32_R_MINMAG:
+        not_implemented();
+        break;
+    case EXTF80_TO_UI64_R_MINMAG:
+        not_implemented();
+        break;
+    case EXTF80_TO_I32_R_MINMAG:
+        test_a_extF80_z_i32_x(slow_extF80M_to_i32_r_minMag,
+                              qemu_extF80M_to_i32_r_minMag, exact);
+        break;
+    case EXTF80_TO_I64_R_MINMAG:
+        test_a_extF80_z_i64_x(slow_extF80M_to_i64_r_minMag,
+                              qemu_extF80M_to_i64_r_minMag, exact);
+        break;
+    case EXTF80_TO_F16:
+        not_implemented();
+        break;
+    case EXTF80_TO_F32:
+        test_a_extF80_z_f32(slow_extF80M_to_f32, qemu_extF80M_to_f32);
+        break;
+    case EXTF80_TO_F64:
+        test_a_extF80_z_f64(slow_extF80M_to_f64, qemu_extF80M_to_f64);
+        break;
+    case EXTF80_TO_F128:
+        test_a_extF80_z_f128(slow_extF80M_to_f128M, qemu_extF80M_to_f128M);
+        break;
+    case EXTF80_ROUNDTOINT:
+        test_az_extF80_rx(slow_extF80M_roundToInt, qemu_extF80M_roundToInt,
+                          rmode, exact);
+        break;
+    case EXTF80_ADD:
+        true_abz_extF80M = slow_extF80M_add;
+        subj_abz_extF80M = qemu_extF80M_add;
+        goto test_abz_extF80;
+    case EXTF80_SUB:
+        true_abz_extF80M = slow_extF80M_sub;
+        subj_abz_extF80M = qemu_extF80M_sub;
+        goto test_abz_extF80;
+    case EXTF80_MUL:
+        true_abz_extF80M = slow_extF80M_mul;
+        subj_abz_extF80M = qemu_extF80M_mul;
+        goto test_abz_extF80;
+    case EXTF80_DIV:
+        true_abz_extF80M = slow_extF80M_div;
+        subj_abz_extF80M = qemu_extF80M_div;
+        goto test_abz_extF80;
+    case EXTF80_REM:
+        true_abz_extF80M = slow_extF80M_rem;
+        subj_abz_extF80M = qemu_extF80M_rem;
+    test_abz_extF80:
+        test_abz_extF80(true_abz_extF80M, subj_abz_extF80M);
+        break;
+    case EXTF80_SQRT:
+        test_az_extF80(slow_extF80M_sqrt, qemu_extF80M_sqrt);
+        break;
+    case EXTF80_EQ:
+        true_ab_extF80M_z_bool = slow_extF80M_eq;
+        subj_ab_extF80M_z_bool = qemu_extF80M_eq;
+        goto test_ab_extF80_z_bool;
+    case EXTF80_LE:
+        true_ab_extF80M_z_bool = slow_extF80M_le;
+        subj_ab_extF80M_z_bool = qemu_extF80M_le;
+        goto test_ab_extF80_z_bool;
+    case EXTF80_LT:
+        true_ab_extF80M_z_bool = slow_extF80M_lt;
+        subj_ab_extF80M_z_bool = qemu_extF80M_lt;
+        goto test_ab_extF80_z_bool;
+    case EXTF80_EQ_SIGNALING:
+        true_ab_extF80M_z_bool = slow_extF80M_eq_signaling;
+        subj_ab_extF80M_z_bool = qemu_extF80M_eq_signaling;
+        goto test_ab_extF80_z_bool;
+    case EXTF80_LE_QUIET:
+        true_ab_extF80M_z_bool = slow_extF80M_le_quiet;
+        subj_ab_extF80M_z_bool = qemu_extF80M_le_quiet;
+        goto test_ab_extF80_z_bool;
+    case EXTF80_LT_QUIET:
+        true_ab_extF80M_z_bool = slow_extF80M_lt_quiet;
+        subj_ab_extF80M_z_bool = qemu_extF80M_lt_quiet;
+    test_ab_extF80_z_bool:
+        test_ab_extF80_z_bool(true_ab_extF80M_z_bool, subj_ab_extF80M_z_bool);
+        break;
+    case F128_TO_UI32:
+        not_implemented();
+        break;
+    case F128_TO_UI64:
+        test_a_f128_z_ui64_rx(slow_f128M_to_ui64, qemu_f128M_to_ui64, rmode,
+                              exact);
+        break;
+    case F128_TO_I32:
+        test_a_f128_z_i32_rx(slow_f128M_to_i32, qemu_f128M_to_i32, rmode,
+                             exact);
+        break;
+    case F128_TO_I64:
+        test_a_f128_z_i64_rx(slow_f128M_to_i64, qemu_f128M_to_i64, rmode,
+                             exact);
+        break;
+    case F128_TO_UI32_R_MINMAG:
+        test_a_f128_z_ui32_x(slow_f128M_to_ui32_r_minMag,
+                             qemu_f128M_to_ui32_r_minMag, exact);
+        break;
+    case F128_TO_UI64_R_MINMAG:
+        test_a_f128_z_ui64_x(slow_f128M_to_ui64_r_minMag,
+                             qemu_f128M_to_ui64_r_minMag, exact);
+        break;
+    case F128_TO_I32_R_MINMAG:
+        test_a_f128_z_i32_x(slow_f128M_to_i32_r_minMag,
+                            qemu_f128M_to_i32_r_minMag, exact);
+        break;
+    case F128_TO_I64_R_MINMAG:
+        test_a_f128_z_i64_x(slow_f128M_to_i64_r_minMag,
+                            qemu_f128M_to_i64_r_minMag, exact);
+        break;
+    case F128_TO_F16:
+        not_implemented();
+        break;
+    case F128_TO_F32:
+        test_a_f128_z_f32(slow_f128M_to_f32, qemu_f128M_to_f32);
+        break;
+    case F128_TO_F64:
+        test_a_f128_z_f64(slow_f128M_to_f64, qemu_f128M_to_f64);
+        break;
+    case F128_TO_EXTF80:
+        test_a_f128_z_extF80(slow_f128M_to_extF80M, qemu_f128M_to_extF80M);
+        break;
+    case F128_ROUNDTOINT:
+        test_az_f128_rx(slow_f128M_roundToInt, qemu_f128M_roundToInt, rmode,
+                        exact);
+        break;
+    case F128_ADD:
+        true_abz_f128M = slow_f128M_add;
+        subj_abz_f128M = qemu_f128M_add;
+        goto test_abz_f128;
+    case F128_SUB:
+        true_abz_f128M = slow_f128M_sub;
+        subj_abz_f128M = qemu_f128M_sub;
+        goto test_abz_f128;
+    case F128_MUL:
+        true_abz_f128M = slow_f128M_mul;
+        subj_abz_f128M = qemu_f128M_mul;
+        goto test_abz_f128;
+    case F128_DIV:
+        true_abz_f128M = slow_f128M_div;
+        subj_abz_f128M = qemu_f128M_div;
+        goto test_abz_f128;
+    case F128_REM:
+        true_abz_f128M = slow_f128M_rem;
+        subj_abz_f128M = qemu_f128M_rem;
+    test_abz_f128:
+        test_abz_f128(true_abz_f128M, subj_abz_f128M);
+        break;
+    case F128_MULADD:
+        not_implemented();
+        break;
+    case F128_SQRT:
+        test_az_f128(slow_f128M_sqrt, qemu_f128M_sqrt);
+        break;
+    case F128_EQ:
+        true_ab_f128M_z_bool = slow_f128M_eq;
+        subj_ab_f128M_z_bool = qemu_f128M_eq;
+        goto test_ab_f128_z_bool;
+    case F128_LE:
+        true_ab_f128M_z_bool = slow_f128M_le;
+        subj_ab_f128M_z_bool = qemu_f128M_le;
+        goto test_ab_f128_z_bool;
+    case F128_LT:
+        true_ab_f128M_z_bool = slow_f128M_lt;
+        subj_ab_f128M_z_bool = qemu_f128M_lt;
+        goto test_ab_f128_z_bool;
+    case F128_EQ_SIGNALING:
+        true_ab_f128M_z_bool = slow_f128M_eq_signaling;
+        subj_ab_f128M_z_bool = qemu_f128M_eq_signaling;
+        goto test_ab_f128_z_bool;
+    case F128_LE_QUIET:
+        true_ab_f128M_z_bool = slow_f128M_le_quiet;
+        subj_ab_f128M_z_bool = qemu_f128M_le_quiet;
+        goto test_ab_f128_z_bool;
+    case F128_LT_QUIET:
+        true_ab_f128M_z_bool = slow_f128M_lt_quiet;
+        subj_ab_f128M_z_bool = qemu_f128M_lt_quiet;
+    test_ab_f128_z_bool:
+        test_ab_f128_z_bool(true_ab_f128M_z_bool, subj_ab_f128M_z_bool);
+        break;
+    }
+    if ((verCases_errorStop && verCases_anyErrors)) {
+        verCases_exitWithStatus();
+    }
+}
+
+static unsigned int test_name_to_op(const char *arg)
+{
+    unsigned int i;
+
+    /* counting begins at 1 */
+    for (i = 1; i < NUM_FUNCTIONS; i++) {
+        const char *name = functionInfos[i].namePtr;
+
+        if (name && !strcmp(name, arg)) {
+            return i;
+        }
+    }
+    return 0;
+}
+
+static unsigned int round_name_to_mode(const char *name)
+{
+    int i;
+
+    /* counting begins at 1 */
+    for (i = 1; i < NUM_ROUNDINGMODES; i++) {
+        if (!strcmp(round_mode_names[i], name)) {
+            return i;
+        }
+    }
+    return 0;
+}
+
+static int set_init_flags(const char *flags)
+{
+    const char *p;
+
+    for (p = flags; *p != '\0'; p++) {
+        switch (*p) {
+        case 'v':
+            slow_init_flags |= softfloat_flag_invalid;
+            qemu_init_flags |= float_flag_invalid;
+            break;
+        case 'i':
+            slow_init_flags |= softfloat_flag_infinite;
+            qemu_init_flags |= float_flag_divbyzero;
+            break;
+        case 'o':
+            slow_init_flags |= softfloat_flag_overflow;
+            qemu_init_flags |= float_flag_overflow;
+            break;
+        case 'u':
+            slow_init_flags |= softfloat_flag_underflow;
+            qemu_init_flags |= float_flag_underflow;
+            break;
+        case 'x':
+            slow_init_flags |= softfloat_flag_inexact;
+            qemu_init_flags |= float_flag_inexact;
+            break;
+        default:
+            return 1;
+        }
+    }
+    return 0;
+}
+
+static uint8_t slow_clear_flags(void)
+{
+    uint8_t prev = slowfloat_exceptionFlags;
+
+    slowfloat_exceptionFlags = slow_init_flags;
+    return prev;
+}
+
+static uint8_t qemu_clear_flags(void)
+{
+    uint8_t prev = qemu_flags_to_sf(qsf.float_exception_flags);
+
+    qsf.float_exception_flags = qemu_init_flags;
+    return prev;
+}
+
+static void parse_args(int argc, char *argv[])
+{
+    unsigned int i;
+    int c;
+
+    for (;;) {
+        c = getopt(argc, argv, "he:f:l:r:s");
+        if (c < 0) {
+            break;
+        }
+        switch (c) {
+        case 'h':
+            usage_complete(argc, argv);
+            exit(EXIT_SUCCESS);
+        case 'e':
+            if (qemu_strtoui(optarg, NULL, 0, &n_max_errors)) {
+                fprintf(stderr, "fatal: invalid max error count\n");
+                exit(EXIT_FAILURE);
+            }
+            break;
+        case 'f':
+            if (set_init_flags(optarg)) {
+                fprintf(stderr, "fatal: flags must be a subset of 'vioux'\n");
+                exit(EXIT_FAILURE);
+            }
+            break;
+        case 'l':
+            if (qemu_strtoi(optarg, NULL, 0, &test_level)) {
+                fprintf(stderr, "fatal: invalid test level\n");
+                exit(EXIT_FAILURE);
+            }
+            break;
+        case 'r':
+            if (!strcmp(optarg, "all")) {
+                test_round_mode = 0;
+            } else {
+                test_round_mode = round_name_to_mode(optarg);
+                if (test_round_mode == 0) {
+                    fprintf(stderr, "fatal: invalid rounding mode\n");
+                    exit(EXIT_FAILURE);
+                }
+            }
+            break;
+        case 's':
+            verCases_errorStop = true;
+            break;
+        case '?':
+            /* invalid option or missing argument; getopt prints error info */
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    /* set rounding modes */
+    if (test_round_mode == 0) {
+        /* test all rounding modes; note that counting begins at 1 */
+        n_round_modes = NUM_ROUNDINGMODES - 1;
+        round_modes = g_malloc_n(n_round_modes, sizeof(*round_modes));
+        for (i = 0; i < n_round_modes; i++) {
+            round_modes[i] = i + 1;
+        }
+    } else {
+        n_round_modes = 1;
+        round_modes = g_malloc(sizeof(*round_modes));
+        round_modes[0] = test_round_mode;
+    }
+
+    /* set test ops */
+    if (optind == argc) {
+        /* test all ops; note that counting begins at 1 */
+        n_test_ops = NUM_FUNCTIONS - 1;
+        test_ops = g_malloc_n(n_test_ops, sizeof(*test_ops));
+        for (i = 0; i < n_test_ops; i++) {
+            test_ops[i] = i + 1;
+        }
+    } else {
+        n_test_ops = argc - optind;
+        test_ops = g_malloc_n(n_test_ops, sizeof(*test_ops));
+        for (i = 0; i < n_test_ops; i++) {
+            const char *name = argv[i + optind];
+            unsigned int op = test_name_to_op(name);
+
+            if (op == 0) {
+                fprintf(stderr, "fatal: invalid op '%s'\n", name);
+                exit(EXIT_FAILURE);
+            }
+            test_ops[i] = op;
+        }
+    }
+}
+
+static void QEMU_NORETURN run_test(void)
+{
+    unsigned int i;
+
+    genCases_setLevel(test_level);
+    verCases_maxErrorCount = n_max_errors;
+
+    testLoops_trueFlagsFunction = slow_clear_flags;
+    testLoops_subjFlagsFunction = qemu_clear_flags;
+
+    for (i = 0; i < n_test_ops; i++) {
+        unsigned int op = test_ops[i];
+        int j;
+
+        if (functionInfos[op].namePtr == NULL) {
+            continue;
+        }
+        verCases_functionNamePtr = functionInfos[op].namePtr;
+
+        for (j = 0; j < n_round_modes; j++) {
+            int attrs = functionInfos[op].attribs;
+            int round = round_modes[j];
+            int rmode = roundingModes[round];
+            int k;
+
+            verCases_roundingCode = 0;
+            slowfloat_roundingMode = rmode;
+            qsf.float_rounding_mode = sf_rounding_to_qemu(rmode);
+
+            if (attrs & (FUNC_ARG_ROUNDINGMODE | FUNC_EFF_ROUNDINGMODE)) {
+                /* print rounding mode if the op is affected by it */
+                verCases_roundingCode = round;
+            } else if (j > 0) {
+                /* if the op is not sensitive to rounding, move on */
+                break;
+            }
+
+            /* QEMU doesn't have !exact */
+            verCases_exact = true;
+            verCases_usesExact = !!(attrs & FUNC_ARG_EXACT);
+
+            for (k = 0; k < 3; k++) {
+                int prec80 = 32;
+                int l;
+
+                if (k == 1) {
+                    prec80 = 64;
+                } else if (k == 2) {
+                    prec80 = 80;
+                }
+
+                verCases_roundingPrecision = 0;
+                slow_extF80_roundingPrecision = prec80;
+                qsf.floatx80_rounding_precision = prec80;
+
+                if (attrs & FUNC_EFF_ROUNDINGPRECISION) {
+                    verCases_roundingPrecision = prec80;
+                } else if (k > 0) {
+                    /* if the op is not sensitive to prec80, move on */
+                    break;
+                }
+
+                /* note: the count begins at 1 */
+                for (l = 1; l < NUM_TININESSMODES; l++) {
+                    int tmode = tininessModes[l];
+
+                    verCases_tininessCode = 0;
+                    slowfloat_detectTininess = tmode;
+                    qsf.float_detect_tininess = sf_tininess_to_qemu(tmode);
+
+                    if (attrs & FUNC_EFF_TININESSMODE ||
+                        ((attrs & FUNC_EFF_TININESSMODE_REDUCEDPREC) &&
+                         prec80 && prec80 < 80)) {
+                        verCases_tininessCode = l;
+                    } else if (l > 1) {
+                        /* if the op is not sensitive to tininess, move on */
+                        break;
+                    }
+
+                    do_testfloat(op, rmode, true);
+                }
+            }
+        }
+    }
+    verCases_exitWithStatus();
+    /* old compilers might miss that we exited */
+    g_assert_not_reached();
+}
+
+int main(int argc, char *argv[])
+{
+    parse_args(argc, argv);
+    fail_programName = argv[0];
+    run_test(); /* does not return */
+}
diff --git a/tests/fp/wrap.inc.c b/tests/fp/wrap.inc.c
new file mode 100644
index 0000000000..d3bf600cd0
--- /dev/null
+++ b/tests/fp/wrap.inc.c
@@ -0,0 +1,653 @@
+/*
+ * In this file we wrap QEMU FP functions to look like softfloat/testfloat's,
+ * so that we can use the testfloat infrastructure as-is.
+ *
+ * This file must be included directly from fp-test.c. We could compile it
+ * separately, but it would be tedious to add declarations for all the wrappers.
+ */
+
+static signed char sf_tininess_to_qemu(uint_fast8_t mode)
+{
+    switch (mode) {
+    case softfloat_tininess_beforeRounding:
+        return float_tininess_before_rounding;
+    case softfloat_tininess_afterRounding:
+        return float_tininess_after_rounding;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static signed char sf_rounding_to_qemu(uint_fast8_t mode)
+{
+    switch (mode) {
+    case softfloat_round_near_even:
+        return float_round_nearest_even;
+    case softfloat_round_minMag:
+        return float_round_to_zero;
+    case softfloat_round_min:
+        return float_round_down;
+    case softfloat_round_max:
+        return float_round_up;
+    case softfloat_round_near_maxMag:
+        return float_round_ties_away;
+    case softfloat_round_odd:
+        return float_round_to_odd;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint_fast8_t qemu_flags_to_sf(uint8_t qflags)
+{
+    uint_fast8_t ret = 0;
+
+    if (qflags & float_flag_invalid) {
+        ret |= softfloat_flag_invalid;
+    }
+    if (qflags & float_flag_divbyzero) {
+        ret |= softfloat_flag_infinite;
+    }
+    if (qflags & float_flag_overflow) {
+        ret |= softfloat_flag_overflow;
+    }
+    if (qflags & float_flag_underflow) {
+        ret |= softfloat_flag_underflow;
+    }
+    if (qflags & float_flag_inexact) {
+        ret |= softfloat_flag_inexact;
+    }
+    return ret;
+}
+
+/*
+ * floatx80 and float128 cannot be cast between qemu and softfloat, because
+ * in softfloat the order of the fields depends on the host's endianness.
+ */
+static extFloat80_t qemu_to_soft80(floatx80 a)
+{
+    extFloat80_t ret;
+
+    ret.signif = a.low;
+    ret.signExp = a.high;
+    return ret;
+}
+
+static floatx80 soft_to_qemu80(extFloat80_t a)
+{
+    floatx80 ret;
+
+    ret.low = a.signif;
+    ret.high = a.signExp;
+    return ret;
+}
+
+static float128_t qemu_to_soft128(float128 a)
+{
+    float128_t ret;
+    struct uint128 *to = (struct uint128 *)&ret;
+
+    to->v0 = a.low;
+    to->v64 = a.high;
+    return ret;
+}
+
+static float128 soft_to_qemu128(float128_t a)
+{
+    struct uint128 *from = (struct uint128 *)&a;
+    float128 ret;
+
+    ret.low = from->v0;
+    ret.high = from->v64;
+    return ret;
+}
+
+/* conversions */
+#define WRAP_SF_TO_SF_IEEE(name, func, a_type, b_type)  \
+    static b_type##_t name(a_type##_t a)                \
+    {                                                   \
+        a_type *ap = (a_type *)&a;                      \
+        b_type ret;                                     \
+                                                        \
+        ret = func(*ap, true, &qsf);                    \
+        return *(b_type##_t *)&ret;                     \
+    }
+
+WRAP_SF_TO_SF_IEEE(qemu_f16_to_f32, float16_to_float32, float16, float32)
+WRAP_SF_TO_SF_IEEE(qemu_f16_to_f64, float16_to_float64, float16, float64)
+
+WRAP_SF_TO_SF_IEEE(qemu_f32_to_f16, float32_to_float16, float32, float16)
+WRAP_SF_TO_SF_IEEE(qemu_f64_to_f16, float64_to_float16, float64, float16)
+#undef WRAP_SF_TO_SF_IEEE
+
+#define WRAP_SF_TO_SF(name, func, a_type, b_type)       \
+    static b_type##_t name(a_type##_t a)                \
+    {                                                   \
+        a_type *ap = (a_type *)&a;                      \
+        b_type ret;                                     \
+                                                        \
+        ret = func(*ap, &qsf);                          \
+        return *(b_type##_t *)&ret;                     \
+    }
+
+WRAP_SF_TO_SF(qemu_f32_to_f64, float32_to_float64, float32, float64)
+WRAP_SF_TO_SF(qemu_f64_to_f32, float64_to_float32, float64, float32)
+#undef WRAP_SF_TO_SF
+
+#define WRAP_SF_TO_80(name, func, type)                 \
+    static void name(type##_t a, extFloat80_t *res)     \
+    {                                                   \
+        floatx80 ret;                                   \
+        type *ap = (type *)&a;                          \
+                                                        \
+        ret = func(*ap, &qsf);                          \
+        *res = qemu_to_soft80(ret);                     \
+    }
+
+WRAP_SF_TO_80(qemu_f32_to_extF80M, float32_to_floatx80, float32)
+WRAP_SF_TO_80(qemu_f64_to_extF80M, float64_to_floatx80, float64)
+#undef WRAP_SF_TO_80
+
+#define WRAP_SF_TO_128(name, func, type)                \
+    static void name(type##_t a, float128_t *res)       \
+    {                                                   \
+        float128 ret;                                   \
+        type *ap = (type *)&a;                          \
+                                                        \
+        ret = func(*ap, &qsf);                          \
+        *res = qemu_to_soft128(ret);                    \
+    }
+
+WRAP_SF_TO_128(qemu_f32_to_f128M, float32_to_float128, float32)
+WRAP_SF_TO_128(qemu_f64_to_f128M, float64_to_float128, float64)
+#undef WRAP_SF_TO_128
+
+/* Note: exact is ignored since qemu's softfloat assumes it is set */
+#define WRAP_SF_TO_INT(name, func, type, fast_type)                     \
+    static fast_type name(type##_t a, uint_fast8_t round, bool exact)   \
+    {                                                                   \
+        type *ap = (type *)&a;                                          \
+                                                                        \
+        qsf.float_rounding_mode = sf_rounding_to_qemu(round);           \
+        return func(*ap, &qsf);                                         \
+    }
+
+WRAP_SF_TO_INT(qemu_f16_to_ui32, float16_to_uint32, float16, uint_fast32_t)
+WRAP_SF_TO_INT(qemu_f16_to_ui64, float16_to_uint64, float16, uint_fast64_t)
+
+WRAP_SF_TO_INT(qemu_f32_to_ui32, float32_to_uint32, float32, uint_fast32_t)
+WRAP_SF_TO_INT(qemu_f32_to_ui64, float32_to_uint64, float32, uint_fast64_t)
+
+WRAP_SF_TO_INT(qemu_f64_to_ui32, float64_to_uint32, float64, uint_fast32_t)
+WRAP_SF_TO_INT(qemu_f64_to_ui64, float64_to_uint64, float64, uint_fast64_t)
+
+WRAP_SF_TO_INT(qemu_f16_to_i32, float16_to_int32, float16, int_fast32_t)
+WRAP_SF_TO_INT(qemu_f16_to_i64, float16_to_int64, float16, int_fast64_t)
+
+WRAP_SF_TO_INT(qemu_f32_to_i32, float32_to_int32, float32, int_fast32_t)
+WRAP_SF_TO_INT(qemu_f32_to_i64, float32_to_int64, float32, int_fast64_t)
+
+WRAP_SF_TO_INT(qemu_f64_to_i32, float64_to_int32, float64, int_fast32_t)
+WRAP_SF_TO_INT(qemu_f64_to_i64, float64_to_int64, float64, int_fast64_t)
+#undef WRAP_SF_TO_INT
+
+/* Note: exact is ignored since qemu's softfloat assumes it is set */
+#define WRAP_SF_TO_INT_MINMAG(name, func, type, fast_type)      \
+    static fast_type name(type##_t a, bool exact)               \
+    {                                                           \
+        type *ap = (type *)&a;                                  \
+                                                                \
+        return func(*ap, &qsf);                                 \
+    }
+
+WRAP_SF_TO_INT_MINMAG(qemu_f16_to_ui32_r_minMag,
+                      float16_to_uint32_round_to_zero, float16, uint_fast32_t)
+WRAP_SF_TO_INT_MINMAG(qemu_f16_to_ui64_r_minMag,
+                      float16_to_uint64_round_to_zero, float16, uint_fast64_t)
+
+WRAP_SF_TO_INT_MINMAG(qemu_f16_to_i32_r_minMag,
+                      float16_to_int32_round_to_zero, float16, int_fast32_t)
+WRAP_SF_TO_INT_MINMAG(qemu_f16_to_i64_r_minMag,
+                      float16_to_int64_round_to_zero, float16, int_fast64_t)
+
+WRAP_SF_TO_INT_MINMAG(qemu_f32_to_ui32_r_minMag,
+                      float32_to_uint32_round_to_zero, float32, uint_fast32_t)
+WRAP_SF_TO_INT_MINMAG(qemu_f32_to_ui64_r_minMag,
+                      float32_to_uint64_round_to_zero, float32, uint_fast64_t)
+
+WRAP_SF_TO_INT_MINMAG(qemu_f32_to_i32_r_minMag,
+                      float32_to_int32_round_to_zero, float32, int_fast32_t)
+WRAP_SF_TO_INT_MINMAG(qemu_f32_to_i64_r_minMag,
+                      float32_to_int64_round_to_zero, float32, int_fast64_t)
+
+WRAP_SF_TO_INT_MINMAG(qemu_f64_to_ui32_r_minMag,
+                      float64_to_uint32_round_to_zero, float64, uint_fast32_t)
+WRAP_SF_TO_INT_MINMAG(qemu_f64_to_ui64_r_minMag,
+                      float64_to_uint64_round_to_zero, float64, uint_fast64_t)
+
+WRAP_SF_TO_INT_MINMAG(qemu_f64_to_i32_r_minMag,
+                      float64_to_int32_round_to_zero, float64, int_fast32_t)
+WRAP_SF_TO_INT_MINMAG(qemu_f64_to_i64_r_minMag,
+                      float64_to_int64_round_to_zero, float64, int_fast64_t)
+#undef WRAP_SF_TO_INT_MINMAG
+
+#define WRAP_80_TO_SF(name, func, type)                 \
+    static type##_t name(const extFloat80_t *ap)        \
+    {                                                   \
+        floatx80 a;                                     \
+        type ret;                                       \
+                                                        \
+        a = soft_to_qemu80(*ap);                        \
+        ret = func(a, &qsf);                            \
+        return *(type##_t *)&ret;                       \
+    }
+
+WRAP_80_TO_SF(qemu_extF80M_to_f32, floatx80_to_float32, float32)
+WRAP_80_TO_SF(qemu_extF80M_to_f64, floatx80_to_float64, float64)
+#undef WRAP_80_TO_SF
+
+#define WRAP_128_TO_SF(name, func, type)        \
+    static type##_t name(const float128_t *ap)  \
+    {                                           \
+        float128 a;                             \
+        type ret;                               \
+                                                \
+        a = soft_to_qemu128(*ap);               \
+        ret = func(a, &qsf);                    \
+        return *(type##_t *)&ret;               \
+    }
+
+WRAP_128_TO_SF(qemu_f128M_to_f32, float128_to_float32, float32)
+WRAP_128_TO_SF(qemu_f128M_to_f64, float128_to_float64, float64)
+#undef WRAP_128_TO_SF
+
+static void qemu_extF80M_to_f128M(const extFloat80_t *from, float128_t *to)
+{
+    floatx80 qfrom;
+    float128 qto;
+
+    qfrom = soft_to_qemu80(*from);
+    qto = floatx80_to_float128(qfrom, &qsf);
+    *to = qemu_to_soft128(qto);
+}
+
+static void qemu_f128M_to_extF80M(const float128_t *from, extFloat80_t *to)
+{
+    float128 qfrom;
+    floatx80 qto;
+
+    qfrom = soft_to_qemu128(*from);
+    qto = float128_to_floatx80(qfrom, &qsf);
+    *to = qemu_to_soft80(qto);
+}
+
+#define WRAP_INT_TO_SF(name, func, int_type, type)      \
+    static type##_t name(int_type a)                    \
+    {                                                   \
+        type ret;                                       \
+                                                        \
+        ret = func(a, &qsf);                            \
+        return *(type##_t *)&ret;                       \
+    }
+
+WRAP_INT_TO_SF(qemu_ui32_to_f16, uint32_to_float16, uint32_t, float16)
+WRAP_INT_TO_SF(qemu_ui32_to_f32, uint32_to_float32, uint32_t, float32)
+WRAP_INT_TO_SF(qemu_ui32_to_f64, uint32_to_float64, uint32_t, float64)
+
+WRAP_INT_TO_SF(qemu_ui64_to_f16, uint64_to_float16, uint64_t, float16)
+WRAP_INT_TO_SF(qemu_ui64_to_f32, uint64_to_float32, uint64_t, float32)
+WRAP_INT_TO_SF(qemu_ui64_to_f64, uint64_to_float64, uint64_t, float64)
+
+WRAP_INT_TO_SF(qemu_i32_to_f16, int32_to_float16, int32_t, float16)
+WRAP_INT_TO_SF(qemu_i32_to_f32, int32_to_float32, int32_t, float32)
+WRAP_INT_TO_SF(qemu_i32_to_f64, int32_to_float64, int32_t, float64)
+
+WRAP_INT_TO_SF(qemu_i64_to_f16, int64_to_float16, int64_t, float16)
+WRAP_INT_TO_SF(qemu_i64_to_f32, int64_to_float32, int64_t, float32)
+WRAP_INT_TO_SF(qemu_i64_to_f64, int64_to_float64, int64_t, float64)
+#undef WRAP_INT_TO_SF
+
+#define WRAP_INT_TO_80(name, func, int_type)            \
+    static void name(int_type a, extFloat80_t *res)     \
+    {                                                   \
+        floatx80 ret;                                   \
+                                                        \
+        ret = func(a, &qsf);                            \
+        *res = qemu_to_soft80(ret);                     \
+    }
+
+WRAP_INT_TO_80(qemu_i32_to_extF80M, int32_to_floatx80, int32_t)
+WRAP_INT_TO_80(qemu_i64_to_extF80M, int64_to_floatx80, int64_t)
+#undef WRAP_INT_TO_80
+
+/* Note: exact is ignored since qemu's softfloat assumes it is set */
+#define WRAP_80_TO_INT(name, func, fast_type)                           \
+    static fast_type name(const extFloat80_t *ap, uint_fast8_t round,   \
+                          bool exact)                                   \
+    {                                                                   \
+        floatx80 a;                                                     \
+                                                                        \
+        a = soft_to_qemu80(*ap);                                        \
+        qsf.float_rounding_mode = sf_rounding_to_qemu(round);           \
+        return func(a, &qsf);                                           \
+    }
+
+WRAP_80_TO_INT(qemu_extF80M_to_i32, floatx80_to_int32, int_fast32_t)
+WRAP_80_TO_INT(qemu_extF80M_to_i64, floatx80_to_int64, int_fast64_t)
+#undef WRAP_80_TO_INT
+
+/* Note: exact is ignored since qemu's softfloat assumes it is set */
+#define WRAP_80_TO_INT_MINMAG(name, func, fast_type)            \
+    static fast_type name(const extFloat80_t *ap, bool exact)   \
+    {                                                           \
+        floatx80 a;                                             \
+                                                                \
+        a = soft_to_qemu80(*ap);                                \
+        return func(a, &qsf);                                   \
+    }
+
+WRAP_80_TO_INT_MINMAG(qemu_extF80M_to_i32_r_minMag,
+                      floatx80_to_int32_round_to_zero, int_fast32_t)
+WRAP_80_TO_INT_MINMAG(qemu_extF80M_to_i64_r_minMag,
+                      floatx80_to_int64_round_to_zero, int_fast64_t)
+#undef WRAP_80_TO_INT_MINMAG
+
+/* Note: exact is ignored since qemu's softfloat assumes it is set */
+#define WRAP_128_TO_INT(name, func, fast_type)                          \
+    static fast_type name(const float128_t *ap, uint_fast8_t round,     \
+                          bool exact)                                   \
+    {                                                                   \
+        float128 a;                                                     \
+                                                                        \
+        a = soft_to_qemu128(*ap);                                       \
+        qsf.float_rounding_mode = sf_rounding_to_qemu(round);           \
+        return func(a, &qsf);                                           \
+    }
+
+WRAP_128_TO_INT(qemu_f128M_to_i32, float128_to_int32, int_fast32_t)
+WRAP_128_TO_INT(qemu_f128M_to_i64, float128_to_int64, int_fast64_t)
+
+WRAP_128_TO_INT(qemu_f128M_to_ui64, float128_to_uint64, uint_fast64_t)
+#undef WRAP_128_TO_INT
+
+/* Note: exact is ignored since qemu's softfloat assumes it is set */
+#define WRAP_128_TO_INT_MINMAG(name, func, fast_type)           \
+    static fast_type name(const float128_t *ap, bool exact)     \
+    {                                                           \
+        float128 a;                                             \
+                                                                \
+        a = soft_to_qemu128(*ap);                               \
+        return func(a, &qsf);                                   \
+    }
+
+WRAP_128_TO_INT_MINMAG(qemu_f128M_to_i32_r_minMag,
+                       float128_to_int32_round_to_zero, int_fast32_t)
+WRAP_128_TO_INT_MINMAG(qemu_f128M_to_i64_r_minMag,
+                       float128_to_int64_round_to_zero, int_fast64_t)
+
+WRAP_128_TO_INT_MINMAG(qemu_f128M_to_ui32_r_minMag,
+                       float128_to_uint32_round_to_zero, uint_fast32_t)
+WRAP_128_TO_INT_MINMAG(qemu_f128M_to_ui64_r_minMag,
+                       float128_to_uint64_round_to_zero, uint_fast64_t)
+#undef WRAP_128_TO_INT_MINMAG
+
+#define WRAP_INT_TO_128(name, func, int_type)           \
+    static void name(int_type a, float128_t *res)       \
+    {                                                   \
+        float128 ret;                                   \
+                                                        \
+        ret = func(a, &qsf);                            \
+        *res = qemu_to_soft128(ret);                    \
+    }
+
+WRAP_INT_TO_128(qemu_ui64_to_f128M, uint64_to_float128, uint64_t)
+
+WRAP_INT_TO_128(qemu_i32_to_f128M, int32_to_float128, int32_t)
+WRAP_INT_TO_128(qemu_i64_to_f128M, int64_to_float128, int64_t)
+#undef WRAP_INT_TO_128
+
+/* Note: exact is ignored since qemu's softfloat assumes it is set */
+#define WRAP_ROUND_TO_INT(name, func, type)                             \
+    static type##_t name(type##_t a, uint_fast8_t round, bool exact)    \
+    {                                                                   \
+        type *ap = (type *)&a;                                          \
+        type ret;                                                       \
+                                                                        \
+        qsf.float_rounding_mode = sf_rounding_to_qemu(round);           \
+        ret = func(*ap, &qsf);                                          \
+        return *(type##_t *)&ret;                                       \
+    }
+
+WRAP_ROUND_TO_INT(qemu_f16_roundToInt, float16_round_to_int, float16)
+WRAP_ROUND_TO_INT(qemu_f32_roundToInt, float32_round_to_int, float32)
+WRAP_ROUND_TO_INT(qemu_f64_roundToInt, float64_round_to_int, float64)
+#undef WRAP_ROUND_TO_INT
+
+static void qemu_extF80M_roundToInt(const extFloat80_t *ap, uint_fast8_t round,
+                                    bool exact, extFloat80_t *res)
+{
+    floatx80 a;
+    floatx80 ret;
+
+    a = soft_to_qemu80(*ap);
+    qsf.float_rounding_mode = sf_rounding_to_qemu(round);
+    ret = floatx80_round_to_int(a, &qsf);
+    *res = qemu_to_soft80(ret);
+}
+
+static void qemu_f128M_roundToInt(const float128_t *ap, uint_fast8_t round,
+                                  bool exact, float128_t *res)
+{
+    float128 a;
+    float128 ret;
+
+    a = soft_to_qemu128(*ap);
+    qsf.float_rounding_mode = sf_rounding_to_qemu(round);
+    ret = float128_round_to_int(a, &qsf);
+    *res = qemu_to_soft128(ret);
+}
+
+/* operations */
+#define WRAP1(name, func, type)                 \
+    static type##_t name(type##_t a)            \
+    {                                           \
+        type *ap = (type *)&a;                  \
+        type ret;                               \
+                                                \
+        ret = func(*ap, &qsf);                  \
+        return *(type##_t *)&ret;               \
+    }
+
+#define WRAP2(name, func, type)                         \
+    static type##_t name(type##_t a, type##_t b)        \
+    {                                                   \
+        type *ap = (type *)&a;                          \
+        type *bp = (type *)&b;                          \
+        type ret;                                       \
+                                                        \
+        ret = func(*ap, *bp, &qsf);                     \
+        return *(type##_t *)&ret;                       \
+    }
+
+#define WRAP_COMMON_OPS(b)                              \
+    WRAP1(qemu_f##b##_sqrt, float##b##_sqrt, float##b)  \
+    WRAP2(qemu_f##b##_add, float##b##_add, float##b)    \
+    WRAP2(qemu_f##b##_sub, float##b##_sub, float##b)    \
+    WRAP2(qemu_f##b##_mul, float##b##_mul, float##b)    \
+    WRAP2(qemu_f##b##_div, float##b##_div, float##b)
+
+WRAP_COMMON_OPS(16)
+WRAP_COMMON_OPS(32)
+WRAP_COMMON_OPS(64)
+#undef WRAP_COMMON
+
+WRAP2(qemu_f32_rem, float32_rem, float32)
+WRAP2(qemu_f64_rem, float64_rem, float64)
+#undef WRAP2
+#undef WRAP1
+
+#define WRAP1_80(name, func)                                    \
+    static void name(const extFloat80_t *ap, extFloat80_t *res) \
+    {                                                           \
+        floatx80 a;                                             \
+        floatx80 ret;                                           \
+                                                                \
+        a = soft_to_qemu80(*ap);                                \
+        ret = func(a, &qsf);                                    \
+        *res = qemu_to_soft80(ret);                             \
+    }
+
+WRAP1_80(qemu_extF80M_sqrt, floatx80_sqrt)
+#undef WRAP1_80
+
+#define WRAP1_128(name, func)                                   \
+    static void name(const float128_t *ap, float128_t *res)     \
+    {                                                           \
+        float128 a;                                             \
+        float128 ret;                                           \
+                                                                \
+        a = soft_to_qemu128(*ap);                               \
+        ret = func(a, &qsf);                                    \
+        *res = qemu_to_soft128(ret);                            \
+    }
+
+WRAP1_128(qemu_f128M_sqrt, float128_sqrt)
+#undef WRAP1_128
+
+#define WRAP2_80(name, func)                                            \
+    static void name(const extFloat80_t *ap, const extFloat80_t *bp,    \
+                     extFloat80_t *res)                                 \
+    {                                                                   \
+        floatx80 a;                                                     \
+        floatx80 b;                                                     \
+        floatx80 ret;                                                   \
+                                                                        \
+        a = soft_to_qemu80(*ap);                                        \
+        b = soft_to_qemu80(*bp);                                        \
+        ret = func(a, b, &qsf);                                         \
+        *res = qemu_to_soft80(ret);                                     \
+    }
+
+WRAP2_80(qemu_extF80M_add, floatx80_add)
+WRAP2_80(qemu_extF80M_sub, floatx80_sub)
+WRAP2_80(qemu_extF80M_mul, floatx80_mul)
+WRAP2_80(qemu_extF80M_div, floatx80_div)
+WRAP2_80(qemu_extF80M_rem, floatx80_rem)
+#undef WRAP2_80
+
+#define WRAP2_128(name, func)                                           \
+    static void name(const float128_t *ap, const float128_t *bp,        \
+                     float128_t *res)                                   \
+    {                                                                   \
+        float128 a;                                                     \
+        float128 b;                                                     \
+        float128 ret;                                                   \
+                                                                        \
+        a = soft_to_qemu128(*ap);                                       \
+        b = soft_to_qemu128(*bp);                                       \
+        ret = func(a, b, &qsf);                                         \
+        *res = qemu_to_soft128(ret);                                    \
+    }
+
+WRAP2_128(qemu_f128M_add, float128_add)
+WRAP2_128(qemu_f128M_sub, float128_sub)
+WRAP2_128(qemu_f128M_mul, float128_mul)
+WRAP2_128(qemu_f128M_div, float128_div)
+WRAP2_128(qemu_f128M_rem, float128_rem)
+#undef WRAP2_128
+
+#define WRAP_MULADD(name, func, type)                           \
+    static type##_t name(type##_t a, type##_t b, type##_t c)    \
+    {                                                           \
+        type *ap = (type *)&a;                                  \
+        type *bp = (type *)&b;                                  \
+        type *cp = (type *)&c;                                  \
+        type ret;                                               \
+                                                                \
+        ret = func(*ap, *bp, *cp, 0, &qsf);                     \
+        return *(type##_t *)&ret;                               \
+    }
+
+WRAP_MULADD(qemu_f16_mulAdd, float16_muladd, float16)
+WRAP_MULADD(qemu_f32_mulAdd, float32_muladd, float32)
+WRAP_MULADD(qemu_f64_mulAdd, float64_muladd, float64)
+#undef WRAP_MULADD
+
+#define WRAP_CMP16(name, func, retcond)         \
+    static bool name(float16_t a, float16_t b)  \
+    {                                           \
+        float16 *ap = (float16 *)&a;            \
+        float16 *bp = (float16 *)&b;            \
+        int ret;                                \
+                                                \
+        ret = func(*ap, *bp, &qsf);             \
+        return retcond;                         \
+    }
+
+WRAP_CMP16(qemu_f16_eq_signaling, float16_compare, ret == 0)
+WRAP_CMP16(qemu_f16_eq, float16_compare_quiet, ret == 0)
+WRAP_CMP16(qemu_f16_le, float16_compare, ret <= 0)
+WRAP_CMP16(qemu_f16_lt, float16_compare, ret < 0)
+WRAP_CMP16(qemu_f16_le_quiet, float16_compare_quiet, ret <= 0)
+WRAP_CMP16(qemu_f16_lt_quiet, float16_compare_quiet, ret < 0)
+#undef WRAP_CMP16
+
+#define WRAP_CMP(name, func, type)              \
+    static bool name(type##_t a, type##_t b)    \
+    {                                           \
+        type *ap = (type *)&a;                  \
+        type *bp = (type *)&b;                  \
+                                                \
+        return !!func(*ap, *bp, &qsf);          \
+    }
+
+#define GEN_WRAP_CMP(b)                                                 \
+    WRAP_CMP(qemu_f##b##_eq_signaling, float##b##_eq, float##b)         \
+    WRAP_CMP(qemu_f##b##_eq, float##b##_eq_quiet, float##b)             \
+    WRAP_CMP(qemu_f##b##_le, float##b##_le, float##b)                   \
+    WRAP_CMP(qemu_f##b##_lt, float##b##_lt, float##b)                   \
+    WRAP_CMP(qemu_f##b##_le_quiet, float##b##_le_quiet, float##b)       \
+    WRAP_CMP(qemu_f##b##_lt_quiet, float##b##_lt_quiet, float##b)
+
+GEN_WRAP_CMP(32)
+GEN_WRAP_CMP(64)
+#undef GEN_WRAP_CMP
+#undef WRAP_CMP
+
+#define WRAP_CMP80(name, func)                                          \
+    static bool name(const extFloat80_t *ap, const extFloat80_t *bp)    \
+    {                                                                   \
+        floatx80 a;                                                     \
+        floatx80 b;                                                     \
+                                                                        \
+        a = soft_to_qemu80(*ap);                                        \
+        b = soft_to_qemu80(*bp);                                        \
+        return !!func(a, b, &qsf);                                      \
+    }
+
+WRAP_CMP80(qemu_extF80M_eq_signaling, floatx80_eq)
+WRAP_CMP80(qemu_extF80M_eq, floatx80_eq_quiet)
+WRAP_CMP80(qemu_extF80M_le, floatx80_le)
+WRAP_CMP80(qemu_extF80M_lt, floatx80_lt)
+WRAP_CMP80(qemu_extF80M_le_quiet, floatx80_le_quiet)
+WRAP_CMP80(qemu_extF80M_lt_quiet, floatx80_le_quiet)
+#undef WRAP_CMP80
+
+#define WRAP_CMP128(name, func)                                         \
+    static bool name(const float128_t *ap, const float128_t *bp)        \
+    {                                                                   \
+        float128 a;                                                     \
+        float128 b;                                                     \
+                                                                        \
+        a = soft_to_qemu128(*ap);                                       \
+        b = soft_to_qemu128(*bp);                                       \
+        return !!func(a, b, &qsf);                                      \
+    }
+
+WRAP_CMP128(qemu_f128M_eq_signaling, float128_eq)
+WRAP_CMP128(qemu_f128M_eq, float128_eq_quiet)
+WRAP_CMP128(qemu_f128M_le, float128_le)
+WRAP_CMP128(qemu_f128M_lt, float128_lt)
+WRAP_CMP128(qemu_f128M_le_quiet, float128_le_quiet)
+WRAP_CMP128(qemu_f128M_lt_quiet, float128_lt_quiet)
+#undef WRAP_CMP128
diff --git a/configure b/configure
index f3d4b799a5..f89d293585 100755
--- a/configure
+++ b/configure
@@ -296,6 +296,8 @@ if test -e "$source_path/.git"
 then
     git_update=yes
     git_submodules="ui/keycodemapdb"
+    git_submodules="$git_submodules tests/fp/berkeley-testfloat-3"
+    git_submodules="$git_submodules tests/fp/berkeley-softfloat-3"
 else
     git_update=no
     git_submodules=""
@@ -7449,12 +7451,14 @@ fi
 
 # build tree in object directory in case the source is not in the current directory
 DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
+DIRS="$DIRS tests/fp"
 DIRS="$DIRS docs docs/interop fsdev scsi"
 DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios roms/vgabios"
 FILES="Makefile tests/tcg/Makefile qdict-test-data.txt"
 FILES="$FILES tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
 FILES="$FILES tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
+FILES="$FILES tests/fp/Makefile"
 FILES="$FILES pc-bios/optionrom/Makefile pc-bios/keymaps"
 FILES="$FILES pc-bios/spapr-rtas/Makefile"
 FILES="$FILES pc-bios/s390-ccw/Makefile"
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 175d013f4a..7a3059bf6c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -670,6 +670,9 @@ tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
 tests/atomic64-bench$(EXESUF): tests/atomic64-bench.o $(test-util-obj-y)
 
+tests/fp/%:
+	$(MAKE) -C $(dir $@) $(notdir $@)
+
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
 	hw/core/bus.o \
diff --git a/tests/fp/.gitignore b/tests/fp/.gitignore
new file mode 100644
index 0000000000..8d45d18ac4
--- /dev/null
+++ b/tests/fp/.gitignore
@@ -0,0 +1 @@
+fp-test
diff --git a/tests/fp/Makefile b/tests/fp/Makefile
new file mode 100644
index 0000000000..d649a5a1db
--- /dev/null
+++ b/tests/fp/Makefile
@@ -0,0 +1,597 @@
+BUILD_DIR := $(CURDIR)/../..
+
+include $(BUILD_DIR)/config-host.mak
+include $(SRC_PATH)/rules.mak
+
+SOFTFLOAT_DIR := $(SRC_PATH)/tests/fp/berkeley-softfloat-3
+TESTFLOAT_DIR := $(SRC_PATH)/tests/fp/berkeley-testfloat-3
+
+SF_SOURCE_DIR  := $(SOFTFLOAT_DIR)/source
+SF_INCLUDE_DIR := $(SOFTFLOAT_DIR)/source/include
+# we could use any specialize here, it doesn't matter
+SF_SPECIALIZE := 8086-SSE
+SF_SPECIALIZE_DIR := $(SF_SOURCE_DIR)/$(SF_SPECIALIZE)
+
+TF_SOURCE_DIR := $(TESTFLOAT_DIR)/source
+
+$(call set-vpath, $(SRC_PATH)/fpu $(SRC_PATH)/tests/fp)
+
+LIBQEMUUTIL := $(BUILD_DIR)/libqemuutil.a
+
+# Use this variable to be clear when we pull in our own implementation
+# We build the object with a default rule thanks to the vpath above
+QEMU_SOFTFLOAT_OBJ := softfloat.o
+
+QEMU_INCLUDES += -I$(SRC_PATH)/tests/fp
+QEMU_INCLUDES += -I$(SF_INCLUDE_DIR)
+QEMU_INCLUDES += -I$(SF_SPECIALIZE_DIR)
+QEMU_INCLUDES += -I$(TF_SOURCE_DIR)
+
+# work around TARGET_* poisoning
+QEMU_CFLAGS += -DHW_POISON_H
+
+# capstone has a platform.h file that clashes with softfloat's
+QEMU_CFLAGS := $(filter-out %capstone, $(QEMU_CFLAGS))
+
+# softfloat defines
+SF_OPTS :=
+SF_OPTS += -DSOFTFLOAT_ROUND_ODD
+SF_OPTS += -DINLINE_LEVEL=5
+SF_OPTS += -DSOFTFLOAT_FAST_DIV32TO16
+SF_OPTS += -DSOFTFLOAT_FAST_DIV64TO32
+SF_OPTS += -DSOFTFLOAT_FAST_INT64
+QEMU_CFLAGS += $(SF_OPTS)
+
+# silence the build of softfloat objects
+SF_CFLAGS += -Wno-missing-prototypes
+SF_CFLAGS += -Wno-redundant-decls
+SF_CFLAGS += -Wno-return-type
+SF_CFLAGS += -Wno-error
+
+# testfloat defines
+TF_OPTS :=
+TF_OPTS += -DFLOAT16
+TF_OPTS += -DFLOAT64
+TF_OPTS += -DEXTFLOAT80
+TF_OPTS += -DFLOAT128
+TF_OPTS += -DFLOAT_ROUND_ODD
+TF_OPTS += -DLONG_DOUBLE_IS_EXTFLOAT80
+QEMU_CFLAGS += $(TF_OPTS)
+
+# silence the build of testfloat objects
+TF_CFLAGS :=
+TF_CFLAGS += -Wno-strict-prototypes
+TF_CFLAGS += -Wno-unknown-pragmas
+TF_CFLAGS += -Wno-discarded-qualifiers
+TF_CFLAGS += -Wno-maybe-uninitialized
+TF_CFLAGS += -Wno-missing-prototypes
+TF_CFLAGS += -Wno-return-type
+TF_CFLAGS += -Wno-unused-function
+TF_CFLAGS += -Wno-error
+
+# softfloat objects
+SF_OBJS_PRIMITIVES :=
+SF_OBJS_PRIMITIVES += s_eq128.o
+SF_OBJS_PRIMITIVES += s_le128.o
+SF_OBJS_PRIMITIVES += s_lt128.o
+SF_OBJS_PRIMITIVES += s_shortShiftLeft128.o
+SF_OBJS_PRIMITIVES += s_shortShiftRight128.o
+SF_OBJS_PRIMITIVES += s_shortShiftRightJam64.o
+SF_OBJS_PRIMITIVES += s_shortShiftRightJam64Extra.o
+SF_OBJS_PRIMITIVES += s_shortShiftRightJam128.o
+SF_OBJS_PRIMITIVES += s_shortShiftRightJam128Extra.o
+SF_OBJS_PRIMITIVES += s_shiftRightJam32.o
+SF_OBJS_PRIMITIVES += s_shiftRightJam64.o
+SF_OBJS_PRIMITIVES += s_shiftRightJam64Extra.o
+SF_OBJS_PRIMITIVES += s_shiftRightJam128.o
+SF_OBJS_PRIMITIVES += s_shiftRightJam128Extra.o
+SF_OBJS_PRIMITIVES += s_shiftRightJam256M.o
+SF_OBJS_PRIMITIVES += s_countLeadingZeros8.o
+SF_OBJS_PRIMITIVES += s_countLeadingZeros16.o
+SF_OBJS_PRIMITIVES += s_countLeadingZeros32.o
+SF_OBJS_PRIMITIVES += s_countLeadingZeros64.o
+SF_OBJS_PRIMITIVES += s_add128.o
+SF_OBJS_PRIMITIVES += s_add256M.o
+SF_OBJS_PRIMITIVES += s_sub128.o
+SF_OBJS_PRIMITIVES += s_sub256M.o
+SF_OBJS_PRIMITIVES += s_mul64ByShifted32To128.o
+SF_OBJS_PRIMITIVES += s_mul64To128.o
+SF_OBJS_PRIMITIVES += s_mul128By32.o
+SF_OBJS_PRIMITIVES += s_mul128To256M.o
+SF_OBJS_PRIMITIVES += s_approxRecip_1Ks.o
+SF_OBJS_PRIMITIVES += s_approxRecip32_1.o
+SF_OBJS_PRIMITIVES += s_approxRecipSqrt_1Ks.o
+SF_OBJS_PRIMITIVES += s_approxRecipSqrt32_1.o
+
+SF_OBJS_SPECIALIZE :=
+SF_OBJS_SPECIALIZE += softfloat_raiseFlags.o
+SF_OBJS_SPECIALIZE += s_f16UIToCommonNaN.o
+SF_OBJS_SPECIALIZE += s_commonNaNToF16UI.o
+SF_OBJS_SPECIALIZE += s_propagateNaNF16UI.o
+SF_OBJS_SPECIALIZE += s_f32UIToCommonNaN.o
+SF_OBJS_SPECIALIZE += s_commonNaNToF32UI.o
+SF_OBJS_SPECIALIZE += s_propagateNaNF32UI.o
+SF_OBJS_SPECIALIZE += s_f64UIToCommonNaN.o
+SF_OBJS_SPECIALIZE += s_commonNaNToF64UI.o
+SF_OBJS_SPECIALIZE += s_propagateNaNF64UI.o
+SF_OBJS_SPECIALIZE += extF80M_isSignalingNaN.o
+SF_OBJS_SPECIALIZE += s_extF80UIToCommonNaN.o
+SF_OBJS_SPECIALIZE += s_commonNaNToExtF80UI.o
+SF_OBJS_SPECIALIZE += s_propagateNaNExtF80UI.o
+SF_OBJS_SPECIALIZE += f128M_isSignalingNaN.o
+SF_OBJS_SPECIALIZE += s_f128UIToCommonNaN.o
+SF_OBJS_SPECIALIZE += s_commonNaNToF128UI.o
+SF_OBJS_SPECIALIZE += s_propagateNaNF128UI.o
+
+SF_OBJS_OTHERS :=
+SF_OBJS_OTHERS += s_roundToUI32.o
+SF_OBJS_OTHERS += s_roundToUI64.o
+SF_OBJS_OTHERS += s_roundToI32.o
+SF_OBJS_OTHERS += s_roundToI64.o
+SF_OBJS_OTHERS += s_normSubnormalF16Sig.o
+SF_OBJS_OTHERS += s_roundPackToF16.o
+SF_OBJS_OTHERS += s_normRoundPackToF16.o
+SF_OBJS_OTHERS += s_addMagsF16.o
+SF_OBJS_OTHERS += s_subMagsF16.o
+SF_OBJS_OTHERS += s_mulAddF16.o
+SF_OBJS_OTHERS += s_normSubnormalF32Sig.o
+SF_OBJS_OTHERS += s_roundPackToF32.o
+SF_OBJS_OTHERS += s_normRoundPackToF32.o
+SF_OBJS_OTHERS += s_addMagsF32.o
+SF_OBJS_OTHERS += s_subMagsF32.o
+SF_OBJS_OTHERS += s_mulAddF32.o
+SF_OBJS_OTHERS += s_normSubnormalF64Sig.o
+SF_OBJS_OTHERS += s_roundPackToF64.o
+SF_OBJS_OTHERS += s_normRoundPackToF64.o
+SF_OBJS_OTHERS += s_addMagsF64.o
+SF_OBJS_OTHERS += s_subMagsF64.o
+SF_OBJS_OTHERS += s_mulAddF64.o
+SF_OBJS_OTHERS += s_normSubnormalExtF80Sig.o
+SF_OBJS_OTHERS += s_roundPackToExtF80.o
+SF_OBJS_OTHERS += s_normRoundPackToExtF80.o
+SF_OBJS_OTHERS += s_addMagsExtF80.o
+SF_OBJS_OTHERS += s_subMagsExtF80.o
+SF_OBJS_OTHERS += s_normSubnormalF128Sig.o
+SF_OBJS_OTHERS += s_roundPackToF128.o
+SF_OBJS_OTHERS += s_normRoundPackToF128.o
+SF_OBJS_OTHERS += s_addMagsF128.o
+SF_OBJS_OTHERS += s_subMagsF128.o
+SF_OBJS_OTHERS += s_mulAddF128.o
+SF_OBJS_OTHERS += softfloat_state.o
+SF_OBJS_OTHERS += ui32_to_f16.o
+SF_OBJS_OTHERS += ui32_to_f32.o
+SF_OBJS_OTHERS += ui32_to_f64.o
+SF_OBJS_OTHERS += ui32_to_extF80.o
+SF_OBJS_OTHERS += ui32_to_extF80M.o
+SF_OBJS_OTHERS += ui32_to_f128.o
+SF_OBJS_OTHERS += ui32_to_f128M.o
+SF_OBJS_OTHERS += ui64_to_f16.o
+SF_OBJS_OTHERS += ui64_to_f32.o
+SF_OBJS_OTHERS += ui64_to_f64.o
+SF_OBJS_OTHERS += ui64_to_extF80.o
+SF_OBJS_OTHERS += ui64_to_extF80M.o
+SF_OBJS_OTHERS += ui64_to_f128.o
+SF_OBJS_OTHERS += ui64_to_f128M.o
+SF_OBJS_OTHERS += i32_to_f16.o
+SF_OBJS_OTHERS += i32_to_f32.o
+SF_OBJS_OTHERS += i32_to_f64.o
+SF_OBJS_OTHERS += i32_to_extF80.o
+SF_OBJS_OTHERS += i32_to_extF80M.o
+SF_OBJS_OTHERS += i32_to_f128.o
+SF_OBJS_OTHERS += i32_to_f128M.o
+SF_OBJS_OTHERS += i64_to_f16.o
+SF_OBJS_OTHERS += i64_to_f32.o
+SF_OBJS_OTHERS += i64_to_f64.o
+SF_OBJS_OTHERS += i64_to_extF80.o
+SF_OBJS_OTHERS += i64_to_extF80M.o
+SF_OBJS_OTHERS += i64_to_f128.o
+SF_OBJS_OTHERS += i64_to_f128M.o
+SF_OBJS_OTHERS += f16_to_ui32.o
+SF_OBJS_OTHERS += f16_to_ui64.o
+SF_OBJS_OTHERS += f16_to_i32.o
+SF_OBJS_OTHERS += f16_to_i64.o
+SF_OBJS_OTHERS += f16_to_ui32_r_minMag.o
+SF_OBJS_OTHERS += f16_to_ui64_r_minMag.o
+SF_OBJS_OTHERS += f16_to_i32_r_minMag.o
+SF_OBJS_OTHERS += f16_to_i64_r_minMag.o
+SF_OBJS_OTHERS += f16_to_f32.o
+SF_OBJS_OTHERS += f16_to_f64.o
+SF_OBJS_OTHERS += f16_to_extF80.o
+SF_OBJS_OTHERS += f16_to_extF80M.o
+SF_OBJS_OTHERS += f16_to_f128.o
+SF_OBJS_OTHERS += f16_to_f128M.o
+SF_OBJS_OTHERS += f16_roundToInt.o
+SF_OBJS_OTHERS += f16_add.o
+SF_OBJS_OTHERS += f16_sub.o
+SF_OBJS_OTHERS += f16_mul.o
+SF_OBJS_OTHERS += f16_mulAdd.o
+SF_OBJS_OTHERS += f16_div.o
+SF_OBJS_OTHERS += f16_rem.o
+SF_OBJS_OTHERS += f16_sqrt.o
+SF_OBJS_OTHERS += f16_eq.o
+SF_OBJS_OTHERS += f16_le.o
+SF_OBJS_OTHERS += f16_lt.o
+SF_OBJS_OTHERS += f16_eq_signaling.o
+SF_OBJS_OTHERS += f16_le_quiet.o
+SF_OBJS_OTHERS += f16_lt_quiet.o
+SF_OBJS_OTHERS += f16_isSignalingNaN.o
+SF_OBJS_OTHERS += f32_to_ui32.o
+SF_OBJS_OTHERS += f32_to_ui64.o
+SF_OBJS_OTHERS += f32_to_i32.o
+SF_OBJS_OTHERS += f32_to_i64.o
+SF_OBJS_OTHERS += f32_to_ui32_r_minMag.o
+SF_OBJS_OTHERS += f32_to_ui64_r_minMag.o
+SF_OBJS_OTHERS += f32_to_i32_r_minMag.o
+SF_OBJS_OTHERS += f32_to_i64_r_minMag.o
+SF_OBJS_OTHERS += f32_to_f16.o
+SF_OBJS_OTHERS += f32_to_f64.o
+SF_OBJS_OTHERS += f32_to_extF80.o
+SF_OBJS_OTHERS += f32_to_extF80M.o
+SF_OBJS_OTHERS += f32_to_f128.o
+SF_OBJS_OTHERS += f32_to_f128M.o
+SF_OBJS_OTHERS += f32_roundToInt.o
+SF_OBJS_OTHERS += f32_add.o
+SF_OBJS_OTHERS += f32_sub.o
+SF_OBJS_OTHERS += f32_mul.o
+SF_OBJS_OTHERS += f32_mulAdd.o
+SF_OBJS_OTHERS += f32_div.o
+SF_OBJS_OTHERS += f32_rem.o
+SF_OBJS_OTHERS += f32_sqrt.o
+SF_OBJS_OTHERS += f32_eq.o
+SF_OBJS_OTHERS += f32_le.o
+SF_OBJS_OTHERS += f32_lt.o
+SF_OBJS_OTHERS += f32_eq_signaling.o
+SF_OBJS_OTHERS += f32_le_quiet.o
+SF_OBJS_OTHERS += f32_lt_quiet.o
+SF_OBJS_OTHERS += f32_isSignalingNaN.o
+SF_OBJS_OTHERS += f64_to_ui32.o
+SF_OBJS_OTHERS += f64_to_ui64.o
+SF_OBJS_OTHERS += f64_to_i32.o
+SF_OBJS_OTHERS += f64_to_i64.o
+SF_OBJS_OTHERS += f64_to_ui32_r_minMag.o
+SF_OBJS_OTHERS += f64_to_ui64_r_minMag.o
+SF_OBJS_OTHERS += f64_to_i32_r_minMag.o
+SF_OBJS_OTHERS += f64_to_i64_r_minMag.o
+SF_OBJS_OTHERS += f64_to_f16.o
+SF_OBJS_OTHERS += f64_to_f32.o
+SF_OBJS_OTHERS += f64_to_extF80.o
+SF_OBJS_OTHERS += f64_to_extF80M.o
+SF_OBJS_OTHERS += f64_to_f128.o
+SF_OBJS_OTHERS += f64_to_f128M.o
+SF_OBJS_OTHERS += f64_roundToInt.o
+SF_OBJS_OTHERS += f64_add.o
+SF_OBJS_OTHERS += f64_sub.o
+SF_OBJS_OTHERS += f64_mul.o
+SF_OBJS_OTHERS += f64_mulAdd.o
+SF_OBJS_OTHERS += f64_div.o
+SF_OBJS_OTHERS += f64_rem.o
+SF_OBJS_OTHERS += f64_sqrt.o
+SF_OBJS_OTHERS += f64_eq.o
+SF_OBJS_OTHERS += f64_le.o
+SF_OBJS_OTHERS += f64_lt.o
+SF_OBJS_OTHERS += f64_eq_signaling.o
+SF_OBJS_OTHERS += f64_le_quiet.o
+SF_OBJS_OTHERS += f64_lt_quiet.o
+SF_OBJS_OTHERS += f64_isSignalingNaN.o
+SF_OBJS_OTHERS += extF80_to_ui32.o
+SF_OBJS_OTHERS += extF80_to_ui64.o
+SF_OBJS_OTHERS += extF80_to_i32.o
+SF_OBJS_OTHERS += extF80_to_i64.o
+SF_OBJS_OTHERS += extF80_to_ui32_r_minMag.o
+SF_OBJS_OTHERS += extF80_to_ui64_r_minMag.o
+SF_OBJS_OTHERS += extF80_to_i32_r_minMag.o
+SF_OBJS_OTHERS += extF80_to_i64_r_minMag.o
+SF_OBJS_OTHERS += extF80_to_f16.o
+SF_OBJS_OTHERS += extF80_to_f32.o
+SF_OBJS_OTHERS += extF80_to_f64.o
+SF_OBJS_OTHERS += extF80_to_f128.o
+SF_OBJS_OTHERS += extF80_roundToInt.o
+SF_OBJS_OTHERS += extF80_add.o
+SF_OBJS_OTHERS += extF80_sub.o
+SF_OBJS_OTHERS += extF80_mul.o
+SF_OBJS_OTHERS += extF80_div.o
+SF_OBJS_OTHERS += extF80_rem.o
+SF_OBJS_OTHERS += extF80_sqrt.o
+SF_OBJS_OTHERS += extF80_eq.o
+SF_OBJS_OTHERS += extF80_le.o
+SF_OBJS_OTHERS += extF80_lt.o
+SF_OBJS_OTHERS += extF80_eq_signaling.o
+SF_OBJS_OTHERS += extF80_le_quiet.o
+SF_OBJS_OTHERS += extF80_lt_quiet.o
+SF_OBJS_OTHERS += extF80_isSignalingNaN.o
+SF_OBJS_OTHERS += extF80M_to_ui32.o
+SF_OBJS_OTHERS += extF80M_to_ui64.o
+SF_OBJS_OTHERS += extF80M_to_i32.o
+SF_OBJS_OTHERS += extF80M_to_i64.o
+SF_OBJS_OTHERS += extF80M_to_ui32_r_minMag.o
+SF_OBJS_OTHERS += extF80M_to_ui64_r_minMag.o
+SF_OBJS_OTHERS += extF80M_to_i32_r_minMag.o
+SF_OBJS_OTHERS += extF80M_to_i64_r_minMag.o
+SF_OBJS_OTHERS += extF80M_to_f16.o
+SF_OBJS_OTHERS += extF80M_to_f32.o
+SF_OBJS_OTHERS += extF80M_to_f64.o
+SF_OBJS_OTHERS += extF80M_to_f128M.o
+SF_OBJS_OTHERS += extF80M_roundToInt.o
+SF_OBJS_OTHERS += extF80M_add.o
+SF_OBJS_OTHERS += extF80M_sub.o
+SF_OBJS_OTHERS += extF80M_mul.o
+SF_OBJS_OTHERS += extF80M_div.o
+SF_OBJS_OTHERS += extF80M_rem.o
+SF_OBJS_OTHERS += extF80M_sqrt.o
+SF_OBJS_OTHERS += extF80M_eq.o
+SF_OBJS_OTHERS += extF80M_le.o
+SF_OBJS_OTHERS += extF80M_lt.o
+SF_OBJS_OTHERS += extF80M_eq_signaling.o
+SF_OBJS_OTHERS += extF80M_le_quiet.o
+SF_OBJS_OTHERS += extF80M_lt_quiet.o
+SF_OBJS_OTHERS += f128_to_ui32.o
+SF_OBJS_OTHERS += f128_to_ui64.o
+SF_OBJS_OTHERS += f128_to_i32.o
+SF_OBJS_OTHERS += f128_to_i64.o
+SF_OBJS_OTHERS += f128_to_ui32_r_minMag.o
+SF_OBJS_OTHERS += f128_to_ui64_r_minMag.o
+SF_OBJS_OTHERS += f128_to_i32_r_minMag.o
+SF_OBJS_OTHERS += f128_to_i64_r_minMag.o
+SF_OBJS_OTHERS += f128_to_f16.o
+SF_OBJS_OTHERS += f128_to_f32.o
+SF_OBJS_OTHERS += f128_to_extF80.o
+SF_OBJS_OTHERS += f128_to_f64.o
+SF_OBJS_OTHERS += f128_roundToInt.o
+SF_OBJS_OTHERS += f128_add.o
+SF_OBJS_OTHERS += f128_sub.o
+SF_OBJS_OTHERS += f128_mul.o
+SF_OBJS_OTHERS += f128_mulAdd.o
+SF_OBJS_OTHERS += f128_div.o
+SF_OBJS_OTHERS += f128_rem.o
+SF_OBJS_OTHERS += f128_sqrt.o
+SF_OBJS_OTHERS += f128_eq.o
+SF_OBJS_OTHERS += f128_le.o
+SF_OBJS_OTHERS += f128_lt.o
+SF_OBJS_OTHERS += f128_eq_signaling.o
+SF_OBJS_OTHERS += f128_le_quiet.o
+SF_OBJS_OTHERS += f128_lt_quiet.o
+SF_OBJS_OTHERS += f128_isSignalingNaN.o
+SF_OBJS_OTHERS += f128M_to_ui32.o
+SF_OBJS_OTHERS += f128M_to_ui64.o
+SF_OBJS_OTHERS += f128M_to_i32.o
+SF_OBJS_OTHERS += f128M_to_i64.o
+SF_OBJS_OTHERS += f128M_to_ui32_r_minMag.o
+SF_OBJS_OTHERS += f128M_to_ui64_r_minMag.o
+SF_OBJS_OTHERS += f128M_to_i32_r_minMag.o
+SF_OBJS_OTHERS += f128M_to_i64_r_minMag.o
+SF_OBJS_OTHERS += f128M_to_f16.o
+SF_OBJS_OTHERS += f128M_to_f32.o
+SF_OBJS_OTHERS += f128M_to_extF80M.o
+SF_OBJS_OTHERS += f128M_to_f64.o
+SF_OBJS_OTHERS += f128M_roundToInt.o
+SF_OBJS_OTHERS += f128M_add.o
+SF_OBJS_OTHERS += f128M_sub.o
+SF_OBJS_OTHERS += f128M_mul.o
+SF_OBJS_OTHERS += f128M_mulAdd.o
+SF_OBJS_OTHERS += f128M_div.o
+SF_OBJS_OTHERS += f128M_rem.o
+SF_OBJS_OTHERS += f128M_sqrt.o
+SF_OBJS_OTHERS += f128M_eq.o
+SF_OBJS_OTHERS += f128M_le.o
+SF_OBJS_OTHERS += f128M_lt.o
+SF_OBJS_OTHERS += f128M_eq_signaling.o
+SF_OBJS_OTHERS += f128M_le_quiet.o
+SF_OBJS_OTHERS += f128M_lt_quiet.o
+
+SF_OBJS_ALL_NOSPEC :=
+SF_OBJS_ALL_NOSPEC += $(SF_OBJS_PRIMITIVES)
+SF_OBJS_ALL_NOSPEC += $(SF_OBJS_OTHERS)
+
+SF_OBJS_ALL :=
+SF_OBJS_ALL += $(SF_OBJS_ALL_NOSPEC)
+SF_OBJS_ALL += $(SF_OBJS_SPECIALIZE)
+
+# testfloat objects
+TF_OBJS_GENCASES :=
+TF_OBJS_GENCASES += genCases_ui32.o
+TF_OBJS_GENCASES += genCases_ui64.o
+TF_OBJS_GENCASES += genCases_i32.o
+TF_OBJS_GENCASES += genCases_i64.o
+TF_OBJS_GENCASES += genCases_f16.o
+TF_OBJS_GENCASES += genCases_f32.o
+TF_OBJS_GENCASES += genCases_f64.o
+TF_OBJS_GENCASES += genCases_extF80.o
+TF_OBJS_GENCASES += genCases_f128.o
+
+TF_OBJS_WRITECASE :=
+TF_OBJS_WRITECASE += writeCase_a_ui32.o
+TF_OBJS_WRITECASE += writeCase_a_ui64.o
+TF_OBJS_WRITECASE += writeCase_a_f16.o
+TF_OBJS_WRITECASE += writeCase_ab_f16.o
+TF_OBJS_WRITECASE += writeCase_abc_f16.o
+TF_OBJS_WRITECASE += writeCase_a_f32.o
+TF_OBJS_WRITECASE += writeCase_ab_f32.o
+TF_OBJS_WRITECASE += writeCase_abc_f32.o
+TF_OBJS_WRITECASE += writeCase_a_f64.o
+TF_OBJS_WRITECASE += writeCase_ab_f64.o
+TF_OBJS_WRITECASE += writeCase_abc_f64.o
+TF_OBJS_WRITECASE += writeCase_a_extF80M.o
+TF_OBJS_WRITECASE += writeCase_ab_extF80M.o
+TF_OBJS_WRITECASE += writeCase_a_f128M.o
+TF_OBJS_WRITECASE += writeCase_ab_f128M.o
+TF_OBJS_WRITECASE += writeCase_abc_f128M.o
+TF_OBJS_WRITECASE += writeCase_z_bool.o
+TF_OBJS_WRITECASE += writeCase_z_ui32.o
+TF_OBJS_WRITECASE += writeCase_z_ui64.o
+TF_OBJS_WRITECASE += writeCase_z_f16.o
+TF_OBJS_WRITECASE += writeCase_z_f32.o
+TF_OBJS_WRITECASE += writeCase_z_f64.o
+TF_OBJS_WRITECASE += writeCase_z_extF80M.o
+TF_OBJS_WRITECASE += writeCase_z_f128M.o
+
+TF_OBJS_TEST :=
+TF_OBJS_TEST += test_a_ui32_z_f16.o
+TF_OBJS_TEST += test_a_ui32_z_f32.o
+TF_OBJS_TEST += test_a_ui32_z_f64.o
+TF_OBJS_TEST += test_a_ui32_z_extF80.o
+TF_OBJS_TEST += test_a_ui32_z_f128.o
+TF_OBJS_TEST += test_a_ui64_z_f16.o
+TF_OBJS_TEST += test_a_ui64_z_f32.o
+TF_OBJS_TEST += test_a_ui64_z_f64.o
+TF_OBJS_TEST += test_a_ui64_z_extF80.o
+TF_OBJS_TEST += test_a_ui64_z_f128.o
+TF_OBJS_TEST += test_a_i32_z_f16.o
+TF_OBJS_TEST += test_a_i32_z_f32.o
+TF_OBJS_TEST += test_a_i32_z_f64.o
+TF_OBJS_TEST += test_a_i32_z_extF80.o
+TF_OBJS_TEST += test_a_i32_z_f128.o
+TF_OBJS_TEST += test_a_i64_z_f16.o
+TF_OBJS_TEST += test_a_i64_z_f32.o
+TF_OBJS_TEST += test_a_i64_z_f64.o
+TF_OBJS_TEST += test_a_i64_z_extF80.o
+TF_OBJS_TEST += test_a_i64_z_f128.o
+TF_OBJS_TEST += test_a_f16_z_ui32_rx.o
+TF_OBJS_TEST += test_a_f16_z_ui64_rx.o
+TF_OBJS_TEST += test_a_f16_z_i32_rx.o
+TF_OBJS_TEST += test_a_f16_z_i64_rx.o
+TF_OBJS_TEST += test_a_f16_z_ui32_x.o
+TF_OBJS_TEST += test_a_f16_z_ui64_x.o
+TF_OBJS_TEST += test_a_f16_z_i32_x.o
+TF_OBJS_TEST += test_a_f16_z_i64_x.o
+TF_OBJS_TEST += test_a_f16_z_f32.o
+TF_OBJS_TEST += test_a_f16_z_f64.o
+TF_OBJS_TEST += test_a_f16_z_extF80.o
+TF_OBJS_TEST += test_a_f16_z_f128.o
+TF_OBJS_TEST += test_az_f16.o
+TF_OBJS_TEST += test_az_f16_rx.o
+TF_OBJS_TEST += test_abz_f16.o
+TF_OBJS_TEST += test_abcz_f16.o
+TF_OBJS_TEST += test_ab_f16_z_bool.o
+TF_OBJS_TEST += test_a_f32_z_ui32_rx.o
+TF_OBJS_TEST += test_a_f32_z_ui64_rx.o
+TF_OBJS_TEST += test_a_f32_z_i32_rx.o
+TF_OBJS_TEST += test_a_f32_z_i64_rx.o
+TF_OBJS_TEST += test_a_f32_z_ui32_x.o
+TF_OBJS_TEST += test_a_f32_z_ui64_x.o
+TF_OBJS_TEST += test_a_f32_z_i32_x.o
+TF_OBJS_TEST += test_a_f32_z_i64_x.o
+TF_OBJS_TEST += test_a_f32_z_f16.o
+TF_OBJS_TEST += test_a_f32_z_f64.o
+TF_OBJS_TEST += test_a_f32_z_extF80.o
+TF_OBJS_TEST += test_a_f32_z_f128.o
+TF_OBJS_TEST += test_az_f32.o
+TF_OBJS_TEST += test_az_f32_rx.o
+TF_OBJS_TEST += test_abz_f32.o
+TF_OBJS_TEST += test_abcz_f32.o
+TF_OBJS_TEST += test_ab_f32_z_bool.o
+TF_OBJS_TEST += test_a_f64_z_ui32_rx.o
+TF_OBJS_TEST += test_a_f64_z_ui64_rx.o
+TF_OBJS_TEST += test_a_f64_z_i32_rx.o
+TF_OBJS_TEST += test_a_f64_z_i64_rx.o
+TF_OBJS_TEST += test_a_f64_z_ui32_x.o
+TF_OBJS_TEST += test_a_f64_z_ui64_x.o
+TF_OBJS_TEST += test_a_f64_z_i32_x.o
+TF_OBJS_TEST += test_a_f64_z_i64_x.o
+TF_OBJS_TEST += test_a_f64_z_f16.o
+TF_OBJS_TEST += test_a_f64_z_f32.o
+TF_OBJS_TEST += test_a_f64_z_extF80.o
+TF_OBJS_TEST += test_a_f64_z_f128.o
+TF_OBJS_TEST += test_az_f64.o
+TF_OBJS_TEST += test_az_f64_rx.o
+TF_OBJS_TEST += test_abz_f64.o
+TF_OBJS_TEST += test_abcz_f64.o
+TF_OBJS_TEST += test_ab_f64_z_bool.o
+TF_OBJS_TEST += test_a_extF80_z_ui32_rx.o
+TF_OBJS_TEST += test_a_extF80_z_ui64_rx.o
+TF_OBJS_TEST += test_a_extF80_z_i32_rx.o
+TF_OBJS_TEST += test_a_extF80_z_i64_rx.o
+TF_OBJS_TEST += test_a_extF80_z_ui32_x.o
+TF_OBJS_TEST += test_a_extF80_z_ui64_x.o
+TF_OBJS_TEST += test_a_extF80_z_i32_x.o
+TF_OBJS_TEST += test_a_extF80_z_i64_x.o
+TF_OBJS_TEST += test_a_extF80_z_f16.o
+TF_OBJS_TEST += test_a_extF80_z_f32.o
+TF_OBJS_TEST += test_a_extF80_z_f64.o
+TF_OBJS_TEST += test_a_extF80_z_f128.o
+TF_OBJS_TEST += test_az_extF80.o
+TF_OBJS_TEST += test_az_extF80_rx.o
+TF_OBJS_TEST += test_abz_extF80.o
+TF_OBJS_TEST += test_ab_extF80_z_bool.o
+TF_OBJS_TEST += test_a_f128_z_ui32_rx.o
+TF_OBJS_TEST += test_a_f128_z_ui64_rx.o
+TF_OBJS_TEST += test_a_f128_z_i32_rx.o
+TF_OBJS_TEST += test_a_f128_z_i64_rx.o
+TF_OBJS_TEST += test_a_f128_z_ui32_x.o
+TF_OBJS_TEST += test_a_f128_z_ui64_x.o
+TF_OBJS_TEST += test_a_f128_z_i32_x.o
+TF_OBJS_TEST += test_a_f128_z_i64_x.o
+TF_OBJS_TEST += test_a_f128_z_f16.o
+TF_OBJS_TEST += test_a_f128_z_f32.o
+TF_OBJS_TEST += test_a_f128_z_f64.o
+TF_OBJS_TEST += test_a_f128_z_extF80.o
+TF_OBJS_TEST += test_az_f128.o
+TF_OBJS_TEST += test_az_f128_rx.o
+TF_OBJS_TEST += test_abz_f128.o
+TF_OBJS_TEST += test_abcz_f128.o
+TF_OBJS_TEST += test_ab_f128_z_bool.o
+
+TF_OBJS_LIB :=
+TF_OBJS_LIB += uint128_inline.o
+TF_OBJS_LIB += uint128.o
+TF_OBJS_LIB += fail.o
+TF_OBJS_LIB += functions_common.o
+TF_OBJS_LIB += functionInfos.o
+TF_OBJS_LIB += standardFunctionInfos.o
+TF_OBJS_LIB += random.o
+TF_OBJS_LIB += genCases_common.o
+TF_OBJS_LIB += $(TF_OBJS_GENCASES)
+TF_OBJS_LIB += genCases_writeTestsTotal.o
+TF_OBJS_LIB += verCases_inline.o
+TF_OBJS_LIB += verCases_common.o
+TF_OBJS_LIB += verCases_writeFunctionName.o
+TF_OBJS_LIB += readHex.o
+TF_OBJS_LIB += writeHex.o
+TF_OBJS_LIB += $(TF_OBJS_WRITECASE)
+TF_OBJS_LIB += testLoops_common.o
+TF_OBJS_LIB += $(TF_OBJS_TEST)
+
+BINARIES := fp-test$(EXESUF)
+
+# everything depends on config-host.h because platform.h includes it
+all: $(BUILD_DIR)/config-host.h
+	$(MAKE) $(BINARIES)
+
+$(LIBQEMUUTIL):
+	$(MAKE) -C $(BUILD_DIR) libqemuutil.a
+
+$(BUILD_DIR)/config-host.h:
+	$(MAKE) -C $(BUILD_DIR) config-host.h
+
+# libtestfloat.a depends on libsoftfloat.a, so specify it first
+FP_TEST_LIBS := libtestfloat.a libsoftfloat.a $(LIBQEMUUTIL)
+
+fp-test$(EXESUF): fp-test.o slowfloat.o $(QEMU_SOFTFLOAT_OBJ) $(FP_TEST_LIBS)
+
+# Custom rule to build with SF_CFLAGS
+SF_BUILD = $(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
+		$(QEMU_CFLAGS) $(SF_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
+		$($@-cflags) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+$(SF_OBJS_ALL_NOSPEC): %.o: $(SF_SOURCE_DIR)/%.c
+	$(SF_BUILD)
+$(SF_OBJS_SPECIALIZE): %.o: $(SF_SPECIALIZE_DIR)/%.c
+	$(SF_BUILD)
+
+libsoftfloat.a: $(SF_OBJS_ALL)
+
+# Custom rule to build with TF_CFLAGS
+$(TF_OBJS_LIB) slowfloat.o: %.o: $(TF_SOURCE_DIR)/%.c
+	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
+		$(QEMU_CFLAGS) $(TF_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
+		$($@-cflags) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+libtestfloat.a: $(TF_OBJS_LIB)
+
+clean:
+	rm -f *.o *.d $(BINARIES)
+	rm -f *.gcno *.gcda *.gcov
+	rm -f fp-test$(EXESUF)
+	rm -f libsoftfloat.a
+	rm -f libtestfloat.a
+
+-include $(wildcard *.d)
-- 
2.17.1
