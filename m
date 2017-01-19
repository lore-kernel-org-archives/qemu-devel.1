Received: from eggs.gnu.org ([2001:4830:134:3::10]:47656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPv-00012t-P9
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0005Cn-MS
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:19 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPq-00059u-Ci
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:14 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPe-00038X-I7
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:02 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:33 +0000
Message-Id: <1484834995-26826-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/36] aspeed/smc: reset flash after each test
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

Let's make sure when each test is run that the flash object is in an
initial state and did not keep configuration from the previous tests.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 1483979087-32663-9-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/m25p80-test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/m25p80-test.c b/tests/m25p80-test.c
index cb7ec81..8dd550d 100644
--- a/tests/m25p80-test.c
+++ b/tests/m25p80-test.c
@@ -50,6 +50,8 @@ enum {
     READ = 0x03,
     PP = 0x02,
     WREN = 0x6,
+    RESET_ENABLE = 0x66,
+    RESET_MEMORY = 0x99,
     EN_4BYTE_ADDR = 0xB7,
     ERASE_SECTOR = 0xd8,
 };
@@ -76,6 +78,14 @@ static void spi_conf(uint32_t value)
     writel(ASPEED_FMC_BASE + R_CONF, conf);
 }
 
+static void spi_conf_remove(uint32_t value)
+{
+    uint32_t conf = readl(ASPEED_FMC_BASE + R_CONF);
+
+    conf &= ~value;
+    writel(ASPEED_FMC_BASE + R_CONF, conf);
+}
+
 static void spi_ctrl_start_user(void)
 {
     uint32_t ctrl = readl(ASPEED_FMC_BASE + R_CTRL0);
@@ -95,6 +105,18 @@ static void spi_ctrl_stop_user(void)
     writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
 }
 
+static void flash_reset(void)
+{
+    spi_conf(CONF_ENABLE_W0);
+
+    spi_ctrl_start_user();
+    writeb(ASPEED_FLASH_BASE, RESET_ENABLE);
+    writeb(ASPEED_FLASH_BASE, RESET_MEMORY);
+    spi_ctrl_stop_user();
+
+    spi_conf_remove(CONF_ENABLE_W0);
+}
+
 static void test_read_jedec(void)
 {
     uint32_t jedec = 0x0;
@@ -108,6 +130,8 @@ static void test_read_jedec(void)
     jedec |= readb(ASPEED_FLASH_BASE);
     spi_ctrl_stop_user();
 
+    flash_reset();
+
     g_assert_cmphex(jedec, ==, FLASH_JEDEC);
 }
 
@@ -155,6 +179,8 @@ static void test_erase_sector(void)
     for (i = 0; i < PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, 0xffffffff);
     }
+
+    flash_reset();
 }
 
 static void test_erase_all(void)
@@ -182,6 +208,8 @@ static void test_erase_all(void)
     for (i = 0; i < PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, 0xffffffff);
     }
+
+    flash_reset();
 }
 
 static void test_write_page(void)
@@ -195,6 +223,7 @@ static void test_write_page(void)
 
     spi_ctrl_start_user();
     writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
+    writeb(ASPEED_FLASH_BASE, WREN);
     writeb(ASPEED_FLASH_BASE, PP);
     writel(ASPEED_FLASH_BASE, make_be32(my_page_addr));
 
@@ -215,6 +244,8 @@ static void test_write_page(void)
     for (i = 0; i < PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, 0xffffffff);
     }
+
+    flash_reset();
 }
 
 static char tmp_path[] = "/tmp/qtest.m25p80.XXXXXX";
-- 
2.7.4
