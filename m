Received: from eggs.gnu.org ([2001:4830:134:3::10]:55090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7q-0002wh-8t
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7p-0001eF-7o
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:02 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7p-0001eB-4f
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:00:01 -0400
Received: by mail-qt0-x243.google.com with SMTP id e8-v6so23084733qth.0
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:00:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:09 -0300
Message-Id: <20180504155918.21287-12-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/20] sdcard: Add test_sd_request_frame_crc7()
 qtest (request command CRC7)
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/sdcard-test.c    | 54 ++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100644 tests/sdcard-test.c

diff --git a/tests/sdcard-test.c b/tests/sdcard-test.c
new file mode 100644
index 0000000000..1358ee28c6
--- /dev/null
+++ b/tests/sdcard-test.c
@@ -0,0 +1,54 @@
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
+static void sd_prepare_request48(SDFrame48 *frame, uint8_t cmd, uint32_t arg)
+{
+    sd_prepare_request(frame, cmd, arg, /* gen_crc */ true);
+}
+
+static void test_sd_request_frame_crc7(void)
+{
+    SDFrame48 frame;
+
+    /* CMD0 */
+    sd_prepare_request48(&frame, 0, 0);
+    g_assert_cmphex(frame.crc, ==, 0b1001010);
+
+    /* CMD17 */
+    sd_prepare_request48(&frame, 17, 0);
+    g_assert_cmphex(frame.crc, ==, 0b0101010);
+
+    /* APP_CMD */
+    sd_prepare_request48(&frame, 55, 0);
+    g_assert_cmphex(frame.crc, ==, 0x32);
+
+    /* ACMD41 SEND_OP_COND */
+    sd_prepare_request48(&frame, 41, 0x00100000);
+    g_assert_cmphex(frame.crc, ==, 0x5f >> 1);
+
+    /* CMD2 ALL_SEND_CID */
+    sd_prepare_request48(&frame, 2, 0);
+    g_assert_cmphex(frame.crc, ==, 0x4d >> 1);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("sd/req_crc7", test_sd_request_frame_crc7);
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b9a5e31a2..6a70a1dbab 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -380,6 +380,7 @@ check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/sdhci-test$(EXESUF)
+check-qtest-arm-y += tests/sdcard-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
@@ -835,6 +836,7 @@ tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
 tests/sdhci-test$(EXESUF): tests/sdhci-test.o $(libqos-pc-obj-y)
+tests/sdcard-test$(EXESUF): tests/sdcard-test.o hw/sd/sdmmc-internal.o
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
-- 
2.17.0
