Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714C2C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C24420726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C24420726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysgo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00OM-0008Gt-H0
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 04:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rka@sysgo.com>) id 1j00NL-0006hp-Mu
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rka@sysgo.com>) id 1j00NK-0000ue-Mx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:56:39 -0500
Received: from mail.sysgo.com ([176.9.12.79]:52560)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <rka@sysgo.com>)
 id 1j00NI-0000sl-7j; Fri, 07 Feb 2020 04:56:36 -0500
From: Roman Kapl <rka@sysgo.com>
To: qemu-arm@nongnu.org
Subject: [PATCH] i.MX: Add support for WDT on i.MX6
Date: Fri,  7 Feb 2020 10:55:29 +0100
Message-Id: <20200207095529.11309-1-rka@sysgo.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 176.9.12.79
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Roman Kapl <rka@sysgo.com>,
 qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Uses the i.MX2 rudimentary watchdog driver.

Signed-off-by: Roman Kapl <rka@sysgo.com>
---
 hw/arm/fsl-imx6.c         | 21 +++++++++++++++++++++
 include/hw/arm/fsl-imx6.h |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 7b7b97f74c..f2adaca1c5 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -87,6 +87,12 @@ static void fsl_imx6_init(Object *obj)
         sysbus_init_child_obj(obj, name, &s->spi[i], sizeof(s->spi[i]),
                               TYPE_IMX_SPI);
     }
+    for (i =3D 0; i < FSL_IMX6_NUM_WDTS; i++) {
+        snprintf(name, NAME_SIZE, "wdt%d", i);
+        sysbus_init_child_obj(obj, name, &s->wdt[i], sizeof(s->wdt[i]),
+                              TYPE_IMX2_WDT);
+    }
+
=20
     sysbus_init_child_obj(obj, "eth", &s->eth, sizeof(s->eth), TYPE_IMX_=
ENET);
 }
@@ -377,6 +383,21 @@ static void fsl_imx6_realize(DeviceState *dev, Error=
 **errp)
                        qdev_get_gpio_in(DEVICE(&s->a9mpcore),
                                         FSL_IMX6_ENET_MAC_1588_IRQ));
=20
+    /*
+     * Watchdog
+     */
+    for (i =3D 0; i < FSL_IMX6_NUM_WDTS; i++) {
+        static const hwaddr FSL_IMX6_WDOGn_ADDR[FSL_IMX6_NUM_WDTS] =3D {
+            FSL_IMX6_WDOG1_ADDR,
+            FSL_IMX6_WDOG2_ADDR,
+        };
+
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
+                                 &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX6_WDOGn_AD=
DR[i]);
+    }
+
     /* ROM memory */
     memory_region_init_rom(&s->rom, NULL, "imx6.rom",
                            FSL_IMX6_ROM_SIZE, &err);
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 06f8aaeda4..6d76cc4447 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -21,6 +21,8 @@
 #include "hw/cpu/a9mpcore.h"
 #include "hw/misc/imx6_ccm.h"
 #include "hw/misc/imx6_src.h"
+#include "hw/misc/imx6_src.h"
+#include "hw/misc/imx2_wdt.h"
 #include "hw/char/imx_serial.h"
 #include "hw/timer/imx_gpt.h"
 #include "hw/timer/imx_epit.h"
@@ -42,6 +44,7 @@
 #define FSL_IMX6_NUM_GPIOS 7
 #define FSL_IMX6_NUM_ESDHCS 4
 #define FSL_IMX6_NUM_ECSPIS 5
+#define FSL_IMX6_NUM_WDTS 2
=20
 typedef struct FslIMX6State {
     /*< private >*/
@@ -59,6 +62,7 @@ typedef struct FslIMX6State {
     IMXGPIOState   gpio[FSL_IMX6_NUM_GPIOS];
     SDHCIState     esdhc[FSL_IMX6_NUM_ESDHCS];
     IMXSPIState    spi[FSL_IMX6_NUM_ECSPIS];
+    IMX2WdtState   wdt[FSL_IMX6_NUM_WDTS];
     IMXFECState    eth;
     MemoryRegion   rom;
     MemoryRegion   caam;
--=20
2.22.0


