Received: from eggs.gnu.org ([2001:4830:134:3::10]:35821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fY1Sw-0006eg-36
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fY1Sv-00069M-00
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:49:58 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fY1Su-00067q-QK
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:49:56 -0400
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Tue, 26 Jun 2018 22:49:33 -0500
Message-Id: <20180627034935.20276-4-venu.busireddy@oracle.com>
In-Reply-To: <20180627034935.20276-1-venu.busireddy@oracle.com>
References: <20180627034935.20276-1-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH v2 3/4] Add "Group Identifier" support to Red
 Hat PCI bridge.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: venu.busireddy@oracle.com, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

Add the "Vendor-Specific" capability to the Red Hat PCI bridge device
"pci-bridge", to contain the "Group Identifier" (UUID) that will be
used to pair a virtio device with the passthrough device attached to
that bridge.

This capability is added to the bridge iff the "uuid" option is specified
for the bridge.

Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hw/pci-bridge/pci_bridge_dev.c |  8 ++++++++
 hw/pci/pci_bridge.c            | 26 ++++++++++++++++++++++++++
 include/hw/pci/pcie.h          |  1 +
 3 files changed, 35 insertions(+)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index b2d861d216..bbbc6fa1c6 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -71,6 +71,12 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
         bridge_dev->msi = ON_OFF_AUTO_OFF;
     }
 
+    err = pci_bridge_vendor_init(dev, 0, errp);
+    if (err < 0) {
+        error_append_hint(errp, "Can't init group ID, error %d\n", err);
+        goto vendor_cap_err;
+    }
+
     err = slotid_cap_init(dev, 0, bridge_dev->chassis_nr, 0, errp);
     if (err) {
         goto slotid_error;
@@ -109,6 +115,7 @@ slotid_error:
     if (shpc_present(dev)) {
         shpc_cleanup(dev, &bridge_dev->bar);
     }
+vendor_cap_err:
 shpc_error:
     pci_bridge_exitfn(dev);
 }
@@ -162,6 +169,7 @@ static Property pci_bridge_dev_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
                     PCI_BRIDGE_DEV_F_SHPC_REQ, true),
+    DEFINE_PROP_UUID(COMPAT_PROP_UUID, PCIDevice, uuid, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 40a39f57cb..cb8b3dad2a 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -34,12 +34,17 @@
 #include "hw/pci/pci_bus.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
+#include "qemu/uuid.h"
 
 /* PCI bridge subsystem vendor ID helper functions */
 #define PCI_SSVID_SIZEOF        8
 #define PCI_SSVID_SVID          4
 #define PCI_SSVID_SSID          6
 
+#define PCI_VENDOR_SIZEOF             20
+#define PCI_VENDOR_CAP_LEN_OFFSET      2
+#define PCI_VENDOR_GROUP_ID_OFFSET     4
+
 int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
                           uint16_t svid, uint16_t ssid,
                           Error **errp)
@@ -57,6 +62,27 @@ int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
     return pos;
 }
 
+int pci_bridge_vendor_init(PCIDevice *d, uint8_t offset, Error **errp)
+{
+    int pos;
+
+    if (qemu_uuid_is_null(&d->uuid)) {
+        return 0;
+    }
+
+    pos = pci_add_capability(d, PCI_CAP_ID_VNDR, offset, PCI_VENDOR_SIZEOF,
+            errp);
+    if (pos < 0) {
+        return pos;
+    }
+
+    pci_set_word(d->config + pos + PCI_VENDOR_CAP_LEN_OFFSET,
+            PCI_VENDOR_SIZEOF);
+    memcpy(d->config + pos + PCI_VENDOR_GROUP_ID_OFFSET, &d->uuid,
+            sizeof(QemuUUID));
+    return pos;
+}
+
 /* Accessor function to get parent bridge device from pci bus. */
 PCIDevice *pci_bridge_get_device(PCIBus *bus)
 {
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index b71e369703..b4189d0ce3 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -82,6 +82,7 @@ struct PCIExpressDevice {
 };
 
 #define COMPAT_PROP_PCP "power_controller_present"
+#define COMPAT_PROP_UUID "uuid"
 
 /* PCI express capability helper functions */
 int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type,
