Received: from eggs.gnu.org ([2001:4830:134:3::10]:38599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKJ-00023L-SK
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKI-0003FB-L6
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:23 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33156)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKI-0003Ev-C4
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:22 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon,  6 Aug 2018 12:01:10 +0200
Message-Id: <20180806100114.21410-4-contrib@steffen-goertz.de>
In-Reply-To: <20180806100114.21410-1-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/7] tests: Add bbc:microbit / nRF51 test suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

The microbit-test includes tests for the nRF51 NVMC
peripheral and will host future nRF51 peripheral tests
and board-level bbc:microbit tests.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 tests/Makefile.include |   2 +
 tests/microbit-test.c  | 126 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 tests/microbit-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 760a0f18b6..1f1206e33a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -378,6 +378,7 @@ check-qtest-sparc64-y +=3D tests/boot-serial-test$(EX=
ESUF)
 check-qtest-arm-y =3D tests/tmp105-test$(EXESUF)
 check-qtest-arm-y +=3D tests/pca9552-test$(EXESUF)
 check-qtest-arm-y +=3D tests/ds1338-test$(EXESUF)
+check-qtest-arm-y +=3D tests/microbit-test$(EXESUF)
 check-qtest-arm-y +=3D tests/m25p80-test$(EXESUF)
 gcov-files-arm-y +=3D hw/misc/tmp105.c
 check-qtest-arm-y +=3D tests/virtio-blk-test$(EXESUF)
@@ -793,6 +794,7 @@ tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-=
sector.o $(libqos-obj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
 tests/pca9552-test$(EXESUF): tests/pca9552-test.o $(libqos-omap-obj-y)
 tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
+tests/microbit-test$(EXESUF): tests/microbit-test.o
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
 tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
 tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
diff --git a/tests/microbit-test.c b/tests/microbit-test.c
new file mode 100644
index 0000000000..9f83063cf3
--- /dev/null
+++ b/tests/microbit-test.c
@@ -0,0 +1,126 @@
+ /*
+ * QTest testcase for Microbit board using the Nordic Semiconductor nRF5=
1 SoC.
+ *
+ * nRF51:
+ * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.=
pdf
+ * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.p=
df
+ *
+ * Microbit Board: http://microbit.org/
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
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
+
+#define PAGE_SIZE           1024
+#define FLASH_SIZE          (256 * PAGE_SIZE)
+#define FLASH_BASE          0x00000000
+#define UICR_BASE           0x10001000
+#define UICR_SIZE           0x100
+#define NVMC_BASE           0x4001E000UL
+#define NVMC_READY          0x400
+#define NVMC_CONFIG         0x504
+#define NVMC_ERASEPAGE      0x508
+#define NVMC_ERASEPCR1      0x508
+#define NVMC_ERASEALL       0x50C
+#define NVMC_ERASEPCR0      0x510
+#define NVMC_ERASEUICR      0x514
+
+
+static void fill_and_erase(hwaddr base, hwaddr size, uint32_t address_re=
g)
+{
+    /* Fill memory */
+    writel(NVMC_BASE + NVMC_CONFIG, 0x01);
+    for (hwaddr i =3D 0; i < size; ++i) {
+        writeb(base + i, i);
+        g_assert_cmpuint(readb(base + i), =3D=3D, i & 0xFF);
+    }
+    writel(NVMC_BASE + NVMC_CONFIG, 0x00);
+
+    /* Erase Page */
+    writel(NVMC_BASE + NVMC_CONFIG, 0x02);
+    writel(NVMC_BASE + address_reg, base);
+    writel(NVMC_BASE + NVMC_CONFIG, 0x00);
+
+    /* Check memory */
+    for (hwaddr i =3D 0; i < size; ++i) {
+        g_assert_cmpuint(readb(base + i), =3D=3D, 0xFF);
+    }
+}
+
+static void test_nrf51_nvmc(void)
+{
+    uint32_t value;
+    /* Test always ready */
+    value =3D readl(NVMC_BASE + NVMC_READY);
+    g_assert_cmpuint(value & 0x01, =3D=3D, 0x01);
+
+    /* Test write-read config register */
+    writel(NVMC_BASE + NVMC_CONFIG, 0x03);
+    g_assert_cmpuint(readl(NVMC_BASE + NVMC_CONFIG), =3D=3D, 0x03);
+    writel(NVMC_BASE + NVMC_CONFIG, 0x00);
+    g_assert_cmpuint(readl(NVMC_BASE + NVMC_CONFIG), =3D=3D, 0x00);
+
+    /* Test PCR0 */
+    fill_and_erase(FLASH_BASE, PAGE_SIZE, NVMC_ERASEPCR0);
+    fill_and_erase(FLASH_BASE + PAGE_SIZE, PAGE_SIZE, NVMC_ERASEPCR0);
+
+    /* Test PCR1 */
+    fill_and_erase(FLASH_BASE, PAGE_SIZE, NVMC_ERASEPCR1);
+    fill_and_erase(FLASH_BASE + PAGE_SIZE, PAGE_SIZE, NVMC_ERASEPCR1);
+
+    /* Erase all */
+    writel(NVMC_BASE + NVMC_CONFIG, 0x01);
+    for (hwaddr i =3D 0; i < FLASH_SIZE / 4; i++) {
+        writel(FLASH_BASE + i * 4, i);
+        g_assert_cmpuint(readl(FLASH_BASE + i * 4), =3D=3D, i);
+    }
+    writel(NVMC_BASE + NVMC_CONFIG, 0x00);
+
+    writel(NVMC_BASE + NVMC_CONFIG, 0x02);
+    writel(NVMC_BASE + NVMC_ERASEALL, 0x01);
+    writel(NVMC_BASE + NVMC_CONFIG, 0x00);
+
+    for (hwaddr i =3D 0; i < FLASH_SIZE / 4; i++) {
+        g_assert_cmpuint(readl(FLASH_BASE + i * 4), =3D=3D, 0xFFFFFFFF);
+    }
+
+    /* Erase UICR */
+    writel(NVMC_BASE + NVMC_CONFIG, 0x01);
+    for (hwaddr i =3D 0; i < UICR_SIZE / 4; i++) {
+        writel(UICR_BASE + i * 4, i);
+        g_assert_cmpuint(readl(UICR_BASE + i * 4), =3D=3D, i);
+    }
+    writel(NVMC_BASE + NVMC_CONFIG, 0x00);
+
+    writel(NVMC_BASE + NVMC_CONFIG, 0x02);
+    writel(NVMC_BASE + NVMC_ERASEUICR, 0x01);
+    writel(NVMC_BASE + NVMC_CONFIG, 0x00);
+
+    for (hwaddr i =3D 0; i < UICR_SIZE / 4; i++) {
+        g_assert_cmpuint(readl(UICR_BASE + i * 4), =3D=3D, 0xFFFFFFFF);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    global_qtest =3D qtest_startf("-machine microbit");
+
+    qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
+
+    ret =3D g_test_run();
+
+    qtest_quit(global_qtest);
+    return ret;
+}
--=20
2.18.0
