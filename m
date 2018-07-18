Received: from eggs.gnu.org ([2001:4830:134:3::10]:52228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ffn8J-0003Tb-8h
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 10:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ffn8D-0002AY-W3
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 10:08:47 -0400
Date: Wed, 18 Jul 2018 16:08:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180718160832.0d754aa4@redhat.com>
In-Reply-To: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 00/15] ARM virt: PCDIMM/NVDIMM at 2TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

On Tue,  3 Jul 2018 09:19:43 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> This series aims at supporting PCDIMM/NVDIMM intantiation in
> machvirt at 2TB guest physical address.
> 
> This is achieved in 3 steps:
> 1) support more than 40b IPA/GPA
will it work for TCG as well?
/important from make check pov and maybe in cases when there is no ARM system available to test/play with the feature/



> 2) support PCDIMM instantiation
> 3) support NVDIMM instantiation
> 
> This series reuses/rebases patches initially submitted by Shameer in [1]
> and Kwangwoo in [2].
> 
> I put all parts all together for consistency and due to dependencies
> however as soon as the kernel dependency is resolved we can consider
> upstreaming them separately.
> 
> Support more than 40b IPA/GPA [ patches 1 - 5 ]
> -----------------------------------------------
> was "[RFC 0/6] KVM/ARM: Dynamic and larger GPA size"
> 
> At the moment the guest physical address space is limited to 40b
> due to KVM limitations. [0] bumps this limitation and allows to
> create a VM with up to 52b GPA address space.
> 
> With this series, QEMU creates a virt VM with the max IPA range
> reported by the host kernel or 40b by default.
> 
> This choice can be overriden by using the -machine kvm-type=<bits>
> option with bits within [40, 52]. If <bits> are not supported by
> the host, the legacy 40b value is used.
> 
> Currently the EDK2 FW also hardcodes the max number of GPA bits to
> 40. This will need to be fixed.
> 
> PCDIMM Support [ patches 6 - 11 ]
> ---------------------------------
> was "[RFC 0/5] ARM virt: Support PC-DIMM at 2TB"
> 
> We instantiate the device_memory at 2TB. Using it obviously requires
> at least 42b of IPA/GPA. While its max capacity is currently limited
> to 2TB, the actual size depends on the initial guest RAM size and
> maxmem parameter.
> 
> Actual hot-plug and hot-unplug of PC-DIMM is not suported due to lack
> of support of those features in baremetal.
> 
> NVDIMM support [ patches 12 - 15 ]
> ----------------------------------
> 
> Once the memory hotplug framework is in place it is fairly
> straightforward to add support for NVDIMM. the machine "nvdimm" option
> turns the capability on.
> 
> Best Regards
> 
> Eric
> 
> References:
> 
> [0] [PATCH v3 00/20] arm64: Dynamic & 52bit IPA support
> https://www.spinics.net/lists/kernel/msg2841735.html
> 
> [1] [RFC v2 0/6] hw/arm: Add support for non-contiguous iova regions
> http://patchwork.ozlabs.org/cover/914694/
> 
> [2] [RFC PATCH 0/3] add nvdimm support on AArch64 virt platform
> https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04599.html
> 
> Tests:
> - On Cavium Gigabyte, a 48b VM was created.
> - Migration tests were performed between kernel supporting the
>   feature and destination kernel not suporting it
> - test with ACPI: to overcome the limitation of EDK2 FW, virt
>   memory map was hacked to move the device memory below 1TB.
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/v2.12.0-dimm-2tb-v3
> 
> History:
> 
> v2 -> v3:
> - fix pc_q35 and pc_piix compilation error
> - kwangwoo's email being not valid anymore, remove his address
> 
> v1 -> v2:
> - kvm_get_max_vm_phys_shift moved in arch specific file
> - addition of NVDIMM part
> - single series
> - rebase on David's refactoring
> 
> v1:
> - was "[RFC 0/6] KVM/ARM: Dynamic and larger GPA size"
> - was "[RFC 0/5] ARM virt: Support PC-DIMM at 2TB"
> 
> Best Regards
> 
> Eric
> 
> 
> Eric Auger (9):
>   linux-headers: header update for KVM/ARM KVM_ARM_GET_MAX_VM_PHYS_SHIFT
>   hw/boards: Add a MachineState parameter to kvm_type callback
>   kvm: add kvm_arm_get_max_vm_phys_shift
>   hw/arm/virt: support kvm_type property
>   hw/arm/virt: handle max_vm_phys_shift conflicts on migration
>   hw/arm/virt: Allocate device_memory
>   acpi: move build_srat_hotpluggable_memory to generic ACPI source
>   hw/arm/boot: Expose the pmem nodes in the DT
>   hw/arm/virt: Add nvdimm and nvdimm-persistence options
> 
> Kwangwoo Lee (2):
>   nvdimm: use configurable ACPI IO base and size
>   hw/arm/virt: Add nvdimm hot-plug infrastructure
> 
> Shameer Kolothum (4):
>   hw/arm/virt: Add memory hotplug framework
>   hw/arm/boot: introduce fdt_add_memory_node helper
>   hw/arm/boot: Expose the PC-DIMM nodes in the DT
>   hw/arm/virt-acpi-build: Add PC-DIMM in SRAT
> 
>  accel/kvm/kvm-all.c                            |   2 +-
>  default-configs/arm-softmmu.mak                |   4 +
>  hw/acpi/aml-build.c                            |  51 ++++
>  hw/acpi/nvdimm.c                               |  28 ++-
>  hw/arm/boot.c                                  | 123 +++++++--
>  hw/arm/virt-acpi-build.c                       |  10 +
>  hw/arm/virt.c                                  | 330 ++++++++++++++++++++++---
>  hw/i386/acpi-build.c                           |  49 ----
>  hw/i386/pc_piix.c                              |   8 +-
>  hw/i386/pc_q35.c                               |   8 +-
>  hw/ppc/mac_newworld.c                          |   2 +-
>  hw/ppc/mac_oldworld.c                          |   2 +-
>  hw/ppc/spapr.c                                 |   2 +-
>  include/hw/acpi/aml-build.h                    |   3 +
>  include/hw/arm/arm.h                           |   2 +
>  include/hw/arm/virt.h                          |   7 +
>  include/hw/boards.h                            |   2 +-
>  include/hw/mem/nvdimm.h                        |  12 +
>  include/standard-headers/linux/virtio_config.h |  16 +-
>  linux-headers/asm-mips/unistd.h                |  18 +-
>  linux-headers/asm-powerpc/kvm.h                |   1 +
>  linux-headers/linux/kvm.h                      |  16 ++
>  target/arm/kvm.c                               |   9 +
>  target/arm/kvm_arm.h                           |  16 ++
>  24 files changed, 597 insertions(+), 124 deletions(-)
> 
