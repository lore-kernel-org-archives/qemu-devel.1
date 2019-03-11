Received: from eggs.gnu.org ([209.51.188.92]:57190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h3Lss-00056j-3L
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h3Lsj-0001TO-RS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:26:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54274 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h3LsP-0000fl-Pr
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:26:21 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 11 Mar 2019 15:24:47 +0100
Message-Id: <1552314290-28709-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 4/7] target/mips: Add tests for a variety of MSA
 integer divide instructions
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

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Add tests for a variety of MSA integer divide instructions.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1551964929-17845-3-git-send-email-mateja.marjanovic@rt-rk.com>
---
 .../user/ase/msa/int-divide/test_msa_div_s_b.c     | 151 +++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_s_d.c     | 151 +++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_s_h.c     | 151 +++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_s_w.c     | 151 +++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_u_b.c     | 151 +++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_u_d.c     | 151 +++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_u_h.c     | 151 +++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_u_w.c     | 151 +++++++++++++++++++++
 8 files changed, 1208 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c

diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
new file mode 100644
index 0000000..38e3670
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DIV_S.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "DIV_S.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*   0  */
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },    /*  16  */
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0200ff0200ff0200ULL, 0xff0200ff0200ff02ULL, },
+        { 0xfd0001fd0001fd00ULL, 0x01fd0001fd0001fdULL, },
+        { 0xababababababababULL, 0xababababababababULL, },    /*  24  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0xfe0001fe0001fe00ULL, 0x01fe0001fe0001feULL, },
+        { 0x0300ff0300ff0300ULL, 0xff0300ff0300ff03ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },    /*  32  */
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0100000100000100ULL, 0x0001000001000001ULL, },
+        { 0xff0000ff0000ff00ULL, 0x00ff0000ff0000ffULL, },
+        { 0xcdcdcdcdcdcdcdcdULL, 0xcdcdcdcdcdcdcdcdULL, },    /*  40  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0xff0000ff0000ff00ULL, 0x00ff0000ff0000ffULL, },
+        { 0x0100000100000100ULL, 0x0001000001000001ULL, },
+        { 0x1d72c81d72c81d72ULL, 0xc81d72c81d72c81dULL, },    /*  48  */
+        { 0x0101ff0101ff0101ULL, 0xff0101ff0101ff01ULL, },
+        { 0x0001000001000001ULL, 0x0000010000010000ULL, },
+        { 0x00ff0000ff0000ffULL, 0x0000ff0000ff0000ULL, },
+        { 0x0002ff0002ff0002ULL, 0xff0002ff0002ff00ULL, },
+        { 0x00fe0100fe0100feULL, 0x0100fe0100fe0100ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0xe48f39e48f39e48fULL, 0x39e48f39e48f39e4ULL, },    /*  56  */
+        { 0xffff01ffff01ffffULL, 0x01ffff01ffff01ffULL, },
+        { 0x00ff0000ff0000ffULL, 0x0000ff0000ff0000ULL, },
+        { 0x0001000001000001ULL, 0x0000010000010000ULL, },
+        { 0x00fe0100fe0100feULL, 0x0100fe0100fe0100ULL, },
+        { 0x0002ff0002ff0002ULL, 0xff0002ff0002ff00ULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*  64  */
+        { 0x18ff01000000ff08ULL, 0x04f50003000100fdULL, },
+        { 0x0101000000fe0000ULL, 0x01fe00a20002fe00ULL, },
+        { 0xff01ff000002fe00ULL, 0x00fa00fe00010200ULL, },
+        { 0x000000ff01ff0000ULL, 0x0000fa00f600ff00ULL, },
+        { 0x0101ff0101010101ULL, 0x0101010101010101ULL, },
+        { 0x000000ffff020000ULL, 0x000001e600010200ULL, },
+        { 0x0000000100fe0100ULL, 0x000000000000fe00ULL, },
+        { 0x00000301ff00fffeULL, 0x0000fb002a000001ULL, },    /*  72  */
+        { 0x10ff0100000002f0ULL, 0x02040000fc0000fbULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0001fdff00ff03ffULL, 0x000200000000ff00ULL, },
+        { 0x000000ff02000001ULL, 0xff00f6002b0000f8ULL, },
+        { 0xeaffff0001000009ULL, 0xfa0101fffc010018ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_S_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_S_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
new file mode 100644
index 0000000..d92b695
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DIV_S.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "DIV_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*   0  */
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },    /*  16  */
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000003ULL, 0xffffffffffffffffULL, },
+        { 0xfffffffffffffffdULL, 0x0000000000000001ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },    /*  24  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0xfffffffffffffffeULL, 0x0000000000000001ULL, },
+        { 0x0000000000000003ULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },    /*  32  */
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xcccccccccccccccdULL, 0xcccccccccccccccdULL, },    /*  40  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c72ULL, 0xc71c71c71c71c71dULL, },    /*  48  */
+        { 0x0000000000000001ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38fULL, 0x38e38e38e38e38e4ULL, },    /*  56  */
+        { 0xffffffffffffffffULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*  64  */
+        { 0x000000000000001cULL, 0x0000000000000003ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  72  */
+        { 0x0000000000000013ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffe6ULL, 0xfffffffffffffffaULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_S_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
new file mode 100644
index 0000000..f191b98
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DIV_S.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "DIV_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*   0  */
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },    /*  16  */
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0003ffff00000003ULL, 0xffff00000003ffffULL, },
+        { 0xfffd00010000fffdULL, 0x00010000fffd0001ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },    /*  24  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0xfffe00010000fffeULL, 0x00010000fffe0001ULL, },
+        { 0x0003ffff00000003ULL, 0xffff00000003ffffULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },    /*  32  */
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0001000000000001ULL, 0x0000000000010000ULL, },
+        { 0xffff00000000ffffULL, 0x00000000ffff0000ULL, },
+        { 0xcccdcccdcccdcccdULL, 0xcccdcccdcccdcccdULL, },    /*  40  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0xffff00000000ffffULL, 0x00000000ffff0000ULL, },
+        { 0x0001000000000001ULL, 0x0000000000010000ULL, },
+        { 0x1c72c71d71c81c72ULL, 0xc71d71c81c72c71dULL, },    /*  48  */
+        { 0x0001ffff00010001ULL, 0xffff00010001ffffULL, },
+        { 0x0000000000010000ULL, 0x0000000100000000ULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
+        { 0x0000ffff00020000ULL, 0xffff00020000ffffULL, },
+        { 0x00000001fffe0000ULL, 0x0001fffe00000001ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0xe38f38e48e39e38fULL, 0x38e48e39e38f38e4ULL, },    /*  56  */
+        { 0xffff0001ffffffffULL, 0x0001ffffffff0001ULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
+        { 0x0000000000010000ULL, 0x0000000100000000ULL, },
+        { 0x00000001fffe0000ULL, 0x0001fffe00000001ULL, },
+        { 0x0000ffff00020000ULL, 0xffff00020000ffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*  64  */
+        { 0x001cffbf0000ffffULL, 0x0003000000000000ULL, },
+        { 0x0001000000000000ULL, 0x000100000000fffeULL, },
+        { 0xffffffff0000fffeULL, 0x0000000000000002ULL, },
+        { 0x0000000000010000ULL, 0x0000fffafff3ffffULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x00000000ffff0000ULL, 0x0000000100000002ULL, },
+        { 0x0000000000000001ULL, 0x000000000000fffeULL, },
+        { 0x00000003ffffffffULL, 0x0000fffb00370000ULL, },    /*  72  */
+        { 0x0013ff2e00000002ULL, 0x00020000fffd0000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0000fffd00000003ULL, 0x000000000000ffffULL, },
+        { 0x0000000000020000ULL, 0xfffffff600390000ULL, },
+        { 0xffe6003900010000ULL, 0xfffa0001fffc0000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_S_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
new file mode 100644
index 0000000..0baaff1
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DIV_S.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "DIV_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*   0  */
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },    /*  16  */
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000200000000ULL, 0xffffffff00000002ULL, },
+        { 0xfffffffd00000000ULL, 0x00000001fffffffdULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },    /*  24  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0xfffffffe00000000ULL, 0x00000001fffffffeULL, },
+        { 0x0000000300000000ULL, 0xffffffff00000003ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },    /*  32  */
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000100000000ULL, 0x0000000000000001ULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },
+        { 0xcccccccdcccccccdULL, 0xcccccccdcccccccdULL, },    /*  40  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },
+        { 0x0000000100000000ULL, 0x0000000000000001ULL, },
+        { 0x1c71c71d71c71c72ULL, 0xc71c71c81c71c71dULL, },    /*  48  */
+        { 0x0000000100000001ULL, 0xffffffff00000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000002ULL, 0xffffffff00000000ULL, },
+        { 0x00000000fffffffeULL, 0x0000000100000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xe38e38e48e38e38fULL, 0x38e38e39e38e38e4ULL, },    /*  56  */
+        { 0xffffffffffffffffULL, 0x00000001ffffffffULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x00000000fffffffeULL, 0x0000000100000000ULL, },
+        { 0x0000000000000002ULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*  64  */
+        { 0x0000001c00000000ULL, 0x0000000300000000ULL, },
+        { 0x0000000100000000ULL, 0x0000000100000000ULL, },
+        { 0xffffffff00000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x00000000fffffff2ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000037ULL, },    /*  72  */
+        { 0x0000001300000000ULL, 0x00000002fffffffdULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000002ULL, 0xffffffff00000039ULL, },
+        { 0xffffffe600000001ULL, 0xfffffffafffffffcULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_S_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
new file mode 100644
index 0000000..770544a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DIV_U.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "DIV_U.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0303030303030303ULL, 0x0303030303030303ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0505050505050505ULL, 0x0505050505050505ULL, },
+        { 0x0101040101040101ULL, 0x0401010401010401ULL, },
+        { 0x0902010902010902ULL, 0x0109020109020109ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0303030303030303ULL, 0x0303030303030303ULL, },
+        { 0x0001030001030001ULL, 0x0300010300010300ULL, },
+        { 0x0601000601000601ULL, 0x0006010006010006ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0000010000010000ULL, 0x0100000100000100ULL, },
+        { 0x0300000300000300ULL, 0x0003000003000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0001030001030001ULL, 0x0300010300010300ULL, },
+        { 0x0701010701010701ULL, 0x0107010107010107ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0100000100000100ULL, 0x0001000001000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0100000100000100ULL, 0x0001000001000001ULL, },
+        { 0x0201000201000201ULL, 0x0002010002010002ULL, },
+        { 0x0100000100000100ULL, 0x0001000001000001ULL, },
+        { 0x0402010402010402ULL, 0x0104020104020104ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0801000801000801ULL, 0x0008010008010008ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000010000010000ULL, 0x0100000100000100ULL, },
+        { 0x0001020001020001ULL, 0x0200010200010200ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0002030002030002ULL, 0x0300020300020300ULL, },
+        { 0x0000030000030000ULL, 0x0300000300000300ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*  64  */
+        { 0x0000ff0200000008ULL, 0x040000030c010200ULL, },
+        { 0x0001010100000000ULL, 0x0100000001020400ULL, },
+        { 0x01010a0200020000ULL, 0x0000000001010000ULL, },
+        { 0x0101000001010200ULL, 0x0002110000000015ULL, },
+        { 0x0101ff0101010101ULL, 0x0101010101010101ULL, },
+        { 0x0102000000000100ULL, 0x000100000001020cULL, },
+        { 0x0202000100030000ULL, 0x0001010000000001ULL, },
+        { 0x0100000004020102ULL, 0x0002120200000001ULL, },    /*  72  */
+        { 0x0000ff0102010010ULL, 0x0200010908000000ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0101070201040001ULL, 0x0000010101000000ULL, },
+        { 0x0000000002000201ULL, 0x01020c020000010dULL, },
+        { 0x0000ff0001000109ULL, 0x0700000808010200ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_U_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_U_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
new file mode 100644
index 0000000..9653e7d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DIV_U.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "DIV_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000003ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000005ULL, 0x0000000000000005ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000004ULL, },
+        { 0x0000000000000009ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000003ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000006ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000003ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000007ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000004ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000008ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },    /*  72  */
+        { 0x0000000000000000ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000007ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_U_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
new file mode 100644
index 0000000..3dcd30b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DIV_U.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "DIV_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0003000300030003ULL, 0x0003000300030003ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0005000500050005ULL, 0x0005000500050005ULL, },
+        { 0x0001000400010001ULL, 0x0004000100010004ULL, },
+        { 0x0009000100020009ULL, 0x0001000200090001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0003000300030003ULL, 0x0003000300030003ULL, },
+        { 0x0000000300010000ULL, 0x0003000100000003ULL, },
+        { 0x0006000000010006ULL, 0x0000000100060000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0000000100000000ULL, 0x0001000000000001ULL, },
+        { 0x0003000000000003ULL, 0x0000000000030000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },
+        { 0x0000000300010000ULL, 0x0003000100000003ULL, },
+        { 0x0007000100010007ULL, 0x0001000100070001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000000000001ULL, 0x0000000000010000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0001000000000001ULL, 0x0000000000010000ULL, },
+        { 0x0002000000010002ULL, 0x0000000100020000ULL, },
+        { 0x0001000000000001ULL, 0x0000000000010000ULL, },
+        { 0x0004000100020004ULL, 0x0001000200040001ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0008000000010008ULL, 0x0000000100080000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000100000000ULL, 0x0001000000000001ULL, },
+        { 0x0000000200010000ULL, 0x0002000100000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000300020000ULL, 0x0003000200000003ULL, },
+        { 0x0000000300000000ULL, 0x0003000000000003ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*  64  */
+        { 0x0000025400000000ULL, 0x00030000000b0002ULL, },
+        { 0x0000000100000000ULL, 0x0001000000010004ULL, },
+        { 0x0001000a00000000ULL, 0x0000000000010000ULL, },
+        { 0x0001000000010002ULL, 0x0000001000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0001000000000001ULL, 0x0000000000000002ULL, },
+        { 0x0002000000000000ULL, 0x0000000100000000ULL, },
+        { 0x0001000000040001ULL, 0x0000001100000000ULL, },    /*  72  */
+        { 0x000001c300020000ULL, 0x0002000100080000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0001000700010000ULL, 0x0000000100010000ULL, },
+        { 0x0000000000020002ULL, 0x0001000c00000001ULL, },
+        { 0x0000003900010001ULL, 0x0007000000070002ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_U_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
new file mode 100644
index 0000000..fd395ef
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DIV_U.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "DIV_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000300000003ULL, 0x0000000300000003ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000500000005ULL, 0x0000000500000005ULL, },
+        { 0x0000000100000001ULL, 0x0000000400000001ULL, },
+        { 0x0000000900000002ULL, 0x0000000100000009ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000300000003ULL, 0x0000000300000003ULL, },
+        { 0x0000000000000001ULL, 0x0000000300000000ULL, },
+        { 0x0000000600000001ULL, 0x0000000000000006ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },
+        { 0x0000000300000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },
+        { 0x0000000000000001ULL, 0x0000000300000000ULL, },
+        { 0x0000000700000001ULL, 0x0000000100000007ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000100000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000200000001ULL, 0x0000000000000002ULL, },
+        { 0x0000000100000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000400000002ULL, 0x0000000100000004ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000800000001ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000200000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000002ULL, 0x0000000300000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000300000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x000000030000000bULL, },
+        { 0x0000000000000000ULL, 0x0000000100000001ULL, },
+        { 0x0000000100000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000100000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000100000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000200000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000004ULL, 0x0000000000000000ULL, },    /*  72  */
+        { 0x0000000000000002ULL, 0x0000000200000008ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000100000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000002ULL, 0x0000000100000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000700000007ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DIV_U_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
