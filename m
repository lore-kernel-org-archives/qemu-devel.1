Received: from eggs.gnu.org ([209.51.188.92]:35560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gvnNE-0007FD-Sk
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gvnND-0000lQ-TU
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:10:36 -0500
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-12-eric.auger@redhat.com>
	<278b9b9a-f299-1ce2-2a9d-566ef406c1c7@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <791bf4ec-aa80-b296-7140-84fa1c46a06f@redhat.com>
Date: Mon, 18 Feb 2019 19:10:13 +0100
MIME-Version: 1.0
In-Reply-To: <278b9b9a-f299-1ce2-2a9d-566ef406c1c7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 11/18] hw/arm/virt: Add memory hotplug
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
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

Hi David,

On 2/14/19 6:15 PM, David Hildenbrand wrote:
> On 05.02.19 18:32, Eric Auger wrote:
>> This patch adds the the memory hot-plug/hot-unplug infrastructure
>> in machvirt. It is still not enabled as no device memory is allocated.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
>>
>> ---
>> v4 -> v5:
>> - change in pc_dimm_pre_plug signature
>> - CONFIG_MEM_HOTPLUG replaced by CONFIG_MEM_DEVICE and CONFIG_DIMM
>>
>> v3 -> v4:
>> - check the memory device is not hotplugged
>>
>> v2 -> v3:
>> - change in pc_dimm_plug()'s signature
>> - add pc_dimm_pre_plug call
>>
>> v1 -> v2:
>> - s/virt_dimm_plug|unplug/virt_memory_plug|unplug
>> - s/pc_dimm_memory_plug/pc_dimm_plug
>> - reworded title and commit message
>> - added pre_plug cb
>> - don't handle get_memory_region failure anymore
>> ---
>>  default-configs/arm-softmmu.mak |  2 ++
>>  hw/arm/virt.c                   | 64 ++++++++++++++++++++++++++++++++-
>>  2 files changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>> index be88870799..dc4624794f 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -160,3 +160,5 @@ CONFIG_PCI_DESIGNWARE=y
>>  CONFIG_STRONGARM=y
>>  CONFIG_HIGHBANK=y
>>  CONFIG_MUSICPAL=y
>> +CONFIG_MEM_DEVICE=y
>> +CONFIG_DIMM=y
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index f01886da22..783468ba77 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -59,6 +59,8 @@
>>  #include "qapi/visitor.h"
>>  #include "standard-headers/linux/input.h"
>>  #include "hw/arm/smmuv3.h"
>> +#include "hw/mem/pc-dimm.h"
>> +#include "hw/mem/nvdimm.h"
>>  
>>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
>> @@ -1763,6 +1765,49 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>>      return ms->possible_cpus;
>>  }
>>  
>> +static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>> +                                 Error **errp)
>> +{
>> +    const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>> +
>> +    if (dev->hotplugged) {
>> +        error_setg(errp, "memory hotplug is not supported");
>> +    }
>> +
>> +    if (is_nvdimm) {
>> +        error_setg(errp, "nvdimm is not yet supported");
>> +        return;
>> +    }
>> +
>> +    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
>> +}
>> +
>> +static void virt_memory_plug(HotplugHandler *hotplug_dev,
>> +                             DeviceState *dev, Error **errp)
>> +{
>> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>> +    Error *local_err = NULL;
>> +
>> +    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
>> +
>> +    error_propagate(errp, local_err);
>> +}
>> +
>> +static void virt_memory_unplug(HotplugHandler *hotplug_dev,
>> +                               DeviceState *dev, Error **errp)
>> +{
>> +    pc_dimm_unplug(PC_DIMM(dev), MACHINE(hotplug_dev));
>> +    object_unparent(OBJECT(dev));
> 
> Please note that this will soon change with
> 
> [PATCH RFCv2 0/9] qdev: Hotplug handler chaining + virtio-pmem
> 
> What you'll have to do then is to replace the object_unparent by a
> 
> object_property_set_bool(OBJECT(dev), false, "realized", NULL);
Noted.

Thanks for the heads up!

Eric
> 
> 
