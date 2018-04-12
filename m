Received: from eggs.gnu.org ([2001:4830:134:3::10]:39049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f6dw3-0005j6-Ud
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f6dw0-0007Q3-Of
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:14:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:48812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f6dw0-0007PY-El
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:14:48 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 12 Apr 2018 23:12:26 +0800
Message-Id: <20180412151232.17506-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH v3 0/6] Extend vhost-user to support
 registering external host notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com

The original subject is: Extend vhost-user to support VFIO based accelerators

Update notes
============

Now, this patch set just focuses on adding the support for
registering memory region based host notifiers. With this
support, guest driver in the VM will be able to notify the
hardware device at the vhost backend directly.

It's one of the most important things in vDPA -- the host
notification offload. Because, normally, the hardware device
heavily depends on the notifications. Without this support,
there will be a lot of VM-Exit happen due to the notifications
from guest driver (it will drop the VM performance) and a
lot of CPU resources wasted to do the notification relay
(it will make the hardware offload less attractive, because
one important goal of hardware offload is to free the CPU
resources).

More backgrounds of this patch set can be found from the
cover letter of the previous versions:

RFC: http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg04844.html
v1:  http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg06028.html
v2:  http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg05009.html

v2 -> v3:
- A better implementation of the shared vhost-user state (MST);
- Use bus callback to add/delete subregions for notification (MST);
- Refine APIs' names which add/delete subregions for notification (MST);
- Refine the doc of the new vhost-user types and messages (MST);
- Separate host notification offload from the guest notification offload (MST);
- Drop the guest notification offload support from this patch;
- Add memory filter for vhost backend to filter the sections they can handle;

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
  vhost-user: add Net prefix to internal state structure
  vhost-user: introduce shared vhost-user state
  vhost-user: support receiving file descriptors in slave_read
  virtio: support setting memory region based host notifier
  vhost: allow backends to filter memory sections
  vhost-user: support registering external host notifiers

 backends/cryptodev-vhost-user.c     |  20 +++-
 docs/interop/vhost-user.txt         |  33 ++++++
 hw/block/vhost-user-blk.c           |  22 +++-
 hw/scsi/vhost-user-scsi.c           |  20 +++-
 hw/virtio/Makefile.objs             |   2 +-
 hw/virtio/vhost-stub.c              |  10 ++
 hw/virtio/vhost-user.c              | 206 ++++++++++++++++++++++++++++++++++--
 hw/virtio/vhost.c                   |   9 +-
 hw/virtio/virtio-pci.c              |  22 ++++
 hw/virtio/virtio.c                  |  13 +++
 include/hw/virtio/vhost-backend.h   |   4 +
 include/hw/virtio/vhost-user-blk.h  |   2 +
 include/hw/virtio/vhost-user-scsi.h |   2 +
 include/hw/virtio/vhost-user.h      |  28 +++++
 include/hw/virtio/virtio-bus.h      |   2 +
 include/hw/virtio/virtio.h          |   2 +
 net/vhost-user.c                    |  78 +++++++++-----
 17 files changed, 433 insertions(+), 42 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user.h

-- 
2.11.0
