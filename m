Received: from eggs.gnu.org ([2001:4830:134:3::10]:52103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHR-0002I5-1y
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHQ-0007LO-2e
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHP-0007L2-QU
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHO-0000Er-Nt
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:22 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:57 +0100
Message-Id: <20180626165658.31394-32-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/32] aspeed: initialize the SCU controller
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

From: Cédric Le Goater <clg@kaod.org>

The System Control Unit should be initialized first as it drives all
the configuration of the SoC and other device models.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Acked-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 20180622075700.5923-3-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_soc.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 1955a892f4a..7cc05ee27ea 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -109,18 +109,6 @@ static void aspeed_soc_init(Object *obj)
     object_initialize(&s->cpu, sizeof(s->cpu), sc->info->cpu_type);
     object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
 
-    object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
-    object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
-    qdev_set_parent_bus(DEVICE(&s->vic), sysbus_get_default());
-
-    object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEED_TIMER);
-    object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl), NULL);
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
 
+    object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
+    object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
+    qdev_set_parent_bus(DEVICE(&s->vic), sysbus_get_default());
+
+    object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEED_TIMER);
+    object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl), NULL);
+    qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());
+
+    object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
+    object_property_add_child(obj, "i2c", OBJECT(&s->i2c), NULL);
+    qdev_set_parent_bus(DEVICE(&s->i2c), sysbus_get_default());
+
     object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename);
     object_property_add_child(obj, "fmc", OBJECT(&s->fmc), NULL);
     qdev_set_parent_bus(DEVICE(&s->fmc), sysbus_get_default());
@@ -195,6 +195,14 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), ASPEED_SOC_SRAM_BASE,
                                 &s->sram);
 
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
@@ -219,14 +227,6 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
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
         qemu_irq uart5 = qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs[4]);
-- 
2.17.1
