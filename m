Received: from eggs.gnu.org ([209.51.188.92]:48632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtwGF-00054Y-0H
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtwG5-0000ZX-Cv
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:15:41 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52986 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gtwG4-0000MR-CG
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:15:33 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 13 Feb 2019 16:14:55 +0100
Message-Id: <1550070897-5013-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550070897-5013-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550070897-5013-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 5/7] tests/tcg: target/mips: Add tests for
 MSA bit counting instructions
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

Add tests for MSA bit counting instructions. Each test consists of 80
test cases, so altogether there are 960 test cases.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .../user/ase/msa/bit-counting/test_msa_nloc_b.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nloc_d.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nloc_h.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nloc_w.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nlzc_b.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nlzc_d.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nlzc_h.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nlzc_w.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_pcnt_b.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_pcnt_d.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_pcnt_h.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_pcnt_w.c    | 144 +++++++++++++++++++++
 12 files changed, 1728 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c

diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c
new file mode 100644
index 0000000..eb46290
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MSA instruction NLOC.B
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
+#include "../../../include/wrappers_msa.h"
+#include "../../../include/test_inputs.h"
+#include "../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "NLOC.B";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0808080808080808ULL, 0x0808080808080808ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0301000301000301ULL, 0x0003010003010003ULL, },
+        { 0x0000020000020000ULL, 0x0200000200000200ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0500000103050000ULL, 0x0103050000010305ULL, },
+        { 0x0002040000000204ULL, 0x0000000204000000ULL, },
+        { 0x0600020600020600ULL, 0x0206000206000206ULL, },
+        { 0x0004000004000004ULL, 0x0000040000040000ULL, },
+        { 0x0700050003000107ULL, 0x0005000300010700ULL, },
+        { 0x0006000400020000ULL, 0x0600040002000006ULL, },
+        { 0x0800080008000800ULL, 0x0800080008000800ULL, },    /*  16  */
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0801000300050007ULL, 0x0008010003000500ULL, },
+        { 0x0000020004000600ULL, 0x0800000200040006ULL, },
+        { 0x0802000600080200ULL, 0x0600080200060008ULL, },
+        { 0x0000040008000004ULL, 0x0008000004000800ULL, },
+        { 0x0803000801000700ULL, 0x0005000803000801ULL, },
+        { 0x0000060000040008ULL, 0x0200080000060000ULL, },
+        { 0x0804000804000804ULL, 0x0008040008040008ULL, },    /*  24  */
+        { 0x0000080000080000ULL, 0x0800000800000800ULL, },
+        { 0x0805000007000008ULL, 0x0100080300080500ULL, },
+        { 0x0000080200080400ULL, 0x0006000008000008ULL, },
+        { 0x0806000008020008ULL, 0x0600000802000806ULL, },
+        { 0x0000080400000800ULL, 0x0008040000080000ULL, },
+        { 0x0807000008050000ULL, 0x0803000008010008ULL, },
+        { 0x0000080600000804ULL, 0x0000080200000800ULL, },
+        { 0x0808000008080000ULL, 0x0808000008080000ULL, },    /*  32  */
+        { 0x0000080800000808ULL, 0x0000080800000808ULL, },
+        { 0x0808010000080300ULL, 0x0008050000080700ULL, },
+        { 0x0000000802000008ULL, 0x0400000806000008ULL, },
+        { 0x0808020000080600ULL, 0x0008080200000806ULL, },
+        { 0x0000000804000008ULL, 0x0800000008040000ULL, },
+        { 0x0808030000080801ULL, 0x0000080700000008ULL, },
+        { 0x0000000806000000ULL, 0x0804000008080200ULL, },
+        { 0x0808040000080804ULL, 0x0000080804000008ULL, },    /*  40  */
+        { 0x0000000808000000ULL, 0x0808000000080800ULL, },
+        { 0x0808050000000807ULL, 0x0000000808010000ULL, },
+        { 0x0000000808020000ULL, 0x0808040000000806ULL, },
+        { 0x0808060000000808ULL, 0x0200000808060000ULL, },
+        { 0x0000000808040000ULL, 0x0008080000000808ULL, },
+        { 0x0808070000000808ULL, 0x0500000008080300ULL, },
+        { 0x0000000808060000ULL, 0x0008080400000008ULL, },
+        { 0x0808080000000808ULL, 0x0800000008080800ULL, },    /*  48  */
+        { 0x0000000808080000ULL, 0x0008080800000008ULL, },
+        { 0x0808080100000008ULL, 0x0803000000080805ULL, },
+        { 0x0000000008080200ULL, 0x0000080804000000ULL, },
+        { 0x0808080200000008ULL, 0x0806000000080808ULL, },
+        { 0x0000000008080400ULL, 0x0000080808000000ULL, },
+        { 0x0808080300000008ULL, 0x0808010000000808ULL, },
+        { 0x0000000008080600ULL, 0x0000000808040000ULL, },
+        { 0x0808080400000008ULL, 0x0808040000000808ULL, },    /*  56  */
+        { 0x0000000008080800ULL, 0x0000000808080000ULL, },
+        { 0x0808080500000000ULL, 0x0808070000000008ULL, },
+        { 0x0000000008080802ULL, 0x0000000808080400ULL, },
+        { 0x0808080600000000ULL, 0x0808080200000008ULL, },
+        { 0x0000000008080804ULL, 0x0000000008080800ULL, },
+        { 0x0808080700000000ULL, 0x0808080500000000ULL, },
+        { 0x0000000008080806ULL, 0x0000000008080804ULL, },
+        { 0x0100030200000000ULL, 0x0000000007000100ULL, },    /*  64  */
+        { 0x0501000000010200ULL, 0x0004010000000006ULL, },
+        { 0x0100010101020101ULL, 0x0002020801000000ULL, },
+        { 0x0000000000000300ULL, 0x0104010201000301ULL, },
+        { 0x0101000000010000ULL, 0x0100000102020001ULL, },
+        { 0x0200010108000005ULL, 0x0000000007010000ULL, },
+        { 0x0100000000020100ULL, 0x0100000001040100ULL, },
+        { 0x0601000401010101ULL, 0x0106000000000001ULL, },
+        { 0x0000000200010300ULL, 0x0300030001010000ULL, },    /*  72  */
+        { 0x0100020000020302ULL, 0x0100010101030100ULL, },
+        { 0x0103040402020200ULL, 0x0102000000000000ULL, },
+        { 0x0101040400010001ULL, 0x0201030000010103ULL, },
+        { 0x0300000301000300ULL, 0x0100010200000200ULL, },
+        { 0x0100000600000001ULL, 0x0401000100000000ULL, },
+        { 0x0000000000010401ULL, 0x0300010402000000ULL, },
+        { 0x0100010104000201ULL, 0x0200020200000003ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_NLOC_B(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_NLOC_B(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c
new file mode 100644
index 0000000..bb1c0cf
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MSA instruction NLOC.D
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
+#include "../../../include/wrappers_msa.h"
+#include "../../../include/test_inputs.h"
+#include "../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "NLOC.D";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000040ULL, 0x0000000000000040ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000003ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000004ULL, 0x0000000000000004ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000005ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000006ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000007ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000006ULL, },
+        { 0x0000000000000008ULL, 0x0000000000000008ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000009ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000008ULL, },
+        { 0x000000000000000aULL, 0x0000000000000006ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000000bULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000002ULL, },
+        { 0x000000000000000cULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000008ULL, },
+        { 0x000000000000000dULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000000eULL, 0x0000000000000006ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000000fULL, 0x000000000000000bULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000010ULL, 0x0000000000000010ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000011ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000004ULL, },
+        { 0x0000000000000012ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000013ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x000000000000000cULL, },
+        { 0x0000000000000014ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000010ULL, },
+        { 0x0000000000000015ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000014ULL, },
+        { 0x0000000000000016ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000017ULL, 0x0000000000000005ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000018ULL, 0x0000000000000008ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000019ULL, 0x000000000000000bULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000001aULL, 0x000000000000000eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000001bULL, 0x0000000000000011ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000001cULL, 0x0000000000000014ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000001dULL, 0x0000000000000017ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000001eULL, 0x000000000000001aULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000001fULL, 0x000000000000001dULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x0000000000000005ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000006ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000003ULL, },    /*  72  */
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000003ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000004ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000002ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_NLOC_D(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_NLOC_D(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c
new file mode 100644
index 0000000..da1cd83
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MSA instruction NLOC.H
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
+#include "../../../include/wrappers_msa.h"
+#include "../../../include/test_inputs.h"
+#include "../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "NLOC.H";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0010001000100010ULL, 0x0010001000100010ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0003000000010003ULL, 0x0000000100030000ULL, },
+        { 0x0000000200000000ULL, 0x0002000000000002ULL, },
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0005000000030000ULL, 0x0001000500000003ULL, },
+        { 0x0000000400000002ULL, 0x0000000000040000ULL, },
+        { 0x0006000200000006ULL, 0x0002000000060002ULL, },
+        { 0x0000000000040000ULL, 0x0000000400000000ULL, },
+        { 0x0007000500030001ULL, 0x0000000000000007ULL, },
+        { 0x0000000000000000ULL, 0x0006000400020000ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0009000000000000ULL, 0x0000000100030005ULL, },
+        { 0x0000000200040006ULL, 0x0008000000000000ULL, },
+        { 0x000a000000000002ULL, 0x0006000a00000000ULL, },
+        { 0x0000000400080000ULL, 0x0000000000040008ULL, },
+        { 0x000b000000010007ULL, 0x0000000000030009ULL, },
+        { 0x0000000600000000ULL, 0x0002000800000000ULL, },
+        { 0x000c00000004000cULL, 0x00000004000c0000ULL, },    /*  24  */
+        { 0x0000000800000000ULL, 0x0008000000000008ULL, },
+        { 0x000d000000070000ULL, 0x0001000b00000005ULL, },
+        { 0x0000000a00000004ULL, 0x0000000000080000ULL, },
+        { 0x000e0000000a0000ULL, 0x000600000002000eULL, },
+        { 0x0000000c00000008ULL, 0x0000000400000000ULL, },
+        { 0x000f0000000d0000ULL, 0x000b000000090000ULL, },
+        { 0x0000000e0000000cULL, 0x0000000a00000008ULL, },
+        { 0x0010000000100000ULL, 0x0010000000100000ULL, },    /*  32  */
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },
+        { 0x0010000100000003ULL, 0x0000000500000007ULL, },
+        { 0x0000000000020000ULL, 0x0004000000060000ULL, },
+        { 0x0010000200000006ULL, 0x0000000a0000000eULL, },
+        { 0x0000000000040000ULL, 0x00080000000c0000ULL, },
+        { 0x0010000300000009ULL, 0x0000000f00000000ULL, },
+        { 0x0000000000060000ULL, 0x000c000000100002ULL, },
+        { 0x001000040000000cULL, 0x0000001000040000ULL, },    /*  40  */
+        { 0x0000000000080000ULL, 0x0010000000000008ULL, },
+        { 0x001000050000000fULL, 0x0000000000090000ULL, },
+        { 0x00000000000a0000ULL, 0x001000040000000eULL, },
+        { 0x0010000600000010ULL, 0x00020000000e0000ULL, },
+        { 0x00000000000c0000ULL, 0x0000000800000010ULL, },
+        { 0x0010000700000010ULL, 0x0005000000100003ULL, },
+        { 0x00000000000e0000ULL, 0x0000000c00000000ULL, },
+        { 0x0010000800000010ULL, 0x0008000000100008ULL, },    /*  48  */
+        { 0x0000000000100000ULL, 0x0000001000000000ULL, },
+        { 0x0010000900000000ULL, 0x000b00000000000dULL, },
+        { 0x0000000000100002ULL, 0x0000001000040000ULL, },
+        { 0x0010000a00000000ULL, 0x000e000000000010ULL, },
+        { 0x0000000000100004ULL, 0x0000001000080000ULL, },
+        { 0x0010000b00000000ULL, 0x0010000100000010ULL, },
+        { 0x0000000000100006ULL, 0x00000000000c0000ULL, },
+        { 0x0010000c00000000ULL, 0x0010000400000010ULL, },    /*  56  */
+        { 0x0000000000100008ULL, 0x0000000000100000ULL, },
+        { 0x0010000d00000000ULL, 0x0010000700000000ULL, },
+        { 0x000000000010000aULL, 0x0000000000100004ULL, },
+        { 0x0010000e00000000ULL, 0x0010000a00000000ULL, },
+        { 0x000000000010000cULL, 0x0000000000100008ULL, },
+        { 0x0010000f00000000ULL, 0x0010000d00000000ULL, },
+        { 0x000000000010000eULL, 0x000000000010000cULL, },
+        { 0x0001000300000000ULL, 0x0000000000070001ULL, },    /*  64  */
+        { 0x0005000000000002ULL, 0x0000000100000000ULL, },
+        { 0x0001000100010001ULL, 0x0000000200010000ULL, },
+        { 0x0000000000000003ULL, 0x0001000100010003ULL, },
+        { 0x0001000000000000ULL, 0x0001000000020000ULL, },
+        { 0x0002000100080000ULL, 0x0000000000070000ULL, },
+        { 0x0001000000000001ULL, 0x0001000000010001ULL, },
+        { 0x0006000000010001ULL, 0x0001000000000000ULL, },
+        { 0x0000000000000003ULL, 0x0003000300010000ULL, },    /*  72  */
+        { 0x0001000200000003ULL, 0x0001000100010001ULL, },
+        { 0x0001000400020002ULL, 0x0001000000000000ULL, },
+        { 0x0001000400000000ULL, 0x0002000300000001ULL, },
+        { 0x0003000000010003ULL, 0x0001000100000002ULL, },
+        { 0x0001000000000000ULL, 0x0004000000000000ULL, },
+        { 0x0000000000000004ULL, 0x0003000100020000ULL, },
+        { 0x0001000100040002ULL, 0x0002000200000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_NLOC_H(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_NLOC_H(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c
new file mode 100644
index 0000000..a059763
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MSA instruction NLOC.W
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
+#include "../../../include/wrappers_msa.h"
+#include "../../../include/test_inputs.h"
+#include "../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "NLOC.W";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000002000000020ULL, 0x0000002000000020ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000300000001ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000200000000ULL, },
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000500000003ULL, 0x0000000100000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000004ULL, },
+        { 0x0000000600000000ULL, 0x0000000200000006ULL, },
+        { 0x0000000000000004ULL, 0x0000000000000000ULL, },
+        { 0x0000000700000003ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000600000002ULL, },
+        { 0x0000000800000008ULL, 0x0000000800000008ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000900000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000004ULL, 0x0000000800000000ULL, },
+        { 0x0000000a00000000ULL, 0x0000000600000000ULL, },
+        { 0x0000000000000008ULL, 0x0000000000000004ULL, },
+        { 0x0000000b00000001ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000200000000ULL, },
+        { 0x0000000c00000004ULL, 0x000000000000000cULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000800000000ULL, },
+        { 0x0000000d00000007ULL, 0x0000000100000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000008ULL, },
+        { 0x0000000e0000000aULL, 0x0000000600000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000f0000000dULL, 0x0000000b00000009ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000001100000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000002ULL, 0x0000000400000006ULL, },
+        { 0x0000001200000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000004ULL, 0x000000080000000cULL, },
+        { 0x0000001300000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000006ULL, 0x0000000c00000012ULL, },
+        { 0x0000001400000000ULL, 0x0000000000000004ULL, },    /*  40  */
+        { 0x0000000000000008ULL, 0x0000001000000000ULL, },
+        { 0x0000001500000000ULL, 0x0000000000000009ULL, },
+        { 0x000000000000000aULL, 0x0000001400000000ULL, },
+        { 0x0000001600000000ULL, 0x000000020000000eULL, },
+        { 0x000000000000000cULL, 0x0000000000000000ULL, },
+        { 0x0000001700000000ULL, 0x0000000500000013ULL, },
+        { 0x000000000000000eULL, 0x0000000000000000ULL, },
+        { 0x0000001800000000ULL, 0x0000000800000018ULL, },    /*  48  */
+        { 0x0000000000000010ULL, 0x0000000000000000ULL, },
+        { 0x0000001900000000ULL, 0x0000000b00000000ULL, },
+        { 0x0000000000000012ULL, 0x0000000000000004ULL, },
+        { 0x0000001a00000000ULL, 0x0000000e00000000ULL, },
+        { 0x0000000000000014ULL, 0x0000000000000008ULL, },
+        { 0x0000001b00000000ULL, 0x0000001100000000ULL, },
+        { 0x0000000000000016ULL, 0x000000000000000cULL, },
+        { 0x0000001c00000000ULL, 0x0000001400000000ULL, },    /*  56  */
+        { 0x0000000000000018ULL, 0x0000000000000010ULL, },
+        { 0x0000001d00000000ULL, 0x0000001700000000ULL, },
+        { 0x000000000000001aULL, 0x0000000000000014ULL, },
+        { 0x0000001e00000000ULL, 0x0000001a00000000ULL, },
+        { 0x000000000000001cULL, 0x0000000000000018ULL, },
+        { 0x0000001f00000000ULL, 0x0000001d00000000ULL, },
+        { 0x000000000000001eULL, 0x000000000000001cULL, },
+        { 0x0000000100000000ULL, 0x0000000000000007ULL, },    /*  64  */
+        { 0x0000000500000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000100000001ULL, },
+        { 0x0000000100000000ULL, 0x0000000100000002ULL, },
+        { 0x0000000200000008ULL, 0x0000000000000007ULL, },
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },
+        { 0x0000000600000001ULL, 0x0000000100000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000300000001ULL, },    /*  72  */
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },
+        { 0x0000000100000002ULL, 0x0000000100000000ULL, },
+        { 0x0000000100000000ULL, 0x0000000200000000ULL, },
+        { 0x0000000300000001ULL, 0x0000000100000000ULL, },
+        { 0x0000000100000000ULL, 0x0000000400000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000300000002ULL, },
+        { 0x0000000100000004ULL, 0x0000000200000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_NLOC_W(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_NLOC_W(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c
new file mode 100644
index 0000000..9616d6e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MSA instruction NLZC.B
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
+#include "../../../include/wrappers_msa.h"
+#include "../../../include/test_inputs.h"
+#include "../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "NLZC.B";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0808080808080808ULL, 0x0808080808080808ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },
+        { 0x0000020000020000ULL, 0x0200000200000200ULL, },
+        { 0x0301000301000301ULL, 0x0003010003010003ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0002040000000204ULL, 0x0000000204000000ULL, },
+        { 0x0500000103050000ULL, 0x0103050000010305ULL, },
+        { 0x0004000004000004ULL, 0x0000040000040000ULL, },
+        { 0x0600020600020600ULL, 0x0206000206000206ULL, },
+        { 0x0006000400020000ULL, 0x0600040002000006ULL, },
+        { 0x0700050003000107ULL, 0x0005000300010700ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },    /*  16  */
+        { 0x0800080008000800ULL, 0x0800080008000800ULL, },
+        { 0x0000020004000600ULL, 0x0800000200040006ULL, },
+        { 0x0801000300050007ULL, 0x0008010003000500ULL, },
+        { 0x0000040008000004ULL, 0x0008000004000800ULL, },
+        { 0x0802000600080200ULL, 0x0600080200060008ULL, },
+        { 0x0000060000040008ULL, 0x0200080000060000ULL, },
+        { 0x0803000801000700ULL, 0x0005000803000801ULL, },
+        { 0x0000080000080000ULL, 0x0800000800000800ULL, },    /*  24  */
+        { 0x0804000804000804ULL, 0x0008040008040008ULL, },
+        { 0x0000080200080400ULL, 0x0006000008000008ULL, },
+        { 0x0805000007000008ULL, 0x0100080300080500ULL, },
+        { 0x0000080400000800ULL, 0x0008040000080000ULL, },
+        { 0x0806000008020008ULL, 0x0600000802000806ULL, },
+        { 0x0000080600000804ULL, 0x0000080200000800ULL, },
+        { 0x0807000008050000ULL, 0x0803000008010008ULL, },
+        { 0x0000080800000808ULL, 0x0000080800000808ULL, },    /*  32  */
+        { 0x0808000008080000ULL, 0x0808000008080000ULL, },
+        { 0x0000000802000008ULL, 0x0400000806000008ULL, },
+        { 0x0808010000080300ULL, 0x0008050000080700ULL, },
+        { 0x0000000804000008ULL, 0x0800000008040000ULL, },
+        { 0x0808020000080600ULL, 0x0008080200000806ULL, },
+        { 0x0000000806000000ULL, 0x0804000008080200ULL, },
+        { 0x0808030000080801ULL, 0x0000080700000008ULL, },
+        { 0x0000000808000000ULL, 0x0808000000080800ULL, },    /*  40  */
+        { 0x0808040000080804ULL, 0x0000080804000008ULL, },
+        { 0x0000000808020000ULL, 0x0808040000000806ULL, },
+        { 0x0808050000000807ULL, 0x0000000808010000ULL, },
+        { 0x0000000808040000ULL, 0x0008080000000808ULL, },
+        { 0x0808060000000808ULL, 0x0200000808060000ULL, },
+        { 0x0000000808060000ULL, 0x0008080400000008ULL, },
+        { 0x0808070000000808ULL, 0x0500000008080300ULL, },
+        { 0x0000000808080000ULL, 0x0008080800000008ULL, },    /*  48  */
+        { 0x0808080000000808ULL, 0x0800000008080800ULL, },
+        { 0x0000000008080200ULL, 0x0000080804000000ULL, },
+        { 0x0808080100000008ULL, 0x0803000000080805ULL, },
+        { 0x0000000008080400ULL, 0x0000080808000000ULL, },
+        { 0x0808080200000008ULL, 0x0806000000080808ULL, },
+        { 0x0000000008080600ULL, 0x0000000808040000ULL, },
+        { 0x0808080300000008ULL, 0x0808010000000808ULL, },
+        { 0x0000000008080800ULL, 0x0000000808080000ULL, },    /*  56  */
+        { 0x0808080400000008ULL, 0x0808040000000808ULL, },
+        { 0x0000000008080802ULL, 0x0000000808080400ULL, },
+        { 0x0808080500000000ULL, 0x0808070000000008ULL, },
+        { 0x0000000008080804ULL, 0x0000000008080800ULL, },
+        { 0x0808080600000000ULL, 0x0808080200000008ULL, },
+        { 0x0000000008080806ULL, 0x0000000008080804ULL, },
+        { 0x0808080700000000ULL, 0x0808080500000000ULL, },
+        { 0x0001000002010101ULL, 0x0101040100010004ULL, },    /*  64  */
+        { 0x0000080101000004ULL, 0x0300000303020100ULL, },
+        { 0x0001000000000000ULL, 0x0200000000020203ULL, },
+        { 0x0101030101020001ULL, 0x0000000000010000ULL, },
+        { 0x0000010101000101ULL, 0x0002010000000100ULL, },
+        { 0x0002000000040200ULL, 0x0304010100000201ULL, },
+        { 0x0002010501000001ULL, 0x0002040200000001ULL, },
+        { 0x0000020000000000ULL, 0x0000010203010100ULL, },
+        { 0x0203040001000001ULL, 0x0001000200000201ULL, },    /*  72  */
+        { 0x0001000301000000ULL, 0x0002000000000001ULL, },
+        { 0x0000000000000003ULL, 0x0000010101040103ULL, },
+        { 0x0000000002000100ULL, 0x0000000101000000ULL, },
+        { 0x0003020000010004ULL, 0x0001000001010003ULL, },
+        { 0x0001020003020100ULL, 0x0000020001040201ULL, },
+        { 0x0102010102000000ULL, 0x0001000000030201ULL, },
+        { 0x0001000000010000ULL, 0x0001000001010300ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_NLZC_B(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_NLZC_B(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c
new file mode 100644
index 0000000..801c4bc
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MSA instruction NLZC.D
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
+#include "../../../include/wrappers_msa.h"
+#include "../../../include/test_inputs.h"
+#include "../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "NLZC.D";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000040ULL, 0x0000000000000040ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000003ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000005ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000006ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000006ULL, },
+        { 0x0000000000000007ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000009ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000000aULL, 0x0000000000000006ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000002ULL, },
+        { 0x000000000000000bULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000008ULL, },    /*  24  */
+        { 0x000000000000000cULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000000dULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000000eULL, 0x0000000000000006ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000000fULL, 0x000000000000000bULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0x0000000000000010ULL, 0x0000000000000010ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000004ULL, },
+        { 0x0000000000000011ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000012ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x000000000000000cULL, },
+        { 0x0000000000000013ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000010ULL, },    /*  40  */
+        { 0x0000000000000014ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000014ULL, },
+        { 0x0000000000000015ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000016ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000017ULL, 0x0000000000000005ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0x0000000000000018ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000019ULL, 0x000000000000000bULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000001aULL, 0x000000000000000eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000001bULL, 0x0000000000000011ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x000000000000001cULL, 0x0000000000000014ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000001dULL, 0x0000000000000017ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000001eULL, 0x000000000000001aULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000001fULL, 0x000000000000001dULL, },
+        { 0x0000000000000000ULL, 0x0000000000000001ULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000000ULL, },    /*  72  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_NLZC_D(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_NLZC_D(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c
new file mode 100644
index 0000000..03cb4cd
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MSA instruction NLZC.H
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
+#include "../../../include/wrappers_msa.h"
+#include "../../../include/test_inputs.h"
+#include "../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "NLZC.H";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0010001000100010ULL, 0x0010001000100010ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },
+        { 0x0000000200000000ULL, 0x0002000000000002ULL, },
+        { 0x0003000000010003ULL, 0x0000000100030000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },
+        { 0x0000000400000002ULL, 0x0000000000040000ULL, },
+        { 0x0005000000030000ULL, 0x0001000500000003ULL, },
+        { 0x0000000000040000ULL, 0x0000000400000000ULL, },
+        { 0x0006000200000006ULL, 0x0002000000060002ULL, },
+        { 0x0000000000000000ULL, 0x0006000400020000ULL, },
+        { 0x0007000500030001ULL, 0x0000000000000007ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0000000200040006ULL, 0x0008000000000000ULL, },
+        { 0x0009000000000000ULL, 0x0000000100030005ULL, },
+        { 0x0000000400080000ULL, 0x0000000000040008ULL, },
+        { 0x000a000000000002ULL, 0x0006000a00000000ULL, },
+        { 0x0000000600000000ULL, 0x0002000800000000ULL, },
+        { 0x000b000000010007ULL, 0x0000000000030009ULL, },
+        { 0x0000000800000000ULL, 0x0008000000000008ULL, },    /*  24  */
+        { 0x000c00000004000cULL, 0x00000004000c0000ULL, },
+        { 0x0000000a00000004ULL, 0x0000000000080000ULL, },
+        { 0x000d000000070000ULL, 0x0001000b00000005ULL, },
+        { 0x0000000c00000008ULL, 0x0000000400000000ULL, },
+        { 0x000e0000000a0000ULL, 0x000600000002000eULL, },
+        { 0x0000000e0000000cULL, 0x0000000a00000008ULL, },
+        { 0x000f0000000d0000ULL, 0x000b000000090000ULL, },
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },    /*  32  */
+        { 0x0010000000100000ULL, 0x0010000000100000ULL, },
+        { 0x0000000000020000ULL, 0x0004000000060000ULL, },
+        { 0x0010000100000003ULL, 0x0000000500000007ULL, },
+        { 0x0000000000040000ULL, 0x00080000000c0000ULL, },
+        { 0x0010000200000006ULL, 0x0000000a0000000eULL, },
+        { 0x0000000000060000ULL, 0x000c000000100002ULL, },
+        { 0x0010000300000009ULL, 0x0000000f00000000ULL, },
+        { 0x0000000000080000ULL, 0x0010000000000008ULL, },    /*  40  */
+        { 0x001000040000000cULL, 0x0000001000040000ULL, },
+        { 0x00000000000a0000ULL, 0x001000040000000eULL, },
+        { 0x001000050000000fULL, 0x0000000000090000ULL, },
+        { 0x00000000000c0000ULL, 0x0000000800000010ULL, },
+        { 0x0010000600000010ULL, 0x00020000000e0000ULL, },
+        { 0x00000000000e0000ULL, 0x0000000c00000000ULL, },
+        { 0x0010000700000010ULL, 0x0005000000100003ULL, },
+        { 0x0000000000100000ULL, 0x0000001000000000ULL, },    /*  48  */
+        { 0x0010000800000010ULL, 0x0008000000100008ULL, },
+        { 0x0000000000100002ULL, 0x0000001000040000ULL, },
+        { 0x0010000900000000ULL, 0x000b00000000000dULL, },
+        { 0x0000000000100004ULL, 0x0000001000080000ULL, },
+        { 0x0010000a00000000ULL, 0x000e000000000010ULL, },
+        { 0x0000000000100006ULL, 0x00000000000c0000ULL, },
+        { 0x0010000b00000000ULL, 0x0010000100000010ULL, },
+        { 0x0000000000100008ULL, 0x0000000000100000ULL, },    /*  56  */
+        { 0x0010000c00000000ULL, 0x0010000400000010ULL, },
+        { 0x000000000010000aULL, 0x0000000000100004ULL, },
+        { 0x0010000d00000000ULL, 0x0010000700000000ULL, },
+        { 0x000000000010000cULL, 0x0000000000100008ULL, },
+        { 0x0010000e00000000ULL, 0x0010000a00000000ULL, },
+        { 0x000000000010000eULL, 0x000000000010000cULL, },
+        { 0x0010000f00000000ULL, 0x0010000d00000000ULL, },
+        { 0x0000000000020001ULL, 0x0001000400000000ULL, },    /*  64  */
+        { 0x0000000900010000ULL, 0x0003000000030001ULL, },
+        { 0x0000000000000000ULL, 0x0002000000000002ULL, },
+        { 0x0001000300010000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100010001ULL, 0x0000000100000001ULL, },
+        { 0x0000000000000002ULL, 0x0003000100000002ULL, },
+        { 0x0000000100010000ULL, 0x0000000400000000ULL, },
+        { 0x0000000200000000ULL, 0x0000000100030001ULL, },
+        { 0x0002000400010000ULL, 0x0000000000000002ULL, },    /*  72  */
+        { 0x0000000000010000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000100010001ULL, },
+        { 0x0000000000020001ULL, 0x0000000000010000ULL, },
+        { 0x0000000200000000ULL, 0x0000000000010000ULL, },
+        { 0x0000000200030001ULL, 0x0000000200010002ULL, },
+        { 0x0001000100020000ULL, 0x0000000000000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000010003ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_NLZC_H(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_NLZC_H(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c
new file mode 100644
index 0000000..2ca93de
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MSA instruction NLZC.W
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
+#include "../../../include/wrappers_msa.h"
+#include "../../../include/test_inputs.h"
+#include "../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "NLZC.W";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000002000000020ULL, 0x0000002000000020ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000200000000ULL, },
+        { 0x0000000300000001ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000004ULL, },
+        { 0x0000000500000003ULL, 0x0000000100000000ULL, },
+        { 0x0000000000000004ULL, 0x0000000000000000ULL, },
+        { 0x0000000600000000ULL, 0x0000000200000006ULL, },
+        { 0x0000000000000000ULL, 0x0000000600000002ULL, },
+        { 0x0000000700000003ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0x0000000800000008ULL, 0x0000000800000008ULL, },
+        { 0x0000000000000004ULL, 0x0000000800000000ULL, },
+        { 0x0000000900000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000008ULL, 0x0000000000000004ULL, },
+        { 0x0000000a00000000ULL, 0x0000000600000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000200000000ULL, },
+        { 0x0000000b00000001ULL, 0x0000000000000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000800000000ULL, },    /*  24  */
+        { 0x0000000c00000004ULL, 0x000000000000000cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000008ULL, },
+        { 0x0000000d00000007ULL, 0x0000000100000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000e0000000aULL, 0x0000000600000002ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000f0000000dULL, 0x0000000b00000009ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },
+        { 0x0000000000000002ULL, 0x0000000400000006ULL, },
+        { 0x0000001100000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000004ULL, 0x000000080000000cULL, },
+        { 0x0000001200000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000006ULL, 0x0000000c00000012ULL, },
+        { 0x0000001300000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000008ULL, 0x0000001000000000ULL, },    /*  40  */
+        { 0x0000001400000000ULL, 0x0000000000000004ULL, },
+        { 0x000000000000000aULL, 0x0000001400000000ULL, },
+        { 0x0000001500000000ULL, 0x0000000000000009ULL, },
+        { 0x000000000000000cULL, 0x0000000000000000ULL, },
+        { 0x0000001600000000ULL, 0x000000020000000eULL, },
+        { 0x000000000000000eULL, 0x0000000000000000ULL, },
+        { 0x0000001700000000ULL, 0x0000000500000013ULL, },
+        { 0x0000000000000010ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0x0000001800000000ULL, 0x0000000800000018ULL, },
+        { 0x0000000000000012ULL, 0x0000000000000004ULL, },
+        { 0x0000001900000000ULL, 0x0000000b00000000ULL, },
+        { 0x0000000000000014ULL, 0x0000000000000008ULL, },
+        { 0x0000001a00000000ULL, 0x0000000e00000000ULL, },
+        { 0x0000000000000016ULL, 0x000000000000000cULL, },
+        { 0x0000001b00000000ULL, 0x0000001100000000ULL, },
+        { 0x0000000000000018ULL, 0x0000000000000010ULL, },    /*  56  */
+        { 0x0000001c00000000ULL, 0x0000001400000000ULL, },
+        { 0x000000000000001aULL, 0x0000000000000014ULL, },
+        { 0x0000001d00000000ULL, 0x0000001700000000ULL, },
+        { 0x000000000000001cULL, 0x0000000000000018ULL, },
+        { 0x0000001e00000000ULL, 0x0000001a00000000ULL, },
+        { 0x000000000000001eULL, 0x000000000000001cULL, },
+        { 0x0000001f00000000ULL, 0x0000001d00000000ULL, },
+        { 0x0000000000000002ULL, 0x0000000100000000ULL, },    /*  64  */
+        { 0x0000000000000001ULL, 0x0000000300000003ULL, },
+        { 0x0000000000000000ULL, 0x0000000200000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000300000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000003ULL, },
+        { 0x0000000200000001ULL, 0x0000000000000000ULL, },    /*  72  */
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000001ULL, },
+        { 0x0000000000000003ULL, 0x0000000000000001ULL, },
+        { 0x0000000100000002ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000001ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_NLZC_W(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_NLZC_W(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c
new file mode 100644
index 0000000..b4cad43
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MSA instruction PCNT.B
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
+#include "../../../include/wrappers_msa.h"
+#include "../../../include/test_inputs.h"
+#include "../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "PCNT.B";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0808080808080808ULL, 0x0808080808080808ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0504030504030504ULL, 0x0305040305040305ULL, },
+        { 0x0304050304050304ULL, 0x0503040503040503ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },    /*   8  */
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x0505040303050504ULL, 0x0303050504030305ULL, },
+        { 0x0303040505030304ULL, 0x0505030304050503ULL, },
+        { 0x0604020604020604ULL, 0x0206040206040206ULL, },
+        { 0x0204060204060204ULL, 0x0602040602040602ULL, },
+        { 0x0702050403060107ULL, 0x0205040306010702ULL, },
+        { 0x0106030405020701ULL, 0x0603040502070106ULL, },
+        { 0x0800080008000800ULL, 0x0800080008000800ULL, },    /*  16  */
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0801060304050207ULL, 0x0008010603040502ULL, },
+        { 0x0007020504030601ULL, 0x0800070205040306ULL, },
+        { 0x0802040600080204ULL, 0x0600080204060008ULL, },
+        { 0x0006040208000604ULL, 0x0208000604020800ULL, },
+        { 0x0803020801040700ULL, 0x0605000803020801ULL, },
+        { 0x0005060007040108ULL, 0x0203080005060007ULL, },
+        { 0x0804000804000804ULL, 0x0008040008040008ULL, },    /*  24  */
+        { 0x0004080004080004ULL, 0x0800040800040800ULL, },
+        { 0x0805000607000408ULL, 0x0102080300080500ULL, },
+        { 0x0003080201080400ULL, 0x0706000508000308ULL, },
+        { 0x0806000408020008ULL, 0x0600040802000806ULL, },
+        { 0x0002080400060800ULL, 0x0208040006080002ULL, },
+        { 0x0807000208050004ULL, 0x0803000608010008ULL, },
+        { 0x0001080600030804ULL, 0x0005080200070800ULL, },
+        { 0x0808000008080000ULL, 0x0808000008080000ULL, },    /*  32  */
+        { 0x0000080800000808ULL, 0x0000080800000808ULL, },
+        { 0x0808010006080300ULL, 0x0408050002080700ULL, },
+        { 0x0000070802000508ULL, 0x0400030806000108ULL, },
+        { 0x0808020004080600ULL, 0x0008080200040806ULL, },
+        { 0x0000060804000208ULL, 0x0800000608040002ULL, },
+        { 0x0808030002080801ULL, 0x0004080700000608ULL, },
+        { 0x0000050806000007ULL, 0x0804000108080200ULL, },
+        { 0x0808040000080804ULL, 0x0000080804000008ULL, },    /*  40  */
+        { 0x0000040808000004ULL, 0x0808000004080800ULL, },
+        { 0x0808050000060807ULL, 0x0000040808010002ULL, },
+        { 0x0000030808020001ULL, 0x0808040000070806ULL, },
+        { 0x0808060000040808ULL, 0x0200000808060000ULL, },
+        { 0x0000020808040000ULL, 0x0608080000020808ULL, },
+        { 0x0808070000020808ULL, 0x0500000408080300ULL, },
+        { 0x0000010808060000ULL, 0x0308080400000508ULL, },
+        { 0x0808080000000808ULL, 0x0800000008080800ULL, },    /*  48  */
+        { 0x0000000808080000ULL, 0x0008080800000008ULL, },
+        { 0x0808080100000608ULL, 0x0803000004080805ULL, },
+        { 0x0000000708080200ULL, 0x0005080804000003ULL, },
+        { 0x0808080200000408ULL, 0x0806000000080808ULL, },
+        { 0x0000000608080400ULL, 0x0002080808000000ULL, },
+        { 0x0808080300000208ULL, 0x0808010000040808ULL, },
+        { 0x0000000508080600ULL, 0x0000070808040000ULL, },
+        { 0x0808080400000008ULL, 0x0808040000000808ULL, },    /*  56  */
+        { 0x0000000408080800ULL, 0x0000040808080000ULL, },
+        { 0x0808080500000006ULL, 0x0808070000000408ULL, },
+        { 0x0000000308080802ULL, 0x0000010808080400ULL, },
+        { 0x0808080600000004ULL, 0x0808080200000008ULL, },
+        { 0x0000000208080804ULL, 0x0000000608080800ULL, },
+        { 0x0808080700000002ULL, 0x0808080500000004ULL, },
+        { 0x0000000108080806ULL, 0x0000000308080804ULL, },
+        { 0x0204050402030401ULL, 0x0405030507060302ULL, },    /*  64  */
+        { 0x0706000404040501ULL, 0x0207060303060306ULL, },
+        { 0x0404050405060401ULL, 0x0404040805040302ULL, },
+        { 0x0305030405030404ULL, 0x0405020404020402ULL, },
+        { 0x0503050506060203ULL, 0x0302050505050405ULL, },
+        { 0x0304060308020406ULL, 0x0403020207040204ULL, },
+        { 0x0405030204040503ULL, 0x0303010207040503ULL, },
+        { 0x0605030404040602ULL, 0x0407040502020505ULL, },
+        { 0x0104020504050503ULL, 0x0705030404040403ULL, },    /*  72  */
+        { 0x0405050304050506ULL, 0x0402050302050504ULL, },
+        { 0x0304060604050404ULL, 0x0403040305030502ULL, },
+        { 0x0304050503030305ULL, 0x0404040505050306ULL, },
+        { 0x0502030504030502ULL, 0x0303030504050403ULL, },
+        { 0x0303040703030303ULL, 0x0603040404030405ULL, },
+        { 0x0302020402060704ULL, 0x0604030705030204ULL, },
+        { 0x0404050305040605ULL, 0x0404050504030405ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_PCNT_B(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_PCNT_B(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c
new file mode 100644
index 0000000..d6a8b0d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MSA instruction PCNT.D
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
+#include "../../../include/wrappers_msa.h"
+#include "../../../include/test_inputs.h"
+#include "../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "PCNT.D";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000040ULL, 0x0000000000000040ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
+        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
+        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
+        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
+        { 0x0000000000000021ULL, 0x0000000000000020ULL, },
+        { 0x000000000000001fULL, 0x0000000000000020ULL, },
+        { 0x0000000000000020ULL, 0x0000000000000020ULL, },    /*   8  */
+        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
+        { 0x0000000000000022ULL, 0x000000000000001fULL, },
+        { 0x000000000000001eULL, 0x0000000000000021ULL, },
+        { 0x0000000000000022ULL, 0x0000000000000020ULL, },
+        { 0x000000000000001eULL, 0x0000000000000020ULL, },
+        { 0x0000000000000023ULL, 0x000000000000001eULL, },
+        { 0x000000000000001dULL, 0x0000000000000022ULL, },
+        { 0x0000000000000020ULL, 0x0000000000000020ULL, },    /*  16  */
+        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
+        { 0x0000000000000024ULL, 0x000000000000001dULL, },
+        { 0x000000000000001cULL, 0x0000000000000023ULL, },
+        { 0x0000000000000022ULL, 0x0000000000000022ULL, },
+        { 0x000000000000001eULL, 0x000000000000001eULL, },
+        { 0x0000000000000021ULL, 0x0000000000000021ULL, },
+        { 0x000000000000001fULL, 0x000000000000001fULL, },
+        { 0x0000000000000024ULL, 0x0000000000000020ULL, },    /*  24  */
+        { 0x000000000000001cULL, 0x0000000000000020ULL, },
+        { 0x0000000000000026ULL, 0x000000000000001bULL, },
+        { 0x000000000000001aULL, 0x0000000000000025ULL, },
+        { 0x0000000000000024ULL, 0x0000000000000022ULL, },
+        { 0x000000000000001cULL, 0x000000000000001eULL, },
+        { 0x0000000000000022ULL, 0x0000000000000022ULL, },
+        { 0x000000000000001eULL, 0x000000000000001eULL, },
+        { 0x0000000000000020ULL, 0x0000000000000020ULL, },    /*  32  */
+        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
+        { 0x0000000000000022ULL, 0x0000000000000022ULL, },
+        { 0x000000000000001eULL, 0x000000000000001eULL, },
+        { 0x0000000000000024ULL, 0x0000000000000024ULL, },
+        { 0x000000000000001cULL, 0x000000000000001cULL, },
+        { 0x0000000000000026ULL, 0x0000000000000021ULL, },
+        { 0x000000000000001aULL, 0x000000000000001fULL, },
+        { 0x0000000000000028ULL, 0x000000000000001cULL, },    /*  40  */
+        { 0x0000000000000018ULL, 0x0000000000000024ULL, },
+        { 0x000000000000002aULL, 0x0000000000000017ULL, },
+        { 0x0000000000000016ULL, 0x0000000000000029ULL, },
+        { 0x000000000000002aULL, 0x0000000000000018ULL, },
+        { 0x0000000000000016ULL, 0x0000000000000028ULL, },
+        { 0x0000000000000029ULL, 0x000000000000001cULL, },
+        { 0x0000000000000017ULL, 0x0000000000000024ULL, },
+        { 0x0000000000000028ULL, 0x0000000000000020ULL, },    /*  48  */
+        { 0x0000000000000018ULL, 0x0000000000000020ULL, },
+        { 0x0000000000000027ULL, 0x0000000000000024ULL, },
+        { 0x0000000000000019ULL, 0x000000000000001cULL, },
+        { 0x0000000000000026ULL, 0x0000000000000026ULL, },
+        { 0x000000000000001aULL, 0x000000000000001aULL, },
+        { 0x0000000000000025ULL, 0x0000000000000025ULL, },
+        { 0x000000000000001bULL, 0x000000000000001bULL, },
+        { 0x0000000000000024ULL, 0x0000000000000024ULL, },    /*  56  */
+        { 0x000000000000001cULL, 0x000000000000001cULL, },
+        { 0x0000000000000023ULL, 0x0000000000000023ULL, },
+        { 0x000000000000001dULL, 0x000000000000001dULL, },
+        { 0x0000000000000022ULL, 0x0000000000000022ULL, },
+        { 0x000000000000001eULL, 0x000000000000001eULL, },
+        { 0x0000000000000021ULL, 0x0000000000000021ULL, },
+        { 0x000000000000001fULL, 0x000000000000001fULL, },
+        { 0x0000000000000019ULL, 0x0000000000000023ULL, },    /*  64  */
+        { 0x000000000000001fULL, 0x0000000000000024ULL, },
+        { 0x0000000000000021ULL, 0x0000000000000022ULL, },
+        { 0x000000000000001fULL, 0x000000000000001bULL, },
+        { 0x0000000000000023ULL, 0x0000000000000022ULL, },
+        { 0x0000000000000024ULL, 0x000000000000001cULL, },
+        { 0x000000000000001eULL, 0x000000000000001cULL, },
+        { 0x0000000000000022ULL, 0x0000000000000022ULL, },
+        { 0x000000000000001dULL, 0x0000000000000022ULL, },    /*  72  */
+        { 0x0000000000000025ULL, 0x000000000000001eULL, },
+        { 0x0000000000000024ULL, 0x000000000000001dULL, },
+        { 0x000000000000001fULL, 0x0000000000000024ULL, },
+        { 0x000000000000001dULL, 0x000000000000001eULL, },
+        { 0x000000000000001dULL, 0x0000000000000021ULL, },
+        { 0x000000000000001eULL, 0x0000000000000022ULL, },
+        { 0x0000000000000024ULL, 0x0000000000000022ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_PCNT_D(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_PCNT_D(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c
new file mode 100644
index 0000000..1cdcabd
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MSA instruction PCNT.H
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
+#include "../../../include/wrappers_msa.h"
+#include "../../../include/test_inputs.h"
+#include "../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "PCNT.H";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0010001000100010ULL, 0x0010001000100010ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0009000800070009ULL, 0x0008000700090008ULL, },
+        { 0x0007000800090007ULL, 0x0008000900070008ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },    /*   8  */
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x000a000700080009ULL, 0x0006000a00070008ULL, },
+        { 0x0006000900080007ULL, 0x000a000600090008ULL, },
+        { 0x000a00080006000aULL, 0x00080006000a0008ULL, },
+        { 0x00060008000a0006ULL, 0x0008000a00060008ULL, },
+        { 0x0009000900090008ULL, 0x0007000700070009ULL, },
+        { 0x0007000700070008ULL, 0x0009000900090007ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },    /*  16  */
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0009000900090009ULL, 0x0008000700070007ULL, },
+        { 0x0007000700070007ULL, 0x0008000900090009ULL, },
+        { 0x000a000a00080006ULL, 0x0006000a000a0008ULL, },
+        { 0x000600060008000aULL, 0x000a000600060008ULL, },
+        { 0x000b000a00050007ULL, 0x000b000800050009ULL, },
+        { 0x00050006000b0009ULL, 0x00050008000b0007ULL, },
+        { 0x000c00080004000cULL, 0x00080004000c0008ULL, },    /*  24  */
+        { 0x00040008000c0004ULL, 0x0008000c00040008ULL, },
+        { 0x000d00060007000cULL, 0x0003000b00080005ULL, },
+        { 0x0003000a00090004ULL, 0x000d00050008000bULL, },
+        { 0x000e0004000a0008ULL, 0x0006000c0002000eULL, },
+        { 0x0002000c00060008ULL, 0x000a0004000e0002ULL, },
+        { 0x000f0002000d0004ULL, 0x000b000600090008ULL, },
+        { 0x0001000e0003000cULL, 0x0005000a00070008ULL, },
+        { 0x0010000000100000ULL, 0x0010000000100000ULL, },    /*  32  */
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },
+        { 0x00100001000e0003ULL, 0x000c0005000a0007ULL, },
+        { 0x0000000f0002000dULL, 0x0004000b00060009ULL, },
+        { 0x00100002000c0006ULL, 0x0008000a0004000eULL, },
+        { 0x0000000e0004000aULL, 0x00080006000c0002ULL, },
+        { 0x00100003000a0009ULL, 0x0004000f0000000eULL, },
+        { 0x0000000d00060007ULL, 0x000c000100100002ULL, },
+        { 0x001000040008000cULL, 0x0000001000040008ULL, },    /*  40  */
+        { 0x0000000c00080004ULL, 0x00100000000c0008ULL, },
+        { 0x001000050006000fULL, 0x0000000c00090002ULL, },
+        { 0x0000000b000a0001ULL, 0x001000040007000eULL, },
+        { 0x0010000600040010ULL, 0x00020008000e0000ULL, },
+        { 0x0000000a000c0000ULL, 0x000e000800020010ULL, },
+        { 0x0010000700020010ULL, 0x0005000400100003ULL, },
+        { 0x00000009000e0000ULL, 0x000b000c0000000dULL, },
+        { 0x0010000800000010ULL, 0x0008000000100008ULL, },    /*  48  */
+        { 0x0000000800100000ULL, 0x0008001000000008ULL, },
+        { 0x001000090000000eULL, 0x000b0000000c000dULL, },
+        { 0x0000000700100002ULL, 0x0005001000040003ULL, },
+        { 0x0010000a0000000cULL, 0x000e000000080010ULL, },
+        { 0x0000000600100004ULL, 0x0002001000080000ULL, },
+        { 0x0010000b0000000aULL, 0x0010000100040010ULL, },
+        { 0x0000000500100006ULL, 0x0000000f000c0000ULL, },
+        { 0x0010000c00000008ULL, 0x0010000400000010ULL, },    /*  56  */
+        { 0x0000000400100008ULL, 0x0000000c00100000ULL, },
+        { 0x0010000d00000006ULL, 0x001000070000000cULL, },
+        { 0x000000030010000aULL, 0x0000000900100004ULL, },
+        { 0x0010000e00000004ULL, 0x0010000a00000008ULL, },
+        { 0x000000020010000cULL, 0x0000000600100008ULL, },
+        { 0x0010000f00000002ULL, 0x0010000d00000004ULL, },
+        { 0x000000010010000eULL, 0x000000030010000cULL, },
+        { 0x0006000900050005ULL, 0x00090008000d0005ULL, },    /*  64  */
+        { 0x000d000400080006ULL, 0x0009000900090009ULL, },
+        { 0x00080009000b0005ULL, 0x0008000c00090005ULL, },
+        { 0x0008000700080008ULL, 0x0009000600060006ULL, },
+        { 0x0008000a000c0005ULL, 0x0005000a000a0009ULL, },
+        { 0x00070009000a000aULL, 0x00070004000b0006ULL, },
+        { 0x0009000500080008ULL, 0x00060003000b0008ULL, },
+        { 0x000b000700080008ULL, 0x000b00090004000aULL, },
+        { 0x0005000700090008ULL, 0x000c000700080007ULL, },    /*  72  */
+        { 0x000900080009000bULL, 0x0006000800070009ULL, },
+        { 0x0007000c00090008ULL, 0x0007000700080007ULL, },
+        { 0x0007000a00060008ULL, 0x00080009000a0009ULL, },
+        { 0x0007000800070007ULL, 0x0006000800090007ULL, },
+        { 0x0006000b00060006ULL, 0x0009000800070009ULL, },
+        { 0x000500060008000bULL, 0x000a000a00080006ULL, },
+        { 0x000800080009000bULL, 0x0008000a00070009ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_PCNT_H(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_PCNT_H(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c
new file mode 100644
index 0000000..38ddc14
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c
@@ -0,0 +1,144 @@
+/*
+ *  Test program for MSA instruction PCNT.W
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
+#include "../../../include/wrappers_msa.h"
+#include "../../../include/test_inputs.h"
+#include "../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *instruction_name = "PCNT.W";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000002000000020ULL, 0x0000002000000020ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },
+        { 0x0000001100000010ULL, 0x0000000f00000011ULL, },
+        { 0x0000000f00000010ULL, 0x000000110000000fULL, },
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },    /*   8  */
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },
+        { 0x0000001100000011ULL, 0x000000100000000fULL, },
+        { 0x0000000f0000000fULL, 0x0000001000000011ULL, },
+        { 0x0000001200000010ULL, 0x0000000e00000012ULL, },
+        { 0x0000000e00000010ULL, 0x000000120000000eULL, },
+        { 0x0000001200000011ULL, 0x0000000e00000010ULL, },
+        { 0x0000000e0000000fULL, 0x0000001200000010ULL, },
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },    /*  16  */
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },
+        { 0x0000001200000012ULL, 0x0000000f0000000eULL, },
+        { 0x0000000e0000000eULL, 0x0000001100000012ULL, },
+        { 0x000000140000000eULL, 0x0000001000000012ULL, },
+        { 0x0000000c00000012ULL, 0x000000100000000eULL, },
+        { 0x000000150000000cULL, 0x000000130000000eULL, },
+        { 0x0000000b00000014ULL, 0x0000000d00000012ULL, },
+        { 0x0000001400000010ULL, 0x0000000c00000014ULL, },    /*  24  */
+        { 0x0000000c00000010ULL, 0x000000140000000cULL, },
+        { 0x0000001300000013ULL, 0x0000000e0000000dULL, },
+        { 0x0000000d0000000dULL, 0x0000001200000013ULL, },
+        { 0x0000001200000012ULL, 0x0000001200000010ULL, },
+        { 0x0000000e0000000eULL, 0x0000000e00000010ULL, },
+        { 0x0000001100000011ULL, 0x0000001100000011ULL, },
+        { 0x0000000f0000000fULL, 0x0000000f0000000fULL, },
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },    /*  32  */
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },
+        { 0x0000001100000011ULL, 0x0000001100000011ULL, },
+        { 0x0000000f0000000fULL, 0x0000000f0000000fULL, },
+        { 0x0000001200000012ULL, 0x0000001200000012ULL, },
+        { 0x0000000e0000000eULL, 0x0000000e0000000eULL, },
+        { 0x0000001300000013ULL, 0x000000130000000eULL, },
+        { 0x0000000d0000000dULL, 0x0000000d00000012ULL, },
+        { 0x0000001400000014ULL, 0x000000100000000cULL, },    /*  40  */
+        { 0x0000000c0000000cULL, 0x0000001000000014ULL, },
+        { 0x0000001500000015ULL, 0x0000000c0000000bULL, },
+        { 0x0000000b0000000bULL, 0x0000001400000015ULL, },
+        { 0x0000001600000014ULL, 0x0000000a0000000eULL, },
+        { 0x0000000a0000000cULL, 0x0000001600000012ULL, },
+        { 0x0000001700000012ULL, 0x0000000900000013ULL, },
+        { 0x000000090000000eULL, 0x000000170000000dULL, },
+        { 0x0000001800000010ULL, 0x0000000800000018ULL, },    /*  48  */
+        { 0x0000000800000010ULL, 0x0000001800000008ULL, },
+        { 0x000000190000000eULL, 0x0000000b00000019ULL, },
+        { 0x0000000700000012ULL, 0x0000001500000007ULL, },
+        { 0x0000001a0000000cULL, 0x0000000e00000018ULL, },
+        { 0x0000000600000014ULL, 0x0000001200000008ULL, },
+        { 0x0000001b0000000aULL, 0x0000001100000014ULL, },
+        { 0x0000000500000016ULL, 0x0000000f0000000cULL, },
+        { 0x0000001c00000008ULL, 0x0000001400000010ULL, },    /*  56  */
+        { 0x0000000400000018ULL, 0x0000000c00000010ULL, },
+        { 0x0000001d00000006ULL, 0x000000170000000cULL, },
+        { 0x000000030000001aULL, 0x0000000900000014ULL, },
+        { 0x0000001e00000004ULL, 0x0000001a00000008ULL, },
+        { 0x000000020000001cULL, 0x0000000600000018ULL, },
+        { 0x0000001f00000002ULL, 0x0000001d00000004ULL, },
+        { 0x000000010000001eULL, 0x000000030000001cULL, },
+        { 0x0000000f0000000aULL, 0x0000001100000012ULL, },    /*  64  */
+        { 0x000000110000000eULL, 0x0000001200000012ULL, },
+        { 0x0000001100000010ULL, 0x000000140000000eULL, },
+        { 0x0000000f00000010ULL, 0x0000000f0000000cULL, },
+        { 0x0000001200000011ULL, 0x0000000f00000013ULL, },
+        { 0x0000001000000014ULL, 0x0000000b00000011ULL, },
+        { 0x0000000e00000010ULL, 0x0000000900000013ULL, },
+        { 0x0000001200000010ULL, 0x000000140000000eULL, },
+        { 0x0000000c00000011ULL, 0x000000130000000fULL, },    /*  72  */
+        { 0x0000001100000014ULL, 0x0000000e00000010ULL, },
+        { 0x0000001300000011ULL, 0x0000000e0000000fULL, },
+        { 0x000000110000000eULL, 0x0000001100000013ULL, },
+        { 0x0000000f0000000eULL, 0x0000000e00000010ULL, },
+        { 0x000000110000000cULL, 0x0000001100000010ULL, },
+        { 0x0000000b00000013ULL, 0x000000140000000eULL, },
+        { 0x0000001000000014ULL, 0x0000001200000010ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_PCNT_W(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_PCNT_W(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
