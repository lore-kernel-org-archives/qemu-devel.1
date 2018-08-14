Received: from eggs.gnu.org ([2001:4830:134:3::10]:52652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvT-0004uI-VJ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdu5-0006ij-4g
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:15 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdu4-0006gE-5x
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:48 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdu2-0007I1-8y
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:46 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:55 +0100
Message-Id: <20180814181815.23348-26-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 25/45] intc/arm_gic: Wire the vCPU interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc Michel <luc.michel@greensocs.com>

Add the read/write functions to handle accesses to the vCPU interface.
Those accesses are forwarded to the real CPU interface, with the CPU id
being converted to the corresponding vCPU id (vCPU id = CPU id +
GIC_NCPU).

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180727095421.386-15-luc.michel@greensocs.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 0e1b23047e3..7ee2e6bcbb3 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1555,6 +1555,23 @@ static MemTxResult gic_do_cpu_write(void *opaque, hwaddr addr,
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
@@ -1574,6 +1591,19 @@ static const MemoryRegionOps gic_cpu_ops = {
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
@@ -1595,8 +1625,11 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
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
-- 
2.18.0
