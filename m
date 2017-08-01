Received: from eggs.gnu.org ([2001:4830:134:3::10]:38112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dcTZM-0007JJ-JZ
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dcTZH-0001Ce-MJ
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:34:28 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue,  1 Aug 2017 11:33:06 +0200
Message-Id: <1501579994-3320-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com

This series implements the virtio-iommu device.

This v3 mostly is a rebase on top of v2.10-rc0 that uses
IOMMUMmeoryRegion plus some small fixes.

This is a proof of concept based on the virtio-iommu specification
written by Jean-Philippe Brucker [1].

The device gets instantiated using the "-device virtio-iommu-device"
option. It currently works with ARM virt machine only, as the machine
must handle the dt binding between the virtio-mmio "iommu" node and
the PCI host bridge node.

ACPI booting is not yet supported.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v2.10.0-rc0-virtio-iommu-rfcv3

References:
[1] [RFC 0/3] virtio-iommu: a paravirtualized IOMMU,
[2] [RFC PATCH linux] iommu: Add virtio-iommu driver
[3] [RFC PATCH kvmtool 00/15] Add virtio-iommu

Testing:
- >= 4.12 guest kernel + virtio-iommu driver [2]
- guest using a virtio-net-pci device:
  ,vhost=off,iommu_platform,disable-modern=off,disable-legacy=on

History:
v2 -> v3:
- rebase on top of 2.10-rc0 and especially
  [PATCH qemu v9 0/2] memory/iommu: QOM'fy IOMMU MemoryRegion
- add mutex init
- fix as->mappings deletion using g_tree_ref/unref
- when a dev is attached whereas it is already attached to
  another address space, first detach it
- fix some error values
- page_sizes = TARGET_PAGE_MASK;
- I haven't changed the unmap() semantics yet, waiting for the
  next virtio-iommu spec revision.

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
 hw/virtio/virtio-iommu.c                      | 670 ++++++++++++++++++++++++++
 include/hw/arm/virt.h                         |   5 +
 include/hw/virtio/virtio-iommu.h              |  61 +++
 include/standard-headers/linux/virtio_ids.h   |   1 +
 include/standard-headers/linux/virtio_iommu.h | 142 ++++++
 linux-headers/linux/virtio_iommu.h            |   1 +
 scripts/update-linux-headers.sh               |   3 +
 10 files changed, 1005 insertions(+), 9 deletions(-)
 create mode 100644 hw/virtio/virtio-iommu.c
 create mode 100644 include/hw/virtio/virtio-iommu.h
 create mode 100644 include/standard-headers/linux/virtio_iommu.h
 create mode 100644 linux-headers/linux/virtio_iommu.h

-- 
2.5.5
