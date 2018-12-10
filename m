Received: from eggs.gnu.org ([2001:4830:134:3::10]:55448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1gWOEK-0001Og-UI
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1gWOED-0001rH-8d
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:16:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1gWOEB-0001nb-9D
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:16:17 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Mon, 10 Dec 2018 11:15:48 -0500
Message-Id: <1544458548-5986-4-git-send-email-venu.busireddy@oracle.com>
In-Reply-To: <1544458548-5986-1-git-send-email-venu.busireddy@oracle.com>
References: <1544458548-5986-1-git-send-email-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH 3/3] vfio-pci: Add FAILOVER_PRIMARY_CHANGED
 event to shorten downtime during failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: venu.busireddy@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

From: Si-Wei Liu <si-wei.liu@oracle.com>

When a VF is hotplugged into the guest, datapath switching will be
performed immediately, which is sub-optimal in terms of timing, and
could end up with substantial network downtime. One of ways to shorten
this downtime is to switch the datapath only after the VF is seen to get
enabled by guest, indicated by the bus master bit in VF's PCI config
space getting enabled. The FAILOVER_PRIMARY_CHANGED event is emitted
at that time to indicate this condition. Then management stack can kick
off datapath switching upon receiving the event.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hw/vfio/pci.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/net.json | 26 ++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ce1f33c..ea24ca2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -34,6 +34,7 @@
 #include "pci.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-net.h"
 
 #define MSIX_CAP_LENGTH 12
 
@@ -42,6 +43,7 @@
 
 static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
+static void vfio_failover_notify(VFIOPCIDevice *vdev, bool status);
 
 /*
  * Disabling BAR mmaping can be slow, but toggling it around INTx can
@@ -1170,6 +1172,8 @@ void vfio_pci_write_config(PCIDevice *pdev,
 {
     VFIOPCIDevice *vdev = PCI_VFIO(pdev);
     uint32_t val_le = cpu_to_le32(val);
+    bool may_notify = false;
+    bool master_was = false;
 
     trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
 
@@ -1180,6 +1184,14 @@ void vfio_pci_write_config(PCIDevice *pdev,
                      __func__, vdev->vbasedev.name, addr, val, len);
     }
 
+    /* Bus Master Enabling/Disabling */
+    if (pdev->failover_primary && current_cpu &&
+        range_covers_byte(addr, len, PCI_COMMAND)) {
+        master_was = !!(pci_get_word(pdev->config + PCI_COMMAND) &
+                        PCI_COMMAND_MASTER);
+        may_notify = true;
+    }
+
     /* MSI/MSI-X Enabling/Disabling */
     if (pdev->cap_present & QEMU_PCI_CAP_MSI &&
         ranges_overlap(addr, len, pdev->msi_cap, vdev->msi_cap_size)) {
@@ -1235,6 +1247,14 @@ void vfio_pci_write_config(PCIDevice *pdev,
         /* Write everything to QEMU to keep emulated bits correct */
         pci_default_write_config(pdev, addr, val, len);
     }
+
+    if (may_notify) {
+        bool master_now = !!(pci_get_word(pdev->config + PCI_COMMAND) &
+                             PCI_COMMAND_MASTER);
+        if (master_was != master_now) {
+            vfio_failover_notify(vdev, master_now);
+        }
+    }
 }
 
 /*
@@ -2801,6 +2821,17 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static void vfio_failover_notify(VFIOPCIDevice *vdev, bool status)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    const char *n;
+    gchar *path;
+
+    n = pdev->qdev.id ? pdev->qdev.id : vdev->vbasedev.name;
+    path = object_get_canonical_path(OBJECT(vdev));
+    qapi_event_send_failover_primary_changed(!!n, n, path, status);
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = PCI_VFIO(pdev);
@@ -3109,10 +3140,36 @@ static void vfio_instance_finalize(Object *obj)
     vfio_put_group(group);
 }
 
+static void vfio_exit_failover_notify(VFIOPCIDevice *vdev)
+{
+    PCIDevice *pdev = &vdev->pdev;
+
+    /*
+     * Guest driver may not get the chance to disable bus mastering
+     * before the device object gets to be unrealized. In that event,
+     * send out a "disabled" notification on behalf of guest driver.
+     */
+    if (pdev->failover_primary &&
+        pdev->bus_master_enable_region.enabled) {
+        vfio_failover_notify(vdev, false);
+    }
+}
+
 static void vfio_exitfn(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = PCI_VFIO(pdev);
 
+    /*
+     * During the guest reboot sequence, it is sometimes possible that
+     * the guest may not get sufficient time to complete the entire driver
+     * removal sequence, near the end of which a PCI config space write to
+     * disable bus mastering can be intercepted by device. In such cases,
+     * the FAILOVER_PRIMARY_CHANGED "disable" event will not be emitted. It
+     * is imperative to generate the event on the guest's behalf if the
+     * guest fails to make it.
+     */
+    vfio_exit_failover_notify(vdev);
+
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
diff --git a/qapi/net.json b/qapi/net.json
index 04a9de9..e5992c8 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -727,3 +727,29 @@
 ##
 { 'event': 'FAILOVER_UNPLUG_PRIMARY',
   'data': {'*device': 'str', 'path': 'str'} }
+
+##
+# @FAILOVER_PRIMARY_CHANGED:
+#
+# Emitted whenever the driver of failover primary is loaded or unloaded
+# by the guest.
+#
+# @device: device name
+#
+# @path: device path
+#
+# @enabled: true if driver is loaded thus device is enabled in guest
+#
+# Since: 3.0
+#
+# Example:
+#
+# <- { "event": "FAILOVER_PRIMARY_CHANGED",
+#      "data": { "device": "vfio-0",
+#                "path": "/machine/peripheral/vfio-0" },
+#                "enabled": "true" },
+#      "timestamp": { "seconds": 1539935213, "microseconds": 753529 } }
+#
+##
+{ 'event': 'FAILOVER_PRIMARY_CHANGED',
+  'data': { '*device': 'str', 'path': 'str', 'enabled': 'bool' } }
