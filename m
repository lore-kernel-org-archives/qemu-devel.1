Received: from eggs.gnu.org ([209.51.188.92]:58753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guF4M-0003XL-ND
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guF4I-00034e-7q
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:20:40 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50342 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1guF4F-0000bF-Ak
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:20:36 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 14 Feb 2019 12:18:17 +0100
Message-Id: <1550143103-20133-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550143103-20133-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550143103-20133-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 3/9] tests/tcg: target/mips: Add a header
 with test utilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, alex.bennee@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add a header that contains test utilities. For now, it contains
only a function for checking and printing test results for bit
counting and similar MSA instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/test_utils.h | 84 +++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 tests/tcg/mips/include/test_utils.h

diff --git a/tests/tcg/mips/include/test_utils.h b/tests/tcg/mips/include/test_utils.h
new file mode 100644
index 0000000..03f3191
--- /dev/null
+++ b/tests/tcg/mips/include/test_utils.h
@@ -0,0 +1,84 @@
+/*
+ *  Header file for test utilities
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
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
+#ifndef TEST_UTILS_H
+#define TEST_UTILS_H
+
+#include <stdio.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <string.h>
+
+#define PRINT_RESULTS 0
+
+static inline int32_t check_results(char *instruction_name,
+                                    uint32_t test_count,
+                                    double elapsed_time,
+                                    uint64_t *b128_result,
+                                    uint64_t *b128_expect)
+{
+#if PRINT_RESULTS
+
+    uint32_t i;
+    printf("\n");
+    for (i = 0; i < test_count; i++) {
+        uint64_t a, b;
+        memcpy(&a, (b128_result + 2 * i), 8);
+        memcpy(&b, (b128_result + 2 * i + 1), 8);
+        if (i % 8 != 0) {
+            printf("        { 0x%016llxULL, 0x%016llxULL, },\n", a, b);
+        } else {
+            printf("        { 0x%016llxULL, 0x%016llxULL, },    /* %3d  */\n",
+                   a, b, i);
+        }
+    }
+    printf("\n");
+
+    return 0;
+
+#else
+
+    uint32_t i;
+    uint32_t pass_count = 0;
+    uint32_t fail_count = 0;
+
+    printf("%s:   ", instruction_name);
+    for (i = 0; i < test_count; i++) {
+        if (b128_result[i] == b128_expect[i]) {
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
+
+#endif
+}
+
+#endif
-- 
2.7.4
