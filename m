Received: from eggs.gnu.org ([2001:4830:134:3::10]:36216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3NtJ-00043s-SQ
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3NtG-0002ab-LZ
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:30:33 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:39001 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3NtG-0002Yd-0t
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:30:30 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Tue,  3 Apr 2018 23:30:26 +0800
Message-Id: <1522769426-6056-3-git-send-email-suhang16@mails.ucas.ac.cn>
In-Reply-To: <1522769426-6056-1-git-send-email-suhang16@mails.ucas.ac.cn>
References: <1522769426-6056-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] [PATCH 2/2] Add QTest testcase for the Hex File Loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org

'test.hex' file is a bare metal ARM software stored in Hexadecimal
Object Format. When it's loaded by QEMU, it will print "Hello world!\n"
on console.

`pre_store` array in 'hexloader-test.c' file, stores the binary format
of 'test.hex' file, which is used to verify correctness.

Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
 tests/Makefile.include |  2 ++
 tests/hexloader-test.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/test.hex         | 11 ++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 tests/hexloader-test.c
 create mode 100644 tests/test.hex

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b9a5e31a2c2..f4a3e71f34ee 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -380,6 +380,7 @@ check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/sdhci-test$(EXESUF)
+check-qtest-arm-y += tests/hexloader-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
@@ -755,6 +756,7 @@ tests/qmp-test$(EXESUF): tests/qmp-test.o
 tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
 tests/rtc-test$(EXESUF): tests/rtc-test.o
 tests/m48t59-test$(EXESUF): tests/m48t59-test.o
+tests/hexloader-test$(EXESUF): tests/hexloader-test.o
 tests/endianness-test$(EXESUF): tests/endianness-test.o
 tests/spapr-phb-test$(EXESUF): tests/spapr-phb-test.o $(libqos-obj-y)
 tests/prom-env-test$(EXESUF): tests/prom-env-test.o $(libqos-obj-y)
diff --git a/tests/hexloader-test.c b/tests/hexloader-test.c
new file mode 100644
index 000000000000..b1a491dcd9de
--- /dev/null
+++ b/tests/hexloader-test.c
@@ -0,0 +1,56 @@
+/*
+ * QTest testcase for the Intel Hexadecimal Object File Loader
+ *
+ * Authors:
+ *  Su Hang <suhang16@mails.ucas.ac.cn> 2018
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define BIN_SIZE 146
+
+static unsigned char pre_store[BIN_SIZE] = {
+    4,   208, 159, 229, 22,  0,   0,   235, 254, 255, 255, 234, 152, 16,  1,
+    0,   4,   176, 45,  229, 0,   176, 141, 226, 12,  208, 77,  226, 8,   0,
+    11,  229, 6,   0,   0,   234, 8,   48,  27,  229, 0,   32,  211, 229, 44,
+    48,  159, 229, 0,   32,  131, 229, 8,   48,  27,  229, 1,   48,  131, 226,
+    8,   48,  11,  229, 8,   48,  27,  229, 0,   48,  211, 229, 0,   0,   83,
+    227, 244, 255, 255, 26,  0,   0,   160, 225, 0,   208, 139, 226, 4,   176,
+    157, 228, 30,  255, 47,  225, 0,   16,  31,  16,  0,   72,  45,  233, 4,
+    176, 141, 226, 8,   0,   159, 229, 230, 255, 255, 235, 0,   0,   160, 225,
+    0,   136, 189, 232, 132, 0,   1,   0,   0,   16,  31,  16,  72,  101, 108,
+    108, 111, 32,  119, 111, 114, 108, 100, 33,  10,  0};
+
+/* success if no crash or abort */
+static void hex_loader_test(void)
+{
+    unsigned int i;
+    unsigned char memory_content[BIN_SIZE];
+    const unsigned int base_addr = 0x00010000;
+
+    QTestState *s = qtest_startf(
+        "-M versatilepb -m 128M -nographic -kernel ../tests/test.hex");
+
+    for (i = 0; i < BIN_SIZE; ++i) {
+        memory_content[i] = qtest_readb(s, base_addr + i);
+        g_assert_cmpuint(memory_content[i], ==, pre_store[i]);
+    }
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/tmp/hex_loader", hex_loader_test);
+    ret = g_test_run();
+
+    return ret;
+}
diff --git a/tests/test.hex b/tests/test.hex
new file mode 100644
index 000000000000..59b96e3e6fa7
--- /dev/null
+++ b/tests/test.hex
@@ -0,0 +1,11 @@
+:1000000004D09FE5160000EBFEFFFFEA9810010008
+:1000100004B02DE500B08DE20CD04DE208000BE5F8
+:10002000060000EA08301BE50020D3E52C309FE5F0
+:10003000002083E508301BE5013083E208300BE542
+:1000400008301BE50030D3E5000053E3F4FFFF1A4E
+:100050000000A0E100D08BE204B09DE41EFF2FE180
+:1000600000101F1000482DE904B08DE208009FE544
+:10007000E6FFFFEB0000A0E10088BDE8840001007E
+:1000800000101F1048656C6C6F20776F726C6421D4
+:020090000A0064
+:00000001FF
-- 
2.7.4
