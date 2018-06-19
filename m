Received: from eggs.gnu.org ([2001:4830:134:3::10]:38181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fVCzJ-0005Qq-43
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fVCzH-0006Jm-Vg
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:31:45 -0400
From: luc.michel@greensocs.com
Date: Tue, 19 Jun 2018 11:31:24 +0200
Message-Id: <20180619093124.24011-8-luc.michel@greensocs.com>
In-Reply-To: <20180619093124.24011-1-luc.michel@greensocs.com>
References: <20180619093124.24011-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v2 7/7] xlnx-zynqmp: Improve GIC wiring and
 MMIO mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc MICHEL <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

From: Luc MICHEL <luc.michel@greensocs.com>

This commit improve the way the GIC is realized and connected in the
ZynqMP SoC. The security extensions are enabled only if requested in the
machine state. The same goes for the virtualization extensions.

All the GIC to APU CPU(s) IRQ lines are now connected, including FIQ,
vIRQ and vFIQ. The missing CPU to GIC timers IRQ connections are also
added (HYP and SEC timers).

The GIC maintenance IRQs are back-wired to the correct GIC PPIs.

Finally, the MMIO mappings are reworked to take into account the ZynqMP
specificities. the GIC (v)CPU interface is aliased 16 times:
  * for the firsts 0x1000 bytes from 0xf9010000 to 0xf901f000
  * for the seconds 0x1000 bytes from 0xf9020000 to 0xf902f000
Mappings of the virtual interface and virtual CPU interface are mapped
only when virtualization extensions are requested. The
XlnxZynqMPGICRegion struct has been enhanced to be able to catch all
this information.

Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>
---
 hw/arm/xlnx-zynqmp.c         | 92 ++++++++++++++++++++++++++++++++----
 include/hw/arm/xlnx-zynqmp.h |  4 +-
 2 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 2045b9d71e..4d17c70ec6 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -29,12 +29,17 @@
 
 #define ARM_PHYS_TIMER_PPI  30
 #define ARM_VIRT_TIMER_PPI  27
+#define ARM_HYP_TIMER_PPI   26
+#define ARM_SEC_TIMER_PPI   29
+#define GIC_MAINTENANCE_PPI 25
 
 #define GEM_REVISION        0x40070106
 
 #define GIC_BASE_ADDR       0xf9000000
 #define GIC_DIST_ADDR       0xf9010000
 #define GIC_CPU_ADDR        0xf9020000
+#define GIC_VIFACE_ADDR     0xf9040000
+#define GIC_VCPU_ADDR       0xf9060000
 
 #define SATA_INTR           133
 #define SATA_ADDR           0xFD0C0000
@@ -111,11 +116,54 @@ static const int adma_ch_intr[XLNX_ZYNQMP_NUM_ADMA_CH] = {
 typedef struct XlnxZynqMPGICRegion {
     int region_index;
     uint32_t address;
+    uint32_t offset;
+    bool virt;
 } XlnxZynqMPGICRegion;
 
 static const XlnxZynqMPGICRegion xlnx_zynqmp_gic_regions[] = {
-    { .region_index = 0, .address = GIC_DIST_ADDR, },
-    { .region_index = 1, .address = GIC_CPU_ADDR,  },
+    /* Distributor */
+    {
+        .region_index = 0,
+        .address = GIC_DIST_ADDR,
+        .offset = 0,
+        .virt = false
+    },
+
+    /* CPU interface */
+    {
+        .region_index = 1,
+        .address = GIC_CPU_ADDR,
+        .offset = 0,
+        .virt = false
+    },
+    {
+        .region_index = 1,
+        .address = GIC_CPU_ADDR + 0x10000,
+        .offset = 0x1000,
+        .virt = false
+    },
+
+    /* Virtual interface */
+    {
+        .region_index = 2,
+        .address = GIC_VIFACE_ADDR,
+        .offset = 0,
+        .virt = true
+    },
+
+    /* Virtual CPU interface */
+    {
+        .region_index = 3,
+        .address = GIC_VCPU_ADDR,
+        .offset = 0,
+        .virt = true
+    },
+    {
+        .region_index = 3,
+        .address = GIC_VCPU_ADDR + 0x10000,
+        .offset = 0x1000,
+        .virt = true
+    },
 };
 
 static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
@@ -286,6 +334,9 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", GIC_NUM_SPI_INTR + 32);
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
+    qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", s->secure);
+    qdev_prop_set_bit(DEVICE(&s->gic),
+                      "has-virtualization-extensions", s->virt);
 
     /* Realize APUs before realizing the GIC. KVM requires this.  */
     for (i = 0; i < num_apus; i++) {
@@ -330,19 +381,23 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_GIC_REGIONS; i++) {
         SysBusDevice *gic = SYS_BUS_DEVICE(&s->gic);
         const XlnxZynqMPGICRegion *r = &xlnx_zynqmp_gic_regions[i];
-        MemoryRegion *mr = sysbus_mmio_get_region(gic, r->region_index);
+        MemoryRegion *mr;
         uint32_t addr = r->address;
         int j;
 
-        sysbus_mmio_map(gic, r->region_index, addr);
+        if (r->virt && !s->virt) {
+            continue;
+        }
 
+        mr = sysbus_mmio_get_region(gic, r->region_index);
         for (j = 0; j < XLNX_ZYNQMP_GIC_ALIASES; j++) {
             MemoryRegion *alias = &s->gic_mr[i][j];
 
-            addr += XLNX_ZYNQMP_GIC_REGION_SIZE;
             memory_region_init_alias(alias, OBJECT(s), "zynqmp-gic-alias", mr,
-                                     0, XLNX_ZYNQMP_GIC_REGION_SIZE);
+                                     r->offset, XLNX_ZYNQMP_GIC_REGION_SIZE);
             memory_region_add_subregion(system_memory, addr, alias);
+
+            addr += XLNX_ZYNQMP_GIC_REGION_SIZE;
         }
     }
 
@@ -352,12 +407,33 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i,
                            qdev_get_gpio_in(DEVICE(&s->apu_cpu[i]),
                                             ARM_CPU_IRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + num_apus,
+                           qdev_get_gpio_in(DEVICE(&s->apu_cpu[i]),
+                                            ARM_CPU_FIQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + num_apus * 2,
+                           qdev_get_gpio_in(DEVICE(&s->apu_cpu[i]),
+                                            ARM_CPU_VIRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + num_apus * 3,
+                           qdev_get_gpio_in(DEVICE(&s->apu_cpu[i]),
+                                            ARM_CPU_VFIQ));
         irq = qdev_get_gpio_in(DEVICE(&s->gic),
                                arm_gic_ppi_index(i, ARM_PHYS_TIMER_PPI));
-        qdev_connect_gpio_out(DEVICE(&s->apu_cpu[i]), 0, irq);
+        qdev_connect_gpio_out(DEVICE(&s->apu_cpu[i]), GTIMER_PHYS, irq);
         irq = qdev_get_gpio_in(DEVICE(&s->gic),
                                arm_gic_ppi_index(i, ARM_VIRT_TIMER_PPI));
-        qdev_connect_gpio_out(DEVICE(&s->apu_cpu[i]), 1, irq);
+        qdev_connect_gpio_out(DEVICE(&s->apu_cpu[i]), GTIMER_VIRT, irq);
+        irq = qdev_get_gpio_in(DEVICE(&s->gic),
+                               arm_gic_ppi_index(i, ARM_HYP_TIMER_PPI));
+        qdev_connect_gpio_out(DEVICE(&s->apu_cpu[i]), GTIMER_HYP, irq);
+        irq = qdev_get_gpio_in(DEVICE(&s->gic),
+                               arm_gic_ppi_index(i, ARM_SEC_TIMER_PPI));
+        qdev_connect_gpio_out(DEVICE(&s->apu_cpu[i]), GTIMER_SEC, irq);
+
+        if (s->virt) {
+            irq = qdev_get_gpio_in(DEVICE(&s->gic),
+                                   arm_gic_ppi_index(i, GIC_MAINTENANCE_PPI));
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + num_apus * 4, irq);
+        }
     }
 
     if (s->has_rpu) {
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 82b6ec2486..98f925ab84 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -53,7 +53,7 @@
 #define XLNX_ZYNQMP_OCM_RAM_0_ADDRESS 0xFFFC0000
 #define XLNX_ZYNQMP_OCM_RAM_SIZE 0x10000
 
-#define XLNX_ZYNQMP_GIC_REGIONS 2
+#define XLNX_ZYNQMP_GIC_REGIONS 6
 
 /* ZynqMP maps the ARM GIC regions (GICC, GICD ...) at consecutive 64k offsets
  * and under-decodes the 64k region. This mirrors the 4k regions to every 4k
@@ -62,7 +62,7 @@
  */
 
 #define XLNX_ZYNQMP_GIC_REGION_SIZE 0x1000
-#define XLNX_ZYNQMP_GIC_ALIASES     (0x10000 / XLNX_ZYNQMP_GIC_REGION_SIZE - 1)
+#define XLNX_ZYNQMP_GIC_ALIASES     (0x10000 / XLNX_ZYNQMP_GIC_REGION_SIZE)
 
 #define XLNX_ZYNQMP_MAX_LOW_RAM_SIZE    0x80000000ull
 
-- 
2.17.1
