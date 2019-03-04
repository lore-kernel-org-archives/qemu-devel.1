Received: from eggs.gnu.org ([209.51.188.92]:42840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h0qDL-0004pZ-34
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h0qDH-0005Tz-Ay
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:13:15 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:59763 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h0qDG-0005SR-Lo
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:13:11 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  4 Mar 2019 17:11:49 +0100
Message-Id: <1551715911-8440-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551715911-8440-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551715911-8440-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 09/11] tests/tcg: target/mips: Add tests for
 MIPS64R6 int multiply instructions
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

Add tests for MIPS64R6 integer multiply instructions. MUH and MUHU require
64 bit inputs in the form of 64-bit sign-extended 32-bit inputs.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .../isa/mips64r6/int-multiply/test_mips64r6_dmuh.c | 151 +++++++++++++++++++++
 .../mips64r6/int-multiply/test_mips64r6_dmuhu.c    | 151 +++++++++++++++++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_dmul.c | 151 +++++++++++++++++++++
 .../mips64r6/int-multiply/test_mips64r6_dmulu.c    | 151 +++++++++++++++++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_muh.c  | 151 +++++++++++++++++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_muhu.c | 151 +++++++++++++++++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_mul.c  | 151 +++++++++++++++++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_mulu.c | 151 +++++++++++++++++++++
 8 files changed, 1208 insertions(+)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c

diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
new file mode 100644
index 0000000..c049378
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction DMUH
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
+    char *instruction_name = "DMUH";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000000ULL,                    /*   0  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0xffffffffffffffffULL,
+        0x0000000000000000ULL,
+        0xffffffffffffffffULL,
+        0x0000000000000000ULL,
+        0xffffffffffffffffULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,                    /*  16  */
+        0x0000000000000000ULL,
+        0x1c71c71c71c71c72ULL,
+        0xe38e38e38e38e38eULL,
+        0x1111111111111111ULL,
+        0xeeeeeeeeeeeeeeeeULL,
+        0x097b425ed097b426ULL,
+        0xf684bda12f684bdaULL,
+        0xffffffffffffffffULL,                    /*  24  */
+        0x0000000000000000ULL,
+        0xe38e38e38e38e38eULL,
+        0x1c71c71c71c71c71ULL,
+        0xeeeeeeeeeeeeeeeeULL,
+        0x1111111111111110ULL,
+        0xf684bda12f684bdaULL,
+        0x097b425ed097b425ULL,
+        0x0000000000000000ULL,                    /*  32  */
+        0x0000000000000000ULL,
+        0x1111111111111111ULL,
+        0xeeeeeeeeeeeeeeeeULL,
+        0x0a3d70a3d70a3d70ULL,
+        0xf5c28f5c28f5c28fULL,
+        0x05b05b05b05b05b0ULL,
+        0xfa4fa4fa4fa4fa4fULL,
+        0xffffffffffffffffULL,                    /*  40  */
+        0x0000000000000000ULL,
+        0xeeeeeeeeeeeeeeeeULL,
+        0x1111111111111110ULL,
+        0xf5c28f5c28f5c28fULL,
+        0x0a3d70a3d70a3d70ULL,
+        0xfa4fa4fa4fa4fa4fULL,
+        0x05b05b05b05b05b0ULL,
+        0x0000000000000000ULL,                    /*  48  */
+        0x0000000000000000ULL,
+        0x097b425ed097b426ULL,
+        0xf684bda12f684bdaULL,
+        0x05b05b05b05b05b0ULL,
+        0xfa4fa4fa4fa4fa4fULL,
+        0x0329161f9add3c0cULL,
+        0xfcd6e9e06522c3f3ULL,
+        0xffffffffffffffffULL,                    /*  56  */
+        0x0000000000000000ULL,
+        0xf684bda12f684bdaULL,
+        0x097b425ed097b425ULL,
+        0xfa4fa4fa4fa4fa4fULL,
+        0x05b05b05b05b05b0ULL,
+        0xfcd6e9e06522c3f3ULL,
+        0x0329161f9add3c0cULL,
+        0x37dbf4448b48bce3ULL,                    /*  64  */
+        0x01fd28a6ebd66e19ULL,
+        0x271290430f9643afULL,
+        0xcb89d38b96a86603ULL,
+        0x01fd28a6ebd66e19ULL,
+        0x00122100b25f881aULL,
+        0x016425c3dacd63e9ULL,
+        0xfe21cf6e9b332df5ULL,
+        0x271290430f9643afULL,                    /*  72  */
+        0x016425c3dacd63e9ULL,
+        0x1b549d7f3d46f8d3ULL,
+        0xdb4dd51d1b7c58f2ULL,
+        0xcb89d38b96a86603ULL,
+        0xfe21cf6e9b332df5ULL,
+        0xdb4dd51d1b7c58f2ULL,
+        0x31454bf2781d2c60ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DMUH(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DMUH(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                                (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                               RANDOM_INPUTS_64_SHORT_COUNT * i + j));
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
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
new file mode 100644
index 0000000..dfb4195
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction DMUHU
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
+    char *instruction_name = "DMUHU";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0xfffffffffffffffeULL,                    /*   0  */
+        0x0000000000000000ULL,
+        0xaaaaaaaaaaaaaaa9ULL,
+        0x5555555555555554ULL,
+        0xcccccccccccccccbULL,
+        0x3333333333333332ULL,
+        0xe38e38e38e38e38dULL,
+        0x1c71c71c71c71c70ULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0xaaaaaaaaaaaaaaa9ULL,                    /*  16  */
+        0x0000000000000000ULL,
+        0x71c71c71c71c71c6ULL,
+        0x38e38e38e38e38e3ULL,
+        0x8888888888888887ULL,
+        0x2222222222222221ULL,
+        0x97b425ed097b425eULL,
+        0x12f684bda12f684bULL,
+        0x5555555555555554ULL,                    /*  24  */
+        0x0000000000000000ULL,
+        0x38e38e38e38e38e3ULL,
+        0x1c71c71c71c71c71ULL,
+        0x4444444444444443ULL,
+        0x1111111111111110ULL,
+        0x4bda12f684bda12fULL,
+        0x097b425ed097b425ULL,
+        0xcccccccccccccccbULL,                    /*  32  */
+        0x0000000000000000ULL,
+        0x8888888888888887ULL,
+        0x4444444444444443ULL,
+        0xa3d70a3d70a3d708ULL,
+        0x28f5c28f5c28f5c2ULL,
+        0xb60b60b60b60b60aULL,
+        0x16c16c16c16c16c0ULL,
+        0x3333333333333332ULL,                    /*  40  */
+        0x0000000000000000ULL,
+        0x2222222222222221ULL,
+        0x1111111111111110ULL,
+        0x28f5c28f5c28f5c2ULL,
+        0x0a3d70a3d70a3d70ULL,
+        0x2d82d82d82d82d82ULL,
+        0x05b05b05b05b05b0ULL,
+        0xe38e38e38e38e38dULL,                    /*  48  */
+        0x0000000000000000ULL,
+        0x97b425ed097b425eULL,
+        0x4bda12f684bda12fULL,
+        0xb60b60b60b60b60aULL,
+        0x2d82d82d82d82d82ULL,
+        0xca4587e6b74f0328ULL,
+        0x1948b0fcd6e9e064ULL,
+        0x1c71c71c71c71c70ULL,                    /*  56  */
+        0x0000000000000000ULL,
+        0x12f684bda12f684bULL,
+        0x097b425ed097b425ULL,
+        0x16c16c16c16c16c0ULL,
+        0x05b05b05b05b05b0ULL,
+        0x1948b0fcd6e9e064ULL,
+        0x0329161f9add3c0cULL,
+        0x48b1c1dcdc0d6763ULL,                    /*  64  */
+        0x86260fd661cc8a61ULL,
+        0x5bd825b9f1c8246fULL,
+        0x3bd8e9d8f4da4851ULL,
+        0x86260fd661cc8a61ULL,
+        0xf78e21c74d87162aULL,
+        0xa97cd4d1e230b671ULL,
+        0x6e70e5bbf9651043ULL,
+        0x5bd825b9f1c8246fULL,                    /*  72  */
+        0xa97cd4d1e230b671ULL,
+        0x7409fad4b0e60fd3ULL,
+        0x4b9ceb6a79ae3b40ULL,
+        0x3bd8e9d8f4da4851ULL,
+        0x6e70e5bbf9651043ULL,
+        0x4b9ceb6a79ae3b40ULL,
+        0x31454bf2781d2c60ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DMUHU(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DMUHU(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                                (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                               RANDOM_INPUTS_64_SHORT_COUNT * i + j));
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
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
new file mode 100644
index 0000000..3c337dd
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction DMUL
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
+    char *instruction_name = "DMUL";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000001ULL,                    /*   0  */
+        0x0000000000000000ULL,
+        0x5555555555555556ULL,
+        0xaaaaaaaaaaaaaaabULL,
+        0x3333333333333334ULL,
+        0xcccccccccccccccdULL,
+        0x1c71c71c71c71c72ULL,
+        0xe38e38e38e38e38fULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x5555555555555556ULL,                    /*  16  */
+        0x0000000000000000ULL,
+        0x38e38e38e38e38e4ULL,
+        0x1c71c71c71c71c72ULL,
+        0x7777777777777778ULL,
+        0xdddddddddddddddeULL,
+        0x12f684bda12f684cULL,
+        0x425ed097b425ed0aULL,
+        0xaaaaaaaaaaaaaaabULL,                    /*  24  */
+        0x0000000000000000ULL,
+        0x1c71c71c71c71c72ULL,
+        0x8e38e38e38e38e39ULL,
+        0xbbbbbbbbbbbbbbbcULL,
+        0xeeeeeeeeeeeeeeefULL,
+        0x097b425ed097b426ULL,
+        0xa12f684bda12f685ULL,
+        0x3333333333333334ULL,                    /*  32  */
+        0x0000000000000000ULL,
+        0x7777777777777778ULL,
+        0xbbbbbbbbbbbbbbbcULL,
+        0xf5c28f5c28f5c290ULL,
+        0x3d70a3d70a3d70a4ULL,
+        0x7d27d27d27d27d28ULL,
+        0xb60b60b60b60b60cULL,
+        0xcccccccccccccccdULL,                    /*  40  */
+        0x0000000000000000ULL,
+        0xdddddddddddddddeULL,
+        0xeeeeeeeeeeeeeeefULL,
+        0x3d70a3d70a3d70a4ULL,
+        0x8f5c28f5c28f5c29ULL,
+        0x9f49f49f49f49f4aULL,
+        0x2d82d82d82d82d83ULL,
+        0x1c71c71c71c71c72ULL,                    /*  48  */
+        0x0000000000000000ULL,
+        0x12f684bda12f684cULL,
+        0x097b425ed097b426ULL,
+        0x7d27d27d27d27d28ULL,
+        0x9f49f49f49f49f4aULL,
+        0xb0fcd6e9e06522c4ULL,
+        0x6b74f0329161f9aeULL,
+        0xe38e38e38e38e38fULL,                    /*  56  */
+        0x0000000000000000ULL,
+        0x425ed097b425ed0aULL,
+        0xa12f684bda12f685ULL,
+        0xb60b60b60b60b60cULL,
+        0x2d82d82d82d82d83ULL,
+        0x6b74f0329161f9aeULL,
+        0x781948b0fcd6e9e1ULL,
+        0xad45be6961639000ULL,                    /*  64  */
+        0xefa7a5a0e7176a00ULL,
+        0x08c6139fc4346000ULL,
+        0xfbe1883aee787980ULL,
+        0xefa7a5a0e7176a00ULL,
+        0x37ae2b38fded7040ULL,
+        0x6acb3d68be6cdc00ULL,
+        0xedbf72842143b470ULL,
+        0x08c6139fc4346000ULL,                    /*  72  */
+        0x6acb3d68be6cdc00ULL,
+        0x8624e5e1e5044000ULL,
+        0x76a5ab8089e38100ULL,
+        0xfbe1883aee787980ULL,
+        0xedbf72842143b470ULL,
+        0x76a5ab8089e38100ULL,
+        0x4bb436d5b1e9cfc4ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DMUL(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DMUL(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                                (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                               RANDOM_INPUTS_64_SHORT_COUNT * i + j));
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
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
new file mode 100644
index 0000000..b20a1ba
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction DMULU
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
+    char *instruction_name = "DMULU";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000001ULL,                    /*   0  */
+        0x0000000000000000ULL,
+        0x5555555555555556ULL,
+        0xaaaaaaaaaaaaaaabULL,
+        0x3333333333333334ULL,
+        0xcccccccccccccccdULL,
+        0x1c71c71c71c71c72ULL,
+        0xe38e38e38e38e38fULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x5555555555555556ULL,                    /*  16  */
+        0x0000000000000000ULL,
+        0x38e38e38e38e38e4ULL,
+        0x1c71c71c71c71c72ULL,
+        0x7777777777777778ULL,
+        0xdddddddddddddddeULL,
+        0x12f684bda12f684cULL,
+        0x425ed097b425ed0aULL,
+        0xaaaaaaaaaaaaaaabULL,                    /*  24  */
+        0x0000000000000000ULL,
+        0x1c71c71c71c71c72ULL,
+        0x8e38e38e38e38e39ULL,
+        0xbbbbbbbbbbbbbbbcULL,
+        0xeeeeeeeeeeeeeeefULL,
+        0x097b425ed097b426ULL,
+        0xa12f684bda12f685ULL,
+        0x3333333333333334ULL,                    /*  32  */
+        0x0000000000000000ULL,
+        0x7777777777777778ULL,
+        0xbbbbbbbbbbbbbbbcULL,
+        0xf5c28f5c28f5c290ULL,
+        0x3d70a3d70a3d70a4ULL,
+        0x7d27d27d27d27d28ULL,
+        0xb60b60b60b60b60cULL,
+        0xcccccccccccccccdULL,                    /*  40  */
+        0x0000000000000000ULL,
+        0xdddddddddddddddeULL,
+        0xeeeeeeeeeeeeeeefULL,
+        0x3d70a3d70a3d70a4ULL,
+        0x8f5c28f5c28f5c29ULL,
+        0x9f49f49f49f49f4aULL,
+        0x2d82d82d82d82d83ULL,
+        0x1c71c71c71c71c72ULL,                    /*  48  */
+        0x0000000000000000ULL,
+        0x12f684bda12f684cULL,
+        0x097b425ed097b426ULL,
+        0x7d27d27d27d27d28ULL,
+        0x9f49f49f49f49f4aULL,
+        0xb0fcd6e9e06522c4ULL,
+        0x6b74f0329161f9aeULL,
+        0xe38e38e38e38e38fULL,                    /*  56  */
+        0x0000000000000000ULL,
+        0x425ed097b425ed0aULL,
+        0xa12f684bda12f685ULL,
+        0xb60b60b60b60b60cULL,
+        0x2d82d82d82d82d83ULL,
+        0x6b74f0329161f9aeULL,
+        0x781948b0fcd6e9e1ULL,
+        0xad45be6961639000ULL,                    /*  64  */
+        0xefa7a5a0e7176a00ULL,
+        0x08c6139fc4346000ULL,
+        0xfbe1883aee787980ULL,
+        0xefa7a5a0e7176a00ULL,
+        0x37ae2b38fded7040ULL,
+        0x6acb3d68be6cdc00ULL,
+        0xedbf72842143b470ULL,
+        0x08c6139fc4346000ULL,                    /*  72  */
+        0x6acb3d68be6cdc00ULL,
+        0x8624e5e1e5044000ULL,
+        0x76a5ab8089e38100ULL,
+        0xfbe1883aee787980ULL,
+        0xedbf72842143b470ULL,
+        0x76a5ab8089e38100ULL,
+        0x4bb436d5b1e9cfc4ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DMULU(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_DMULU(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                                (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                               RANDOM_INPUTS_64_SHORT_COUNT * i + j));
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
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
new file mode 100644
index 0000000..9134074
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction MUH
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
+    char *instruction_name = "MUH";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000000ULL,                    /*   0  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0xffffffffffffffffULL,
+        0x0000000000000000ULL,
+        0xffffffffffffffffULL,
+        0x0000000000000000ULL,
+        0xffffffffffffffffULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,                    /*  16  */
+        0x0000000000000000ULL,
+        0x000000001c71c71cULL,
+        0xffffffffe38e38e3ULL,
+        0x0000000011111111ULL,
+        0xffffffffeeeeeeeeULL,
+        0x00000000097b425fULL,
+        0xfffffffff684bda1ULL,
+        0xffffffffffffffffULL,                    /*  24  */
+        0x0000000000000000ULL,
+        0xffffffffe38e38e3ULL,
+        0x000000001c71c71cULL,
+        0xffffffffeeeeeeeeULL,
+        0x0000000011111110ULL,
+        0xfffffffff684bda1ULL,
+        0x00000000097b425eULL,
+        0x0000000000000000ULL,                    /*  32  */
+        0x0000000000000000ULL,
+        0x0000000011111111ULL,
+        0xffffffffeeeeeeeeULL,
+        0x000000000a3d70a4ULL,
+        0xfffffffff5c28f5cULL,
+        0x0000000005b05b05ULL,
+        0xfffffffffa4fa4faULL,
+        0xffffffffffffffffULL,                    /*  40  */
+        0x0000000000000000ULL,
+        0xffffffffeeeeeeeeULL,
+        0x0000000011111110ULL,
+        0xfffffffff5c28f5cULL,
+        0x000000000a3d70a3ULL,
+        0xfffffffffa4fa4faULL,
+        0x0000000005b05b05ULL,
+        0x0000000000000000ULL,                    /*  48  */
+        0x0000000000000000ULL,
+        0x00000000097b425fULL,
+        0xfffffffff684bda1ULL,
+        0x0000000005b05b05ULL,
+        0xfffffffffa4fa4faULL,
+        0x000000000329161fULL,
+        0xfffffffffcd6e9e0ULL,
+        0xffffffffffffffffULL,                    /*  56  */
+        0x0000000000000000ULL,
+        0xfffffffff684bda1ULL,
+        0x00000000097b425eULL,
+        0xfffffffffa4fa4faULL,
+        0x0000000005b05b05ULL,
+        0xfffffffffcd6e9e0ULL,
+        0x000000000329161fULL,
+        0x0000000037dbf444ULL,                    /*  64  */
+        0x0000000001fd28a7ULL,
+        0x0000000027129043ULL,
+        0xffffffffcb89d38bULL,
+        0x0000000001fd28a7ULL,
+        0x0000000000122100ULL,
+        0x00000000016425c3ULL,
+        0xfffffffffe21cf6eULL,
+        0x0000000027129043ULL,                    /*  72  */
+        0x00000000016425c3ULL,
+        0x000000001b549d7fULL,
+        0xffffffffdb4dd51cULL,
+        0xffffffffcb89d38bULL,
+        0xfffffffffe21cf6eULL,
+        0xffffffffdb4dd51cULL,
+        0x0000000031454bf2ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_MUH(b64_pattern_se + i, b64_pattern_se + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_MUH(b64_random_se + i, b64_random_se + j,
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
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
new file mode 100644
index 0000000..2485060
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction MUHU
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
+    char *instruction_name = "MUHU";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0xfffffffffffffffeULL,                    /*   0  */
+        0x0000000000000000ULL,
+        0xffffffffaaaaaaa9ULL,
+        0x0000000055555554ULL,
+        0xffffffffcccccccbULL,
+        0x0000000033333332ULL,
+        0xffffffffe38e38e2ULL,
+        0x000000001c71c71bULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0xffffffffaaaaaaa9ULL,                    /*  16  */
+        0x0000000000000000ULL,
+        0x0000000071c71c70ULL,
+        0x0000000038e38e38ULL,
+        0xffffffff88888887ULL,
+        0x0000000022222221ULL,
+        0xffffffff97b425ecULL,
+        0x0000000012f684bdULL,
+        0x0000000055555554ULL,                    /*  24  */
+        0x0000000000000000ULL,
+        0x0000000038e38e38ULL,
+        0x000000001c71c71cULL,
+        0x0000000044444443ULL,
+        0x0000000011111110ULL,
+        0x000000004bda12f6ULL,
+        0x00000000097b425eULL,
+        0xffffffffcccccccbULL,                    /*  32  */
+        0x0000000000000000ULL,
+        0xffffffff88888887ULL,
+        0x0000000044444443ULL,
+        0xffffffffa3d70a3cULL,
+        0x0000000028f5c28fULL,
+        0xffffffffb60b60b4ULL,
+        0x0000000016c16c16ULL,
+        0x0000000033333332ULL,                    /*  40  */
+        0x0000000000000000ULL,
+        0x0000000022222221ULL,
+        0x0000000011111110ULL,
+        0x0000000028f5c28fULL,
+        0x000000000a3d70a3ULL,
+        0x000000002d82d82dULL,
+        0x0000000005b05b05ULL,
+        0xffffffffe38e38e2ULL,                    /*  48  */
+        0x0000000000000000ULL,
+        0xffffffff97b425ecULL,
+        0x000000004bda12f6ULL,
+        0xffffffffb60b60b4ULL,
+        0x000000002d82d82dULL,
+        0xffffffffca4587e5ULL,
+        0x000000001948b0fcULL,
+        0x000000001c71c71bULL,                    /*  56  */
+        0x0000000000000000ULL,
+        0x0000000012f684bdULL,
+        0x00000000097b425eULL,
+        0x0000000016c16c16ULL,
+        0x0000000005b05b05ULL,
+        0x000000001948b0fcULL,
+        0x000000000329161fULL,
+        0x0000000048b1c1dcULL,                    /*  64  */
+        0xffffffff86260fd6ULL,
+        0x000000005bd825b9ULL,
+        0x000000003bd8e9d8ULL,
+        0xffffffff86260fd6ULL,
+        0xfffffffff78e21c6ULL,
+        0xffffffffa97cd4d0ULL,
+        0x000000006e70e5bbULL,
+        0x000000005bd825b9ULL,                    /*  72  */
+        0xffffffffa97cd4d0ULL,
+        0x000000007409fad3ULL,
+        0x000000004b9ceb69ULL,
+        0x000000003bd8e9d8ULL,
+        0x000000006e70e5bbULL,
+        0x000000004b9ceb69ULL,
+        0x0000000031454bf2ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_MUHU(b64_pattern_se + i, b64_pattern_se + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_MUHU(b64_random_se + i, b64_random_se + j,
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
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
new file mode 100644
index 0000000..acf779c
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction MUL
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
+    char *instruction_name = "MUL";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000001ULL,                    /*   0  */
+        0x0000000000000000ULL,
+        0x0000000055555556ULL,
+        0xffffffffaaaaaaabULL,
+        0x0000000033333334ULL,
+        0xffffffffcccccccdULL,
+        0x0000000071c71c72ULL,
+        0xffffffff8e38e38fULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000055555556ULL,                    /*  16  */
+        0x0000000000000000ULL,
+        0xffffffffe38e38e4ULL,
+        0x0000000071c71c72ULL,
+        0x0000000077777778ULL,
+        0xffffffffdddddddeULL,
+        0xffffffffa12f684cULL,
+        0xffffffffb425ed0aULL,
+        0xffffffffaaaaaaabULL,                    /*  24  */
+        0x0000000000000000ULL,
+        0x0000000071c71c72ULL,
+        0x0000000038e38e39ULL,
+        0xffffffffbbbbbbbcULL,
+        0xffffffffeeeeeeefULL,
+        0xffffffffd097b426ULL,
+        0xffffffffda12f685ULL,
+        0x0000000033333334ULL,                    /*  32  */
+        0x0000000000000000ULL,
+        0x0000000077777778ULL,
+        0xffffffffbbbbbbbcULL,
+        0x0000000028f5c290ULL,
+        0x000000000a3d70a4ULL,
+        0x0000000027d27d28ULL,
+        0x000000000b60b60cULL,
+        0xffffffffcccccccdULL,                    /*  40  */
+        0x0000000000000000ULL,
+        0xffffffffdddddddeULL,
+        0xffffffffeeeeeeefULL,
+        0x000000000a3d70a4ULL,
+        0xffffffffc28f5c29ULL,
+        0x0000000049f49f4aULL,
+        0xffffffff82d82d83ULL,
+        0x0000000071c71c72ULL,                    /*  48  */
+        0x0000000000000000ULL,
+        0xffffffffa12f684cULL,
+        0xffffffffd097b426ULL,
+        0x0000000027d27d28ULL,
+        0x0000000049f49f4aULL,
+        0xffffffffe06522c4ULL,
+        0xffffffff9161f9aeULL,
+        0xffffffff8e38e38fULL,                    /*  56  */
+        0x0000000000000000ULL,
+        0xffffffffb425ed0aULL,
+        0xffffffffda12f685ULL,
+        0x000000000b60b60cULL,
+        0xffffffff82d82d83ULL,
+        0xffffffff9161f9aeULL,
+        0xfffffffffcd6e9e1ULL,
+        0x0000000061639000ULL,                    /*  64  */
+        0xffffffffe7176a00ULL,
+        0xffffffffc4346000ULL,
+        0xffffffffee787980ULL,
+        0xffffffffe7176a00ULL,
+        0xfffffffffded7040ULL,
+        0xffffffffbe6cdc00ULL,
+        0x000000002143b470ULL,
+        0xffffffffc4346000ULL,                    /*  72  */
+        0xffffffffbe6cdc00ULL,
+        0xffffffffe5044000ULL,
+        0xffffffff89e38100ULL,
+        0xffffffffee787980ULL,
+        0x000000002143b470ULL,
+        0xffffffff89e38100ULL,
+        0xffffffffb1e9cfc4ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_MUL(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_MUL(b64_random + i, b64_random + j,
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
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c
new file mode 100644
index 0000000..65d5803
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MIPS64R6 instruction MULU
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
+    char *instruction_name = "MULU";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000001ULL,                    /*   0  */
+        0x0000000000000000ULL,
+        0x0000000055555556ULL,
+        0xffffffffaaaaaaabULL,
+        0x0000000033333334ULL,
+        0xffffffffcccccccdULL,
+        0x0000000071c71c72ULL,
+        0xffffffff8e38e38fULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000055555556ULL,                    /*  16  */
+        0x0000000000000000ULL,
+        0xffffffffe38e38e4ULL,
+        0x0000000071c71c72ULL,
+        0x0000000077777778ULL,
+        0xffffffffdddddddeULL,
+        0xffffffffa12f684cULL,
+        0xffffffffb425ed0aULL,
+        0xffffffffaaaaaaabULL,                    /*  24  */
+        0x0000000000000000ULL,
+        0x0000000071c71c72ULL,
+        0x0000000038e38e39ULL,
+        0xffffffffbbbbbbbcULL,
+        0xffffffffeeeeeeefULL,
+        0xffffffffd097b426ULL,
+        0xffffffffda12f685ULL,
+        0x0000000033333334ULL,                    /*  32  */
+        0x0000000000000000ULL,
+        0x0000000077777778ULL,
+        0xffffffffbbbbbbbcULL,
+        0x0000000028f5c290ULL,
+        0x000000000a3d70a4ULL,
+        0x0000000027d27d28ULL,
+        0x000000000b60b60cULL,
+        0xffffffffcccccccdULL,                    /*  40  */
+        0x0000000000000000ULL,
+        0xffffffffdddddddeULL,
+        0xffffffffeeeeeeefULL,
+        0x000000000a3d70a4ULL,
+        0xffffffffc28f5c29ULL,
+        0x0000000049f49f4aULL,
+        0xffffffff82d82d83ULL,
+        0x0000000071c71c72ULL,                    /*  48  */
+        0x0000000000000000ULL,
+        0xffffffffa12f684cULL,
+        0xffffffffd097b426ULL,
+        0x0000000027d27d28ULL,
+        0x0000000049f49f4aULL,
+        0xffffffffe06522c4ULL,
+        0xffffffff9161f9aeULL,
+        0xffffffff8e38e38fULL,                    /*  56  */
+        0x0000000000000000ULL,
+        0xffffffffb425ed0aULL,
+        0xffffffffda12f685ULL,
+        0x000000000b60b60cULL,
+        0xffffffff82d82d83ULL,
+        0xffffffff9161f9aeULL,
+        0xfffffffffcd6e9e1ULL,
+        0x0000000061639000ULL,                    /*  64  */
+        0xffffffffe7176a00ULL,
+        0xffffffffc4346000ULL,
+        0xffffffffee787980ULL,
+        0xffffffffe7176a00ULL,
+        0xfffffffffded7040ULL,
+        0xffffffffbe6cdc00ULL,
+        0x000000002143b470ULL,
+        0xffffffffc4346000ULL,                    /*  72  */
+        0xffffffffbe6cdc00ULL,
+        0xffffffffe5044000ULL,
+        0xffffffff89e38100ULL,
+        0xffffffffee787980ULL,
+        0x000000002143b470ULL,
+        0xffffffff89e38100ULL,
+        0xffffffffb1e9cfc4ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_MULU(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_MULU(b64_random + i, b64_random + j,
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
