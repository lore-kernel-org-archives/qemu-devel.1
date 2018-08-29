Received: from eggs.gnu.org ([2001:4830:134:3::10]:41063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4ir-0003mb-Cq
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4im-0004h2-Dh
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:57:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=7726cd878=Alistair.Francis@wdc.com>)
	id 1fv4im-0004ge-5n
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:57:36 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 29 Aug 2018 10:57:25 -0700
Message-Id: <8f2b50188d14e9cc43f5c9a7b34061ffc76c411f.1535565338.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1535565338.git.alistair.francis@wdc.com>
References: <cover.1535565338.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 7/7] hw/riscv/virt: Connect a VirtIO net
 PCIe device
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
 default-configs/riscv32-softmmu.mak |  1 +
 default-configs/riscv64-softmmu.mak |  1 +
 hw/riscv/virt.c                     | 20 +++++++++++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index 35e74bebe9..6e19fdc935 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -9,6 +9,7 @@ CONFIG_CADENCE=y
 CONFIG_PCI=y
 CONFIG_PCI_GENERIC=y
 CONFIG_PCI_XILINX=y
+CONFIG_VIRTIO_PCI=y
 
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index 35e74bebe9..6e19fdc935 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -9,6 +9,7 @@ CONFIG_CADENCE=y
 CONFIG_PCI=y
 CONFIG_PCI_GENERIC=y
 CONFIG_PCI_XILINX=y
+CONFIG_VIRTIO_PCI=y
 
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d360d66e42..faca8e3d42 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -36,6 +36,7 @@
 #include "hw/riscv/sifive_test.h"
 #include "hw/riscv/virt.h"
 #include "chardev/char.h"
+#include "net/net.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
 #include "exec/address-spaces.h"
@@ -322,6 +323,8 @@ static void riscv_virt_board_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+    DeviceState *dev;
+    PCIBus *pci_bus;
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
@@ -436,9 +439,20 @@ static void riscv_virt_board_init(MachineState *machine)
             qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
     }
 
-    gpex_pcie_init(system_memory, 0, memmap[VIRT_PCIE].base,
-                   memmap[VIRT_PCIE].size, 0x40000000, 0x20000000,
-                   qdev_get_gpio_in(DEVICE(s->plic), PCIE_IRQ), true);
+    dev = gpex_pcie_init(system_memory, 0, memmap[VIRT_PCIE].base,
+                         memmap[VIRT_PCIE].size, 0x40000000, 0x20000000,
+                         qdev_get_gpio_in(DEVICE(s->plic), PCIE_IRQ), true);
+    pci_bus = PCI_HOST_BRIDGE(dev)->bus;
+
+    for (i = 0; i < nb_nics; i++) {
+        NICInfo *nd = &nd_table[i];
+
+        if (!nd->model) {
+            nd->model = g_strdup("virtio");
+        }
+
+        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
+    }
 
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
-- 
2.17.1
