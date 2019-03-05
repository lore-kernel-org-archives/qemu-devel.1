Received: from eggs.gnu.org ([209.51.188.92]:47007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1ESk-0001Ak-8b
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1ESi-00029S-43
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:45 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51688 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1ESh-00027P-Ll
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:43 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue,  5 Mar 2019 19:05:17 +0100
Message-Id: <1551809127-3658-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551809127-3658-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551809127-3658-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 05/15] tests/tcg: target/mips: Add test
 utilities for 64-bit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add test utilities for 64-bit tests. Some of MIPS64R6 instructions
require 64-bit inputs to be 32-bit integers sign-extedned to 64 bits,
hence the need for sets of such inputs.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1551800076-8104-6-git-send-email-aleksandar.markovic@rt-rk.com>
---
 tests/tcg/mips/include/test_inputs_64.h | 208 ++++++++++++++++++++++++++++++++
 tests/tcg/mips/include/test_utils_64.h  |  78 ++++++++++++
 2 files changed, 286 insertions(+)
 create mode 100644 tests/tcg/mips/include/test_inputs_64.h
 create mode 100644 tests/tcg/mips/include/test_utils_64.h

diff --git a/tests/tcg/mips/include/test_inputs_64.h b/tests/tcg/mips/include/test_inputs_64.h
new file mode 100644
index 0000000..6891a36
--- /dev/null
+++ b/tests/tcg/mips/include/test_inputs_64.h
@@ -0,0 +1,208 @@
+/*
+ *  Header file for pattern and random test inputs
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
+#ifndef TEST_INPUTS_64_H
+#define TEST_INPUTS_64_H
+
+#include <stdint.h>
+
+
+#define PATTERN_INPUTS_64_COUNT          64
+#define PATTERN_INPUTS_64_SHORT_COUNT     8
+
+static const uint64_t b64_pattern[PATTERN_INPUTS_64_COUNT] = {
+    0xFFFFFFFFFFFFFFFFULL,                               /*   0 */
+    0x0000000000000000ULL,
+    0xAAAAAAAAAAAAAAAAULL,
+    0x5555555555555555ULL,
+    0xCCCCCCCCCCCCCCCCULL,
+    0x3333333333333333ULL,
+    0xE38E38E38E38E38EULL,
+    0x1C71C71C71C71C71ULL,
+    0xF0F0F0F0F0F0F0F0ULL,                               /*   8 */
+    0x0F0F0F0F0F0F0F0FULL,
+    0xF83E0F83E0F83E0FULL,
+    0x07C1F07C1F07C1F0ULL,
+    0xFC0FC0FC0FC0FC0FULL,
+    0x03F03F03F03F03F0ULL,
+    0xFE03F80FE03F80FEULL,
+    0x01FC07F01FC07F01ULL,
+    0xFF00FF00FF00FF00ULL,                               /*  16 */
+    0x00FF00FF00FF00FFULL,
+    0xFF803FE00FF803FEULL,
+    0x007FC01FF007FC01ULL,
+    0xFFC00FFC00FFC00FULL,
+    0x003FF003FF003FF0ULL,
+    0xFFE003FF800FFE00ULL,
+    0x001FFC007FF001FFULL,
+    0xFFF000FFF000FFF0ULL,                               /*  24 */
+    0x000FFF000FFF000FULL,
+    0xFFF8003FFE000FFFULL,
+    0x0007FFC001FFF000ULL,
+    0xFFFC000FFFC000FFULL,
+    0x0003FFF0003FFF00ULL,
+    0xFFFE0003FFF8000FULL,
+    0x0001FFFC0007FFF0ULL,
+    0xFFFF0000FFFF0000ULL,                               /*  32 */
+    0x0000FFFF0000FFFFULL,
+    0xFFFF80003FFFE000ULL,
+    0x00007FFFC0001FFFULL,
+    0xFFFFC0000FFFFC00ULL,
+    0x00003FFFF00003FFULL,
+    0xFFFFE00003FFFF80ULL,
+    0x00001FFFFC00007FULL,
+    0xFFFFF00000FFFFF0ULL,                               /*  40 */
+    0x00000FFFFF00000FULL,
+    0xFFFFF800003FFFFEULL,
+    0x000007FFFFC00001ULL,
+    0xFFFFFC00000FFFFFULL,
+    0x000003FFFFF00000ULL,
+    0xFFFFFE000003FFFFULL,
+    0x000001FFFFFC0000ULL,
+    0xFFFFFF000000FFFFULL,                               /*  48 */
+    0x000000FFFFFF0000ULL,
+    0xFFFFFF8000003FFFULL,
+    0x0000007FFFFFC000ULL,
+    0xFFFFFFC000000FFFULL,
+    0x0000003FFFFFF000ULL,
+    0xFFFFFFE0000003FFULL,
+    0x0000001FFFFFFC00ULL,
+    0xFFFFFFF0000000FFULL,                               /*  56 */
+    0x0000000FFFFFFF00ULL,
+    0xFFFFFFF80000003FULL,
+    0x00000007FFFFFFC0ULL,
+    0xFFFFFFFC0000000FULL,
+    0x00000003FFFFFFF0ULL,
+    0xFFFFFFFE00000003ULL,
+    0x00000001FFFFFFFCULL,
+};
+
+static const uint64_t b64_pattern_se[PATTERN_INPUTS_64_COUNT] = {
+    0xFFFFFFFFFFFFFFFFULL,                               /*   0 */
+    0x0000000000000000ULL,
+    0xFFFFFFFFAAAAAAAAULL,
+    0x0000000055555555ULL,
+    0xFFFFFFFFCCCCCCCCULL,
+    0x0000000033333333ULL,
+    0xFFFFFFFFE38E38E3ULL,
+    0x000000001C71C71CULL,
+    0xFFFFFFFFF0F0F0F0ULL,                               /*   8 */
+    0x000000000F0F0F0FULL,
+    0xFFFFFFFFF83E0F83ULL,
+    0x0000000007C1F07CULL,
+    0xFFFFFFFFFC0FC0FCULL,
+    0x0000000003F03F03ULL,
+    0xFFFFFFFFFE03F80FULL,
+    0x0000000001FC07F0ULL,
+    0xFFFFFFFFFF00FF00ULL,                               /*  16 */
+    0x0000000000FF00FFULL,
+    0xFFFFFFFFFF803FE0ULL,
+    0x00000000007FC01FULL,
+    0xFFFFFFFFFFC00FFCULL,
+    0x00000000003FF003ULL,
+    0xFFFFFFFFFFE003FFULL,
+    0x00000000001FFC00ULL,
+    0xFFFFFFFFFFF000FFULL,                               /*  24 */
+    0x00000000000FFF00ULL,
+    0xFFFFFFFFFFF8003FULL,
+    0x000000000007FFC0ULL,
+    0xFFFFFFFFFFFC000FULL,
+    0x000000000003FFF0ULL,
+    0xFFFFFFFFFFFE0003ULL,
+    0x000000000001FFFCULL,
+    0xFFFFFFFFFFFF0000ULL,                               /*  32 */
+    0x000000000000FFFFULL,
+    0xFFFFFFFFFFFF8000ULL,
+    0x0000000000007FFFULL,
+    0xFFFFFFFFFFFFC000ULL,
+    0x0000000000003FFFULL,
+    0xFFFFFFFFFFFFE000ULL,
+    0x0000000000001FFFULL,
+    0xFFFFFFFFFFFFF000ULL,                               /*  40 */
+    0x0000000000000FFFULL,
+    0xFFFFFFFFFFFFF800ULL,
+    0x00000000000007FFULL,
+    0xFFFFFFFFFFFFFC00ULL,
+    0x00000000000003FFULL,
+    0xFFFFFFFFFFFFFE00ULL,
+    0x00000000000001FFULL,
+    0xFFFFFFFFFFFFFF00ULL,                               /*  48 */
+    0x00000000000000FFULL,
+    0xFFFFFFFFFFFFFF80ULL,
+    0x000000000000007FULL,
+    0xFFFFFFFFFFFFFFC0ULL,
+    0x000000000000003FULL,
+    0xFFFFFFFFFFFFFFE0ULL,
+    0x000000000000001FULL,
+    0xFFFFFFFFFFFFFFF0ULL,                               /*  56 */
+    0x000000000000000FULL,
+    0xFFFFFFFFFFFFFFF8ULL,
+    0x0000000000000007ULL,
+    0xFFFFFFFFFFFFFFFCULL,
+    0x0000000000000003ULL,
+    0xFFFFFFFFFFFFFFFEULL,
+    0x0000000000000001ULL,
+};
+
+
+#define RANDOM_INPUTS_64_COUNT           16
+#define RANDOM_INPUTS_64_SHORT_COUNT      4
+
+static const uint64_t b64_random[RANDOM_INPUTS_64_COUNT] = {
+    0x886AE6CC28625540ULL,                               /*   0 */
+    0xFBBE00634D93C708ULL,
+    0xAC5AAEAAB9CF8B80ULL,
+    0x704F164D5E31E24EULL,
+    0xB9926B7C7DAF4258ULL,
+    0xD027BE89FF0A2EF9ULL,
+    0xB83B580665CABC4AULL,
+    0xFC8F23F09AA6B782ULL,
+    0x201E09CD56AEE649ULL,                               /*   8 */
+    0xA57CD91365D9E5D7ULL,
+    0xA2E8F6F5C9CBC61BULL,
+    0xA89CF2F131A864AEULL,
+    0xE61438E9A652EA0AULL,
+    0x944A35FD192361A8ULL,
+    0x4630426322BEF79CULL,
+    0x8B5AA7A2F259DEADULL,
+};
+
+static const uint64_t b64_random_se[RANDOM_INPUTS_64_COUNT] = {
+    0xFFFFFFFF886AE6CCULL,                               /*   0 */
+    0xFFFFFFFFFBBE0063ULL,
+    0xFFFFFFFFAC5AAEAAULL,
+    0x00000000704F164DULL,
+    0xFFFFFFFFB9926B7CULL,
+    0xFFFFFFFFD027BE89ULL,
+    0xFFFFFFFFB83B5806ULL,
+    0xFFFFFFFFFC8F23F0ULL,
+    0x00000000201E09CDULL,                               /*   8 */
+    0xFFFFFFFFA57CD913ULL,
+    0xFFFFFFFFA2E8F6F5ULL,
+    0xFFFFFFFFA89CF2F1ULL,
+    0xFFFFFFFFE61438E9ULL,
+    0xFFFFFFFF944A35FDULL,
+    0x0000000046304263ULL,
+    0xFFFFFFFF8B5AA7A2ULL,
+};
+
+
+#endif
diff --git a/tests/tcg/mips/include/test_utils_64.h b/tests/tcg/mips/include/test_utils_64.h
new file mode 100644
index 0000000..ee38284
--- /dev/null
+++ b/tests/tcg/mips/include/test_utils_64.h
@@ -0,0 +1,78 @@
+/*
+ *  Header file for test utilities
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
+#ifndef TEST_UTILS_64_H
+#define TEST_UTILS_64_H
+
+#include <stdio.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <string.h>
+
+#define PRINT_RESULTS 0
+
+
+static inline int32_t check_results_64(const char *instruction_name,
+                                       const uint32_t test_count,
+                                       const double elapsed_time,
+                                       const uint64_t *b64_result,
+                                       const uint64_t *b64_expect)
+{
+#if PRINT_RESULTS
+    uint32_t ii;
+    printf("\n");
+    for (ii = 0; ii < test_count; ii++) {
+        uint64_t a;
+        memcpy(&a, (b64_result + ii), 8);
+        if (ii % 8 != 0) {
+            printf("        0x%016llxULL,\n", a);
+        } else {
+            printf("        0x%016llxULL,                    /* %3d  */\n",
+                   a, ii);
+        }
+    }
+    printf("\n");
+#endif
+    uint32_t i;
+    uint32_t pass_count = 0;
+    uint32_t fail_count = 0;
+
+    printf("%s:   ", instruction_name);
+    for (i = 0; i < test_count; i++) {
+        if (b64_result[i] == b64_expect[i]) {
+            pass_count++;
+        } else {
+            fail_count++;
+        }
+    }
+
+    printf("PASS: %3d   FAIL: %3d   elapsed time: %5.2f ms\n",
+           pass_count, fail_count, elapsed_time);
+
+    if (fail_count > 0) {
+        return -1;
+    } else {
+        return 0;
+    }
+}
+
+
+#endif
-- 
2.7.4
