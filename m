Received: from eggs.gnu.org ([2001:4830:134:3::10]:42049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1clffL-00054N-4A
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1clffI-00062p-Hs
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:46:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1clffI-00062D-9F
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:46:20 -0500
References: <20160822161740.4252-1-prem.mallappa@broadcom.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <465528b8-332b-083e-fc04-5613fadc57fa@redhat.com>
Date: Wed, 8 Mar 2017 18:46:13 +0100
MIME-Version: 1.0
In-Reply-To: <20160822161740.4252-1-prem.mallappa@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/9] SMMUv3 Emulation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prem Mallappa <prem.mallappa@broadcom.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

Hi,
On 22/08/2016 18:17, Prem Mallappa wrote:
> v1 -> v2:
> 	- Adopted review comments from Eric Auger
> 		- Make SMMU_DPRINTF to internally call qemu_log
> 	            (since translation requests are too many, we need control
> 		     on the type of log we want)
> 		- SMMUTransCfg modified to suite simplicity
> 		- Change RegInfo to uint64 register array
> 		- Code cleanup
> 		- Test cleanups
> 	- Reshuffled patches
> 
> RFC -> v1:
> 	- As per SMMUv3 spec 16.0 (only is_ste_consistant() is noticeable)
> 	- Reworked register access/update logic
> 	- Factored out translation code for
> 		- single point bug fix
> 		- sharing/removal in future
> 	- (optional) Unit tests added, with PCI test device
> 		- S1 with 4k/64k, S1+S2 with 4k/64k
> 		- (S1 or S2) only can be verified by Linux 4.7 driver
> 	- (optional) Priliminary ACPI support
> 
> RFC:
> 	- Implements SMMUv3 spec 11.0
> 	- Supported for PCIe devices, 
> 	- Command Queue and Event Queue supported
> 	- LPAE only, S1 is supported and Tested, S2 not tested
> 	- BE mode Translation not supported
> 	- IRQ support (legacy, no MSI)
> 	- Tested with DPDK and e1000 
> 
> Patch 1: Add new log type for IOMMU transactions
> 
> Patch 2: Adds support in virt.c to create both SMMUv3 device and dts entries
> 
> Patch 2: Adds SMMUv3 model to QEMU
> 	Multiple files, big ones, translate functionality is split across to
> 	accomodate SMMUv2 model, and to remove when common translation feature
> 	(if) becomes available.
> 
> Patch 3: Adds SMMU build support
> 
> Patch 4: Some devicetree function to add support for SMMU's multiple interrupt
> 	 assignment with names
> 
> << optional patches >>
> Optional patches are posted for completeness or for those who wants to test.
> 
> Patch 5: A simple PCI device which does DMA from 'src' to 'dst' given
> 	 src_addr, dst_addr and size, and is used by unit test, uses
> 	 pci_dma_read and pci_dma_write in a crude way but serves the purpose.
> 
> Patch 6: Current libqos PCI helpers are x86 only, this addes a generic interface
> 
> Patch 7: Unit tests for SMMU, 
> 		- initializes SMMU device 
> 		- initializes Test device
> 		- allocates page tables 1:1 mapping va == pa
> 		- allocates STE/CD accordingly for S1, S2, S1+S2
> 		- initiates DMA via PCI test device
> 		- verifies transfered data
> 
> Patch 8: Added ACPI IORT tables, was needed for internal project purpose, but 
> 	 posting here for anyone looking for testing ACPI on ARM platforms.
> 	 (P.S: Linux side IORT patches are WIP)
> 
> Repo:
> https://github.com/pmallappa/qemu/tree/upstream/smmuv3/v2
> 
> To Test:
> $ make tests/smmuv3-test
> $ QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64 tests/smmuv3-test
> << expect lot of prints >>
> 
> Any comments welcome..
As Prem was forced to stop his activity on this series, I volunteer to
pursue his work. Prior to starting the work, I just would like to check
nobody works on this already or objects.

If not, I intend to rebase and will do my utmost to align, when sensible
with what was done on Xilinx vsmmuv2/intel iommu.

Thanks

Eric
> 
> Cheers
> /Prem
> 
> Prem Mallappa (9):
>   log: Add new IOMMU type
>   devicetree: Added new APIs to make use of more fdt functions
>   hw: arm: SMMUv3 emulation model
>   hw: arm: Added SMMUv3 files for build
>   hw: arm: Add SMMUv3 to virt platform, create DTS accordingly
>   [optional] hw: misc: added testdev for smmu
>   [optional] tests: libqos: generic pci probing helpers
>   [optional] tests: SMMUv3 unit tests
>   [optional] arm: smmu-v3: ACPI IORT initial support
> 
>  default-configs/aarch64-softmmu.mak |    1 +
>  device_tree.c                       |   35 +
>  hw/arm/Makefile.objs                |    1 +
>  hw/arm/smmu-common.c                |  152 ++++
>  hw/arm/smmu-common.h                |  141 ++++
>  hw/arm/smmu-v3.c                    | 1369 +++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-internal.h            |  432 +++++++++++
>  hw/arm/virt-acpi-build.c            |   43 ++
>  hw/arm/virt.c                       |   62 ++
>  hw/misc/Makefile.objs               |    2 +-
>  hw/misc/pci-testdev-smmu.c          |  239 ++++++
>  hw/misc/pci-testdev-smmu.h          |   22 +
>  hw/vfio/common.c                    |    2 +-
>  include/hw/acpi/acpi-defs.h         |   84 +++
>  include/hw/arm/smmu.h               |   33 +
>  include/hw/arm/virt.h               |    2 +
>  include/qemu/log.h                  |    1 +
>  include/sysemu/device_tree.h        |   18 +
>  tests/Makefile.include              |    4 +
>  tests/libqos/pci-generic.c          |  197 +++++
>  tests/libqos/pci-generic.h          |   58 ++
>  tests/smmuv3-test.c                 |  952 ++++++++++++++++++++++++
>  util/log.c                          |    2 +
>  23 files changed, 3850 insertions(+), 2 deletions(-)
>  create mode 100644 hw/arm/smmu-common.c
>  create mode 100644 hw/arm/smmu-common.h
>  create mode 100644 hw/arm/smmu-v3.c
>  create mode 100644 hw/arm/smmuv3-internal.h
>  create mode 100644 hw/misc/pci-testdev-smmu.c
>  create mode 100644 hw/misc/pci-testdev-smmu.h
>  create mode 100644 include/hw/arm/smmu.h
>  create mode 100644 tests/libqos/pci-generic.c
>  create mode 100644 tests/libqos/pci-generic.h
>  create mode 100644 tests/smmuv3-test.c
> 
