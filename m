Received: from eggs.gnu.org ([2001:4830:134:3::10]:35538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaB-0002Yz-6q
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaA-0001LE-2Z
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:31 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLta9-0001L4-RB
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:29 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLta9-0003vx-17
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:29 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:09 +0000
Message-Id: <1482852077-19397-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/25] aspeed: add a memory region for SRAM
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

The size of the SRAM depends on the SoC model, so use a per-soc
definition when creating the region.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1480434248-27138-9-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  2 ++
 hw/arm/aspeed_soc.c         | 52 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 6f1b679..1ab5dea 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -29,6 +29,7 @@ typedef struct AspeedSoCState {
     /*< public >*/
     ARMCPU cpu;
     MemoryRegion iomem;
+    MemoryRegion sram;
     AspeedVICState vic;
     AspeedTimerCtrlState timerctrl;
     AspeedI2CState i2c;
@@ -46,6 +47,7 @@ typedef struct AspeedSoCInfo {
     const char *cpu_model;
     uint32_t silicon_rev;
     hwaddr sdram_base;
+    uint64_t sram_size;
     int spis_num;
     const hwaddr *spi_bases;
     const char *fmc_typename;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 82e2712..233a6b9 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -29,6 +29,7 @@
 #define ASPEED_SOC_VIC_BASE         0x1E6C0000
 #define ASPEED_SOC_SDMC_BASE        0x1E6E0000
 #define ASPEED_SOC_SCU_BASE         0x1E6E2000
+#define ASPEED_SOC_SRAM_BASE        0x1E720000
 #define ASPEED_SOC_TIMER_BASE       0x1E782000
 #define ASPEED_SOC_I2C_BASE         0x1E78A000
 
@@ -47,15 +48,37 @@ static const char *aspeed_soc_ast2500_typenames[] = {
     "aspeed.smc.ast2500-spi1", "aspeed.smc.ast2500-spi2" };
 
 static const AspeedSoCInfo aspeed_socs[] = {
-    { "ast2400-a0", "arm926", AST2400_A0_SILICON_REV, AST2400_SDRAM_BASE,
-      1, aspeed_soc_ast2400_spi_bases,
-      "aspeed.smc.fmc", aspeed_soc_ast2400_typenames },
-    { "ast2400",    "arm926", AST2400_A0_SILICON_REV, AST2400_SDRAM_BASE,
-      1, aspeed_soc_ast2400_spi_bases,
-     "aspeed.smc.fmc", aspeed_soc_ast2400_typenames },
-    { "ast2500-a1", "arm1176", AST2500_A1_SILICON_REV, AST2500_SDRAM_BASE,
-      2, aspeed_soc_ast2500_spi_bases,
-      "aspeed.smc.ast2500-fmc", aspeed_soc_ast2500_typenames },
+    {
+        .name         = "ast2400-a0",
+        .cpu_model    = "arm926",
+        .silicon_rev  = AST2400_A0_SILICON_REV,
+        .sdram_base   = AST2400_SDRAM_BASE,
+        .sram_size    = 0x8000,
+        .spis_num     = 1,
+        .spi_bases    = aspeed_soc_ast2400_spi_bases,
+        .fmc_typename = "aspeed.smc.fmc",
+        .spi_typename = aspeed_soc_ast2400_typenames,
+    }, {
+        .name         = "ast2400",
+        .cpu_model    = "arm926",
+        .silicon_rev  = AST2400_A0_SILICON_REV,
+        .sdram_base   = AST2400_SDRAM_BASE,
+        .sram_size    = 0x8000,
+        .spis_num     = 1,
+        .spi_bases    = aspeed_soc_ast2400_spi_bases,
+        .fmc_typename = "aspeed.smc.fmc",
+        .spi_typename = aspeed_soc_ast2400_typenames,
+    }, {
+        .name         = "ast2500-a1",
+        .cpu_model    = "arm1176",
+        .silicon_rev  = AST2500_A1_SILICON_REV,
+        .sdram_base   = AST2500_SDRAM_BASE,
+        .sram_size    = 0x9000,
+        .spis_num     = 2,
+        .spi_bases    = aspeed_soc_ast2500_spi_bases,
+        .fmc_typename = "aspeed.smc.ast2500-fmc",
+        .spi_typename = aspeed_soc_ast2500_typenames,
+    },
 };
 
 /*
@@ -157,6 +180,17 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* SRAM */
+    memory_region_init_ram(&s->sram, OBJECT(dev), "aspeed.sram",
+                           sc->info->sram_size, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    vmstate_register_ram_global(&s->sram);
+    memory_region_add_subregion(get_system_memory(), ASPEED_SOC_SRAM_BASE,
+                                &s->sram);
+
     /* VIC */
     object_property_set_bool(OBJECT(&s->vic), true, "realized", &err);
     if (err) {
-- 
2.7.4
