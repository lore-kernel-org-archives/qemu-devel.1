Received: from eggs.gnu.org ([2001:4830:134:3::10]:59815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQfsO-0001Kd-GN
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQfsN-0005fV-Iu
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:49:36 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQfsN-0005f8-Ec
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:49:35 -0500
Received: by mail-qk0-x243.google.com with SMTP id p13so93458qke.4
	for <qemu-devel@nongnu.org>; Sun, 17 Dec 2017 12:49:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 17 Dec 2017 17:49:11 -0300
Message-Id: <20171217204912.12420-4-f4bug@amsat.org>
In-Reply-To: <20171217204912.12420-1-f4bug@amsat.org>
References: <20171217204912.12420-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/4] hw/pci-host/xilinx: QOM'ify the AXI-PCIe
 host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, James Hogan <jhogan@kernel.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/xilinx-pcie.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 7659253090..756db39fd5 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -267,24 +267,23 @@ static void xilinx_pcie_root_config_write(PCIDevice *d, uint32_t address,
     }
 }
 
-static int xilinx_pcie_root_init(PCIDevice *dev)
+static void xilinx_pcie_root_realize(PCIDevice *pci, Error **errp)
 {
-    BusState *bus = qdev_get_parent_bus(DEVICE(dev));
+    DeviceState *dev = DEVICE(pci);
+    BusState *bus = qdev_get_parent_bus(dev);
     XilinxPCIEHost *s = XILINX_PCIE_HOST(bus->parent);
 
-    pci_set_word(dev->config + PCI_COMMAND,
+    pci_set_word(pci->config + PCI_COMMAND,
                  PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
-    pci_set_word(dev->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
-    pci_set_word(dev->config + PCI_MEMORY_LIMIT,
+    pci_set_word(pci->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
+    pci_set_word(pci->config + PCI_MEMORY_LIMIT,
                  ((s->mmio_base + s->mmio_size - 1) >> 16) & 0xfff0);
 
-    pci_bridge_initfn(dev, TYPE_PCI_BUS);
+    pci_bridge_initfn(pci, TYPE_PCI_BUS);
 
-    if (pcie_endpoint_cap_v1_init(dev, 0x80) < 0) {
+    if (pcie_endpoint_cap_v1_init(pci, 0x80) < 0) {
         hw_error("Failed to initialize PCIe capability");
     }
-
-    return 0;
 }
 
 static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
@@ -300,7 +299,7 @@ static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_BRIDGE_HOST;
     k->is_express = true;
     k->is_bridge = true;
-    k->init = xilinx_pcie_root_init;
+    k->realize = xilinx_pcie_root_realize;
     k->exit = pci_bridge_exitfn;
     dc->reset = pci_bridge_reset;
     k->config_read = xilinx_pcie_root_config_read;
-- 
2.15.1
