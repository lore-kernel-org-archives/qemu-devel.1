Received: from eggs.gnu.org ([2001:4830:134:3::10]:45983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eSH2a-00063O-Up
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 01:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eSH2W-0007M3-26
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 01:42:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:46019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1eSH2V-0007Ia-PE
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 01:42:39 -0500
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri, 22 Dec 2017 14:41:48 +0800
Message-Id: <20171222064151.29266-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [RFC 0/3] Extend vhost-user to support VFIO based
 accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com

This RFC patch set does some small extensions to vhost-user protocol
to support VFIO based accelerators, and makes it possible to get the
similar performance of VFIO passthru while keeping the virtio device
emulation in QEMU.

When we have virtio ring compatible devices, it's possible to setup
the device (DMA mapping, PCI config, etc) based on the existing info
(memory-table, features, vring info, etc) which is available on the
vhost-backend (e.g. DPDK vhost library). Then, we will be able to
use such devices to accelerate the emulated device for the VM. And
we call it vDPA: vhost DataPath Acceleration. The key difference
between VFIO passthru and vDPA is that, in vDPA only the data path
(e.g. ring, notify and queue interrupt) is pass-throughed, the device
control path (e.g. PCI configuration space and MMIO regions) is still
defined and emulated by QEMU.

The benefits of keeping virtio device emulation in QEMU compared
with virtio device VFIO passthru include (but not limit to):

- consistent device interface from guest OS;
- max flexibility on control path and hardware design;
- leveraging the existing virtio live-migration framework;

But the critical issue in vDPA is that the data path performance is
relatively low and some host threads are needed for the data path,
because some necessary mechanisms are missing to support:

1) guest driver notifies the device directly;
2) device interrupts the guest directly;

So this patch set does some small extensions to vhost-user protocol
to make both of them possible. It leverages the same mechanisms (e.g.
EPT and Posted-Interrupt on Intel platform) as the VFIO passthru to
achieve the data path pass through.

A new protocol feature bit is added to negotiate the accelerator feature
support. Two new slave message types are added to enable the notify and
interrupt passthru for each queue. From the view of vhost-user protocol
design, it's very flexible. The passthru can be enabled/disabled for
each queue individually, and it's possible to accelerate each queue by
different devices. More design and implementation details can be found
from the last patch.

There are some rough edges in this patch set (so this is a RFC patch
set for now), but it's never too early to hear the thoughts from the
community! So any comments and suggestions would be really appreciated!

Tiwei Bie (3):
  vhost-user: support receiving file descriptors in slave_read
  vhost-user: introduce shared vhost-user state
  vhost-user: add VFIO based accelerators support

 docs/interop/vhost-user.txt     |  57 ++++++
 hw/scsi/vhost-user-scsi.c       |   6 +-
 hw/vfio/common.c                |   2 +-
 hw/virtio/vhost-user.c          | 430 +++++++++++++++++++++++++++++++++++++++-
 hw/virtio/vhost.c               |   3 +-
 hw/virtio/virtio-pci.c          |   8 -
 hw/virtio/virtio-pci.h          |   8 +
 include/hw/vfio/vfio.h          |   2 +
 include/hw/virtio/vhost-user.h  |  43 ++++
 include/hw/virtio/virtio-scsi.h |   6 +-
 net/vhost-user.c                |  30 +--
 11 files changed, 561 insertions(+), 34 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user.h

-- 
2.13.3
