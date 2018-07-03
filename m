Received: from eggs.gnu.org ([2001:4830:134:3::10]:55189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faQyQ-0005WV-Bf
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faQyP-0000WH-9b
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:28:26 -0400
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
	<1530602398-16127-8-git-send-email-eric.auger@redhat.com>
	<b674de55-665d-9597-eebb-42983094f90c@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <19c64f9e-21ed-c070-8490-069d916fb771@redhat.com>
Date: Tue, 3 Jul 2018 21:28:16 +0200
MIME-Version: 1.0
In-Reply-To: <b674de55-665d-9597-eebb-42983094f90c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 07/15] hw/arm/virt: Add memory hotplug
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

Hi David,

On 07/03/2018 08:28 PM, David Hildenbrand wrote:
> On 03.07.2018 09:19, Eric Auger wrote:
>> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>
>> This patch adds the the memory hot-plug/hot-unplug infrastructure
>> in machvirt.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
>>
>> ---
>>
>> v1 -> v2:
>> - s/virt_dimm_plug|unplug/virt_memory_plug|unplug
>> - s/pc_dimm_memory_plug/pc_dimm_plug
>> - reworded title and commit message
>> - added pre_plug cb
>> - don't handle get_memory_region failure anymore
>> ---
>>  default-configs/arm-softmmu.mak |  2 ++
>>  hw/arm/virt.c                   | 68 ++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>> index 834d45c..28fe8f3 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -152,3 +152,5 @@ CONFIG_PCI_DESIGNWARE=y
>>  CONFIG_STRONGARM=y
>>  CONFIG_HIGHBANK=y
>>  CONFIG_MUSICPAL=y
>> +CONFIG_MEM_HOTPLUG=y
>> +
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 6fefb78..7190962 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -60,6 +60,8 @@
>>  #include "standard-headers/linux/input.h"
>>  #include "hw/arm/smmuv3.h"
>>  #include "hw/acpi/acpi.h"
>> +#include "hw/mem/pc-dimm.h"
>> +#include "hw/mem/nvdimm.h"
>>  
>>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
>> @@ -1785,6 +1787,53 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>>      return ms->possible_cpus;
>>  }
>>  
>> +static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>> +                                 Error **errp)
>> +{
>> +    const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>> +
>> +    if (is_nvdimm) {
>> +        error_setg(errp, "nvdimm is not yet supported");
>> +        return;
>> +    }
>> +}
>> +
>> +static void virt_memory_plug(HotplugHandler *hotplug_dev,
>> +                             DeviceState *dev, Error **errp)
>> +{
>> +    PCDIMMDevice *dimm = PC_DIMM(dev);
>> +    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>> +    MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
>> +    Error *local_err = NULL;
>> +    uint64_t align;
>> +
>> +    if (memory_region_get_alignment(mr)) {
>> +        align = memory_region_get_alignment(mr);
>> +    } else {
>> +        /* by default we align on 64KB page size */
>> +        align = SZ_64K;
>> +    }
> 
> After my latest re-factoring is applied
> 
> 1. memory_region_get_alignment(mr) will never be 0
> 2. alignment detection will be handled internally
> 
> So once you rebase to that version, just pass NULL for "*legacy_align"

Agreed. Thanks

Eric
> 
> 
