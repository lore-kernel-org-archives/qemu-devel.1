Received: from eggs.gnu.org ([2001:4830:134:3::10]:39659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhcn-0006gx-C8
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhci-0006c1-13
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:32:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:65506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhch-0006bQ-OV
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:31:55 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 11 Oct 2018 20:31:52 +0000
Message-ID: <20181011203115.18666-6-alistair.francis@wdc.com>
References: <20181011203115.18666-1-alistair.francis@wdc.com>
In-Reply-To: <20181011203115.18666-1-alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PULL 05/10] hw/riscv/virt: Connect a VirtIO net PCIe
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 default-configs/riscv32-softmmu.mak |  1 +
 default-configs/riscv64-softmmu.mak |  1 +
 hw/riscv/virt.c                     | 20 +++++++++++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-=
softmmu.mak
index 05fae82f1b..bb3dd34606 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -9,6 +9,7 @@ CONFIG_CADENCE=3Dy
=20
 CONFIG_PCI_GENERIC=3Dy
 CONFIG_PCI_XILINX=3Dy
+CONFIG_VIRTIO_PCI=3Dy
=20
 CONFIG_VGA=3Dy
 CONFIG_VGA_PCI=3Dy
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-=
softmmu.mak
index 05fae82f1b..bb3dd34606 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -9,6 +9,7 @@ CONFIG_CADENCE=3Dy
=20
 CONFIG_PCI_GENERIC=3Dy
 CONFIG_PCI_XILINX=3Dy
+CONFIG_VIRTIO_PCI=3Dy
=20
 CONFIG_VGA=3Dy
 CONFIG_VGA_PCI=3Dy
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 62a953aa2b..6d91810bcf 100644
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
@@ -322,6 +323,8 @@ static void riscv_virt_board_init(MachineState *machine=
)
     MemoryRegion *system_memory =3D get_system_memory();
     MemoryRegion *main_mem =3D g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
+    DeviceState *dev;
+    PCIBus *pci_bus;
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
@@ -436,9 +439,20 @@ static void riscv_virt_board_init(MachineState *machin=
e)
             qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
     }
=20
-    gpex_pcie_init(system_memory, 0, memmap[VIRT_PCIE].base,
-                   memmap[VIRT_PCIE].size, 0x40000000, 0x20000000,
-                   qdev_get_gpio_in(DEVICE(s->plic), PCIE_IRQ), true);
+    dev =3D gpex_pcie_init(system_memory, 0, memmap[VIRT_PCIE].base,
+                         memmap[VIRT_PCIE].size, 0x40000000, 0x20000000,
+                         qdev_get_gpio_in(DEVICE(s->plic), PCIE_IRQ), true=
);
+    pci_bus =3D PCI_HOST_BRIDGE(dev)->bus;
+
+    for (i =3D 0; i < nb_nics; i++) {
+        NICInfo *nd =3D &nd_table[i];
+
+        if (!nd->model) {
+            nd->model =3D g_strdup("virtio");
+        }
+
+        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
+    }
=20
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
--=20
2.17.1
