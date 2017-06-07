Received: from eggs.gnu.org ([2001:4830:134:3::10]:50406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dIdP1-0005sU-Rf
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dIdP0-0007ye-SU
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:01:47 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed,  7 Jun 2017 18:01:19 +0200
Message-Id: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, robin.murphy@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com

This series implements the virtio-iommu device. This is a proof
of concept based on the virtio-iommu specification written by
Jean-Philippe Brucker [1]. This was tested with a guest using
the virtio-iommu driver [2] and exposed with a virtio-net-pci
using dma ops.

The device gets instantiated using the "-device virtio-iommu-device"
option. It currently works with ARM virt machine only as the machine
must handle the dt binding between the virtio-mmio "iommu" node and
the PCI host bridge node. ACPI booting is not yet supported.

This should allow to start some benchmarking activities against
pure emulated IOMMU (especially ARM SMMU).

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/virtio-iommu-rfcv2

References:
[1] [RFC 0/3] virtio-iommu: a paravirtualized IOMMU,
[2] [RFC PATCH linux] iommu: Add virtio-iommu driver
[3] [RFC PATCH kvmtool 00/15] Add virtio-iommu

History:
v1 -> v2:
- fix redifinition of viommu_as typedef

Eric Auger (8):
  update-linux-headers: import virtio_iommu.h
  linux-headers: Update for virtio-iommu
  virtio_iommu: add skeleton
  virtio-iommu: Decode the command payload
  virtio_iommu: Add the iommu regions
  virtio-iommu: Implement the translation and commands
  hw/arm/virt: Add 2.10 machine type
  hw/arm/virt: Add virtio-iommu the virt board

 hw/arm/virt.c                                 | 116 ++++-
 hw/virtio/Makefile.objs                       |   1 +
 hw/virtio/trace-events                        |  14 +
 hw/virtio/virtio-iommu.c                      | 623 ++++++++++++++++++++++++++
 include/hw/arm/virt.h                         |   5 +
 include/hw/virtio/virtio-iommu.h              |  60 +++
 include/standard-headers/linux/virtio_ids.h   |   1 +
 include/standard-headers/linux/virtio_iommu.h | 142 ++++++
 linux-headers/linux/virtio_iommu.h            |   1 +
 scripts/update-linux-headers.sh               |   3 +
 10 files changed, 957 insertions(+), 9 deletions(-)
 create mode 100644 hw/virtio/virtio-iommu.c
 create mode 100644 include/hw/virtio/virtio-iommu.h
 create mode 100644 include/standard-headers/linux/virtio_iommu.h
 create mode 100644 linux-headers/linux/virtio_iommu.h

-- 
2.5.5
