Received: from eggs.gnu.org ([2001:4830:134:3::10]:37359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWW-0002TP-BW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWV-00049O-6k
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:00 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWU-00045M-W5
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:59 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWM-0001P9-3S
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:50 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:33 +0000
Message-Id: <1483962824-29185-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/21] hw/arm/virt: parameter passing cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

Some simple cleanups made possible by "hw/arm/virt: Merge
VirtBoardInfo and VirtMachineState"

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20170102200153.28864-6-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2ca9527..a39fbd2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -553,10 +553,10 @@ static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
     fdt_add_v2m_gic_node(vms);
 }
 
-static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type,
-                       bool secure, bool no_its)
+static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type)
 {
     /* We create a standalone GIC */
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     DeviceState *gicdev;
     SysBusDevice *gicbusdev;
     const char *gictype;
@@ -572,7 +572,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type,
      */
     qdev_prop_set_uint32(gicdev, "num-irq", NUM_IRQS + 32);
     if (!kvm_irqchip_in_kernel()) {
-        qdev_prop_set_bit(gicdev, "has-security-extensions", secure);
+        qdev_prop_set_bit(gicdev, "has-security-extensions", vms->secure);
     }
     qdev_init_nofail(gicdev);
     gicbusdev = SYS_BUS_DEVICE(gicdev);
@@ -618,7 +618,7 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic, int type,
 
     fdt_add_gic_node(vms, type);
 
-    if (type == 3 && !no_its) {
+    if (type == 3 && !vmc->no_its) {
         create_its(vms, gicdev);
     } else if (type == 2) {
         create_v2m(vms, pic);
@@ -980,8 +980,7 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
                            0x7           /* PCI irq */);
 }
 
-static void create_pcie(const VirtMachineState *vms, qemu_irq *pic,
-                        bool use_highmem)
+static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
@@ -1024,7 +1023,7 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic,
                              mmio_reg, base_mmio, size_mmio);
     memory_region_add_subregion(get_system_memory(), base_mmio, mmio_alias);
 
-    if (use_highmem) {
+    if (vms->highmem) {
         /* Map high MMIO space */
         MemoryRegion *high_mmio_alias = g_new0(MemoryRegion, 1);
 
@@ -1073,7 +1072,7 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic,
     qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                  2, base_ecam, 2, size_ecam);
 
-    if (use_highmem) {
+    if (vms->highmem) {
         qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "ranges",
                                      1, FDT_PCI_RANGE_IOPORT, 2, 0,
                                      2, base_pio, 2, size_pio,
@@ -1384,7 +1383,7 @@ static void machvirt_init(MachineState *machine)
 
     create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
 
-    create_gic(vms, pic, gic_version, vms->secure, vmc->no_its);
+    create_gic(vms, pic, gic_version);
 
     fdt_add_pmu_nodes(vms, gic_version);
 
@@ -1397,7 +1396,7 @@ static void machvirt_init(MachineState *machine)
 
     create_rtc(vms, pic);
 
-    create_pcie(vms, pic, vms->highmem);
+    create_pcie(vms, pic);
 
     create_gpio(vms, pic);
 
-- 
2.7.4
