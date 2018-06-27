Received: from eggs.gnu.org ([2001:4830:134:3::10]:35777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fY1Su-0006eP-HV
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fY1Sr-00061g-7A
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:49:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fY1Sq-0005wm-Vv
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:49:53 -0400
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Tue, 26 Jun 2018 22:49:30 -0500
Message-Id: <20180627034935.20276-1-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH v2 0/4] Use of unique identifier for pairing
 virtio and passthrough devices...
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

The patch set "Enable virtio_net to act as a standby for a passthru
device" [1] deals with live migration of guests that use passthrough
devices. However, that scheme uses the MAC address for pairing
the virtio device and the passthrough device. The thread "netvsc:
refactor notifier/event handling code to use the failover framework"
[2] discusses an alternate mechanism, such as using an UUID, for pairing
the devices. Based on that discussion, proposals "Add "Group Identifier"
to virtio PCI capabilities." [3] and "RFC: Use of bridge devices to
store pairing information..." [4] were made.

The current patch set includes all the feedback received for proposals [3]
and [4]. For the sake of completeness, patch for the virtio specification
is also included here. Following is the updated proposal.

1. Extend the virtio specification to include a new virtio PCI capability
   "VIRTIO_PCI_CAP_GROUP_ID_CFG".

2. Enhance the QEMU CLI to include a "uuid" option to the virtio device.
   The "uuid" is a string in UUID format.

3. Enhance the QEMU CLI to include a "uuid" option to the bridge device.
   The "uuid" is a string in UUID format. Currently, PCIe bridge for
   the Q35 model is supported.

4. The operator creates a unique identifier string using 'uuidgen'.

5. When the virtio device is created, the operator uses the "uuid" option
   (for example, '-device virtio-net-pci,uuid="string"') and specifies
   the UUID created in step 4.

   QEMU stores the UUID in the virtio device's configuration space
   in the capability "VIRTIO_PCI_CAP_GROUP_ID_CFG".

6. When assigning a PCI device to the guest in passthrough mode, the
   operator first creates a bridge using the "uuid" option (for example,
   '-device pcie-downstream,uuid="string"') to specify the UUID created
   in step 4, and then attaches the passthrough device to the bridge.

   QEMU stores the UUID in the configuration space of the bridge as
   Vendor-Specific capability (0x09). The "Vendor" here is not to be
   confused with a specific organization. Instead, the vendor of the
   bridge is QEMU. To avoid mixing up with other bridges, the bridge
   will be created with vendor ID 0x1b36 (PCI_VENDOR_ID_REDHAT) and
   device ID 0x000e (PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE) if the "uuid"
   option is specified. Otherwise, current defaults are used.

7. Patch 4 in patch series "Enable virtio_net to act as a standby for
   a passthru device" [1] needs to be modified to use the UUID values
   present in the bridge's configuration space and the virtio device's
   configuration space instead of the MAC address for pairing the devices.

Thanks!

Venu

[1] https://lists.oasis-open.org/archives/virtio-dev/201805/msg00156.html
[2] https://www.spinics.net/lists/netdev/msg499011.html
[3] https://lists.oasis-open.org/archives/virtio-dev/201805/msg00118.html
[4] https://lists.oasis-open.org/archives/virtio-dev/201805/msg00204.html

Changes in v2:
  - As Michael Tsirkin suggested, changed the virtio specification
    to restrict the group identifier to be a 16-byte field, presented
    entirely in the virtio device's configuration space.
  - As Michael Tsirkin suggested, instead of tweaking the ioh3420
    device with Red Hat vendor ID, create a new PCIe bridge device
    named "pcie-downstream" with Red Hat Vendor ID, and include the
    group identifier in this device.
  - Added a new patch to enhance the "pci-bridge" device to support
    the group identifier (for the i440FX model).

Venu Busireddy (4):
  Add a true or false option to the DEFINE_PROP_UUID macro.
  Add "Group Identifier" support to virtio devices.
  Add "Group Identifier" support to Red Hat PCI bridge.
  Add "Group Identifier" support to Red Hat PCI Express bridge.

 default-configs/arm-softmmu.mak             |   1 +
 default-configs/i386-softmmu.mak            |   1 +
 default-configs/x86_64-softmmu.mak          |   1 +
 hw/acpi/vmgenid.c                           |   2 +-
 hw/pci-bridge/Makefile.objs                 |   1 +
 hw/pci-bridge/pci_bridge_dev.c              |   8 +
 hw/pci-bridge/pcie_downstream.c             | 215 ++++++++++++++++++++
 hw/pci-bridge/pcie_downstream.h             |  10 +
 hw/pci/pci_bridge.c                         |  26 +++
 hw/virtio/virtio-pci.c                      |  15 ++
 hw/virtio/virtio-pci.h                      |   3 +-
 include/hw/pci/pci.h                        |   3 +
 include/hw/pci/pcie.h                       |   1 +
 include/hw/qdev-properties.h                |   4 +-
 include/standard-headers/linux/virtio_pci.h |   8 +
 15 files changed, 295 insertions(+), 4 deletions(-)
 create mode 100644 hw/pci-bridge/pcie_downstream.c
 create mode 100644 hw/pci-bridge/pcie_downstream.h
