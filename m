Received: from eggs.gnu.org ([2001:4830:134:3::10]:45501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gL4zt-0006aG-0f
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gL4zq-00008q-Uh
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:30:44 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  9 Nov 2018 12:29:39 +0100
Message-Id: <20181109112957.10067-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v8 00/18] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: kevin.tian@intel.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com

This series rebases the virtio-iommu device on qemu 3.1.0-rc0
and implements the v0.8 virtio-iommu spec [1]. Most importantly
the pci proxy for the virtio-iommu device is now available and
gets instantiated by the ARM virt machine when the ",iommu=virtio"
virt machine option is added.

The virtio-iommu-pci device always uses the 00:01.0 BDF and is
transparently instantiated by machvirt. The rationale is the
virtio-iommu-pci is not bound to be hotplugged and its BDF must
be known when building the guest device tree or ACPI tables.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v3.1.0-rc0-virtio-iommu-v0.8

References:
[1] [PATCH v3 0/7] Add virtio-iommu driver

[2] guest branch featuring the virtio-iommu driver v0.8 + ACPI
    integration not yet officially released by Jean.
https://github.com/eauger/linux/tree/v4.19-rc7-virtio-iommu-v0.8-iort

Testing:
- tested with guest using virtio-net-pci
  (,vhost=off,iommu_platform,disable-modern=off,disable-legacy=on)
  and virtio-blk-pci
- VFIO/VHOST integration is not part of this series
- When using the virtio-blk-pci, some EDK2 FW versions feature
  unmapped transactions and in that case the guest fails to boot.

History:

v7 -> v8:
- virtio-iommu-pci added
- virt instantiation modified
- DT and ACPI modified to exclude the iommu RID from the mapping
- VIRTIO_IOMMU_F_BYPASS, VIRTIO_F_VERSION_1 features exposed

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

Eric Auger (18):
  update-linux-headers: Import virtio_iommu.h
  linux-headers: Partial update for virtio-iommu v0.8
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
  virtio-iommu-pci: Add virtio iommu pci support
  hw/arm/virt: Add virtio-iommu to the virt board
  hw/arm/virt-acpi-build: Introduce fill_iort_idmap helper
  hw/arm/virt-acpi-build: Add virtio-iommu node in IORT table
  hw/arm/virt: Allow virtio-iommu instantiation

 hw/arm/virt-acpi-build.c                      |   90 +-
 hw/arm/virt.c                                 |   56 +-
 hw/virtio/Makefile.objs                       |    1 +
 hw/virtio/trace-events                        |   26 +
 hw/virtio/virtio-iommu.c                      | 1064 +++++++++++++++++
 hw/virtio/virtio-pci.c                        |   50 +
 hw/virtio/virtio-pci.h                        |   14 +
 include/hw/acpi/acpi-defs.h                   |   21 +-
 include/hw/pci/pci.h                          |    1 +
 include/hw/virtio/virtio-iommu.h              |   65 +
 include/standard-headers/linux/virtio_ids.h   |    1 +
 include/standard-headers/linux/virtio_iommu.h |  159 +++
 linux-headers/linux/virtio_iommu.h            |    1 +
 qdev-monitor.c                                |    1 +
 scripts/update-linux-headers.sh               |    3 +
 15 files changed, 1522 insertions(+), 31 deletions(-)
 create mode 100644 hw/virtio/virtio-iommu.c
 create mode 100644 include/hw/virtio/virtio-iommu.h
 create mode 100644 include/standard-headers/linux/virtio_iommu.h
 create mode 100644 linux-headers/linux/virtio_iommu.h

-- 
2.17.2
