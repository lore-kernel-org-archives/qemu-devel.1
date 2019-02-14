Received: from eggs.gnu.org ([209.51.188.92]:35786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL7I-0004mD-2I
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL7E-0004Xa-BB
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:48:07 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52329 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1guL7D-0004Ip-Rs
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:48:04 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 14 Feb 2019 18:47:24 +0100
Message-Id: <1550166444-22882-16-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 15/15] tests/tcg: target/mips: Add tests for MSA
 logic instructions
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

Add tests for MSA logic instructions. This includes following
instructions:

  * AND.V - logical AND
  * NOR.V - logical NOR
  * OR.V - logical OR
  * XOR.V - logical XOR

Each test consists of 80 test cases, so altogether there are 320
test cases.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c  | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c | 153 +++++++++++++++++++++
 4 files changed, 612 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
 create mode 100644 tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
 create mode 100644 tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
 create mode 100644 tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c

diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
new file mode 100644
index 0000000..51b256f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction AND.V
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "AND.V";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0xa28a28a28a28a28aULL, 0x28a28a28a28a28a2ULL, },
+        { 0x0820820820820820ULL, 0x8208208208208208ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0x4104104104104104ULL, 0x1041041041041041ULL, },
+        { 0x1451451451451451ULL, 0x4514514514514514ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc08c08c08c08c08cULL, 0x08c08c08c08c08c0ULL, },
+        { 0x0c40c40c40c40c40ULL, 0xc40c40c40c40c40cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x2302302302302302ULL, 0x3023023023023023ULL, },
+        { 0x1031031031031031ULL, 0x0310310310310310ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xa28a28a28a28a28aULL, 0x28a28a28a28a28a2ULL, },
+        { 0x4104104104104104ULL, 0x1041041041041041ULL, },
+        { 0xc08c08c08c08c08cULL, 0x08c08c08c08c08c0ULL, },
+        { 0x2302302302302302ULL, 0x3023023023023023ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0820820820820820ULL, 0x8208208208208208ULL, },
+        { 0x1451451451451451ULL, 0x4514514514514514ULL, },
+        { 0x0c40c40c40c40c40ULL, 0xc40c40c40c40c40cULL, },
+        { 0x1031031031031031ULL, 0x0310310310310310ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x882a004008024500ULL, 0x02670b1a143b100cULL, },
+        { 0x884aa68828420100ULL, 0x0340025eaa2b2004ULL, },
+        { 0x004a064c08204040ULL, 0x09610858a842a000ULL, },
+        { 0x882a004008024500ULL, 0x02670b1a143b100cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xa81a002209838300ULL, 0x02d0821a012b0014ULL, },
+        { 0x700e00414c11c208ULL, 0x00f18818010242a0ULL, },
+        { 0x884aa68828420100ULL, 0x0340025eaa2b2004ULL, },    /*  72  */
+        { 0xa81a002209838300ULL, 0x02d0821a012b0014ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x204a060818018200ULL, 0x05d080d8a9022000ULL, },
+        { 0x004a064c08204040ULL, 0x09610858a842a000ULL, },
+        { 0x700e00414c11c208ULL, 0x00f18818010242a0ULL, },
+        { 0x204a060818018200ULL, 0x05d080d8a9022000ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AND_V(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AND_V(b128_random[i], b128_random[j],
+                         b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
new file mode 100644
index 0000000..90ca198
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction NOR.V
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "NOR.V";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x1451451451451451ULL, 0x4514514514514514ULL, },
+        { 0x4104104104104104ULL, 0x1041041041041041ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x0820820820820820ULL, 0x8208208208208208ULL, },
+        { 0xa28a28a28a28a28aULL, 0x28a28a28a28a28a2ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1031031031031031ULL, 0x0310310310310310ULL, },
+        { 0x2302302302302302ULL, 0x3023023023023023ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0c40c40c40c40c40ULL, 0xc40c40c40c40c40cULL, },
+        { 0xc08c08c08c08c08cULL, 0x08c08c08c08c08c0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1451451451451451ULL, 0x4514514514514514ULL, },
+        { 0x0820820820820820ULL, 0x8208208208208208ULL, },
+        { 0x1031031031031031ULL, 0x0310310310310310ULL, },
+        { 0x0c40c40c40c40c40ULL, 0xc40c40c40c40c40cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x4104104104104104ULL, 0x1041041041041041ULL, },
+        { 0xa28a28a28a28a28aULL, 0x28a28a28a28a28a2ULL, },
+        { 0x2302302302302302ULL, 0x3023023023023023ULL, },
+        { 0xc08c08c08c08c08cULL, 0x08c08c08c08c08c0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x77951933d79daabfULL, 0xb498f4a101844ff3ULL, },    /*  64  */
+        { 0x04011910920c28b7ULL, 0xa40844a100800d03ULL, },
+        { 0x538511114610203fULL, 0x9000300000844ae3ULL, },
+        { 0x07900932818c08b1ULL, 0x3008742100840d53ULL, },
+        { 0x04011910920c28b7ULL, 0xa40844a100800d03ULL, },
+        { 0x0441ff9cb26c38f7ULL, 0xed0844e5eac0ad03ULL, },
+        { 0x0001511402203077ULL, 0xc800000040c08803ULL, },
+        { 0x0400e990a04c18b1ULL, 0x6008442542800d03ULL, },
+        { 0x538511114610203fULL, 0x9000300000844ae3ULL, },    /*  72  */
+        { 0x0001511402203077ULL, 0xc800000040c08803ULL, },
+        { 0x53a551554630747fULL, 0xd827390054d4daebULL, },
+        { 0x03a0411000001431ULL, 0x500631005494184bULL, },
+        { 0x07900932818c08b1ULL, 0x3008742100840d53ULL, },
+        { 0x0400e990a04c18b1ULL, 0x6008442542800d03ULL, },
+        { 0x03a0411000001431ULL, 0x500631005494184bULL, },
+        { 0x8fb0e9b2a1ce1db1ULL, 0x720e772756bd1d5fULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_NOR_V(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_NOR_V(b128_random[i], b128_random[j],
+                         b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
new file mode 100644
index 0000000..4ad5366
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction OR.V
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "OR.V";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xeeeeeeeeeeeeeeeeULL, 0xeeeeeeeeeeeeeeeeULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0xebaebaebaebaebaeULL, 0xbaebaebaebaebaebULL, },
+        { 0xbefbefbefbefbefbULL, 0xefbefbefbefbefbeULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xf7df7df7df7df7dfULL, 0x7df7df7df7df7df7ULL, },
+        { 0x5d75d75d75d75d75ULL, 0xd75d75d75d75d75dULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xeeeeeeeeeeeeeeeeULL, 0xeeeeeeeeeeeeeeeeULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xefcefcefcefcefceULL, 0xfcefcefcefcefcefULL, },
+        { 0xdcfdcfdcfdcfdcfdULL, 0xcfdcfdcfdcfdcfdcULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xf3bf3bf3bf3bf3bfULL, 0x3bf3bf3bf3bf3bf3ULL, },
+        { 0x3f73f73f73f73f73ULL, 0xf73f73f73f73f73fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xebaebaebaebaebaeULL, 0xbaebaebaebaebaebULL, },
+        { 0xf7df7df7df7df7dfULL, 0x7df7df7df7df7df7ULL, },
+        { 0xefcefcefcefcefceULL, 0xfcefcefcefcefcefULL, },
+        { 0xf3bf3bf3bf3bf3bfULL, 0x3bf3bf3bf3bf3bf3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xbefbefbefbefbefbULL, 0xefbefbefbefbefbeULL, },
+        { 0x5d75d75d75d75d75ULL, 0xd75d75d75d75d75dULL, },
+        { 0xdcfdcfdcfdcfdcfdULL, 0xcfdcfdcfdcfdcfdcULL, },
+        { 0x3f73f73f73f73f73ULL, 0xf73f73f73f73f73fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbfee6ef6df3d748ULL, 0x5bf7bb5eff7ff2fcULL, },
+        { 0xac7aeeeeb9efdfc0ULL, 0x6fffcfffff7bb51cULL, },
+        { 0xf86ff6cd7e73f74eULL, 0xcff78bdeff7bf2acULL, },
+        { 0xfbfee6ef6df3d748ULL, 0x5bf7bb5eff7ff2fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfffeaeebfddfcf88ULL, 0x37ffffffbf3f77fcULL, },
+        { 0xfbff166f5fb3e74eULL, 0x9ff7bbdabd7ff2fcULL, },
+        { 0xac7aeeeeb9efdfc0ULL, 0x6fffcfffff7bb51cULL, },    /*  72  */
+        { 0xfffeaeebfddfcf88ULL, 0x37ffffffbf3f77fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xfc5fbeefffffebceULL, 0xaff9ceffab6be7b4ULL, },
+        { 0xf86ff6cd7e73f74eULL, 0xcff78bdeff7bf2acULL, },
+        { 0xfbff166f5fb3e74eULL, 0x9ff7bbdabd7ff2fcULL, },
+        { 0xfc5fbeefffffebceULL, 0xaff9ceffab6be7b4ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_OR_V(b128_pattern[i], b128_pattern[j],
+                        b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_OR_V(b128_random[i], b128_random[j],
+                        b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                     (PATTERN_INPUTS_SHORT_COUNT)) +
+                                    RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
new file mode 100644
index 0000000..54effed
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction XOR.V
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "XOR.V";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x4924924924924924ULL, 0x9249249249249249ULL, },
+        { 0xb6db6db6db6db6dbULL, 0x6db6db6db6db6db6ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xb6db6db6db6db6dbULL, 0x6db6db6db6db6db6ULL, },
+        { 0x4924924924924924ULL, 0x9249249249249249ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x2f42f42f42f42f42ULL, 0xf42f42f42f42f42fULL, },
+        { 0xd0bd0bd0bd0bd0bdULL, 0x0bd0bd0bd0bd0bd0ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd0bd0bd0bd0bd0bdULL, 0x0bd0bd0bd0bd0bd0ULL, },
+        { 0x2f42f42f42f42f42ULL, 0xf42f42f42f42f42fULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x4924924924924924ULL, 0x9249249249249249ULL, },
+        { 0xb6db6db6db6db6dbULL, 0x6db6db6db6db6db6ULL, },
+        { 0x2f42f42f42f42f42ULL, 0xf42f42f42f42f42fULL, },
+        { 0xd0bd0bd0bd0bd0bdULL, 0x0bd0bd0bd0bd0bd0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xb6db6db6db6db6dbULL, 0x6db6db6db6db6db6ULL, },
+        { 0x4924924924924924ULL, 0x9249249249249249ULL, },
+        { 0xd0bd0bd0bd0bd0bdULL, 0x0bd0bd0bd0bd0bd0ULL, },
+        { 0x2f42f42f42f42f42ULL, 0xf42f42f42f42f42fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x73d4e6af65f19248ULL, 0x5990b044eb44e2f0ULL, },
+        { 0x2430486691addec0ULL, 0x6cbfcda155509518ULL, },
+        { 0xf825f0817653b70eULL, 0xc6968386573952acULL, },
+        { 0x73d4e6af65f19248ULL, 0x5990b044eb44e2f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x57e4aec9f45c4c88ULL, 0x352f7de5be1477e8ULL, },
+        { 0x8bf1162e13a22546ULL, 0x9f0633c2bc7db05cULL, },
+        { 0x2430486691addec0ULL, 0x6cbfcda155509518ULL, },    /*  72  */
+        { 0x57e4aec9f45c4c88ULL, 0x352f7de5be1477e8ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xdc15b8e7e7fe69ceULL, 0xaa294e270269c7b4ULL, },
+        { 0xf825f0817653b70eULL, 0xc6968386573952acULL, },
+        { 0x8bf1162e13a22546ULL, 0x9f0633c2bc7db05cULL, },
+        { 0xdc15b8e7e7fe69ceULL, 0xaa294e270269c7b4ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_XOR_V(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_XOR_V(b128_random[i], b128_random[j],
+                         b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
-- 
2.7.4
