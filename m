Received: from eggs.gnu.org ([2001:4830:134:3::10]:46061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qv-0008Bs-0s
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qu-0005wA-3X
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1qt-0005vQ-TI
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:40 -0500
Date: Thu, 21 Dec 2017 16:29:33 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-18-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/25] hw/pci-host/xilinx: QOM'ify the AXI-PCIe
 host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel@redhat.com>, Paul Burton <paul.burton@mips.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci-host/xilinx-pcie.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index d2f88d1..53b561f 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci-host/xilinx-pcie.h"
=20
@@ -267,24 +268,22 @@ static void xilinx_pcie_root_config_write(PCIDevice=
 *d, uint32_t address,
     }
 }
=20
-static int xilinx_pcie_root_init(PCIDevice *dev)
+static void xilinx_pcie_root_realize(PCIDevice *pci_dev, Error **errp)
 {
-    BusState *bus =3D qdev_get_parent_bus(DEVICE(dev));
+    BusState *bus =3D qdev_get_parent_bus(DEVICE(pci_dev));
     XilinxPCIEHost *s =3D XILINX_PCIE_HOST(bus->parent);
=20
-    pci_set_word(dev->config + PCI_COMMAND,
+    pci_set_word(pci_dev->config + PCI_COMMAND,
                  PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
-    pci_set_word(dev->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
-    pci_set_word(dev->config + PCI_MEMORY_LIMIT,
+    pci_set_word(pci_dev->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
+    pci_set_word(pci_dev->config + PCI_MEMORY_LIMIT,
                  ((s->mmio_base + s->mmio_size - 1) >> 16) & 0xfff0);
=20
-    pci_bridge_initfn(dev, TYPE_PCI_BUS);
+    pci_bridge_initfn(pci_dev, TYPE_PCI_BUS);
=20
-    if (pcie_endpoint_cap_v1_init(dev, 0x80) < 0) {
-        hw_error("Failed to initialize PCIe capability");
+    if (pcie_endpoint_cap_v1_init(pci_dev, 0x80) < 0) {
+        error_setg(errp, "Failed to initialize PCIe capability");
     }
-
-    return 0;
 }
=20
 static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
@@ -300,7 +299,7 @@ static void xilinx_pcie_root_class_init(ObjectClass *=
klass, void *data)
     k->class_id =3D PCI_CLASS_BRIDGE_HOST;
     k->is_express =3D true;
     k->is_bridge =3D true;
-    k->init =3D xilinx_pcie_root_init;
+    k->realize =3D xilinx_pcie_root_realize;
     k->exit =3D pci_bridge_exitfn;
     dc->reset =3D pci_bridge_reset;
     k->config_read =3D xilinx_pcie_root_config_read;
--=20
MST
