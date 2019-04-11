Received: from eggs.gnu.org ([209.51.188.92]:32797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEcHy-0003zh-Jc
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEcHp-0004yr-3x
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:10:53 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:49644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEcHj-0004ss-PD
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:10:47 -0400
Received: from player759.ha.ovh.net (unknown [10.109.146.20])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5747D22A1F5
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 18:10:38 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 11 Apr 2019 18:10:12 +0200
Message-Id: <20190411161013.4514-3-clg@kaod.org>
In-Reply-To: <20190411161013.4514-1-clg@kaod.org>
References: <20190411161013.4514-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] aspeed: add a per SoC mapping for the
 memory space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This will simplify the definition of new SoCs, like the AST2600 which
should use a slightly different address space and have a different set
of controllers.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h |   2 +-
 hw/arm/aspeed_soc.c         | 121 ++++++++++++++++++++++--------------
 2 files changed, 77 insertions(+), 46 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index b0d266434288..eda9094660b5 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -53,11 +53,11 @@ typedef struct AspeedSoCInfo {
     hwaddr sdram_base;
     uint64_t sram_size;
     int spis_num;
-    const hwaddr *spi_bases;
     const char *fmc_typename;
     const char **spi_typename;
     int wdts_num;
     const int *irqmap;
+    const hwaddr *memmap;
 } AspeedSoCInfo;
=20
 typedef struct AspeedSoCClass {
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 5bbd1fb87d18..9b601709e93c 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -58,21 +58,58 @@ enum {
     ASPEED_SDRAM,
 };
=20
-#define ASPEED_SOC_UART_5_BASE      0x00184000
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
-#define ASPEED_SOC_IOMEM_BASE       0x1E600000
-#define ASPEED_SOC_FMC_BASE         0x1E620000
-#define ASPEED_SOC_SPI_BASE         0x1E630000
-#define ASPEED_SOC_SPI2_BASE        0x1E631000
-#define ASPEED_SOC_VIC_BASE         0x1E6C0000
-#define ASPEED_SOC_SDMC_BASE        0x1E6E0000
-#define ASPEED_SOC_SCU_BASE         0x1E6E2000
-#define ASPEED_SOC_SRAM_BASE        0x1E720000
-#define ASPEED_SOC_TIMER_BASE       0x1E782000
-#define ASPEED_SOC_WDT_BASE         0x1E785000
-#define ASPEED_SOC_I2C_BASE         0x1E78A000
-#define ASPEED_SOC_ETH1_BASE        0x1E660000
-#define ASPEED_SOC_ETH2_BASE        0x1E680000
+
+static const hwaddr aspeed_soc_ast2400_memmap[] =3D {
+    [ASPEED_IOMEM]  =3D 0x1E600000,
+    [ASPEED_FMC]    =3D 0x1E620000,
+    [ASPEED_SPI1]   =3D 0x1E630000,
+    [ASPEED_VIC]    =3D 0x1E6C0000,
+    [ASPEED_SDMC]   =3D 0x1E6E0000,
+    [ASPEED_SCU]    =3D 0x1E6E2000,
+    [ASPEED_ADC]    =3D 0x1E6E9000,
+    [ASPEED_SRAM]   =3D 0x1E720000,
+    [ASPEED_GPIO]   =3D 0x1E780000,
+    [ASPEED_RTC]    =3D 0x1E781000,
+    [ASPEED_TIMER1] =3D 0x1E782000,
+    [ASPEED_WDT]    =3D 0x1E785000,
+    [ASPEED_PWM]    =3D 0x1E786000,
+    [ASPEED_LPC]    =3D 0x1E789000,
+    [ASPEED_IBT]    =3D 0x1E789140,
+    [ASPEED_I2C]    =3D 0x1E78A000,
+    [ASPEED_ETH1]   =3D 0x1E660000,
+    [ASPEED_ETH2]   =3D 0x1E680000,
+    [ASPEED_UART1]  =3D 0x1E783000,
+    [ASPEED_UART5]  =3D 0x1E784000,
+    [ASPEED_VUART]  =3D 0x1E787000,
+    [ASPEED_SDRAM]  =3D 0x40000000,
+};
+
+static const hwaddr aspeed_soc_ast2500_memmap[] =3D {
+    [ASPEED_IOMEM]  =3D 0x1E600000,
+    [ASPEED_FMC]    =3D 0x1E620000,
+    [ASPEED_SPI1]   =3D 0x1E630000,
+    [ASPEED_SPI2]   =3D 0x1E631000,
+    [ASPEED_VIC]    =3D 0x1E6C0000,
+    [ASPEED_SDMC]   =3D 0x1E6E0000,
+    [ASPEED_SCU]    =3D 0x1E6E2000,
+    [ASPEED_ADC]    =3D 0x1E6E9000,
+    [ASPEED_SRAM]   =3D 0x1E720000,
+    [ASPEED_GPIO]   =3D 0x1E780000,
+    [ASPEED_RTC]    =3D 0x1E781000,
+    [ASPEED_TIMER1] =3D 0x1E782000,
+    [ASPEED_WDT]    =3D 0x1E785000,
+    [ASPEED_PWM]    =3D 0x1E786000,
+    [ASPEED_LPC]    =3D 0x1E789000,
+    [ASPEED_IBT]    =3D 0x1E789140,
+    [ASPEED_I2C]    =3D 0x1E78A000,
+    [ASPEED_ETH1]   =3D 0x1E660000,
+    [ASPEED_ETH2]   =3D 0x1E680000,
+    [ASPEED_UART1]  =3D 0x1E783000,
+    [ASPEED_UART5]  =3D 0x1E784000,
+    [ASPEED_VUART]  =3D 0x1E787000,
+    [ASPEED_SDRAM]  =3D 0x80000000,
+};
=20
 static const int aspeed_soc_ast2400_irqmap[] =3D {
     [ASPEED_UART1]  =3D 9,
@@ -104,17 +141,9 @@ static const int aspeed_soc_ast2400_irqmap[] =3D {
     [ASPEED_ETH2]   =3D 3,
 };
=20
-#define AST2400_SDRAM_BASE       0x40000000
-#define AST2500_SDRAM_BASE       0x80000000
-
-/* AST2500 uses the same IRQs as the AST2400 */
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
=20
-static const hwaddr aspeed_soc_ast2400_spi_bases[] =3D { ASPEED_SOC_SPI_=
BASE };
 static const char *aspeed_soc_ast2400_typenames[] =3D { "aspeed.smc.spi"=
 };
-
-static const hwaddr aspeed_soc_ast2500_spi_bases[] =3D { ASPEED_SOC_SPI_=
BASE,
-                                                       ASPEED_SOC_SPI2_B=
ASE};
 static const char *aspeed_soc_ast2500_typenames[] =3D {
     "aspeed.smc.ast2500-spi1", "aspeed.smc.ast2500-spi2" };
=20
@@ -123,50 +152,50 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .name         =3D "ast2400-a0",
         .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
         .silicon_rev  =3D AST2400_A0_SILICON_REV,
-        .sdram_base   =3D AST2400_SDRAM_BASE,
+        .sdram_base   =3D aspeed_soc_ast2400_memmap[ASPEED_SDRAM],
         .sram_size    =3D 0x8000,
         .spis_num     =3D 1,
-        .spi_bases    =3D aspeed_soc_ast2400_spi_bases,
         .fmc_typename =3D "aspeed.smc.fmc",
         .spi_typename =3D aspeed_soc_ast2400_typenames,
         .wdts_num     =3D 2,
         .irqmap       =3D aspeed_soc_ast2400_irqmap,
+        .memmap       =3D aspeed_soc_ast2400_memmap,
     }, {
         .name         =3D "ast2400-a1",
         .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
         .silicon_rev  =3D AST2400_A1_SILICON_REV,
-        .sdram_base   =3D AST2400_SDRAM_BASE,
+        .sdram_base   =3D aspeed_soc_ast2400_memmap[ASPEED_SDRAM],
         .sram_size    =3D 0x8000,
         .spis_num     =3D 1,
-        .spi_bases    =3D aspeed_soc_ast2400_spi_bases,
         .fmc_typename =3D "aspeed.smc.fmc",
         .spi_typename =3D aspeed_soc_ast2400_typenames,
         .wdts_num     =3D 2,
         .irqmap       =3D aspeed_soc_ast2400_irqmap,
+        .memmap       =3D aspeed_soc_ast2400_memmap,
     }, {
         .name         =3D "ast2400",
         .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
         .silicon_rev  =3D AST2400_A0_SILICON_REV,
-        .sdram_base   =3D AST2400_SDRAM_BASE,
+        .sdram_base   =3D aspeed_soc_ast2400_memmap[ASPEED_SDRAM],
         .sram_size    =3D 0x8000,
         .spis_num     =3D 1,
-        .spi_bases    =3D aspeed_soc_ast2400_spi_bases,
         .fmc_typename =3D "aspeed.smc.fmc",
         .spi_typename =3D aspeed_soc_ast2400_typenames,
         .wdts_num     =3D 2,
         .irqmap       =3D aspeed_soc_ast2400_irqmap,
+        .memmap       =3D aspeed_soc_ast2400_memmap,
     }, {
         .name         =3D "ast2500-a1",
         .cpu_type     =3D ARM_CPU_TYPE_NAME("arm1176"),
         .silicon_rev  =3D AST2500_A1_SILICON_REV,
-        .sdram_base   =3D AST2500_SDRAM_BASE,
+        .sdram_base   =3D aspeed_soc_ast2500_memmap[ASPEED_SDRAM],
         .sram_size    =3D 0x9000,
         .spis_num     =3D 2,
-        .spi_bases    =3D aspeed_soc_ast2500_spi_bases,
         .fmc_typename =3D "aspeed.smc.ast2500-fmc",
         .spi_typename =3D aspeed_soc_ast2500_typenames,
         .wdts_num     =3D 3,
         .irqmap       =3D aspeed_soc_ast2500_irqmap,
+        .memmap       =3D aspeed_soc_ast2500_memmap,
     },
 };
=20
@@ -256,8 +285,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
     Error *err =3D NULL, *local_err =3D NULL;
=20
     /* IO space */
-    create_unimplemented_device("aspeed_soc.io",
-                                ASPEED_SOC_IOMEM_BASE, ASPEED_SOC_IOMEM_=
SIZE);
+    create_unimplemented_device("aspeed_soc.io", sc->info->memmap[ASPEED=
_IOMEM],
+                                ASPEED_SOC_IOMEM_SIZE);
=20
     /* CPU */
     object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
@@ -273,8 +302,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, err);
         return;
     }
-    memory_region_add_subregion(get_system_memory(), ASPEED_SOC_SRAM_BAS=
E,
-                                &s->sram);
+    memory_region_add_subregion(get_system_memory(),
+                                sc->info->memmap[ASPEED_SRAM], &s->sram)=
;
=20
     /* SCU */
     object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
@@ -282,7 +311,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, ASPEED_SOC_SCU_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->info->memmap[ASPEED_=
SCU]);
=20
     /* VIC */
     object_property_set_bool(OBJECT(&s->vic), true, "realized", &err);
@@ -290,7 +319,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, ASPEED_SOC_VIC_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, sc->info->memmap[ASPEED_=
VIC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 0,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 1,
@@ -302,7 +331,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0, ASPEED_SOC_TIMER_B=
ASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0,
+                    sc->info->memmap[ASPEED_TIMER1]);
     for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         qemu_irq irq =3D aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
@@ -311,8 +341,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
     /* UART - attach an 8250 to the IO space as our UART5 */
     if (serial_hd(0)) {
         qemu_irq uart5 =3D aspeed_soc_get_irq(s, ASPEED_UART5);
-        serial_mm_init(get_system_memory(),
-                       ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE, 2=
,
+        serial_mm_init(get_system_memory(), sc->info->memmap[ASPEED_UART=
5], 2,
                        uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN)=
;
     }
=20
@@ -322,7 +351,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, ASPEED_SOC_I2C_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->info->memmap[ASPEED_=
I2C]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
                        aspeed_soc_get_irq(s, ASPEED_I2C));
=20
@@ -332,7 +361,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, ASPEED_SOC_FMC_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->info->memmap[ASPEED_=
FMC]);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
                     s->fmc.ctrl->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
@@ -348,7 +377,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
             error_propagate(errp, err);
             return;
         }
-        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, sc->info->spi_bas=
es[i]);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                        sc->info->memmap[ASPEED_SPI1 + i]);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 1,
                         s->spi[i].ctrl->flash_window_base);
     }
@@ -359,7 +389,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, ASPEED_SOC_SDMC_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->info->memmap[ASPEED=
_SDMC]);
=20
     /* Watch dog */
     for (i =3D 0; i < sc->info->wdts_num; i++) {
@@ -369,7 +399,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                        ASPEED_SOC_WDT_BASE + i * 0x20);
+                        sc->info->memmap[ASPEED_WDT] + i * 0x20);
     }
=20
     /* Net */
@@ -382,7 +412,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_BA=
SE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0,
+                    sc->info->memmap[ASPEED_ETH1]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
                        aspeed_soc_get_irq(s, ASPEED_ETH1));
 }
--=20
2.20.1
