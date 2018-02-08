Received: from eggs.gnu.org ([2001:4830:134:3::10]:54147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZG-000693-Ba
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZE-0008Kl-Oc
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50880 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZE-0008Jj-HV
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:08 -0500
Date: Thu, 8 Feb 2018 21:09:07 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-13-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 12/26] pci/bus: let it has higher migration
 priority
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

From: Peter Xu <peterx@redhat.com>

In the past, we prioritized IOMMU migration so that we have such a
priority order:

    IOMMU > PCI Devices

When migrating a guest with both vIOMMU and a pcie-root-port, we'll
always migrate vIOMMU first, since pci buses will be seen to have the
same priority of general PCI devices.

That's problematic.

The thing is that PCI bus number information is stored in the root port,
and that is needed by vIOMMU during post_load(), e.g., to figure out
context entry for a device.  If we don't have correct bus numbers for
devices, we won't be able to recover device state of the DMAR memory
regions, and things will be messed up.

So let's boost the PCIe root ports to be even with higher priority:

   PCIe Root Port > IOMMU > PCI Devices

A smoke test shows that this patch fixes bug 1538953.

Also, apply this rule to all the PCI bus/bridge devices: ioh3420,
xio3130_downstream, xio3130_upstream, pcie_pci_bridge, pci-pci bridge,
i82801b11.

I noted that we set pcie_pci_bridge_dev_vmstate twice.  Clean that up
together.

CC: Alex Williamson <alex.williamson@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Laurent Vivier <lvivier@redhat.com>
Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1538953
Reported-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/migration/vmstate.h        | 1 +
 hw/pci-bridge/gen_pcie_root_port.c | 1 +
 hw/pci-bridge/i82801b11.c          | 1 +
 hw/pci-bridge/ioh3420.c            | 1 +
 hw/pci-bridge/pci_bridge_dev.c     | 1 +
 hw/pci-bridge/pcie_pci_bridge.c    | 2 +-
 hw/pci-bridge/xio3130_downstream.c | 1 +
 hw/pci-bridge/xio3130_upstream.c   | 1 +
 8 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 8c38894..df463fd 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -148,6 +148,7 @@ enum VMStateFlags {
 typedef enum {
     MIG_PRI_DEFAULT = 0,
     MIG_PRI_IOMMU,              /* Must happen before PCI devices */
+    MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
     MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
     MIG_PRI_GICV3,              /* Must happen before the ITS */
     MIG_PRI_MAX,
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 3dbacc6..d117e20 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -101,6 +101,7 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_rp_dev = {
     .name = "pcie-root-port",
+    .priority = MIG_PRI_PCI_BUS,
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pcie_cap_slot_post_load,
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index ebf7f5f..620b435 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -80,6 +80,7 @@ err_bridge:
 
 static const VMStateDescription i82801b11_bridge_dev_vmstate = {
     .name = "i82801b11_bridge",
+    .priority = MIG_PRI_PCI_BUS,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
         VMSTATE_END_OF_LIST()
diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index 5f56a2f..a7bfbdd 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -83,6 +83,7 @@ static void ioh3420_interrupts_uninit(PCIDevice *d)
 
 static const VMStateDescription vmstate_ioh3420 = {
     .name = "ioh-3240-express-root-port",
+    .priority = MIG_PRI_PCI_BUS,
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pcie_cap_slot_post_load,
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index d56f663..b2d861d 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -174,6 +174,7 @@ static bool pci_device_shpc_present(void *opaque, int version_id)
 
 static const VMStateDescription pci_bridge_dev_vmstate = {
     .name = "pci_bridge",
+    .priority = MIG_PRI_PCI_BUS,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
         SHPC_VMSTATE(shpc, PCIDevice, pci_device_shpc_present),
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index a4d827c..e5ac797 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -129,6 +129,7 @@ static Property pcie_pci_bridge_dev_properties[] = {
 
 static const VMStateDescription pcie_pci_bridge_dev_vmstate = {
         .name = TYPE_PCIE_PCI_BRIDGE_DEV,
+        .priority = MIG_PRI_PCI_BUS,
         .fields = (VMStateField[]) {
             VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
             SHPC_VMSTATE(shpc, PCIDevice, NULL),
@@ -178,7 +179,6 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
     k->config_write = pcie_pci_bridge_write_config;
     dc->vmsd = &pcie_pci_bridge_dev_vmstate;
     dc->props = pcie_pci_bridge_dev_properties;
-    dc->vmsd = &pcie_pci_bridge_dev_vmstate;
     dc->reset = &pcie_pci_bridge_reset;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     hc->plug = pcie_pci_bridge_hotplug_cb;
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 1e09d2a..4dd2e65 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -161,6 +161,7 @@ static Property xio3130_downstream_props[] = {
 
 static const VMStateDescription vmstate_xio3130_downstream = {
     .name = "xio3130-express-downstream-port",
+    .priority = MIG_PRI_PCI_BUS,
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pcie_cap_slot_post_load,
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 227997c..c5f02a6 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -133,6 +133,7 @@ PCIEPort *xio3130_upstream_init(PCIBus *bus, int devfn, bool multifunction,
 
 static const VMStateDescription vmstate_xio3130_upstream = {
     .name = "xio3130-express-upstream-port",
+    .priority = MIG_PRI_PCI_BUS,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-- 
MST
