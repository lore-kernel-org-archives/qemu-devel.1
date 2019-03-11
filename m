Received: from eggs.gnu.org ([209.51.188.92]:57349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h3LtP-0005aV-PY
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h3LtG-0001j8-MJ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:27:03 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50881 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h3Lst-0001Vo-EK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:26:54 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 11 Mar 2019 15:24:49 +0100
Message-Id: <1552314290-28709-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 6/7] target/mips: Add tests for a variety of MSA
 integer multiply instructions
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

Add tests for a variety of MSA integer multiply instructions.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1551964929-17845-5-git-send-email-mateja.marjanovic@rt-rk.com>
---
 .../user/ase/msa/int-multiply/test_msa_mul_q_h.c   | 151 +++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mul_q_w.c   | 151 +++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mulr_q_h.c  | 151 +++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mulr_q_w.c  | 151 +++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mulv_b.c    | 151 +++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mulv_d.c    | 151 +++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mulv_h.c    | 151 +++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mulv_w.c    | 151 +++++++++++++++++++++
 8 files changed, 1208 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c

diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_h.c
new file mode 100644
index 0000000..f152608
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction MUL_Q.H
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
+    char *instruction_name = "MUL_Q.H";
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
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x38e438e438e438e4ULL, 0x38e438e438e438e4ULL, },
+        { 0xc71cc71cc71cc71cULL, 0xc71cc71cc71cc71cULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x12f6da134bdb12f6ULL, 0xda134bdb12f6da13ULL, },
+        { 0xed0925edb425ed09ULL, 0x25edb425ed0925edULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71cc71cc71cc71cULL, 0xc71cc71cc71cc71cULL, },
+        { 0x38e338e338e338e3ULL, 0x38e338e338e338e3ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x2221222122212221ULL, 0x2221222122212221ULL, },
+        { 0xed0925ecb425ed09ULL, 0x25ecb425ed0925ecULL, },
+        { 0x12f5da124bd912f5ULL, 0xda124bd912f5da12ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x147b147b147b147bULL, 0x147b147b147b147bULL, },
+        { 0xeb84eb84eb84eb84ULL, 0xeb84eb84eb84eb84ULL, },
+        { 0x0b60e93e2d830b60ULL, 0xe93e2d830b60e93eULL, },
+        { 0xf49f16c1d27cf49fULL, 0x16c1d27cf49f16c1ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x2221222122212221ULL, 0x2221222122212221ULL, },
+        { 0xeb84eb84eb84eb84ULL, 0xeb84eb84eb84eb84ULL, },
+        { 0x147a147a147a147aULL, 0x147a147a147a147aULL, },
+        { 0xf49f16c1d27cf49fULL, 0x16c1d27cf49f16c1ULL, },
+        { 0x0b60e93e2d820b60ULL, 0xe93e2d820b60e93eULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x12f6da134bdb12f6ULL, 0xda134bdb12f6da13ULL, },
+        { 0xed0925ecb425ed09ULL, 0x25ecb425ed0925ecULL, },
+        { 0x0b60e93e2d830b60ULL, 0xe93e2d830b60e93eULL, },
+        { 0xf49f16c1d27cf49fULL, 0x16c1d27cf49f16c1ULL, },
+        { 0x0652194865240652ULL, 0x1948652406521948ULL, },
+        { 0xf9ade6b79adcf9adULL, 0xe6b79adcf9ade6b7ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xed0925edb425ed09ULL, 0x25edb425ed0925edULL, },
+        { 0x12f5da124bd912f5ULL, 0xda124bd912f5da12ULL, },
+        { 0xf49f16c1d27cf49fULL, 0x16c1d27cf49f16c1ULL, },
+        { 0x0b60e93e2d820b60ULL, 0xe93e2d820b60e93eULL, },
+        { 0xf9ade6b79adcf9adULL, 0xe6b79adcf9ade6b7ULL, },
+        { 0x0651194965220651ULL, 0x1949652206511949ULL, },
+        { 0x6fb904f60cbd38c7ULL, 0x2c6b0102000431f1ULL, },    /*  64  */
+        { 0x03faffec1879da0eULL, 0x0b2bf9e1ffbfcc2aULL, },
+        { 0x4e261003e9dab268ULL, 0x1778faf00101e8d6ULL, },
+        { 0x9712fb9b1db7ec38ULL, 0xbccff56b01071259ULL, },
+        { 0x03faffec1879da0eULL, 0x0b2bf9e1ffbfcc2aULL, },
+        { 0x002400002f03195aULL, 0x02cf2515038635ccULL, },
+        { 0x02c8ffc1d57533d9ULL, 0x05e71eaef1eb1809ULL, },
+        { 0xfc43001139150d37ULL, 0xef194023f19aecf4ULL, },
+        { 0x4e261003e9dab268ULL, 0x1778faf00101e8d6ULL, },    /*  72  */
+        { 0x02c8ffc1d57533d9ULL, 0x05e71eaef1eb1809ULL, },
+        { 0x36aa33af267d6a08ULL, 0x0c67196238380abdULL, },
+        { 0xb69bf1d4cc591b07ULL, 0xdc7e3510397df77dULL, },
+        { 0x9712fb9b1db7ec38ULL, 0xbccff56b01071259ULL, },
+        { 0xfc43001139150d37ULL, 0xef194023f19aecf4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MUL_Q_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MUL_Q_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_w.c
new file mode 100644
index 0000000..df815ee
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction MUL_Q.W
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
+    char *instruction_name = "MUL_Q.W";
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
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x38e38e3938e38e39ULL, 0x38e38e3938e38e39ULL, },
+        { 0xc71c71c6c71c71c6ULL, 0xc71c71c6c71c71c6ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x12f684be4bda12f7ULL, 0xda12f68512f684beULL, },
+        { 0xed097b42b425ed09ULL, 0x25ed097bed097b42ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c6c71c71c6ULL, 0xc71c71c6c71c71c6ULL, },
+        { 0x38e38e3838e38e38ULL, 0x38e38e3838e38e38ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x2222222122222221ULL, 0x2222222122222221ULL, },
+        { 0xed097b42b425ed09ULL, 0x25ed097aed097b42ULL, },
+        { 0x12f684bd4bda12f5ULL, 0xda12f68412f684bdULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x147ae148147ae148ULL, 0x147ae148147ae148ULL, },
+        { 0xeb851eb8eb851eb8ULL, 0xeb851eb8eb851eb8ULL, },
+        { 0x0b60b60b2d82d82eULL, 0xe93e93e90b60b60bULL, },
+        { 0xf49f49f4d27d27d2ULL, 0x16c16c17f49f49f4ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x2222222122222221ULL, 0x2222222122222221ULL, },
+        { 0xeb851eb8eb851eb8ULL, 0xeb851eb8eb851eb8ULL, },
+        { 0x147ae147147ae147ULL, 0x147ae147147ae147ULL, },
+        { 0xf49f49f4d27d27d2ULL, 0x16c16c16f49f49f4ULL, },
+        { 0x0b60b60b2d82d82dULL, 0xe93e93e90b60b60bULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x12f684be4bda12f7ULL, 0xda12f68512f684beULL, },
+        { 0xed097b42b425ed09ULL, 0x25ed097aed097b42ULL, },
+        { 0x0b60b60b2d82d82eULL, 0xe93e93e90b60b60bULL, },
+        { 0xf49f49f4d27d27d2ULL, 0x16c16c16f49f49f4ULL, },
+        { 0x06522c3f6522c3f3ULL, 0x1948b0fc06522c3fULL, },
+        { 0xf9add3c09add3c0dULL, 0xe6b74f03f9add3c0ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xed097b42b425ed09ULL, 0x25ed097bed097b42ULL, },
+        { 0x12f684bd4bda12f5ULL, 0xda12f68412f684bdULL, },
+        { 0xf49f49f4d27d27d2ULL, 0x16c16c17f49f49f4ULL, },
+        { 0x0b60b60b2d82d82dULL, 0xe93e93e90b60b60bULL, },
+        { 0xf9add3c09add3c0dULL, 0xe6b74f03f9add3c0ULL, },
+        { 0x06522c3f6522c3f1ULL, 0x1948b0fc06522c3fULL, },
+        { 0x6fb7e8890cbdc0d2ULL, 0x2c6b144600049a04ULL, },    /*  64  */
+        { 0x03fa514e1879c701ULL, 0x0b2c6ca9ffbf8ac6ULL, },
+        { 0x4e252086e9daefbfULL, 0x1779189301015a34ULL, },
+        { 0x9713a7171db7f3a5ULL, 0xbccfb4690107236fULL, },
+        { 0x03fa514e1879c701ULL, 0x0b2c6ca9ffbf8ac6ULL, },
+        { 0x002442012f047611ULL, 0x02cf8c140386e68eULL, },
+        { 0x02c84b87d575d121ULL, 0x05e79a8af1eb1c52ULL, },
+        { 0xfc439edc3916c1e4ULL, 0xef19389cf19a0fddULL, },
+        { 0x4e252086e9daefbfULL, 0x1779189301015a34ULL, },    /*  72  */
+        { 0x02c84b87d575d121ULL, 0x05e79a8af1eb1c52ULL, },
+        { 0x36a93aff267d11c3ULL, 0x0c6788643838c14cULL, },
+        { 0xb69baa39cc590fcdULL, 0xdc7e6df7397c58d9ULL, },
+        { 0x9713a7171db7f3a5ULL, 0xbccfb4690107236fULL, },
+        { 0xfc439edc3916c1e4ULL, 0xef19389cf19a0fddULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MUL_Q_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MUL_Q_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_h.c
new file mode 100644
index 0000000..fd0a5fa
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction MULR_Q.H
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
+    char *instruction_name = "MULR_Q.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000010000ULL, 0x0000000100000000ULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x38e438e438e438e4ULL, 0x38e438e438e438e4ULL, },
+        { 0xc71cc71cc71cc71cULL, 0xc71cc71cc71cc71cULL, },
+        { 0x2223222322232223ULL, 0x2223222322232223ULL, },
+        { 0xdddedddedddedddeULL, 0xdddedddedddedddeULL, },
+        { 0x12f7da134bdb12f7ULL, 0xda134bdb12f7da13ULL, },
+        { 0xed0a25eeb425ed0aULL, 0x25eeb425ed0a25eeULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71cc71cc71cc71cULL, 0xc71cc71cc71cc71cULL, },
+        { 0x38e338e338e338e3ULL, 0x38e338e338e338e3ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0xed0925edb426ed09ULL, 0x25edb426ed0925edULL, },
+        { 0x12f6da134bda12f6ULL, 0xda134bda12f6da13ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2223222322232223ULL, 0x2223222322232223ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x147c147c147c147cULL, 0x147c147c147c147cULL, },
+        { 0xeb85eb85eb85eb85ULL, 0xeb85eb85eb85eb85ULL, },
+        { 0x0b61e93e2d840b61ULL, 0xe93e2d840b61e93eULL, },
+        { 0xf49f16c2d27cf49fULL, 0x16c2d27cf49f16c2ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xdddedddedddedddeULL, 0xdddedddedddedddeULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0xeb85eb85eb85eb85ULL, 0xeb85eb85eb85eb85ULL, },
+        { 0x147b147b147b147bULL, 0x147b147b147b147bULL, },
+        { 0xf49f16c1d27df49fULL, 0x16c1d27df49f16c1ULL, },
+        { 0x0b60e93e2d830b60ULL, 0xe93e2d830b60e93eULL, },
+        { 0x0000000000010000ULL, 0x0000000100000000ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x12f7da134bdb12f7ULL, 0xda134bdb12f7da13ULL, },
+        { 0xed0925edb426ed09ULL, 0x25edb426ed0925edULL, },
+        { 0x0b61e93e2d840b61ULL, 0xe93e2d840b61e93eULL, },
+        { 0xf49f16c1d27df49fULL, 0x16c1d27df49f16c1ULL, },
+        { 0x0652194865240652ULL, 0x1948652406521948ULL, },
+        { 0xf9aee6b79addf9aeULL, 0xe6b79addf9aee6b7ULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xed0a25eeb425ed0aULL, 0x25eeb425ed0a25eeULL, },
+        { 0x12f6da134bda12f6ULL, 0xda134bda12f6da13ULL, },
+        { 0xf49f16c2d27cf49fULL, 0x16c2d27cf49f16c2ULL, },
+        { 0x0b60e93e2d830b60ULL, 0xe93e2d830b60e93eULL, },
+        { 0xf9aee6b79addf9aeULL, 0xe6b79addf9aee6b7ULL, },
+        { 0x0652194965230652ULL, 0x1949652306521949ULL, },
+        { 0x6fba04f60cbe38c7ULL, 0x2c6b0102000531f1ULL, },    /*  64  */
+        { 0x03faffed1879da0fULL, 0x0b2cf9e2ffbfcc2aULL, },
+        { 0x4e261004e9dbb269ULL, 0x1779faf00102e8d7ULL, },
+        { 0x9713fb9c1db7ec39ULL, 0xbccff56b01081259ULL, },
+        { 0x03faffed1879da0fULL, 0x0b2cf9e2ffbfcc2aULL, },
+        { 0x002400002f04195bULL, 0x02cf2516038735cdULL, },
+        { 0x02c8ffc1d57633daULL, 0x05e71eaff1eb180aULL, },
+        { 0xfc44001139160d37ULL, 0xef1a4023f19aecf5ULL, },
+        { 0x4e261004e9dbb269ULL, 0x1779faf00102e8d7ULL, },    /*  72  */
+        { 0x02c8ffc1d57633daULL, 0x05e71eaff1eb180aULL, },
+        { 0x36aa33af267e6a09ULL, 0x0c67196338390abeULL, },
+        { 0xb69bf1d4cc591b07ULL, 0xdc7f3511397df77eULL, },
+        { 0x9713fb9c1db7ec39ULL, 0xbccff56b01081259ULL, },
+        { 0xfc44001139160d37ULL, 0xef1a4023f19aecf5ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MULR_Q_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MULR_Q_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_w.c
new file mode 100644
index 0000000..f28b0d0
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction MULR_Q.W
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
+    char *instruction_name = "MULR_Q.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x38e38e3a38e38e3aULL, 0x38e38e3a38e38e3aULL, },
+        { 0xc71c71c7c71c71c7ULL, 0xc71c71c7c71c71c7ULL, },
+        { 0x2222222322222223ULL, 0x2222222322222223ULL, },
+        { 0xdddddddedddddddeULL, 0xdddddddedddddddeULL, },
+        { 0x12f684be4bda12f7ULL, 0xda12f68512f684beULL, },
+        { 0xed097b43b425ed09ULL, 0x25ed097ced097b43ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c7c71c71c7ULL, 0xc71c71c7c71c71c7ULL, },
+        { 0x38e38e3838e38e38ULL, 0x38e38e3838e38e38ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0xed097b42b425ed0aULL, 0x25ed097bed097b42ULL, },
+        { 0x12f684bd4bda12f6ULL, 0xda12f68512f684bdULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2222222322222223ULL, 0x2222222322222223ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x147ae148147ae148ULL, 0x147ae148147ae148ULL, },
+        { 0xeb851eb8eb851eb8ULL, 0xeb851eb8eb851eb8ULL, },
+        { 0x0b60b60c2d82d82eULL, 0xe93e93e90b60b60cULL, },
+        { 0xf49f49f5d27d27d2ULL, 0x16c16c17f49f49f5ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xdddddddedddddddeULL, 0xdddddddedddddddeULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0xeb851eb8eb851eb8ULL, 0xeb851eb8eb851eb8ULL, },
+        { 0x147ae148147ae148ULL, 0x147ae148147ae148ULL, },
+        { 0xf49f49f4d27d27d3ULL, 0x16c16c16f49f49f4ULL, },
+        { 0x0b60b60b2d82d82dULL, 0xe93e93e90b60b60bULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x12f684be4bda12f7ULL, 0xda12f68512f684beULL, },
+        { 0xed097b42b425ed0aULL, 0x25ed097bed097b42ULL, },
+        { 0x0b60b60c2d82d82eULL, 0xe93e93e90b60b60cULL, },
+        { 0xf49f49f4d27d27d3ULL, 0x16c16c16f49f49f4ULL, },
+        { 0x06522c3f6522c3f4ULL, 0x1948b0fc06522c3fULL, },
+        { 0xf9add3c19add3c0dULL, 0xe6b74f04f9add3c1ULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xed097b43b425ed09ULL, 0x25ed097ced097b43ULL, },
+        { 0x12f684bd4bda12f6ULL, 0xda12f68512f684bdULL, },
+        { 0xf49f49f5d27d27d2ULL, 0x16c16c17f49f49f5ULL, },
+        { 0x0b60b60b2d82d82dULL, 0xe93e93e90b60b60bULL, },
+        { 0xf9add3c19add3c0dULL, 0xe6b74f04f9add3c1ULL, },
+        { 0x06522c3f6522c3f2ULL, 0x1948b0fd06522c3fULL, },
+        { 0x6fb7e8890cbdc0d3ULL, 0x2c6b144600049a05ULL, },    /*  64  */
+        { 0x03fa514e1879c702ULL, 0x0b2c6ca9ffbf8ac7ULL, },
+        { 0x4e252087e9daefc0ULL, 0x1779189301015a35ULL, },
+        { 0x9713a7171db7f3a6ULL, 0xbccfb46a0107236fULL, },
+        { 0x03fa514e1879c702ULL, 0x0b2c6ca9ffbf8ac7ULL, },
+        { 0x002442012f047612ULL, 0x02cf8c140386e68fULL, },
+        { 0x02c84b88d575d121ULL, 0x05e79a8bf1eb1c52ULL, },
+        { 0xfc439edd3916c1e4ULL, 0xef19389cf19a0fdeULL, },
+        { 0x4e252087e9daefc0ULL, 0x1779189301015a35ULL, },    /*  72  */
+        { 0x02c84b88d575d121ULL, 0x05e79a8bf1eb1c52ULL, },
+        { 0x36a93aff267d11c4ULL, 0x0c6788643838c14cULL, },
+        { 0xb69baa3acc590fcdULL, 0xdc7e6df7397c58daULL, },
+        { 0x9713a7171db7f3a6ULL, 0xbccfb46a0107236fULL, },
+        { 0xfc439edd3916c1e4ULL, 0xef19389cf19a0fdeULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MULR_Q_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MULR_Q_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
new file mode 100644
index 0000000..6beeda9
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction MULV.B
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
+    char *instruction_name = "MULV.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0xcdcdcdcdcdcdcdcdULL, 0xcdcdcdcdcdcdcdcdULL, },
+        { 0x1d72c81d72c81d72ULL, 0xc81d72c81d72c81dULL, },
+        { 0xe48f39e48f39e48fULL, 0x39e48f39e48f39e4ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe4e4e4e4e4e4e4e4ULL, 0xe4e4e4e4e4e4e4e4ULL, },
+        { 0x7272727272727272ULL, 0x7272727272727272ULL, },
+        { 0x7878787878787878ULL, 0x7878787878787878ULL, },
+        { 0xdedededededededeULL, 0xdedededededededeULL, },
+        { 0xbe4c30be4c30be4cULL, 0x30be4c30be4c30beULL, },
+        { 0x980a26980a26980aULL, 0x26980a26980a2698ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7272727272727272ULL, 0x7272727272727272ULL, },
+        { 0x3939393939393939ULL, 0x3939393939393939ULL, },
+        { 0xbcbcbcbcbcbcbcbcULL, 0xbcbcbcbcbcbcbcbcULL, },
+        { 0xefefefefefefefefULL, 0xefefefefefefefefULL, },
+        { 0x5f26985f26985f26ULL, 0x985f26985f26985fULL, },
+        { 0x4c85134c85134c85ULL, 0x134c85134c85134cULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7878787878787878ULL, 0x7878787878787878ULL, },
+        { 0xbcbcbcbcbcbcbcbcULL, 0xbcbcbcbcbcbcbcbcULL, },
+        { 0x9090909090909090ULL, 0x9090909090909090ULL, },
+        { 0xa4a4a4a4a4a4a4a4ULL, 0xa4a4a4a4a4a4a4a4ULL, },
+        { 0xe428a0e428a0e428ULL, 0xa0e428a0e428a0e4ULL, },
+        { 0x500c94500c94500cULL, 0x94500c94500c9450ULL, },
+        { 0xcdcdcdcdcdcdcdcdULL, 0xcdcdcdcdcdcdcdcdULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xdedededededededeULL, 0xdedededededededeULL, },
+        { 0xefefefefefefefefULL, 0xefefefefefefefefULL, },
+        { 0xa4a4a4a4a4a4a4a4ULL, 0xa4a4a4a4a4a4a4a4ULL, },
+        { 0x2929292929292929ULL, 0x2929292929292929ULL, },
+        { 0x394a28394a28394aULL, 0x28394a28394a2839ULL, },
+        { 0x9483a59483a59483ULL, 0xa59483a59483a594ULL, },
+        { 0x1d72c81d72c81d72ULL, 0xc81d72c81d72c81dULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xbe4c30be4c30be4cULL, 0x30be4c30be4c30beULL, },
+        { 0x5f26985f26985f26ULL, 0x985f26985f26985fULL, },
+        { 0xe428a0e428a0e428ULL, 0xa0e428a0e428a0e4ULL, },
+        { 0x394a28394a28394aULL, 0x28394a28394a2839ULL, },
+        { 0x49c44049c44049c4ULL, 0x4049c44049c44049ULL, },
+        { 0xd4ae88d4ae88d4aeULL, 0x88d4ae88d4ae88d4ULL, },
+        { 0xe48f39e48f39e48fULL, 0x39e48f39e48f39e4ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x980a26980a26980aULL, 0x26980a26980a2698ULL, },
+        { 0x4c85134c85134c85ULL, 0x134c85134c85134cULL, },
+        { 0x500c94500c94500cULL, 0x94500c94500c9450ULL, },
+        { 0x9483a59483a59483ULL, 0xa59483a59483a594ULL, },
+        { 0xd4ae88d4ae88d4aeULL, 0x88d4ae88d4ae88d4ULL, },
+        { 0x10e1b110e1b110e1ULL, 0xb110e1b110e1b110ULL, },
+        { 0x40e4a49040843900ULL, 0xf971798404190090ULL, },    /*  64  */
+        { 0x58ac00e408461300ULL, 0x4661098cd64560d0ULL, },
+        { 0x60445478e83e2700ULL, 0x6de882a2aaa970f0ULL, },
+        { 0x80b6c45cb0c20a80ULL, 0x4ff7d850aeb66080ULL, },
+        { 0x58ac00e408461300ULL, 0x4661098cd64560d0ULL, },
+        { 0x190400492969b140ULL, 0x445199a4b9814410ULL, },
+        { 0xa4cc00bea5dd0d00ULL, 0xbe68a2e60795dab0ULL, },
+        { 0xd0a200c74623ae70ULL, 0xea8758f0dd3e6480ULL, },
+        { 0x60445478e83e2700ULL, 0x6de882a2aaa970f0ULL, },    /*  72  */
+        { 0xa4cc00bea5dd0d00ULL, 0xbe68a2e60795dab0ULL, },
+        { 0x90a444e4b1617900ULL, 0xf140240139395990ULL, },
+        { 0x40c6f422ee9fb600ULL, 0x7b583028e316aa80ULL, },
+        { 0x80b6c45cb0c20a80ULL, 0x4ff7d850aeb66080ULL, },
+        { 0xd0a200c74623ae70ULL, 0xea8758f0dd3e6480ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MULV_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MULV_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
new file mode 100644
index 0000000..3205d4b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction MULV.D
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
+    char *instruction_name = "MULV.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0xcccccccccccccccdULL, 0xcccccccccccccccdULL, },
+        { 0x1c71c71c71c71c72ULL, 0xc71c71c71c71c71dULL, },
+        { 0xe38e38e38e38e38fULL, 0x38e38e38e38e38e4ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x38e38e38e38e38e4ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x7777777777777778ULL, 0x7777777777777778ULL, },
+        { 0xdddddddddddddddeULL, 0xdddddddddddddddeULL, },
+        { 0x12f684bda12f684cULL, 0x2f684bda12f684beULL, },
+        { 0x425ed097b425ed0aULL, 0x25ed097b425ed098ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x8e38e38e38e38e39ULL, 0x8e38e38e38e38e39ULL, },
+        { 0xbbbbbbbbbbbbbbbcULL, 0xbbbbbbbbbbbbbbbcULL, },
+        { 0xeeeeeeeeeeeeeeefULL, 0xeeeeeeeeeeeeeeefULL, },
+        { 0x097b425ed097b426ULL, 0x97b425ed097b425fULL, },
+        { 0xa12f684bda12f685ULL, 0x12f684bda12f684cULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7777777777777778ULL, 0x7777777777777778ULL, },
+        { 0xbbbbbbbbbbbbbbbcULL, 0xbbbbbbbbbbbbbbbcULL, },
+        { 0xf5c28f5c28f5c290ULL, 0xf5c28f5c28f5c290ULL, },
+        { 0x3d70a3d70a3d70a4ULL, 0x3d70a3d70a3d70a4ULL, },
+        { 0x7d27d27d27d27d28ULL, 0x38e38e38e38e38e4ULL, },
+        { 0xb60b60b60b60b60cULL, 0xfa4fa4fa4fa4fa50ULL, },
+        { 0xcccccccccccccccdULL, 0xcccccccccccccccdULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xdddddddddddddddeULL, 0xdddddddddddddddeULL, },
+        { 0xeeeeeeeeeeeeeeefULL, 0xeeeeeeeeeeeeeeefULL, },
+        { 0x3d70a3d70a3d70a4ULL, 0x3d70a3d70a3d70a4ULL, },
+        { 0x8f5c28f5c28f5c29ULL, 0x8f5c28f5c28f5c29ULL, },
+        { 0x9f49f49f49f49f4aULL, 0x8e38e38e38e38e39ULL, },
+        { 0x2d82d82d82d82d83ULL, 0x3e93e93e93e93e94ULL, },
+        { 0x1c71c71c71c71c72ULL, 0xc71c71c71c71c71dULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x12f684bda12f684cULL, 0x2f684bda12f684beULL, },
+        { 0x097b425ed097b426ULL, 0x97b425ed097b425fULL, },
+        { 0x7d27d27d27d27d28ULL, 0x38e38e38e38e38e4ULL, },
+        { 0x9f49f49f49f49f4aULL, 0x8e38e38e38e38e39ULL, },
+        { 0xb0fcd6e9e06522c4ULL, 0x522c3f35ba781949ULL, },
+        { 0x6b74f0329161f9aeULL, 0x74f0329161f9add4ULL, },
+        { 0xe38e38e38e38e38fULL, 0x38e38e38e38e38e4ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x425ed097b425ed0aULL, 0x25ed097b425ed098ULL, },
+        { 0xa12f684bda12f685ULL, 0x12f684bda12f684cULL, },
+        { 0xb60b60b60b60b60cULL, 0xfa4fa4fa4fa4fa50ULL, },
+        { 0x2d82d82d82d82d83ULL, 0x3e93e93e93e93e94ULL, },
+        { 0x6b74f0329161f9aeULL, 0x74f0329161f9add4ULL, },
+        { 0x781948b0fcd6e9e1ULL, 0xc3f35ba781948b10ULL, },
+        { 0xad45be6961639000ULL, 0x3297fdea74988090ULL, },    /*  64  */
+        { 0xefa7a5a0e7176a00ULL, 0xb8110a1f6f1923d0ULL, },
+        { 0x08c6139fc4346000ULL, 0xab209f86581f7cf0ULL, },
+        { 0xfbe1883aee787980ULL, 0x821d25438dd09f80ULL, },
+        { 0xefa7a5a0e7176a00ULL, 0xb8110a1f6f1923d0ULL, },
+        { 0x37ae2b38fded7040ULL, 0x682476774aee6810ULL, },
+        { 0x6acb3d68be6cdc00ULL, 0xafdad2311444e7b0ULL, },
+        { 0xedbf72842143b470ULL, 0x7f8223caefce5580ULL, },
+        { 0x08c6139fc4346000ULL, 0xab209f86581f7cf0ULL, },    /*  72  */
+        { 0x6acb3d68be6cdc00ULL, 0xafdad2311444e7b0ULL, },
+        { 0x8624e5e1e5044000ULL, 0xd98178a63216c990ULL, },
+        { 0x76a5ab8089e38100ULL, 0xa1019a60d4dad480ULL, },
+        { 0xfbe1883aee787980ULL, 0x821d25438dd09f80ULL, },
+        { 0xedbf72842143b470ULL, 0x7f8223caefce5580ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MULV_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MULV_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
new file mode 100644
index 0000000..e7bd985
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction MULV.H
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
+    char *instruction_name = "MULV.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0xcccdcccdcccdcccdULL, 0xcccdcccdcccdcccdULL, },
+        { 0x1c72c71d71c81c72ULL, 0xc71d71c81c72c71dULL, },
+        { 0xe38f38e48e39e38fULL, 0x38e48e39e38f38e4ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x38e438e438e438e4ULL, 0x38e438e438e438e4ULL, },
+        { 0x1c721c721c721c72ULL, 0x1c721c721c721c72ULL, },
+        { 0x7778777877787778ULL, 0x7778777877787778ULL, },
+        { 0xdddedddedddedddeULL, 0xdddedddedddedddeULL, },
+        { 0x684c84bea130684cULL, 0x84bea130684c84beULL, },
+        { 0xed0ad098b426ed0aULL, 0xd098b426ed0ad098ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c721c721c721c72ULL, 0x1c721c721c721c72ULL, },
+        { 0x8e398e398e398e39ULL, 0x8e398e398e398e39ULL, },
+        { 0xbbbcbbbcbbbcbbbcULL, 0xbbbcbbbcbbbcbbbcULL, },
+        { 0xeeefeeefeeefeeefULL, 0xeeefeeefeeefeeefULL, },
+        { 0xb426425fd098b426ULL, 0x425fd098b426425fULL, },
+        { 0xf685684cda13f685ULL, 0x684cda13f685684cULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7778777877787778ULL, 0x7778777877787778ULL, },
+        { 0xbbbcbbbcbbbcbbbcULL, 0xbbbcbbbcbbbcbbbcULL, },
+        { 0xc290c290c290c290ULL, 0xc290c290c290c290ULL, },
+        { 0x70a470a470a470a4ULL, 0x70a470a470a470a4ULL, },
+        { 0x7d2838e4f4a07d28ULL, 0x38e4f4a07d2838e4ULL, },
+        { 0xb60cfa503e94b60cULL, 0xfa503e94b60cfa50ULL, },
+        { 0xcccdcccdcccdcccdULL, 0xcccdcccdcccdcccdULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xdddedddedddedddeULL, 0xdddedddedddedddeULL, },
+        { 0xeeefeeefeeefeeefULL, 0xeeefeeefeeefeeefULL, },
+        { 0x70a470a470a470a4ULL, 0x70a470a470a470a4ULL, },
+        { 0x5c295c295c295c29ULL, 0x5c295c295c295c29ULL, },
+        { 0x9f4a8e397d289f4aULL, 0x8e397d289f4a8e39ULL, },
+        { 0x2d833e944fa52d83ULL, 0x3e944fa52d833e94ULL, },
+        { 0x1c72c71d71c81c72ULL, 0xc71d71c81c72c71dULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x684c84bea130684cULL, 0x84bea130684c84beULL, },
+        { 0xb426425fd098b426ULL, 0x425fd098b426425fULL, },
+        { 0x7d2838e4f4a07d28ULL, 0x38e4f4a07d2838e4ULL, },
+        { 0x9f4a8e397d289f4aULL, 0x8e397d289f4a8e39ULL, },
+        { 0x22c419492c4022c4ULL, 0x19492c4022c41949ULL, },
+        { 0xf9aeadd44588f9aeULL, 0xadd44588f9aeadd4ULL, },
+        { 0xe38f38e48e39e38fULL, 0x38e48e39e38f38e4ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xed0ad098b426ed0aULL, 0xd098b426ed0ad098ULL, },
+        { 0xf685684cda13f685ULL, 0x684cda13f685684cULL, },
+        { 0xb60cfa503e94b60cULL, 0xfa503e94b60cfa50ULL, },
+        { 0x2d833e944fa52d83ULL, 0x3e944fa52d833e94ULL, },
+        { 0xf9aeadd44588f9aeULL, 0xadd44588f9aeadd4ULL, },
+        { 0xe9e18b1048b1e9e1ULL, 0x8b1048b1e9e18b10ULL, },
+        { 0xcbe43290c5849000ULL, 0x837136844f198090ULL, },    /*  64  */
+        { 0x2cac40e4aa466a00ULL, 0xfe61d18cb74523d0ULL, },
+        { 0x2d44eb78793e6000ULL, 0x4fe806a2e7a97cf0ULL, },
+        { 0x78b6f35cb6c27980ULL, 0xb6f78750ceb69f80ULL, },
+        { 0x2cac40e4aa466a00ULL, 0xfe61d18cb74523d0ULL, },
+        { 0x21042649c2697040ULL, 0xaa51fea465816810ULL, },
+        { 0x28cc8bbef4dddc00ULL, 0xa1687ae6a695e7b0ULL, },
+        { 0xcfa29fc7d323b470ULL, 0xe587adf0113e5580ULL, },
+        { 0x2d44eb78793e6000ULL, 0x4fe806a2e7a97cf0ULL, },    /*  72  */
+        { 0x28cc8bbef4dddc00ULL, 0xa1687ae6a695e7b0ULL, },
+        { 0x0fa488e4d5614000ULL, 0x864072017939c990ULL, },
+        { 0x8fc62522929f8100ULL, 0x7a585f288416d480ULL, },
+        { 0x78b6f35cb6c27980ULL, 0xb6f78750ceb69f80ULL, },
+        { 0xcfa29fc7d323b470ULL, 0xe587adf0113e5580ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MULV_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MULV_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
new file mode 100644
index 0000000..9c318b3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction MULV.W
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
+    char *instruction_name = "MULV.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0xcccccccdcccccccdULL, 0xcccccccdcccccccdULL, },
+        { 0x1c71c71d71c71c72ULL, 0xc71c71c81c71c71dULL, },
+        { 0xe38e38e48e38e38fULL, 0x38e38e39e38e38e4ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e4e38e38e4ULL, 0xe38e38e4e38e38e4ULL, },
+        { 0x71c71c7271c71c72ULL, 0x71c71c7271c71c72ULL, },
+        { 0x7777777877777778ULL, 0x7777777877777778ULL, },
+        { 0xdddddddedddddddeULL, 0xdddddddedddddddeULL, },
+        { 0x12f684bea12f684cULL, 0x84bda13012f684beULL, },
+        { 0x425ed098b425ed0aULL, 0xd097b426425ed098ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x71c71c7271c71c72ULL, 0x71c71c7271c71c72ULL, },
+        { 0x38e38e3938e38e39ULL, 0x38e38e3938e38e39ULL, },
+        { 0xbbbbbbbcbbbbbbbcULL, 0xbbbbbbbcbbbbbbbcULL, },
+        { 0xeeeeeeefeeeeeeefULL, 0xeeeeeeefeeeeeeefULL, },
+        { 0x097b425fd097b426ULL, 0x425ed098097b425fULL, },
+        { 0xa12f684cda12f685ULL, 0x684bda13a12f684cULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7777777877777778ULL, 0x7777777877777778ULL, },
+        { 0xbbbbbbbcbbbbbbbcULL, 0xbbbbbbbcbbbbbbbcULL, },
+        { 0x28f5c29028f5c290ULL, 0x28f5c29028f5c290ULL, },
+        { 0x0a3d70a40a3d70a4ULL, 0x0a3d70a40a3d70a4ULL, },
+        { 0xe38e38e427d27d28ULL, 0x9f49f4a0e38e38e4ULL, },
+        { 0x4fa4fa500b60b60cULL, 0x93e93e944fa4fa50ULL, },
+        { 0xcccccccdcccccccdULL, 0xcccccccdcccccccdULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xdddddddedddddddeULL, 0xdddddddedddddddeULL, },
+        { 0xeeeeeeefeeeeeeefULL, 0xeeeeeeefeeeeeeefULL, },
+        { 0x0a3d70a40a3d70a4ULL, 0x0a3d70a40a3d70a4ULL, },
+        { 0xc28f5c29c28f5c29ULL, 0xc28f5c29c28f5c29ULL, },
+        { 0x38e38e3949f49f4aULL, 0x27d27d2838e38e39ULL, },
+        { 0x93e93e9482d82d83ULL, 0xa4fa4fa593e93e94ULL, },
+        { 0x1c71c71d71c71c72ULL, 0xc71c71c81c71c71dULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x12f684bea12f684cULL, 0x84bda13012f684beULL, },
+        { 0x097b425fd097b426ULL, 0x425ed098097b425fULL, },
+        { 0xe38e38e427d27d28ULL, 0x9f49f4a0e38e38e4ULL, },
+        { 0x38e38e3949f49f4aULL, 0x27d27d2838e38e39ULL, },
+        { 0xba781949e06522c4ULL, 0x06522c40ba781949ULL, },
+        { 0x61f9add49161f9aeULL, 0xc0ca458861f9add4ULL, },
+        { 0xe38e38e48e38e38fULL, 0x38e38e39e38e38e4ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x425ed098b425ed0aULL, 0xd097b426425ed098ULL, },
+        { 0xa12f684cda12f685ULL, 0x684bda13a12f684cULL, },
+        { 0x4fa4fa500b60b60cULL, 0x93e93e944fa4fa50ULL, },
+        { 0x93e93e9482d82d83ULL, 0xa4fa4fa593e93e94ULL, },
+        { 0x61f9add49161f9aeULL, 0xc0ca458861f9add4ULL, },
+        { 0x81948b10fcd6e9e1ULL, 0x781948b181948b10ULL, },
+        { 0xb103329061639000ULL, 0x3a25368474988090ULL, },    /*  64  */
+        { 0x10bf40e4e7176a00ULL, 0x8176d18c6f1923d0ULL, },
+        { 0x7393eb78c4346000ULL, 0xb7bf06a2581f7cf0ULL, },
+        { 0xb0f0f35cee787980ULL, 0xd67987508dd09f80ULL, },
+        { 0x10bf40e4e7176a00ULL, 0x8176d18c6f1923d0ULL, },
+        { 0xb4f42649fded7040ULL, 0x3ceafea44aee6810ULL, },
+        { 0xf73d8bbebe6cdc00ULL, 0x53697ae61444e7b0ULL, },
+        { 0x7abb9fc72143b470ULL, 0x11e5adf0efce5580ULL, },
+        { 0x7393eb78c4346000ULL, 0xb7bf06a2581f7cf0ULL, },    /*  72  */
+        { 0xf73d8bbebe6cdc00ULL, 0x53697ae61444e7b0ULL, },
+        { 0xb6b388e4e5044000ULL, 0x1aff72013216c990ULL, },
+        { 0xe8bf252289e38100ULL, 0x91ae5f28d4dad480ULL, },
+        { 0xb0f0f35cee787980ULL, 0xd67987508dd09f80ULL, },
+        { 0x7abb9fc72143b470ULL, 0x11e5adf0efce5580ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MULV_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MULV_W(b128_random[i], b128_random[j],
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
