Received: from eggs.gnu.org ([2001:4830:134:3::10]:51243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fiFeZ-0008Lt-Js
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fiFeW-0002Yd-M3
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:00:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 25 Jul 2018 09:59:44 +0100
Message-Id: <20180725085944.11856-8-stefanha@redhat.com>
In-Reply-To: <20180725085944.11856-1-stefanha@redhat.com>
References: <20180725085944.11856-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 7/7] Add QTest testcase for the Intel
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
Cc: mail@steffen-goertz.de, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, ilg@livius.net, qemu-arm@nongnu.org, Julia Suvorova <jusual@mail.ru>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Steffen Gortz <qemu.ml@steffen-goertz.de>, jim@groklearning.com, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>

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
 tests/hexloader-test.c               | 56 ++++++++++++++++++++++++++++
 tests/hex-loader-check-data/test.hex | 12 ++++++
 5 files changed, 80 insertions(+)
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
index 0000000000..78b566f8b1
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
+        "-M emcraft-sf2 -nographic -kernel ./tests/hex-loader-check-data/test.hex");
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
