Received: from eggs.gnu.org ([2001:4830:134:3::10]:44364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecXzN-0004GU-6E
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecXzL-00068J-Pj
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:49:53 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 19 Jan 2018 14:48:53 +0000
Message-Id: <1516373355-305-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v5 00/22] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

This series implements the virtio-iommu device.

This v5 is an upgrade to v0.5 spec [1].

Compared to v4:
- event queue and fault reporting
- we now return the IOAPIC MSI region if the virtio-iommu is instantiated
  in a PC machine.
- we bypass transactions on MSI HW region and fault on reserved ones.
- We support ACPI boot with mach-virt (based on IORT proposal)
- We moved to the new driver naming conventions
- simplified mach-virt instantiation
- worked around the disappearing of pci_find_primary_bus

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v2.11.0-virtio-iommu-v5

References:
[1] [RFC] virtio-iommu version 0.5
git://linux-arm.org/virtio-iommu.git viommu/v0.5

[2] guest branch featuring the virtio-iommu driver v0.5
git://linux-arm.org/linux-jpb.git virtio-iommu/v0.5.1

Testing:
- tested with guest using virtio-pci-net and virtio-blk-pci
  (,vhost=off,iommu_platform,disable-modern=off,disable-legacy=on)
- virtio-blk-pci uses irqfd: with GICv3, use
  "target/arm/kvm: Translate the MSI doorbell in kvm_arch_fixup_msi_route"
  available on my branch
- VFIO support will be brought by a separate series
- on x86 is hacked guest kernel (available on demand)

History:
v4 -> v5:
- new functionalities reported above + below fixes:
- in virtio_iommu_translate, check the dev->as is not NULL
- initialize as->device_list in virtio_iommu_get_as
- initialize bufstate.error to false in virtio_iommu_probe

v3-> v4:
- see above

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


Eric Auger (22):
  machine: Add a get_primary_pci_bus callback
  hw/arm/virt: Implement get_primary_pci_bus
  pc: Implement get_primary_pci_bus
  update-linux-headers: Import virtio_iommu.h
  linux-headers: Partial update for virtio-iommu
  virtio-iommu: Add skeleton
  virtio-iommu: Decode the command payload
  virtio-iommu: Add the iommu regions
  virtio-iommu: Register attached endpoints
  virtio-iommu: Implement attach/detach command
  virtio-iommu: Implement map/unmap
  virtio-iommu: Implement translate
  virtio-iommu: Implement probe request
  virtio-iommu: Add an msi_bypass property
  virtio-iommu: Implement fault reporting
  virtio_iommu: Handle reserved regions in translation process
  hw/arm/virt: Add virtio-iommu to the virt board
  hw/arm/virt-acpi-build: Add virtio-iommu node in IORT table
  memory.h: Add set_page_size_mask IOMMUMemoryRegion callback
  hw/vfio/common: Set the IOMMUMemoryRegion supported page sizes
  virtio-iommu: Implement set_page_size_mask
  hw/vfio/common: Do not print error when viommu translates into an mmio
    region

 hw/arm/virt-acpi-build.c                      |   55 +-
 hw/arm/virt.c                                 |   99 ++-
 hw/i386/pc.c                                  |    8 +
 hw/vfio/common.c                              |    7 +-
 hw/virtio/Makefile.objs                       |    1 +
 hw/virtio/trace-events                        |   25 +
 hw/virtio/virtio-iommu.c                      | 1063 +++++++++++++++++++++++++
 include/exec/memory.h                         |    4 +
 include/hw/acpi/acpi-defs.h                   |   21 +-
 include/hw/arm/virt.h                         |   19 +
 include/hw/boards.h                           |    3 +
 include/hw/vfio/vfio-common.h                 |    1 +
 include/hw/virtio/virtio-iommu.h              |   63 ++
 include/standard-headers/linux/virtio_ids.h   |    1 +
 include/standard-headers/linux/virtio_iommu.h |  195 +++++
 linux-headers/linux/virtio_iommu.h            |    1 +
 scripts/update-linux-headers.sh               |    3 +
 17 files changed, 1552 insertions(+), 17 deletions(-)
 create mode 100644 hw/virtio/virtio-iommu.c
 create mode 100644 include/hw/virtio/virtio-iommu.h
 create mode 100644 include/standard-headers/linux/virtio_iommu.h
 create mode 100644 linux-headers/linux/virtio_iommu.h

-- 
1.9.1
