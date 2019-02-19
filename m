Received: from eggs.gnu.org ([209.51.188.92]:40001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gw7lc-0003T4-2p
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gw7lb-0002bh-6m
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:57:08 -0500
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-15-eric.auger@redhat.com>
	<20190218103155.2b74e0a2@Igors-MacBook-Pro.local>
	<852c526c-42fd-4ff4-d00e-1a44e1561e67@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f635f102-7aaf-db1d-fc17-b1d8cb5b01b6@redhat.com>
Date: Tue, 19 Feb 2019 16:56:58 +0100
MIME-Version: 1.0
In-Reply-To: <852c526c-42fd-4ff4-d00e-1a44e1561e67@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 14/18] hw/arm/virt: Allocate
 device_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, drjones@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au

On 19.02.19 16:53, Auger Eric wrote:
> Hi Igor,
> 
> On 2/18/19 10:31 AM, Igor Mammedov wrote:
>> On Tue,  5 Feb 2019 18:33:02 +0100
>> Eric Auger <eric.auger@redhat.com> wrote:
>>
>>> The device memory region is located after the initial RAM.
>>> its start/size are 1GB aligned.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
>>>
>>> ---
>>> v4 -> v5:
>>> - device memory set after the initial RAM
>>>
>>> v3 -> v4:
>>> - remove bootinfo.device_memory_start/device_memory_size
>>> - rename VIRT_HOTPLUG_MEM into VIRT_DEVICE_MEM
>>> ---
>>>  hw/arm/virt.c | 36 ++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 36 insertions(+)
>>>
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 783468ba77..b683902991 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -61,6 +61,7 @@
>>>  #include "hw/arm/smmuv3.h"
>>>  #include "hw/mem/pc-dimm.h"
>>>  #include "hw/mem/nvdimm.h"
>>> +#include "hw/acpi/acpi.h"
>>>  
>>>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>>>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
>>> @@ -1260,6 +1261,37 @@ static void create_secure_ram(VirtMachineState *vms,
>>>      g_free(nodename);
>>>  }
>>>  
>>> +static void create_device_memory(VirtMachineState *vms, MemoryRegion *sysmem)
>>> +{
>>> +    MachineState *ms = MACHINE(vms);
>>> +    uint64_t device_memory_size = ms->maxram_size - ms->ram_size;
>> should size it with 1Gb alignment per slot from the start (to avoid x86 mistakes),
>> see enforce_aligned_dimm usage and associated commit for more details
> I don't understand the computation done in pc machine. eventually we are
> likely to have more device memory than requested by the user. Why don't
> we check (machine->maxram_size - machine->ram_size) >=
> machine->ram_slots * GiB
> instead of adding 1GiB/slot to the initial user requirements?

This is to be able to potentially align each slot as far as I know, so
the "memory device address space" cannot that easily be fragmented.

E.g. Linux requires a certain alignment to make full use of a DIMM.

> 
> Also machine->maxram_size - machine->ram_size is checked to be aligned
> with TARGET_PAGE_SIZE. Is TARGET_PAGE_SIZE representative of the guest
> PAGE in accelerated mode? Is it valid ro require an alignment on 1GB
> boundary as I do in this patch?

I guess the alignment check is only done because for that target,
anything having sub-page granularity cannot be used either way.

-- 

Thanks,

David / dhildenb
