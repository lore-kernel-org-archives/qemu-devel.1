Received: from eggs.gnu.org ([2001:4830:134:3::10]:33229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eM4Ep-0001NX-Py
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eM4El-0007Jz-Qg
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:32277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eM4El-0007JF-Hy
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:39 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  5 Dec 2017 11:33:09 +0800
Message-Id: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 0/7] Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Cc: jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com, Wei Wang <wei.w.wang@intel.com>

Vhost-pci is a point-to-point based inter-VM communication solution. This
patch series implements the vhost-pci-net device setup and emulation. The
device is implemented as a virtio device, and it is set up via the
vhost-user protocol to get the neessary info (e.g the memory info of the
remote VM, vring info).

Currently, only the fundamental functions are implemented. More features,
such as MQ and live migration, will be updated in the future.

The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
http://dpdk.org/ml/archives/dev/2017-November/082615.html

v2->v3 changes:
1) static device creation: instead of creating and hot-plugging the
   device when receiving a vhost-user msg, the device is not created
   via the qemu booting command line.
2) remove vqs: rq and ctrlq are removed in this version.
    - receive vq: the receive vq is not needed anymore. The PMD directly
                  shares the remote txq and rxq - grab from remote txq to
                  receive packets, and put to rxq to send packets.
    - ctrlq: the ctrlq is replaced by the first 4KB metadata area of the
             device Bar-2.
3) simpler implementation: the entire implementation has been tailored
   from ~1800 LOC to ~850 LOC.

Wei Wang (7):
  vhost-user: share the vhost-user protocol related structures
  vhost-pci-net: add vhost-pci-net
  virtio/virtio-pci.c: add vhost-pci-net-pci
  vhost-pci-slave: add vhost-pci slave implementation
  vhost-user: VHOST_USER_SET_VHOST_PCI msg
  vhost-pci-slave: handle VHOST_USER_SET_VHOST_PCI
  virtio/vhost.c: vhost-pci needs remote gpa

 hw/net/Makefile.objs                           |   2 +-
 hw/net/vhost_net.c                             |  37 +++
 hw/net/vhost_pci_net.c                         | 137 +++++++++++
 hw/virtio/Makefile.objs                        |   1 +
 hw/virtio/vhost-pci-slave.c                    | 310 +++++++++++++++++++++++++
 hw/virtio/vhost-user.c                         | 117 ++--------
 hw/virtio/vhost.c                              |  63 +++--
 hw/virtio/virtio-pci.c                         |  55 +++++
 hw/virtio/virtio-pci.h                         |  14 ++
 include/hw/pci/pci.h                           |   1 +
 include/hw/virtio/vhost-backend.h              |   2 +
 include/hw/virtio/vhost-pci-net.h              |  42 ++++
 include/hw/virtio/vhost-pci-slave.h            |  12 +
 include/hw/virtio/vhost-user.h                 | 108 +++++++++
 include/hw/virtio/vhost.h                      |   2 +
 include/net/vhost_net.h                        |   2 +
 include/standard-headers/linux/vhost_pci_net.h |  65 ++++++
 include/standard-headers/linux/virtio_ids.h    |   1 +
 18 files changed, 851 insertions(+), 120 deletions(-)
 create mode 100644 hw/net/vhost_pci_net.c
 create mode 100644 hw/virtio/vhost-pci-slave.c
 create mode 100644 include/hw/virtio/vhost-pci-net.h
 create mode 100644 include/hw/virtio/vhost-pci-slave.h
 create mode 100644 include/hw/virtio/vhost-user.h
 create mode 100644 include/standard-headers/linux/vhost_pci_net.h

-- 
2.7.4
