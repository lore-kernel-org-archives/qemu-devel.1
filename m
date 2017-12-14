Received: from eggs.gnu.org ([2001:4830:134:3::10]:53468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePIpR-0005q1-Sw
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePIpR-0003XZ-0U
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 21:00:53 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 23:00:20 -0300
Message-Id: <20171214020025.4004-4-f4bug@amsat.org>
In-Reply-To: <20171214020025.4004-1-f4bug@amsat.org>
References: <20171214020025.4004-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/8] sdhci: add qtest to check the SD Spec
 version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

read the HCVER register with check_specs_version()

Machines tested:
- Specs v2:
  smdkc210
- Specs v3:
  sabrelite
  raspi2
  xilinx-zynq-a9

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/sdhci-test.c     | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 tests/sdhci-test.c

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
new file mode 100644
index 0000000000..4ebe1e349b
--- /dev/null
+++ b/tests/sdhci-test.c
@@ -0,0 +1,74 @@
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
+    } sdhci;
+} models[] = {
+    { "arm",    "smdkc210",
+        {0x12510000, 2} },
+    { "arm",    "sabrelite",
+        {0x02190000, 3} },
+    { "arm",    "raspi2",           /* bcm2835 */
+        {0x3f300000, 3} },
+    { "arm",    "xilinx-zynq-a9",   /* exynos4210 */
+        {0xe0100000, 3} },
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
+    char *name;
+    int i;
+
+    g_test_init(&argc, &argv, NULL);
+
+    for (i = 0; i < ARRAY_SIZE(models); i++) {
+        name = g_strdup_printf("sdhci/%s", models[i].machine);
+        qtest_add_data_func(name, &models[i], test_machine);
+        g_free(name);
+    }
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4a1afcb499..c6c0a91827 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -355,6 +355,7 @@ check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
 gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
+check-qtest-arm-y += tests/sdhci-test$(EXESUF)
 check-qtest-arm-y += tests/sdcard_tests.py
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
-- 
2.15.1
