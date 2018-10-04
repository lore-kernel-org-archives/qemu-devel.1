Received: from eggs.gnu.org ([2001:4830:134:3::10]:57480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g81Yp-0004Gg-Dt
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g81Y9-0005MU-Tn
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:12:12 -0400
Date: Thu, 4 Oct 2018 13:11:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181004131150.3de8174a@redhat.com>
In-Reply-To: <43a03645-fa17-3274-9a66-502acc27b2ee@redhat.com>
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
	<43a03645-fa17-3274-9a66-502acc27b2ee@redhat.com>
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
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, wei@redhat.com, drjones@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, agraf@suse.de, Laszlo Ersek <lersek@redhat.com>, david@gibson.dropbear.id.au

On Wed, 3 Oct 2018 15:49:03 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi,
> 
> On 7/3/18 9:19 AM, Eric Auger wrote:
> > This series aims at supporting PCDIMM/NVDIMM intantiation in
> > machvirt at 2TB guest physical address.
> > 
> > This is achieved in 3 steps:
> > 1) support more than 40b IPA/GPA
> > 2) support PCDIMM instantiation
> > 3) support NVDIMM instantiation  
> 
> While respinning this series I have some general questions that raise up
> when thinking about extending the RAM on mach-virt:
> 
> At the moment mach-virt offers 255GB max initial RAM starting at 1GB
> ("-m " option).
> 
> This series does not touch this initial RAM and only targets to add
> device memory (usable for PCDIMM, NVDIMM, virtio-mem, virtio-pmem) in
> 3.1 machine, located at 2TB. 3.0 address map top currently is at 1TB
> (legacy aarch32 LPAE limit) so it would leave 1TB for IO or PCI. Is it OK?
> 
> - Putting device memory at 2TB means only ARMv8/aarch64 would get
> benefit of it. Is it an issue? ie. no device memory for ARMv7 or
> ARMv8/aarch32. Do we need to put effort supporting more memory and
> memory devices for those configs? there is less than 256GB free in the
> existing 1TB mach-virt memory map anyway.
> 
> - is it OK to rely only on device memory to extend the existing 255 GB
> RAM or would we need additional initial memory? device memory usage
> induces a more complex command line so this puts a constraint on upper
> layers. Is it acceptable though?
> 
> - I revisited the series so that the max IPA size shift would get
> automatically computed according to the top address reached by the
> device memory, ie. 2TB + (maxram_size - ramsize). So we would not need
> any additional kvm-type or explicit vm-phys-shift option to select the
> correct max IPA shift (or any CPU phys-bits as suggested by Dave). This
> also assumes we don't put anything beyond the device memory. It is OK?
> 
> - Igor told me we was concerned about the split-memory RAM model as it
> caused a lot of trouble regarding compat/migration on PC machine. After
> having studied the pc machine code I now wonder if we can compare the PC
> compat issues with the ones we could encounter on ARM with the proposed
> split memory model.
that's not the only issue.

For example since initial memory isn't modeled as a device
(i.e. it's just a plain memory region), there is a bunch of numa
code to deal with it. If initial memory were replaced by pc-dimm,
we would drop some of it and if we deprecated old '-numa mem' we
should be able to drop the most of it (newer '-numa memdev' maps
directly into pc-dimm model).

 
> On PC there are many knobs to tune the RAM layout
> - max_ram_below_4g option tunes how much RAM we want below 4G
> - gigabyte_align to force 3GB versus 3.5GB lowmem limit if ram_size >
> max_ram_below_4g
> - plus the usual ram_size which affects the rest of the initial ram
> - plus the maxram_size, slots which affect the size of the device memory
> - the device memory is just behind the initial RAM, aligned to 1GB
> 
> Note the inital RAM and the device memory may be disjoint due to
> misalignment of the initial ram size against 1GB
> 
> On ARM, we would have 3.0 virt machine supporting only initial RAM from
> 1GB to 256 GB. 3.1 (or beyond ;-)) virt machine would support the same
> initial RAM + device memory from 2TB to 4TB.
> 
> With that memory split and the different machine type, I don't see any
> major hurdle with respect to migration. Do I miss something?
Later on someone with a need to punch holes in fixed initial RAM/device memory,
starts making it complex.

> Alternative to have a split model is having a floating RAM base for a
> contiguous initial + device memory (contiguity actually depends on
> initial RAM size alignment too). This requires significant changes in FW
> and also potentially impacts the legacy virt address map as we need to
> pass the RAM floating base address in some way (using an SRAM at 1GB) or
> using fw_cfg. Is it worth the effort? Also, Peter/Laszlo mentioned their
> reluctance to move the RAM earlier
Drew is working on it, lets see outcome first.

We actually may try implement single region that uses pc-dimm for
all memory (including initial) and be still compatible with legacy layout
as far as legacy mode sticks to the current RAM limit and device memory
region is put at the current RAM base.
When flexible RAM base is available, we will move that region to
non legacy layout at 2TB (or wherever).

> (https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg03172.html).
> 
> Your feedbacks on those points are really welcome!
> 
> Thanks
> 
> Eric
> 
> > 
> > This series reuses/rebases patches initially submitted by Shameer in [1]
> > and Kwangwoo in [2].
> > 
> > I put all parts all together for consistency and due to dependencies
> > however as soon as the kernel dependency is resolved we can consider
> > upstreaming them separately.
> > 
> > Support more than 40b IPA/GPA [ patches 1 - 5 ]
> > -----------------------------------------------
> > was "[RFC 0/6] KVM/ARM: Dynamic and larger GPA size"
> > 
> > At the moment the guest physical address space is limited to 40b
> > due to KVM limitations. [0] bumps this limitation and allows to
> > create a VM with up to 52b GPA address space.
> > 
> > With this series, QEMU creates a virt VM with the max IPA range
> > reported by the host kernel or 40b by default.
> > 
> > This choice can be overriden by using the -machine kvm-type=<bits>
> > option with bits within [40, 52]. If <bits> are not supported by
> > the host, the legacy 40b value is used.
> > 
> > Currently the EDK2 FW also hardcodes the max number of GPA bits to
> > 40. This will need to be fixed.
> > 
> > PCDIMM Support [ patches 6 - 11 ]
> > ---------------------------------
> > was "[RFC 0/5] ARM virt: Support PC-DIMM at 2TB"
> > 
> > We instantiate the device_memory at 2TB. Using it obviously requires
> > at least 42b of IPA/GPA. While its max capacity is currently limited
> > to 2TB, the actual size depends on the initial guest RAM size and
> > maxmem parameter.
> > 
> > Actual hot-plug and hot-unplug of PC-DIMM is not suported due to lack
> > of support of those features in baremetal.
> > 
> > NVDIMM support [ patches 12 - 15 ]
> > ----------------------------------
> > 
> > Once the memory hotplug framework is in place it is fairly
> > straightforward to add support for NVDIMM. the machine "nvdimm" option
> > turns the capability on.
> > 
> > Best Regards
> > 
> > Eric
> > 
> > References:
> > 
> > [0] [PATCH v3 00/20] arm64: Dynamic & 52bit IPA support
> > https://www.spinics.net/lists/kernel/msg2841735.html
> > 
> > [1] [RFC v2 0/6] hw/arm: Add support for non-contiguous iova regions
> > http://patchwork.ozlabs.org/cover/914694/
> > 
> > [2] [RFC PATCH 0/3] add nvdimm support on AArch64 virt platform
> > https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04599.html
> > 
> > Tests:
> > - On Cavium Gigabyte, a 48b VM was created.
> > - Migration tests were performed between kernel supporting the
> >   feature and destination kernel not suporting it
> > - test with ACPI: to overcome the limitation of EDK2 FW, virt
> >   memory map was hacked to move the device memory below 1TB.
> > 
> > This series can be found at:
> > https://github.com/eauger/qemu/tree/v2.12.0-dimm-2tb-v3
> > 
> > History:
> > 
> > v2 -> v3:
> > - fix pc_q35 and pc_piix compilation error
> > - kwangwoo's email being not valid anymore, remove his address
> > 
> > v1 -> v2:
> > - kvm_get_max_vm_phys_shift moved in arch specific file
> > - addition of NVDIMM part
> > - single series
> > - rebase on David's refactoring
> > 
> > v1:
> > - was "[RFC 0/6] KVM/ARM: Dynamic and larger GPA size"
> > - was "[RFC 0/5] ARM virt: Support PC-DIMM at 2TB"
> > 
> > Best Regards
> > 
> > Eric
> > 
> > 
> > Eric Auger (9):
> >   linux-headers: header update for KVM/ARM KVM_ARM_GET_MAX_VM_PHYS_SHIFT
> >   hw/boards: Add a MachineState parameter to kvm_type callback
> >   kvm: add kvm_arm_get_max_vm_phys_shift
> >   hw/arm/virt: support kvm_type property
> >   hw/arm/virt: handle max_vm_phys_shift conflicts on migration
> >   hw/arm/virt: Allocate device_memory
> >   acpi: move build_srat_hotpluggable_memory to generic ACPI source
> >   hw/arm/boot: Expose the pmem nodes in the DT
> >   hw/arm/virt: Add nvdimm and nvdimm-persistence options
> > 
> > Kwangwoo Lee (2):
> >   nvdimm: use configurable ACPI IO base and size
> >   hw/arm/virt: Add nvdimm hot-plug infrastructure
> > 
> > Shameer Kolothum (4):
> >   hw/arm/virt: Add memory hotplug framework
> >   hw/arm/boot: introduce fdt_add_memory_node helper
> >   hw/arm/boot: Expose the PC-DIMM nodes in the DT
> >   hw/arm/virt-acpi-build: Add PC-DIMM in SRAT
> > 
> >  accel/kvm/kvm-all.c                            |   2 +-
> >  default-configs/arm-softmmu.mak                |   4 +
> >  hw/acpi/aml-build.c                            |  51 ++++
> >  hw/acpi/nvdimm.c                               |  28 ++-
> >  hw/arm/boot.c                                  | 123 +++++++--
> >  hw/arm/virt-acpi-build.c                       |  10 +
> >  hw/arm/virt.c                                  | 330 ++++++++++++++++++++++---
> >  hw/i386/acpi-build.c                           |  49 ----
> >  hw/i386/pc_piix.c                              |   8 +-
> >  hw/i386/pc_q35.c                               |   8 +-
> >  hw/ppc/mac_newworld.c                          |   2 +-
> >  hw/ppc/mac_oldworld.c                          |   2 +-
> >  hw/ppc/spapr.c                                 |   2 +-
> >  include/hw/acpi/aml-build.h                    |   3 +
> >  include/hw/arm/arm.h                           |   2 +
> >  include/hw/arm/virt.h                          |   7 +
> >  include/hw/boards.h                            |   2 +-
> >  include/hw/mem/nvdimm.h                        |  12 +
> >  include/standard-headers/linux/virtio_config.h |  16 +-
> >  linux-headers/asm-mips/unistd.h                |  18 +-
> >  linux-headers/asm-powerpc/kvm.h                |   1 +
> >  linux-headers/linux/kvm.h                      |  16 ++
> >  target/arm/kvm.c                               |   9 +
> >  target/arm/kvm_arm.h                           |  16 ++
> >  24 files changed, 597 insertions(+), 124 deletions(-)
> >   
> 
