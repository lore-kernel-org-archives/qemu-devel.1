Received: from eggs.gnu.org ([2001:4830:134:3::10]:51761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKsq-0000Zb-Ht
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKsn-0000jH-D4
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:12:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKsm-0000in-VY
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:12:21 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 16 Aug 2018 09:11:59 -0700
Message-Id: <b662ea5294b6b16fc7e1c132c88db499f639d28f.1534435831.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1534435831.git.alistair.francis@wdc.com>
References: <cover.1534435831.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 3/6] hw/riscv/virt: Connect the gpex PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mjc@sifive.com
Cc: alistair.francis@wdc.com, alistair23@gmail.com

Connect the gpex PCIe device based on the device tree included in the
HiFive Unleashed ROM.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 default-configs/riscv32-softmmu.mak |  3 ++
 default-configs/riscv64-softmmu.mak |  3 ++
 hw/riscv/virt.c                     | 58 +++++++++++++++++++++++++++++
 include/hw/riscv/virt.h             |  4 +-
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index 7937c69e22..2c943e2669 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -5,3 +5,6 @@ CONFIG_VIRTIO_MMIO=y
 include virtio.mak
 
 CONFIG_CADENCE=y
+
+CONFIG_PCI=y
+CONFIG_PCI_GENERIC=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index 7937c69e22..2c943e2669 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -5,3 +5,6 @@ CONFIG_VIRTIO_MMIO=y
 include virtio.mak
 
 CONFIG_CADENCE=y
+
+CONFIG_PCI=y
+CONFIG_PCI_GENERIC=y
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e8ba4d192d..9bdeea38f2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -39,6 +39,8 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
 #include "exec/address-spaces.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-host/gpex.h"
 #include "elf.h"
 
 #include <libfdt.h>
@@ -55,6 +57,7 @@ static const struct MemmapEntry {
     [VIRT_UART0] =    { 0x10000000,      0x100 },
     [VIRT_VIRTIO] =   { 0x10001000,     0x1000 },
     [VIRT_DRAM] =     { 0x80000000,        0x0 },
+    [VIRT_PCIE] =     { 0x2000000000, 0x4000000 },
 };
 
 static uint64_t load_kernel(const char *kernel_filename)
@@ -233,6 +236,32 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         g_free(nodename);
     }
 
+    nodename = g_strdup_printf("/pci@%lx",
+        (long) memmap[VIRT_PCIE].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 0x3);
+    qemu_fdt_setprop_cells(fdt, nodename, "#interrupt-cells", 0x1);
+    qemu_fdt_setprop_cells(fdt, nodename, "#size-cells", 0x2);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+                            "pci-host-ecam-generic");
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
@@ -260,6 +289,31 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     return fdt;
 }
 
+
+static inline DeviceState *
+gpex_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
+                 hwaddr cfg_base, uint64_t cfg_size,
+                 hwaddr mmio_base, uint64_t mmio_size,
+                 qemu_irq irq, bool link_up)
+{
+    DeviceState *dev;
+    MemoryRegion *cfg, *mmio;
+
+    dev = qdev_create(NULL, TYPE_GPEX_HOST);
+
+    qdev_init_nofail(dev);
+
+    cfg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
+
+    mmio = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_add_subregion_overlap(sys_mem, 0, mmio, 0);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
+
+    return dev;
+}
+
 static void riscv_virt_board_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = virt_memmap;
@@ -382,6 +436,10 @@ static void riscv_virt_board_init(MachineState *machine)
             qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
     }
 
+    gpex_pcie_init(system_memory, 0, memmap[VIRT_PCIE].base,
+                           memmap[VIRT_PCIE].size, 0x40000000, 0x20000000,
+                           qdev_get_gpio_in(DEVICE(s->plic), PCIE_IRQ), true);
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
