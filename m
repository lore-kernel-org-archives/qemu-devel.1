Received: from eggs.gnu.org ([2001:4830:134:3::10]:58024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmlu5-0005nP-Ge
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmlu4-0006Sn-49
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:14:57 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  6 Aug 2018 22:14:28 +0200
Message-Id: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v7 00/16] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

This series rebases the virtio-iommu device on qemu 3.0.0-rc3
and implements the v0.7 virtio-iommu spec [1]. This is a basic
upgrade as the fate of the virtio mmio based solution is unclear.

It also fixes a bug when the end-points are not attached to the
root bus.

Important notice: the way the virtio-iommu is instantiated was
changed to fit the way the smmuv3 is, ie. using a virt machine
option: ",iommu=virtio".

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v3.0.0-rc3-virtio-iommu-v0.7

References:
[1] [RFC] virtio-iommu version 0.7
git://linux-arm.org/virtio-iommu.git viommu/v0.7

[2] guest branch featuring the virtio-iommu driver v0.7
https://github.com/eauger/linux/tree/v4.18-rc1-virtio-iommu-v0.7-acpi

Testing:
- tested with guest using virtio-net-pci
  (,vhost=off,iommu_platform,disable-modern=off,disable-legacy=on)
  and virtio-blk-pci
- VFIO/VHOST integration is not part of this series

History:

v6 -> v7:
- rebase on qemu 3.0.0-rc3
- minor update against v0.7
- fix issue with EP not on pci.0 and ACPI probing
- change the instantiation method

v5 -> v6:
- minor update against v0.6 spec
- fix g_hash_table_lookup in virtio_iommu_find_add_as
- replace some error_reports by qemu_log_mask(LOG_GUEST_ERROR, ...)

v4 -> v5:
- event queue and fault reporting
- we now return the IOAPIC MSI region if the virtio-iommu is instantiated
  in a PC machine.
- we bypass transactions on MSI HW region and fault on reserved ones.
- We support ACPI boot with mach-virt (based on IORT proposal)
- We moved to the new driver naming conventions
- simplified mach-virt instantiation
- worked around the disappearing of pci_find_primary_bus
- in virtio_iommu_translate, check the dev->as is not NULL
- initialize as->device_list in virtio_iommu_get_as
- initialize bufstate.error to false in virtio_iommu_probe

v3 -> v4:
- probe request support although no reserved region is returned at
  the moment
- unmap semantics less strict, as specified in v0.4
- device registration, attach/detach revisited
- split into smaller patches to ease review
- propose a way to inform the IOMMU mr about the page_size_mask
  of underlying HW IOMMU, if any
- remove warning associated with the translation of the MSI doorbell

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

Eric Auger (16):
  linux-headers: Partial update for virtio-iommu v0.7
  virtio-iommu: Add skeleton
  virtio-iommu: Decode the command payload
  virtio-iommu: Add the iommu regions
  virtio-iommu: Endpoint and domains structs and helpers
  virtio-iommu: Implement attach/detach command
  virtio-iommu: Implement map/unmap
  virtio-iommu: Implement translate
  virtio-iommu: Implement probe request
  virtio-iommu: Add an msi_bypass property
  virtio-iommu: Implement fault reporting
  virtio_iommu: Handle reserved regions in translation process
  qdev: export qbus_find_recursive
  hw/arm/virt: Add virtio-iommu to the virt board
  hw/arm/virt-acpi-build: Add virtio-iommu node in IORT table
  hw/arm/virt: Allow virtio-iommu instantiation

 hw/arm/virt-acpi-build.c                      |   39 +-
 hw/arm/virt.c                                 |   59 +-
 hw/virtio/Makefile.objs                       |    1 +
 hw/virtio/trace-events                        |   24 +
 hw/virtio/virtio-iommu.c                      | 1041 +++++++++++++++++++++++++
 include/hw/acpi/acpi-defs.h                   |   21 +-
 include/hw/arm/virt.h                         |    1 +
 include/hw/qdev-core.h                        |    3 +
 include/hw/virtio/virtio-iommu.h              |   64 ++
 include/standard-headers/linux/virtio_ids.h   |    1 +
 include/standard-headers/linux/virtio_iommu.h |  172 ++++
 linux-headers/linux/virtio_iommu.h            |    1 +
 qdev-monitor.c                                |    5 +-
 13 files changed, 1418 insertions(+), 14 deletions(-)
 create mode 100644 hw/virtio/virtio-iommu.c
 create mode 100644 include/hw/virtio/virtio-iommu.h
 create mode 100644 include/standard-headers/linux/virtio_iommu.h
 create mode 100644 linux-headers/linux/virtio_iommu.h

-- 
2.5.5
