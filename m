Received: from eggs.gnu.org ([2001:4830:134:3::10]:57395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cj8xY-0004lE-JX
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cj8xX-0006uu-O6
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:26:44 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed,  1 Mar 2017 20:26:15 +0200
Message-Id: <20170301182618.22395-3-krzk@kernel.org>
In-Reply-To: <20170301182618.22395-1-krzk@kernel.org>
References: <20170301182618.22395-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH 2/5] hw/intc/exynos4210_gic: Use more
 meaningful name for local variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhao@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>

There are to SysBusDevice variables in exynos4210_gic_realize()
function: one for the device itself and second for arm_gic device.  Add
a prefix "gic" to the second one so it will be easier to understand the
code.

While at it, put local uninitialized 'i' variable at the end, next to
other uninitialized ones.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/intc/exynos4210_gic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index 5986e54d39c9..4f7a8b6ca709 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -296,21 +296,21 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
 {
     Exynos4210GicState *s = EXYNOS4210_GIC(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    uint32_t i;
     const char cpu_prefix[] = "exynos4210-gic-alias_cpu";
     const char dist_prefix[] = "exynos4210-gic-alias_dist";
     char cpu_alias_name[sizeof(cpu_prefix) + 3];
     char dist_alias_name[sizeof(cpu_prefix) + 3];
-    SysBusDevice *busdev;
+    SysBusDevice *gicbusdev;
+    uint32_t i;
 
     s->gic = qdev_create(NULL, "arm_gic");
     qdev_prop_set_uint32(s->gic, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(s->gic, "num-irq", EXYNOS4210_GIC_NIRQ);
     qdev_init_nofail(s->gic);
-    busdev = SYS_BUS_DEVICE(s->gic);
+    gicbusdev = SYS_BUS_DEVICE(s->gic);
 
     /* Pass through outbound IRQ lines from the GIC */
-    sysbus_pass_irq(sbd, busdev);
+    sysbus_pass_irq(sbd, gicbusdev);
 
     /* Pass through inbound GPIO lines to the GIC */
     qdev_init_gpio_in(dev, exynos4210_gic_set_irq,
@@ -321,7 +321,7 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
         sprintf(cpu_alias_name, "%s%x", cpu_prefix, i);
         memory_region_init_alias(&s->cpu_alias[i], OBJECT(s),
                                  cpu_alias_name,
-                                 sysbus_mmio_get_region(busdev, 1),
+                                 sysbus_mmio_get_region(gicbusdev, 1),
                                  0,
                                  EXYNOS4210_GIC_CPU_REGION_SIZE);
         memory_region_add_subregion(&s->cpu_container,
@@ -331,7 +331,7 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
         sprintf(dist_alias_name, "%s%x", dist_prefix, i);
         memory_region_init_alias(&s->dist_alias[i], OBJECT(s),
                                  dist_alias_name,
-                                 sysbus_mmio_get_region(busdev, 0),
+                                 sysbus_mmio_get_region(gicbusdev, 0),
                                  0,
                                  EXYNOS4210_GIC_DIST_REGION_SIZE);
         memory_region_add_subregion(&s->dist_container,
-- 
2.9.3
