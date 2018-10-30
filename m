Received: from eggs.gnu.org ([2001:4830:134:3::10]:34970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8344f8b50=Alistair.Francis@wdc.com>)
	id 1gHcKx-0000oX-Uk
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8344f8b50=Alistair.Francis@wdc.com>)
	id 1gHcKs-0002mc-68
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:18:09 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Oct 2018 22:17:59 +0000
Message-ID: <546aa18b75a04a281e82706ea41ee9a4a9f3e2bc.1540937826.git.alistair.francis@wdc.com>
References: <cover.1540937826.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1540937826.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v6 2/5] hw/riscv/virt: Connect the gpex PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

Connect the gpex PCIe device based on the device tree included in the
HiFive Unleashed ROM.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 default-configs/riscv32-softmmu.mak |   6 +-
 default-configs/riscv64-softmmu.mak |   6 +-
 hw/riscv/virt.c                     | 111 ++++++++++++++++++++++++++++
 include/hw/riscv/virt.h             |   8 +-
 4 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-=
softmmu.mak
index 7937c69e22..3e3d195f37 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -1,7 +1,11 @@
 # Default configuration for riscv-softmmu
=20
+include pci.mak
+
 CONFIG_SERIAL=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
-include virtio.mak
=20
 CONFIG_CADENCE=3Dy
+
+CONFIG_PCI_GENERIC=3Dy
+CONFIG_PCI_XILINX=3Dy
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-=
softmmu.mak
index 7937c69e22..3e3d195f37 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -1,7 +1,11 @@
 # Default configuration for riscv-softmmu
=20
+include pci.mak
+
 CONFIG_SERIAL=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
-include virtio.mak
=20
 CONFIG_CADENCE=3Dy
+
+CONFIG_PCI_GENERIC=3Dy
+CONFIG_PCI_XILINX=3Dy
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4a137a503c..2fbe58ba4b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -39,6 +39,8 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
 #include "exec/address-spaces.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-host/gpex.h"
 #include "elf.h"
=20
 #include <libfdt.h>
@@ -55,6 +57,10 @@ static const struct MemmapEntry {
     [VIRT_UART0] =3D    { 0x10000000,      0x100 },
     [VIRT_VIRTIO] =3D   { 0x10001000,     0x1000 },
     [VIRT_DRAM] =3D     { 0x80000000,        0x0 },
+    [VIRT_PCIE_MMIO] =3D { 0x2000000000, 0x4000000 },
+    [VIRT_PCIE_PIO] =3D { 0x2010000, 0x40000000 },
+    [VIRT_PCIE_ECAM] =3D { 0x40000000, 0x20000000 },
+
 };
=20
 static uint64_t load_kernel(const char *kernel_filename)
@@ -98,6 +104,37 @@ static hwaddr load_initrd(const char *filename, uint64_=
t mem_size,
     return *start + size;
 }
=20
+#define INTERREUPT_MAP_WIDTH 7
+
+static void create_pcie_irq_map(void *fdt, char *nodename,
+                                uint32_t plic_phandle)
+{
+    int pin;
+    uint32_t full_irq_map[GPEX_NUM_IRQS * INTERREUPT_MAP_WIDTH] =3D { 0 };
+    uint32_t *irq_map =3D full_irq_map;
+
+        for (pin =3D 0; pin < GPEX_NUM_IRQS; pin++) {
+            int irq_nr =3D PCIE_IRQ + (pin % PCI_NUM_PINS);
+            int i;
+
+            uint32_t map[] =3D {
+                0, 0, 0,
+                pin + 1, plic_phandle, 0, irq_nr};
+
+            /* Convert map to big endian */
+            for (i =3D 0; i < INTERREUPT_MAP_WIDTH; i++) {
+                irq_map[i] =3D cpu_to_be32(map[i]);
+            }
+            irq_map +=3D INTERREUPT_MAP_WIDTH;
+        }
+
+    qemu_fdt_setprop(fdt, nodename, "interrupt-map",
+                     full_irq_map, sizeof(full_irq_map));
+
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
+                           0, 0, 0, 0x7);
+}
+
 static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memma=
p,
     uint64_t mem_size, const char *cmdline)
 {
@@ -233,6 +270,31 @@ static void *create_fdt(RISCVVirtState *s, const struc=
t MemmapEntry *memmap,
         g_free(nodename);
     }
=20
+    nodename =3D g_strdup_printf("/pci@%lx",
+        (long) memmap[VIRT_PCIE_MMIO].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 0x3);
+    qemu_fdt_setprop_cells(fdt, nodename, "#interrupt-cells", 0x1);
+    qemu_fdt_setprop_cells(fdt, nodename, "#size-cells", 0x2);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+                            "pci-host-ecam-generic");
+    qemu_fdt_setprop_string(fdt, nodename, "device_type", "pci");
+    qemu_fdt_setprop_cell(fdt, nodename, "linux,pci-domain", 0);
+    qemu_fdt_setprop_cells(fdt, nodename, "bus-range", 0,
+                           memmap[VIRT_PCIE_ECAM].base /
+                               PCIE_MMCFG_SIZE_MIN - 1);
+    qemu_fdt_setprop(fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg", 0x20, 0,
+                           0, memmap[VIRT_PCIE_ECAM].size);
+    qemu_fdt_setprop_cells(fdt, nodename, "ranges",
+                           memmap[VIRT_PCIE_PIO].base,
+                               0, memmap[VIRT_PCIE_PIO].size,
+                           0, memmap[VIRT_PCIE_MMIO].base,
+                               0, memmap[VIRT_PCIE_MMIO].size);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle=
);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupts", PCIE_IRQ);
+    create_pcie_irq_map(fdt, nodename, plic_phandle);
+
     nodename =3D g_strdup_printf("/test@%lx",
         (long)memmap[VIRT_TEST].base);
     qemu_fdt_add_subnode(fdt, nodename);
@@ -262,6 +324,47 @@ static void *create_fdt(RISCVVirtState *s, const struc=
t MemmapEntry *memmap,
     return fdt;
 }
=20
+
+static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
+                                          hwaddr ecam_base, hwaddr ecam_si=
ze,
+                                          hwaddr mmio_base, hwaddr mmio_si=
ze,
+                                          hwaddr pio_base,
+                                          DeviceState *plic, bool link_up)
+{
+    DeviceState *dev;
+    MemoryRegion *ecam_alias, *ecam_reg;
+    MemoryRegion *mmio_alias, *mmio_reg;
+    qemu_irq irq;
+    int i;
+
+    dev =3D qdev_create(NULL, TYPE_GPEX_HOST);
+
+    qdev_init_nofail(dev);
+
+    ecam_alias =3D g_new0(MemoryRegion, 1);
+    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
+                             ecam_reg, 0, ecam_size);
+    memory_region_add_subregion(get_system_memory(), ecam_base, ecam_alias=
);
+
+    mmio_alias =3D g_new0(MemoryRegion, 1);
+    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
+                             mmio_reg, mmio_base, mmio_size);
+    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_alias=
);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
+
+    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
+        irq =3D qdev_get_gpio_in(plic, PCIE_IRQ + i);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
+        gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ + i);
+    }
+
+    return dev;
+}
+
 static void riscv_virt_board_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap =3D virt_memmap;
@@ -384,6 +487,14 @@ static void riscv_virt_board_init(MachineState *machin=
e)
             qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
     }
=20
+    gpex_pcie_init(system_memory,
+                         memmap[VIRT_PCIE_MMIO].base,
+                         memmap[VIRT_PCIE_MMIO].size,
+                         memmap[VIRT_PCIE_ECAM].base,
+                         memmap[VIRT_PCIE_ECAM].size,
+                         memmap[VIRT_PCIE_PIO].base,
+                         DEVICE(s->plic), true);
+
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 7cb2742070..dd4feddb42 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -38,14 +38,18 @@ enum {
     VIRT_PLIC,
     VIRT_UART0,
     VIRT_VIRTIO,
-    VIRT_DRAM
+    VIRT_DRAM,
+    VIRT_PCIE_MMIO,
+    VIRT_PCIE_PIO,
+    VIRT_PCIE_ECAM
 };
=20
 enum {
     UART0_IRQ =3D 10,
     VIRTIO_IRQ =3D 1, /* 1 to 8 */
     VIRTIO_COUNT =3D 8,
-    VIRTIO_NDEV =3D 0x35
+    PCIE_IRQ =3D 0x20, /* 32 to 35 */
+    VIRTIO_NDEV =3D 0x36
 };
=20
 enum {
--=20
2.19.1
