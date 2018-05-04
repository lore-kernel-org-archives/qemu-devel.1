Received: from eggs.gnu.org ([2001:4830:134:3::10]:51589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ7-0005bX-AZ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ6-0000TO-05
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJ5-0000Q4-Nl
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:43 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ3-0002zG-F9
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:41 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:16 +0100
Message-Id: <20180504171540.25813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/24] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue: Eric's SMMUv3 patchset, and an array
of minor bugfixes and improvements from various others.

thanks
-- PMM

The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180504

for you to fetch changes up to 5680740c92993e9b3f3e011f2a2c394070e33f56:

  hw/arm/virt: Introduce the iommu option (2018-05-04 18:05:52 +0100)

----------------------------------------------------------------
target-arm queue:
 * Emulate the SMMUv3 (IOMMU); one will be created in the 'virt' board
   if the commandline includes "-machine iommu=smmuv3"
 * target/arm: Implement v8M VLLDM and VLSTM
 * hw/arm: Don't fail qtest due to missing SD card in -nodefaults mode
 * Some fixes to silence Coverity false-positives
 * arm: boot: set boot_info starting from first_cpu
   (fixes a technical bug not visible in practice)
 * hw/net/smc91c111: Convert away from old_mmio
 * hw/usb/tusb6010: Convert away from old_mmio
 * hw/char/cmsdk-apb-uart.c: Accept more input after character read
 * target/arm: Make MPUIR write-ignored on OMAP, StrongARM
 * hw/arm/virt: Add linux,pci-domain property

----------------------------------------------------------------
Eric Auger (11):
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

Igor Mammedov (1):
      arm: boot: set boot_info starting from first_cpu

Jan Kiszka (1):
      hw/arm/virt: Add linux,pci-domain property

Mathew Maidment (1):
      target/arm: Correct MPUIR privilege level in register_cp_regs_for_features() conditional case

Patrick Oppenlander (1):
      hw/char/cmsdk-apb-uart.c: Accept more input after character read

Peter Maydell (3):
      hw/usb/tusb6010: Convert away from old_mmio
      hw/net/smc91c111: Convert away from old_mmio
      target/arm: Implement v8M VLLDM and VLSTM

Prem Mallappa (3):
      hw/arm/smmuv3: Skeleton
      hw/arm/virt: Add SMMUv3 to the virt board
      hw/arm/virt-acpi-build: Add smmuv3 node in IORT table

Richard Henderson (2):
      target/arm: Tidy conditions in handle_vec_simd_shri
      target/arm: Tidy condition in disas_simd_two_reg_misc

Thomas Huth (1):
      hw/arm: Don't fail qtest due to missing SD card in -nodefaults mode

 hw/arm/Makefile.objs                |    1 +
 hw/arm/smmu-internal.h              |   99 +++
 hw/arm/smmuv3-internal.h            |  621 ++++++++++++++++++
 include/hw/acpi/acpi-defs.h         |   15 +
 include/hw/arm/smmu-common.h        |  145 +++++
 include/hw/arm/smmuv3.h             |   87 +++
 include/hw/arm/virt.h               |   10 +
 hw/arm/boot.c                       |    2 +-
 hw/arm/omap1.c                      |    8 +-
 hw/arm/omap2.c                      |    8 +-
 hw/arm/pxa2xx.c                     |   15 +-
 hw/arm/smmu-common.c                |  372 +++++++++++
 hw/arm/smmuv3.c                     | 1191 +++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c            |   55 +-
 hw/arm/virt.c                       |  101 ++-
 hw/char/cmsdk-apb-uart.c            |    1 +
 hw/net/smc91c111.c                  |   54 +-
 hw/usb/tusb6010.c                   |   40 +-
 target/arm/helper.c                 |    2 +-
 target/arm/kvm.c                    |   38 +-
 target/arm/translate-a64.c          |   12 +-
 target/arm/translate.c              |   17 +-
 default-configs/aarch64-softmmu.mak |    1 +
 hw/arm/trace-events                 |   37 ++
 target/arm/trace-events             |    3 +
 25 files changed, 2868 insertions(+), 67 deletions(-)
 create mode 100644 hw/arm/smmu-internal.h
 create mode 100644 hw/arm/smmuv3-internal.h
 create mode 100644 include/hw/arm/smmu-common.h
 create mode 100644 include/hw/arm/smmuv3.h
 create mode 100644 hw/arm/smmu-common.c
 create mode 100644 hw/arm/smmuv3.c
