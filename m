Received: from eggs.gnu.org ([2001:4830:134:3::10]:53046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLnB-0005Rc-PZ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLn7-00007K-C5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:50:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:7359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1erLn7-00006Y-1r
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:50:25 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Thu,  1 Mar 2018 18:33:23 +0800
Message-Id: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 00/12] Introduce new iommu notifier
 framework for virt-SVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

This patchset is to introduce a notifier framework for virt-SVA.
You may find virt-SVA design details from the link below.

https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04925.html

SVA is short for Shared Virtual Addressing. This is also called Shared
Virtual Memory in previous patchsets. However, SVM is confusing as it
can also be short for Secure Virtual Machine. So this patchset use
Shared Virtual Addressing instead of Shared Virtual Memory. And it
would be applied in future (SVA)related patch series as well.

Qemu has an existing notifier framework based on MemoryRegion, which
are used for MAP/UNMAP. However, it is not well suited for virt-SVA.
Reasons are as below:
- virt-SVA works along with PT = 1
- if PT = 1 IOMMU MR are disabled so MR notifier are not registered
- new notifiers do not fit nicely in this framework as they need to be
  registered even if PT = 1
- need a new framework to attach the new notifiers
- Additional background can be got from:
  https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04931.html

So a new iommu notifier framework is needed. This patchset introduces
a notifier framework based on IOMMUSVAContext. IOMMUSVAContext is
introduced to be an abstract of virt-SVA operations in Qemu.

Patch Overview:
* 1 - 2: rename existing naming, the IOMMU MemoryRegion Notifier
         framework
* 3 - 4: introduce SVA notifier framework based on IOMMUSVAContext
* 5 - 7: introduce PCISVAOps and expose the SVA notfier framework
         through hw/pci layer
* 8 - 12: show the usage of SVA notifier in Intel vIOMMU emulator

[v2->v3 changes]
* Rephrase the cover letter
* Follow David's suggestion, take emulated SVA capable device
  into consideration
* renaming IOMMUObject to be IOMMUSVAContext
* Expose SVA nofitier registeration through hw/pci layer
* rename the file hw/core/iommu.c to be hw/core/pasid.c
         include/hw/core/iommu.h to be include/hw/core/pasid.h
* use SVA instead of SVM in patchset
* rename patchset title, previous is "Introduce new iommu notifier framework"

v2 link:
https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04553.html

[v1->v2 changes]
* Rephrase the cover letter
* Re-sort the sequence of the patches
* Split the patch to introduce IOMMUObject and AddressSpaceOps
* Address two missed list init spotted by Auger Eric

v1 link:
http://qemu-devel.nongnu.narkive.com/XhqBQ8wc/resend-patch-0-6-introduce-new-iommu-notifier-framework

Original patchset from Peter Xu can be found in the link below.

https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05360.html

Comments and suggestions are always welcomed, thanks.

Liu, Yi L (10):
  vfio: rename GuestIOMMU to be GuestIOMMUMR
  vfio/pci: add notify framework based on IOMMUSVAContext
  hw/pci: introduce PCISVAOps to PCIDevice
  vfio/pci: provide vfio_pci_sva_ops instance
  vfio/pci: register sva notifier
  hw/pci: introduce pci_device_notify_iommu()
  intel_iommu: record assigned devices in a list
  intel_iommu: bind guest pasid table to host
  intel_iommu: add framework for PASID AddressSpace management
  intel_iommu: bind device to PASID tagged AddressSpace

Peter Xu (2):
  memory: rename existing iommu notifier to be iommu mr notifier
  hw/core: introduce IOMMUSVAContext for virt-SVA

 hw/alpha/typhoon.c             |   2 +-
 hw/core/Makefile.objs          |   1 +
 hw/core/pasid.c                |  64 ++++++++++
 hw/hppa/dino.c                 |   2 +-
 hw/i386/amd_iommu.c            |   8 +-
 hw/i386/intel_iommu.c          | 272 +++++++++++++++++++++++++++++++++++++----
 hw/i386/intel_iommu_internal.h |  10 ++
 hw/pci-host/ppce500.c          |   2 +-
 hw/pci-host/prep.c             |   2 +-
 hw/pci-host/sabre.c            |   2 +-
 hw/pci/pci.c                   |  85 ++++++++++++-
 hw/ppc/spapr_iommu.c           |   8 +-
 hw/ppc/spapr_pci.c             |   2 +-
 hw/s390x/s390-pci-bus.c        |   6 +-
 hw/vfio/common.c               |  28 +++--
 hw/vfio/pci.c                  |  84 +++++++++++++
 hw/virtio/vhost.c              |  10 +-
 include/exec/memory.h          |  55 +++++----
 include/hw/core/pasid.h        | 110 +++++++++++++++++
 include/hw/i386/intel_iommu.h  |  43 ++++++-
 include/hw/pci/pci.h           |  33 ++++-
 include/hw/pci/pci_bus.h       |   1 +
 include/hw/vfio/vfio-common.h  |  19 ++-
 include/hw/virtio/vhost.h      |   4 +-
 memory.c                       |  37 +++---
 25 files changed, 774 insertions(+), 116 deletions(-)
 create mode 100644 hw/core/pasid.c
 create mode 100644 include/hw/core/pasid.h

-- 
1.9.1
