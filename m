Received: from eggs.gnu.org ([2001:4830:134:3::10]:41268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eAavW-0007kY-Ci
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eAavS-0004Ng-CO
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:18:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:37808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eAavS-0004Mu-30
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:18:18 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Fri,  3 Nov 2017 20:01:50 +0800
Message-Id: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RESEND PATCH 0/6] Introduce new iommu notifier
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com
Cc: tianyu.lan@intel.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

Hi,

Resend it due to the build error reported by the auto-test. No functional
change compared with the previous sending.

This patchset is a follow-up of Peter Xu's patchset as the link below.
In brief, Peter's patchset is to introduce a common IOMMU object which
is not depending on platform (x86/ppc/...), or bus (PCI/...). And based
on it, a iommu object based notifier framework is introduced and also
AddressSpaceOps is added to provide methods like getting IOMMUObject
behind an AddressSpace. It could be used to detect the exposure of
vIOMMU.

https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05360.html

Here let me try to address why we need such change.

I'm working on virt-SVM enabling for passthru devices on Intel platform.
This work is to extend the existing intel iommu emulator in Qemu. Among
the extensions, there are two requirements which ae related to the topic
we are talking here.

* intel iommu emulator needs to propagate a guest pasid table pointer
  to host through VFIO. So that host intel iommu driver could set it to
  its ctx table. With guest pasid table pointer set, host would be able
  to get guest CR3 table after guest calls intel_svm_bind_mm(). Then HW
  iommu could do nested translation to get GVA->GPA GPA->HPA. Thus enables
  Shared Virtual Memory in guest.

* intel iommu emulator needs to propagate guest's iotlb(1st level cache)
  flush to host through VFIO.

Since the two requirements need to talk with VFIO, so notifiers are
needed. Meanwhile, the notifiers should be registered as long as there
is vIOMMU exposed to guest.

Qemu has an existing notifier framework based on MemoryRegion. And we
are using it for MAP/UNMAP. However, we cannot use it here. Reason is
as below:

* IOMMU MemoryRegion notifiers depends on IOMMU MemoryRegion. If guest
  iommu driver configs to bypass the IOVA adress translation. The address
  space would be system ram address space. The MemoryRegion would be the
  RAM MemoryRegion. Details can be got in Peter's patch to allow dynamic
  switch of IOMMU region.
  https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg02690.html

* virt-SVM requires guest to config to bypass the IOVA address translation
  With such config, we can make sure host would have a GPA->HPA mapping,
  and meanwhile intel iommu emulator could propagate the guest CR3 table
  (GVA->GPA) to host. With nested translation, we are able to achieve
  GVA->GPA and then GPA->HPA translation. However, if so, the IOMMU
  MemoryRegion notifiers would not be registered. It means for virt-SVM,
  we need another notifier framework.

Based on Peter's patch, I did some clean up and fulfill the notifier
framework based on IOMMUObject and also provide an example of the newly
introduced notifier framework. The notifier framework introduced here
is going to be used in my virt-SVM patchset.

For virt-SVM design details, you may refer to svm RFC patch.
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04925.html

Liu, Yi L (3):
  vfio: rename GuestIOMMU to be GuestIOMMUMR
  vfio/pci: add notify framework based on IOMMUObject
  vfio/pci: register vfio_iommu_bind_pasidtbl_notify notifier

Peter Xu (3):
  memory: rename existing iommu notifier to be iommu mr notifier
  memory: introduce AddressSpaceOps and IOMMUObject
  intel_iommu: provide AddressSpaceOps.iommu_get instance

 hw/core/Makefile.objs         |  1 +
 hw/core/iommu.c               | 58 ++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.c           |  6 ++--
 hw/i386/intel_iommu.c         | 41 +++++++++++++----------
 hw/ppc/spapr_iommu.c          |  8 ++---
 hw/s390x/s390-pci-bus.c       |  2 +-
 hw/vfio/common.c              | 25 +++++++-------
 hw/vfio/pci.c                 | 53 ++++++++++++++++++++++++++++-
 hw/virtio/vhost.c             | 10 +++---
 include/exec/memory.h         | 77 ++++++++++++++++++++++++++++---------------
 include/hw/core/iommu.h       | 73 ++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/intel_iommu.h | 10 +++---
 include/hw/vfio/vfio-common.h | 16 ++++++---
 include/hw/virtio/vhost.h     |  4 +--
 memory.c                      | 47 +++++++++++++++-----------
 15 files changed, 331 insertions(+), 100 deletions(-)
 create mode 100644 hw/core/iommu.c
 create mode 100644 include/hw/core/iommu.h

-- 
1.9.1
