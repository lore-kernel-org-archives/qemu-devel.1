Received: from eggs.gnu.org ([2001:4830:134:3::10]:58502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4e-0004Ws-Vb
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4b-0002o6-U1
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:29 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4b-0002nA-OI
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:25 -0400
Received: by mail-qt0-x242.google.com with SMTP id q13-v6so43174505qtp.4
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:50 -0300
Message-Id: <20180509034658.26455-7-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/14] sdcard: Add
 test_sd_verify_cksum_frame136()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>

Per the Physical Layer Simplified Spec. "3.6 Bus Protocol":

  There are two types of Data packet format for the SD card.

  (1) Usual data (8-bit width): The usual data (8-bit width) are sent in
      LSB (Least Significant Byte) first, MSB (Most Significant Byte) last
      sequence. But in the individual byte, it is MSB (Most Significant Bit)
      first, LSB (Least Significant Bit) last.

  (2) Wide width data (SD Memory Register): The wide width data is shifted
      from the MSB bit.

Since the SD frames use different byte order, we use the lm32 target
for big-endian qtesting, and aarch64 for the little-endian qtesting.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/sdcard-test.c    | 35 +++++++++++++++++++++++++++++++++++
 tests/Makefile.include |  4 ++++
 2 files changed, 39 insertions(+)
 create mode 100644 tests/sdcard-test.c

diff --git a/tests/sdcard-test.c b/tests/sdcard-test.c
new file mode 100644
index 0000000000..c59af28382
--- /dev/null
+++ b/tests/sdcard-test.c
@@ -0,0 +1,35 @@
+/*
+ * QTest testcase for SD protocol and cards
+ *
+ * Examples taken from:
+ *
+ * - Physical Layer Simplified Specification (chap. 4.5: Cyclic Redundancy Code)
+ * - http://wiki.seabright.co.nz/wiki/SdCardProtocol.html
+ *
+ * Tests written by Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/sd/sd.h"
+
+static void test_sd_response_frame136_crc7(void)
+{
+    uint8_t buf[16];
+
+    /* response to CMD2 ALL_SEND_CID */
+    memcpy(&buf, "\x1d\x41\x44\x53\x44\x20\x20\x20\x10\xa0\x40\x0b\xc1\x00\x88",
+           sizeof(buf));
+    buf[15] = sd_frame136_calc_checksum(buf);
+    g_assert_cmphex(buf[15], ==, 0xad);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("sd/prepare_resp136_crc7", test_sd_response_frame136_crc7);
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b9a5e31a2..34230b150e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -384,6 +384,9 @@ check-qtest-arm-y += tests/sdhci-test$(EXESUF)
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
 check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
+check-qtest-aarch64-y += tests/sdcard-test$(EXESUF)
+
+check-qtest-lm32-y += tests/sdcard-test$(EXESUF)
 
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 
@@ -835,6 +838,7 @@ tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
 tests/sdhci-test$(EXESUF): tests/sdhci-test.o $(libqos-pc-obj-y)
+tests/sdcard-test$(EXESUF): tests/sdcard-test.o hw/sd/sdmmc-internal.o
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
-- 
2.17.0
