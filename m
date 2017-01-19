Received: from eggs.gnu.org ([2001:4830:134:3::10]:47543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPs-00010H-Sx
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0005CQ-Ip
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPq-0004w9-7o
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:14 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPf-00038u-0q
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:34 +0000
Message-Id: <1484834995-26826-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/36] aspeed/smc: extend tests for Command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

The Aspeed SMC controllers have a mode (Command mode) in which
accesses to the flash content are no different than doing MMIOs. The
controller generates all the necessary commands to load (or store)
data in memory.

So add a couple of tests doing direct reads and writes on the AHB bus.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1483979087-32663-10-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/m25p80-test.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tests/m25p80-test.c b/tests/m25p80-test.c
index 8dd550d..244aa33 100644
--- a/tests/m25p80-test.c
+++ b/tests/m25p80-test.c
@@ -36,6 +36,9 @@
 #define   CRTL_EXTENDED0       0  /* 32 bit addressing for SPI */
 #define R_CTRL0             0x10
 #define   CTRL_CE_STOP_ACTIVE  (1 << 2)
+#define   CTRL_READMODE        0x0
+#define   CTRL_FREADMODE       0x1
+#define   CTRL_WRITEMODE       0x2
 #define   CTRL_USERMODE        0x3
 
 #define ASPEED_FMC_BASE    0x1E620000
@@ -86,6 +89,22 @@ static void spi_conf_remove(uint32_t value)
     writel(ASPEED_FMC_BASE + R_CONF, conf);
 }
 
+static void spi_ce_ctrl(uint32_t value)
+{
+    uint32_t conf = readl(ASPEED_FMC_BASE + R_CE_CTRL);
+
+    conf |= value;
+    writel(ASPEED_FMC_BASE + R_CE_CTRL, conf);
+}
+
+static void spi_ctrl_setmode(uint8_t mode, uint8_t cmd)
+{
+    uint32_t ctrl = readl(ASPEED_FMC_BASE + R_CTRL0);
+    ctrl &= ~(CTRL_USERMODE | 0xff << 16);
+    ctrl |= mode | (cmd << 16);
+    writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
+}
+
 static void spi_ctrl_start_user(void)
 {
     uint32_t ctrl = readl(ASPEED_FMC_BASE + R_CTRL0);
@@ -152,6 +171,18 @@ static void read_page(uint32_t addr, uint32_t *page)
     spi_ctrl_stop_user();
 }
 
+static void read_page_mem(uint32_t addr, uint32_t *page)
+{
+    int i;
+
+    /* move out USER mode to use direct reads from the AHB bus */
+    spi_ctrl_setmode(CTRL_READMODE, READ);
+
+    for (i = 0; i < PAGE_SIZE / 4; i++) {
+        page[i] = make_be32(readl(ASPEED_FLASH_BASE + addr + i * 4));
+    }
+}
+
 static void test_erase_sector(void)
 {
     uint32_t some_page_addr = 0x600 * PAGE_SIZE;
@@ -248,6 +279,75 @@ static void test_write_page(void)
     flash_reset();
 }
 
+static void test_read_page_mem(void)
+{
+    uint32_t my_page_addr = 0x14000 * PAGE_SIZE; /* beyond 16MB */
+    uint32_t some_page_addr = 0x15000 * PAGE_SIZE;
+    uint32_t page[PAGE_SIZE / 4];
+    int i;
+
+    /* Enable 4BYTE mode for controller. This is should be strapped by
+     * HW for CE0 anyhow.
+     */
+    spi_ce_ctrl(1 << CRTL_EXTENDED0);
+
+    /* Enable 4BYTE mode for flash. */
+    spi_conf(CONF_ENABLE_W0);
+    spi_ctrl_start_user();
+    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
+    spi_ctrl_stop_user();
+    spi_conf_remove(CONF_ENABLE_W0);
+
+    /* Check what was written */
+    read_page_mem(my_page_addr, page);
+    for (i = 0; i < PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
+    }
+
+    /* Check some other page. It should be full of 0xff */
+    read_page_mem(some_page_addr, page);
+    for (i = 0; i < PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, 0xffffffff);
+    }
+
+    flash_reset();
+}
+
+static void test_write_page_mem(void)
+{
+    uint32_t my_page_addr = 0x15000 * PAGE_SIZE;
+    uint32_t page[PAGE_SIZE / 4];
+    int i;
+
+    /* Enable 4BYTE mode for controller. This is should be strapped by
+     * HW for CE0 anyhow.
+     */
+    spi_ce_ctrl(1 << CRTL_EXTENDED0);
+
+    /* Enable 4BYTE mode for flash. */
+    spi_conf(CONF_ENABLE_W0);
+    spi_ctrl_start_user();
+    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
+    writeb(ASPEED_FLASH_BASE, WREN);
+    spi_ctrl_stop_user();
+
+    /* move out USER mode to use direct writes to the AHB bus */
+    spi_ctrl_setmode(CTRL_WRITEMODE, PP);
+
+    for (i = 0; i < PAGE_SIZE / 4; i++) {
+        writel(ASPEED_FLASH_BASE + my_page_addr + i * 4,
+               make_be32(my_page_addr + i * 4));
+    }
+
+    /* Check what was written */
+    read_page_mem(my_page_addr, page);
+    for (i = 0; i < PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
+    }
+
+    flash_reset();
+}
+
 static char tmp_path[] = "/tmp/qtest.m25p80.XXXXXX";
 
 int main(int argc, char **argv)
@@ -273,6 +373,8 @@ int main(int argc, char **argv)
     qtest_add_func("/m25p80/erase_sector", test_erase_sector);
     qtest_add_func("/m25p80/erase_all",  test_erase_all);
     qtest_add_func("/m25p80/write_page", test_write_page);
+    qtest_add_func("/m25p80/read_page_mem", test_read_page_mem);
+    qtest_add_func("/m25p80/write_page_mem", test_write_page_mem);
 
     ret = g_test_run();
 
-- 
2.7.4
