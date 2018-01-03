Received: from eggs.gnu.org ([2001:4830:134:3::10]:33979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsX-0003PO-95
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsT-0007UJ-50
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:05 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsT-0007UD-1A
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:01 -0500
Received: by mail-qk0-x242.google.com with SMTP id p13so2661318qke.4
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:35:00 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:34:05 -0300
Message-Id: <20180103183418.23730-13-f4bug@amsat.org>
In-Reply-To: <20180103183418.23730-1-f4bug@amsat.org>
References: <20180103183418.23730-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 12/25] sdhci: add qtest to check the SD Spec
 version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

with check_specs_version()

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/sdhci-test.c     | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |  2 ++
 2 files changed, 84 insertions(+)
 create mode 100644 tests/sdhci-test.c

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
new file mode 100644
index 0000000000..492b332588
--- /dev/null
+++ b/tests/sdhci-test.c
@@ -0,0 +1,82 @@
+/*
+ * QTest testcase for SDHCI controllers
+ *
+ * Written by Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define SDHC_HCVER                      0xFE
+
+static const struct sdhci_t {
+    const char *arch;
+    const char *machine;
+    struct {
+        uintptr_t addr;
+        uint8_t version;
+        uint8_t baseclock;
+        struct {
+            bool sdma;
+            uint64_t reg;
+        } capab;
+    } sdhci;
+} models[] = {
+    /* Exynos4210 */
+    { "arm",    "smdkc210",
+        {0x12510000, 2, 0, {1, 0x5e80080} } },
+
+    /* Zynq-7000 */
+    { "arm",    "xilinx-zynq-a9",
+        {0xe0100000, 2, 0, {1, 0x01790080} } },
+};
+
+static uint32_t sdhci_readl(uintptr_t base, uint32_t reg_addr)
+{
+    QTestState *qtest = global_qtest;
+
+    return qtest_readl(qtest, base + reg_addr);
+}
+
+static void check_specs_version(uintptr_t addr, uint8_t version)
+{
+    uint32_t v;
+
+    v = sdhci_readl(addr, SDHC_HCVER);
+    v &= 0xff;
+    v += 1;
+    g_assert_cmpuint(v, ==, version);
+}
+
+static void test_machine(const void *data)
+{
+    const struct sdhci_t *test = data;
+
+    global_qtest = qtest_startf("-machine %s -d unimp", test->machine);
+
+    check_specs_version(test->sdhci.addr, test->sdhci.version);
+
+    qtest_quit(global_qtest);
+}
+
+int main(int argc, char *argv[])
+{
+    const char *arch = qtest_get_arch();
+    char *name;
+    int i;
+
+    g_test_init(&argc, &argv, NULL);
+
+    for (i = 0; i < ARRAY_SIZE(models); i++) {
+        if (strcmp(arch, models[i].arch)) {
+            continue;
+        }
+        name = g_strdup_printf("sdhci/%s", models[i].machine);
+        qtest_add_data_func(name, &models[i], test_machine);
+        g_free(name);
+    }
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c002352134..af7f324e07 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -355,6 +355,7 @@ check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
 gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
+check-qtest-arm-y += tests/sdhci-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 
@@ -609,6 +610,7 @@ tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF) $(tes
 tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)
 tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
+tests/sdhci-test$(EXESUF): tests/sdhci-test.o
 
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
-- 
2.15.1
