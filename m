Received: from eggs.gnu.org ([2001:4830:134:3::10]:48200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eI9zB-0003w0-5k
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eI9z6-00008Y-KW
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:26004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eI9z6-00006q-At
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:20 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Fri, 24 Nov 2017 16:52:33 +0800
Message-Id: <1511513560-28611-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 0/7] Introduce new iommu notifier framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, tianyu.lan@intel.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patchset is a follow-up of Peter Xu's patchset as the link below.
In brief, Peter's patchset is to introduce a common IOMMU object which
is an abstract of IOMMU in Qemu. And based on it, an iommu object based
notifier framework is introduced. And also AddressSpaceOps is added to
provide methods like getting IOMMUObject behind an AddressSpace. It could
also be used to detect the exposure of vIOMMU to guest.

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
are using it for MAP/UNMAP. However, it is not well suited for the new
notifiers required by virt-SVM. Reasons are as below:
- virt-SVM works along with PT = 1
- if PT = 1 IOMMU MR are disabled so MR notifier are not registered
- new notifiers do not fit nicely in this framework as they need to be
  registered even if PT = 1
- need a new framework to attach the new notifiers
- Additional background can be got from:
  https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04931.html

So a new iommu notifier framework is needed. And IOMMUObject is
introduced to stand for the abstract of IOMMU translation unit or so.

Based on Peter's patch, I did some clean up and fulfill the notifier
framework based on IOMMUObject and also provide an example of the newly
introduced notifier framework. The notifier framework introduced here
is going to be used in my virt-SVM patchset.

For virt-SVM design details, you may refer to virt-SVM RFC patchset.
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04925.html


Patch Overview:
* 1 - 2: rename existing naming related to the IOMMU Notifier framework
* 3: introduce IOMMUObject
* 4: introduce AddressSpaceOps for getting IOMMUObject
* 5: provide VT-d AddressSpaceOps instance
* 6: fulfill the new iommu notifier framework
* 7: an example, show the usage of the new iommu notifier framework

[v1->v2 changes]
* Rephrase the cover letter
* Re-sort the sequence of the patches
* Split the patch to introduce IOMMUObject and AddressSpaceOps
* Address two missed list init spotted by Auger Eric

Liu, Yi L (3):
  vfio: rename GuestIOMMU to be GuestIOMMUMR
  vfio/pci: add notify framework based on IOMMUObject
  vfio/pci: register vfio_iommu_bind_pasidtbl_notify notifier

Peter Xu (4):
  memory: rename existing iommu notifier to be iommu mr notifier
  hw/core: introduce IOMMUObject
  memory: introduce AddressSpaceOps
  intel_iommu: provide AddressSpaceOps.iommu_get instance

 hw/core/Makefile.objs         |  1 +
 hw/core/iommu.c               | 64 +++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.c           |  6 ++--
 hw/i386/intel_iommu.c         | 42 +++++++++++++----------
 hw/ppc/spapr_iommu.c          |  8 ++---
 hw/s390x/s390-pci-bus.c       |  2 +-
 hw/vfio/common.c              | 26 ++++++++-------
 hw/vfio/pci.c                 | 53 ++++++++++++++++++++++++++++-
 hw/virtio/vhost.c             | 10 +++---
 include/exec/memory.h         | 77 ++++++++++++++++++++++++++++---------------
 include/hw/core/iommu.h       | 76 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/intel_iommu.h | 10 +++---
 include/hw/vfio/vfio-common.h | 17 +++++++---
 include/hw/virtio/vhost.h     |  4 +--
 memory.c                      | 47 +++++++++++++++-----------
 15 files changed, 343 insertions(+), 100 deletions(-)
 create mode 100644 hw/core/iommu.c
 create mode 100644 include/hw/core/iommu.h

-- 
1.9.1
