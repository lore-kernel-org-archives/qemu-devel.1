Received: from eggs.gnu.org ([2001:4830:134:3::10]:42627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fZ1jw-0001VE-UU
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 18:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fZ1js-0007Vb-RT
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 18:19:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fZ1js-0007Qh-Hf
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 18:19:36 -0400
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Fri, 29 Jun 2018 17:19:05 -0500
Message-Id: <20180629221907.3662-3-venu.busireddy@oracle.com>
In-Reply-To: <20180629221907.3662-1-venu.busireddy@oracle.com>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH v3 2/3] Add "Group Identifier" support to Red
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
"pci-bridge", to contain the "Group Identifier" that will be used to pair
a virtio device with the passthrough device attached to that bridge. Also,
change the Device ID of the bridge to PCI_DEVICE_ID_REDHAT_BRIDGE_FAILOVER
to avoid confusion with bridges that don't have this capability.

This capability is added to the bridge iff the "failover-group-id"
option is specified for the bridge.

Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hw/pci-bridge/pci_bridge_dev.c | 10 ++++++++++
 hw/pci/pci_bridge.c            | 34 +++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h           | 35 +++++++++++++++++-----------------
 include/hw/pci/pci_bridge.h    |  2 ++
 4 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index b2d861d216..d3879071a8 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -71,6 +71,13 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
         bridge_dev->msi = ON_OFF_AUTO_OFF;
     }
 
+    err = pci_bridge_vendor_init(dev, 0, PCI_DEVICE_ID_REDHAT_BRIDGE_FAILOVER,
+            errp);
+    if (err < 0) {
+        error_append_hint(errp, "Can't init group ID, error %d\n", err);
+        goto vendor_cap_err;
+    }
+
     err = slotid_cap_init(dev, 0, bridge_dev->chassis_nr, 0, errp);
     if (err) {
         goto slotid_error;
@@ -109,6 +116,7 @@ slotid_error:
     if (shpc_present(dev)) {
         shpc_cleanup(dev, &bridge_dev->bar);
     }
+vendor_cap_err:
 shpc_error:
     pci_bridge_exitfn(dev);
 }
@@ -162,6 +170,8 @@ static Property pci_bridge_dev_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
                     PCI_BRIDGE_DEV_F_SHPC_REQ, true),
+    DEFINE_PROP_UINT64(COMPAT_PROP_FAILOVER_GROUP_ID,
+                       PCIDevice, failover_group_id, ULLONG_MAX),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 40a39f57cb..68cc619c20 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -40,6 +40,10 @@
 #define PCI_SSVID_SVID          4
 #define PCI_SSVID_SSID          6
 
+#define PCI_VENDOR_SIZEOF             12
+#define PCI_VENDOR_CAP_LEN_OFFSET      2
+#define PCI_VENDOR_GROUP_ID_OFFSET     4
+
 int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
                           uint16_t svid, uint16_t ssid,
                           Error **errp)
@@ -57,6 +61,36 @@ int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
     return pos;
 }
 
+int pci_bridge_vendor_init(PCIDevice *d, uint8_t offset,
+                           uint16_t device_id, Error **errp)
+{
+    int pos;
+    PCIDeviceClass *dc = PCI_DEVICE_GET_CLASS(d);
+
+    if (d->failover_group_id == ULLONG_MAX) {
+        return 0;
+    }
+
+    pos = pci_add_capability(d, PCI_CAP_ID_VNDR, offset, PCI_VENDOR_SIZEOF,
+            errp);
+    if (pos < 0) {
+        return pos;
+    }
+
+    /*
+     * Tweak the Device ID to avoid confusion
+     * with bridges that don't have the group id capability.
+     */
+    dc->device_id = device_id;
+    pci_set_word(d->config + PCI_DEVICE_ID, device_id);
+
+    pci_set_word(d->config + pos + PCI_VENDOR_CAP_LEN_OFFSET,
+            PCI_VENDOR_SIZEOF);
+    memcpy(d->config + pos + PCI_VENDOR_GROUP_ID_OFFSET,
+            &d->failover_group_id, sizeof(uint64_t));
+    return pos;
+}
+
 /* Accessor function to get parent bridge device from pci bus. */
 PCIDevice *pci_bridge_get_device(PCIBus *bus)
 {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index b59c3e7e38..bc38032761 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -86,23 +86,24 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
 
-#define PCI_VENDOR_ID_REDHAT             0x1b36
-#define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
-#define PCI_DEVICE_ID_REDHAT_SERIAL      0x0002
-#define PCI_DEVICE_ID_REDHAT_SERIAL2     0x0003
-#define PCI_DEVICE_ID_REDHAT_SERIAL4     0x0004
-#define PCI_DEVICE_ID_REDHAT_TEST        0x0005
-#define PCI_DEVICE_ID_REDHAT_ROCKER      0x0006
-#define PCI_DEVICE_ID_REDHAT_SDHCI       0x0007
-#define PCI_DEVICE_ID_REDHAT_PCIE_HOST   0x0008
-#define PCI_DEVICE_ID_REDHAT_PXB         0x0009
-#define PCI_DEVICE_ID_REDHAT_BRIDGE_SEAT 0x000a
-#define PCI_DEVICE_ID_REDHAT_PXB_PCIE    0x000b
-#define PCI_DEVICE_ID_REDHAT_PCIE_RP     0x000c
-#define PCI_DEVICE_ID_REDHAT_XHCI        0x000d
-#define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
-#define PCI_DEVICE_ID_REDHAT_MDPY        0x000f
-#define PCI_DEVICE_ID_REDHAT_QXL         0x0100
+#define PCI_VENDOR_ID_REDHAT                    0x1b36
+#define PCI_DEVICE_ID_REDHAT_BRIDGE             0x0001
+#define PCI_DEVICE_ID_REDHAT_SERIAL             0x0002
+#define PCI_DEVICE_ID_REDHAT_SERIAL2            0x0003
+#define PCI_DEVICE_ID_REDHAT_SERIAL4            0x0004
+#define PCI_DEVICE_ID_REDHAT_TEST               0x0005
+#define PCI_DEVICE_ID_REDHAT_ROCKER             0x0006
+#define PCI_DEVICE_ID_REDHAT_SDHCI              0x0007
+#define PCI_DEVICE_ID_REDHAT_PCIE_HOST          0x0008
+#define PCI_DEVICE_ID_REDHAT_PXB                0x0009
+#define PCI_DEVICE_ID_REDHAT_BRIDGE_SEAT        0x000a
+#define PCI_DEVICE_ID_REDHAT_PXB_PCIE           0x000b
+#define PCI_DEVICE_ID_REDHAT_PCIE_RP            0x000c
+#define PCI_DEVICE_ID_REDHAT_XHCI               0x000d
+#define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE        0x000e
+#define PCI_DEVICE_ID_REDHAT_MDPY               0x000f
+#define PCI_DEVICE_ID_REDHAT_BRIDGE_FAILOVER    0x0010
+#define PCI_DEVICE_ID_REDHAT_QXL                0x0100
 
 #define FMT_PCIBUS                      PRIx64
 
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 0347da52d2..aa471ec5a4 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -83,6 +83,8 @@ struct PCIBridge {
 int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
                           uint16_t svid, uint16_t ssid,
                           Error **errp);
+int pci_bridge_vendor_init(PCIDevice *dev, uint8_t offset,
+                           uint16_t device_id, Error **errp);
 
 PCIDevice *pci_bridge_get_device(PCIBus *bus);
 PCIBus *pci_bridge_get_sec_bus(PCIBridge *br);
