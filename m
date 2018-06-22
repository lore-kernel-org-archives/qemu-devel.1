Received: from eggs.gnu.org ([2001:4830:134:3::10]:44565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRmM-0001eB-1e
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRmI-0005UL-S5
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:31:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRmI-0005SZ-HW
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:31:26 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 22 Jun 2018 12:30:19 -0700
Message-Id: <b6739ec82dae839bb8874ce527be53d4528f87d2.1529695276.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1529695276.git.alistair.francis@wdc.com>
References: <cover.1529695276.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 4/5] hw/riscv/virt: Connect a VGA PCIe device
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 default-configs/riscv32-softmmu.mak |  3 +++
 default-configs/riscv64-softmmu.mak |  3 +++
 hw/riscv/virt.c                     | 12 +++++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index b8cac7a49f..73a421d3de 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -7,3 +7,6 @@ CONFIG_CADENCE=y
 
 CONFIG_PCI=y
 CONFIG_PCI_XILINX=y
+
+CONFIG_VGA=y
+CONFIG_VGA_PCI=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index b8cac7a49f..73a421d3de 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -7,3 +7,6 @@ CONFIG_CADENCE=y
 
 CONFIG_PCI=y
 CONFIG_PCI_XILINX=y
+
+CONFIG_VGA=y
+CONFIG_VGA_PCI=y
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 7c1ed3aee5..11f6f96a47 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -328,6 +328,8 @@ static void riscv_virt_board_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+    PCIBus *pci_bus;
+    DeviceState *dev;
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
@@ -443,9 +445,12 @@ static void riscv_virt_board_init(MachineState *machine)
             qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
     }
 
-    xilinx_pcie_init(system_memory, 0, memmap[VIRT_PCIE].base,
-                     memmap[VIRT_PCIE].size, 0x40000000, 0x20000000,
-                     qdev_get_gpio_in(DEVICE(s->plic), PCIE_IRQ), true);
+    dev = xilinx_pcie_init(system_memory, 0, memmap[VIRT_PCIE].base,
+                           memmap[VIRT_PCIE].size, 0x40000000, 0x20000000,
+                           qdev_get_gpio_in(DEVICE(s->plic), PCIE_IRQ), true);
+    pci_bus = &PCI_BRIDGE(&XILINX_PCIE_HOST(dev)->root)->sec_bus;
+
+    pci_vga_init(pci_bus);
 
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
@@ -457,6 +462,7 @@ static void riscv_virt_board_machine_init(MachineClass *mc)
     mc->desc = "RISC-V VirtIO Board (Privileged ISA v1.10)";
     mc->init = riscv_virt_board_init;
     mc->max_cpus = 8; /* hardcoded limit in BBL */
+    mc->default_display = "std";
 }
 
 DEFINE_MACHINE("virt", riscv_virt_board_machine_init)
-- 
2.17.1
