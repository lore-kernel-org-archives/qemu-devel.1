Received: from eggs.gnu.org ([2001:4830:134:3::10]:34606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQx78-0005iO-SM
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQx6L-0000uB-F7
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:13:58 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:44829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQx6I-0000rs-JJ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:13:06 -0500
Received: by mail-qt0-x244.google.com with SMTP id m59so20313304qte.11
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 07:13:06 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 18 Dec 2017 12:12:43 -0300
Message-Id: <20171218151244.9975-4-f4bug@amsat.org>
In-Reply-To: <20171218151244.9975-1-f4bug@amsat.org>
References: <20171218151244.9975-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/4] hw/pci-host/xilinx: QOM'ify the
 AXI-PCIe host bridge
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
v2: use 'pci_dev' variable, replaced hw_error() -> error_setg()

 hw/pci-host/xilinx-pcie.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 7659253090..681fdf486a 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -267,24 +267,22 @@ static void xilinx_pcie_root_config_write(PCIDevice *d, uint32_t address,
     }
 }
 
-static int xilinx_pcie_root_init(PCIDevice *dev)
+static void xilinx_pcie_root_realize(PCIDevice *pci_dev, Error **errp)
 {
-    BusState *bus = qdev_get_parent_bus(DEVICE(dev));
+    BusState *bus = qdev_get_parent_bus(DEVICE(pci_dev));
     XilinxPCIEHost *s = XILINX_PCIE_HOST(bus->parent);
 
-    pci_set_word(dev->config + PCI_COMMAND,
+    pci_set_word(pci_dev->config + PCI_COMMAND,
                  PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
-    pci_set_word(dev->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
-    pci_set_word(dev->config + PCI_MEMORY_LIMIT,
+    pci_set_word(pci_dev->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
+    pci_set_word(pci_dev->config + PCI_MEMORY_LIMIT,
                  ((s->mmio_base + s->mmio_size - 1) >> 16) & 0xfff0);
 
-    pci_bridge_initfn(dev, TYPE_PCI_BUS);
+    pci_bridge_initfn(pci_dev, TYPE_PCI_BUS);
 
-    if (pcie_endpoint_cap_v1_init(dev, 0x80) < 0) {
-        hw_error("Failed to initialize PCIe capability");
+    if (pcie_endpoint_cap_v1_init(pci_dev, 0x80) < 0) {
+        error_setg(errp, "Failed to initialize PCIe capability");
     }
-
-    return 0;
 }
 
 static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
@@ -300,7 +298,7 @@ static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
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
