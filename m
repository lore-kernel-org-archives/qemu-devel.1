Received: from eggs.gnu.org ([2001:4830:134:3::10]:60848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1exp2x-0002hR-E0
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1exp2u-0008ST-8q
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:17:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:42870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1exp2t-0008Rg-Se
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:17:28 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Mon, 19 Mar 2018 15:15:31 +0800
Message-Id: <20180319071537.28649-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/6] Extend vhost-user to support VFIO based
 accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com

This patch set does some small extensions to vhost-user protocol
to support VFIO based accelerators, and makes it possible to get
the similar performance of VFIO based PCI passthru while keeping
the virtio device emulation in QEMU.

How does accelerator accelerate vhost (data path)
=================================================

Any virtio ring compatible devices potentially can be used as the
vhost data path accelerators. We can setup the accelerator based
on the informations (e.g. memory table, features, ring info, etc)
available on the vhost backend. And accelerator will be able to use
the virtio ring provided by the virtio driver in the VM directly.
So the virtio driver in the VM can exchange e.g. network packets
with the accelerator directly via the virtio ring. That is to say,
we will be able to use the accelerator to accelerate the vhost
data path. We call it vDPA: vhost Data Path Acceleration.

Notice: Although the accelerator can talk with the virtio driver
in the VM via the virtio ring directly. The control path events
(e.g. device start/stop) in the VM will still be trapped and handled
by QEMU, and QEMU will deliver such events to the vhost backend
via standard vhost protocol.

Below link is an example showing how to setup a such environment
via nested VM. In this case, the virtio device in the outer VM is
the accelerator. It will be used to accelerate the virtio device
in the inner VM. In reality, we could use virtio ring compatible
hardware device as the accelerators.

http://dpdk.org/ml/archives/dev/2017-December/085044.html

In above example, it doesn't require any changes to QEMU, but
it has lower performance compared with the traditional VFIO
based PCI passthru. And that's the problem this patch set wants
to solve.

The performance issue of vDPA/vhost-user and solutions
======================================================

For vhost-user backend, the critical issue in vDPA is that the
data path performance is relatively low and some host threads are
needed for the data path, because some necessary mechanisms are
missing to support:

1) guest driver notifies the device directly;
2) device interrupts the guest directly;

So this patch set does some small extensions to the vhost-user
protocol to make both of them possible. It leverages the same
mechanisms (e.g. EPT and Posted-Interrupt on Intel platform) as
the PCI passthru.

A new protocol feature bit is added to negotiate the accelerator
feature support. Two new slave message types are added to control
the notify region and queue interrupt passthru for each queue.
>From the view of vhost-user protocol design, it's very flexible.
The passthru can be enabled/disabled for each queue individually,
and it's possible to accelerate each queue by different devices.
More design and implementation details can be found from the last
patch.

Difference between vDPA and PCI passthru
========================================

The key difference between PCI passthru and vDPA is that, in vDPA
only the data path of the device (e.g. DMA ring, notify region and
queue interrupt) is pass-throughed to the VM, the device control
path (e.g. PCI configuration space and MMIO regions) is still
defined and emulated by QEMU.

The benefits of keeping virtio device emulation in QEMU compared
with virtio device PCI passthru include (but not limit to):

- consistent device interface for guest OS in the VM;
- max flexibility on the hardware (i.e. the accelerators) design;
- leveraging the existing virtio live-migration framework;

Why extend vhost-user for vDPA
==============================

We have already implemented various virtual switches (e.g. OVS-DPDK)
based on vhost-user for VMs in the Cloud. They are purely software
running on CPU cores. When we have accelerators for such NFVi applications,
it's ideal if the applications could keep using the original interface
(i.e. vhost-user netdev) with QEMU, and infrastructure is able to decide
when and how to switch between CPU and accelerators within the interface.
And the switching (i.e. switch between CPU and accelerators) can be done
flexibly and quickly inside the applications.

More details about this can be found from the Cunming's discussions on
the RFC patch set.

Update notes
============

IOMMU feature bit check is removed in this version, because:

The IOMMU feature is negotiable, when an accelerator is used and
it doesn't support virtual IOMMU, its driver just won't provide
this feature bit when vhost library querying its features. And if
it supports the virtual IOMMU, its driver can provide this feature
bit. It's not reasonable to add this limitation in this patch set.

The previous links:
RFC: http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg04844.html
v1:  http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg06028.html

v1 -> v2:
- Add some explanations about why extend vhost-user in commit log (Paolo);
- Bug fix in slave_read() according to Stefan's fix in DPDK;
- Remove IOMMU feature check and related commit log;
- Some minor refinements;
- Rebase to the latest QEMU;

RFC -> v1:
- Add some details about how vDPA works in cover letter (Alexey)
- Add some details about the OVS offload use-case in cover letter (Jason)
- Move PCI specific stuffs out of vhost-user (Jason)
- Handle the virtual IOMMU case (Jason)
- Move VFIO group management code into vfio/common.c (Alex)
- Various refinements;
(approximately sorted by comment posting time)

Tiwei Bie (6):
  vhost-user: support receiving file descriptors in slave_read
  vhost-user: introduce shared vhost-user state
  virtio: support adding sub-regions for notify region
  vfio: support getting VFIOGroup from groupfd
  vfio: remove DPRINTF() definition from vfio-common.h
  vhost-user: add VFIO based accelerators support

 Makefile.target                 |   4 +
 docs/interop/vhost-user.txt     |  57 +++++++++
 hw/scsi/vhost-user-scsi.c       |   6 +-
 hw/vfio/common.c                |  97 +++++++++++++++-
 hw/virtio/vhost-user.c          | 248 +++++++++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-pci.c          |  48 ++++++++
 hw/virtio/virtio-pci.h          |   5 +
 hw/virtio/virtio.c              |  39 +++++++
 include/hw/vfio/vfio-common.h   |  11 +-
 include/hw/virtio/vhost-user.h  |  34 ++++++
 include/hw/virtio/virtio-scsi.h |   6 +-
 include/hw/virtio/virtio.h      |   5 +
 include/qemu/osdep.h            |   1 +
 net/vhost-user.c                |  30 ++---
 scripts/create_config           |   3 +
 15 files changed, 561 insertions(+), 33 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user.h

-- 
2.11.0
