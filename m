Received: from eggs.gnu.org ([2001:4830:134:3::10]:53961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linuc.decode@gmail.com>) id 1dxSYD-0008BM-7Y
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 02:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linuc.decode@gmail.com>) id 1dxSY8-0007vj-I3
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 02:44:01 -0400
Date: Thu, 28 Sep 2017 12:13:12 +0530
From: Linu Cherian <linuc.decode@gmail.com>
Message-ID: <20170928064312.GA1544@virtx40>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v7 00/20] ARM SMMUv3 Emulation
 Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com, mohun106@gmail.com, drjones@redhat.com, tcain@qti.qualcomm.com, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mst@redhat.com, jean-philippe.brucker@arm.com, tn@semihalf.com, will.deacon@arm.com, robin.murphy@arm.com, peterx@redhat.com, bharat.bhushan@nxp.com, christoffer.dall@linaro.org, wtownsen@redhat.com

Hi Eric,


On Fri Sep 01, 2017 at 07:21:03PM +0200, Eric Auger wrote:
> This series implements the emulation code for ARM SMMUv3.
> 
> Changes since v6:
> - DPDK testpmd now running on guest with 2 assigned VFs
> - Changed the instantiation method: add the following option to
>   the QEMU command line
>   -device smmuv3 # for virtio/vhost use cases
>   -device smmuv3,caching-mode # for vfio use cases (based on [1])
> - splitted the series into smaller patches to allow the review
> - the VFIO integration based on "tlbi-on-map" smmuv3 driver
>   is isolated from the rest: last 2 patches, not for upstream.
>   This is shipped for testing/bench until a better solution is found.
> - Reworked permission flag checks and event generation
> e testing:
> - in dt and ACPI modes
> - virtio-net-pci and vhost-net devices using dma ops with various
>   guest page sizes [2]
> - assigned VFs using dma ops [3]:
>   - AMD Overdrive and igbvf passthrough (using gsi direct mapping)
>   - Cavium ThunderX and ixgbevf passthrough (using KVM MSI routing)
> - DPDK testpmd on guest running with VFIO user space drivers (2 igbvf) [3]
>   with guest and host page size equal (4kB)
> 
> Known limitations:
> - no VMSAv8-32 suport
> - no nested stage support (S1 + S2)
> - no support for HYP mappings
> - register fine emulation, commands, interrupts and errors were
>   not accurately tested. Handling is sufficient to run use cases
>   described above though.
> - interrupts and event generation not observed yet.

While testing with vfio-pci, observed that the below two  Qemu command,
results in two different behaviour. Is this expected by design ?

Case 1:
# -device vfio-pci,host=0002:01:00.3 -device smmuv3,caching-mode
 Here iommu is not attached to the pci bus in Qemu backend, since
 pci_setup_iommu is not called before vfio_realize.

Case 2:
# -device smmuv3,caching-mode -device vfio-pci,host=0002:01:00.3
This works as expected, iommu is attached to the pci bus.

> 
> Best Regards
> 
> Eric
> 
> This series can be found at:
> v7: https://github.com/eauger/qemu/tree/v2.10.0-SMMU-v7
> Previous version at:
> v6: https://github.com/eauger/qemu/tree/v2.10.0-rc2-SMMU-v6
> 
> References:
> [1] [RFC v2 0/4] arm-smmu-v3 tlbi-on-map option
>     https://lkml.org/lkml/2017/8/11/426
> 
> [2] qemu cmd line excerpt:
> -device smmuv3 \
> -netdev tap,id=tap0,script=no,downscript=no,ifname=tap0,vhost=off \
> -device virtio-net-pci,netdev=tap0,mac=6a:f5:10:b1:3d:d2,iommu_platform,disable-modern=off,disable-legacy=on \
> [3] use -device smmuv3,caching-mode
> 
> 
> History:
> v6 -> v7:
> - see above
> 
> v5 -> v6:
> - Rebase on 2.10 and IOMMUMemoryRegion
> - add ACPI TLBI_ON_MAP support (VFIO integration also works in
>   ACPI mode)
> - fix block replay
> - handle implementation defined SMMU_CMD_TLBI_NH_VA_AM cmd
>   (goes along with TLBI_ON_MAP FW quirk)
> - replay systematically unmap the whole range first
> - smmuv3_map_hook does not unmap anymore and the unmap is done
>   before the replay
> - add and use smmuv3_context_device_invalidate instead of
>   blindly replaying everything
> 
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
> 
> Eric Auger (18):
>   hw/arm/smmu-common: smmu base device and datatypes
>   hw/arm/smmu-common: IOMMU memory region and address space setup
>   hw/arm/smmu-common: smmu_read/write_sysmem
>   hw/arm/smmu-common: VMSAv8-64 page table walk
>   hw/arm/smmuv3: Wired IRQ and GERROR helpers
>   hw/arm/smmuv3: Queue helpers
>   hw/arm/smmuv3: Implement MMIO write operations
>   hw/arm/smmuv3: Event queue recording helper
>   hw/arm/smmuv3: Implement translate callback
>   target/arm/kvm: Translate the MSI doorbell in kvm_arch_fixup_msi_route
>   hw/arm/smmuv3: Implement data structure and TLB invalidation
>     notifications
>   hw/arm/smmuv3: Implement IOMMU memory region replay callback
>   hw/arm/virt: Store the PCI host controller dt phandle
>   hw/arm/sysbus-fdt: Pass the VirtMachineState to the node creation
>     functions
>   hw/arm/sysbus-fdt: Pass the platform bus base address in
>     PlatformBusFDTData
>   hw/arm/sysbus-fdt: Allow smmuv3 dynamic instantiation
>   hw/arm/smmuv3: [not for upstream] add SMMU_CMD_TLBI_NH_VA_AM handling
>   hw/arm/smmuv3: [not for upstream] Add caching-mode option
> 
> Prem Mallappa (2):
>   hw/arm/smmuv3: Skeleton
>   hw/arm/virt-acpi-build: Add smmuv3 node in IORT table
> 
>  default-configs/aarch64-softmmu.mak |    1 +
>  hw/arm/Makefile.objs                |    1 +
>  hw/arm/smmu-common.c                |  527 ++++++++++++++++
>  hw/arm/smmu-internal.h              |  105 ++++
>  hw/arm/smmuv3-internal.h            |  584 +++++++++++++++++
>  hw/arm/smmuv3.c                     | 1181 +++++++++++++++++++++++++++++++++++
>  hw/arm/sysbus-fdt.c                 |  129 +++-
>  hw/arm/trace-events                 |   48 ++
>  hw/arm/virt-acpi-build.c            |   63 +-
>  hw/arm/virt.c                       |    6 +-
>  include/hw/acpi/acpi-defs.h         |   15 +
>  include/hw/arm/smmu-common.h        |  123 ++++
>  include/hw/arm/smmuv3.h             |   80 +++
>  include/hw/arm/sysbus-fdt.h         |    2 +
>  include/hw/arm/virt.h               |   15 +
>  target/arm/kvm.c                    |   27 +
>  target/arm/trace-events             |    3 +
>  17 files changed, 2886 insertions(+), 24 deletions(-)
>  create mode 100644 hw/arm/smmu-common.c
>  create mode 100644 hw/arm/smmu-internal.h
>  create mode 100644 hw/arm/smmuv3-internal.h
>  create mode 100644 hw/arm/smmuv3.c
>  create mode 100644 include/hw/arm/smmu-common.h
>  create mode 100644 include/hw/arm/smmuv3.h
> 
> -- 
> 2.5.5
> 
> 

-- 
Linu cherian
