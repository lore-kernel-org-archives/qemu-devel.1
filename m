Received: from eggs.gnu.org ([209.51.188.92]:51358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gvqU6-0004hu-32
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gvqU4-0000DS-Sk
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:29:54 -0500
From: Auger Eric <eric.auger@redhat.com>
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-10-eric.auger@redhat.com>
	<CAFEAcA-d1nMJkFpWmbVD7i=FF8C8irzNkLpOukkGx4=i=g_MTQ@mail.gmail.com>
Message-ID: <4b104c37-58f4-76c1-1141-8952523ae0d7@redhat.com>
Date: Mon, 18 Feb 2019 22:29:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-d1nMJkFpWmbVD7i=FF8C8irzNkLpOukkGx4=i=g_MTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 09/18] hw/arm/virt: Implement kvm_type
 function for 4.0 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

Hi Peter,

On 2/14/19 6:29 PM, Peter Maydell wrote:
> On Tue, 5 Feb 2019 at 17:33, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> This patch implements the machine class kvm_type() callback.
>> It returns the max IPA shift needed to implement the whole GPA
>> range including the RAM and IO regions located beyond.
>> The returned value in passed though the KVM_CREATE_VM ioctl and
>> this allows KVM to set the stage2 tables dynamically.
>>
>> At this stage the RAM limit still is limited to 255GB.
>>
>> Setting all the existing highmem IO regions beyond the RAM
>> allows to have a single contiguous RAM region (initial RAM and
>> possible hotpluggable device memory). That way we do not need
>> to do invasive changes in the EDK2 FW to support a dynamic
>> RAM base.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v5 -> v6:
>> - add some comments
>> - high IO region cannot start before 256GiB
>> ---
>>  hw/arm/virt.c         | 52 +++++++++++++++++++++++++++++++++++++++++--
>>  include/hw/arm/virt.h |  2 ++
>>  2 files changed, 52 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 2b15839d0b..b90ffc2e5d 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1366,6 +1366,7 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>>
>>  static void virt_set_memmap(VirtMachineState *vms)
>>  {
>> +    MachineState *ms = MACHINE(vms);
>>      hwaddr base;
>>      int i;
>>
>> @@ -1375,7 +1376,17 @@ static void virt_set_memmap(VirtMachineState *vms)
>>          vms->memmap[i] = a15memmap[i];
>>      }
>>
>> -    vms->high_io_base = 256 * GiB; /* Top of the legacy initial RAM region */
>> +    /*
>> +     * We now compute the base of the high IO region depending on the
>> +     * amount of initial and device memory. The device memory start/size
>> +     * is aligned on 1GiB. We never put the high IO region below 256GiB
>> +     * so that if maxram_size is < 255GiB we keep the legacy memory map
>> +     */
>> +    vms->high_io_base = ROUND_UP(GiB + ms->ram_size, GiB) +
>> +                        ROUND_UP(ms->maxram_size - ms->ram_size, GiB);
> 
> I don't understand this expression...
My intent was to align the start of the device memory on a GiB boundary,
just after the initial RAM (ram_size). And then align the floating IO
region on a GiB boundary after the device memory (of size
ms->maxram_size - ms->ram_size). What do I miss?
> 
>> +    if (vms->high_io_base < 256 * GiB) {
>> +        vms->high_io_base = 256 * GiB;
>> +    }
>>      base = vms->high_io_base;
>>
>>      for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
>> @@ -1386,6 +1397,7 @@ static void virt_set_memmap(VirtMachineState *vms)
>>          vms->memmap[i].size = size;
>>          base += size;
>>      }
>> +    vms->highest_gpa = base - 1;
>>  }
>>
>>  static void machvirt_init(MachineState *machine)
>> @@ -1402,7 +1414,9 @@ static void machvirt_init(MachineState *machine)
>>      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
>>      bool aarch64 = true;
>>
>> -    virt_set_memmap(vms);
>> +    if (!vms->extended_memmap) {
>> +        virt_set_memmap(vms);
>> +    }
>>
>>      /* We can probe only here because during property set
>>       * KVM is not available yet
>> @@ -1784,6 +1798,36 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>>      return NULL;
>>  }
>>
>> +/*
>> + * for arm64 kvm_type [7-0] encodes the IPA size shift
>> + */
>> +static int virt_kvm_type(MachineState *ms, const char *type_str)
>> +{
>> +    VirtMachineState *vms = VIRT_MACHINE(ms);
>> +    int max_vm_phys_shift = kvm_arm_get_max_vm_phys_shift(ms);
>> +    int max_pa_shift;
>> +
>> +    vms->extended_memmap = true;
>> +
>> +    virt_set_memmap(vms);
>> +
>> +    max_pa_shift = 64 - clz64(vms->highest_gpa);
>> +
>> +    if (max_pa_shift > max_vm_phys_shift) {
>> +        error_report("-m and ,maxmem option values "
>> +                     "require an IPA range (%d bits) larger than "
>> +                     "the one supported by the host (%d bits)",
>> +                     max_pa_shift, max_vm_phys_shift);
>> +       exit(1);
>> +    }
> 
> Presumably we should have some equivalent check for TCG, so
> that we don't let the user create a setup which wants more
> bits of physical address than the TCG CPU allows ?
kvm_type() sets the new memory map. For TCG we should stick to the 1TB
GPA address space which should be consistent with the existing
ID_AA64MMFR0_EL1 settings (arm/internals.h implements arm_pamax(ARMCPU
*cpu) which decodes hardcoded cpu->id_aa64mmfr0).
> 
>> +    /*
>> +     * By default we return 0 which corresponds to an implicit legacy
>> +     * 40b IPA setting. Otherwise we return the actual requested IPA
>> +     * logsize
>> +     */
>> +    return max_pa_shift > 40 ? max_pa_shift : 0;
>> +}
>> +
>>  static void virt_machine_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -1808,6 +1852,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>>      mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
>>      mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
>>      mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
>> +    mc->kvm_type = virt_kvm_type;
>>      assert(!mc->get_hotplug_handler);
>>      mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>>      hc->plug = virt_machine_device_plug_cb;
>> @@ -1911,6 +1956,9 @@ static void virt_machine_3_1_options(MachineClass *mc)
>>  {
>>      virt_machine_4_0_options(mc);
>>      compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
>> +
>> +    /* extended memory map is enabled from 4.0 onwards */
>> +    mc->kvm_type = NULL;
> 
> When is there a difference between setting this to NULL,
> and setting it to virt_kvm_type but having the memory
> size be <= 256GiB ?
There shouldn't be any difference. When size <= 255GiB we stick to the
1TB PA address space.
> 
> If there isn't any difference, why can't we just let the
> pre-4.0 versions behave like the new ones? No existing
> VM setup will have > 256GB of memory, so as long as there's
> no behaviour change for the <=256GB case we don't need to
> take special effort to ensure that the >256GB case continues
> to give an error message, do we ?
But don't we want to forbid any pre-4.0 machvirt to run with more than
255GiB RAM?

Thanks

Eric
> 
>>  }
>>  DEFINE_VIRT_MACHINE(3, 1)
>>
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 3dc7a6c5d5..c88f67a492 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -132,6 +132,8 @@ typedef struct {
>>      uint32_t iommu_phandle;
>>      int psci_conduit;
>>      hwaddr high_io_base;
>> +    hwaddr highest_gpa;
>> +    bool extended_memmap;
>>  } VirtMachineState;
>>
>>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
>> --
>> 2.20.1
> 
> thanks
> -- PMM
> 
