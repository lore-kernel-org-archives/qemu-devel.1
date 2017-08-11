Received: from eggs.gnu.org ([2001:4830:134:3::10]:34088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dgAqY-0008Jh-VJ
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dgAqX-0001vl-2g
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:23:30 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 11 Aug 2017 16:22:25 +0200
Message-Id: <1502461354-11327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v6 0/9] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.williamson@redhat.com, prem.mallappa@gmail.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com

This series implements the emulation code for ARM SMMUv3.
This is the continuation of Prem's work [1].

This v6 fixes some VFIO integration issues:
- Block replay was corrected.
- Range unmap is done before the replay (vhost issue).
- Introduction of a new CMDQ_OP_TLBI_NH_VA_AM command to
  handle invalidation of hugepages. DPDK was tested with
  a single assigned VF*.
Also 64b MMIO accesses should be fixed now.

For VFIO integration, a quirk is needed on guest side in the arm-smmu-v3
driver [2]. This quirk now can used both in dt and ACPI modes.

The smmu is instantiated when passing the smmu option to machvirt:
"-M virt-2.10,smmu". Most probably I will change this to instantiate it
using -device option in next version and add an option to select caching
mode.

The series needs to be further split to allow decent reviews and I
don't expect any at this stage. However testing really is welcome.

I tested the following use cases:
- booted a guest in dt and acpi mode with an iommu_platform
  virtio-net-pci device (using dma ops). Tested with the following
  guest combinations: 4K page - 39 bit VA, 4K - 48b, 64K - 39b,
  64K - 48b.
- booted a guest [2] with assigned PCIe device virtual functions:
  - AMD Overdrive and igbvf passthrough (using gsi direct mapping)
  - Cavium ThunderX and ixgbevf passthrough (using KVM MSI routing)
  - ran DPDK testpmd on guest using a single passthroughed igbvf.

* dpdk testpmd using Using 2 igbvf's does not work at the moment:
  - the issue is on guest side the 2 devices are put in the same domain
    by vfio_iommu_type1_attach_group() and mappings are replayed on
    a single devicephysical smmu
    only for the 1st device. This causes an smmu fault. I will address
    this in next revision.

Known limitations:
- no VMSAv8-32 suport
- no nested stage support (S1 + S2)
- no support for HYP mappings
- register fine emulation, commands, interrupts and errors were
  not accurately tested. Handling is sufficient to run use cases
  described above though.

Best Regards

Eric

This series can be found at:
v6: https://github.com/eauger/qemu/tree/v2.10.0-rc2-SMMU-v6
v5: https://github.com/eauger/qemu/tree/v2.9-SMMU-v5

References:
[1] Prem's last iteration:
[2] [RFC v2 0/4] arm-smmu-v3 tlbi-on-map option

History:
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


Eric Auger (6):
  hw/arm/smmu-common: smmu base class
  hw/arm/virt: Add 2.11 machine type
  hw/arm/virt: Add tlbi-on-map property to the smmuv3 node
  target/arm/kvm: Translate the MSI doorbell in kvm_arch_fixup_msi_route
  hw/arm/smmuv3: VFIO integration
  hw/arm/virt-acpi-build: Use the ACPI_IORT_SMMU_V3_CACHING_MODE model

Prem Mallappa (3):
  hw/arm/smmuv3: smmuv3 emulation model
  hw/arm/virt: Add SMMUv3 to the virt board
  hw/arm/virt-acpi-build: Add smmuv3 node in IORT table

 default-configs/aarch64-softmmu.mak |    1 +
 hw/arm/Makefile.objs                |    1 +
 hw/arm/smmu-common.c                |  493 ++++++++++++
 hw/arm/smmu-internal.h              |   89 +++
 hw/arm/smmuv3-internal.h            |  652 ++++++++++++++++
 hw/arm/smmuv3.c                     | 1412 +++++++++++++++++++++++++++++++++++
 hw/arm/trace-events                 |   62 ++
 hw/arm/virt-acpi-build.c            |   58 +-
 hw/arm/virt.c                       |  110 ++-
 include/hw/acpi/acpi-defs.h         |   15 +
 include/hw/arm/smmu-common.h        |  126 ++++
 include/hw/arm/smmuv3.h             |   89 +++
 include/hw/arm/virt.h               |    5 +
 include/hw/compat.h                 |    3 +
 target/arm/kvm.c                    |   27 +
 target/arm/trace-events             |    3 +
 16 files changed, 3137 insertions(+), 9 deletions(-)
 create mode 100644 hw/arm/smmu-common.c
 create mode 100644 hw/arm/smmu-internal.h
 create mode 100644 hw/arm/smmuv3-internal.h
 create mode 100644 hw/arm/smmuv3.c
 create mode 100644 include/hw/arm/smmu-common.h
 create mode 100644 include/hw/arm/smmuv3.h

-- 
2.5.5
