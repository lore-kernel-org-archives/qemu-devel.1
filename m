Received: from eggs.gnu.org ([2001:4830:134:3::10]:55250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6qX-0006Tw-7G
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6oG-0005JU-8h
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:23:33 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sat,  1 Sep 2018 16:22:52 +0200
Message-Id: <20180901142312.11662-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 00/20] vSMMUv3/pSMMUv3 2 stage VFIO integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alex.williamson@redhat.com, mst@redhat.com, cdall@kernel.org, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com

Up to now vSMMUv3 has not been integrated with VFIO. VFIO
integration requires to program the physical IOMMU consistently
with the guest mappings. However, as opposed to VTD, SMMUv3 has
no "Caching Mode" which allows easy trapping of guest mappings.
This means the vSMMUV3 cannot use the same VFIO integration as VTD.

However SMMUv3 has 2 translation stages. This was devised with
virtualization use case in mind where stage 1 is "owned" by the
guest whereas the host uses stage 2 for VM isolation.

This series sets up this nested translation stage. It only works
if there is one physical SMMUv3 used along with QEMU vSMMUv3 (in
other words, it does not work if there is a physical SMMUv2).

The series uses a new kernel user API [1], still under definition.

- We force the host to use stage 2 instead of stage 1, when we
  detect a vSMMUV3 is behind a VFIO device. For a VFIO device
  without any virtual IOMMU, we still use stage 1 as many existing
  SMMUs expect this behavior.
- We introduce new IOTLB "config" notifiers, requested to notify
  changes in the config of a given iommu memory region. So now
  we have notifiers for IOTLB changes and config changes.
- vSMMUv3 calls config notifiers when STE (Stream Table Entries)
  are updated by the guest.
- We implement a specific UNMAP notifier that conveys guest
  IOTLB invalidations to the host
- We implement a new MAP notifiers only used for MSI IOVAs so
  that the host can build a nested stage translation for MSI IOVAs
- As the legacy MAP notifier is not called anymore, we must make
  sure stage 2 mappings are set. This is achieved through another
  memory listener.

Physical SMMUs faults are not yet reported to the guest. This support
will be added in next releases.

Note: some iommu memory notifier rework related patches are close
to those previously published by Peter and Liu. I will be pleased to
add their Signed-off-by if they agree/wish.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v3.0.0_2stage-rfc-v1

Testing:
- For testing use my kernel branch
  https://github.com/eauger/linux/tree/v4.18-2stage-rfc++
  features [1] + small evolutions
- Tested on Qualcomm HW
- Known limitation:
  - currently sending an NH_ASID command instead of NH_VA
    upon guest NH_VA may cause important perf downgrade.
    Propagating NH_VA does not work at the moment.
  - no fault reporting to the guest

References:
- [1] [RFC 00/13] SMMUv3 Nested Stage Setup
  https://www.spinics.net/lists/kvm-arm/msg32525.html


Eric Auger (20):
  hw/arm/smmu-common: Fix the name of the iommu memory regions
  update-linux-headers: Import iommu.h
  linux-headers: Partial header update
  memory: add IOMMU_ATTR_VFIO_NESTED IOMMU memory region attribute
  hw/arm/smmuv3: Implement get_attr API to report IOMMU_ATTR_VFIO_NESTED
  hw/vfio/common: Refactor container initialization
  hw/vfio/common: Force nested if iommu requires it
  memory: Introduce IOMMUIOLTBNotifier
  memory: rename memory_region notify_iommu, notify_one
  memory: Add IOMMUConfigNotifier
  hw/arm/smmuv3: Store s1ctrptr in translation config data
  hw/arm/smmuv3: Implement dummy replay
  hw/arm/smmuv3: Notify on config changes
  hw/vfio/common: Introduce vfio_alloc_guest_iommu helper
  hw/vfio/common: Introduce vfio_dma_(un)map_ram_section helpers
  hw/vfio/common: Register specific nested mode notifiers and
    memory_listener
  hw/vfio/common: Register MAP notifier for MSI binding
  target/arm/kvm: Notifies IOMMU on MSI stage 1 binding
  vfio/pci: Always set up MSI route before enabling vectors
  hw/arm/smmuv3: Remove warning about unsupported MAP notifiers

 exec.c                          |  12 +-
 hw/arm/smmu-common.c            |  12 +-
 hw/arm/smmuv3.c                 | 100 ++++--
 hw/i386/intel_iommu.c           |  16 +-
 hw/misc/tz-mpc.c                |   8 +-
 hw/ppc/spapr_iommu.c            |   2 +-
 hw/s390x/s390-pci-inst.c        |   4 +-
 hw/vfio/common.c                | 547 +++++++++++++++++++++++---------
 hw/vfio/pci.c                   |   1 +
 hw/vfio/trace-events            |   4 +-
 hw/virtio/vhost.c               |  12 +-
 include/exec/memory.h           |  98 ++++--
 include/hw/arm/smmu-common.h    |   1 +
 linux-headers/linux/iommu.h     | 157 +++++++++
 linux-headers/linux/vfio.h      |  28 +-
 memory.c                        |  52 ++-
 scripts/update-linux-headers.sh |   2 +-
 target/arm/kvm.c                |  46 ++-
 18 files changed, 818 insertions(+), 284 deletions(-)
 create mode 100644 linux-headers/linux/iommu.h

-- 
2.17.1
