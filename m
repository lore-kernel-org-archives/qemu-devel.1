Received: from eggs.gnu.org ([2001:4830:134:3::10]:56573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faR2m-0008KU-BD
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faR2l-0003bL-8p
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:32:56 -0400
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
	<1530602398-16127-6-git-send-email-eric.auger@redhat.com>
	<8495014b-5811-4f4f-5af3-d065cd6561b7@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2513e4a9-8980-6274-b933-a5e107b32da5@redhat.com>
Date: Tue, 3 Jul 2018 21:32:40 +0200
MIME-Version: 1.0
In-Reply-To: <8495014b-5811-4f4f-5af3-d065cd6561b7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 05/15] hw/arm/virt: handle
 max_vm_phys_shift conflicts on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com
Cc: wei@redhat.com, drjones@redhat.com, david@gibson.dropbear.id.au, dgilbert@redhat.com, agraf@suse.de

Hi David,
On 07/03/2018 08:41 PM, David Hildenbrand wrote:
> On 03.07.2018 09:19, Eric Auger wrote:
>> When migrating a VM, we must make sure the destination host
>> supports as many IPA bits as the source. Otherwise the migration
>> must fail.
>>
>> We add a VMState infrastructure to machvirt. On pre_save(),
>> the current source max_vm_phys_shift is saved.
>>
>> On destination, we cannot use this information when creating the
>> VM. The VM is created using the max value reported by the
>> destination host - or the kvm_type inherited value -. However on
>> post_load() we can check that this value is compatible with the
>> source saved value.
> 
> Just wondering, how exactly is the guest able to detect the 42b (e.g. vs
> 42b) configuration?

the source IPA size is saved in the VMState. When restoring it on
post_load we check against the current IPA size (corresponding to the
max the destination KVM does support). The destination IPA size is
chosen before creating the destination VM. If the destination IPA size
is less than the source IPA size, we fail the migration.

Hope this helps

Thanks

Eric

> 
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/virt.c         | 37 +++++++++++++++++++++++++++++++++++++
>>  include/hw/arm/virt.h |  2 ++
>>  2 files changed, 39 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 04a32de..5a4d0bf 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1316,6 +1316,40 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>>      return arm_cpu_mp_affinity(idx, clustersz);
>>  }
>>  
>> +static int virt_post_load(void *opaque, int version_id)
>> +{
>> +    VirtMachineState *vms = (VirtMachineState *)opaque;
>> +
>> +    if (vms->max_vm_phys_shift < vms->source_max_vm_phys_shift) {
>> +        error_report("This host kernel only supports %d IPA bits whereas "
>> +                     "the guest requires %d GPA bits", vms->max_vm_phys_shift,
>> +                     vms->source_max_vm_phys_shift);
>> +        return -1;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int virt_pre_save(void *opaque)
>> +{
>> +    VirtMachineState *vms = (VirtMachineState *)opaque;
>> +
>> +    vms->source_max_vm_phys_shift = vms->max_vm_phys_shift;
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_virt = {
>> +    .name = "virt",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .post_load = virt_post_load,
>> +    .pre_save = virt_pre_save,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_INT32(source_max_vm_phys_shift, VirtMachineState),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>> +
>>  static void machvirt_init(MachineState *machine)
>>  {
>>      VirtMachineState *vms = VIRT_MACHINE(machine);
>> @@ -1537,6 +1571,7 @@ static void machvirt_init(MachineState *machine)
>>  
>>      vms->machine_done.notify = virt_machine_done;
>>      qemu_add_machine_init_done_notifier(&vms->machine_done);
>> +    vmstate_register(NULL, 0, &vmstate_virt, vms);
>>  }
>>  
>>  static bool virt_get_secure(Object *obj, Error **errp)
>> @@ -1727,6 +1762,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>>  
>>  static int virt_kvm_type(MachineState *ms, const char *type_str)
>>  {
>> +    VirtMachineState *vms = VIRT_MACHINE(ms);
>>      int max_vm_phys_shift, ret = 0;
>>      uint64_t type;
>>  
>> @@ -1747,6 +1783,7 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
>>      }
>>      ret = max_vm_phys_shift;
>>  out:
>> +    vms->max_vm_phys_shift = (max_vm_phys_shift > 0) ? ret : 40;
>>      return ret;
>>  }
>>  
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 1a90ffc..91f6de2 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -125,6 +125,8 @@ typedef struct {
>>      uint32_t iommu_phandle;
>>      int psci_conduit;
>>      char *kvm_type;
>> +    int32_t max_vm_phys_shift;
>> +    int32_t source_max_vm_phys_shift;
>>  } VirtMachineState;
>>  
>>  #define VIRT_ECAM_ID(high) (high ? VIRT_PCIE_ECAM_HIGH : VIRT_PCIE_ECAM)
>>
> 
> 
