Received: from eggs.gnu.org ([2001:4830:134:3::10]:47562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPt-00010u-C7
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0005D9-Uj
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:17 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPq-000582-LE
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:14 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPd-00037n-LU
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:01 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:31 +0000
Message-Id: <1484834995-26826-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/36] aspeed/smc: adjust the size of the
 register region
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

The SPI controller of the AST2400 SoC has less registers. So we can
adjust the size of the memory region holding the registers depending
on the controller type. We can also remove the guest_error logging
which is useless as the range of the region is strict enough.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 1483979087-32663-7-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/aspeed_smc.h |  1 +
 hw/ssi/aspeed_smc.c         | 25 ++++++++++---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 861120b..e811742 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -45,6 +45,7 @@ typedef struct AspeedSMCController {
     hwaddr flash_window_base;
     uint32_t flash_window_size;
     bool has_dma;
+    uint32_t nregs;
 } AspeedSMCController;
 
 typedef struct AspeedSMCFlash {
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index d8287ab..8d8a62e 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -130,6 +130,9 @@
 #define R_SPI_MISC_CTRL   (0x10 / 4)
 #define R_SPI_TIMINGS     (0x14 / 4)
 
+#define ASPEED_SMC_R_SPI_MAX (0x20 / 4)
+#define ASPEED_SMC_R_SMC_MAX (0x20 / 4)
+
 #define ASPEED_SOC_SMC_FLASH_BASE   0x10000000
 #define ASPEED_SOC_FMC_FLASH_BASE   0x20000000
 #define ASPEED_SOC_SPI_FLASH_BASE   0x30000000
@@ -185,6 +188,7 @@ static const AspeedSMCController controllers[] = {
         .flash_window_base = ASPEED_SOC_SMC_FLASH_BASE,
         .flash_window_size = 0x6000000,
         .has_dma           = false,
+        .nregs             = ASPEED_SMC_R_SMC_MAX,
     }, {
         .name              = "aspeed.smc.fmc",
         .r_conf            = R_CONF,
@@ -197,6 +201,7 @@ static const AspeedSMCController controllers[] = {
         .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
         .flash_window_size = 0x10000000,
         .has_dma           = true,
+        .nregs             = ASPEED_SMC_R_MAX,
     }, {
         .name              = "aspeed.smc.spi",
         .r_conf            = R_SPI_CONF,
@@ -209,6 +214,7 @@ static const AspeedSMCController controllers[] = {
         .flash_window_base = ASPEED_SOC_SPI_FLASH_BASE,
         .flash_window_size = 0x10000000,
         .has_dma           = false,
+        .nregs             = ASPEED_SMC_R_SPI_MAX,
     }, {
         .name              = "aspeed.smc.ast2500-fmc",
         .r_conf            = R_CONF,
@@ -221,6 +227,7 @@ static const AspeedSMCController controllers[] = {
         .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
         .flash_window_size = 0x10000000,
         .has_dma           = true,
+        .nregs             = ASPEED_SMC_R_MAX,
     }, {
         .name              = "aspeed.smc.ast2500-spi1",
         .r_conf            = R_CONF,
@@ -233,6 +240,7 @@ static const AspeedSMCController controllers[] = {
         .flash_window_base = ASPEED_SOC_SPI_FLASH_BASE,
         .flash_window_size = 0x8000000,
         .has_dma           = false,
+        .nregs             = ASPEED_SMC_R_MAX,
     }, {
         .name              = "aspeed.smc.ast2500-spi2",
         .r_conf            = R_CONF,
@@ -245,6 +253,7 @@ static const AspeedSMCController controllers[] = {
         .flash_window_base = ASPEED_SOC_SPI2_FLASH_BASE,
         .flash_window_size = 0x8000000,
         .has_dma           = false,
+        .nregs             = ASPEED_SMC_R_MAX,
     },
 };
 
@@ -521,13 +530,6 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
 
     addr >>= 2;
 
-    if (addr >= ARRAY_SIZE(s->regs)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Out-of-bounds read at 0x%" HWADDR_PRIx "\n",
-                      __func__, addr);
-        return 0;
-    }
-
     if (addr == s->r_conf ||
         addr == s->r_timings ||
         addr == s->r_ce_ctrl ||
@@ -550,13 +552,6 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
 
     addr >>= 2;
 
-    if (addr >= ARRAY_SIZE(s->regs)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Out-of-bounds write at 0x%" HWADDR_PRIx "\n",
-                      __func__, addr);
-        return;
-    }
-
     if (addr == s->r_conf ||
         addr == s->r_timings ||
         addr == s->r_ce_ctrl) {
@@ -624,7 +619,7 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
 
     /* The memory region for the controller registers */
     memory_region_init_io(&s->mmio, OBJECT(s), &aspeed_smc_ops, s,
-                          s->ctrl->name, ASPEED_SMC_R_MAX * 4);
+                          s->ctrl->name, s->ctrl->nregs * 4);
     sysbus_init_mmio(sbd, &s->mmio);
 
     /*
-- 
2.7.4
