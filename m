Received: from eggs.gnu.org ([2001:4830:134:3::10]:36147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fbCA4-0000Tr-4N
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 17:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fbCA1-0000G5-1S
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 17:51:36 -0400
Received: from smtp39.i.mail.ru ([94.100.177.99]:58784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fbCA0-0000F7-Pe
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 17:51:32 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Fri,  6 Jul 2018 00:50:52 +0300
Message-Id: <20180705215052.8795-3-jusual@mail.ru>
In-Reply-To: <20180705215052.8795-1-jusual@mail.ru>
References: <20180705215052.8795-1-jusual@mail.ru>
Subject: [Qemu-devel] [RFC v2 2/2] tests: Add ARMv6-M reserved register test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Check that reserved SCS registers return 0 at read,
and writes are ignored.

Based-on: <20180627143815.1829-1-joel@jms.id.au>
Based-on: <20180630091343.14391-1-stefanha@redhat.com>

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
Test will work if Joel's patches will use ARMv6-M.

 tests/Makefile.include            |  2 ++
 tests/tcg/arm/test-reserved-reg.c | 60 +++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 tests/tcg/arm/test-reserved-reg.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d323c42682..8ab0b0d15f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -387,6 +387,7 @@ gcov-files-arm-y += hw/timer/arm_mptimer.c
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/sdhci-test$(EXESUF)
 check-qtest-arm-y += tests/hexloader-test$(EXESUF)
+check-qtest-arm-y += tests/tcg/arm/test-reserved-reg$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
@@ -771,6 +772,7 @@ tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
 tests/rtc-test$(EXESUF): tests/rtc-test.o
 tests/m48t59-test$(EXESUF): tests/m48t59-test.o
 tests/hexloader-test$(EXESUF): tests/hexloader-test.o
+tests/test-reserved-reg$(EXESUF): tests/tcg/arm/test-reserved-reg.o
 tests/endianness-test$(EXESUF): tests/endianness-test.o
 tests/spapr-phb-test$(EXESUF): tests/spapr-phb-test.o $(libqos-obj-y)
 tests/prom-env-test$(EXESUF): tests/prom-env-test.o $(libqos-obj-y)
diff --git a/tests/tcg/arm/test-reserved-reg.c b/tests/tcg/arm/test-reserved-reg.c
new file mode 100644
index 0000000000..97273ff24d
--- /dev/null
+++ b/tests/tcg/arm/test-reserved-reg.c
@@ -0,0 +1,60 @@
+/*
+ * Test ARMv6-M SCS reserved registers
+ *
+ * Copyright (c) 2018 Julia Suvorova <jusual@mail.ru>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2
+ * or later. See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+static void test_reserved_reg(void)
+{
+    QTestState *s;
+    int i;
+    static const uint64_t reserved_reg[] = { 0xe000ed10, /* SCR */
+                                             0xe000ed18, /* SHPR1 */
+                                             0xe000ed28, /* CFSR */
+                                             0xe000ed2c, /* HFSR */
+                                             0xe000ed34, /* MMFAR */
+                                             0xe000ed38, /* BFAR */
+                                             0xe000ed3c, /* AFSR */
+                                             0xe000ed40, /* CPUID */
+                                             0xe000ed88, /* CPACR */
+                                             0xe000ef00  /* STIR */ };
+    static const uint8_t mini_kernel[] = { 0x00, 0x00, 0x00, 0x00,
+                                           0x09, 0x00, 0x00, 0x00 };
+    ssize_t wlen, kernel_size = sizeof(mini_kernel);
+    int code_fd;
+    char codetmp[] = "/tmp/reserved-reg-test-XXXXXX";
+
+    code_fd = mkstemp(codetmp);
+    wlen = write(code_fd, mini_kernel, sizeof(mini_kernel));
+    g_assert(wlen == kernel_size);
+    close(code_fd);
+
+    s = qtest_startf("-kernel %s -M microbit -nographic", codetmp);
+
+    for (i = 0; i < ARRAY_SIZE(reserved_reg); i++) {
+        int res;
+        qtest_writel(s, reserved_reg[i], 1);
+        res = qtest_readl(s, reserved_reg[i]);
+        g_assert(!res);
+    }
+
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("tcg/arm/test-reserved-reg", test_reserved_reg);
+    ret = g_test_run();
+
+    return ret;
+}
-- 
2.17.1
