Received: from eggs.gnu.org ([2001:4830:134:3::10]:40007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kieran@bingham.xyz>) id 1fTpuy-0007Wh-WC
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kieran@bingham.xyz>) id 1fTpux-0004tO-NO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:41:37 -0400
From: Kieran Bingham <kieran@bingham.xyz>
Date: Fri, 15 Jun 2018 15:41:23 +0100
Message-Id: <20180615144123.20844-1-kieran@bingham.xyz>
Subject: [Qemu-devel] [PATCH] [QEMU][RFC] hw/arm/sysbus-fdt: Enable
 rcar-gen3-scif dynamic instantiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-renesas-soc@vger.kernel.org, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, geert@glider.be, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran@bingham.xyz>

Allow the provision of a Renesas R-Car Gen3 (H)SCIF controller device
from the Qemu command line:

  -device vfio-platform,host=e6e68000.serial,manufacturer=renesas,model=rcar-gen3-scif

To support this, the serial device must be unbound from the host, and
rebound to the vfio-platform driver:

  echo 1 > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
  echo e6e68000.serial > /sys/bus/platform/drivers/sh-sci/unbind
  echo vfio-platform > /sys/bus/platform/devices/e6e68000.serial/driver_override
  echo e6e68000.serial > /sys/bus/platform/drivers/vfio-platform/bind

Ideally, this patch should be unnecessary and the FDT should be
generated automatically from the host, or perhaps with the provision of
a DTO, allowing the configuration to be provided externally from Q-Emu.

The functionality of this patch mostly duplicates the
add_rcar_gpio_fdt_node() with the exception of the gpio-controller node,
and #gpio-cells.

Not-Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

---

This patch supports testing of serial device passthrough on R-Car Gen3,
and is not meant to be upstreamed as is. This serves as a purpose for
ongoing development and investigation into para-virtualisation of the
R-Car Gen3 platforms, and highlights the extensions needed to support
passing through a basic serial device to a guest.

This patch and its dependencies is available at the following branch:

  https://github.com/kbingham/qemu.git rcar3/serial/passthrough

This builds upon existing work [0] done by Geert Uytterhoeven

 [0]  https://www.spinics.net/lists/kvm/msg163975.html
---
 hw/arm/sysbus-fdt.c | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index a04e5b384c29..ec755e0f4652 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -477,6 +477,66 @@ static int add_rcar_gpio_fdt_node(SysBusDevice *sbdev, void *opaque)
     return 0;
 }
 
+/**
+ * add_rcar_scif_fdt_node
+ *
+ * Generates a simple node with following properties:
+ * compatible string, regs, #gpio-cells, gpio-controller
+ */
+static int add_rcar_scif_fdt_node(SysBusDevice *sbdev, void *opaque)
+{
+    PlatformBusFDTData *data = opaque;
+    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
+    const char *parent_node = data->pbus_node_name;
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    PlatformBusDevice *pbus = data->pbus;
+    int compat_str_len, i, irq_number;
+    uint32_t *reg_attr, *irq_attr;
+    void *fdt = data->fdt;
+    uint64_t mmio_base;
+    char *nodename;
+
+    mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    nodename = g_strdup_printf("%s/%s@%" PRIx64, parent_node,
+                               vbasedev->name, mmio_base);
+    qemu_fdt_add_subnode(fdt, nodename);
+
+    printf("%s - using nodename :%s\n", __func__, nodename);
+
+    /* Add compatible */
+    compat_str_len = strlen(vdev->compat) + 1;
+    qemu_fdt_setprop(fdt, nodename, "compatible",
+                          vdev->compat, compat_str_len);
+
+    /* Copy reg */
+    reg_attr = g_new(uint32_t, vbasedev->num_regions * 2);
+    for (i = 0; i < vbasedev->num_regions; i++) {
+        mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, i);
+        reg_attr[2 * i] = cpu_to_be32(mmio_base);
+        reg_attr[2 * i + 1] = cpu_to_be32(
+                                memory_region_size(vdev->regions[i]->mem));
+    }
+    qemu_fdt_setprop(fdt, nodename, "reg", reg_attr,
+                     vbasedev->num_regions * 2 * sizeof(uint32_t));
+
+    /* Copy interrupts */
+    irq_attr = g_new(uint32_t, vbasedev->num_irqs * 3);
+    for (i = 0; i < vbasedev->num_irqs; i++) {
+        irq_number = platform_bus_get_irqn(pbus, sbdev , i)
+                         + data->irq_start;
+        irq_attr[3 * i] = cpu_to_be32(GIC_FDT_IRQ_TYPE_SPI);
+        irq_attr[3 * i + 1] = cpu_to_be32(irq_number);
+        irq_attr[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    }
+    qemu_fdt_setprop(fdt, nodename, "interrupts",
+                     irq_attr, vbasedev->num_irqs * 3 * sizeof(uint32_t));
+
+    g_free(irq_attr);
+    g_free(reg_attr);
+    g_free(nodename);
+    return 0;
+}
+
 /* manufacturer/model matching */
 static bool vfio_platform_match(SysBusDevice *sbdev,
                                 const BindingEntry *entry)
@@ -516,6 +576,7 @@ static const BindingEntry bindings[] = {
     TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
     VFIO_PLATFORM_BINDING("amd", "xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
     VFIO_PLATFORM_BINDING("renesas", "rcar-gen3-gpio", add_rcar_gpio_fdt_node),
+    VFIO_PLATFORM_BINDING("renesas", "rcar-gen3-scif", add_rcar_scif_fdt_node),
 #endif
     TYPE_BINDING("", NULL), /* last element */
 };
-- 
2.17.1
