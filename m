Received: from eggs.gnu.org ([209.51.188.92]:58827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h0rD8-0005YW-KL
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h0rD6-0000x2-Qd
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:17:06 -0500
References: <20190304101339.25970-1-eric.auger@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a90df8ae-503e-227a-2f4a-3bd61e4da99f@redhat.com>
Date: Mon, 4 Mar 2019 18:11:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190304101339.25970-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 00/10] ARM virt: Initial RAM expansion
 and extended memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com, pbonzini@redhat.com

Hi Peter,

On 3/4/19 11:13 AM, Eric Auger wrote:
> This series aims to bump the 255GB RAM limit in machvirt and paves the
> way to device memory addition.
> 
> In machvirt versions < 4.0, the initial RAM starts at 1GB and can
> grow up to 255GB. From 256GB onwards we find IO regions such as the
> additional GICv3 RDIST region, high PCIe ECAM region and high PCIe
> MMIO region. The address map was 1TB large. This corresponded to
> the max IPA capacity KVM was able to manage.
> 
> Since 4.20, the host kernel is able to support a larger and dynamic
> IPA range. So the guest physical address can go beyond the 1TB. The
> max GPA size depends on the host kernel configuration and physical CPUs.
> 
> In this series we use this feature and allow the RAM to grow without
> any other limit than the one put by the host kernel.
> 
> The RAM still starts at 1GB. First comes the initial ram (-m) of size
> ram_size and then we provision sufficient space for the looming
> device memory (dimensionned using ,maxmem and slots options).
> 
> IO regions previously located between 256GB and 1TB are moved after
> the RAM. Their offset is dynamically computed, depends on ram_size,
> slots, maxram_size. Size alignment is enforced.
> 
> In case maxmem value is inferior to 255GB, the legacy memory map
> still is used.
> 
> As we keep the initial RAM at 1GB base address, we do not need to do
> invasive changes in the EDK2 FW. It seems nobody is eager to do
> that job at the moment.
> 
> Device memory being put just after the initial RAM, it will be
> possible to get access to this feature while keeping a 1TB address
> map.
> 
> Best Regards
> 
> Eric
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/v3.1.0-extended-memmap-v12
> 
> History:
> v11 -> v12:
> - collected last Igor's and Richard's R-b's
> - removed the memmap initialization to NULL

I collected all the R-b's I received from Igor and Richard and I removed
the PCDIMM/NVDIMM integration. Please let me know if you have some
remaining comments so that this series hopefully lands in the next release.

Thanks

Eric
> 
> v10 -> v11:
> - remove vms->high_io_base
> - remove RAM_BASE
> - see individual change logs for other adjustments
> 
> v9 -> v10:
> - only the keep the first 10 patches which move to the extended memmap
> - remove the 1GB alignment check on maxram_size
> 
> v8 -> v9:
> - fixed make check SIGSEV
> - fixed TCG issue (restored virt_set_memmap in machvirt_init)
> - removed Igor's R-b on "hw/arm/boot: Expose the PC-DIMM nodes in the DT"
> 
> v7 -> v8:
> - addressed Igor's comments"
> - remove no_extended_memmap knob
> - moved acpi_nvdimm_state into MachineState
> - separate "hw/arm/virt: Check the VCPU PA range in TCG mode" patch
> 
> v6 -> v7:
> - Addressed Peter and Igor comments (exceptions sent my email)
> - Fixed TCG case. Now device memory works also for TCG and vcpu
>   pamax is checked
> - See individual logs for more details
> 
> v5 -> v6:
> - mingw compilation issue fix
> - kvm_arm_get_max_vm_phys_shift always returns the number of supported
>   IPA bits
> - new patch "hw/arm/virt: Rename highmem IO regions" that eases the review
>   of "hw/arm/virt: Split the memory map description"
> - "hw/arm/virt: Move memory map initialization into machvirt_init"
>   squashed into the previous patch
> - change alignment of IO regions beyond the RAM so that it matches their
>   size
> 
> v4 -> v5:
> - change in the memory map
> - see individual logs
> 
> v3 -> v4:
> - rebase on David's "pc-dimm: next bunch of cleanups" and
>   "pc-dimm: pre_plug "slot" and "addr" assignment"
> - kvm-type option not used anymore. We directly use
>   maxram_size and ram_size machine fields to compute the
>   MAX IPA range. Migration is naturally handled as CLI
>   option are kept between source and destination. This was
>   suggested by David.
> - device_memory_start and device_memory_size not stored
>   anymore in vms->bootinfo
> - I did not take into account 2 Igor's comments: the one
>   related to the refactoring of arm_load_dtb and the one
>   related to the generation of the dtb after system_reset
>   which would contain nodes of hotplugged devices (we do
>   not support hotplug at this stage)
> - check the end-user does not attempt to hotplug a device
> - addition of "vl: Set machine ram_size, maxram_size and
>   ram_slots earlier"
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
> Eric Auger (9):
>   hw/arm/virt: Rename highmem IO regions
>   hw/arm/virt: Split the memory map description
>   hw/boards: Add a MachineState parameter to kvm_type callback
>   kvm: add kvm_arm_get_max_vm_ipa_size
>   vl: Set machine ram_size, maxram_size and ram_slots earlier
>   hw/arm/virt: Dynamic memory map depending on RAM requirements
>   hw/arm/virt: Implement kvm_type function for 4.0 machine
>   hw/arm/virt: Check the VCPU PA range in TCG mode
>   hw/arm/virt: Bump the 255GB initial RAM limit
> 
> Shameer Kolothum (1):
>   hw/arm/boot: introduce fdt_add_memory_node helper
> 
>  accel/kvm/kvm-all.c      |   2 +-
>  hw/arm/boot.c            |  54 +++++++----
>  hw/arm/virt-acpi-build.c |  10 +-
>  hw/arm/virt.c            | 196 +++++++++++++++++++++++++++++++--------
>  hw/ppc/mac_newworld.c    |   3 +-
>  hw/ppc/mac_oldworld.c    |   2 +-
>  hw/ppc/spapr.c           |   2 +-
>  include/hw/arm/virt.h    |  16 +++-
>  include/hw/boards.h      |   5 +-
>  target/arm/kvm.c         |  10 ++
>  target/arm/kvm_arm.h     |  13 +++
>  vl.c                     |   6 +-
>  12 files changed, 241 insertions(+), 78 deletions(-)
> 
