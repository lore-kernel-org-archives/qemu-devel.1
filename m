Received: from eggs.gnu.org ([209.51.188.92]:39165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1ggdPG-0004gc-Az
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 17:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1ggdPF-0003w4-L9
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 17:30:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1ggdPF-0003rJ-Bk
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 17:30:01 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Mon,  7 Jan 2019 17:29:39 -0500
Message-Id: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH v3 0/5] Support for datapath switching during
 live migration
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

Implement the infrastructure to support datapath switching during live
migration involving SR-IOV devices.

1. This patch is based off on the current VIRTIO_NET_F_STANDBY feature
   bit and MAC address device pairing.

2. This set of events will be consumed by userspace management software
   to orchestrate all the hot plug and datapath switching activities.
   This scheme has the least QEMU modifications while allowing userspace
   software to build its own intelligence to control the whole process
   of SR-IOV live migration.

3. While the hidden device model (viz. coupled device model) is still
   being explored for automatic hot plugging (QEMU) and automatic datapath
   switching (host-kernel), this series provides a supplemental set
   of interfaces if management software wants to drive the SR-IOV live
   migration on its own. It should not conflict with the hidden device
   model but just offers simplicity of implementation.


Si-Wei Liu (2):
  vfio-pci: Add FAILOVER_PRIMARY_CHANGED event to shorten downtime during failover
  pci: query command extension to check the bus master enabling status of the failover-primary device

Sridhar Samudrala (1):
  virtio_net: Add VIRTIO_NET_F_STANDBY feature bit.

Venu Busireddy (2):
  virtio_net: Add support for "Data Path Switching" during Live Migration.
  virtio_net: Add a query command for FAILOVER_STANDBY_CHANGED event.

---
Changes in v3:
  Fix issues with coding style in patch 3/5.

Changes in v2:
  Added a query command for FAILOVER_STANDBY_CHANGED event.
  Added a query command for FAILOVER_PRIMARY_CHANGED event.

 hmp.c                          |   5 +++
 hw/acpi/pcihp.c                |  27 +++++++++++
 hw/net/virtio-net.c            |  42 +++++++++++++++++
 hw/pci/pci.c                   |   5 +++
 hw/vfio/pci.c                  |  60 +++++++++++++++++++++++++
 hw/vfio/pci.h                  |   1 +
 include/hw/pci/pci.h           |   1 +
 include/hw/virtio/virtio-net.h |   1 +
 include/net/net.h              |   2 +
 net/net.c                      |  61 +++++++++++++++++++++++++
 qapi/misc.json                 |   5 ++-
 qapi/net.json                  | 100 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 309 insertions(+), 1 deletion(-)
