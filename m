Received: from eggs.gnu.org ([2001:4830:134:3::10]:41034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4ii-0003Be-AT
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4id-0004dS-A5
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:57:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64917)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4ic-0004ch-89
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:57:26 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 29 Aug 2018 10:57:13 -0700
Message-Id: <59f754de00349434c7335dc80a123f39549056ac.1535565338.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1535565338.git.alistair.francis@wdc.com>
References: <cover.1535565338.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 6/7] hw/riscv/sifive_u: Connect the Xilinx
 PCIe
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

Connect the Xilinx PCIe device based on the information in the device
tree stored in the ROM of the HiFish Unleashed board.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 default-configs/riscv32-softmmu.mak |  1 +
 default-configs/riscv64-softmmu.mak |  1 +
 hw/riscv/sifive_u.c                 | 64 +++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u.h         |  4 +-
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index fcefa68f1e..35e74bebe9 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -8,6 +8,7 @@ CONFIG_CADENCE=y
 
 CONFIG_PCI=y
 CONFIG_PCI_GENERIC=y
+CONFIG_PCI_XILINX=y
 
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index fcefa68f1e..35e74bebe9 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -8,6 +8,7 @@ CONFIG_CADENCE=y
 
 CONFIG_PCI=y
 CONFIG_PCI_GENERIC=y
+CONFIG_PCI_XILINX=y
 
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 59ae1ce24a..9a8dd8eade 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -45,6 +45,8 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
 #include "exec/address-spaces.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-host/xilinx-pcie.h"
 #include "elf.h"
 
 #include <libfdt.h>
@@ -61,6 +63,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
+    [SIFIVE_U_PCIE] =     { 0x2000000000, 0x4000000 },
 };
 
 #define GEM_REVISION        0x10070109
@@ -218,6 +221,32 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg", 0x0);
     g_free(nodename);
 
+    nodename = g_strdup_printf("/pci@%lx",
+        (long) memmap[SIFIVE_U_PCIE].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 0x3);
+    qemu_fdt_setprop_cells(fdt, nodename, "#interrupt-cells", 0x1);
+    qemu_fdt_setprop_cells(fdt, nodename, "#size-cells", 0x2);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+                            "xlnx,axi-pcie-host-1.00.a");
+    qemu_fdt_setprop_string(fdt, nodename, "device_type", "pci");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg", 0x20, 0x0, 0x0,
+                           memmap[SIFIVE_U_PCIE].size);
+    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
+    qemu_fdt_setprop_cells(fdt, nodename, "ranges", 0x2000000, 0x0,
+                           0x40000000, 0x0, 0x40000000, 0x0, 0x20000000);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_PCIE_IRQ);
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/pci@%lx/interrupt-controller",
+            (long) memmap[SIFIVE_U_PCIE].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 0x00);
+    qemu_fdt_setprop_cells(fdt, nodename, "#interrupt-cells", 0x1);
+    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
+    g_free(nodename);
+
     nodename = g_strdup_printf("/soc/uart@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
@@ -234,6 +263,37 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 }
 
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
 static void riscv_sifive_u_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_u_memmap;
@@ -373,6 +433,10 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
                        plic_gpios[SIFIVE_U_GEM_IRQ]);
+
+    xilinx_pcie_init(system_memory, 0, memmap[SIFIVE_U_PCIE].base,
+                     memmap[SIFIVE_U_PCIE].size, 0x40000000, 0x20000000,
+                     qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_PCIE_IRQ), true);
 }
 
 static void riscv_sifive_u_machine_init(MachineClass *mc)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index e8b4d9ffa3..e7292ea83b 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -53,12 +53,14 @@ enum {
     SIFIVE_U_UART0,
     SIFIVE_U_UART1,
     SIFIVE_U_DRAM,
-    SIFIVE_U_GEM
+    SIFIVE_U_GEM,
+    SIFIVE_U_PCIE
 };
 
 enum {
     SIFIVE_U_UART0_IRQ = 3,
     SIFIVE_U_UART1_IRQ = 4,
+    SIFIVE_U_PCIE_IRQ = 0x20,
     SIFIVE_U_GEM_IRQ = 0x35
 };
 
-- 
2.17.1
