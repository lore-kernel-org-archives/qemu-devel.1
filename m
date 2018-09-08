Received: from eggs.gnu.org ([208.118.235.92]:55130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fyinB-0005xB-3Q
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 15:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fyijo-0008Tf-Ao
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 15:17:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39599)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fyijo-0008Og-2c
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 15:17:44 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  8 Sep 2018 15:17:35 -0400
Message-Id: <20180908191735.22861-3-cota@braap.org>
In-Reply-To: <20180908191735.22861-1-cota@braap.org>
References: <20180908191735.22861-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 2/2] tests: add floating point tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>

By leveraging berkeley's softfloat and testfloat.

fp-test.c is derived from testfloat's testsoftfloat.c. To ease
the tracking of upstream changes to the latter file, fp-test.c
keeps the original camel-case variable naming, and includes
most new code via wrap.inc.c.

Most changes to the original code are simple style changes,
although a couple of not-so-subtle modifications have been
made (noted with XXX in the code), namely:

- We do not test ROUND_ODD, since not all of our primitives
  support it (e.g. fp16)

- Do not test !exact in round-to-integer, since it is not
  implemented in QEMU (this flag was added to softfloat v3).

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 configure              |    2 +
 tests/fp/platform.h    |   41 ++
 tests/fp/fp-test.c     | 1052 ++++++++++++++++++++++++++++++++++++++++
 tests/fp/wrap.inc.c    |  600 +++++++++++++++++++++++
 tests/Makefile.include |    3 +
 tests/fp/.gitignore    |    1 +
 tests/fp/Makefile      |  591 ++++++++++++++++++++++
 7 files changed, 2290 insertions(+)
 create mode 100644 tests/fp/platform.h
 create mode 100644 tests/fp/fp-test.c
 create mode 100644 tests/fp/wrap.inc.c
 create mode 100644 tests/fp/.gitignore
 create mode 100644 tests/fp/Makefile

diff --git a/configure b/configure
index 58862d2ae8..b02da8c0b4 100755
--- a/configure
+++ b/configure
@@ -7451,12 +7451,14 @@ fi
 
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
diff --git a/tests/fp/platform.h b/tests/fp/platform.h
new file mode 100644
index 0000000000..80af8a94b6
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
+ *     this list of conditions, and the following disclaimer in the documentation
+ *     and/or other materials provided with the distribution.
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
index 0000000000..43da4e43c5
--- /dev/null
+++ b/tests/fp/fp-test.c
@@ -0,0 +1,1052 @@
+/*
+ * fp-test.c - test QEMU's softfloat implementation using Berkeley's Testfloat
+ *
+ * Derived from testfloat/source/testsoftfloat.c.
+ *
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
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
+/* keep most code separate to make tracking upstream changes more easily */
+#include "wrap.inc.c"
+
+enum {
+    EXACT_FALSE = 1,
+    EXACT_TRUE
+};
+
+static void catchSIGINT(int signalCode)
+{
+    if (verCases_stop) {
+        exit(EXIT_FAILURE);
+    }
+    verCases_stop = true;
+}
+
+static void
+testFunctionInstance(int functionCode, uint_fast8_t roundingMode, bool exact)
+{
+    float16_t (*trueFunction_abz_f16)(float16_t, float16_t);
+    float16_t (*subjFunction_abz_f16)(float16_t, float16_t);
+    bool (*trueFunction_ab_f16_z_bool)(float16_t, float16_t);
+    bool (*subjFunction_ab_f16_z_bool)(float16_t, float16_t);
+    float32_t (*trueFunction_abz_f32)(float32_t, float32_t);
+    float32_t (*subjFunction_abz_f32)(float32_t, float32_t);
+    bool (*trueFunction_ab_f32_z_bool)(float32_t, float32_t);
+    bool (*subjFunction_ab_f32_z_bool)(float32_t, float32_t);
+    float64_t (*trueFunction_abz_f64)(float64_t, float64_t);
+    float64_t (*subjFunction_abz_f64)(float64_t, float64_t);
+    bool (*trueFunction_ab_f64_z_bool)(float64_t, float64_t);
+    bool (*subjFunction_ab_f64_z_bool)(float64_t, float64_t);
+    void (*trueFunction_abz_extF80M)(
+        const extFloat80_t *, const extFloat80_t *, extFloat80_t *);
+    void (*subjFunction_abz_extF80M)(
+        const extFloat80_t *, const extFloat80_t *, extFloat80_t *);
+    bool (*trueFunction_ab_extF80M_z_bool)(
+        const extFloat80_t *, const extFloat80_t *);
+    bool (*subjFunction_ab_extF80M_z_bool)(
+        const extFloat80_t *, const extFloat80_t *);
+    void (*trueFunction_abz_f128M)(
+        const float128_t *, const float128_t *, float128_t *);
+    void (*subjFunction_abz_f128M)(
+        const float128_t *, const float128_t *, float128_t *);
+    bool (*trueFunction_ab_f128M_z_bool)(
+        const float128_t *, const float128_t *);
+    bool (*subjFunction_ab_f128M_z_bool)(
+        const float128_t *, const float128_t *);
+
+    fputs("Testing ", stderr);
+    verCases_writeFunctionName(stderr);
+    fputs(".\n", stderr);
+
+    switch (functionCode) {
+        /*--------------------------------------------------------------------
+         *--------------------------------------------------------------------*/
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
+        /* not implemented */
+        break;
+    case UI32_TO_F128:
+        /* not implemented */
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
+        /* not implemented */
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
+        /*--------------------------------------------------------------------
+         *--------------------------------------------------------------------*/
+    case F16_TO_UI32:
+        test_a_f16_z_ui32_rx(
+        slow_f16_to_ui32, qemu_f16_to_ui32, roundingMode, exact);
+        break;
+    case F16_TO_UI64:
+        test_a_f16_z_ui64_rx(
+        slow_f16_to_ui64, qemu_f16_to_ui64, roundingMode, exact);
+        break;
+    case F16_TO_I32:
+        test_a_f16_z_i32_rx(
+        slow_f16_to_i32, qemu_f16_to_i32, roundingMode, exact);
+        break;
+    case F16_TO_I64:
+        test_a_f16_z_i64_rx(
+        slow_f16_to_i64, qemu_f16_to_i64, roundingMode, exact);
+        break;
+    case F16_TO_UI32_R_MINMAG:
+        /* not implemented */
+        break;
+    case F16_TO_UI64_R_MINMAG:
+        /* not implemented */
+        break;
+    case F16_TO_I32_R_MINMAG:
+        /* not implemented */
+        break;
+    case F16_TO_I64_R_MINMAG:
+        /* not implemented */
+        break;
+    case F16_TO_F32:
+        test_a_f16_z_f32(slow_f16_to_f32, qemu_f16_to_f32);
+        break;
+    case F16_TO_F64:
+        test_a_f16_z_f64(slow_f16_to_f64, qemu_f16_to_f64);
+        break;
+    case F16_TO_EXTF80:
+        /* not implemented */
+        break;
+    case F16_TO_F128:
+        /* not implemented */
+        break;
+    case F16_ROUNDTOINT:
+        test_az_f16_rx(
+        slow_f16_roundToInt, qemu_f16_roundToInt, roundingMode, exact);
+        break;
+    case F16_ADD:
+        trueFunction_abz_f16 = slow_f16_add;
+        subjFunction_abz_f16 = qemu_f16_add;
+        goto test_abz_f16;
+    case F16_SUB:
+        trueFunction_abz_f16 = slow_f16_sub;
+        subjFunction_abz_f16 = qemu_f16_sub;
+        goto test_abz_f16;
+    case F16_MUL:
+        trueFunction_abz_f16 = slow_f16_mul;
+        subjFunction_abz_f16 = qemu_f16_mul;
+        goto test_abz_f16;
+    case F16_DIV:
+        trueFunction_abz_f16 = slow_f16_div;
+        subjFunction_abz_f16 = qemu_f16_div;
+        goto test_abz_f16;
+    case F16_REM:
+        /* not implemented */
+        break;
+    test_abz_f16:
+        test_abz_f16(trueFunction_abz_f16, subjFunction_abz_f16);
+        break;
+    case F16_MULADD:
+        test_abcz_f16(slow_f16_mulAdd, qemu_f16_mulAdd);
+        break;
+    case F16_SQRT:
+        test_az_f16(slow_f16_sqrt, qemu_f16_sqrt);
+        break;
+    case F16_EQ:
+        trueFunction_ab_f16_z_bool = slow_f16_eq;
+        subjFunction_ab_f16_z_bool = qemu_f16_eq;
+        goto test_ab_f16_z_bool;
+    case F16_LE:
+        trueFunction_ab_f16_z_bool = slow_f16_le;
+        subjFunction_ab_f16_z_bool = qemu_f16_le;
+        goto test_ab_f16_z_bool;
+    case F16_LT:
+        trueFunction_ab_f16_z_bool = slow_f16_lt;
+        subjFunction_ab_f16_z_bool = qemu_f16_lt;
+        goto test_ab_f16_z_bool;
+    case F16_EQ_SIGNALING:
+        trueFunction_ab_f16_z_bool = slow_f16_eq_signaling;
+        subjFunction_ab_f16_z_bool = qemu_f16_eq_signaling;
+        goto test_ab_f16_z_bool;
+    case F16_LE_QUIET:
+        trueFunction_ab_f16_z_bool = slow_f16_le_quiet;
+        subjFunction_ab_f16_z_bool = qemu_f16_le_quiet;
+        goto test_ab_f16_z_bool;
+    case F16_LT_QUIET:
+        trueFunction_ab_f16_z_bool = slow_f16_lt_quiet;
+        subjFunction_ab_f16_z_bool = qemu_f16_lt_quiet;
+    test_ab_f16_z_bool:
+        test_ab_f16_z_bool(
+        trueFunction_ab_f16_z_bool, subjFunction_ab_f16_z_bool);
+        break;
+        /*--------------------------------------------------------------------
+         *--------------------------------------------------------------------*/
+    case F32_TO_UI32:
+        test_a_f32_z_ui32_rx(
+        slow_f32_to_ui32, qemu_f32_to_ui32, roundingMode, exact);
+        break;
+    case F32_TO_UI64:
+        test_a_f32_z_ui64_rx(
+        slow_f32_to_ui64, qemu_f32_to_ui64, roundingMode, exact);
+        break;
+    case F32_TO_I32:
+        test_a_f32_z_i32_rx(
+        slow_f32_to_i32, qemu_f32_to_i32, roundingMode, exact);
+        break;
+    case F32_TO_I64:
+        test_a_f32_z_i64_rx(
+        slow_f32_to_i64, qemu_f32_to_i64, roundingMode, exact);
+        break;
+    case F32_TO_UI32_R_MINMAG:
+        /* not implemented */
+        break;
+    case F32_TO_UI64_R_MINMAG:
+        /* not implemented */
+        break;
+    case F32_TO_I32_R_MINMAG:
+        /* not implemented */
+        break;
+    case F32_TO_I64_R_MINMAG:
+        /* not implemented */
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
+        test_az_f32_rx(
+        slow_f32_roundToInt, qemu_f32_roundToInt, roundingMode, exact);
+        break;
+    case F32_ADD:
+        trueFunction_abz_f32 = slow_f32_add;
+        subjFunction_abz_f32 = qemu_f32_add;
+        goto test_abz_f32;
+    case F32_SUB:
+        trueFunction_abz_f32 = slow_f32_sub;
+        subjFunction_abz_f32 = qemu_f32_sub;
+        goto test_abz_f32;
+    case F32_MUL:
+        trueFunction_abz_f32 = slow_f32_mul;
+        subjFunction_abz_f32 = qemu_f32_mul;
+        goto test_abz_f32;
+    case F32_DIV:
+        trueFunction_abz_f32 = slow_f32_div;
+        subjFunction_abz_f32 = qemu_f32_div;
+        goto test_abz_f32;
+    case F32_REM:
+        trueFunction_abz_f32 = slow_f32_rem;
+        subjFunction_abz_f32 = qemu_f32_rem;
+    test_abz_f32:
+        test_abz_f32(trueFunction_abz_f32, subjFunction_abz_f32);
+        break;
+    case F32_MULADD:
+        test_abcz_f32(slow_f32_mulAdd, qemu_f32_mulAdd);
+        break;
+    case F32_SQRT:
+        test_az_f32(slow_f32_sqrt, qemu_f32_sqrt);
+        break;
+    case F32_EQ:
+        trueFunction_ab_f32_z_bool = slow_f32_eq;
+        subjFunction_ab_f32_z_bool = qemu_f32_eq;
+        goto test_ab_f32_z_bool;
+    case F32_LE:
+        trueFunction_ab_f32_z_bool = slow_f32_le;
+        subjFunction_ab_f32_z_bool = qemu_f32_le;
+        goto test_ab_f32_z_bool;
+    case F32_LT:
+        trueFunction_ab_f32_z_bool = slow_f32_lt;
+        subjFunction_ab_f32_z_bool = qemu_f32_lt;
+        goto test_ab_f32_z_bool;
+    case F32_EQ_SIGNALING:
+        trueFunction_ab_f32_z_bool = slow_f32_eq_signaling;
+        subjFunction_ab_f32_z_bool = qemu_f32_eq_signaling;
+        goto test_ab_f32_z_bool;
+    case F32_LE_QUIET:
+        trueFunction_ab_f32_z_bool = slow_f32_le_quiet;
+        subjFunction_ab_f32_z_bool = qemu_f32_le_quiet;
+        goto test_ab_f32_z_bool;
+    case F32_LT_QUIET:
+        trueFunction_ab_f32_z_bool = slow_f32_lt_quiet;
+        subjFunction_ab_f32_z_bool = qemu_f32_lt_quiet;
+    test_ab_f32_z_bool:
+        test_ab_f32_z_bool(
+        trueFunction_ab_f32_z_bool, subjFunction_ab_f32_z_bool);
+        break;
+        /*--------------------------------------------------------------------
+         *--------------------------------------------------------------------*/
+    case F64_TO_UI32:
+        test_a_f64_z_ui32_rx(
+        slow_f64_to_ui32, qemu_f64_to_ui32, roundingMode, exact);
+        break;
+    case F64_TO_UI64:
+        test_a_f64_z_ui64_rx(
+        slow_f64_to_ui64, qemu_f64_to_ui64, roundingMode, exact);
+        break;
+    case F64_TO_I32:
+        test_a_f64_z_i32_rx(
+        slow_f64_to_i32, qemu_f64_to_i32, roundingMode, exact);
+        break;
+    case F64_TO_I64:
+        test_a_f64_z_i64_rx(
+        slow_f64_to_i64, qemu_f64_to_i64, roundingMode, exact);
+        break;
+    case F64_TO_UI32_R_MINMAG:
+        /* not implemented */
+        break;
+    case F64_TO_UI64_R_MINMAG:
+        /* not implemented */
+        break;
+    case F64_TO_I32_R_MINMAG:
+        /* not implemented */
+        break;
+    case F64_TO_I64_R_MINMAG:
+        /* not implemented */
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
+        test_az_f64_rx(
+        slow_f64_roundToInt, qemu_f64_roundToInt, roundingMode, exact);
+        break;
+    case F64_ADD:
+        trueFunction_abz_f64 = slow_f64_add;
+        subjFunction_abz_f64 = qemu_f64_add;
+        goto test_abz_f64;
+    case F64_SUB:
+        trueFunction_abz_f64 = slow_f64_sub;
+        subjFunction_abz_f64 = qemu_f64_sub;
+        goto test_abz_f64;
+    case F64_MUL:
+        trueFunction_abz_f64 = slow_f64_mul;
+        subjFunction_abz_f64 = qemu_f64_mul;
+        goto test_abz_f64;
+    case F64_DIV:
+        trueFunction_abz_f64 = slow_f64_div;
+        subjFunction_abz_f64 = qemu_f64_div;
+        goto test_abz_f64;
+    case F64_REM:
+        trueFunction_abz_f64 = slow_f64_rem;
+        subjFunction_abz_f64 = qemu_f64_rem;
+    test_abz_f64:
+        test_abz_f64(trueFunction_abz_f64, subjFunction_abz_f64);
+        break;
+    case F64_MULADD:
+        test_abcz_f64(slow_f64_mulAdd, qemu_f64_mulAdd);
+        break;
+    case F64_SQRT:
+        test_az_f64(slow_f64_sqrt, qemu_f64_sqrt);
+        break;
+    case F64_EQ:
+        trueFunction_ab_f64_z_bool = slow_f64_eq;
+        subjFunction_ab_f64_z_bool = qemu_f64_eq;
+        goto test_ab_f64_z_bool;
+    case F64_LE:
+        trueFunction_ab_f64_z_bool = slow_f64_le;
+        subjFunction_ab_f64_z_bool = qemu_f64_le;
+        goto test_ab_f64_z_bool;
+    case F64_LT:
+        trueFunction_ab_f64_z_bool = slow_f64_lt;
+        subjFunction_ab_f64_z_bool = qemu_f64_lt;
+        goto test_ab_f64_z_bool;
+    case F64_EQ_SIGNALING:
+        trueFunction_ab_f64_z_bool = slow_f64_eq_signaling;
+        subjFunction_ab_f64_z_bool = qemu_f64_eq_signaling;
+        goto test_ab_f64_z_bool;
+    case F64_LE_QUIET:
+        trueFunction_ab_f64_z_bool = slow_f64_le_quiet;
+        subjFunction_ab_f64_z_bool = qemu_f64_le_quiet;
+        goto test_ab_f64_z_bool;
+    case F64_LT_QUIET:
+        trueFunction_ab_f64_z_bool = slow_f64_lt_quiet;
+        subjFunction_ab_f64_z_bool = qemu_f64_lt_quiet;
+    test_ab_f64_z_bool:
+        test_ab_f64_z_bool(
+        trueFunction_ab_f64_z_bool, subjFunction_ab_f64_z_bool);
+        break;
+        /*--------------------------------------------------------------------
+         *--------------------------------------------------------------------*/
+    case EXTF80_TO_UI32:
+        /* not implemented */
+        break;
+    case EXTF80_TO_UI64:
+        /* not implemented */
+        break;
+    case EXTF80_TO_I32:
+        test_a_extF80_z_i32_rx(
+        slow_extF80M_to_i32, qemu_extF80M_to_i32, roundingMode, exact);
+        break;
+    case EXTF80_TO_I64:
+        test_a_extF80_z_i64_rx(
+        slow_extF80M_to_i64, qemu_extF80M_to_i64, roundingMode, exact);
+        break;
+    case EXTF80_TO_UI32_R_MINMAG:
+        /* not implemented */
+        break;
+    case EXTF80_TO_UI64_R_MINMAG:
+        /* not implemented */
+        break;
+    case EXTF80_TO_I32_R_MINMAG:
+        /* not implemented */
+        break;
+    case EXTF80_TO_I64_R_MINMAG:
+        /* not implemented */
+        break;
+    case EXTF80_TO_F16:
+        /* not implemented */
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
+        test_az_extF80_rx(
+        slow_extF80M_roundToInt, qemu_extF80M_roundToInt, roundingMode, exact);
+        break;
+    case EXTF80_ADD:
+        trueFunction_abz_extF80M = slow_extF80M_add;
+        subjFunction_abz_extF80M = qemu_extF80M_add;
+        goto test_abz_extF80;
+    case EXTF80_SUB:
+        trueFunction_abz_extF80M = slow_extF80M_sub;
+        subjFunction_abz_extF80M = qemu_extF80M_sub;
+        goto test_abz_extF80;
+    case EXTF80_MUL:
+        trueFunction_abz_extF80M = slow_extF80M_mul;
+        subjFunction_abz_extF80M = qemu_extF80M_mul;
+        goto test_abz_extF80;
+    case EXTF80_DIV:
+        trueFunction_abz_extF80M = slow_extF80M_div;
+        subjFunction_abz_extF80M = qemu_extF80M_div;
+        goto test_abz_extF80;
+    case EXTF80_REM:
+        trueFunction_abz_extF80M = slow_extF80M_rem;
+        subjFunction_abz_extF80M = qemu_extF80M_rem;
+    test_abz_extF80:
+        test_abz_extF80(trueFunction_abz_extF80M, subjFunction_abz_extF80M);
+        break;
+    case EXTF80_SQRT:
+        test_az_extF80(slow_extF80M_sqrt, qemu_extF80M_sqrt);
+        break;
+    case EXTF80_EQ:
+        trueFunction_ab_extF80M_z_bool = slow_extF80M_eq;
+        subjFunction_ab_extF80M_z_bool = qemu_extF80M_eq;
+        goto test_ab_extF80_z_bool;
+    case EXTF80_LE:
+        trueFunction_ab_extF80M_z_bool = slow_extF80M_le;
+        subjFunction_ab_extF80M_z_bool = qemu_extF80M_le;
+        goto test_ab_extF80_z_bool;
+    case EXTF80_LT:
+        trueFunction_ab_extF80M_z_bool = slow_extF80M_lt;
+        subjFunction_ab_extF80M_z_bool = qemu_extF80M_lt;
+        goto test_ab_extF80_z_bool;
+    case EXTF80_EQ_SIGNALING:
+        trueFunction_ab_extF80M_z_bool = slow_extF80M_eq_signaling;
+        subjFunction_ab_extF80M_z_bool = qemu_extF80M_eq_signaling;
+        goto test_ab_extF80_z_bool;
+    case EXTF80_LE_QUIET:
+        trueFunction_ab_extF80M_z_bool = slow_extF80M_le_quiet;
+        subjFunction_ab_extF80M_z_bool = qemu_extF80M_le_quiet;
+        goto test_ab_extF80_z_bool;
+    case EXTF80_LT_QUIET:
+        trueFunction_ab_extF80M_z_bool = slow_extF80M_lt_quiet;
+        subjFunction_ab_extF80M_z_bool = qemu_extF80M_lt_quiet;
+    test_ab_extF80_z_bool:
+        test_ab_extF80_z_bool(
+        trueFunction_ab_extF80M_z_bool, subjFunction_ab_extF80M_z_bool);
+        break;
+        /*--------------------------------------------------------------------
+         *--------------------------------------------------------------------*/
+    case F128_TO_UI32:
+        /* not implemented */
+        break;
+    case F128_TO_UI64:
+        test_a_f128_z_ui64_rx(
+        slow_f128M_to_ui64, qemu_f128M_to_ui64, roundingMode, exact);
+        break;
+    case F128_TO_I32:
+        test_a_f128_z_i32_rx(
+        slow_f128M_to_i32, qemu_f128M_to_i32, roundingMode, exact);
+        break;
+    case F128_TO_I64:
+        test_a_f128_z_i64_rx(
+        slow_f128M_to_i64, qemu_f128M_to_i64, roundingMode, exact);
+        break;
+    case F128_TO_UI32_R_MINMAG:
+        /* not implemented */
+        break;
+    case F128_TO_UI64_R_MINMAG:
+        /* not implemented */
+        break;
+    case F128_TO_I32_R_MINMAG:
+        /* not implemented */
+        break;
+    case F128_TO_I64_R_MINMAG:
+        /* not implemented */
+        break;
+    case F128_TO_F16:
+        /* not implemented */
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
+        test_az_f128_rx(
+        slow_f128M_roundToInt, qemu_f128M_roundToInt, roundingMode, exact);
+        break;
+    case F128_ADD:
+        trueFunction_abz_f128M = slow_f128M_add;
+        subjFunction_abz_f128M = qemu_f128M_add;
+        goto test_abz_f128;
+    case F128_SUB:
+        trueFunction_abz_f128M = slow_f128M_sub;
+        subjFunction_abz_f128M = qemu_f128M_sub;
+        goto test_abz_f128;
+    case F128_MUL:
+        trueFunction_abz_f128M = slow_f128M_mul;
+        subjFunction_abz_f128M = qemu_f128M_mul;
+        goto test_abz_f128;
+    case F128_DIV:
+        trueFunction_abz_f128M = slow_f128M_div;
+        subjFunction_abz_f128M = qemu_f128M_div;
+        goto test_abz_f128;
+    case F128_REM:
+        trueFunction_abz_f128M = slow_f128M_rem;
+        subjFunction_abz_f128M = qemu_f128M_rem;
+    test_abz_f128:
+        test_abz_f128(trueFunction_abz_f128M, subjFunction_abz_f128M);
+        break;
+    case F128_MULADD:
+        /* not implemented */
+        break;
+    case F128_SQRT:
+        test_az_f128(slow_f128M_sqrt, qemu_f128M_sqrt);
+        break;
+    case F128_EQ:
+        trueFunction_ab_f128M_z_bool = slow_f128M_eq;
+        subjFunction_ab_f128M_z_bool = qemu_f128M_eq;
+        goto test_ab_f128_z_bool;
+    case F128_LE:
+        trueFunction_ab_f128M_z_bool = slow_f128M_le;
+        subjFunction_ab_f128M_z_bool = qemu_f128M_le;
+        goto test_ab_f128_z_bool;
+    case F128_LT:
+        trueFunction_ab_f128M_z_bool = slow_f128M_lt;
+        subjFunction_ab_f128M_z_bool = qemu_f128M_lt;
+        goto test_ab_f128_z_bool;
+    case F128_EQ_SIGNALING:
+        trueFunction_ab_f128M_z_bool = slow_f128M_eq_signaling;
+        subjFunction_ab_f128M_z_bool = qemu_f128M_eq_signaling;
+        goto test_ab_f128_z_bool;
+    case F128_LE_QUIET:
+        trueFunction_ab_f128M_z_bool = slow_f128M_le_quiet;
+        subjFunction_ab_f128M_z_bool = qemu_f128M_le_quiet;
+        goto test_ab_f128_z_bool;
+    case F128_LT_QUIET:
+        trueFunction_ab_f128M_z_bool = slow_f128M_lt_quiet;
+        subjFunction_ab_f128M_z_bool = qemu_f128M_lt_quiet;
+    test_ab_f128_z_bool:
+        test_ab_f128_z_bool(
+        trueFunction_ab_f128M_z_bool, subjFunction_ab_f128M_z_bool);
+        break;
+    }
+    if ((verCases_errorStop && verCases_anyErrors) || verCases_stop) {
+        verCases_exitWithStatus();
+    }
+}
+
+static void
+testFunction(int functionCode, uint_fast8_t roundingPrecisionIn,
+             int roundingCodeIn, int tininessCodeIn, int exactCodeIn)
+{
+    int functionAttribs;
+    uint_fast8_t roundingPrecision;
+    int roundingCode;
+    uint_fast8_t roundingMode = { 0 };
+    int exactCode;
+    bool exact;
+    int tininessCode;
+    uint_fast8_t tininessMode;
+
+    functionAttribs = functionInfos[functionCode].attribs;
+    verCases_functionNamePtr = functionInfos[functionCode].namePtr;
+    roundingPrecision = 32;
+    for (;;) {
+        if (functionAttribs & FUNC_EFF_ROUNDINGPRECISION) {
+            if (roundingPrecisionIn) {
+                roundingPrecision = roundingPrecisionIn;
+            }
+        } else {
+            roundingPrecision = 0;
+        }
+        verCases_roundingPrecision = roundingPrecision;
+        if (roundingPrecision) {
+            slow_extF80_roundingPrecision = roundingPrecision;
+            qsf.floatx80_rounding_precision = roundingPrecision;
+        }
+        /* XXX: not testing ROUND_ODD */
+        for (roundingCode = 1; roundingCode < NUM_ROUNDINGMODES - 1;
+             ++roundingCode) {
+            if (
+                functionAttribs
+                & (FUNC_ARG_ROUNDINGMODE | FUNC_EFF_ROUNDINGMODE)
+                ) {
+                if (roundingCodeIn) {
+                    roundingCode = roundingCodeIn;
+                }
+            } else {
+                roundingCode = 0;
+            }
+            verCases_roundingCode = roundingCode;
+            if (roundingCode) {
+                roundingMode = roundingModes[roundingCode];
+                if (functionAttribs & FUNC_EFF_ROUNDINGMODE) {
+                    slowfloat_roundingMode = roundingMode;
+                    qsf.float_rounding_mode =
+                        softfloat_rounding_to_qemu(roundingMode);
+                }
+            }
+            /*
+             * XXX not testing EXACT_FALSE
+             *   for (exactCode = EXACT_FALSE; exactCode <= EXACT_TRUE;
+             *   ++exactCode)
+             */
+            exactCode = EXACT_TRUE;
+            {
+                if (functionAttribs & FUNC_ARG_EXACT) {
+                    if (exactCodeIn) {
+                        exactCode = exactCodeIn;
+                    }
+                } else {
+                    exactCode = 0;
+                }
+                exact = (exactCode == EXACT_TRUE);
+                verCases_usesExact = (exactCode != 0);
+                verCases_exact = exact;
+                for (
+                    tininessCode = 1;
+                    tininessCode < NUM_TININESSMODES;
+                    ++tininessCode
+                    ) {
+                    if (
+                        (functionAttribs & FUNC_EFF_TININESSMODE)
+                        || ((functionAttribs
+                             & FUNC_EFF_TININESSMODE_REDUCEDPREC)
+                            && roundingPrecision
+                            && (roundingPrecision < 80))
+                        ) {
+                        if (tininessCodeIn) {
+                            tininessCode = tininessCodeIn;
+                        }
+                    } else {
+                        tininessCode = 0;
+                    }
+                    verCases_tininessCode = tininessCode;
+                    if (tininessCode) {
+                        tininessMode = tininessModes[tininessCode];
+                        slowfloat_detectTininess = tininessMode;
+                        qsf.float_detect_tininess =
+                            softfloat_tininess_to_qemu(tininessMode);
+                    }
+                    testFunctionInstance(functionCode, roundingMode, exact);
+                    if (tininessCodeIn || !tininessCode) {
+                        break;
+                    }
+                }
+                if (exactCodeIn || !exactCode) {
+                    break;
+                }
+            }
+            if (roundingCodeIn || !roundingCode) {
+                break;
+            }
+        }
+        if (roundingPrecisionIn || !roundingPrecision) {
+            break;
+        }
+        if (roundingPrecision == 80) {
+            break;
+        } else if (roundingPrecision == 64) {
+            roundingPrecision = 80;
+        } else if (roundingPrecision == 32) {
+            roundingPrecision = 64;
+        }
+    }
+
+}
+
+int main(int argc, char *argv[])
+{
+    bool haveFunctionArg;
+    int functionCode, numOperands;
+    uint_fast8_t roundingPrecision;
+    int roundingCode, tininessCode, exactCode;
+    const char *argPtr;
+    unsigned long ui;
+    long i;
+    int functionMatchAttrib;
+    struct sigaction sigact;
+
+    /*------------------------------------------------------------------------
+     *------------------------------------------------------------------------*/
+    fail_programName = (char *)"fp-test";
+    if (argc <= 1) {
+        goto writeHelpMessage;
+    }
+    genCases_setLevel(1);
+    verCases_maxErrorCount = 20;
+    testLoops_trueFlagsPtr = &slowfloat_exceptionFlags;
+    testLoops_subjFlagsFunction = qemu_softfloat_clearExceptionFlags;
+    haveFunctionArg = false;
+    functionCode = 0;
+    numOperands = 0;
+    roundingPrecision = 0;
+    roundingCode = 0;
+    tininessCode = 0;
+    exactCode = 0;
+    for (;;) {
+        --argc;
+        if (!argc) {
+            break;
+        }
+        argPtr = *++argv;
+        if (!argPtr) {
+            break;
+        }
+        if (argPtr[0] == '-') {
+            ++argPtr;
+        }
+        if (
+            !strcmp(argPtr, "help") || !strcmp(argPtr, "-help")
+            || !strcmp(argPtr, "h")
+            ) {
+        writeHelpMessage:
+            fputs(
+                "fp-test [<option>...] <function>\n"
+                "  <option>:  (* is default)\n"
+                "    -help            --Write this message and exit.\n"
+                "    -seed <num>      --Set pseudo-random number generator seed to <num>.\n"
+                " *  -seed 1\n"
+                "    -level <num>     --Testing level <num> (1 or 2).\n"
+                " *  -level 1\n"
+                "    -errors <num>    --Stop each function test after <num> errors.\n"
+                " *  -errors 20\n"
+                "    -errorstop       --Exit after first function with any error.\n"
+                "    -forever         --Test one function repeatedly (implies '-level 2').\n"
+                "    -precision32     --For extF80, test only 32-bit rounding precision.\n"
+                "    -precision64     --For extF80, test only 64-bit rounding precision.\n"
+                "    -precision80     --For extF80, test only 80-bit rounding precision.\n"
+                "    -rnear_even      --Test only rounding to nearest/even.\n"
+                "    -rminMag         --Test only rounding to minimum magnitude (toward zero).\n"
+                "    -rmin            --Test only rounding to minimum (down).\n"
+                "    -rmax            --Test only rounding to maximum (up).\n"
+                "    -rnear_maxMag    --Test only rounding to nearest/maximum magnitude\n"
+                "                         (nearest/away).\n"
+                "    -rodd            --Test only rounding to odd (jamming).  (For rounding to\n"
+                "                         an integer value, 'minMag' rounding is done instead.)\n"
+                "    -tininessbefore  --Test only underflow tininess detected before rounding.\n"
+                "    -tininessafter   --Test only underflow tininess detected after rounding.\n"
+                "    -notexact        --Test only non-exact rounding to integer (no inexact\n"
+                "                         exceptions).\n"
+                "    -exact           --Test only exact rounding to integer (raising inexact\n"
+                "                         exceptions).\n"
+                "  <function>:\n"
+                "    <int>_to_<float>            <float>_add      <float>_eq\n"
+                "    <float>_to_<int>            <float>_sub      <float>_le\n"
+                "    <float>_to_<int>_r_minMag   <float>_mul      <float>_lt\n"
+                "    <float>_to_<float>          <float>_mulAdd   <float>_eq_signaling\n"
+                "    <float>_roundToInt          <float>_div      <float>_le_quiet\n"
+                "                                <float>_rem      <float>_lt_quiet\n"
+                "                                <float>_sqrt\n"
+                "    -all1            --All unary functions.\n"
+                "    -all2            --All binary functions.\n"
+                "  <int>:\n"
+                "    ui32             --Unsigned 32-bit integer.\n"
+                "    ui64             --Unsigned 64-bit integer.\n"
+                "    i32              --Signed 32-bit integer.\n"
+                "    i64              --Signed 64-bit integer.\n"
+                "  <float>:\n"
+                "    f16              --Binary 16-bit floating-point (half-precision).\n"
+                "    f32              --Binary 32-bit floating-point (single-precision).\n"
+                "    f64              --Binary 64-bit floating-point (double-precision).\n"
+                "    extF80           --Binary 80-bit extended floating-point.\n"
+                "    f128             --Binary 128-bit floating-point (quadruple-precision).\n"
+                ,
+                stdout
+                );
+            return EXIT_SUCCESS;
+        } else if (!strcmp(argPtr, "seed")) {
+            if (argc < 2) {
+                goto optionError;
+            }
+            if (qemu_strtoul(argv[1], &argPtr, 10, &ui)) {
+                goto optionError;
+            }
+            if (*argPtr) {
+                goto optionError;
+            }
+            srand(ui);
+            --argc;
+            ++argv;
+        } else if (!strcmp(argPtr, "level")) {
+            if (argc < 2) {
+                goto optionError;
+            }
+            if (qemu_strtol(argv[1], &argPtr, 10, &i)) {
+                goto optionError;
+            }
+            if (*argPtr) {
+                goto optionError;
+            }
+            genCases_setLevel(i);
+            --argc;
+            ++argv;
+        } else if (!strcmp(argPtr, "level1")) {
+            genCases_setLevel(1);
+        } else if (!strcmp(argPtr, "level2")) {
+            genCases_setLevel(2);
+        } else if (!strcmp(argPtr, "errors")) {
+            if (argc < 2) {
+                goto optionError;
+            }
+            if (qemu_strtol(argv[1], &argPtr, 10, &i)) {
+                goto optionError;
+            }
+            if (*argPtr) {
+                goto optionError;
+            }
+            verCases_maxErrorCount = i;
+            --argc;
+            ++argv;
+        } else if (!strcmp(argPtr, "errorstop")) {
+            verCases_errorStop = true;
+        } else if (!strcmp(argPtr, "forever")) {
+            genCases_setLevel(2);
+            testLoops_forever = true;
+        } else if (!strcmp(argPtr, "precision32")) {
+            roundingPrecision = 32;
+        } else if (!strcmp(argPtr, "precision64")) {
+            roundingPrecision = 64;
+        } else if (!strcmp(argPtr, "precision80")) {
+            roundingPrecision = 80;
+        } else if (
+            !strcmp(argPtr, "rnear_even")
+            || !strcmp(argPtr, "rneareven")
+            || !strcmp(argPtr, "rnearest_even")
+            ) {
+            roundingCode = ROUND_NEAR_EVEN;
+        } else if (
+            !strcmp(argPtr, "rminmag") || !strcmp(argPtr, "rminMag")
+            ) {
+            roundingCode = ROUND_MINMAG;
+        } else if (!strcmp(argPtr, "rmin")) {
+            roundingCode = ROUND_MIN;
+        } else if (!strcmp(argPtr, "rmax")) {
+            roundingCode = ROUND_MAX;
+        } else if (
+            !strcmp(argPtr, "rnear_maxmag")
+            || !strcmp(argPtr, "rnear_maxMag")
+            || !strcmp(argPtr, "rnearmaxmag")
+            || !strcmp(argPtr, "rnearest_maxmag")
+            || !strcmp(argPtr, "rnearest_maxMag")
+            ) {
+            roundingCode = ROUND_NEAR_MAXMAG;
+        } else if (!strcmp(argPtr, "rodd")) {
+            roundingCode = ROUND_ODD;
+        } else if (!strcmp(argPtr, "tininessbefore")) {
+            tininessCode = TININESS_BEFORE_ROUNDING;
+        } else if (!strcmp(argPtr, "tininessafter")) {
+            tininessCode = TININESS_AFTER_ROUNDING;
+        } else if (!strcmp(argPtr, "notexact")) {
+            exactCode = EXACT_FALSE;
+        } else if (!strcmp(argPtr, "exact")) {
+            exactCode = EXACT_TRUE;
+        } else if (!strcmp(argPtr, "all1")) {
+            haveFunctionArg = true;
+            functionCode = 0;
+            numOperands = 1;
+        } else if (!strcmp(argPtr, "all2")) {
+            haveFunctionArg = true;
+            functionCode = 0;
+            numOperands = 2;
+        } else {
+            functionCode = 1;
+            while (strcmp(argPtr, functionInfos[functionCode].namePtr)) {
+                ++functionCode;
+                if (functionCode == NUM_FUNCTIONS) {
+                    fail("Invalid argument '%s'", *argv);
+                }
+            }
+            haveFunctionArg = true;
+        }
+    }
+    if (!haveFunctionArg) {
+        fail("Function argument required");
+    }
+    /*------------------------------------------------------------------------
+     *------------------------------------------------------------------------*/
+    sigact = (struct sigaction) {
+        .sa_handler = catchSIGINT,
+        .sa_flags = SA_RESETHAND | SA_NODEFER,
+    };
+    sigemptyset(&sigact.sa_mask);
+    sigaction(SIGINT, &sigact, NULL);
+    sigaction(SIGTERM, &sigact, NULL);
+    if (functionCode) {
+        if (testLoops_forever) {
+            if (!roundingPrecision) {
+                roundingPrecision = 80;
+            }
+            if (!roundingCode) {
+                roundingCode = ROUND_NEAR_EVEN;
+            }
+        }
+        testFunction(
+            functionCode,
+            roundingPrecision,
+            roundingCode,
+            tininessCode,
+            exactCode
+            );
+    } else {
+        if (testLoops_forever) {
+            fail("Can test only one function with '-forever' option");
+        }
+        functionMatchAttrib =
+            (numOperands == 1) ? FUNC_ARG_UNARY : FUNC_ARG_BINARY;
+        for (
+            functionCode = 1; functionCode < NUM_FUNCTIONS; ++functionCode
+            ) {
+            if (functionInfos[functionCode].attribs & functionMatchAttrib) {
+                testFunction(
+                    functionCode,
+                    roundingPrecision,
+                    roundingCode,
+                    tininessCode,
+                    exactCode
+                    );
+            }
+        }
+    }
+    verCases_exitWithStatus();
+    /*------------------------------------------------------------------------
+     *------------------------------------------------------------------------*/
+ optionError:
+    fail("'%s' option requires numeric argument", *argv);
+    return 1;
+}
diff --git a/tests/fp/wrap.inc.c b/tests/fp/wrap.inc.c
new file mode 100644
index 0000000000..5d1edc96c9
--- /dev/null
+++ b/tests/fp/wrap.inc.c
@@ -0,0 +1,600 @@
+/* wrap QEMU softfloat functions to mimic those in upstream softfloat */
+
+/* qemu softfloat status */
+static float_status qsf;
+
+static signed char softfloat_tininess_to_qemu(uint_fast8_t mode)
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
+static signed char softfloat_rounding_to_qemu(uint_fast8_t mode)
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
+static uint_fast8_t qemu_flags_to_softfloat(uint8_t qflags)
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
+static uint_fast8_t qemu_softfloat_clearExceptionFlags(void)
+{
+    uint_fast8_t prevFlags;
+
+    prevFlags = qemu_flags_to_softfloat(qsf.float_exception_flags);
+    qsf.float_exception_flags = 0;
+    return prevFlags;
+}
+
+/*
+ * softfloat/testfloat calls look very different from QEMU ones.
+ * With these macros we wrap the QEMU calls to look like softfloat/testfloat's,
+ * so that we can use the testfloat infrastructure as-is.
+ */
+
+static extFloat80_t qemu_to_soft80(floatx80 a)
+{
+    extFloat80_t ret;
+    void *p = &ret;
+
+    memcpy(p, &a.high, sizeof(a.high));
+    memcpy(p + 8, &a.low, sizeof(a.low));
+    return ret;
+}
+
+static floatx80 soft_to_qemu80(extFloat80_t a)
+{
+    floatx80 ret;
+    void *p = &a;
+
+    memcpy(&ret.high, p, sizeof(ret.high));
+    memcpy(&ret.low, p + 8, sizeof(ret.low));
+    return ret;
+}
+
+static float128_t qemu_to_soft128(float128 a)
+{
+    float128_t ret;
+    struct uint128 *to = (struct uint128 *)&ret;
+
+#ifdef HOST_WORDS_BIGENDIAN
+    to->v0 = a.low;
+    to->v64 = a.high;
+#else
+    to->v0 = a.high;
+    to->v64 = a.low;
+#endif
+    return ret;
+}
+
+static float128 soft_to_qemu128(float128_t a)
+{
+    struct uint128 *from = (struct uint128 *)&a;
+    float128 ret;
+
+#ifdef HOST_WORDS_BIGENDIAN
+    ret.low = from->v0;
+    ret.high = from->v64;
+#else
+    ret.high = from->v0;
+    ret.low = from->v64;
+#endif
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
+#define WRAP_SF_TO_INT(name, scalfunc, type, int_type, fast_type)       \
+    static fast_type name(type##_t a, uint_fast8_t round, bool exact)   \
+    {                                                                   \
+        type *ap = (type *)&a;                                          \
+        int r = softfloat_rounding_to_qemu(round);                      \
+                                                                        \
+        return scalfunc(*ap, r, 0, &qsf);                               \
+    }
+
+WRAP_SF_TO_INT(qemu_f16_to_ui32, float16_to_uint32_scalbn, float16, uint32_t,
+               uint_fast32_t)
+WRAP_SF_TO_INT(qemu_f16_to_ui64, float16_to_uint64_scalbn, float16, uint64_t,
+               uint_fast64_t)
+
+WRAP_SF_TO_INT(qemu_f32_to_ui32, float32_to_uint32_scalbn, float32, uint32_t,
+               uint_fast32_t)
+WRAP_SF_TO_INT(qemu_f32_to_ui64, float32_to_uint64_scalbn, float32, uint64_t,
+               uint_fast64_t)
+
+WRAP_SF_TO_INT(qemu_f64_to_ui32, float64_to_uint32_scalbn, float64, uint32_t,
+               uint_fast32_t)
+WRAP_SF_TO_INT(qemu_f64_to_ui64, float64_to_uint64_scalbn, float64, uint64_t,
+               uint_fast64_t)
+
+WRAP_SF_TO_INT(qemu_f16_to_i32, float16_to_int32_scalbn, float16, int32_t,
+               int_fast32_t)
+WRAP_SF_TO_INT(qemu_f16_to_i64, float16_to_int64_scalbn, float16, int64_t,
+               int_fast64_t)
+
+WRAP_SF_TO_INT(qemu_f32_to_i32, float32_to_int32_scalbn, float32, int32_t,
+               int_fast32_t)
+WRAP_SF_TO_INT(qemu_f32_to_i64, float32_to_int64_scalbn, float32, int64_t,
+               int_fast64_t)
+
+WRAP_SF_TO_INT(qemu_f64_to_i32, float64_to_int32_scalbn, float64, int32_t,
+               int_fast32_t)
+WRAP_SF_TO_INT(qemu_f64_to_i64, float64_to_int64_scalbn, float64, int64_t,
+               int_fast64_t)
+#undef WRAP_SF_TO_INT
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
+#define WRAP_128_TO_SF(name, func, type)                \
+    static type##_t name(const float128_t *ap)          \
+    {                                                   \
+        float128 a;                                     \
+        type ret;                                       \
+                                                        \
+        a = soft_to_qemu128(*ap);                       \
+        ret = func(a, &qsf);                            \
+        return *(type##_t *)&ret;                       \
+    }
+
+WRAP_128_TO_SF(qemu_f128M_to_f32, float128_to_float32, float32)
+WRAP_128_TO_SF(qemu_f128M_to_f64, float128_to_float64, float64)
+#undef WRAP_80_TO_SF
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
+#define WRAP_80_TO_INT(name, func, int_type, fast_type)                 \
+    static fast_type name(const extFloat80_t *ap, uint_fast8_t round,   \
+                          bool exact)                                   \
+    {                                                                   \
+        floatx80 a;                                                     \
+        int_type ret;                                                   \
+                                                                        \
+        a = soft_to_qemu80(*ap);                                        \
+        qsf.float_rounding_mode = softfloat_rounding_to_qemu(round);    \
+        ret = func(a, &qsf);                                            \
+        return ret;                                                     \
+    }
+
+WRAP_80_TO_INT(qemu_extF80M_to_i32, floatx80_to_int32, int32_t, int_fast32_t)
+WRAP_80_TO_INT(qemu_extF80M_to_i64, floatx80_to_int64, int64_t, int_fast64_t)
+#undef WRAP_80_TO_INT
+
+/* Note: exact is ignored since qemu's softfloat assumes it is set */
+#define WRAP_128_TO_INT(name, func, int_type, fast_type)                \
+    static fast_type name(const float128_t *ap, uint_fast8_t round,     \
+                          bool exact)                                   \
+    {                                                                   \
+        float128 a;                                                     \
+        int_type ret;                                                   \
+                                                                        \
+        a = soft_to_qemu128(*ap);                                       \
+        qsf.float_rounding_mode = softfloat_rounding_to_qemu(round);    \
+        ret = func(a, &qsf);                                            \
+        return ret;                                                     \
+    }
+
+WRAP_128_TO_INT(qemu_f128M_to_i32, float128_to_int32, int32_t, int_fast32_t)
+WRAP_128_TO_INT(qemu_f128M_to_i64, float128_to_int64, int64_t, int_fast64_t)
+
+WRAP_128_TO_INT(qemu_f128M_to_ui64, float128_to_uint64, uint64_t, uint_fast64_t)
+#undef WRAP_80_TO_INT
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
+        qsf.float_rounding_mode = softfloat_rounding_to_qemu(round);    \
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
+    qsf.float_rounding_mode = softfloat_rounding_to_qemu(round);
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
+    qsf.float_rounding_mode = softfloat_rounding_to_qemu(round);
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
+#define WRAP_CMP(name, func, type, retcond)     \
+    static bool name(type##_t a, type##_t b)    \
+    {                                           \
+        type *ap = (type *)&a;                  \
+        type *bp = (type *)&b;                  \
+        int ret;                                \
+                                                \
+        ret = func(*ap, *bp, &qsf);             \
+        return retcond;                         \
+    }
+
+#define GEN_WRAP_CMP(b)                                                      \
+WRAP_CMP(qemu_f##b##_eq_signaling, float##b##_compare, float##b, ret == 0)   \
+WRAP_CMP(qemu_f##b##_eq, float##b##_compare_quiet, float##b, ret == 0)       \
+WRAP_CMP(qemu_f##b##_le, float##b##_compare, float##b, ret <= 0)             \
+WRAP_CMP(qemu_f##b##_lt, float##b##_compare, float##b, ret < 0)              \
+WRAP_CMP(qemu_f##b##_le_quiet, float##b##_compare_quiet, float##b, ret <= 0) \
+WRAP_CMP(qemu_f##b##_lt_quiet, float##b##_compare_quiet, float##b, ret < 0)
+
+GEN_WRAP_CMP(16)
+GEN_WRAP_CMP(32)
+GEN_WRAP_CMP(64)
+#undef GEN_WRAP_CMP
+#undef WRAP_CMP
+
+#define WRAP_CMP80(name, func, retcond)                                 \
+    static bool name(const extFloat80_t *ap, const extFloat80_t *bp)    \
+    {                                                                   \
+        floatx80 a;                                                     \
+        floatx80 b;                                                     \
+        int ret;                                                        \
+                                                                        \
+        a = soft_to_qemu80(*ap);                                        \
+        b = soft_to_qemu80(*bp);                                        \
+        ret = func(a, b, &qsf);                                         \
+        return retcond;                                                 \
+    }
+
+WRAP_CMP80(qemu_extF80M_eq_signaling, floatx80_compare, ret == 0)
+WRAP_CMP80(qemu_extF80M_eq, floatx80_compare_quiet, ret == 0)
+WRAP_CMP80(qemu_extF80M_le, floatx80_compare, ret <= 0)
+WRAP_CMP80(qemu_extF80M_lt, floatx80_compare, ret < 0)
+WRAP_CMP80(qemu_extF80M_le_quiet, floatx80_compare_quiet, ret <= 0)
+WRAP_CMP80(qemu_extF80M_lt_quiet, floatx80_compare_quiet, ret < 0)
+#undef WRAP_CMP80
+
+#define WRAP_CMP80(name, func, retcond)                                 \
+    static bool name(const float128_t *ap, const float128_t *bp)        \
+    {                                                                   \
+        float128 a;                                                     \
+        float128 b;                                                     \
+        int ret;                                                        \
+                                                                        \
+        a = soft_to_qemu128(*ap);                                       \
+        b = soft_to_qemu128(*bp);                                       \
+        ret = func(a, b, &qsf);                                         \
+        return retcond;                                                 \
+    }
+
+WRAP_CMP80(qemu_f128M_eq_signaling, float128_compare, ret == 0)
+WRAP_CMP80(qemu_f128M_eq, float128_compare_quiet, ret == 0)
+WRAP_CMP80(qemu_f128M_le, float128_compare, ret <= 0)
+WRAP_CMP80(qemu_f128M_lt, float128_compare, ret < 0)
+WRAP_CMP80(qemu_f128M_le_quiet, float128_compare_quiet, ret <= 0)
+WRAP_CMP80(qemu_f128M_lt_quiet, float128_compare_quiet, ret < 0)
+#undef WRAP_CMP80
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 87c81d1dcc..363f133101 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -657,6 +657,9 @@ tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)
 tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
 
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
index 0000000000..2f9e58b649
--- /dev/null
+++ b/tests/fp/Makefile
@@ -0,0 +1,591 @@
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
+all: $(BINARIES)
+
+$(LIBQEMUUTIL):
+	$(MAKE) -C $(BUILD_DIR) libqemuutil.a
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
+	rm -f fp-test$(EXESUF)
+	rm -f libsoftfloat.a
+	rm -f libtestfloat.a
+
+-include $(wildcard *.d)
-- 
2.17.1
