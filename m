Received: from eggs.gnu.org ([2001:4830:134:3::10]:43079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fWGwi-0006Zg-Pv
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fWGwf-0008TF-Is
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:57:28 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:35289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fWGwf-0008Qa-Ct
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:57:25 -0400
Received: from player168.ha.ovh.net (unknown [10.109.105.96])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 6868DC66DE
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 09:57:23 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Jun 2018 09:56:59 +0200
Message-Id: <20180622075700.5923-3-clg@kaod.org>
In-Reply-To: <20180622075700.5923-1-clg@kaod.org>
References: <20180622075700.5923-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/3] aspeed: initialize the SCU controller
 first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The System Control Unit should be initialized first as it drives all
the configuration of the SoC and other device models.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 hw/arm/aspeed_soc.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 1955a892f4a4..7cc05ee27ea4 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -109,18 +109,6 @@ static void aspeed_soc_init(Object *obj)
     object_initialize(&s->cpu, sizeof(s->cpu), sc->info->cpu_type);
     object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
=20
-    object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
-    object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
-    qdev_set_parent_bus(DEVICE(&s->vic), sysbus_get_default());
-
-    object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEED_T=
IMER);
-    object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl), N=
ULL);
-    qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());
-
-    object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
-    object_property_add_child(obj, "i2c", OBJECT(&s->i2c), NULL);
-    qdev_set_parent_bus(DEVICE(&s->i2c), sysbus_get_default());
-
     object_initialize(&s->scu, sizeof(s->scu), TYPE_ASPEED_SCU);
     object_property_add_child(obj, "scu", OBJECT(&s->scu), NULL);
     qdev_set_parent_bus(DEVICE(&s->scu), sysbus_get_default());
@@ -133,6 +121,18 @@ static void aspeed_soc_init(Object *obj)
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
                               "hw-prot-key", &error_abort);
=20
+    object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
+    object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
+    qdev_set_parent_bus(DEVICE(&s->vic), sysbus_get_default());
+
+    object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEED_T=
IMER);
+    object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl), N=
ULL);
+    qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());
+
+    object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
+    object_property_add_child(obj, "i2c", OBJECT(&s->i2c), NULL);
+    qdev_set_parent_bus(DEVICE(&s->i2c), sysbus_get_default());
+
     object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename);
     object_property_add_child(obj, "fmc", OBJECT(&s->fmc), NULL);
     qdev_set_parent_bus(DEVICE(&s->fmc), sysbus_get_default());
@@ -195,6 +195,14 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
     memory_region_add_subregion(get_system_memory(), ASPEED_SOC_SRAM_BAS=
E,
                                 &s->sram);
=20
+    /* SCU */
+    object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, ASPEED_SOC_SCU_BASE);
+
     /* VIC */
     object_property_set_bool(OBJECT(&s->vic), true, "realized", &err);
     if (err) {
@@ -219,14 +227,6 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
=20
-    /* SCU */
-    object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, ASPEED_SOC_SCU_BASE);
-
     /* UART - attach an 8250 to the IO space as our UART5 */
     if (serial_hd(0)) {
         qemu_irq uart5 =3D qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs[4=
]);
--=20
2.13.6
