Received: from eggs.gnu.org ([209.51.188.92]:35470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1C6A-0002Qk-56
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1C65-00036j-VO
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:16 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54884 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1C64-0002q9-VN
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:13 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue,  5 Mar 2019 16:34:32 +0100
Message-Id: <1551800076-8104-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551800076-8104-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551800076-8104-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 10/14] tests/tcg: target/mips: Add tests for
 MIPS64R6 bit swap instructions
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

Add tests for MIPS64R6 bit swap instructions: BITSWAP and DBITSWAP.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 .../isa/mips64r6/bit-swap/test_mips64r6_bitswap.c  | 144 +++++++++++++++++++++
 .../isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c | 144 +++++++++++++++++++++
 2 files changed, 288 insertions(+)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c

diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c b/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
new file mode 100644
index 0000000..639850d
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MIPS64R6 instruction BITSWAP
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
+    char *instruction_name = "BITSWAP";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0xffffffffffffffffULL,                    /*   0  */
+        0x0000000000000000ULL,
+        0x0000000055555555ULL,
+        0xffffffffaaaaaaaaULL,
+        0x0000000033333333ULL,
+        0xffffffffccccccccULL,
+        0x00000000711cc771ULL,
+        0xffffffff8ee3388eULL,
+        0x000000000f0f0f0fULL,                    /*   8  */
+        0xfffffffff0f0f0f0ULL,
+        0x00000000071f7cf0ULL,
+        0xfffffffff8e0830fULL,
+        0xfffffffff0033ff0ULL,
+        0x000000000ffcc00fULL,
+        0x0000000007fc017fULL,
+        0xfffffffff803fe80ULL,
+        0xffffffffff00ff00ULL,                    /*  16  */
+        0x0000000000ff00ffULL,
+        0xfffffffff01fc07fULL,
+        0x000000000fe03f80ULL,
+        0x0000000000ff03f0ULL,
+        0xffffffffff00fc0fULL,
+        0x0000000001f07f00ULL,
+        0xfffffffffe0f80ffULL,
+        0x000000000f00ff0fULL,                    /*  24  */
+        0xfffffffff0ff00f0ULL,
+        0x000000007f00f0ffULL,
+        0xffffffff80ff0f00ULL,
+        0xffffffffff0300ffULL,
+        0x0000000000fcff00ULL,
+        0xffffffffff1f00f0ULL,
+        0x0000000000e0ff0fULL,
+        0xffffffffffff0000ULL,                    /*  32  */
+        0x000000000000ffffULL,
+        0xfffffffffcff0700ULL,
+        0x000000000300f8ffULL,
+        0xfffffffff0ff3f00ULL,
+        0x000000000f00c0ffULL,
+        0xffffffffc0ffff01ULL,
+        0x000000003f0000feULL,
+        0x0000000000ffff0fULL,                    /*  40  */
+        0xffffffffff0000f0ULL,
+        0x0000000000fcff7fULL,
+        0xffffffffff030080ULL,
+        0x0000000000f0ffffULL,
+        0xffffffffff0f0000ULL,
+        0x0000000000c0ffffULL,
+        0xffffffffff3f0000ULL,
+        0x000000000000ffffULL,                    /*  48  */
+        0xffffffffffff0000ULL,
+        0x000000000000fcffULL,
+        0xffffffffffff0300ULL,
+        0x000000000000f0ffULL,
+        0xffffffffffff0f00ULL,
+        0x000000000000c0ffULL,
+        0xffffffffffff3f00ULL,
+        0x00000000000000ffULL,                    /*  56  */
+        0xffffffffffffff00ULL,
+        0x00000000000000fcULL,
+        0xffffffffffffff03ULL,
+        0x00000000000000f0ULL,
+        0xffffffffffffff0fULL,
+        0x00000000000000c0ULL,
+        0xffffffffffffff3fULL,
+        0x000000001446aa02ULL,                    /*  64  */
+        0xffffffffb2c9e310ULL,
+        0xffffffff9df3d101ULL,
+        0x000000007a8c4772ULL,
+        0xffffffffbef5421aULL,
+        0xffffffffff50749fULL,
+        0xffffffffa6533d52ULL,
+        0x000000005965ed41ULL,
+        0x000000006a756792ULL,                    /*  72  */
+        0xffffffffa69ba7ebULL,
+        0xffffffff93d363d8ULL,
+        0xffffffff8c152675ULL,
+        0x00000000654a5750ULL,
+        0xffffffff98c48615ULL,
+        0x00000000447def39ULL,
+        0x000000004f9a7bb5ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_64_COUNT) {
+            do_mips64r6_BITSWAP(b64_pattern + i, b64_result + i);
+        } else {
+            do_mips64r6_BITSWAP(b64_random + (i - PATTERN_INPUTS_64_COUNT),
+                                b64_result + i);
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
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c b/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
new file mode 100644
index 0000000..366fe61
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MIPS64R6 instruction DBITSWAP
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
+    char *instruction_name = "DBITSWAP";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] = {
+        0xffffffffffffffffULL,                    /*   0  */
+        0x0000000000000000ULL,
+        0x5555555555555555ULL,
+        0xaaaaaaaaaaaaaaaaULL,
+        0x3333333333333333ULL,
+        0xccccccccccccccccULL,
+        0xc7711cc7711cc771ULL,
+        0x388ee3388ee3388eULL,
+        0x0f0f0f0f0f0f0f0fULL,                    /*   8  */
+        0xf0f0f0f0f0f0f0f0ULL,
+        0x1f7cf0c1071f7cf0ULL,
+        0xe0830f3ef8e0830fULL,
+        0x3ff0033ff0033ff0ULL,
+        0xc00ffcc00ffcc00fULL,
+        0x7fc01ff007fc017fULL,
+        0x803fe00ff803fe80ULL,
+        0xff00ff00ff00ff00ULL,                    /*  16  */
+        0x00ff00ff00ff00ffULL,
+        0xff01fc07f01fc07fULL,
+        0x00fe03f80fe03f80ULL,
+        0xff03f03f00ff03f0ULL,
+        0x00fc0fc0ff00fc0fULL,
+        0xff07c0ff01f07f00ULL,
+        0x00f83f00fe0f80ffULL,
+        0xff0f00ff0f00ff0fULL,                    /*  24  */
+        0x00f0ff00f0ff00f0ULL,
+        0xff1f00fc7f00f0ffULL,
+        0x00e0ff0380ff0f00ULL,
+        0xff3f00f0ff0300ffULL,
+        0x00c0ff0f00fcff00ULL,
+        0xff7f00c0ff1f00f0ULL,
+        0x0080ff3f00e0ff0fULL,
+        0xffff0000ffff0000ULL,                    /*  32  */
+        0x0000ffff0000ffffULL,
+        0xffff0100fcff0700ULL,
+        0x0000feff0300f8ffULL,
+        0xffff0300f0ff3f00ULL,
+        0x0000fcff0f00c0ffULL,
+        0xffff0700c0ffff01ULL,
+        0x0000f8ff3f0000feULL,
+        0xffff0f0000ffff0fULL,                    /*  40  */
+        0x0000f0ffff0000f0ULL,
+        0xffff1f0000fcff7fULL,
+        0x0000e0ffff030080ULL,
+        0xffff3f0000f0ffffULL,
+        0x0000c0ffff0f0000ULL,
+        0xffff7f0000c0ffffULL,
+        0x000080ffff3f0000ULL,
+        0xffffff000000ffffULL,                    /*  48  */
+        0x000000ffffff0000ULL,
+        0xffffff010000fcffULL,
+        0x000000feffff0300ULL,
+        0xffffff030000f0ffULL,
+        0x000000fcffff0f00ULL,
+        0xffffff070000c0ffULL,
+        0x000000f8ffff3f00ULL,
+        0xffffff0f000000ffULL,                    /*  56  */
+        0x000000f0ffffff00ULL,
+        0xffffff1f000000fcULL,
+        0x000000e0ffffff03ULL,
+        0xffffff3f000000f0ULL,
+        0x000000c0ffffff0fULL,
+        0xffffff7f000000c0ULL,
+        0x00000080ffffff3fULL,
+        0x115667331446aa02ULL,                    /*  64  */
+        0xdf7d00c6b2c9e310ULL,
+        0x355a75559df3d101ULL,
+        0x0ef268b27a8c4772ULL,
+        0x9d49d63ebef5421aULL,
+        0x0be47d91ff50749fULL,
+        0x1ddc1a60a6533d52ULL,
+        0x3ff1c40f5965ed41ULL,
+        0x047890b36a756792ULL,                    /*  72  */
+        0xa53e9bc8a69ba7ebULL,
+        0x45176faf93d363d8ULL,
+        0x15394f8f8c152675ULL,
+        0x67281c97654a5750ULL,
+        0x2952acbf98c48615ULL,
+        0x620c42c6447def39ULL,
+        0xd15ae5454f9a7bb5ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_64_COUNT) {
+            do_mips64r6_DBITSWAP(b64_pattern + i, b64_result + i);
+        } else {
+            do_mips64r6_DBITSWAP(b64_random + (i - PATTERN_INPUTS_64_COUNT),
+                                 b64_result + i);
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
