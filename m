Received: from eggs.gnu.org ([2001:4830:134:3::10]:47260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fp2-0003Ef-Mc
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fox-0003nZ-PR
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:34:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3fox-0003mr-HQ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:34:43 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 27 Apr 2017 17:34:12 +0800
Message-Id: <1493285660-4470-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/8] IOMMU: introduce common IOMMUObject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

>From time to time, I was always thinking whether we should have a
IOMMU object in common, not depending on platform (x86/ppc/...), or
bus (PCI/...). Virt-svm is a case that may use it now - it needs to
register some notifiers so that when some event triggered the callback
can be invoked. However current MemoryRegion IOMMU notifiers do not
suite well with that purpose, since the notifiers are mostly binded to
memory regions and tailored to IOTLB notifications, while for virt-svm
it should be listening to one IOMMU device, rather than a specific
memory region.

This series tried to do several things:

- renaming old "iommu notifiers" into "iotlb notifiers", to avoid
  confusion of what it is used for

- introduce a way to fetch an IOMMU object from a device DMA address
  space (for x86, it should be a pci device)

- introduce a common IOMMU object, along with a similar notifier
  mechanism for it

There is a use-case example in the last patch to show how to use it,
on how to modify customized IOMMU device to have such a common object,
and on how to use the notifiers (merely the same as old one).

If with luck, this series can be a pre-requisite for the following
patchset:

  [RFC PATCH 00/20] Qemu: Extend intel_iommu emulator to support
  Shared Virtual Memory

But before that, looking forward to any of your comments.

Test done: compile test only.

Please kindly review. Thanks.

Peter Xu (8):
  memory: rename IOMMU_NOTIFIER_*
  memory: rename IOMMUNotifier
  memory: rename iommu_notifier_init()
  memory: rename *_notify_iommu*
  memory: rename *iommu_notifier*
  memory: introduce AddressSpaceOps
  intel_iommu: provide AddressSpaceOps.iommu_get()
  iommu: introduce hw/core/iommu

 hw/core/Makefile.objs         |  1 +
 hw/core/iommu.c               | 61 +++++++++++++++++++++++++++++
 hw/i386/amd_iommu.c           |  6 +--
 hw/i386/intel_iommu.c         | 47 +++++++++++++---------
 hw/ppc/spapr_iommu.c          | 10 ++---
 hw/s390x/s390-pci-inst.c      |  2 +-
 hw/vfio/common.c              | 16 ++++----
 hw/virtio/vhost.c             | 14 +++----
 include/exec/memory.h         | 91 +++++++++++++++++++++++++++----------------
 include/hw/core/iommu.h       | 72 ++++++++++++++++++++++++++++++++++
 include/hw/i386/intel_iommu.h | 10 +++--
 include/hw/vfio/vfio-common.h |  2 +-
 include/hw/virtio/vhost.h     |  4 +-
 memory.c                      | 54 ++++++++++++++-----------
 14 files changed, 283 insertions(+), 107 deletions(-)
 create mode 100644 hw/core/iommu.c
 create mode 100644 include/hw/core/iommu.h

-- 
2.7.4
