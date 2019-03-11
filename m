Received: from eggs.gnu.org ([209.51.188.92]:57364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h3LtS-0005dv-IT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h3LtK-0001kj-5M
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:27:06 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50882 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h3Lsc-0001Om-UM
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:26:58 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 11 Mar 2019 15:24:48 +0100
Message-Id: <1552314290-28709-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 5/7] target/mips: Add tests for a variety of MSA
 integer dot product instructions
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

Add tests for a variety of MSA integer dot product instructions.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1551964929-17845-4-git-send-email-mateja.marjanovic@rt-rk.com>
---
 .../ase/msa/int-dot-product/test_msa_dotp_s_d.c    | 151 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dotp_s_h.c    | 151 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dotp_s_w.c    | 151 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dotp_u_d.c    | 151 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dotp_u_h.c    | 151 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dotp_u_w.c    | 151 +++++++++++++++++++++
 6 files changed, 906 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c

diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
new file mode 100644
index 0000000..af8d609
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DOTP_S.D
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
+    char *instruction_name = "DOTP_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000aaaaaaacULL, 0x00000000aaaaaaacULL, },
+        { 0xffffffff55555556ULL, 0xffffffff55555556ULL, },
+        { 0x0000000066666668ULL, 0x0000000066666668ULL, },
+        { 0xffffffff9999999aULL, 0xffffffff9999999aULL, },
+        { 0x000000008e38e38fULL, 0xffffffffe38e38e5ULL, },
+        { 0xffffffff71c71c73ULL, 0x000000001c71c71dULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000aaaaaaacULL, 0x00000000aaaaaaacULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x38e38e39c71c71c8ULL, 0x38e38e39c71c71c8ULL, },
+        { 0xc71c71c6e38e38e4ULL, 0xc71c71c6e38e38e4ULL, },
+        { 0x22222222eeeeeef0ULL, 0x22222222eeeeeef0ULL, },
+        { 0xddddddddbbbbbbbcULL, 0xddddddddbbbbbbbcULL, },
+        { 0x2f684bdab425ed0aULL, 0xf684bda197b425eeULL, },
+        { 0xd097b425f684bda2ULL, 0x097b425f12f684beULL, },
+        { 0xffffffff55555556ULL, 0xffffffff55555556ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c6e38e38e4ULL, 0xc71c71c6e38e38e4ULL, },
+        { 0x38e38e3871c71c72ULL, 0x38e38e3871c71c72ULL, },
+        { 0xdddddddd77777778ULL, 0xdddddddd77777778ULL, },
+        { 0x22222221dddddddeULL, 0x22222221dddddddeULL, },
+        { 0xd097b425da12f685ULL, 0x097b425e4bda12f7ULL, },
+        { 0x2f684bd97b425ed1ULL, 0xf684bda1097b425fULL, },
+        { 0x0000000066666668ULL, 0x0000000066666668ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x22222222eeeeeef0ULL, 0x22222222eeeeeef0ULL, },
+        { 0xdddddddd77777778ULL, 0xdddddddd77777778ULL, },
+        { 0x147ae14851eb8520ULL, 0x147ae14851eb8520ULL, },
+        { 0xeb851eb8147ae148ULL, 0xeb851eb8147ae148ULL, },
+        { 0x1c71c71d0b60b60cULL, 0xfa4fa4fa82d82d84ULL, },
+        { 0xe38e38e35b05b05cULL, 0x05b05b05e38e38e4ULL, },
+        { 0xffffffff9999999aULL, 0xffffffff9999999aULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xddddddddbbbbbbbcULL, 0xddddddddbbbbbbbcULL, },
+        { 0x22222221dddddddeULL, 0x22222221dddddddeULL, },
+        { 0xeb851eb8147ae148ULL, 0xeb851eb8147ae148ULL, },
+        { 0x147ae147851eb852ULL, 0x147ae147851eb852ULL, },
+        { 0xe38e38e382d82d83ULL, 0x05b05b0560b60b61ULL, },
+        { 0x1c71c71c16c16c17ULL, 0xfa4fa4fa38e38e39ULL, },
+        { 0x000000008e38e38fULL, 0xffffffffe38e38e5ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2f684bdab425ed0aULL, 0xf684bda197b425eeULL, },
+        { 0xd097b425da12f685ULL, 0x097b425e4bda12f7ULL, },
+        { 0x1c71c71d0b60b60cULL, 0xfa4fa4fa82d82d84ULL, },
+        { 0xe38e38e382d82d83ULL, 0x05b05b0560b60b61ULL, },
+        { 0x35ba78199add3c0dULL, 0x0fcd6e9dc0ca4589ULL, },
+        { 0xca4587e6f35ba782ULL, 0xf032916222c3f35cULL, },
+        { 0xffffffff71c71c73ULL, 0x000000001c71c71dULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd097b425f684bda2ULL, 0x097b425f12f684beULL, },
+        { 0x2f684bd97b425ed1ULL, 0xf684bda1097b425fULL, },
+        { 0xe38e38e35b05b05cULL, 0x05b05b05e38e38e4ULL, },
+        { 0x1c71c71c16c16c17ULL, 0xfa4fa4fa38e38e39ULL, },
+        { 0xca4587e6f35ba782ULL, 0xf032916222c3f35cULL, },
+        { 0x35ba78187e6b74f1ULL, 0x0fcd6e9df9add3c1ULL, },
+        { 0x3e3ad4ae1266c290ULL, 0x1637d725aebdb714ULL, },    /*  64  */
+        { 0x0e3a0c27f7d6aae4ULL, 0x0575fbb7f08ff55cULL, },
+        { 0x1c00082337c84b78ULL, 0x0c3d39640fde8392ULL, },
+        { 0xda65cd5e9f696cdcULL, 0xdeeb6bec644a26d0ULL, },
+        { 0x0e3a0c27f7d6aae4ULL, 0x0575fbb7f08ff55cULL, },
+        { 0x17945c09b2e19689ULL, 0x032b395187d966b4ULL, },
+        { 0xec1f0e54b5aa67beULL, 0xfbe95b6e67ae6296ULL, },
+        { 0x1aad30609bff5437ULL, 0xf059a43d01b40370ULL, },
+        { 0x1c00082337c84b78ULL, 0x0c3d39640fde8392ULL, },    /*  72  */
+        { 0xec1f0e54b5aa67beULL, 0xfbe95b6e67ae6296ULL, },
+        { 0x2e9326619bb7c8e4ULL, 0x225024d84d163b91ULL, },
+        { 0xc17a5d0372a2a622ULL, 0x0afd6368668933a8ULL, },
+        { 0xda65cd5e9f696cdcULL, 0xdeeb6bec644a26d0ULL, },
+        { 0x1aad30609bff5437ULL, 0xf059a43d01b40370ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DOTP_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DOTP_S_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
new file mode 100644
index 0000000..40de72a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DOTP_S.H
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
+    char *instruction_name = "DOTP_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00ac00ac00ac00acULL, 0x00ac00ac00ac00acULL, },
+        { 0xff56ff56ff56ff56ULL, 0xff56ff56ff56ff56ULL, },
+        { 0x0068006800680068ULL, 0x0068006800680068ULL, },
+        { 0xff9aff9aff9aff9aULL, 0xff9aff9aff9aff9aULL, },
+        { 0x008fffe5003a008fULL, 0xffe5003a008fffe5ULL, },
+        { 0xff73001dffc8ff73ULL, 0x001dffc8ff73001dULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00ac00ac00ac00acULL, 0x00ac00ac00ac00acULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x39c839c839c839c8ULL, 0x39c839c839c839c8ULL, },
+        { 0xc6e4c6e4c6e4c6e4ULL, 0xc6e4c6e4c6e4c6e4ULL, },
+        { 0x22f022f022f022f0ULL, 0x22f022f022f022f0ULL, },
+        { 0xddbcddbcddbcddbcULL, 0xddbcddbcddbcddbcULL, },
+        { 0x300af6ee137c300aULL, 0xf6ee137c300af6eeULL, },
+        { 0xd0a209beed30d0a2ULL, 0x09beed30d0a209beULL, },
+        { 0xff56ff56ff56ff56ULL, 0xff56ff56ff56ff56ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc6e4c6e4c6e4c6e4ULL, 0xc6e4c6e4c6e4c6e4ULL, },
+        { 0x3872387238723872ULL, 0x3872387238723872ULL, },
+        { 0xdd78dd78dd78dd78ULL, 0xdd78dd78dd78dd78ULL, },
+        { 0x21de21de21de21deULL, 0x21de21de21de21deULL, },
+        { 0xd08508f7ecbed085ULL, 0x08f7ecbed08508f7ULL, },
+        { 0x2ed1f65f12982ed1ULL, 0xf65f12982ed1f65fULL, },
+        { 0x0068006800680068ULL, 0x0068006800680068ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x22f022f022f022f0ULL, 0x22f022f022f022f0ULL, },
+        { 0xdd78dd78dd78dd78ULL, 0xdd78dd78dd78dd78ULL, },
+        { 0x1520152015201520ULL, 0x1520152015201520ULL, },
+        { 0xeb48eb48eb48eb48ULL, 0xeb48eb48eb48eb48ULL, },
+        { 0x1d0cfa840bc81d0cULL, 0xfa840bc81d0cfa84ULL, },
+        { 0xe35c05e4f4a0e35cULL, 0x05e4f4a0e35c05e4ULL, },
+        { 0xff9aff9aff9aff9aULL, 0xff9aff9aff9aff9aULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xddbcddbcddbcddbcULL, 0xddbcddbcddbcddbcULL, },
+        { 0x21de21de21de21deULL, 0x21de21de21de21deULL, },
+        { 0xeb48eb48eb48eb48ULL, 0xeb48eb48eb48eb48ULL, },
+        { 0x1452145214521452ULL, 0x1452145214521452ULL, },
+        { 0xe3830561f472e383ULL, 0x0561f472e3830561ULL, },
+        { 0x1c17fa390b281c17ULL, 0xfa390b281c17fa39ULL, },
+        { 0x008fffe5003a008fULL, 0xffe5003a008fffe5ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x300af6ee137c300aULL, 0xf6ee137c300af6eeULL, },
+        { 0xd08508f7ecbed085ULL, 0x08f7ecbed08508f7ULL, },
+        { 0x1d0cfa840bc81d0cULL, 0xfa840bc81d0cfa84ULL, },
+        { 0xe3830561f472e383ULL, 0x0561f472e3830561ULL, },
+        { 0x360d0f893f04360dULL, 0x0f893f04360d0f89ULL, },
+        { 0xca82f05cc136ca82ULL, 0xf05cc136ca82f05cULL, },
+        { 0xff73001dffc8ff73ULL, 0x001dffc8ff73001dULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd0a209beed30d0a2ULL, 0x09beed30d0a209beULL, },
+        { 0x2ed1f65f12982ed1ULL, 0xf65f12982ed1f65fULL, },
+        { 0xe35c05e4f4a0e35cULL, 0x05e4f4a0e35c05e4ULL, },
+        { 0x1c17fa390b281c17ULL, 0xfa390b281c17fa39ULL, },
+        { 0xca82f05cc136ca82ULL, 0xf05cc136ca82f05cULL, },
+        { 0x34f10fc13e9234f1ULL, 0x0fc13e9234f10fc1ULL, },
+        { 0x64240d342bc42c39ULL, 0x3f6a22fd3b1d1990ULL, },    /*  64  */
+        { 0xe704ebe4e24eef13ULL, 0x01a706951e1be630ULL, },
+        { 0x4ca419cce226b927ULL, 0xfb55fd241553f560ULL, },
+        { 0xec36ee202172098aULL, 0xd846ec28206404e0ULL, },
+        { 0xe704ebe4e24eef13ULL, 0x01a706951e1be630ULL, },
+        { 0x111d264945920cf1ULL, 0x0195153d113a1a54ULL, },
+        { 0xea70debeff82160dULL, 0x04260f88039c0b8aULL, },
+        { 0xe9721dc70769091eULL, 0xf8711c48091bf7e4ULL, },
+        { 0x4ca419cce226b927ULL, 0xfb55fd241553f560ULL, },    /*  72  */
+        { 0xea70debeff82160dULL, 0x04260f88039c0b8aULL, },
+        { 0x3b3437281d127579ULL, 0x0c310d25237206e9ULL, },
+        { 0xf706df16dc8de6b6ULL, 0xf0d31b5827f9f42aULL, },
+        { 0xec36ee202172098aULL, 0xd846ec28206404e0ULL, },
+        { 0xe9721dc70769091eULL, 0xf8711c48091bf7e4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DOTP_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DOTP_S_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
new file mode 100644
index 0000000..2f1d23b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DOTP_S.W
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
+    char *instruction_name = "DOTP_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000aaac0000aaacULL, 0x0000aaac0000aaacULL, },
+        { 0xffff5556ffff5556ULL, 0xffff5556ffff5556ULL, },
+        { 0x0000666800006668ULL, 0x0000666800006668ULL, },
+        { 0xffff999affff999aULL, 0xffff999affff999aULL, },
+        { 0xffffe38f00008e3aULL, 0x000038e5ffffe38fULL, },
+        { 0x00001c73ffff71c8ULL, 0xffffc71d00001c73ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000aaac0000aaacULL, 0x0000aaac0000aaacULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x38e471c838e471c8ULL, 0x38e471c838e471c8ULL, },
+        { 0xc71c38e4c71c38e4ULL, 0xc71c38e4c71c38e4ULL, },
+        { 0x2222eef02222eef0ULL, 0x2222eef02222eef0ULL, },
+        { 0xddddbbbcddddbbbcULL, 0xddddbbbcddddbbbcULL, },
+        { 0xf684ed0a2f69097cULL, 0x12f725eef684ed0aULL, },
+        { 0x097bbda2d097a130ULL, 0xed0984be097bbda2ULL, },
+        { 0xffff5556ffff5556ULL, 0xffff5556ffff5556ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71c38e4c71c38e4ULL, 0xc71c38e4c71c38e4ULL, },
+        { 0x38e31c7238e31c72ULL, 0x38e31c7238e31c72ULL, },
+        { 0xdddd7778dddd7778ULL, 0xdddd7778dddd7778ULL, },
+        { 0x2221ddde2221dddeULL, 0x2221ddde2221dddeULL, },
+        { 0x097af685d09784beULL, 0xed0912f7097af685ULL, },
+        { 0xf6845ed12f67d098ULL, 0x12f6425ff6845ed1ULL, },
+        { 0x0000666800006668ULL, 0x0000666800006668ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2222eef02222eef0ULL, 0x2222eef02222eef0ULL, },
+        { 0xdddd7778dddd7778ULL, 0xdddd7778dddd7778ULL, },
+        { 0x147b8520147b8520ULL, 0x147b8520147b8520ULL, },
+        { 0xeb84e148eb84e148ULL, 0xeb84e148eb84e148ULL, },
+        { 0xfa4fb60c1c7271c8ULL, 0x0b612d84fa4fb60cULL, },
+        { 0x05b0b05ce38df4a0ULL, 0xf49f38e405b0b05cULL, },
+        { 0xffff999affff999aULL, 0xffff999affff999aULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xddddbbbcddddbbbcULL, 0xddddbbbcddddbbbcULL, },
+        { 0x2221ddde2221dddeULL, 0x2221ddde2221dddeULL, },
+        { 0xeb84e148eb84e148ULL, 0xeb84e148eb84e148ULL, },
+        { 0x147ab852147ab852ULL, 0x147ab852147ab852ULL, },
+        { 0x05b02d83e38e1c72ULL, 0xf49f0b6105b02d83ULL, },
+        { 0xfa4f6c171c717d28ULL, 0x0b608e39fa4f6c17ULL, },
+        { 0xffffe38f00008e3aULL, 0x000038e5ffffe38fULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xf684ed0a2f69097cULL, 0x12f725eef684ed0aULL, },
+        { 0x097af685d09784beULL, 0xed0912f7097af685ULL, },
+        { 0xfa4fb60c1c7271c8ULL, 0x0b612d84fa4fb60cULL, },
+        { 0x05b02d83e38e1c72ULL, 0xf49f0b6105b02d83ULL, },
+        { 0x0fcd3c0d35bb4f04ULL, 0x3f3645890fcd3c0dULL, },
+        { 0xf032a782ca453f36ULL, 0xc0c9f35cf032a782ULL, },
+        { 0x00001c73ffff71c8ULL, 0xffffc71d00001c73ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x097bbda2d097a130ULL, 0xed0984be097bbda2ULL, },
+        { 0xf6845ed12f67d098ULL, 0x12f6425ff6845ed1ULL, },
+        { 0x05b0b05ce38df4a0ULL, 0xf49f38e405b0b05cULL, },
+        { 0xfa4f6c171c717d28ULL, 0x0b608e39fa4f6c17ULL, },
+        { 0xf032a782ca453f36ULL, 0xc0c9f35cf032a782ULL, },
+        { 0x0fcd74f135ba3292ULL, 0x3f35d3c10fcd74f1ULL, },
+        { 0x3a57fe7422c25584ULL, 0x16b6b9f518facfa9ULL, },    /*  64  */
+        { 0x01f36d90f9441446ULL, 0x0286cfede5f4db15ULL, },
+        { 0x2f1518bcce21d93eULL, 0x0934568af4ec6499ULL, },
+        { 0xc9576c1204f83042ULL, 0xd91d3e4709b06e36ULL, },
+        { 0x01f36d90f9441446ULL, 0x0286cfede5f4db15ULL, },
+        { 0x0012474d242f32a9ULL, 0x13f2a8f51ca9cd91ULL, },
+        { 0x0144b48a04a7d0ddULL, 0x124b1c4e04fa8e45ULL, },
+        { 0xfe2a6f6923268793ULL, 0x179e9377ef4766beULL, },
+        { 0x2f1518bcce21d93eULL, 0x0934568af4ec6499ULL, },    /*  72  */
+        { 0x0144b48a04a7d0ddULL, 0x124b1c4e04fa8e45ULL, },
+        { 0x352c988848431561ULL, 0x12e4f841217b42c9ULL, },
+        { 0xd437b4e8f3b0139fULL, 0x08c7d980187d5896ULL, },
+        { 0xc9576c1204f83042ULL, 0xd91d3e4709b06e36ULL, },
+        { 0xfe2a6f6923268793ULL, 0x179e9377ef4766beULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DOTP_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DOTP_S_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
new file mode 100644
index 0000000..e998e00
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DOTP_U.D
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
+    char *instruction_name = "DOTP_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xfffffffc00000002ULL, 0xfffffffc00000002ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x55555552aaaaaaacULL, 0x55555552aaaaaaacULL, },
+        { 0xaaaaaaa955555556ULL, 0xaaaaaaa955555556ULL, },
+        { 0x9999999666666668ULL, 0x9999999666666668ULL, },
+        { 0x666666659999999aULL, 0x666666659999999aULL, },
+        { 0x71c71c6f8e38e38fULL, 0x1c71c719e38e38e5ULL, },
+        { 0x8e38e38c71c71c73ULL, 0xe38e38e21c71c71dULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x55555552aaaaaaacULL, 0x55555552aaaaaaacULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e1c71c71c8ULL, 0xe38e38e1c71c71c8ULL, },
+        { 0x71c71c70e38e38e4ULL, 0x71c71c70e38e38e4ULL, },
+        { 0x1111110eeeeeeef0ULL, 0x1111110eeeeeeef0ULL, },
+        { 0x44444443bbbbbbbcULL, 0x44444443bbbbbbbcULL, },
+        { 0xf684bd9fb425ed0aULL, 0xbda12f6697b425eeULL, },
+        { 0x5ed097b2f684bda2ULL, 0x97b425ec12f684beULL, },
+        { 0xaaaaaaa955555556ULL, 0xaaaaaaa955555556ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x71c71c70e38e38e4ULL, 0x71c71c70e38e38e4ULL, },
+        { 0x38e38e3871c71c72ULL, 0x38e38e3871c71c72ULL, },
+        { 0x8888888777777778ULL, 0x8888888777777778ULL, },
+        { 0x22222221dddddddeULL, 0x22222221dddddddeULL, },
+        { 0x7b425ecfda12f685ULL, 0x5ed097b34bda12f7ULL, },
+        { 0x2f684bd97b425ed1ULL, 0x4bda12f6097b425fULL, },
+        { 0x9999999666666668ULL, 0x9999999666666668ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1111110eeeeeeef0ULL, 0x1111110eeeeeeef0ULL, },
+        { 0x8888888777777778ULL, 0x8888888777777778ULL, },
+        { 0x47ae147851eb8520ULL, 0x47ae147851eb8520ULL, },
+        { 0x51eb851e147ae148ULL, 0x51eb851e147ae148ULL, },
+        { 0x27d27d260b60b60cULL, 0xe38e38e182d82d84ULL, },
+        { 0x71c71c705b05b05cULL, 0xb60b60b4e38e38e4ULL, },
+        { 0x666666659999999aULL, 0x666666659999999aULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x44444443bbbbbbbcULL, 0x44444443bbbbbbbcULL, },
+        { 0x22222221dddddddeULL, 0x22222221dddddddeULL, },
+        { 0x51eb851e147ae148ULL, 0x51eb851e147ae148ULL, },
+        { 0x147ae147851eb852ULL, 0x147ae147851eb852ULL, },
+        { 0x49f49f4982d82d83ULL, 0x38e38e3860b60b61ULL, },
+        { 0x1c71c71c16c16c17ULL, 0x2d82d82d38e38e39ULL, },
+        { 0x71c71c6f8e38e38fULL, 0x1c71c719e38e38e5ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xf684bd9fb425ed0aULL, 0xbda12f6697b425eeULL, },
+        { 0x7b425ecfda12f685ULL, 0x5ed097b34bda12f7ULL, },
+        { 0x27d27d260b60b60cULL, 0xe38e38e182d82d84ULL, },
+        { 0x49f49f4982d82d83ULL, 0x38e38e3860b60b61ULL, },
+        { 0x1948b0fb9add3c0dULL, 0xd6e9e063c0ca4589ULL, },
+        { 0x587e6b73f35ba782ULL, 0x4587e6b622c3f35cULL, },
+        { 0x8e38e38c71c71c73ULL, 0xe38e38e21c71c71dULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5ed097b2f684bda2ULL, 0x97b425ec12f684beULL, },
+        { 0x2f684bd97b425ed1ULL, 0x4bda12f6097b425fULL, },
+        { 0x71c71c705b05b05cULL, 0xb60b60b4e38e38e4ULL, },
+        { 0x1c71c71c16c16c17ULL, 0x2d82d82d38e38e39ULL, },
+        { 0x587e6b73f35ba782ULL, 0x4587e6b622c3f35cULL, },
+        { 0x35ba78187e6b74f1ULL, 0x9e06522bf9add3c1ULL, },
+        { 0x4f10a2461266c290ULL, 0x132f373daebdb714ULL, },    /*  64  */
+        { 0x9262f356f7d6aae4ULL, 0x1ab54eb3f08ff55cULL, },
+        { 0x7927f2d937c84b78ULL, 0xb5e40e840fde8392ULL, },
+        { 0x4ab4e3ab9f696cdcULL, 0xd21109f6644a26d0ULL, },
+        { 0x9262f356f7d6aae4ULL, 0x1ab54eb3f08ff55cULL, },
+        { 0x0f105ccfb2e19689ULL, 0x032b395187d966b4ULL, },
+        { 0xe1cb8469b5aa67beULL, 0x1128ae6a67ae6296ULL, },
+        { 0x8afc46ad9bff5437ULL, 0x1890b25301b40370ULL, },
+        { 0x7927f2d937c84b78ULL, 0xb5e40e840fde8392ULL, },    /*  72  */
+        { 0xe1cb8469b5aa67beULL, 0x1128ae6a67ae6296ULL, },
+        { 0xfae79ab59bb7c8e4ULL, 0x78a66f004d163b91ULL, },
+        { 0x8ffb559e72a2a622ULL, 0x8744321b668933a8ULL, },
+        { 0x4ab4e3ab9f696cdcULL, 0xd21109f6644a26d0ULL, },
+        { 0x8afc46ad9bff5437ULL, 0x1890b25301b40370ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DOTP_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DOTP_U_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
new file mode 100644
index 0000000..e8db601
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DOTP_U.H
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
+    char *instruction_name = "DOTP_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xfc02fc02fc02fc02ULL, 0xfc02fc02fc02fc02ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x52ac52ac52ac52acULL, 0x52ac52ac52ac52acULL, },
+        { 0xa956a956a956a956ULL, 0xa956a956a956a956ULL, },
+        { 0x9668966896689668ULL, 0x9668966896689668ULL, },
+        { 0x659a659a659a659aULL, 0x659a659a659a659aULL, },
+        { 0x6f8f19e5c53a6f8fULL, 0x19e5c53a6f8f19e5ULL, },
+        { 0x8c73e21d36c88c73ULL, 0xe21d36c88c73e21dULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x52ac52ac52ac52acULL, 0x52ac52ac52ac52acULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe1c8e1c8e1c8e1c8ULL, 0xe1c8e1c8e1c8e1c8ULL, },
+        { 0x70e470e470e470e4ULL, 0x70e470e470e470e4ULL, },
+        { 0x0ef00ef00ef00ef0ULL, 0x0ef00ef00ef00ef0ULL, },
+        { 0x43bc43bc43bc43bcULL, 0x43bc43bc43bc43bcULL, },
+        { 0xf50abbee837cf50aULL, 0xbbee837cf50abbeeULL, },
+        { 0x5da296becf305da2ULL, 0x96becf305da296beULL, },
+        { 0xa956a956a956a956ULL, 0xa956a956a956a956ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x70e470e470e470e4ULL, 0x70e470e470e470e4ULL, },
+        { 0x3872387238723872ULL, 0x3872387238723872ULL, },
+        { 0x8778877887788778ULL, 0x8778877887788778ULL, },
+        { 0x21de21de21de21deULL, 0x21de21de21de21deULL, },
+        { 0x7a855df741be7a85ULL, 0x5df741be7a855df7ULL, },
+        { 0x2ed14b5f67982ed1ULL, 0x4b5f67982ed14b5fULL, },
+        { 0x9668966896689668ULL, 0x9668966896689668ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0ef00ef00ef00ef0ULL, 0x0ef00ef00ef00ef0ULL, },
+        { 0x8778877887788778ULL, 0x8778877887788778ULL, },
+        { 0x4520452045204520ULL, 0x4520452045204520ULL, },
+        { 0x5148514851485148ULL, 0x5148514851485148ULL, },
+        { 0x260ce1849dc8260cULL, 0xe1849dc8260ce184ULL, },
+        { 0x705cb4e4f8a0705cULL, 0xb4e4f8a0705cb4e4ULL, },
+        { 0x659a659a659a659aULL, 0x659a659a659a659aULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x43bc43bc43bc43bcULL, 0x43bc43bc43bc43bcULL, },
+        { 0x21de21de21de21deULL, 0x21de21de21de21deULL, },
+        { 0x5148514851485148ULL, 0x5148514851485148ULL, },
+        { 0x1452145214521452ULL, 0x1452145214521452ULL, },
+        { 0x4983386127724983ULL, 0x3861277249833861ULL, },
+        { 0x1c172d393e281c17ULL, 0x2d393e281c172d39ULL, },
+        { 0x6f8f19e5c53a6f8fULL, 0x19e5c53a6f8f19e5ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xf50abbee837cf50aULL, 0xbbee837cf50abbeeULL, },
+        { 0x7a855df741be7a85ULL, 0x5df741be7a855df7ULL, },
+        { 0x260ce1849dc8260cULL, 0xe1849dc8260ce184ULL, },
+        { 0x4983386127724983ULL, 0x3861277249833861ULL, },
+        { 0x180dd5895b04180dULL, 0xd5895b04180dd589ULL, },
+        { 0x5782445c6a365782ULL, 0x445c6a365782445cULL, },
+        { 0x8c73e21d36c88c73ULL, 0xe21d36c88c73e21dULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5da296becf305da2ULL, 0x96becf305da296beULL, },
+        { 0x2ed14b5f67982ed1ULL, 0x4b5f67982ed14b5fULL, },
+        { 0x705cb4e4f8a0705cULL, 0xb4e4f8a0705cb4e4ULL, },
+        { 0x1c172d393e281c17ULL, 0x2d393e281c172d39ULL, },
+        { 0x5782445c6a365782ULL, 0x445c6a365782445cULL, },
+        { 0x34f19dc1cc9234f1ULL, 0x9dc1cc9234f19dc1ULL, },
+        { 0x742471342bc42c39ULL, 0x3f6a22fd371d7990ULL, },    /*  64  */
+        { 0xd4044ee4444e4413ULL, 0x68a71195331b4430ULL, },
+        { 0x80a423cc6c264e27ULL, 0x62556624be531a60ULL, },
+        { 0x5c36512021725e8aULL, 0x8a465528c764a2e0ULL, },
+        { 0xd4044ee4444e4413ULL, 0x68a71195331b4430ULL, },
+        { 0x831d26496b929af1ULL, 0xef958b3d113a1254ULL, },
+        { 0xeb7041beae82700dULL, 0xd326aa88189c1f8aULL, },
+        { 0xa8721dc73869b21eULL, 0xf27179481e1be5e4ULL, },
+        { 0x80a423cc6c264e27ULL, 0x62556624be531a60ULL, },    /*  72  */
+        { 0xeb7041beae82700dULL, 0xd326aa88189c1f8aULL, },
+        { 0x9334e7282d128b79ULL, 0xbc319725797206e9ULL, },
+        { 0x670642166b8da1b6ULL, 0xe0d340587bf92d2aULL, },
+        { 0x5c36512021725e8aULL, 0x8a465528c764a2e0ULL, },
+        { 0xa8721dc73869b21eULL, 0xf27179481e1be5e4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DOTP_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DOTP_U_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
new file mode 100644
index 0000000..cf5bd13
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction DOTP_U.W
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
+    char *instruction_name = "DOTP_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xfffc0002fffc0002ULL, 0xfffc0002fffc0002ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5552aaac5552aaacULL, 0x5552aaac5552aaacULL, },
+        { 0xaaa95556aaa95556ULL, 0xaaa95556aaa95556ULL, },
+        { 0x9996666899966668ULL, 0x9996666899966668ULL, },
+        { 0x6665999a6665999aULL, 0x6665999a6665999aULL, },
+        { 0x1c6fe38f71c48e3aULL, 0xc71a38e51c6fe38fULL, },
+        { 0xe38c1c738e3771c8ULL, 0x38e1c71de38c1c73ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5552aaac5552aaacULL, 0x5552aaac5552aaacULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38c71c8e38c71c8ULL, 0xe38c71c8e38c71c8ULL, },
+        { 0x71c638e471c638e4ULL, 0x71c638e471c638e4ULL, },
+        { 0x110eeef0110eeef0ULL, 0x110eeef0110eeef0ULL, },
+        { 0x4443bbbc4443bbbcULL, 0x4443bbbc4443bbbcULL, },
+        { 0xbd9fed0af683097cULL, 0x84bc25eebd9fed0aULL, },
+        { 0x97b2bda25ecfa130ULL, 0xd09684be97b2bda2ULL, },
+        { 0xaaa95556aaa95556ULL, 0xaaa95556aaa95556ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x71c638e471c638e4ULL, 0x71c638e471c638e4ULL, },
+        { 0x38e31c7238e31c72ULL, 0x38e31c7238e31c72ULL, },
+        { 0x8887777888877778ULL, 0x8887777888877778ULL, },
+        { 0x2221ddde2221dddeULL, 0x2221ddde2221dddeULL, },
+        { 0x5ecff6857b4184beULL, 0x425e12f75ecff685ULL, },
+        { 0x4bd95ed12f67d098ULL, 0x684b425f4bd95ed1ULL, },
+        { 0x9996666899966668ULL, 0x9996666899966668ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x110eeef0110eeef0ULL, 0x110eeef0110eeef0ULL, },
+        { 0x8887777888877778ULL, 0x8887777888877778ULL, },
+        { 0x47ab852047ab8520ULL, 0x47ab852047ab8520ULL, },
+        { 0x51eae14851eae148ULL, 0x51eae14851eae148ULL, },
+        { 0xe38cb60c27d071c8ULL, 0x9f482d84e38cb60cULL, },
+        { 0xb609b05c71c5f4a0ULL, 0xfa4e38e4b609b05cULL, },
+        { 0x6665999a6665999aULL, 0x6665999a6665999aULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4443bbbc4443bbbcULL, 0x4443bbbc4443bbbcULL, },
+        { 0x2221ddde2221dddeULL, 0x2221ddde2221dddeULL, },
+        { 0x51eae14851eae148ULL, 0x51eae14851eae148ULL, },
+        { 0x147ab852147ab852ULL, 0x147ab852147ab852ULL, },
+        { 0x38e32d8349f41c72ULL, 0x27d20b6138e32d83ULL, },
+        { 0x2d826c171c717d28ULL, 0x3e938e392d826c17ULL, },
+        { 0x1c6fe38f71c48e3aULL, 0xc71a38e51c6fe38fULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xbd9fed0af683097cULL, 0x84bc25eebd9fed0aULL, },
+        { 0x5ecff6857b4184beULL, 0x425e12f75ecff685ULL, },
+        { 0xe38cb60c27d071c8ULL, 0x9f482d84e38cb60cULL, },
+        { 0x38e32d8349f41c72ULL, 0x27d20b6138e32d83ULL, },
+        { 0xd6e93c0d19474f04ULL, 0x5ba64589d6e93c0dULL, },
+        { 0x4586a782587d3f36ULL, 0x6b73f35c4586a782ULL, },
+        { 0xe38c1c738e3771c8ULL, 0x38e1c71de38c1c73ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x97b2bda25ecfa130ULL, 0xd09684be97b2bda2ULL, },
+        { 0x4bd95ed12f67d098ULL, 0x684b425f4bd95ed1ULL, },
+        { 0xb609b05c71c5f4a0ULL, 0xfa4e38e4b609b05cULL, },
+        { 0x2d826c171c717d28ULL, 0x3e938e392d826c17ULL, },
+        { 0x4586a782587d3f36ULL, 0x6b73f35c4586a782ULL, },
+        { 0x9e0574f135ba3292ULL, 0xcd6dd3c19e0574f1ULL, },
+        { 0x18c3fe7422c25584ULL, 0x16b6b9f57608cfa9ULL, },    /*  64  */
+        { 0x867e6d904e841446ULL, 0x0de4cfed4e2fdb15ULL, },
+        { 0xf94f18bc4bc3d93eULL, 0x1492568ac3a66499ULL, },
+        { 0x4ff36c125a383042ULL, 0x2fe23e4744196e36ULL, },
+        { 0x867e6d904e841446ULL, 0x0de4cfed4e2fdb15ULL, },
+        { 0xf78e474db23f32a9ULL, 0x8a26a8f51ca9cd91ULL, },
+        { 0xa9bfb48aa4c2d0ddULL, 0x94641c4e1a398e45ULL, },
+        { 0x6e796f69cc7c8793ULL, 0x6e879377578266beULL, },
+        { 0xf94f18bc4bc3d93eULL, 0x1492568ac3a66499ULL, },    /*  72  */
+        { 0xa9bfb48aa4c2d0ddULL, 0x94641c4e1a398e45ULL, },
+        { 0xeb349888d2e11561ULL, 0xa0e2f84177d142c9ULL, },
+        { 0x5ad3b4e8bfaf139fULL, 0x8076d98091fe5896ULL, },
+        { 0x4ff36c125a383042ULL, 0x2fe23e4744196e36ULL, },
+        { 0x6e796f69cc7c8793ULL, 0x6e879377578266beULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DOTP_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DOTP_U_W(b128_random[i], b128_random[j],
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
