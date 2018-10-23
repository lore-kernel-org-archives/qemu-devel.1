Received: from eggs.gnu.org ([2001:4830:134:3::10]:51764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JR-0003Me-9I
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JF-0008Fj-Rs
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:12 -0400
Received: from [185.30.24.106] (port=13492
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JE-0008B7-Dv
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:01 -0400
Date: Tue, 23 Oct 2018 19:41:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-22-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/28] hw/pci-bridge/xio3130: Remove unused
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Introduced in 48ebf2f90f8 and faf1e708d5b, these functions
were never used. Remove them.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/xio3130_downstream.h | 11 -----------
 hw/pci-bridge/xio3130_upstream.h   | 10 ----------
 hw/pci-bridge/xio3130_downstream.c | 28 +---------------------------
 hw/pci-bridge/xio3130_upstream.c   | 24 +-----------------------
 4 files changed, 2 insertions(+), 71 deletions(-)
 delete mode 100644 hw/pci-bridge/xio3130_downstream.h
 delete mode 100644 hw/pci-bridge/xio3130_upstream.h

diff --git a/hw/pci-bridge/xio3130_downstream.h b/hw/pci-bridge/xio3130_d=
ownstream.h
deleted file mode 100644
index 8426d9ffa6..0000000000
--- a/hw/pci-bridge/xio3130_downstream.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef QEMU_XIO3130_DOWNSTREAM_H
-#define QEMU_XIO3130_DOWNSTREAM_H
-
-#include "hw/pci/pcie_port.h"
-
-PCIESlot *xio3130_downstream_init(PCIBus *bus, int devfn, bool multifunc=
tion,
-                                  const char *bus_name, pci_map_irq_fn m=
ap_irq,
-                                  uint8_t port, uint8_t chassis,
-                                  uint16_t slot);
-
-#endif /* QEMU_XIO3130_DOWNSTREAM_H */
diff --git a/hw/pci-bridge/xio3130_upstream.h b/hw/pci-bridge/xio3130_ups=
tream.h
deleted file mode 100644
index d0ab7577e2..0000000000
--- a/hw/pci-bridge/xio3130_upstream.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef QEMU_XIO3130_UPSTREAM_H
-#define QEMU_XIO3130_UPSTREAM_H
-
-#include "hw/pci/pcie_port.h"
-
-PCIEPort *xio3130_upstream_init(PCIBus *bus, int devfn, bool multifuncti=
on,
-                                const char *bus_name, pci_map_irq_fn map=
_irq,
-                                uint8_t port);
-
-#endif /* QEMU_XIO3130_UPSTREAM_H */
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_d=
ownstream.c
index b202657954..467bbabe4c 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -23,7 +23,7 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
-#include "xio3130_downstream.h"
+#include "hw/pci/pcie_port.h"
 #include "qapi/error.h"
=20
 #define PCI_DEVICE_ID_TI_XIO3130D       0x8233  /* downstream port */
@@ -127,32 +127,6 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
=20
-PCIESlot *xio3130_downstream_init(PCIBus *bus, int devfn, bool multifunc=
tion,
-                                  const char *bus_name, pci_map_irq_fn m=
ap_irq,
-                                  uint8_t port, uint8_t chassis,
-                                  uint16_t slot)
-{
-    PCIDevice *d;
-    PCIBridge *br;
-    DeviceState *qdev;
-
-    d =3D pci_create_multifunction(bus, devfn, multifunction,
-                                 "xio3130-downstream");
-    if (!d) {
-        return NULL;
-    }
-    br =3D PCI_BRIDGE(d);
-
-    qdev =3D DEVICE(d);
-    pci_bridge_map_irq(br, bus_name, map_irq);
-    qdev_prop_set_uint8(qdev, "port", port);
-    qdev_prop_set_uint8(qdev, "chassis", chassis);
-    qdev_prop_set_uint16(qdev, "slot", slot);
-    qdev_init_nofail(qdev);
-
-    return PCIE_SLOT(d);
-}
-
 static Property xio3130_downstream_props[] =3D {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_ups=
tream.c
index bca2f9a5ea..b524908cf1 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -23,7 +23,7 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
-#include "xio3130_upstream.h"
+#include "hw/pci/pcie_port.h"
=20
 #define PCI_DEVICE_ID_TI_XIO3130U       0x8232  /* upstream port */
 #define XIO3130_REVISION                0x2
@@ -108,28 +108,6 @@ static void xio3130_upstream_exitfn(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
=20
-PCIEPort *xio3130_upstream_init(PCIBus *bus, int devfn, bool multifuncti=
on,
-                             const char *bus_name, pci_map_irq_fn map_ir=
q,
-                             uint8_t port)
-{
-    PCIDevice *d;
-    PCIBridge *br;
-    DeviceState *qdev;
-
-    d =3D pci_create_multifunction(bus, devfn, multifunction, "x3130-ups=
tream");
-    if (!d) {
-        return NULL;
-    }
-    br =3D PCI_BRIDGE(d);
-
-    qdev =3D DEVICE(d);
-    pci_bridge_map_irq(br, bus_name, map_irq);
-    qdev_prop_set_uint8(qdev, "port", port);
-    qdev_init_nofail(qdev);
-
-    return PCIE_PORT(d);
-}
-
 static const VMStateDescription vmstate_xio3130_upstream =3D {
     .name =3D "xio3130-express-upstream-port",
     .priority =3D MIG_PRI_PCI_BUS,
--=20
MST
