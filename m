Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13404C07542
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6A22081C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6A22081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43231 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUYQW-0000Rp-2N
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 11:17:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYMO-0005Vw-4E
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYML-0001Qc-D6
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:13:24 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:51009)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hUYML-0001PU-4o
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:13:21 -0400
Received: from player698.ha.ovh.net (unknown [10.108.35.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D83CC19AE8F
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 17:13:18 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player698.ha.ovh.net (Postfix) with ESMTPSA id E6FA8625A74B;
	Sat, 25 May 2019 15:13:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 May 2019 17:12:25 +0200
Message-Id: <20190525151241.5017-4-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525151241.5017-1-clg@kaod.org>
References: <20190525151241.5017-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6597210504514734865
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddukedgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.172.75
Subject: [Qemu-devel] [PATCH 03/19] aspeed: add a per SoC mapping for the
 memory space
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will simplify the definition of new SoCs, like the AST2600 which
should use a slightly different address space and have a different set
of controllers.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/arm/aspeed_soc.h |   4 +-
 hw/arm/aspeed.c             |   8 +--
 hw/arm/aspeed_soc.c         | 117 ++++++++++++++++++++++--------------
 3 files changed, 78 insertions(+), 51 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 963abecb7244..88b901d5dfa9 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -49,14 +49,13 @@ typedef struct AspeedSoCInfo {
     const char *name;
     const char *cpu_type;
     uint32_t silicon_rev;
-    hwaddr sdram_base;
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
@@ -102,6 +101,7 @@ enum {
     ASPEED_I2C,
     ASPEED_ETH1,
     ASPEED_ETH2,
+    ASPEED_SDRAM,
 };
=20
 #endif /* ASPEED_SOC_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 33070a6df843..10ba3f50481a 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -192,8 +192,8 @@ static void aspeed_board_init(MachineState *machine,
                                         &error_abort);
=20
     memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_siz=
e);
-    memory_region_add_subregion(get_system_memory(), sc->info->sdram_bas=
e,
-                                &bmc->ram);
+    memory_region_add_subregion(get_system_memory(),
+                                sc->info->memmap[ASPEED_SDRAM], &bmc->ra=
m);
     object_property_add_const_link(OBJECT(&bmc->soc), "ram", OBJECT(&bmc=
->ram),
                                    &error_abort);
=20
@@ -202,7 +202,7 @@ static void aspeed_board_init(MachineState *machine,
     memory_region_init_io(&bmc->max_ram, NULL, &max_ram_ops, NULL,
                           "max_ram", max_ram_size  - ram_size);
     memory_region_add_subregion(get_system_memory(),
-                                sc->info->sdram_base + ram_size,
+                                sc->info->memmap[ASPEED_SDRAM] + ram_siz=
e,
                                 &bmc->max_ram);
=20
     aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &error_abor=
t);
@@ -230,7 +230,7 @@ static void aspeed_board_init(MachineState *machine,
     aspeed_board_binfo.initrd_filename =3D machine->initrd_filename;
     aspeed_board_binfo.kernel_cmdline =3D machine->kernel_cmdline;
     aspeed_board_binfo.ram_size =3D ram_size;
-    aspeed_board_binfo.loader_start =3D sc->info->sdram_base;
+    aspeed_board_binfo.loader_start =3D sc->info->memmap[ASPEED_SDRAM];
=20
     if (cfg->i2c_init) {
         cfg->i2c_init(bmc);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 0f661ba3879d..4b705afd096a 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -22,21 +22,58 @@
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
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
@@ -68,17 +105,9 @@ static const int aspeed_soc_ast2400_irqmap[] =3D {
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
@@ -87,50 +116,46 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .name         =3D "ast2400-a0",
         .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
         .silicon_rev  =3D AST2400_A0_SILICON_REV,
-        .sdram_base   =3D AST2400_SDRAM_BASE,
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
@@ -210,8 +235,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
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
@@ -227,8 +252,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
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
@@ -236,7 +261,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
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
@@ -244,7 +269,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
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
@@ -256,7 +281,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
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
@@ -265,8 +291,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
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
@@ -276,7 +301,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
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
@@ -286,7 +311,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
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
@@ -302,7 +327,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
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
@@ -313,7 +339,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
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
@@ -323,7 +349,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                        ASPEED_SOC_WDT_BASE + i * 0x20);
+                        sc->info->memmap[ASPEED_WDT] + i * 0x20);
     }
=20
     /* Net */
@@ -336,7 +362,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
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


