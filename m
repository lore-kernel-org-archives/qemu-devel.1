Received: from eggs.gnu.org ([2001:4830:134:3::10]:58396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSm-0003vY-9u
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSi-0006N8-Aw
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:08 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 27 Jul 2018 11:54:15 +0200
Message-Id: <20180727095421.386-15-luc.michel@greensocs.com>
In-Reply-To: <20180727095421.386-1-luc.michel@greensocs.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v5 14/20] intc/arm_gic: Wire the vCPU interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

Add the read/write functions to handle accesses to the vCPU interface.
Those accesses are forwarded to the real CPU interface, with the CPU id
being converted to the corresponding vCPU id (vCPU id = CPU id +
GIC_NCPU).

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 hw/intc/arm_gic.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 0e1b23047e..7ee2e6bcbb 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1553,10 +1553,27 @@ static MemTxResult gic_do_cpu_write(void *opaque, hwaddr addr,
     GICState *s = *backref;
     int id = (backref - s->backref);
     return gic_cpu_write(s, id, addr, value, attrs);
 }
 
+static MemTxResult gic_thisvcpu_read(void *opaque, hwaddr addr, uint64_t *data,
+                                    unsigned size, MemTxAttrs attrs)
+{
+    GICState *s = (GICState *)opaque;
+
+    return gic_cpu_read(s, gic_get_current_vcpu(s), addr, data, attrs);
+}
+
+static MemTxResult gic_thisvcpu_write(void *opaque, hwaddr addr,
+                                     uint64_t value, unsigned size,
+                                     MemTxAttrs attrs)
+{
+    GICState *s = (GICState *)opaque;
+
+    return gic_cpu_write(s, gic_get_current_vcpu(s), addr, value, attrs);
+}
+
 static const MemoryRegionOps gic_ops[2] = {
     {
         .read_with_attrs = gic_dist_read,
         .write_with_attrs = gic_dist_write,
         .endianness = DEVICE_NATIVE_ENDIAN,
@@ -1572,10 +1589,23 @@ static const MemoryRegionOps gic_cpu_ops = {
     .read_with_attrs = gic_do_cpu_read,
     .write_with_attrs = gic_do_cpu_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static const MemoryRegionOps gic_virt_ops[2] = {
+    {
+        .read_with_attrs = NULL,
+        .write_with_attrs = NULL,
+        .endianness = DEVICE_NATIVE_ENDIAN,
+    },
+    {
+        .read_with_attrs = gic_thisvcpu_read,
+        .write_with_attrs = gic_thisvcpu_write,
+        .endianness = DEVICE_NATIVE_ENDIAN,
+    }
+};
+
 static void arm_gic_realize(DeviceState *dev, Error **errp)
 {
     /* Device instance realize function for the GIC sysbus device */
     int i;
     GICState *s = ARM_GIC(dev);
@@ -1593,12 +1623,15 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "KVM with user space irqchip only works when the "
                          "host kernel supports KVM_CAP_ARM_USER_IRQ");
         return;
     }
 
-    /* This creates distributor and main CPU interface (s->cpuiomem[0]) */
-    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops, NULL);
+    /* This creates distributor, main CPU interface (s->cpuiomem[0]) and if
+     * enabled, virtualization extensions related interfaces (main virtual
+     * interface (s->vifaceiomem[0]) and virtual CPU interface).
+     */
+    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops, gic_virt_ops);
 
     /* Extra core-specific regions for the CPU interfaces. This is
      * necessary for "franken-GIC" implementations, for example on
      * Exynos 4.
      * NB that the memory region size of 0x100 applies for the 11MPCore
-- 
2.18.0
