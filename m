Received: from eggs.gnu.org ([2001:4830:134:3::10]:41593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgWQ-0004ta-Df
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgWN-0008Ov-7i
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:28:50 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:6522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgWM-0008Ni-SV
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:28:47 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Mon,  9 Jul 2018 17:28:36 -0700
Message-Id: <b36a916b0e4532c5dfc93541ceb3292b9c92bdd4.1531182400.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1531182400.git.alistair.francis@wdc.com>
References: <cover.1531182400.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/6] hw/riscv/virt: Connect a VGA PCIe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, alistair23@gmail.com, mjc@sifive.com

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 default-configs/riscv32-softmmu.mak | 3 +++
 default-configs/riscv64-softmmu.mak | 3 +++
 hw/riscv/virt.c                     | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index 2c943e2669..fcefa68f1e 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -8,3 +8,6 @@ CONFIG_CADENCE=y
 
 CONFIG_PCI=y
 CONFIG_PCI_GENERIC=y
+
+CONFIG_VGA=y
+CONFIG_VGA_PCI=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index 2c943e2669..fcefa68f1e 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -8,3 +8,6 @@ CONFIG_CADENCE=y
 
 CONFIG_PCI=y
 CONFIG_PCI_GENERIC=y
+
+CONFIG_VGA=y
+CONFIG_VGA_PCI=y
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0c3800fd64..f973c43c70 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -322,6 +322,8 @@ static void riscv_virt_board_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+    PCIBus *pci_bus;
+    DeviceState *dev;
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
@@ -437,9 +439,12 @@ static void riscv_virt_board_init(MachineState *machine)
             qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
     }
 
-    gpex_pcie_init(system_memory, 0, memmap[VIRT_PCIE].base,
+    dev = gpex_pcie_init(system_memory, 0, memmap[VIRT_PCIE].base,
                            memmap[VIRT_PCIE].size, 0x40000000, 0x20000000,
                            qdev_get_gpio_in(DEVICE(s->plic), PCIE_IRQ), true);
+    pci_bus = PCI_HOST_BRIDGE(dev)->bus;
+
+    pci_vga_init(pci_bus);
 
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
-- 
2.17.1
