Received: from eggs.gnu.org ([2001:4830:134:3::10]:35474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZu-0002Mj-E1
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZt-0001IZ-IP
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:14 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtZt-0001I9-CC
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:13 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZs-0003u6-I8
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:12 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:04 +0000
Message-Id: <1482852077-19397-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/25] aspeed: QOMify the CPU object and attach
 it to the SoC
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

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1480434248-27138-4-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  2 +-
 hw/arm/aspeed_soc.c         | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 5406b49..6f1b679 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -27,7 +27,7 @@ typedef struct AspeedSoCState {
     DeviceState parent;
 
     /*< public >*/
-    ARMCPU *cpu;
+    ARMCPU cpu;
     MemoryRegion iomem;
     AspeedVICState vic;
     AspeedTimerCtrlState timerctrl;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index e14f5c2..db145e2 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -87,9 +87,13 @@ static void aspeed_soc_init(Object *obj)
 {
     AspeedSoCState *s = ASPEED_SOC(obj);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    char *cpu_typename;
     int i;
 
-    s->cpu = cpu_arm_init(sc->info->cpu_model);
+    cpu_typename = g_strdup_printf("%s-" TYPE_ARM_CPU, sc->info->cpu_model);
+    object_initialize(&s->cpu, sizeof(s->cpu), cpu_typename);
+    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
+    g_free(cpu_typename);
 
     object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
     object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
@@ -146,6 +150,13 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(get_system_memory(),
                                         ASPEED_SOC_IOMEM_BASE, &s->iomem, -1);
 
+    /* CPU */
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
     /* VIC */
     object_property_set_bool(OBJECT(&s->vic), true, "realized", &err);
     if (err) {
@@ -154,9 +165,9 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, ASPEED_SOC_VIC_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 0,
-                       qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
+                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 1,
-                       qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_FIQ));
+                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
     /* Timer */
     object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &err);
-- 
2.7.4
