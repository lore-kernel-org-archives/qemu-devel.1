Received: from eggs.gnu.org ([2001:4830:134:3::10]:40932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cybH7-0002Ja-Qi
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cybH3-0000vz-T7
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:42:49 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:54526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cybH3-0000vl-Mo
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:42:45 -0400
Received: from player715.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 01939317E8
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 11:42:43 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 13 Apr 2017 11:41:53 +0200
Message-Id: <1492076514-28821-5-git-send-email-clg@kaod.org>
In-Reply-To: <1492076514-28821-1-git-send-email-clg@kaod.org>
References: <1492076514-28821-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/5] aspeed: add a FTGMAC100 nic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

There is a second NIC but we do not use it for the moment. We use the
'aspeed' property to tune the definition of the end of ring buffer bit
for the Aspeed SoCs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed_soc.c         | 21 +++++++++++++++++++++
 include/hw/arm/aspeed_soc.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 712ae9d6c54d..af0964cf6add 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -19,6 +19,7 @@
 #include "hw/char/serial.h"
 #include "qemu/log.h"
 #include "hw/i2c/aspeed_i2c.h"
+#include "net/net.h"
=20
 #define ASPEED_SOC_UART_5_BASE      0x00184000
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
@@ -33,6 +34,8 @@
 #define ASPEED_SOC_TIMER_BASE       0x1E782000
 #define ASPEED_SOC_WDT_BASE         0x1E785000
 #define ASPEED_SOC_I2C_BASE         0x1E78A000
+#define ASPEED_SOC_ETH1_BASE        0x1E660000
+#define ASPEED_SOC_ETH2_BASE        0x1E680000
=20
 static const int uart_irqs[] =3D { 9, 32, 33, 34, 10 };
 static const int timer_irqs[] =3D { 16, 17, 18, 35, 36, 37, 38, 39, };
@@ -177,6 +180,10 @@ static void aspeed_soc_init(Object *obj)
     qdev_set_parent_bus(DEVICE(&s->wdt), sysbus_get_default());
     object_property_add_const_link(OBJECT(&s->wdt), "scu", OBJECT(&s->sc=
u),
                                    NULL);
+
+    object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC10=
0);
+    object_property_add_child(obj, "ftgmac100", OBJECT(&s->ftgmac100), N=
ULL);
+    qdev_set_parent_bus(DEVICE(&s->ftgmac100), sysbus_get_default());
 }
=20
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
@@ -304,6 +311,20 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, ASPEED_SOC_WDT_BASE);
+
+    /* Net */
+    qdev_set_nic_properties(DEVICE(&s->ftgmac100), &nd_table[0]);
+    object_property_set_bool(OBJECT(&s->ftgmac100), true, "aspeed", &err=
);
+    object_property_set_bool(OBJECT(&s->ftgmac100), true, "realized",
+                             &local_err);
+    error_propagate(&err, local_err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_BA=
SE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
+                       qdev_get_gpio_in(DEVICE(&s->vic), 2));
 }
=20
 static void aspeed_soc_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index dbec0c159885..4c5fc66a1ee0 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -20,6 +20,7 @@
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
+#include "hw/net/ftgmac100.h"
=20
 #define ASPEED_SPIS_NUM  2
=20
@@ -39,6 +40,7 @@ typedef struct AspeedSoCState {
     AspeedSMCState spi[ASPEED_SPIS_NUM];
     AspeedSDMCState sdmc;
     AspeedWDTState wdt;
+    FTGMAC100State ftgmac100;
 } AspeedSoCState;
=20
 #define TYPE_ASPEED_SOC "aspeed-soc"
--=20
2.7.4
