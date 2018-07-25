Received: from eggs.gnu.org ([2001:4830:134:3::10]:48554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1fiKs0-00018P-18
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1fiKrx-00069E-1g
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:34:28 -0400
Received: from xavier.telenet-ops.be ([2a02:1800:120:4::f00:14]:34204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1fiKrw-00067H-Nz
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:34:24 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 25 Jul 2018 16:34:13 +0200
Message-Id: <20180725143413.9728-5-geert+renesas@glider.be>
In-Reply-To: <20180725143413.9728-1-geert+renesas@glider.be>
References: <20180725143413.9728-1-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH v3 4/4] hw/arm/sysbus-fdt: Add support for
 instantiating generic devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a fallback for instantiating generic devices without a type-specific
or compatible-specific instantation method.  This will be used when no
other match is found.

The generic instantation method creates a device node with "reg" and
(optional) "interrupts" properties, and copies the "compatible"
property and other optional properties from the host.
For now the following optional properties are copied, if found:
  - "#gpio-cells",
  - "gpio-controller",
  - "#interrupt-cells",
  - "interrupt-controller",
  - "interrupt-names".

More can be added when needed.

This avoids having to write device-specific instantation methods for
each and every "simple" device using only a set of generic properties.
Devices that need more specialized handling can still provide their
own instantation method.

This has been tested on a Renesas Salvator-XS board with R-Car H3 ES2.0
with SATA:

    -device vfio-platform,host=ee300000.sata

and GPIO (needs VFIO No-IOMMU support):

    -device vfio-platform,host=e6055400.gpio

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 hw/arm/sysbus-fdt.c | 102 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 0e24c803a1c2c734..8040af00ccf131d7 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -415,6 +415,99 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
     return 0;
 }
 
+static HostProperty generic_copied_properties[] = {
+    {"compatible", false},
+    {"#gpio-cells", true},
+    {"gpio-controller", true},
+    {"#interrupt-cells", true},
+    {"interrupt-controller", true},
+    {"interrupt-names", true},
+};
+
+/**
+ * add_generic_fdt_node
+ *
+ * Generates a generic DT node by copying properties from the host
+ */
+static int add_generic_fdt_node(SysBusDevice *sbdev, void *opaque)
+{
+    PlatformBusFDTData *data = opaque;
+    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
+    const char *parent_node = data->pbus_node_name;
+    void *guest_fdt = data->fdt, *host_fdt;
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    char **node_path, *node_name, *dt_name;
+    PlatformBusDevice *pbus = data->pbus;
+    int i, irq_number;
+    uint32_t *reg_attr, *irq_attr;
+    uint64_t mmio_base;
+
+    host_fdt = load_device_tree_from_sysfs();
+
+    dt_name = sysfs_to_dt_name(vbasedev->name);
+    if (!dt_name) {
+        error_report("%s incorrect sysfs device name %s", __func__,
+                     vbasedev->name);
+        exit(1);
+    }
+    node_path = qemu_fdt_node_path(host_fdt, dt_name, vdev->compat,
+                                   &error_fatal);
+    if (!node_path || !node_path[0]) {
+        error_report("%s unable to retrieve node path for %s/%s", __func__,
+                     dt_name, vdev->compat);
+        exit(1);
+    }
+
+    if (node_path[1]) {
+        error_report("%s more than one node matching %s/%s!", __func__, dt_name,
+                     vdev->compat);
+        exit(1);
+    }
+
+    mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    node_name = g_strdup_printf("%s/%s@%" PRIx64, parent_node,
+                               vbasedev->name, mmio_base);
+    qemu_fdt_add_subnode(guest_fdt, node_name);
+
+    /* Copy generic properties */
+    copy_properties_from_host(generic_copied_properties,
+                              ARRAY_SIZE(generic_copied_properties), host_fdt,
+                              guest_fdt, node_path[0], node_name);
+
+    /* Copy reg (remapped) */
+    reg_attr = g_new(uint32_t, vbasedev->num_regions * 2);
+    for (i = 0; i < vbasedev->num_regions; i++) {
+        mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, i);
+        reg_attr[2 * i] = cpu_to_be32(mmio_base);
+        reg_attr[2 * i + 1] = cpu_to_be32(
+                                memory_region_size(vdev->regions[i]->mem));
+    }
+    qemu_fdt_setprop(guest_fdt, node_name, "reg", reg_attr,
+                     vbasedev->num_regions * 2 * sizeof(uint32_t));
+
+    /* Copy interrupts (remapped) */
+    if (vbasedev->num_irqs) {
+        irq_attr = g_new(uint32_t, vbasedev->num_irqs * 3);
+        for (i = 0; i < vbasedev->num_irqs; i++) {
+            irq_number = platform_bus_get_irqn(pbus, sbdev , i)
+                             + data->irq_start;
+            irq_attr[3 * i] = cpu_to_be32(GIC_FDT_IRQ_TYPE_SPI);
+            irq_attr[3 * i + 1] = cpu_to_be32(irq_number);
+            irq_attr[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        }
+        qemu_fdt_setprop(guest_fdt, node_name, "interrupts",
+                         irq_attr, vbasedev->num_irqs * 3 * sizeof(uint32_t));
+        g_free(irq_attr);
+    }
+
+    g_free(reg_attr);
+    g_free(node_name);
+    g_strfreev(node_path);
+    g_free(dt_name);
+    g_free(host_fdt);
+    return 0;
+}
+
 /* DT compatible matching */
 static bool vfio_platform_match(SysBusDevice *sbdev,
                                 const BindingEntry *entry)
@@ -423,6 +516,11 @@ static bool vfio_platform_match(SysBusDevice *sbdev,
     const char *compat;
     unsigned int n;
 
+    if (!entry->compat) {
+        /* Generic DT fallback */
+        return true;
+    }
+
     for (n = vdev->num_compat, compat = vdev->compat; n > 0;
          n--, compat += strlen(compat) + 1) {
         if (!strcmp(entry->compat, compat)) {
@@ -459,6 +557,10 @@ static const BindingEntry bindings[] = {
     VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
 #endif
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
+#ifdef CONFIG_LINUX
+    /* Generic DT fallback must be last */
+    VFIO_PLATFORM_BINDING(NULL, add_generic_fdt_node),
+#endif
     TYPE_BINDING("", NULL), /* last element */
 };
 
-- 
2.17.1
