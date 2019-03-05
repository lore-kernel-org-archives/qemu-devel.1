Received: from eggs.gnu.org ([209.51.188.92]:35586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1C6V-0002oe-0N
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1C6J-0005NC-Hy
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:34 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54888 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1C6F-0002qI-Dj
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:23 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue,  5 Mar 2019 16:34:34 +0100
Message-Id: <1551800076-8104-13-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551800076-8104-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551800076-8104-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 12/14] tests/tcg: target/mips: Add tests for
 MIPS64R6 shift instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add tests for MIPS64R6 shift instructions: SLLV, SRLV, SRAV, DSLLV,
DSRLV, and DSRAV.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 .../user/isa/mips64r6/shift/test_mips64r6_dsllv.c  | 151 +++++++++++++++++++++
 .../user/isa/mips64r6/shift/test_mips64r6_dsrav.c  | 151 +++++++++++++++++++++
 .../user/isa/mips64r6/shift/test_mips64r6_dsrlv.c  | 151 +++++++++++++++++++++
 .../user/isa/mips64r6/shift/test_mips64r6_sllv.c   | 151 +++++++++++++++++++++
 .../user/isa/mips64r6/shift/test_mips64r6_srav.c   | 151 +++++++++++++++++++++
 .../user/isa/mips64r6/shift/test_mips64r6_srlv.c   | 151 +++++++++++++++++++++
 6 files changed, 906 insertions(+)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c

diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
new file mode 100644
index 0000000..b3eb86e
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction DSLLV
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "DSLLV";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x8000000000000000ULL,                    /*   0  */
+        0xffffffffffffffffULL,
+        0xfffffc0000000000ULL,
+        0xffffffffffe00000ULL,
+        0xfffffffffffff000ULL,
+        0xfff8000000000000ULL,
+        0xffffffffffffc000ULL,
+        0xfffe000000000000ULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,                    /*  16  */
+        0xaaaaaaaaaaaaaaaaULL,
+        0xaaaaa80000000000ULL,
+        0x5555555555400000ULL,
+        0xaaaaaaaaaaaaa000ULL,
+        0x5550000000000000ULL,
+        0xaaaaaaaaaaaa8000ULL,
+        0x5554000000000000ULL,
+        0x8000000000000000ULL,                    /*  24  */
+        0x5555555555555555ULL,
+        0x5555540000000000ULL,
+        0xaaaaaaaaaaa00000ULL,
+        0x5555555555555000ULL,
+        0xaaa8000000000000ULL,
+        0x5555555555554000ULL,
+        0xaaaa000000000000ULL,
+        0x0000000000000000ULL,                    /*  32  */
+        0xccccccccccccccccULL,
+        0x3333300000000000ULL,
+        0x9999999999800000ULL,
+        0xccccccccccccc000ULL,
+        0x6660000000000000ULL,
+        0x3333333333330000ULL,
+        0x9998000000000000ULL,
+        0x8000000000000000ULL,                    /*  40  */
+        0x3333333333333333ULL,
+        0xcccccc0000000000ULL,
+        0x6666666666600000ULL,
+        0x3333333333333000ULL,
+        0x9998000000000000ULL,
+        0xccccccccccccc000ULL,
+        0x6666000000000000ULL,
+        0x0000000000000000ULL,                    /*  48  */
+        0xe38e38e38e38e38eULL,
+        0xe38e380000000000ULL,
+        0x1c71c71c71c00000ULL,
+        0xe38e38e38e38e000ULL,
+        0x1c70000000000000ULL,
+        0x8e38e38e38e38000ULL,
+        0xc71c000000000000ULL,
+        0x8000000000000000ULL,                    /*  56  */
+        0x1c71c71c71c71c71ULL,
+        0x1c71c40000000000ULL,
+        0xe38e38e38e200000ULL,
+        0x1c71c71c71c71000ULL,
+        0xe388000000000000ULL,
+        0x71c71c71c71c4000ULL,
+        0x38e2000000000000ULL,
+        0x886ae6cc28625540ULL,                    /*  64  */
+        0x6ae6cc2862554000ULL,
+        0x886ae6cc28625540ULL,
+        0xb9b30a1895500000ULL,
+        0xfbbe00634d93c708ULL,
+        0xbe00634d93c70800ULL,
+        0xfbbe00634d93c708ULL,
+        0x8018d364f1c20000ULL,
+        0xac5aaeaab9cf8b80ULL,                    /*  72  */
+        0x5aaeaab9cf8b8000ULL,
+        0xac5aaeaab9cf8b80ULL,
+        0xabaaae73e2e00000ULL,
+        0x704f164d5e31e24eULL,
+        0x4f164d5e31e24e00ULL,
+        0x704f164d5e31e24eULL,
+        0xc593578c78938000ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DSLLV(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DSLLV(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
new file mode 100644
index 0000000..025e8f8
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction DSRAV
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "DSRAV";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0xffffffffffffffffULL,                    /*   0  */
+        0xffffffffffffffffULL,
+        0xffffffffffffffffULL,
+        0xffffffffffffffffULL,
+        0xffffffffffffffffULL,
+        0xffffffffffffffffULL,
+        0xffffffffffffffffULL,
+        0xffffffffffffffffULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0xffffffffffffffffULL,                    /*  16  */
+        0xaaaaaaaaaaaaaaaaULL,
+        0xffffffffffeaaaaaULL,
+        0xfffffd5555555555ULL,
+        0xfffaaaaaaaaaaaaaULL,
+        0xfffffffffffff555ULL,
+        0xfffeaaaaaaaaaaaaULL,
+        0xffffffffffffd555ULL,
+        0x0000000000000000ULL,                    /*  24  */
+        0x5555555555555555ULL,
+        0x0000000000155555ULL,
+        0x000002aaaaaaaaaaULL,
+        0x0005555555555555ULL,
+        0x0000000000000aaaULL,
+        0x0001555555555555ULL,
+        0x0000000000002aaaULL,
+        0xffffffffffffffffULL,                    /*  32  */
+        0xccccccccccccccccULL,
+        0xfffffffffff33333ULL,
+        0xfffffe6666666666ULL,
+        0xfffcccccccccccccULL,
+        0xfffffffffffff999ULL,
+        0xffff333333333333ULL,
+        0xffffffffffffe666ULL,
+        0x0000000000000000ULL,                    /*  40  */
+        0x3333333333333333ULL,
+        0x00000000000cccccULL,
+        0x0000019999999999ULL,
+        0x0003333333333333ULL,
+        0x0000000000000666ULL,
+        0x0000ccccccccccccULL,
+        0x0000000000001999ULL,
+        0xffffffffffffffffULL,                    /*  48  */
+        0xe38e38e38e38e38eULL,
+        0xfffffffffff8e38eULL,
+        0xffffff1c71c71c71ULL,
+        0xfffe38e38e38e38eULL,
+        0xfffffffffffffc71ULL,
+        0xffff8e38e38e38e3ULL,
+        0xfffffffffffff1c7ULL,
+        0x0000000000000000ULL,                    /*  56  */
+        0x1c71c71c71c71c71ULL,
+        0x0000000000071c71ULL,
+        0x000000e38e38e38eULL,
+        0x0001c71c71c71c71ULL,
+        0x000000000000038eULL,
+        0x000071c71c71c71cULL,
+        0x0000000000000e38ULL,
+        0x886ae6cc28625540ULL,                    /*  64  */
+        0xff886ae6cc286255ULL,
+        0x886ae6cc28625540ULL,
+        0xfffe21ab9b30a189ULL,
+        0xfbbe00634d93c708ULL,
+        0xfffbbe00634d93c7ULL,
+        0xfbbe00634d93c708ULL,
+        0xffffeef8018d364fULL,
+        0xac5aaeaab9cf8b80ULL,                    /*  72  */
+        0xffac5aaeaab9cf8bULL,
+        0xac5aaeaab9cf8b80ULL,
+        0xfffeb16abaaae73eULL,
+        0x704f164d5e31e24eULL,
+        0x00704f164d5e31e2ULL,
+        0x704f164d5e31e24eULL,
+        0x0001c13c593578c7ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DSRAV(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DSRAV(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
new file mode 100644
index 0000000..680f8a1
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction DSRLV
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "DSRLV";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000001ULL,                    /*   0  */
+        0xffffffffffffffffULL,
+        0x00000000003fffffULL,
+        0x000007ffffffffffULL,
+        0x000fffffffffffffULL,
+        0x0000000000001fffULL,
+        0x0003ffffffffffffULL,
+        0x0000000000007fffULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,                    /*  16  */
+        0xaaaaaaaaaaaaaaaaULL,
+        0x00000000002aaaaaULL,
+        0x0000055555555555ULL,
+        0x000aaaaaaaaaaaaaULL,
+        0x0000000000001555ULL,
+        0x0002aaaaaaaaaaaaULL,
+        0x0000000000005555ULL,
+        0x0000000000000000ULL,                    /*  24  */
+        0x5555555555555555ULL,
+        0x0000000000155555ULL,
+        0x000002aaaaaaaaaaULL,
+        0x0005555555555555ULL,
+        0x0000000000000aaaULL,
+        0x0001555555555555ULL,
+        0x0000000000002aaaULL,
+        0x0000000000000001ULL,                    /*  32  */
+        0xccccccccccccccccULL,
+        0x0000000000333333ULL,
+        0x0000066666666666ULL,
+        0x000cccccccccccccULL,
+        0x0000000000001999ULL,
+        0x0003333333333333ULL,
+        0x0000000000006666ULL,
+        0x0000000000000000ULL,                    /*  40  */
+        0x3333333333333333ULL,
+        0x00000000000cccccULL,
+        0x0000019999999999ULL,
+        0x0003333333333333ULL,
+        0x0000000000000666ULL,
+        0x0000ccccccccccccULL,
+        0x0000000000001999ULL,
+        0x0000000000000001ULL,                    /*  48  */
+        0xe38e38e38e38e38eULL,
+        0x000000000038e38eULL,
+        0x0000071c71c71c71ULL,
+        0x000e38e38e38e38eULL,
+        0x0000000000001c71ULL,
+        0x00038e38e38e38e3ULL,
+        0x00000000000071c7ULL,
+        0x0000000000000000ULL,                    /*  56  */
+        0x1c71c71c71c71c71ULL,
+        0x0000000000071c71ULL,
+        0x000000e38e38e38eULL,
+        0x0001c71c71c71c71ULL,
+        0x000000000000038eULL,
+        0x000071c71c71c71cULL,
+        0x0000000000000e38ULL,
+        0x886ae6cc28625540ULL,                    /*  64  */
+        0x00886ae6cc286255ULL,
+        0x886ae6cc28625540ULL,
+        0x000221ab9b30a189ULL,
+        0xfbbe00634d93c708ULL,
+        0x00fbbe00634d93c7ULL,
+        0xfbbe00634d93c708ULL,
+        0x0003eef8018d364fULL,
+        0xac5aaeaab9cf8b80ULL,                    /*  72  */
+        0x00ac5aaeaab9cf8bULL,
+        0xac5aaeaab9cf8b80ULL,
+        0x0002b16abaaae73eULL,
+        0x704f164d5e31e24eULL,
+        0x00704f164d5e31e2ULL,
+        0x704f164d5e31e24eULL,
+        0x0001c13c593578c7ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DSRLV(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DSRLV(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
new file mode 100644
index 0000000..288d087
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction SLLV
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "SLLV";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0xffffffff80000000ULL,                    /*   0  */
+        0xffffffffffffffffULL,
+        0xfffffffffffffc00ULL,
+        0xffffffffffe00000ULL,
+        0xfffffffffffff000ULL,
+        0xfffffffffff80000ULL,
+        0xffffffffffffc000ULL,
+        0xfffffffffffe0000ULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,                    /*  16  */
+        0xffffffffaaaaaaaaULL,
+        0xffffffffaaaaa800ULL,
+        0x0000000055400000ULL,
+        0xffffffffaaaaa000ULL,
+        0x0000000055500000ULL,
+        0xffffffffaaaa8000ULL,
+        0x0000000055540000ULL,
+        0xffffffff80000000ULL,                    /*  24  */
+        0x0000000055555555ULL,
+        0x0000000055555400ULL,
+        0xffffffffaaa00000ULL,
+        0x0000000055555000ULL,
+        0xffffffffaaa80000ULL,
+        0x0000000055554000ULL,
+        0xffffffffaaaa0000ULL,
+        0x0000000000000000ULL,                    /*  32  */
+        0xffffffffccccccccULL,
+        0x0000000033333000ULL,
+        0xffffffff99800000ULL,
+        0xffffffffccccc000ULL,
+        0x0000000066600000ULL,
+        0x0000000033330000ULL,
+        0xffffffff99980000ULL,
+        0xffffffff80000000ULL,                    /*  40  */
+        0x0000000033333333ULL,
+        0xffffffffcccccc00ULL,
+        0x0000000066600000ULL,
+        0x0000000033333000ULL,
+        0xffffffff99980000ULL,
+        0xffffffffccccc000ULL,
+        0x0000000066660000ULL,
+        0x0000000000000000ULL,                    /*  48  */
+        0xffffffff8e38e38eULL,
+        0xffffffffe38e3800ULL,
+        0x0000000071c00000ULL,
+        0xffffffff8e38e000ULL,
+        0x000000001c700000ULL,
+        0x0000000038e38000ULL,
+        0xffffffffc71c0000ULL,
+        0xffffffff80000000ULL,                    /*  56  */
+        0x0000000071c71c71ULL,
+        0x000000001c71c400ULL,
+        0xffffffff8e200000ULL,
+        0x0000000071c71000ULL,
+        0xffffffffe3880000ULL,
+        0xffffffffc71c4000ULL,
+        0x0000000038e20000ULL,
+        0x0000000028625540ULL,                    /*  64  */
+        0x0000000062554000ULL,
+        0x0000000028625540ULL,
+        0xffffffff95500000ULL,
+        0x000000004d93c708ULL,
+        0xffffffff93c70800ULL,
+        0x000000004d93c708ULL,
+        0xfffffffff1c20000ULL,
+        0xffffffffb9cf8b80ULL,                    /*  72  */
+        0xffffffffcf8b8000ULL,
+        0xffffffffb9cf8b80ULL,
+        0xffffffffe2e00000ULL,
+        0x000000005e31e24eULL,
+        0x0000000031e24e00ULL,
+        0x000000005e31e24eULL,
+        0x0000000078938000ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_SLLV(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_SLLV(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
new file mode 100644
index 0000000..f547d9e
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction SRAV
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "SRAV";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0xffffffffffffffffULL,                    /*   0  */
+        0xffffffffffffffffULL,
+        0xffffffffffffffffULL,
+        0xffffffffffffffffULL,
+        0xffffffffffffffffULL,
+        0xffffffffffffffffULL,
+        0xffffffffffffffffULL,
+        0xffffffffffffffffULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0xffffffffffffffffULL,                    /*  16  */
+        0xffffffffaaaaaaaaULL,
+        0xffffffffffeaaaaaULL,
+        0xfffffffffffffd55ULL,
+        0xfffffffffffaaaaaULL,
+        0xfffffffffffff555ULL,
+        0xfffffffffffeaaaaULL,
+        0xffffffffffffd555ULL,
+        0x0000000000000000ULL,                    /*  24  */
+        0x0000000055555555ULL,
+        0x0000000000155555ULL,
+        0x00000000000002aaULL,
+        0x0000000000055555ULL,
+        0x0000000000000aaaULL,
+        0x0000000000015555ULL,
+        0x0000000000002aaaULL,
+        0xffffffffffffffffULL,                    /*  32  */
+        0xffffffffccccccccULL,
+        0xfffffffffff33333ULL,
+        0xfffffffffffffe66ULL,
+        0xfffffffffffcccccULL,
+        0xfffffffffffff999ULL,
+        0xffffffffffff3333ULL,
+        0xffffffffffffe666ULL,
+        0x0000000000000000ULL,                    /*  40  */
+        0x0000000033333333ULL,
+        0x00000000000cccccULL,
+        0x0000000000000199ULL,
+        0x0000000000033333ULL,
+        0x0000000000000666ULL,
+        0x000000000000ccccULL,
+        0x0000000000001999ULL,
+        0xffffffffffffffffULL,                    /*  48  */
+        0xffffffff8e38e38eULL,
+        0xffffffffffe38e38ULL,
+        0xfffffffffffffc71ULL,
+        0xfffffffffff8e38eULL,
+        0xfffffffffffff1c7ULL,
+        0xfffffffffffe38e3ULL,
+        0xffffffffffffc71cULL,
+        0x0000000000000000ULL,                    /*  56  */
+        0x0000000071c71c71ULL,
+        0x00000000001c71c7ULL,
+        0x000000000000038eULL,
+        0x0000000000071c71ULL,
+        0x0000000000000e38ULL,
+        0x000000000001c71cULL,
+        0x00000000000038e3ULL,
+        0x0000000028625540ULL,                    /*  64  */
+        0x0000000000286255ULL,
+        0x0000000028625540ULL,
+        0x000000000000a189ULL,
+        0x000000004d93c708ULL,
+        0x00000000004d93c7ULL,
+        0x000000004d93c708ULL,
+        0x000000000001364fULL,
+        0xffffffffb9cf8b80ULL,                    /*  72  */
+        0xffffffffffb9cf8bULL,
+        0xffffffffb9cf8b80ULL,
+        0xfffffffffffee73eULL,
+        0x000000005e31e24eULL,
+        0x00000000005e31e2ULL,
+        0x000000005e31e24eULL,
+        0x00000000000178c7ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_SRAV(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_SRAV(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
new file mode 100644
index 0000000..8b8075c
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction SRLV
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "SRLV";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000001ULL,                    /*   0  */
+        0xffffffffffffffffULL,
+        0x00000000003fffffULL,
+        0x00000000000007ffULL,
+        0x00000000000fffffULL,
+        0x0000000000001fffULL,
+        0x000000000003ffffULL,
+        0x0000000000007fffULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,                    /*  16  */
+        0xffffffffaaaaaaaaULL,
+        0x00000000002aaaaaULL,
+        0x0000000000000555ULL,
+        0x00000000000aaaaaULL,
+        0x0000000000001555ULL,
+        0x000000000002aaaaULL,
+        0x0000000000005555ULL,
+        0x0000000000000000ULL,                    /*  24  */
+        0x0000000055555555ULL,
+        0x0000000000155555ULL,
+        0x00000000000002aaULL,
+        0x0000000000055555ULL,
+        0x0000000000000aaaULL,
+        0x0000000000015555ULL,
+        0x0000000000002aaaULL,
+        0x0000000000000001ULL,                    /*  32  */
+        0xffffffffccccccccULL,
+        0x0000000000333333ULL,
+        0x0000000000000666ULL,
+        0x00000000000cccccULL,
+        0x0000000000001999ULL,
+        0x0000000000033333ULL,
+        0x0000000000006666ULL,
+        0x0000000000000000ULL,                    /*  40  */
+        0x0000000033333333ULL,
+        0x00000000000cccccULL,
+        0x0000000000000199ULL,
+        0x0000000000033333ULL,
+        0x0000000000000666ULL,
+        0x000000000000ccccULL,
+        0x0000000000001999ULL,
+        0x0000000000000001ULL,                    /*  48  */
+        0xffffffff8e38e38eULL,
+        0x0000000000238e38ULL,
+        0x0000000000000471ULL,
+        0x000000000008e38eULL,
+        0x00000000000011c7ULL,
+        0x00000000000238e3ULL,
+        0x000000000000471cULL,
+        0x0000000000000000ULL,                    /*  56  */
+        0x0000000071c71c71ULL,
+        0x00000000001c71c7ULL,
+        0x000000000000038eULL,
+        0x0000000000071c71ULL,
+        0x0000000000000e38ULL,
+        0x000000000001c71cULL,
+        0x00000000000038e3ULL,
+        0x0000000028625540ULL,                    /*  64  */
+        0x0000000000286255ULL,
+        0x0000000028625540ULL,
+        0x000000000000a189ULL,
+        0x000000004d93c708ULL,
+        0x00000000004d93c7ULL,
+        0x000000004d93c708ULL,
+        0x000000000001364fULL,
+        0xffffffffb9cf8b80ULL,                    /*  72  */
+        0x0000000000b9cf8bULL,
+        0xffffffffb9cf8b80ULL,
+        0x000000000002e73eULL,
+        0x000000005e31e24eULL,
+        0x00000000005e31e2ULL,
+        0x000000005e31e24eULL,
+        0x00000000000178c7ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_SRLV(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_SRLV(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                           b64_result, b64_expect);
+
+    return ret;
+}
-- 
2.7.4
