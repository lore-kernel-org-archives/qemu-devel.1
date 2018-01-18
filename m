Received: from eggs.gnu.org ([2001:4830:134:3::10]:37883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEyh-0006uN-8P
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEye-0003Bc-4Z
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:31:55 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEyd-0003BP-Vs
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:31:52 -0500
Received: by mail-qt0-x241.google.com with SMTP id z11so6783060qtm.3
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 10:31:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 15:30:53 -0300
Message-Id: <20180118183108.16009-2-f4bug@amsat.org>
In-Reply-To: <20180118183108.16009-1-f4bug@amsat.org>
References: <20180118183108.16009-1-f4bug@amsat.org>
In-Reply-To: <20180118182510.15630-1-f4bug@amsat.org>
References: <20180118182510.15630-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 02/17] sdhci: add qtest to check the SD
 capabilities register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

The PCI model is tested with the pc/x86_64 machine,
the SysBus model with the smdkc210/arm machine.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/sdhci-test.c     | 134 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |   3 ++
 2 files changed, 137 insertions(+)
 create mode 100644 tests/sdhci-test.c

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
new file mode 100644
index 0000000000..0db6b81545
--- /dev/null
+++ b/tests/sdhci-test.c
@@ -0,0 +1,134 @@
+/*
+ * QTest testcase for SDHCI controllers
+ *
+ * Written by Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "hw/registerfields.h"
+#include "libqtest.h"
+#include "libqos/pci-pc.h"
+#include "hw/pci/pci.h"
+
+#define SDHC_CAPAB                      0x40
+#define SDHC_HCVER                      0xFE
+
+static const struct sdhci_t {
+    const char *arch, *machine;
+    struct {
+        uintptr_t addr;
+        uint8_t version;
+        uint8_t baseclock;
+        struct {
+            bool sdma;
+            uint64_t reg;
+        } capab;
+    } sdhci;
+    struct {
+        uint16_t vendor_id, device_id;
+    } pci;
+} models[] = {
+    /* PC via PCI */
+    { "x86_64", "pc",
+        {-1,         2, 0, {1, 0x057834b4} },
+        .pci = { PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_SDHCI } },
+
+    /* Exynos4210 */
+    { "arm",    "smdkc210",
+        {0x12510000, 2, 0, {1, 0x5e80080} } },
+};
+
+static struct {
+    QPCIBus *pcibus;
+    QPCIDevice *dev;
+    QPCIBar mem_bar;
+} g = { };
+
+static uint64_t sdhci_readq(uintptr_t base, uint32_t reg_addr)
+{
+    if (g.dev) {
+        uint64_t value;
+
+        qpci_memread(g.dev, g.mem_bar, reg_addr, &value, sizeof(value));
+
+        return value;
+    } else {
+        QTestState *qtest = global_qtest;
+
+        return qtest_readq(qtest, base + reg_addr);
+    }
+}
+
+static void check_capab_capareg(uintptr_t addr, uint64_t expected_capab)
+{
+    uint64_t capab;
+
+    capab = sdhci_readq(addr, SDHC_CAPAB);
+    g_assert_cmphex(capab, ==, expected_capab);
+}
+
+static void machine_start(const struct sdhci_t *test)
+{
+    if (test->pci.vendor_id) {
+        /* PCI */
+        uint16_t vendor_id, device_id;
+        uint64_t barsize;
+
+        global_qtest = qtest_startf("-machine %s -d unimp -device sdhci-pci",
+                                    test->machine);
+
+        g.pcibus = qpci_init_pc(NULL);
+
+        /* Find PCI device and verify it's the right one */
+        g.dev = qpci_device_find(g.pcibus, QPCI_DEVFN(4, 0));
+        g_assert_nonnull(g.dev);
+        vendor_id = qpci_config_readw(g.dev, PCI_VENDOR_ID);
+        device_id = qpci_config_readw(g.dev, PCI_DEVICE_ID);
+        g_assert(vendor_id == test->pci.vendor_id);
+        g_assert(device_id == test->pci.device_id);
+        g.mem_bar = qpci_iomap(g.dev, 0, &barsize);
+        qpci_device_enable(g.dev);
+    } else {
+        /* SysBus */
+        global_qtest = qtest_startf("-machine %s -d unimp", test->machine);
+    }
+}
+
+static void machine_stop(void)
+{
+    g_free(g.dev);
+    qtest_quit(global_qtest);
+}
+
+static void test_machine(const void *data)
+{
+    const struct sdhci_t *test = data;
+
+    machine_start(test);
+
+    check_capab_capareg(test->sdhci.addr, test->sdhci.capab.reg);
+
+    machine_stop();
+}
+
+int main(int argc, char *argv[])
+{
+    const char *arch = qtest_get_arch();
+    char *name;
+    int i;
+
+    g_test_init(&argc, &argv, NULL);
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
index 8883274ae1..756725b0f9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -293,6 +293,7 @@ check-qtest-i386-y += tests/migration-test$(EXESUF)
 check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y += tests/numa-test$(EXESUF)
 check-qtest-x86_64-y += $(check-qtest-i386-y)
+check-qtest-x86_64-y += tests/sdhci-test$(EXESUF)
 gcov-files-i386-y += i386-softmmu/hw/timer/mc146818rtc.c
 gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y))
 
@@ -363,6 +364,7 @@ gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
+check-qtest-arm-y += tests/sdhci-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 
@@ -816,6 +818,7 @@ tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
 tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
+tests/sdhci-test$(EXESUF): tests/sdhci-test.o $(libqos-pc-obj-y)
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
-- 
2.15.1
