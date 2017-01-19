Received: from eggs.gnu.org ([2001:4830:134:3::10]:47596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPu-00011R-0b
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPr-0005Dh-HQ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:17 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPq-00055o-VV
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPd-00037V-6g
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:01 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:30 +0000
Message-Id: <1484834995-26826-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/36] aspeed/smc: unfold the
 AspeedSMCController array
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

This is getting difficult to read. Also add a 'has_dma' field for each
controller type.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1483979087-32663-6-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/aspeed_smc.h |  1 +
 hw/ssi/aspeed_smc.c         | 91 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index bdfbcc0..861120b 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -44,6 +44,7 @@ typedef struct AspeedSMCController {
     const AspeedSegments *segments;
     hwaddr flash_window_base;
     uint32_t flash_window_size;
+    bool has_dma;
 } AspeedSMCController;
 
 typedef struct AspeedSMCFlash {
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 3bd381b..d8287ab 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -173,24 +173,79 @@ static const AspeedSegments aspeed_segments_ast2500_spi2[] = {
 };
 
 static const AspeedSMCController controllers[] = {
-    { "aspeed.smc.smc", R_CONF, R_CE_CTRL, R_CTRL0, R_TIMINGS,
-      CONF_ENABLE_W0, 5, aspeed_segments_legacy,
-      ASPEED_SOC_SMC_FLASH_BASE, 0x6000000 },
-    { "aspeed.smc.fmc", R_CONF, R_CE_CTRL, R_CTRL0, R_TIMINGS,
-      CONF_ENABLE_W0, 5, aspeed_segments_fmc,
-      ASPEED_SOC_FMC_FLASH_BASE, 0x10000000 },
-    { "aspeed.smc.spi", R_SPI_CONF, 0xff, R_SPI_CTRL0, R_SPI_TIMINGS,
-      SPI_CONF_ENABLE_W0, 1, aspeed_segments_spi,
-      ASPEED_SOC_SPI_FLASH_BASE, 0x10000000 },
-    { "aspeed.smc.ast2500-fmc", R_CONF, R_CE_CTRL, R_CTRL0, R_TIMINGS,
-      CONF_ENABLE_W0, 3, aspeed_segments_ast2500_fmc,
-      ASPEED_SOC_FMC_FLASH_BASE, 0x10000000 },
-    { "aspeed.smc.ast2500-spi1", R_CONF, R_CE_CTRL, R_CTRL0, R_TIMINGS,
-      CONF_ENABLE_W0, 2, aspeed_segments_ast2500_spi1,
-      ASPEED_SOC_SPI_FLASH_BASE, 0x8000000 },
-    { "aspeed.smc.ast2500-spi2", R_CONF, R_CE_CTRL, R_CTRL0, R_TIMINGS,
-      CONF_ENABLE_W0, 2, aspeed_segments_ast2500_spi2,
-      ASPEED_SOC_SPI2_FLASH_BASE, 0x8000000 },
+    {
+        .name              = "aspeed.smc.smc",
+        .r_conf            = R_CONF,
+        .r_ce_ctrl         = R_CE_CTRL,
+        .r_ctrl0           = R_CTRL0,
+        .r_timings         = R_TIMINGS,
+        .conf_enable_w0    = CONF_ENABLE_W0,
+        .max_slaves        = 5,
+        .segments          = aspeed_segments_legacy,
+        .flash_window_base = ASPEED_SOC_SMC_FLASH_BASE,
+        .flash_window_size = 0x6000000,
+        .has_dma           = false,
+    }, {
+        .name              = "aspeed.smc.fmc",
+        .r_conf            = R_CONF,
+        .r_ce_ctrl         = R_CE_CTRL,
+        .r_ctrl0           = R_CTRL0,
+        .r_timings         = R_TIMINGS,
+        .conf_enable_w0    = CONF_ENABLE_W0,
+        .max_slaves        = 5,
+        .segments          = aspeed_segments_fmc,
+        .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
+        .flash_window_size = 0x10000000,
+        .has_dma           = true,
+    }, {
+        .name              = "aspeed.smc.spi",
+        .r_conf            = R_SPI_CONF,
+        .r_ce_ctrl         = 0xff,
+        .r_ctrl0           = R_SPI_CTRL0,
+        .r_timings         = R_SPI_TIMINGS,
+        .conf_enable_w0    = SPI_CONF_ENABLE_W0,
+        .max_slaves        = 1,
+        .segments          = aspeed_segments_spi,
+        .flash_window_base = ASPEED_SOC_SPI_FLASH_BASE,
+        .flash_window_size = 0x10000000,
+        .has_dma           = false,
+    }, {
+        .name              = "aspeed.smc.ast2500-fmc",
+        .r_conf            = R_CONF,
+        .r_ce_ctrl         = R_CE_CTRL,
+        .r_ctrl0           = R_CTRL0,
+        .r_timings         = R_TIMINGS,
+        .conf_enable_w0    = CONF_ENABLE_W0,
+        .max_slaves        = 3,
+        .segments          = aspeed_segments_ast2500_fmc,
+        .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
+        .flash_window_size = 0x10000000,
+        .has_dma           = true,
+    }, {
+        .name              = "aspeed.smc.ast2500-spi1",
+        .r_conf            = R_CONF,
+        .r_ce_ctrl         = R_CE_CTRL,
+        .r_ctrl0           = R_CTRL0,
+        .r_timings         = R_TIMINGS,
+        .conf_enable_w0    = CONF_ENABLE_W0,
+        .max_slaves        = 2,
+        .segments          = aspeed_segments_ast2500_spi1,
+        .flash_window_base = ASPEED_SOC_SPI_FLASH_BASE,
+        .flash_window_size = 0x8000000,
+        .has_dma           = false,
+    }, {
+        .name              = "aspeed.smc.ast2500-spi2",
+        .r_conf            = R_CONF,
+        .r_ce_ctrl         = R_CE_CTRL,
+        .r_ctrl0           = R_CTRL0,
+        .r_timings         = R_TIMINGS,
+        .conf_enable_w0    = CONF_ENABLE_W0,
+        .max_slaves        = 2,
+        .segments          = aspeed_segments_ast2500_spi2,
+        .flash_window_base = ASPEED_SOC_SPI2_FLASH_BASE,
+        .flash_window_size = 0x8000000,
+        .has_dma           = false,
+    },
 };
 
 /*
-- 
2.7.4
