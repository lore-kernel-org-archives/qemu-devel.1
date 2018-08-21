Received: from eggs.gnu.org ([2001:4830:134:3::10]:60436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fs6i0-0005wE-NM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fs6hz-0003jx-Hr
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:28:32 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 14:28:09 +0100
Message-Id: <20180821132811.17675-8-peter.maydell@linaro.org>
In-Reply-To: <20180821132811.17675-1-peter.maydell@linaro.org>
References: <20180821132811.17675-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 7/9] hw/cpu/a15mpcore: If CPU has EL2,
 enable it on the GIC and wire it up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Luc Michel <luc.michel@greensocs.com>

For the A15MPCore internal peripheral object, we handle GIC
security extensions support by checking whether the CPUs
have EL3 enabled; if so then we enable it also on the GIC.
Handle the virtualization extensions in the same way: if the
CPU has EL2 then enable it on the GIC and wire up the
virtualization-specific memory regions and the maintenance
interrupt.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/a15mpcore.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 43c10794938..226ce8900f2 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -53,6 +53,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     int i;
     Error *err = NULL;
     bool has_el3;
+    bool has_el2;
     Object *cpuobj;
 
     gicdev = DEVICE(&s->gic);
@@ -67,6 +68,10 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
         has_el3 = object_property_find(cpuobj, "has_el3", NULL) &&
             object_property_get_bool(cpuobj, "has_el3", &error_abort);
         qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
+        /* Similarly for virtualization support */
+        has_el2 = object_property_find(cpuobj, "has_el2", NULL) &&
+            object_property_get_bool(cpuobj, "has_el2", &error_abort);
+        qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_el2);
     }
 
     object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
@@ -103,20 +108,40 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
                                   qdev_get_gpio_in(gicdev,
                                                    ppibase + timer_irq[irq]));
         }
+        if (has_el2) {
+            /* Connect the GIC maintenance interrupt to PPI ID 25 */
+            sysbus_connect_irq(SYS_BUS_DEVICE(gicdev), i + 4 * s->num_cpu,
+                               qdev_get_gpio_in(gicdev, ppibase + 25));
+        }
     }
 
     /* Memory map (addresses are offsets from PERIPHBASE):
      *  0x0000-0x0fff -- reserved
      *  0x1000-0x1fff -- GIC Distributor
      *  0x2000-0x3fff -- GIC CPU interface
-     *  0x4000-0x4fff -- GIC virtual interface control (not modelled)
-     *  0x5000-0x5fff -- GIC virtual interface control (not modelled)
-     *  0x6000-0x7fff -- GIC virtual CPU interface (not modelled)
+     *  0x4000-0x4fff -- GIC virtual interface control for this CPU
+     *  0x5000-0x51ff -- GIC virtual interface control for CPU 0
+     *  0x5200-0x53ff -- GIC virtual interface control for CPU 1
+     *  0x5400-0x55ff -- GIC virtual interface control for CPU 2
+     *  0x5600-0x57ff -- GIC virtual interface control for CPU 3
+     *  0x6000-0x7fff -- GIC virtual CPU interface
      */
     memory_region_add_subregion(&s->container, 0x1000,
                                 sysbus_mmio_get_region(busdev, 0));
     memory_region_add_subregion(&s->container, 0x2000,
                                 sysbus_mmio_get_region(busdev, 1));
+    if (has_el2) {
+        memory_region_add_subregion(&s->container, 0x4000,
+                                    sysbus_mmio_get_region(busdev, 2));
+        memory_region_add_subregion(&s->container, 0x6000,
+                                    sysbus_mmio_get_region(busdev, 3));
+        for (i = 0; i < s->num_cpu; i++) {
+            hwaddr base = 0x5000 + i * 0x200;
+            MemoryRegion *mr = sysbus_mmio_get_region(busdev,
+                                                      4 + s->num_cpu + i);
+            memory_region_add_subregion(&s->container, base, mr);
+        }
+    }
 }
 
 static Property a15mp_priv_properties[] = {
-- 
2.18.0
