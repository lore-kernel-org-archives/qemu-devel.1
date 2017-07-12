Received: from eggs.gnu.org ([2001:4830:134:3::10]:33870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geethasowjanya.akula@gmail.com>) id 1dVLOG-0000HL-5w
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geethasowjanya.akula@gmail.com>) id 1dVLOE-0004O0-Nc
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:25:32 -0400
MIME-Version: 1.0
In-Reply-To: <CACJhume2HkAXVQ8kSCpGEfQV4NOP_=HrZCHXBNLnbm0B8dGQvw@mail.gmail.com>
References: <1499633493-19865-1-git-send-email-eric.auger@redhat.com>
	<CACJhume2HkAXVQ8kSCpGEfQV4NOP_=HrZCHXBNLnbm0B8dGQvw@mail.gmail.com>
From: Geetha Akula <geethasowjanya.akula@gmail.com>
Date: Wed, 12 Jul 2017 22:54:00 +0530
Message-ID: <CANHdaibKEC5=gwfSDM+XRFUFaP-jTTA9aEuWvZVeB-9+nCW2ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v5 0/8] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com, Alex Williamson <alex.williamson@redhat.com>, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com
Cc: mohun106@gmail.com, drjones@redhat.com, tcain@qti.qualcomm.com, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mst@redhat.com, jean-philippe.brucker@arm.com, tn@semihalf.com, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, peterx@redhat.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Christoffer Dall <christoffer.dall@linaro.org>

Hi Eric


> This series implements the emulation code for ARM SMMUv3.
> This is the continuation of Prem's work [1].
>
> This v5 mainly brings VFIO integration in DT mode. On guest kernel
> side, this requires a quirk [1] to force TLB invalidation on map.
>
> The following changes also are noticeable:
> - fix SMMU_CMDQ_CONS offset
> - adds dma-coherent dt property which fixes the unhandled command
>   opcode bug.
> - implements block PTE
>
> The smmu is instantiated when passing the smmu option to machvirt:
> "-M virt-2.10,smmu"
>
> As I haven't split the code yet so that it can be easily reviewable
> I don't expect deep reviews at this stage. Also the implementation may
> be largely sub-optimal.
>
> Tested Use Cases:
> - booted a guest in dt and acpi mode with an iommu_platform
>   virtio-net-pci device (using dma ops). Tested with the following
>   guest combinations: 4K page - 39 bit VA, 4K - 48b, 64K - 39b,
>   64K - 48b.

Verified patches with virtio-net-pci. Not observed any command queue
issues like in V4 patch series. There is a huge difference in iperf numbers
on guest with and without SMMUv3 emulation i.e (1.5 Gbps with viommu
and 9.0 Gbps without viommu). I think this is expected behaviour.

Is there any plan to add device-iotlb and iotlb support in SMMUv3 emulation ?


Thank you,
Geetha.


> - booted a guest (featuring [1]) with PCIe passthrough'ed PCIe devices:
>   - AMD Overdrive and igbvf passthrough (using gsi direct mapping)
>   - Cavium ThunderX and ixgbevf passthrough (using KVM MSI routing)
>
> Unfortunately I have not been able to run DPDK testpmd yet on guest side.
> The problem I see is the user space driver dma-maps a huge area
> and this causes plenty of CMDQ_OP_TLBI_NH_VA commands to be sent
> (tlbi-on-map) which are sent for each page whereas the dma-map covers a
> huge page. I will work on this issue for next version.
>
> Known limitations:
> - no VMSAv8-32 suport
> - no nested stage support (S1 + S2)
> - no support for HYP mappings
> - register fine emulation, commands, interrupts and errors were
>   not accurately tested. Handling is sufficient to run use cases
>   described hereafter though.
>
> Best Regards
>
> Eric
>
> This series can be found at:
> v5: https://github.com/eauger/qemu/tree/v2.9-SMMU-v5
> v4: https://github.com/eauger/qemu/tree/v2.9-SMMU-v4
>
> References:
> [1] [RFC 0/2] arm-smmu-v3 tlbi-on-map option
> [2] Prem's last iteration:
> - https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03531.html
>
> History:
> v4 -> v5:
> - initial_level now part of SMMUTransCfg
> - smmu_page_walk_64 takes into account the max input size
> - implement sys->iommu_ops.replay and sys->iommu_ops.notify_flag_changed
> - smmuv3_translate: bug fix: don't walk on bypass
> - smmu_update_qreg: fix PROD index update
> - I did not yet address Peter's comments as the code is not mature enough
>   to be split into sub patches.
>
> v3 -> v4 [Eric]:
> - page table walk rewritten to allow scan of the page table within a
>   range of IOVA. This prepares for VFIO integration and replay.
> - configuration parsing partially reworked.
> - do not advertise unsupported/untested features: S2, S1 + S2, HYP,
>   PRI, ATS, ..
> - added ACPI table generation
> - migrated to dynamic traces
> - mingw compilation fix
>
> v2 -> v3 [Eric]:
> - rebased on 2.9
> - mostly code and patch reorganization to ease the review process
> - optional patches removed. They may be handled separately. I am currently
>   working on ACPI enablement.
> - optional instantiation of the smmu in mach-virt
> - removed [2/9] (fdt functions) since not mandated
> - start splitting main patch into base and derived object
> - no new function feature added
>
> v1 -> v2 [Prem]:
> - Adopted review comments from Eric Auger
>         - Make SMMU_DPRINTF to internally call qemu_log
>             (since translation requests are too many, we need control
>              on the type of log we want)
>         - SMMUTransCfg modified to suite simplicity
>         - Change RegInfo to uint64 register array
>         - Code cleanup
>         - Test cleanups
> - Reshuffled patches
>
> v0 -> v1 [Prem]:
> - As per SMMUv3 spec 16.0 (only is_ste_consistant() is noticeable)
> - Reworked register access/update logic
> - Factored out translation code for
>         - single point bug fix
>         - sharing/removal in future
> - (optional) Unit tests added, with PCI test device
>         - S1 with 4k/64k, S1+S2 with 4k/64k
>         - (S1 or S2) only can be verified by Linux 4.7 driver
>         - (optional) Priliminary ACPI support
>
> v0 [Prem]:
> - Implements SMMUv3 spec 11.0
> - Supported for PCIe devices,
> - Command Queue and Event Queue supported
> - LPAE only, S1 is supported and Tested, S2 not tested
> - BE mode Translation not supported
> - IRQ support (legacy, no MSI)
> - Tested with DPDK and e1000
>
>
> Eric Auger (5):
>   hw/arm/smmu-common: smmu base class
>   hw/arm/virt: Add 2.10 machine type
>   hw/arm/virt: Add tlbi-on-map property to the smmuv3 node
>   target/arm/kvm: Translate the MSI doorbell in kvm_arch_fixup_msi_route
>   hw/arm/smmuv3: VFIO integration
>
> Prem Mallappa (3):
>   hw/arm/smmuv3: smmuv3 emulation model
>   hw/arm/virt: Add SMMUv3 to the virt board
>   hw/arm/virt-acpi-build: Add smmuv3 node in IORT table
>
>  default-configs/aarch64-softmmu.mak |    1 +
>  hw/arm/Makefile.objs                |    1 +
>  hw/arm/smmu-common.c                |  474 +++++++++++++
>  hw/arm/smmu-internal.h              |   89 +++
>  hw/arm/smmuv3-internal.h            |  651 ++++++++++++++++++
>  hw/arm/smmuv3.c                     | 1256 +++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events                 |   54 ++
>  hw/arm/virt-acpi-build.c            |   56 +-
>  hw/arm/virt.c                       |  111 +++-
>  include/hw/acpi/acpi-defs.h         |   15 +
>  include/hw/arm/smmu-common.h        |  127 ++++
>  include/hw/arm/smmuv3.h             |   87 +++
>  include/hw/arm/virt.h               |    5 +
>  target/arm/kvm.c                    |   28 +
>  target/arm/trace-events             |    3 +
>  15 files changed, 2949 insertions(+), 9 deletions(-)
>  create mode 100644 hw/arm/smmu-common.c
>  create mode 100644 hw/arm/smmu-internal.h
>  create mode 100644 hw/arm/smmuv3-internal.h
>  create mode 100644 hw/arm/smmuv3.c
>  create mode 100644 include/hw/arm/smmu-common.h
>  create mode 100644 include/hw/arm/smmuv3.h
>
> --
> 2.5.5
