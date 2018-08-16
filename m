Received: from eggs.gnu.org ([2001:4830:134:3::10]:51800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKt1-0000iT-H5
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKsy-0000oH-DT
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:12:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKsv-0000mK-Er
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:12:30 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 16 Aug 2018 09:12:17 -0700
Message-Id: <b54c28929f201751c4f41e5cb7170e5b9a774432.1534435831.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1534435831.git.alistair.francis@wdc.com>
References: <cover.1534435831.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 4/6] hw/riscv/virt: Connect a VGA PCIe device
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
index 9bdeea38f2..02652e44ee 100644
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
@@ -436,9 +438,12 @@ static void riscv_virt_board_init(MachineState *machine)
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
