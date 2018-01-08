Received: from eggs.gnu.org ([2001:4830:134:3::10]:42257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZbK-00027S-4B
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZbG-0007h1-VS
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:38 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 12:42:46 -0300
Message-Id: <20180108154303.6522-15-f4bug@amsat.org>
In-Reply-To: <20180108154303.6522-1-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 14/31] sdhci: add qtest to check the SD Spec
 version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <saipava@xilinx.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

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
index 77f8183117..2d7058ca4c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -357,6 +357,7 @@ check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
 gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
+check-qtest-arm-y += tests/sdhci-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 
@@ -612,6 +613,7 @@ tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF) $(tes
 tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)
 tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
+tests/sdhci-test$(EXESUF): tests/sdhci-test.o
 
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
-- 
2.15.1
