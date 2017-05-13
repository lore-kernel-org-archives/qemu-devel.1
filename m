Received: from eggs.gnu.org ([2001:4830:134:3::10]:57506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1d9b4s-00089w-OC
	for qemu-devel@nongnu.org; Sat, 13 May 2017 13:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1d9b4r-0003ng-Cu
	for qemu-devel@nongnu.org; Sat, 13 May 2017 13:43:38 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sat, 13 May 2017 19:43:14 +0200
Message-Id: <1494697399-352-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 0/5] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, edgar.iglesias@gmail.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com

This series introduces the emulation code for ARM SMMUv3.
This is the continuation of Prem's work [1].

This v4 is yet another visibility step as many restrictions apply
to the model at the moment:
- only VMSAv8-64 is supported (no VMSAv8-32)
- only stage 1 has been tested (Block PTE still needs to be
  implemented and tested though)
- no integration with VFIO. We are missing some quirks to force
  the guest to invalidate TLBs when updating the page tables.
  But replay will be easily implemented upon new page table scan.
- stage 2 is not supported. There is partial support when decoding
  configuration information but no support at page table walk level.
  This is my next step.
- at the moment I don't plan to support nested S1 + S2 as I
  understand no SW stack uses it at the moment.
- no support for HYP mappings
- register fine emulation, commands, interrupts and errors were
  not accurately tested. Handling is sufficient to run a guest
  with a virtio-net-pci device using dma ops.
- At the moment no change to the PCIe instantiation (further
  discussions about SMMUv2 TBUs versus SMMUv3 TLBs needed).

- In ACPI mode, the guest must feature the IOMMU probe deferral
  series wich fixes streamid multiple lookup

The smmu is instantiated when passing the smmu option to machvirt:
"-M virt-2.10,smmu"

Best Regards

Eric

This series can be found at:
v4: https://github.com/eauger/qemu/tree/v2.9-SMMU-v4

Testing:
- booted a 4.11 guest in dt and acpi mode with an iommu_platform
  virtio-net-pci device (using dma ops). Tested with the following
  guest combinations: 4K page - 39 bit VA, 4K - 48b, 64K - 39b,
  64K - 48b.
- Also Prem's unit test environment was rebased (available upon
  demand)

References:
[1] Prem's last iteration:
- https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03531.html

History:
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

Eric Auger (2):
  hw/arm/smmu-common: smmu base class
  hw/arm/virt: Add 2.10 machine type

Prem Mallappa (3):
  hw/arm/smmuv3: smmuv3 emulation model
  hw/arm/virt: Add SMMUv3 to the virt board
  hw/arm/virt-acpi-build: add smmuv3 node in IORT table

 default-configs/aarch64-softmmu.mak |    1 +
 hw/arm/Makefile.objs                |    1 +
 hw/arm/smmu-common.c                |  419 +++++++++++++
 hw/arm/smmu-internal.h              |   97 +++
 hw/arm/smmuv3-internal.h            |  603 +++++++++++++++++++
 hw/arm/smmuv3.c                     | 1134 +++++++++++++++++++++++++++++++++++
 hw/arm/trace-events                 |   44 ++
 hw/arm/virt-acpi-build.c            |   56 +-
 hw/arm/virt.c                       |  109 +++-
 include/hw/acpi/acpi-defs.h         |   15 +
 include/hw/arm/smmu-common.h        |  125 ++++
 include/hw/arm/smmuv3.h             |   87 +++
 include/hw/arm/virt.h               |    5 +
 13 files changed, 2687 insertions(+), 9 deletions(-)
 create mode 100644 hw/arm/smmu-common.c
 create mode 100644 hw/arm/smmu-internal.h
 create mode 100644 hw/arm/smmuv3-internal.h
 create mode 100644 hw/arm/smmuv3.c
 create mode 100644 include/hw/arm/smmu-common.h
 create mode 100644 include/hw/arm/smmuv3.h

-- 
2.5.5
