Received: from eggs.gnu.org ([209.51.188.92]:42821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h0qDJ-0004oJ-LG
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h0qDH-0005Tl-9q
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:13:13 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:59755 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h0qDG-0005SP-L3
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:13:11 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  4 Mar 2019 17:11:50 +0100
Message-Id: <1551715911-8440-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551715911-8440-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551715911-8440-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 10/11] tests/tcg: target/mips: Add tests for
 MIPS64R6 bit count instructions
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

Add tests for MIPS64R6 bit count instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .../isa/mips64r6/bit-count/test_mips64r6_clo.c     | 144 +++++++++++++++++++++
 .../isa/mips64r6/bit-count/test_mips64r6_clz.c     | 144 +++++++++++++++++++++
 .../isa/mips64r6/bit-count/test_mips64r6_dclo.c    | 144 +++++++++++++++++++++
 .../isa/mips64r6/bit-count/test_mips64r6_dclz.c    | 144 +++++++++++++++++++++
 .../user/isa/mips64r6/shift/test_mips64r6_srlv.c   |   2 +-
 5 files changed, 577 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c

diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
new file mode 100644
index 0000000..ca9a739
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MIPS64R6 instruction CLO
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
+    char *instruction_name = "CLO";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000020ULL,                    /*   0  */
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,
+        0x0000000000000000ULL,
+        0x0000000000000002ULL,
+        0x0000000000000000ULL,
+        0x0000000000000003ULL,
+        0x0000000000000000ULL,
+        0x0000000000000004ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000005ULL,
+        0x0000000000000000ULL,
+        0x0000000000000006ULL,
+        0x0000000000000000ULL,
+        0x0000000000000007ULL,
+        0x0000000000000000ULL,
+        0x0000000000000008ULL,                    /*  16  */
+        0x0000000000000000ULL,
+        0x0000000000000009ULL,
+        0x0000000000000000ULL,
+        0x000000000000000aULL,
+        0x0000000000000000ULL,
+        0x000000000000000bULL,
+        0x0000000000000000ULL,
+        0x000000000000000cULL,                    /*  24  */
+        0x0000000000000000ULL,
+        0x000000000000000dULL,
+        0x0000000000000000ULL,
+        0x000000000000000eULL,
+        0x0000000000000000ULL,
+        0x000000000000000fULL,
+        0x0000000000000000ULL,
+        0x0000000000000010ULL,                    /*  32  */
+        0x0000000000000000ULL,
+        0x0000000000000011ULL,
+        0x0000000000000000ULL,
+        0x0000000000000012ULL,
+        0x0000000000000000ULL,
+        0x0000000000000013ULL,
+        0x0000000000000000ULL,
+        0x0000000000000014ULL,                    /*  40  */
+        0x0000000000000000ULL,
+        0x0000000000000015ULL,
+        0x0000000000000000ULL,
+        0x0000000000000016ULL,
+        0x0000000000000000ULL,
+        0x0000000000000017ULL,
+        0x0000000000000000ULL,
+        0x0000000000000018ULL,                    /*  48  */
+        0x0000000000000000ULL,
+        0x0000000000000019ULL,
+        0x0000000000000000ULL,
+        0x000000000000001aULL,
+        0x0000000000000000ULL,
+        0x000000000000001bULL,
+        0x0000000000000000ULL,
+        0x000000000000001cULL,                    /*  56  */
+        0x0000000000000000ULL,
+        0x000000000000001dULL,
+        0x0000000000000000ULL,
+        0x000000000000001eULL,
+        0x0000000000000000ULL,
+        0x000000000000001fULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,                    /*  64  */
+        0x0000000000000005ULL,
+        0x0000000000000001ULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,
+        0x0000000000000002ULL,
+        0x0000000000000001ULL,
+        0x0000000000000006ULL,
+        0x0000000000000000ULL,                    /*  72  */
+        0x0000000000000001ULL,
+        0x0000000000000001ULL,
+        0x0000000000000001ULL,
+        0x0000000000000003ULL,
+        0x0000000000000001ULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_64_COUNT) {
+            do_mips64r6_CLO(b64_pattern_se + i, b64_result + i);
+        } else {
+            do_mips64r6_CLO(b64_random_se + (i - PATTERN_INPUTS_64_COUNT),
+                             b64_result + i);
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
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
new file mode 100644
index 0000000..0a7d21d
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MIPS64R6 instruction CLZ
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
+    char *instruction_name = "CLZ";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000000ULL,                    /*   0  */
+        0x0000000000000020ULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,
+        0x0000000000000000ULL,
+        0x0000000000000002ULL,
+        0x0000000000000000ULL,
+        0x0000000000000003ULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000004ULL,
+        0x0000000000000000ULL,
+        0x0000000000000005ULL,
+        0x0000000000000000ULL,
+        0x0000000000000006ULL,
+        0x0000000000000000ULL,
+        0x0000000000000007ULL,
+        0x0000000000000000ULL,                    /*  16  */
+        0x0000000000000008ULL,
+        0x0000000000000000ULL,
+        0x0000000000000009ULL,
+        0x0000000000000000ULL,
+        0x000000000000000aULL,
+        0x0000000000000000ULL,
+        0x000000000000000bULL,
+        0x0000000000000000ULL,                    /*  24  */
+        0x000000000000000cULL,
+        0x0000000000000000ULL,
+        0x000000000000000dULL,
+        0x0000000000000000ULL,
+        0x000000000000000eULL,
+        0x0000000000000000ULL,
+        0x000000000000000fULL,
+        0x0000000000000000ULL,                    /*  32  */
+        0x0000000000000010ULL,
+        0x0000000000000000ULL,
+        0x0000000000000011ULL,
+        0x0000000000000000ULL,
+        0x0000000000000012ULL,
+        0x0000000000000000ULL,
+        0x0000000000000013ULL,
+        0x0000000000000000ULL,                    /*  40  */
+        0x0000000000000014ULL,
+        0x0000000000000000ULL,
+        0x0000000000000015ULL,
+        0x0000000000000000ULL,
+        0x0000000000000016ULL,
+        0x0000000000000000ULL,
+        0x0000000000000017ULL,
+        0x0000000000000000ULL,                    /*  48  */
+        0x0000000000000018ULL,
+        0x0000000000000000ULL,
+        0x0000000000000019ULL,
+        0x0000000000000000ULL,
+        0x000000000000001aULL,
+        0x0000000000000000ULL,
+        0x000000000000001bULL,
+        0x0000000000000000ULL,                    /*  56  */
+        0x000000000000001cULL,
+        0x0000000000000000ULL,
+        0x000000000000001dULL,
+        0x0000000000000000ULL,
+        0x000000000000001eULL,
+        0x0000000000000000ULL,
+        0x000000000000001fULL,
+        0x0000000000000000ULL,                    /*  64  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000002ULL,                    /*  72  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,
+        0x0000000000000000ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_64_COUNT) {
+            do_mips64r6_CLZ(b64_pattern_se + i, b64_result + i);
+        } else {
+            do_mips64r6_CLZ(b64_random_se + (i - PATTERN_INPUTS_64_COUNT),
+                             b64_result + i);
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
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
new file mode 100644
index 0000000..72bb473
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MIPS64R6 instruction DCLO
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
+    char *instruction_name = "DCLO";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000040ULL,                    /*   0  */
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,
+        0x0000000000000000ULL,
+        0x0000000000000002ULL,
+        0x0000000000000000ULL,
+        0x0000000000000003ULL,
+        0x0000000000000000ULL,
+        0x0000000000000004ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000000000005ULL,
+        0x0000000000000000ULL,
+        0x0000000000000006ULL,
+        0x0000000000000000ULL,
+        0x0000000000000007ULL,
+        0x0000000000000000ULL,
+        0x0000000000000008ULL,                    /*  16  */
+        0x0000000000000000ULL,
+        0x0000000000000009ULL,
+        0x0000000000000000ULL,
+        0x000000000000000aULL,
+        0x0000000000000000ULL,
+        0x000000000000000bULL,
+        0x0000000000000000ULL,
+        0x000000000000000cULL,                    /*  24  */
+        0x0000000000000000ULL,
+        0x000000000000000dULL,
+        0x0000000000000000ULL,
+        0x000000000000000eULL,
+        0x0000000000000000ULL,
+        0x000000000000000fULL,
+        0x0000000000000000ULL,
+        0x0000000000000010ULL,                    /*  32  */
+        0x0000000000000000ULL,
+        0x0000000000000011ULL,
+        0x0000000000000000ULL,
+        0x0000000000000012ULL,
+        0x0000000000000000ULL,
+        0x0000000000000013ULL,
+        0x0000000000000000ULL,
+        0x0000000000000014ULL,                    /*  40  */
+        0x0000000000000000ULL,
+        0x0000000000000015ULL,
+        0x0000000000000000ULL,
+        0x0000000000000016ULL,
+        0x0000000000000000ULL,
+        0x0000000000000017ULL,
+        0x0000000000000000ULL,
+        0x0000000000000018ULL,                    /*  48  */
+        0x0000000000000000ULL,
+        0x0000000000000019ULL,
+        0x0000000000000000ULL,
+        0x000000000000001aULL,
+        0x0000000000000000ULL,
+        0x000000000000001bULL,
+        0x0000000000000000ULL,
+        0x000000000000001cULL,                    /*  56  */
+        0x0000000000000000ULL,
+        0x000000000000001dULL,
+        0x0000000000000000ULL,
+        0x000000000000001eULL,
+        0x0000000000000000ULL,
+        0x000000000000001fULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,                    /*  64  */
+        0x0000000000000005ULL,
+        0x0000000000000001ULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,
+        0x0000000000000002ULL,
+        0x0000000000000001ULL,
+        0x0000000000000006ULL,
+        0x0000000000000000ULL,                    /*  72  */
+        0x0000000000000001ULL,
+        0x0000000000000001ULL,
+        0x0000000000000001ULL,
+        0x0000000000000003ULL,
+        0x0000000000000001ULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_64_COUNT) {
+            do_mips64r6_DCLO((void *)&b64_pattern[i], (void *)&b64_result[i]);
+        } else {
+            do_mips64r6_DCLO((void *)&b64_random[i - PATTERN_INPUTS_64_COUNT],
+                             (void *)&b64_result[i]);
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
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c
new file mode 100644
index 0000000..87df12b
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MIPS64R6 instruction DCLZ
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
+    char *instruction_name = "DCLZ";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0x0000000000000000ULL,                    /*   0  */
+        0x0000000000000040ULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,
+        0x0000000000000000ULL,
+        0x0000000000000002ULL,
+        0x0000000000000000ULL,
+        0x0000000000000003ULL,
+        0x0000000000000000ULL,                    /*   8  */
+        0x0000000000000004ULL,
+        0x0000000000000000ULL,
+        0x0000000000000005ULL,
+        0x0000000000000000ULL,
+        0x0000000000000006ULL,
+        0x0000000000000000ULL,
+        0x0000000000000007ULL,
+        0x0000000000000000ULL,                    /*  16  */
+        0x0000000000000008ULL,
+        0x0000000000000000ULL,
+        0x0000000000000009ULL,
+        0x0000000000000000ULL,
+        0x000000000000000aULL,
+        0x0000000000000000ULL,
+        0x000000000000000bULL,
+        0x0000000000000000ULL,                    /*  24  */
+        0x000000000000000cULL,
+        0x0000000000000000ULL,
+        0x000000000000000dULL,
+        0x0000000000000000ULL,
+        0x000000000000000eULL,
+        0x0000000000000000ULL,
+        0x000000000000000fULL,
+        0x0000000000000000ULL,                    /*  32  */
+        0x0000000000000010ULL,
+        0x0000000000000000ULL,
+        0x0000000000000011ULL,
+        0x0000000000000000ULL,
+        0x0000000000000012ULL,
+        0x0000000000000000ULL,
+        0x0000000000000013ULL,
+        0x0000000000000000ULL,                    /*  40  */
+        0x0000000000000014ULL,
+        0x0000000000000000ULL,
+        0x0000000000000015ULL,
+        0x0000000000000000ULL,
+        0x0000000000000016ULL,
+        0x0000000000000000ULL,
+        0x0000000000000017ULL,
+        0x0000000000000000ULL,                    /*  48  */
+        0x0000000000000018ULL,
+        0x0000000000000000ULL,
+        0x0000000000000019ULL,
+        0x0000000000000000ULL,
+        0x000000000000001aULL,
+        0x0000000000000000ULL,
+        0x000000000000001bULL,
+        0x0000000000000000ULL,                    /*  56  */
+        0x000000000000001cULL,
+        0x0000000000000000ULL,
+        0x000000000000001dULL,
+        0x0000000000000000ULL,
+        0x000000000000001eULL,
+        0x0000000000000000ULL,
+        0x000000000000001fULL,
+        0x0000000000000000ULL,                    /*  64  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000002ULL,                    /*  72  */
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,
+        0x0000000000000001ULL,
+        0x0000000000000000ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_64_COUNT) {
+            do_mips64r6_DCLZ(b64_pattern + i, b64_result + i);
+        } else {
+            do_mips64r6_DCLZ(b64_random + (i - PATTERN_INPUTS_64_COUNT),
+                             b64_result + i);
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
index 0bb161f..8b8075c 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
@@ -2,7 +2,7 @@
  *  Test program for MIPS64R6 instruction SRLV
  *
  *  Copyright (C) 2019  Wave Computing, Inc.
- *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
-- 
2.7.4
