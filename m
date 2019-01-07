Received: from eggs.gnu.org ([209.51.188.92]:46599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoq-0005Fi-ND
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXon-0002Ts-RD
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:04 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXok-0002Np-Lx
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:00 -0500
Received: by mail-wr1-x42a.google.com with SMTP id v13so1075124wrw.5
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:10 +0000
Message-Id: <20190107163117.16269-31-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/37] tests/microbit-test: Add Tests for nRF51
 GPIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Steffen Görtz <contrib@steffen-goertz.de>

The test suite for the nRF51 GPIO peripheral for now
only tests initial state. Additionally a set of
tests testing an implementation detail of the model
are included.

Signed-off-by: Steffen Görtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190103091119.9367-8-stefanha@redhat.com
[PMM: fixed stray space at start of file]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/Makefile.include |   2 +
 tests/microbit-test.c  | 160 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 tests/microbit-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3f5a1d0c308..9c84bbd8296 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -277,6 +277,7 @@ check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/tmp105-test$(EXESUF)
 check-qtest-arm-y += tests/pca9552-test$(EXESUF)
 check-qtest-arm-y += tests/ds1338-test$(EXESUF)
+check-qtest-arm-y += tests/microbit-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
 check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
@@ -708,6 +709,7 @@ tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
 tests/pca9552-test$(EXESUF): tests/pca9552-test.o $(libqos-omap-obj-y)
 tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
+tests/microbit-test$(EXESUF): tests/microbit-test.o
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
 tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
 tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
diff --git a/tests/microbit-test.c b/tests/microbit-test.c
new file mode 100644
index 00000000000..f0a180cbc6f
--- /dev/null
+++ b/tests/microbit-test.c
@@ -0,0 +1,160 @@
+/*
+ * QTest testcase for Microbit board using the Nordic Semiconductor nRF51 SoC.
+ *
+ * nRF51:
+ * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
+ * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.pdf
+ *
+ * Microbit Board: http://microbit.org/
+ *
+ * Copyright 2018 Steffen Görtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+#include "libqtest.h"
+
+#include "hw/arm/nrf51.h"
+#include "hw/gpio/nrf51_gpio.h"
+
+static void test_nrf51_gpio(void)
+{
+    size_t i;
+    uint32_t actual, expected;
+
+    struct {
+        hwaddr addr;
+        uint32_t expected;
+    } const reset_state[] = {
+        {NRF51_GPIO_REG_OUT, 0x00000000}, {NRF51_GPIO_REG_OUTSET, 0x00000000},
+        {NRF51_GPIO_REG_OUTCLR, 0x00000000}, {NRF51_GPIO_REG_IN, 0x00000000},
+        {NRF51_GPIO_REG_DIR, 0x00000000}, {NRF51_GPIO_REG_DIRSET, 0x00000000},
+        {NRF51_GPIO_REG_DIRCLR, 0x00000000}
+    };
+
+    /* Check reset state */
+    for (i = 0; i < ARRAY_SIZE(reset_state); i++) {
+        expected = reset_state[i].expected;
+        actual = readl(NRF51_GPIO_BASE + reset_state[i].addr);
+        g_assert_cmpuint(actual, ==, expected);
+    }
+
+    for (i = 0; i < NRF51_GPIO_PINS; i++) {
+        expected = 0x00000002;
+        actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START + i * 4);
+        g_assert_cmpuint(actual, ==, expected);
+    }
+
+    /* Check dir bit consistency between dir and cnf */
+    /* Check set via DIRSET */
+    expected = 0x80000001;
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIRSET, expected);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
+    g_assert_cmpuint(actual, ==, expected);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x01);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x01);
+
+    /* Check clear via DIRCLR */
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIRCLR, 0x80000001);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
+    g_assert_cmpuint(actual, ==, 0x00000000);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x00);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x00);
+
+    /* Check set via DIR */
+    expected = 0x80000001;
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR, expected);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
+    g_assert_cmpuint(actual, ==, expected);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x01);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x01);
+
+    /* Reset DIR */
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR, 0x00000000);
+
+    /* Check Input propagates */
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x00);
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x00);
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, 1);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x01);
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, -1);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
+
+    /* Check pull-up working */
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x00);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b1110);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
+
+    /* Check pull-down working */
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, 1);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0110);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x00);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, -1);
+
+    /* Check Output propagates */
+    irq_intercept_out("/machine/nrf51");
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0011);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
+    g_assert_true(get_irq(0));
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTCLR, 0x01);
+    g_assert_false(get_irq(0));
+
+    /* Check self-stimulation */
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x01);
+
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTCLR, 0x01);
+    actual = readl(NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
+    g_assert_cmpuint(actual, ==, 0x00);
+
+    /*
+     * Check short-circuit - generates an guest_error which must be checked
+     * manually as long as qtest can not scan qemu_log messages
+     */
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b01);
+    writel(NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
+    qtest_set_irq_in(global_qtest, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    global_qtest = qtest_initf("-machine microbit");
+
+    qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
+
+    ret = g_test_run();
+
+    qtest_quit(global_qtest);
+    return ret;
+}
-- 
2.19.2
