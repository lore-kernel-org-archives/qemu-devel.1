Received: from eggs.gnu.org ([2001:4830:134:3::10]:35212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8344f8b50=Alistair.Francis@wdc.com>)
	id 1gHcLa-0001Ax-O0
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8344f8b50=Alistair.Francis@wdc.com>)
	id 1gHcLV-0003Rq-UB
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:18:50 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Oct 2018 22:18:18 +0000
Message-ID: <27888cbc7494b9e496716b3b055f0d72c93e42e5.1540937826.git.alistair.francis@wdc.com>
References: <cover.1540937826.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1540937826.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v6 4/5] hw/riscv/sifive_u: Connect the Xilinx
 PCIe
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

Connect the Xilinx PCIe device based on the information in the device
tree stored in the ROM of the HiFish Unleashed board.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c         | 64 +++++++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u.h |  4 ++-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ef07df2442..0c51c61082 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -45,6 +45,8 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
 #include "exec/address-spaces.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-host/xilinx-pcie.h"
 #include "elf.h"
=20
 #include <libfdt.h>
@@ -61,6 +63,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_UART1] =3D    { 0x10023000,     0x1000 },
     [SIFIVE_U_DRAM] =3D     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =3D      { 0x100900FC,     0x2000 },
+    [SIFIVE_U_PCIE] =3D     { 0x2000000000, 0x4000000 },
 };
=20
 #define GEM_REVISION        0x10070109
@@ -218,6 +221,32 @@ static void create_fdt(SiFiveUState *s, const struct M=
emmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg", 0x0);
     g_free(nodename);
=20
+    nodename =3D g_strdup_printf("/pci@%lx",
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
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle=
);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_PCIE_IRQ)=
;
+    g_free(nodename);
+
+    nodename =3D g_strdup_printf("/pci@%lx/interrupt-controller",
+            (long) memmap[SIFIVE_U_PCIE].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 0x00);
+    qemu_fdt_setprop_cells(fdt, nodename, "#interrupt-cells", 0x1);
+    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
+    g_free(nodename);
+
     nodename =3D g_strdup_printf("/soc/uart@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
@@ -236,6 +265,37 @@ static void create_fdt(SiFiveUState *s, const struct M=
emmapEntry *memmap,
     g_free(nodename);
 }
=20
+static inline DeviceState *
+xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
+                 hwaddr cfg_base, uint64_t cfg_size,
+                 hwaddr mmio_base, uint64_t mmio_size,
+                 qemu_irq irq, bool link_up)
+{
+    DeviceState *dev;
+    MemoryRegion *cfg, *mmio;
+
+    dev =3D qdev_create(NULL, TYPE_XILINX_PCIE_HOST);
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
+    cfg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
+
+    mmio =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_add_subregion_overlap(sys_mem, 0, mmio, 0);
+
+    qdev_connect_gpio_out_named(dev, "interrupt_out", 0, irq);
+
+    return dev;
+}
+
 static void riscv_sifive_u_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap =3D sifive_u_memmap;
@@ -375,6 +435,10 @@ static void riscv_sifive_u_soc_realize(DeviceState *de=
v, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base)=
;
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
                        plic_gpios[SIFIVE_U_GEM_IRQ]);
+
+    xilinx_pcie_init(system_memory, 0, memmap[SIFIVE_U_PCIE].base,
+                     memmap[SIFIVE_U_PCIE].size, 0x40000000, 0x20000000,
+                     qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_PCIE_IRQ),=
 true);
 }
=20
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
=20
 enum {
     SIFIVE_U_UART0_IRQ =3D 3,
     SIFIVE_U_UART1_IRQ =3D 4,
+    SIFIVE_U_PCIE_IRQ =3D 0x20,
     SIFIVE_U_GEM_IRQ =3D 0x35
 };
=20
--=20
2.19.1
