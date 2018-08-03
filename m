Received: from eggs.gnu.org ([2001:4830:134:3::10]:49925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1flbMp-0002rL-LF
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 10:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1flbMo-0007ko-6o
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 10:47:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  3 Aug 2018 15:47:21 +0100
Message-Id: <20180803144721.17036-7-stefanha@redhat.com>
In-Reply-To: <20180803144721.17036-1-stefanha@redhat.com>
References: <20180803144721.17036-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v4 6/6] Add QTest testcase for the Intel
 Hexadecimal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jim@groklearning.com, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org, jusual@mail.ru, Alistair Francis <alistair@alistair23.me>, mail@steffen-goertz.de, ilg@livius.net, Su Hang <suhang16@mails.ucas.ac.cn>, Steffen Gortz <qemu.ml@steffen-goertz.de>, Stefan Hajnoczi <stefanha@redhat.com>

From: Su Hang <suhang16@mails.ucas.ac.cn>

'test.hex' file is a bare metal ARM software stored in Hexadecimal
Object Format. When it's loaded by QEMU, it will print "Hello world!\n"
on console.

`pre_store` array in 'hexloader-test.c' file, stores the binary format
of 'test.hex' file, which is used to verify correctness.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Suggested-by: Steffen Gortz <qemu.ml@steffen-goertz.de>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS                          |  6 +++
 configure                            |  4 ++
 tests/Makefile.include               |  2 +
 tests/hexloader-test.c               | 60 ++++++++++++++++++++++++++++
 tests/hex-loader-check-data/test.hex | 12 ++++++
 5 files changed, 84 insertions(+)
 create mode 100644 tests/hexloader-test.c
 create mode 100644 tests/hex-loader-check-data/test.hex

diff --git a/MAINTAINERS b/MAINTAINERS
index 666e936812..c48d9271cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1323,6 +1323,12 @@ F: hw/core/generic-loader.c
 F: include/hw/core/generic-loader.h
 F: docs/generic-loader.txt
 
+Intel Hexadecimal Object File Loader
+M: Su Hang <suhang16@mails.ucas.ac.cn>
+S: Maintained
+F: tests/hexloader-test.c
+F: tests/hex-loader-check-data/test.hex
+
 CHRP NVRAM
 M: Thomas Huth <thuth@redhat.com>
 S: Maintained
diff --git a/configure b/configure
index 2a7796ea80..db97930314 100755
--- a/configure
+++ b/configure
@@ -7382,6 +7382,10 @@ for test_file in $(find $source_path/tests/acpi-test-data -type f)
 do
     FILES="$FILES tests/acpi-test-data$(echo $test_file | sed -e 's/.*acpi-test-data//')"
 done
+for test_file in $(find $source_path/tests/hex-loader-check-data -type f)
+do
+    FILES="$FILES tests/hex-loader-check-data$(echo $test_file | sed -e 's/.*hex-loader-check-data//')"
+done
 mkdir -p $DIRS
 for f in $FILES ; do
     if [ -e "$source_path/$f" ] && [ "$pwd_is_source_path" != "y" ]; then
diff --git a/tests/Makefile.include b/tests/Makefile.include
index a49282704e..760a0f18b6 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -386,6 +386,7 @@ check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/sdhci-test$(EXESUF)
+check-qtest-arm-y += tests/hexloader-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
@@ -773,6 +774,7 @@ tests/qmp-test$(EXESUF): tests/qmp-test.o
 tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
 tests/rtc-test$(EXESUF): tests/rtc-test.o
 tests/m48t59-test$(EXESUF): tests/m48t59-test.o
+tests/hexloader-test$(EXESUF): tests/hexloader-test.o
 tests/endianness-test$(EXESUF): tests/endianness-test.o
 tests/spapr-phb-test$(EXESUF): tests/spapr-phb-test.o $(libqos-obj-y)
 tests/prom-env-test$(EXESUF): tests/prom-env-test.o $(libqos-obj-y)
diff --git a/tests/hexloader-test.c b/tests/hexloader-test.c
new file mode 100644
index 0000000000..8818bd45f8
--- /dev/null
+++ b/tests/hexloader-test.c
@@ -0,0 +1,60 @@
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
+  0x04, 0xd0, 0x9f, 0xe5,   0x16, 0x00, 0x00, 0xeb,   0xfe, 0xff, 0xff, 0xea,
+  0x98, 0x10, 0x01, 0x00,   0x04, 0xb0, 0x2d, 0xe5,   0x00, 0xb0, 0x8d, 0xe2,
+  0x0c, 0xd0, 0x4d, 0xe2,   0x08, 0x00, 0x0b, 0xe5,   0x06, 0x00, 0x00, 0xea,
+  0x08, 0x30, 0x1b, 0xe5,   0x00, 0x20, 0xd3, 0xe5,   0x2c, 0x30, 0x9f, 0xe5,
+  0x00, 0x20, 0x83, 0xe5,   0x08, 0x30, 0x1b, 0xe5,   0x01, 0x30, 0x83, 0xe2,
+  0x08, 0x30, 0x0b, 0xe5,   0x08, 0x30, 0x1b, 0xe5,   0x00, 0x30, 0xd3, 0xe5,
+  0x00, 0x00, 0x53, 0xe3,   0xf4, 0xff, 0xff, 0x1a,   0x00, 0x00, 0xa0, 0xe1,
+  0x00, 0xd0, 0x8b, 0xe2,   0x04, 0xb0, 0x9d, 0xe4,   0x1e, 0xff, 0x2f, 0xe1,
+  0x00, 0x10, 0x1f, 0x10,   0x00, 0x48, 0x2d, 0xe9,   0x04, 0xb0, 0x8d, 0xe2,
+  0x08, 0x00, 0x9f, 0xe5,   0xe6, 0xff, 0xff, 0xeb,   0x00, 0x00, 0xa0, 0xe1,
+  0x00, 0x88, 0xbd, 0xe8,   0x84, 0x00, 0x01, 0x00,   0x00, 0x10, 0x1f, 0x10,
+  'H',  'e',  'l',  'l',    'o',  ' ',  'w',  'o',    'r',  'l',  'd',  '!',
+  '\n', '\0'
+};
+
+/* success if no crash or abort */
+static void hex_loader_test(void)
+{
+    unsigned int i;
+    unsigned char memory_content[BIN_SIZE];
+    const unsigned int base_addr = 0x00010000;
+
+    QTestState *s = qtest_startf(
+        "-M emcraft-sf2 -nographic -device loader,file=tests/hex-loader-check-data/test.hex");
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
diff --git a/tests/hex-loader-check-data/test.hex b/tests/hex-loader-check-data/test.hex
new file mode 100644
index 0000000000..7e99b452f5
--- /dev/null
+++ b/tests/hex-loader-check-data/test.hex
@@ -0,0 +1,12 @@
+:020000040001F9
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
2.17.1
