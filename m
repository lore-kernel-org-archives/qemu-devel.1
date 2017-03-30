Received: from eggs.gnu.org ([2001:4830:134:3::10]:39929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ctfxs-0003B1-Bn
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ctfxr-00078l-BA
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:42:36 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 30 Mar 2017 21:42:13 +0200
Message-Id: <1490902938-9009-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 0/5] SMMUv3 Emmulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, edgar.iglesias@gmail.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com

This series introduces the emulation code for ARM SMMUv3.
This is the continuation of Prem's work [1].

At the moment only AArch64 translation format is supported, ie.
no support for AArch32 (LPAE) translation.

stage1, stage2 and stage1 + Stage2 are supposed to work but I only
tested stage 1 at the moment.

I will do the comprehensive inventory of unsupported features in
next version.

As reported by Edgar, TBUs are not modeled properly and this will be
addressed in next respin.

Don't spend too much time reviewing this version. This is just a rebase
plus some cleanups done while getting familiar with the code structure.
I will try to move as much in the base class and reuse Xilinx code when
sensible.

Best Regards

Eric

Testing:
- booted a 4.11-rc4 guest in dt mode with virtio-pci device

References:
[1] Prem's last iteration:
- https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03531.html

History:
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


Eric Auger (2):
  hw/arm/smmu-common: smmu base class
  hw/arm/virt: Add 2.10 machine type

Prem Mallappa (3):
  log: Add new IOMMU type
  hw/arm/smmuv3: smmuv3 emulation model
  hw/arm/virt: Add SMMUv3 to the virt board

 default-configs/aarch64-softmmu.mak |    1 +
 hw/arm/Makefile.objs                |    1 +
 hw/arm/smmu-common.c                |  193 ++++++
 hw/arm/smmuv3-internal.h            |  544 +++++++++++++++++
 hw/arm/smmuv3.c                     | 1131 +++++++++++++++++++++++++++++++++++
 hw/arm/virt.c                       |  109 +++-
 include/hw/arm/smmu-common.h        |  151 +++++
 include/hw/arm/smmuv3.h             |   88 +++
 include/hw/arm/virt.h               |    5 +
 include/hw/compat.h                 |    3 +
 include/qemu/log.h                  |    1 +
 util/log.c                          |    2 +
 12 files changed, 2227 insertions(+), 2 deletions(-)
 create mode 100644 hw/arm/smmu-common.c
 create mode 100644 hw/arm/smmuv3-internal.h
 create mode 100644 hw/arm/smmuv3.c
 create mode 100644 include/hw/arm/smmu-common.h
 create mode 100644 include/hw/arm/smmuv3.h

-- 
2.5.5
