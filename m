Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447C3C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090C92083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090C92083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51691 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEcJ6-0004rB-7R
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 12:12:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEcHb-0003YJ-Vx
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEcHZ-0004qE-1u
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:10:35 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:36115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEcHY-0004p8-P1
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:10:32 -0400
Received: from player759.ha.ovh.net (unknown [10.109.146.240])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 717775BFE4
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 18:10:31 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
	[86.201.133.22]) (Authenticated sender: clg@kaod.org)
	by player759.ha.ovh.net (Postfix) with ESMTPSA id 72CDB4B4A97B;
	Thu, 11 Apr 2019 16:10:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 18:10:11 +0200
Message-Id: <20190411161013.4514-2-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411161013.4514-1-clg@kaod.org>
References: <20190411161013.4514-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 7419398911150492433
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudelgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.51.53
Subject: [Qemu-devel] [PATCH 1/3] aspeed: add a per SoC mapping for the
 interrupt space
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411161011.bpp5IogQJhnH2jbX72teRuz5xLE2bCfktLLMiGzOnSc@z>

This will simplify the definition of new SoCs, like the AST2600 which
should use a different CPU and a different IRQ number layout.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h |  1 +
 hw/arm/aspeed_soc.c         | 93 +++++++++++++++++++++++++++++++++----
 2 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 11ec0179db50..b0d266434288 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -57,6 +57,7 @@ typedef struct AspeedSoCInfo {
     const char *fmc_typename;
     const char **spi_typename;
     int wdts_num;
+    const int *irqmap;
 } AspeedSoCInfo;
=20
 typedef struct AspeedSoCClass {
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index a27233d4876b..5bbd1fb87d18 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -22,6 +22,42 @@
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
=20
+enum {
+    ASPEED_IOMEM,
+    ASPEED_UART1,
+    ASPEED_UART2,
+    ASPEED_UART3,
+    ASPEED_UART4,
+    ASPEED_UART5,
+    ASPEED_VUART,
+    ASPEED_FMC,
+    ASPEED_SPI1,
+    ASPEED_SPI2,
+    ASPEED_VIC,
+    ASPEED_SDMC,
+    ASPEED_SCU,
+    ASPEED_ADC,
+    ASPEED_SRAM,
+    ASPEED_GPIO,
+    ASPEED_RTC,
+    ASPEED_TIMER1,
+    ASPEED_TIMER2,
+    ASPEED_TIMER3,
+    ASPEED_TIMER4,
+    ASPEED_TIMER5,
+    ASPEED_TIMER6,
+    ASPEED_TIMER7,
+    ASPEED_TIMER8,
+    ASPEED_WDT,
+    ASPEED_PWM,
+    ASPEED_LPC,
+    ASPEED_IBT,
+    ASPEED_I2C,
+    ASPEED_ETH1,
+    ASPEED_ETH2,
+    ASPEED_SDRAM,
+};
+
 #define ASPEED_SOC_UART_5_BASE      0x00184000
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
 #define ASPEED_SOC_IOMEM_BASE       0x1E600000
@@ -38,12 +74,42 @@
 #define ASPEED_SOC_ETH1_BASE        0x1E660000
 #define ASPEED_SOC_ETH2_BASE        0x1E680000
=20
-static const int uart_irqs[] =3D { 9, 32, 33, 34, 10 };
-static const int timer_irqs[] =3D { 16, 17, 18, 35, 36, 37, 38, 39, };
+static const int aspeed_soc_ast2400_irqmap[] =3D {
+    [ASPEED_UART1]  =3D 9,
+    [ASPEED_UART2]  =3D 32,
+    [ASPEED_UART3]  =3D 33,
+    [ASPEED_UART4]  =3D 34,
+    [ASPEED_UART5]  =3D 10,
+    [ASPEED_VUART]  =3D 8,
+    [ASPEED_FMC]    =3D 19,
+    [ASPEED_SDMC]   =3D 0,
+    [ASPEED_SCU]    =3D 21,
+    [ASPEED_ADC]    =3D 31,
+    [ASPEED_GPIO]   =3D 20,
+    [ASPEED_RTC]    =3D 22,
+    [ASPEED_TIMER1] =3D 16,
+    [ASPEED_TIMER2] =3D 17,
+    [ASPEED_TIMER3] =3D 18,
+    [ASPEED_TIMER4] =3D 35,
+    [ASPEED_TIMER5] =3D 36,
+    [ASPEED_TIMER6] =3D 37,
+    [ASPEED_TIMER7] =3D 38,
+    [ASPEED_TIMER8] =3D 39,
+    [ASPEED_WDT]    =3D 27,
+    [ASPEED_PWM]    =3D 28,
+    [ASPEED_LPC]    =3D 8,
+    [ASPEED_IBT]    =3D 8, /* LPC */
+    [ASPEED_I2C]    =3D 12,
+    [ASPEED_ETH1]   =3D 2,
+    [ASPEED_ETH2]   =3D 3,
+};
=20
 #define AST2400_SDRAM_BASE       0x40000000
 #define AST2500_SDRAM_BASE       0x80000000
=20
+/* AST2500 uses the same IRQs as the AST2400 */
+#define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
+
 static const hwaddr aspeed_soc_ast2400_spi_bases[] =3D { ASPEED_SOC_SPI_=
BASE };
 static const char *aspeed_soc_ast2400_typenames[] =3D { "aspeed.smc.spi"=
 };
=20
@@ -64,6 +130,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .fmc_typename =3D "aspeed.smc.fmc",
         .spi_typename =3D aspeed_soc_ast2400_typenames,
         .wdts_num     =3D 2,
+        .irqmap       =3D aspeed_soc_ast2400_irqmap,
     }, {
         .name         =3D "ast2400-a1",
         .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
@@ -75,6 +142,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .fmc_typename =3D "aspeed.smc.fmc",
         .spi_typename =3D aspeed_soc_ast2400_typenames,
         .wdts_num     =3D 2,
+        .irqmap       =3D aspeed_soc_ast2400_irqmap,
     }, {
         .name         =3D "ast2400",
         .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
@@ -86,6 +154,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .fmc_typename =3D "aspeed.smc.fmc",
         .spi_typename =3D aspeed_soc_ast2400_typenames,
         .wdts_num     =3D 2,
+        .irqmap       =3D aspeed_soc_ast2400_irqmap,
     }, {
         .name         =3D "ast2500-a1",
         .cpu_type     =3D ARM_CPU_TYPE_NAME("arm1176"),
@@ -97,9 +166,17 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .fmc_typename =3D "aspeed.smc.ast2500-fmc",
         .spi_typename =3D aspeed_soc_ast2500_typenames,
         .wdts_num     =3D 3,
+        .irqmap       =3D aspeed_soc_ast2500_irqmap,
     },
 };
=20
+static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
+{
+    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
+
+    return qdev_get_gpio_in(DEVICE(&s->vic), sc->info->irqmap[ctrl]);
+}
+
 static void aspeed_soc_init(Object *obj)
 {
     AspeedSoCState *s =3D ASPEED_SOC(obj);
@@ -226,14 +303,14 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0, ASPEED_SOC_TIMER_B=
ASE);
-    for (i =3D 0; i < ARRAY_SIZE(timer_irqs); i++) {
-        qemu_irq irq =3D qdev_get_gpio_in(DEVICE(&s->vic), timer_irqs[i]=
);
+    for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
+        qemu_irq irq =3D aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
=20
     /* UART - attach an 8250 to the IO space as our UART5 */
     if (serial_hd(0)) {
-        qemu_irq uart5 =3D qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs[4=
]);
+        qemu_irq uart5 =3D aspeed_soc_get_irq(s, ASPEED_UART5);
         serial_mm_init(get_system_memory(),
                        ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE, 2=
,
                        uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN)=
;
@@ -247,7 +324,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, ASPEED_SOC_I2C_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
-                       qdev_get_gpio_in(DEVICE(&s->vic), 12));
+                       aspeed_soc_get_irq(s, ASPEED_I2C));
=20
     /* FMC, The number of CS is set at the board level */
     object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
@@ -259,7 +336,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
                     s->fmc.ctrl->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
-                       qdev_get_gpio_in(DEVICE(&s->vic), 19));
+                       aspeed_soc_get_irq(s, ASPEED_FMC));
=20
     /* SPI */
     for (i =3D 0; i < sc->info->spis_num; i++) {
@@ -307,7 +384,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_BA=
SE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
-                       qdev_get_gpio_in(DEVICE(&s->vic), 2));
+                       aspeed_soc_get_irq(s, ASPEED_ETH1));
 }
=20
 static void aspeed_soc_class_init(ObjectClass *oc, void *data)
--=20
2.20.1


