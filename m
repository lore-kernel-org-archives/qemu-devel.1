Received: from eggs.gnu.org ([2001:4830:134:3::10]:55424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1gWOED-0001KG-5o
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1gWOE9-0001nG-CB
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:16:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1gWOE7-0001m4-Bh
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:16:13 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Mon, 10 Dec 2018 11:15:47 -0500
Message-Id: <1544458548-5986-3-git-send-email-venu.busireddy@oracle.com>
In-Reply-To: <1544458548-5986-1-git-send-email-venu.busireddy@oracle.com>
References: <1544458548-5986-1-git-send-email-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH 2/3] virtio_net: Add support for "Data Path
 Switching" during Live Migration.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: venu.busireddy@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

Added two new events, FAILOVER_PLUG_PRIMARY and FAILOVER_UNPLUG_PRIMARY.
The first is emitted when the guest negotiates the F_STANDBY feature
bit. The second is emitted when the virtio_net driver is removed, either
manually or as a result of guest reboot. Management stack can use these
events to determine when to plug/unplug the VF device to/from the guest.

Also, the Virtual Functions will be automatically removed from the guest
if the guest is rebooted. To properly identify the VFIO devices that
must be removed, a new property named "x-failover-primary" is added to
the vfio-pci devices. Only the vfio-pci devices that have this property
enabled are removed from the guest upon reboot.

Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hw/acpi/pcihp.c                | 27 ++++++++++++++++++++++++++
 hw/net/virtio-net.c            | 23 ++++++++++++++++++++++
 hw/vfio/pci.c                  |  3 +++
 hw/vfio/pci.h                  |  1 +
 include/hw/pci/pci.h           |  1 +
 include/hw/virtio/virtio-net.h |  4 ++++
 qapi/net.json                  | 44 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 103 insertions(+)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 80d42e1..2a3ffd3 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -176,6 +176,25 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slo
     }
 }
 
+static void acpi_pcihp_cleanup_failover_primary(AcpiPciHpState *s, int bsel)
+{
+    BusChild *kid, *next;
+    PCIBus *bus = acpi_pcihp_find_hotplug_bus(s, bsel);
+
+    if (!bus) {
+        return;
+    }
+    QTAILQ_FOREACH_SAFE(kid, &bus->qbus.children, sibling, next) {
+        DeviceState *qdev = kid->child;
+        PCIDevice *pdev = PCI_DEVICE(qdev);
+        int slot = PCI_SLOT(pdev->devfn);
+
+        if (pdev->failover_primary) {
+            s->acpi_pcihp_pci_status[bsel].down |= (1U << slot);
+        }
+    }
+}
+
 static void acpi_pcihp_update_hotplug_bus(AcpiPciHpState *s, int bsel)
 {
     BusChild *kid, *next;
@@ -207,6 +226,14 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
     int i;
 
     for (i = 0; i < ACPI_PCIHP_MAX_HOTPLUG_BUS; ++i) {
+        /*
+         * Set the acpi_pcihp_pci_status[].down bits of all the
+         * failover_primary devices so that the devices are ejected
+         * from the guest. We can't use the qdev_unplug() as well as the
+         * hotplug_handler to unplug the devices, because the guest may
+         * not be in a state to cooperate.
+         */
+        acpi_pcihp_cleanup_failover_primary(s, i);
         acpi_pcihp_update_hotplug_bus(s, i);
     }
 }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 411f8fb..d37f33c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -248,6 +248,28 @@ static void virtio_net_drop_tx_queue_data(VirtIODevice *vdev, VirtQueue *vq)
     }
 }
 
+static void virtio_net_failover_notify_event(VirtIONet *n, uint8_t status)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    if (virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_STANDBY)) {
+        gchar *path = object_get_canonical_path(OBJECT(n->qdev));
+        /*
+         * Emit the FAILOVER_PLUG_PRIMARY event
+         *   when the status transitions from 0 to VIRTIO_CONFIG_S_DRIVER_OK
+         * Emit the FAILOVER_UNPLUG_PRIMARY event
+         *   when the status transitions from VIRTIO_CONFIG_S_DRIVER_OK to 0
+         */
+        if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+                (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK))) {
+            FAILOVER_NOTIFY_EVENT(plug, n, path);
+        } else if ((!(status & VIRTIO_CONFIG_S_DRIVER_OK)) &&
+                (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+            FAILOVER_NOTIFY_EVENT(unplug, n, path);
+        }
+    }
+}
+
 static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
@@ -256,6 +278,7 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
     uint8_t queue_status;
 
     virtio_net_vnet_endian_status(n, status);
+    virtio_net_failover_notify_event(n, status);
     virtio_net_vhost_status(n, status);
 
     for (i = 0; i < n->max_queues; i++) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5c7bd96..ce1f33c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3077,6 +3077,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
+    pdev->failover_primary = vdev->failover_primary;
 
     return;
 
@@ -3219,6 +3220,8 @@ static Property vfio_pci_dev_properties[] = {
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
     DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
                                 OFF_AUTOPCIBAR_OFF),
+    DEFINE_PROP_BOOL("x-failover-primary", VFIOPCIDevice,
+                     failover_primary, false),
     /*
      * TODO - support passed fds... is this necessary?
      * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index b1ae4c0..06ca661 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -167,6 +167,7 @@ typedef struct VFIOPCIDevice {
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
     VFIODisplay *dpy;
+    bool failover_primary;
 } VFIOPCIDevice;
 
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6514bb..b0111d1 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -351,6 +351,7 @@ struct PCIDevice {
     MSIVectorUseNotifier msix_vector_use_notifier;
     MSIVectorReleaseNotifier msix_vector_release_notifier;
     MSIVectorPollNotifier msix_vector_poll_notifier;
+    bool failover_primary;
 };
 
 void pci_register_bar(PCIDevice *pci_dev, int region_num,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 4d7f3c8..a697903 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -22,6 +22,10 @@
 #define VIRTIO_NET(obj) \
         OBJECT_CHECK(VirtIONet, (obj), TYPE_VIRTIO_NET)
 
+#define FAILOVER_NOTIFY_EVENT(type, n, path) \
+        qapi_event_send_failover_##type##_primary \
+                (!!n->netclient_name, n->netclient_name, path)
+
 #define TX_TIMER_INTERVAL 150000 /* 150 us */
 
 /* Limit the number of packets that can be sent via a single flush
diff --git a/qapi/net.json b/qapi/net.json
index 8f99fd9..04a9de9 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -683,3 +683,47 @@
 ##
 { 'event': 'NIC_RX_FILTER_CHANGED',
   'data': { '*name': 'str', 'path': 'str' } }
+
+##
+# @FAILOVER_PLUG_PRIMARY:
+#
+# Emitted when the guest successfully loads the driver after the STANDBY
+# feature bit is negotiated.
+#
+# @device: Indicates the virtio_net device.
+#
+# @path: Indicates the device path.
+#
+# Since: 3.0
+#
+# Example:
+#
+# <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
+#     "event": "FAILOVER_PLUG_PRIMARY",
+#     "data": {"device": "net0", "path": "/machine/peripheral/net0/virtio-backend"} }
+#
+##
+{ 'event': 'FAILOVER_PLUG_PRIMARY',
+  'data': {'*device': 'str', 'path': 'str'} }
+
+##
+# @FAILOVER_UNPLUG_PRIMARY:
+#
+# Emitted when the guest resets the virtio_net driver.
+# The reset can be the result of either unloading the driver or a reboot.
+#
+# @device: Indicates the virtio_net device.
+#
+# @path: Indicates the device path.
+#
+# Since: 3.0
+#
+# Example:
+#
+# <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
+#     "event": "FAILOVER_UNPLUG_PRIMARY",
+#     "data": {"device": "net0", "path": "/machine/peripheral/net0/virtio-backend"} }
+#
+##
+{ 'event': 'FAILOVER_UNPLUG_PRIMARY',
+  'data': {'*device': 'str', 'path': 'str'} }
