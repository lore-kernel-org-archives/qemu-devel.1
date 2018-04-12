Received: from eggs.gnu.org ([2001:4830:134:3::10]:49180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f6WoX-0006Ss-L6
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 03:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f6WoV-00033s-U3
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 03:38:37 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 12 Apr 2018 09:37:51 +0200
Message-Id: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v11 00/17] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, prem.mallappa@gmail.com
Cc: alex.williamson@redhat.com, tn@semihalf.com, mst@redhat.com, cdall@kernel.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, linuc.decode@gmail.com, peterx@redhat.com, jintack@cs.columbia.edu

This series implements the emulation code for ARM SMMUv3.

SMMUv3 gets instantiated by adding ",iommu=smmuv3" to the virt
machine option.

Only stage 1 and AArch64 PTW are supported. [1 - 14] bring the core
emulation code. [15, 16] bring optimizations and 17 brings the vhost
integration.

Main changes since v10:
- fix irq_ctrl_ack read
- on PTW error and when the event is not recorded/set, don't output
  SMMU_EVT_OK anymore but return the ret value instead.
- Add the 3 last patches:
  - configuration cache, IOTLB emulation and vhost integration

Important Note:
I added the last 3 patches for consistency but I would be happy
if [1 - 14] could land upstream first, without waiting for the last
3 patch additional review cycles.

Also note that for vhost integration testing I needed a fix on
kernel side: [PATCH] vhost: Fix vhost_copy_to_user(). Otherwise
vhost-net stalls are observed.

Best Regards

Eric

This series can be found at:
v11: https://github.com/eauger/qemu/tree/v2.12.0-rc2-SMMU-v11
Previous version at:
v10: https://github.com/eauger/qemu/tree/v2.11.0-SMMU-v10

History:

v10 -> v11:
- one fix irq_ctrl_ack read
- addition of last 3 patches

v9 -> v10:
- see individual change logs

v8 -> v9:
- fix mingw compilation (qemu/log.h)
- put gpl v2 license on all files to respect initial license
- change proto of smmu_ptw* to clarify inputs/outputs and
  prepare for iotlb emulation
- fix hash table lookup
- cleanup access type handling during ptw
- cleanup reset infra (parent_reset)
- replace some inline functions by macros
- fix some CMD fields
- increment cmdq cons only after cmd execution
- replace some remaining error_report by qemu_log_mask

v7 -> v8:
Took into account Peter's comments:
- revisit queue data structures
- use registerfields.h and got rid of reg array
- use dma_memory_read for all descriptor fetches
- got rid of page table walk for an iova range and
  implemented standard page table walk for single IOVA
- revisit event data structure
- report events in many more situations and pass the event
  handle all along the decode and ptw phases
- fix gerror/gerron computations
- completely got rid of stage2 decoding
- use a machine option for instantiation
- get rid of VFIO integration
- get rid of VHOST integration (this will be added in a
- abort in case vhost/vfio notifiers get detected
  second step together with TLB emulation)
- Tested migration
- fixed TTBR index computation (issue reported by Tomasz)

v6 -> v7:
- DPDK testpmd now running on guest with 2 assigned VFs
- Changed the instantiation method: add the following option to
  the QEMU command line
  -device smmu # for virtio/vhost use cases
  -device smmu,caching-mode # for vfio use cases (based on [1])
- splitted the series into smaller patches to allow the review
- the VFIO integration based on "ltlbi-on-map" smmuv3 driver
  is isolated from the rest: last 2 patches, not for upstream.
  This is shipped for testing/bench until a better solution is found.
- Reworked permission flag checks and event generation

v5 -> v6:
- Rebase on 2.10 and IOMMUMemoryRegion
- add ACPI TLBI_ON_MAP support (VFIO integration also works in
  ACPI mode)
- fix block replay
- handle implementation defined SMMU_CMD_TLBI_NH_VA_AM cmd
  (goes along with TLBI_ON_MAP FW quirk)
- replay systematically unmap the whole range first
- smmuv3_map_hook does not unmap anymore and the unmap is done
  before the replay
- add and use smmuv3_context_device_invalidate instead of
  blindly replaying everything

v4 -> v5:
- initial_level now part of SMMUTransCfg
- smmu_page_walk_64 takes into account the max input size
- implement sys->iommu_ops.replay and sys->iommu_ops.notify_flag_changed
- smmuv3_translate: bug fix: don't walk on bypass
- smmu_update_qreg: fix PROD index update
- I did not yet address Peter's comments as the code is not mature enough
  to be split into sub patches.

v3 -> v4 [Eric]:
- page table walk rewritten to allow scan of the page table within a
  range of IOVA. This prepares for VFIO integration and replay.
- configuration parsing partially reworked.
- do not advertise unsupported/untested features: S2, S1 + S2, HYP,
  PRI, ATS, ..
- added ACPI table generation
- migrated to dynamic traces
- mingw compilation fix

v2 -> v3 [Eric]:
- rebased on 2.9
- mostly code and patch reorganization to ease the review process
- optional patches removed. They may be handled separately. I am currently
  working on ACPI enablement.
- optional instantiation of the smmu in mach-virt
- removed [2/9] (fdt functions) since not mandated
- start splitting main patch into base and derived object
- no new function feature added

v1 -> v2 [Prem]:
- Adopted review comments from Eric Auger
        - Make SMMU_DPRINTF to internally call qemu_log
            (since translation requests are too many, we need control
             on the type of log we want)
        - SMMUTransCfg modified to suite simplicity
        - Change RegInfo to uint64 register array
        - Code cleanup
        - Test cleanups
- Reshuffled patches

v0 -> v1 [Prem]:
- As per SMMUv3 spec 16.0 (only is_ste_consistant() is noticeable)
- Reworked register access/update logic
- Factored out translation code for
        - single point bug fix
        - sharing/removal in future
- (optional) Unit tests added, with PCI test device
        - S1 with 4k/64k, S1+S2 with 4k/64k
        - (S1 or S2) only can be verified by Linux 4.7 driver
        - (optional) Priliminary ACPI support

v0 [Prem]:
- Implements SMMUv3 spec 11.0
- Supported for PCIe devices,
- Command Queue and Event Queue supported
- LPAE only, S1 is supported and Tested, S2 not tested
- BE mode Translation not supported
- IRQ support (legacy, no MSI)
- Tested with DPDK and e1000


Eric Auger (14):
  hw/arm/smmu-common: smmu base device and datatypes
  hw/arm/smmu-common: IOMMU memory region and address space setup
  hw/arm/smmu-common: VMSAv8-64 page table walk
  hw/arm/smmuv3: Wired IRQ and GERROR helpers
  hw/arm/smmuv3: Queue helpers
  hw/arm/smmuv3: Implement MMIO write operations
  hw/arm/smmuv3: Event queue recording helper
  hw/arm/smmuv3: Implement translate callback
  hw/arm/smmuv3: Abort on vfio or vhost case
  target/arm/kvm: Translate the MSI doorbell in kvm_arch_fixup_msi_route
  hw/arm/virt: Introduce the iommu option
  hw/arm/smmuv3: Cache/invalidate config data
  hw/arm/smmuv3: IOTLB emulation
  hw/arm/smmuv3: Add notifications on invalidation

Prem Mallappa (3):
  hw/arm/smmuv3: Skeleton
  hw/arm/virt: Add SMMUv3 to the virt board
  hw/arm/virt-acpi-build: Add smmuv3 node in IORT table

 default-configs/aarch64-softmmu.mak |    1 +
 hw/arm/Makefile.objs                |    1 +
 hw/arm/smmu-common.c                |  446 +++++++++++
 hw/arm/smmu-internal.h              |  102 +++
 hw/arm/smmuv3-internal.h            |  609 ++++++++++++++
 hw/arm/smmuv3.c                     | 1494 +++++++++++++++++++++++++++++++++++
 hw/arm/trace-events                 |   57 ++
 hw/arm/virt-acpi-build.c            |   55 +-
 hw/arm/virt.c                       |  100 ++-
 include/hw/acpi/acpi-defs.h         |   15 +
 include/hw/arm/smmu-common.h        |  166 ++++
 include/hw/arm/smmuv3.h             |   88 +++
 include/hw/arm/virt.h               |   10 +
 target/arm/kvm.c                    |   27 +
 target/arm/trace-events             |    3 +
 15 files changed, 3166 insertions(+), 8 deletions(-)
 create mode 100644 hw/arm/smmu-common.c
 create mode 100644 hw/arm/smmu-internal.h
 create mode 100644 hw/arm/smmuv3-internal.h
 create mode 100644 hw/arm/smmuv3.c
 create mode 100644 include/hw/arm/smmu-common.h
 create mode 100644 include/hw/arm/smmuv3.h

-- 
2.5.5
