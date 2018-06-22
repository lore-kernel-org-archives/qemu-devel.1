Received: from eggs.gnu.org ([2001:4830:134:3::10]:44328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRlF-0000tm-6F
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRlB-0004sr-VJ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:30:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRlB-0004rN-HX
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:30:17 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 22 Jun 2018 12:30:06 -0700
Message-Id: <8eaf7bd5e178b897765f99abac553a664663193c.1529695276.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1529695276.git.alistair.francis@wdc.com>
References: <cover.1529695276.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 3/5] hw/riscv/virt: Connect the Xilinx PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, alistair23@gmail.com, palmer@sifive.com, mjc@sifive.com

Connect the Xilinx PCIe device based on the device tree included in the
HiFive Unleashed ROM.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 default-configs/riscv32-softmmu.mak |  3 ++
 default-configs/riscv64-softmmu.mak |  3 ++
 hw/riscv/virt.c                     | 65 +++++++++++++++++++++++++++++
 include/hw/riscv/virt.h             |  4 +-
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index 7a003eb5e2..b8cac7a49f 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -4,3 +4,6 @@ CONFIG_SERIAL=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO=y
 CONFIG_CADENCE=y
+
+CONFIG_PCI=y
+CONFIG_PCI_XILINX=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index 7a003eb5e2..b8cac7a49f 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -4,3 +4,6 @@ CONFIG_SERIAL=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO=y
 CONFIG_CADENCE=y
+
+CONFIG_PCI=y
+CONFIG_PCI_XILINX=y
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a95ccb2825..7c1ed3aee5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -38,6 +38,8 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
 #include "exec/address-spaces.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-host/xilinx-pcie.h"
 #include "elf.h"
 
 #include <libfdt.h>
@@ -54,6 +56,7 @@ static const struct MemmapEntry {
     [VIRT_UART0] =    { 0x10000000,      0x100 },
     [VIRT_VIRTIO] =   { 0x10001000,     0x1000 },
     [VIRT_DRAM] =     { 0x80000000,        0x0 },
+    [VIRT_PCIE] =     { 0x2000000000, 0x4000000 },
 };
 
 static uint64_t load_kernel(const char *kernel_filename)
@@ -232,6 +235,32 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         g_free(nodename);
     }
 
+    nodename = g_strdup_printf("/pci@%lx",
+        (long) memmap[VIRT_PCIE].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 0x3);
+    qemu_fdt_setprop_cells(fdt, nodename, "#interrupt-cells", 0x1);
+    qemu_fdt_setprop_cells(fdt, nodename, "#size-cells", 0x2);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+                            "xlnx,axi-pcie-host-1.00.a");
+    qemu_fdt_setprop_string(fdt, nodename, "device_type", "pci");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg", 0x20, 0x0, 0x0,
+                           memmap[VIRT_PCIE].size);
+    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
+    qemu_fdt_setprop_cells(fdt, nodename, "ranges", 0x2000000, 0x0,
+                           0x40000000, 0x0, 0x40000000, 0x0, 0x20000000);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupts", PCIE_IRQ);
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/pci@%lx/interrupt-controller",
+            (long) memmap[VIRT_PCIE].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 0x00);
+    qemu_fdt_setprop_cells(fdt, nodename, "#interrupt-cells", 0x1);
+    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
+    g_free(nodename);
+
     nodename = g_strdup_printf("/test@%lx",
         (long)memmap[VIRT_TEST].base);
     qemu_fdt_add_subnode(fdt, nodename);
@@ -259,6 +288,38 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     return fdt;
 }
 
+
+static inline DeviceState *
+xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
+                 hwaddr cfg_base, uint64_t cfg_size,
+                 hwaddr mmio_base, uint64_t mmio_size,
+                 qemu_irq irq, bool link_up)
+{
+    DeviceState *dev;
+    MemoryRegion *cfg, *mmio;
+
+    dev = qdev_create(NULL, TYPE_XILINX_PCIE_HOST);
+
+    qdev_prop_set_uint32(dev, "bus_nr", bus_nr);
+    qdev_prop_set_uint64(dev, "cfg_base", cfg_base);
+    qdev_prop_set_uint64(dev, "cfg_size", cfg_size);
+    qdev_prop_set_uint64(dev, "mmio_base", mmio_base);
+    qdev_prop_set_uint64(dev, "mmio_size", mmio_size);
+    qdev_prop_set_bit(dev, "link_up", link_up);
+
+    qdev_init_nofail(dev);
+
+    cfg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
+
+    mmio = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_add_subregion_overlap(sys_mem, 0, mmio, 0);
+
+    qdev_connect_gpio_out_named(dev, "interrupt_out", 0, irq);
+
+    return dev;
+}
+
 static void riscv_virt_board_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = virt_memmap;
@@ -382,6 +443,10 @@ static void riscv_virt_board_init(MachineState *machine)
             qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
     }
 
+    xilinx_pcie_init(system_memory, 0, memmap[VIRT_PCIE].base,
+                     memmap[VIRT_PCIE].size, 0x40000000, 0x20000000,
+                     qdev_get_gpio_in(DEVICE(s->plic), PCIE_IRQ), true);
+
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7cb2742070..d0129c2ca5 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -38,13 +38,15 @@ enum {
     VIRT_PLIC,
     VIRT_UART0,
     VIRT_VIRTIO,
-    VIRT_DRAM
+    VIRT_DRAM,
+    VIRT_PCIE
 };
 
 enum {
     UART0_IRQ = 10,
     VIRTIO_IRQ = 1, /* 1 to 8 */
     VIRTIO_COUNT = 8,
+    PCIE_IRQ = 0x20,
     VIRTIO_NDEV = 0x35
 };
 
-- 
2.17.1
