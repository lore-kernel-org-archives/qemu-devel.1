Received: from eggs.gnu.org ([2001:4830:134:3::10]:39526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKPjr-0000rW-Ed
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKPjp-0008Rb-Qc
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:50:39 -0400
Received: from [59.151.112.132] (port=23824 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKPjo-0008P1-Ao
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:50:37 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 12 Jun 2017 21:48:32 +0800
Message-ID: <41cdfa0bee8125dcf347822fb0d9b279ee8b61fa.1497272778.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1497272778.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1497272778.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 6/9] pci: Convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, armbru@redhat.com

The pci-birdge device i82801b11 and io3130_upstream/downstream
still implements the old PCIDeviceClass .init() through *_init()
instead of the new .realize(). All devices need to be converted
to .realize(). So convert it and rename it to *_realize().

Cc: mst@redhat.com
Cc: marcel@redhat.com
Cc: armbru@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/pci-bridge/i82801b11.c          | 11 +++++------
 hw/pci-bridge/pcie_root_port.c     | 15 ++++++---------
 hw/pci-bridge/xio3130_downstream.c | 20 +++++++++-----------
 hw/pci-bridge/xio3130_upstream.c   | 20 +++++++++-----------
 hw/pci/pci_bridge.c                |  7 +++----
 hw/pci/pcie.c                      | 11 ++++++-----
 include/hw/pci/pci_bridge.h        |  3 ++-
 include/hw/pci/pcie.h              |  3 ++-
 8 files changed, 42 insertions(+), 48 deletions(-)

diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 2c065c3..2c1b747 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -59,24 +59,23 @@ typedef struct I82801b11Bridge {
     /*< public >*/
 } I82801b11Bridge;
 
-static int i82801b11_bridge_initfn(PCIDevice *d)
+static void i82801b11_bridge_realize(PCIDevice *d, Error **errp)
 {
     int rc;
 
     pci_bridge_initfn(d, TYPE_PCI_BUS);
 
     rc = pci_bridge_ssvid_init(d, I82801ba_SSVID_OFFSET,
-                               I82801ba_SSVID_SVID, I82801ba_SSVID_SSID);
+                               I82801ba_SSVID_SVID, I82801ba_SSVID_SSID,
+                               errp);
     if (rc < 0) {
         goto err_bridge;
     }
     pci_config_set_prog_interface(d->config, PCI_CLASS_BRIDGE_PCI_INF_SUB);
-    return 0;
+    return;
 
 err_bridge:
     pci_bridge_exitfn(d);
-
-    return rc;
 }
 
 static const VMStateDescription i82801b11_bridge_dev_vmstate = {
@@ -96,7 +95,7 @@ static void i82801b11_bridge_class_init(ObjectClass *klass, void *data)
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82801BA_11;
     k->revision = ICH9_D2P_A2_REVISION;
-    k->init = i82801b11_bridge_initfn;
+    k->realize = i82801b11_bridge_realize;
     k->config_write = pci_bridge_write_config;
     dc->vmsd = &i82801b11_bridge_dev_vmstate;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index cf36318..00f0b1f 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -59,29 +59,27 @@ static void rp_realize(PCIDevice *d, Error **errp)
     PCIDeviceClass *dc = PCI_DEVICE_GET_CLASS(d);
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
     int rc;
-    Error *local_err = NULL;
 
     pci_config_set_interrupt_pin(d->config, 1);
     pci_bridge_initfn(d, TYPE_PCIE_BUS);
     pcie_port_init_reg(d);
 
-    rc = pci_bridge_ssvid_init(d, rpc->ssvid_offset, dc->vendor_id, rpc->ssid);
+    rc = pci_bridge_ssvid_init(d, rpc->ssvid_offset, dc->vendor_id,
+                               rpc->ssid, errp);
     if (rc < 0) {
-        error_setg(errp, "Can't init SSV ID, error %d", rc);
         goto err_bridge;
     }
 
     if (rpc->interrupts_init) {
-        rc = rpc->interrupts_init(d, &local_err);
+        rc = rpc->interrupts_init(d, errp);
         if (rc < 0) {
-            error_propagate(errp, local_err);
             goto err_bridge;
         }
     }
 
-    rc = pcie_cap_init(d, rpc->exp_offset, PCI_EXP_TYPE_ROOT_PORT, p->port);
+    rc = pcie_cap_init(d, rpc->exp_offset, PCI_EXP_TYPE_ROOT_PORT,
+                       p->port, errp);
     if (rc < 0) {
-        error_setg(errp, "Can't add Root Port capability, error %d", rc);
         goto err_int;
     }
 
@@ -98,9 +96,8 @@ static void rp_realize(PCIDevice *d, Error **errp)
     }
 
     rc = pcie_aer_init(d, PCI_ERR_VER, rpc->aer_offset,
-                       PCI_ERR_SIZEOF, &local_err);
+                       PCI_ERR_SIZEOF, errp);
     if (rc < 0) {
-        error_propagate(errp, local_err);
         goto err;
     }
     pcie_aer_root_init(d);
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index cfe8a36..e706f36 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -56,33 +56,33 @@ static void xio3130_downstream_reset(DeviceState *qdev)
     pci_bridge_reset(qdev);
 }
 
-static int xio3130_downstream_initfn(PCIDevice *d)
+static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
 {
     PCIEPort *p = PCIE_PORT(d);
     PCIESlot *s = PCIE_SLOT(d);
     int rc;
-    Error *err = NULL;
 
     pci_bridge_initfn(d, TYPE_PCIE_BUS);
     pcie_port_init_reg(d);
 
     rc = msi_init(d, XIO3130_MSI_OFFSET, XIO3130_MSI_NR_VECTOR,
                   XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
-                  XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT, &err);
+                  XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
+                  errp);
     if (rc < 0) {
         assert(rc == -ENOTSUP);
-        error_report_err(err);
         goto err_bridge;
     }
 
     rc = pci_bridge_ssvid_init(d, XIO3130_SSVID_OFFSET,
-                               XIO3130_SSVID_SVID, XIO3130_SSVID_SSID);
+                               XIO3130_SSVID_SVID, XIO3130_SSVID_SSID,
+                               errp);
     if (rc < 0) {
         goto err_bridge;
     }
 
     rc = pcie_cap_init(d, XIO3130_EXP_OFFSET, PCI_EXP_TYPE_DOWNSTREAM,
-                       p->port);
+                       p->port, errp);
     if (rc < 0) {
         goto err_msi;
     }
@@ -98,13 +98,12 @@ static int xio3130_downstream_initfn(PCIDevice *d)
     }
 
     rc = pcie_aer_init(d, PCI_ERR_VER, XIO3130_AER_OFFSET,
-                       PCI_ERR_SIZEOF, &err);
+                       PCI_ERR_SIZEOF, errp);
     if (rc < 0) {
-        error_report_err(err);
         goto err;
     }
 
-    return 0;
+    return;
 
 err:
     pcie_chassis_del_slot(s);
@@ -114,7 +113,6 @@ err_msi:
     msi_uninit(d);
 err_bridge:
     pci_bridge_exitfn(d);
-    return rc;
 }
 
 static void xio3130_downstream_exitfn(PCIDevice *d)
@@ -181,7 +179,7 @@ static void xio3130_downstream_class_init(ObjectClass *klass, void *data)
     k->is_express = 1;
     k->is_bridge = 1;
     k->config_write = xio3130_downstream_write_config;
-    k->init = xio3130_downstream_initfn;
+    k->realize = xio3130_downstream_realize;
     k->exit = xio3130_downstream_exitfn;
     k->vendor_id = PCI_VENDOR_ID_TI;
     k->device_id = PCI_DEVICE_ID_TI_XIO3130D;
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 401c784..a052224 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -53,32 +53,32 @@ static void xio3130_upstream_reset(DeviceState *qdev)
     pcie_cap_deverr_reset(d);
 }
 
-static int xio3130_upstream_initfn(PCIDevice *d)
+static void xio3130_upstream_realize(PCIDevice *d, Error **errp)
 {
     PCIEPort *p = PCIE_PORT(d);
     int rc;
-    Error *err = NULL;
 
     pci_bridge_initfn(d, TYPE_PCIE_BUS);
     pcie_port_init_reg(d);
 
     rc = msi_init(d, XIO3130_MSI_OFFSET, XIO3130_MSI_NR_VECTOR,
                   XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
-                  XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT, &err);
+                  XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
+                  errp);
     if (rc < 0) {
         assert(rc == -ENOTSUP);
-        error_report_err(err);
         goto err_bridge;
     }
 
     rc = pci_bridge_ssvid_init(d, XIO3130_SSVID_OFFSET,
-                               XIO3130_SSVID_SVID, XIO3130_SSVID_SSID);
+                               XIO3130_SSVID_SVID, XIO3130_SSVID_SSID,
+                               errp);
     if (rc < 0) {
         goto err_bridge;
     }
 
     rc = pcie_cap_init(d, XIO3130_EXP_OFFSET, PCI_EXP_TYPE_UPSTREAM,
-                       p->port);
+                       p->port, errp);
     if (rc < 0) {
         goto err_msi;
     }
@@ -86,13 +86,12 @@ static int xio3130_upstream_initfn(PCIDevice *d)
     pcie_cap_deverr_init(d);
 
     rc = pcie_aer_init(d, PCI_ERR_VER, XIO3130_AER_OFFSET,
-                       PCI_ERR_SIZEOF, &err);
+                       PCI_ERR_SIZEOF, errp);
     if (rc < 0) {
-        error_report_err(err);
         goto err;
     }
 
-    return 0;
+    return;
 
 err:
     pcie_cap_exit(d);
@@ -100,7 +99,6 @@ err_msi:
     msi_uninit(d);
 err_bridge:
     pci_bridge_exitfn(d);
-    return rc;
 }
 
 static void xio3130_upstream_exitfn(PCIDevice *d)
@@ -153,7 +151,7 @@ static void xio3130_upstream_class_init(ObjectClass *klass, void *data)
     k->is_express = 1;
     k->is_bridge = 1;
     k->config_write = xio3130_upstream_write_config;
-    k->init = xio3130_upstream_initfn;
+    k->realize = xio3130_upstream_realize;
     k->exit = xio3130_upstream_exitfn;
     k->vendor_id = PCI_VENDOR_ID_TI;
     k->device_id = PCI_DEVICE_ID_TI_XIO3130U;
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index bb0f3a3..720119b 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -41,15 +41,14 @@
 #define PCI_SSVID_SSID          6
 
 int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
-                          uint16_t svid, uint16_t ssid)
+                          uint16_t svid, uint16_t ssid,
+                          Error **errp)
 {
     int pos;
-    Error *local_err = NULL;
 
     pos = pci_add_capability(dev, PCI_CAP_ID_SSVID, offset,
-                             PCI_SSVID_SIZEOF, &local_err);
+                             PCI_SSVID_SIZEOF, errp);
     if (pos < 0) {
-        error_report_err(local_err);
         return pos;
     }
 
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index f187512..05d091a 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -86,19 +86,19 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
     pci_set_word(cmask + PCI_EXP_LNKSTA, 0);
 }
 
-int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type, uint8_t port)
+int pcie_cap_init(PCIDevice *dev, uint8_t offset,
+                  uint8_t type, uint8_t port,
+                  Error **errp)
 {
     /* PCIe cap v2 init */
     int pos;
     uint8_t *exp_cap;
-    Error *local_err = NULL;
 
     assert(pci_is_express(dev));
 
     pos = pci_add_capability(dev, PCI_CAP_ID_EXP, offset,
-                             PCI_EXP_VER2_SIZEOF, &local_err);
+                             PCI_EXP_VER2_SIZEOF, errp);
     if (pos < 0) {
-        error_report_err(local_err);
         return pos;
     }
     dev->exp.exp_cap = pos;
@@ -147,6 +147,7 @@ static int
 pcie_endpoint_cap_common_init(PCIDevice *dev, uint8_t offset, uint8_t cap_size)
 {
     uint8_t type = PCI_EXP_TYPE_ENDPOINT;
+    Error *local_err = NULL;
 
     /*
      * Windows guests will report Code 10, device cannot start, if
@@ -159,7 +160,7 @@ pcie_endpoint_cap_common_init(PCIDevice *dev, uint8_t offset, uint8_t cap_size)
 
     return (cap_size == PCI_EXP_VER1_SIZEOF)
         ? pcie_cap_v1_init(dev, offset, type, 0)
-        : pcie_cap_init(dev, offset, type, 0);
+        : pcie_cap_init(dev, offset, type, 0, &local_err);
 }
 
 int pcie_endpoint_cap_init(PCIDevice *dev, uint8_t offset)
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index d5891cd..ff7cbaa 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -33,7 +33,8 @@
 #define PCI_BRIDGE_DEV_PROP_SHPC       "shpc"
 
 int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
-                          uint16_t svid, uint16_t ssid);
+                          uint16_t svid, uint16_t ssid,
+                          Error **errp);
 
 PCIDevice *pci_bridge_get_device(PCIBus *bus);
 PCIBus *pci_bridge_get_sec_bus(PCIBridge *br);
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 3d8f24b..b71e369 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -84,7 +84,8 @@ struct PCIExpressDevice {
 #define COMPAT_PROP_PCP "power_controller_present"
 
 /* PCI express capability helper functions */
-int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type, uint8_t port);
+int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type,
+                  uint8_t port, Error **errp);
 int pcie_cap_v1_init(PCIDevice *dev, uint8_t offset,
                      uint8_t type, uint8_t port);
 int pcie_endpoint_cap_init(PCIDevice *dev, uint8_t offset);
-- 
2.9.3
