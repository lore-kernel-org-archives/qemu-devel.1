Received: from eggs.gnu.org ([2001:4830:134:3::10]:45593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hn-0001NW-Np
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hm-0008GJ-NO
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:11 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:28 -0500
Message-Id: <20180619014319.28272-3-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 002/113] pci-bridge/i82801b11: clear bridge
 registers on platform reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Laszlo Ersek <lersek@redhat.com>

The "i82801b11-bridge" device model is a descendant of "base-pci-bridge"
(TYPE_PCI_BRIDGE). However, unlike other similar devices, such as

- pci-bridge,
- pcie-pci-bridge,
- PCIE Root Port,
- xio3130 switch upstream and downstream ports,
- dec-21154-p2p-bridge,
- pbm-bridge,
- xilinx-pcie-root,

"i82801b11-bridge" does not clear the bridge specific registers at
platform reset.

This is a problem because devices on "i82801b11-bridge" continue to
respond to config space cycles after platform reset, when addressed with
the bus number that was previously programmed into the secondary bus
number register of "i82801b11-bridge". This error breaks OVMF's search for
extra (PXB) root buses, for example.

The device class reset method for "i82801b11-bridge" is currently NULL;
set it directly to pci_bridge_reset(), like the last three bridge models
in the above listing do.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-stable@nongnu.org
Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1541839
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit ed247f40db84c8bd4bb7d10948702cd47cc4d5ae)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/pci-bridge/i82801b11.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index cb522bf30c..ebf7f5f0e8 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -98,6 +98,7 @@ static void i82801b11_bridge_class_init(ObjectClass *klass, void *data)
     k->realize = i82801b11_bridge_realize;
     k->config_write = pci_bridge_write_config;
     dc->vmsd = &i82801b11_bridge_dev_vmstate;
+    dc->reset = pci_bridge_reset;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
-- 
2.11.0
