Received: from eggs.gnu.org ([209.51.188.92]:41168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNd-00038t-5P
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNc-0000Xl-70
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:33 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:56072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBNb-0000L7-Vv
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:32 -0500
Received: by mail-wm1-x333.google.com with SMTP id y139so14913878wmc.5
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.11.13 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:41 +0000
Message-Id: <20190128181047.20781-21-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/26] aspeed/smc: Add dummy data register
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

The SMC controllers have a register containing the byte that will be
used as dummy output. It can be modified by software.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190124140519.13838-4-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 6045ca11b96..9f3b6f4b450 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -98,8 +98,8 @@
 /* Misc Control Register #1 */
 #define R_MISC_CTRL1      (0x50 / 4)
 
-/* Misc Control Register #2 */
-#define R_MISC_CTRL2      (0x54 / 4)
+/* SPI dummy cycle data */
+#define R_DUMMY_DATA      (0x54 / 4)
 
 /* DMA Control/Status Register */
 #define R_DMA_CTRL        (0x80 / 4)
@@ -529,7 +529,7 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
      */
     if (aspeed_smc_flash_mode(fl) == CTRL_FREADMODE) {
         for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
-            ssi_transfer(fl->controller->spi, 0xFF);
+            ssi_transfer(fl->controller->spi, s->regs[R_DUMMY_DATA] & 0xff);
         }
     }
 }
@@ -664,6 +664,7 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
         addr == s->r_timings ||
         addr == s->r_ce_ctrl ||
         addr == R_INTR_CTRL ||
+        addr == R_DUMMY_DATA ||
         (addr >= R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_slaves) ||
         (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_slaves)) {
         return s->regs[addr];
@@ -697,6 +698,8 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
         if (value != s->regs[R_SEG_ADDR0 + cs]) {
             aspeed_smc_flash_set_segment(s, cs, value);
         }
+    } else if (addr == R_DUMMY_DATA) {
+        s->regs[addr] = value & 0xff;
     } else {
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
                       __func__, addr);
-- 
2.20.1
