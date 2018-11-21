Received: from eggs.gnu.org ([2001:4830:134:3::10]:58623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856724ab1=Alistair.Francis@wdc.com>)
	id 1gPVuG-0005Tj-AJ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856724ab1=Alistair.Francis@wdc.com>)
	id 1gPVuE-0000Um-A8
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:03:16 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 21 Nov 2018 17:03:03 +0000
Message-ID: <44e7883bd17c6867f0ac488bdab6c880b2420a9b.1542819633.git.alistair.francis@wdc.com>
References: <cover.1542819633.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1542819633.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH for-3.2 v7 6/6] hw/riscv/virt: Connect a VirtIO
 net PCIe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "abologna@redhat.com" <abologna@redhat.com>, "logang@deltatee.com" <logang@deltatee.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 default-configs/riscv32-softmmu.mak |  1 +
 default-configs/riscv64-softmmu.mak |  1 +
 hw/riscv/virt.c                     | 16 +++++++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

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
index e7f0716fb6..de6924e1c7 100644
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
@@ -392,6 +393,8 @@ static void riscv_virt_board_init(MachineState *machine=
)
     MemoryRegion *system_memory =3D get_system_memory();
     MemoryRegion *main_mem =3D g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
+    DeviceState *dev;
+    PCIBus *pci_bus;
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
@@ -506,13 +509,24 @@ static void riscv_virt_board_init(MachineState *machi=
ne)
             qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
     }
=20
-    gpex_pcie_init(system_memory,
+    dev =3D gpex_pcie_init(system_memory,
                          memmap[VIRT_PCIE_ECAM].base,
                          memmap[VIRT_PCIE_ECAM].size,
                          memmap[VIRT_PCIE_MMIO].base,
                          memmap[VIRT_PCIE_MMIO].size,
                          memmap[VIRT_PCIE_PIO].base,
                          DEVICE(s->plic), true);
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
2.19.1
