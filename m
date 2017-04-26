Received: from eggs.gnu.org ([2001:4830:134:3::10]:51958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1d3KBK-0006r7-15
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1d3KBH-0004Jt-TT
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:28:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:33549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1d3KBH-0004JF-JL
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:28:19 -0400
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Wed, 26 Apr 2017 18:11:57 +0800
Message-Id: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
Subject: [Qemu-devel] [RFC PATCH 0/8] Shared Virtual Memory virtualization
 for VT-d
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com

Hi,

This patchset introduces SVM virtualization for intel_iommu in
IOMMU/VFIO. The total SVM virtualization for intel_iommu touched
Qemu/IOMMU/VFIO.

Another patchset would change the Qemu. It is "[RFC PATCH 0/20] Qemu:
Extend intel_iommu emulator to support Shared Virtual Memory"

In this patchset, it adds two new IOMMU APIs and their implementation
in intel_iommu driver. In VFIO, it adds two IOCTL cmd attached on
container->fd to propagate data from QEMU to kernel space.

[Patch Overview]
* 1 adds iommu API definition for binding guest PASID table
* 2 adds binding PASID table API implementation in VT-d iommu driver
* 3 adds iommu API definition to do IOMMU TLB invalidation from guest
* 4 adds IOMMU TLB invalidation implementation in VT-d iommu driver
* 5 adds VFIO IOCTL for propagating PASID table binding from guest
* 6 adds processing of pasid table binding in vfio_iommu_type1
* 7 adds VFIO IOCTL for propagating IOMMU TLB invalidation from guest
* 8 adds processing of IOMMU TLB invalidation in vfio_iommu_type1

Best Wishes,
Yi L


Jacob Pan (3):
  iommu: Introduce bind_pasid_table API function
  iommu/vt-d: add bind_pasid_table function
  iommu/vt-d: Add iommu do invalidate function

Liu, Yi L (5):
  iommu: Introduce iommu do invalidate API function
  VFIO: Add new IOTCL for PASID Table bind propagation
  VFIO: do pasid table binding
  VFIO: Add new IOCTL for IOMMU TLB invalidate propagation
  VFIO: do IOMMU TLB invalidation from guest

 drivers/iommu/intel-iommu.c     | 146 ++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c           |  32 +++++++++
 drivers/vfio/vfio_iommu_type1.c |  98 +++++++++++++++++++++++++++
 include/linux/dma_remapping.h   |   1 +
 include/linux/intel-iommu.h     |  11 +++
 include/linux/iommu.h           |  47 +++++++++++++
 include/uapi/linux/vfio.h       |  26 +++++++
 7 files changed, 361 insertions(+)

-- 
1.9.1
