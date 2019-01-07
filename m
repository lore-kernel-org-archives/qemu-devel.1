Received: from eggs.gnu.org ([209.51.188.92]:52185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1ggZ7c-000798-B1
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1ggZ7Y-00037H-3y
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:55:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1ggZ7P-0002mv-UM
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:55:21 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Mon,  7 Jan 2019 12:54:47 -0500
Message-Id: <1546883690-17798-3-git-send-email-venu.busireddy@oracle.com>
In-Reply-To: <1546883690-17798-1-git-send-email-venu.busireddy@oracle.com>
References: <1546883690-17798-1-git-send-email-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH v2 2/5] virtio_net: Add support for "Data Path
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

Added a new event, FAILOVER_STANDBY_CHANGED, which is emitted whenever
the status of the virtio_net driver in the guest changes (either the
guest successfully loads the driver after the F_STANDBY feature bit
is negotiated, or the guest unloads the driver or reboots). Management
stack can use this event to determine when to plug/unplug the VF device
to/from the guest.

Also, the Virtual Functions will be automatically removed from the guest
if the guest is rebooted. To properly identify the VFIO devices that
must be removed, a new property named "failover-primary" is added to
the vfio-pci devices. Only the vfio-pci devices that have this property
enabled are removed from the guest upon reboot.

Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hw/acpi/pcihp.c      | 27 +++++++++++++++++++++++++++
 hw/net/virtio-net.c  | 24 ++++++++++++++++++++++++
 hw/vfio/pci.c        |  3 +++
 hw/vfio/pci.h        |  1 +
 include/hw/pci/pci.h |  1 +
 qapi/net.json        | 28 ++++++++++++++++++++++++++++
 6 files changed, 84 insertions(+)

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
index 411f8fb..7b1bcde 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -248,6 +248,29 @@ static void virtio_net_drop_tx_queue_data(VirtIODevice *vdev, VirtQueue *vq)
     }
 }
 
+static void virtio_net_failover_notify_event(VirtIONet *n, uint8_t status)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    if (virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_STANDBY)) {
+        const char *ncn = n->netclient_name;
+        gchar *path = object_get_canonical_path(OBJECT(n->qdev));
+        /*
+         * Emit FAILOVER_STANDBY_CHANGED event with enabled=true
+         *   when the status transitions from 0 to VIRTIO_CONFIG_S_DRIVER_OK
+         * Emit FAILOVER_STANDBY_CHANGED event with enabled=false
+         *   when the status transitions from VIRTIO_CONFIG_S_DRIVER_OK to 0
+         */
+        if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+                (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK))) {
+            qapi_event_send_failover_standby_changed(!!ncn, ncn, path, true);
+        } else if ((!(status & VIRTIO_CONFIG_S_DRIVER_OK)) &&
+                (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+            qapi_event_send_failover_standby_changed(!!ncn, ncn, path, false);
+        }
+    }
+}
+
 static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
@@ -256,6 +279,7 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
     uint8_t queue_status;
 
     virtio_net_vnet_endian_status(n, status);
+    virtio_net_failover_notify_event(n, status);
     virtio_net_vhost_status(n, status);
 
     for (i = 0; i < n->max_queues; i++) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5c7bd96..bd83b58 100644
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
+    DEFINE_PROP_BOOL("failover-primary", VFIOPCIDevice, failover_primary,
+                     false),
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
diff --git a/qapi/net.json b/qapi/net.json
index 8f99fd9..6a6d6fe 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -683,3 +683,31 @@
 ##
 { 'event': 'NIC_RX_FILTER_CHANGED',
   'data': { '*name': 'str', 'path': 'str' } }
+
+##
+# @FAILOVER_STANDBY_CHANGED:
+#
+# Emitted whenever the virtio_net driver status changes (either the guest
+# successfully loads the driver after the F_STANDBY feature bit is negotiated,
+# or the guest unloads the driver or reboots).
+#
+# @device: Indicates the virtio_net device.
+#
+# @path: Indicates the device path.
+#
+# @enabled: true if the virtio_net driver is loaded.
+#           false if the virtio_net driver is unloaded or the guest reboots.
+#
+# Since: 4.0
+#
+# Example:
+#
+# <- { "event": "FAILOVER_STANDBY_CHANGED",
+#      "data": { "device": "net0",
+#                "path": "/machine/peripheral/net0/virtio-backend",
+#                "enabled": "true" },
+#      "timestamp": { "seconds": 1432121972, "microseconds": 744001 } },
+#
+##
+{ 'event': 'FAILOVER_STANDBY_CHANGED',
+  'data': {'*device': 'str', 'path': 'str', 'enabled': 'bool'} }
