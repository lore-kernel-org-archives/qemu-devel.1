Received: from eggs.gnu.org ([2001:4830:134:3::10]:55385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1gWOE5-0001GM-EQ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1gWOE2-0001h7-8u
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:16:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:39134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1gWOE1-0001fw-Vk
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:16:06 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Mon, 10 Dec 2018 11:15:45 -0500
Message-Id: <1544458548-5986-1-git-send-email-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH 0/3] Support for datapath switching during live
 migration
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

Sridhar Samudrala (1):
  virtio_net: Add VIRTIO_NET_F_STANDBY feature bit.

Venu Busireddy (1):
  virtio_net: Add support for "Data Path Switching" during Live Migration.

Si-Wei Liu (1):
  vfio-pci: Add FAILOVER_PRIMARY_CHANGED event to shorten downtime during failover

 hw/acpi/pcihp.c                | 27 ++++++++++++++++
 hw/net/virtio-net.c            | 25 +++++++++++++++
 hw/vfio/pci.c                  | 60 ++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h                  |  1 +
 include/hw/pci/pci.h           |  1 +
 include/hw/virtio/virtio-net.h |  4 +++
 qapi/net.json                  | 70 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 188 insertions(+)
