Received: from eggs.gnu.org ([2001:4830:134:3::10]:51869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKtM-00010m-W5
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKtJ-00012q-SU
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:12:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29373)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKtJ-00012J-Hq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:12:53 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 16 Aug 2018 09:12:41 -0700
Message-Id: <5c23e0fc0eb0009a9339392bb7730a0b7cc97e31.1534435831.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1534435831.git.alistair.francis@wdc.com>
References: <cover.1534435831.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 6/6] hw/riscv/virt: Connect a VirtIO net
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
 hw/riscv/virt.c                     | 11 +++++++++++
 3 files changed, 13 insertions(+)

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
index 02652e44ee..28bf35ea56 100644
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
@@ -445,6 +446,16 @@ static void riscv_virt_board_init(MachineState *machine)
 
     pci_vga_init(pci_bus);
 
+    for (i = 0; i < nb_nics; i++) {
+        NICInfo *nd = &nd_table[i];
+
+        if (!nd->model) {
+            nd->model = g_strdup("virtio");
+        }
+
+        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
+    }
+
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
-- 
2.17.1
