Received: from eggs.gnu.org ([209.51.188.92]:59405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gwoBU-0007FV-L3
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gwo5E-0000PW-Kb
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:08:20 -0500
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-15-eric.auger@redhat.com>
	<20190218103155.2b74e0a2@Igors-MacBook-Pro.local>
	<852c526c-42fd-4ff4-d00e-1a44e1561e67@redhat.com>
	<20190221103610.0c2add1c@redhat.com>
	<e264b964-baa6-11e2-8e45-3238d412ca32@redhat.com>
	<4a921c15-43b8-e7dd-2a76-6b9e0fc7f084@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8758bd54-03f4-02b5-386d-ef3c3aee25f9@redhat.com>
Date: Thu, 21 Feb 2019 14:07:53 +0100
MIME-Version: 1.0
In-Reply-To: <4a921c15-43b8-e7dd-2a76-6b9e0fc7f084@redhat.com>
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
To: David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, drjones@redhat.com, dgilbert@redhat.com, shameerali.kolothum.thodi@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger.pro@gmail.com, david@gibson.dropbear.id.au

Hi David,

On 2/21/19 1:44 PM, David Hildenbrand wrote:
> On 21.02.19 13:37, Auger Eric wrote:
>> Hi Igor,
>>
>> On 2/21/19 10:36 AM, Igor Mammedov wrote:
>>> On Tue, 19 Feb 2019 16:53:22 +0100
>>> Auger Eric <eric.auger@redhat.com> wrote:
>>>
>>>> Hi Igor,
>>>>
>>>> On 2/18/19 10:31 AM, Igor Mammedov wrote:
>>>>> On Tue,  5 Feb 2019 18:33:02 +0100
>>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>>   
>>>>>> The device memory region is located after the initial RAM.
>>>>>> its start/size are 1GB aligned.
>>>>>>
>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
>>>>>>
>>>>>> ---
>>>>>> v4 -> v5:
>>>>>> - device memory set after the initial RAM
>>>>>>
>>>>>> v3 -> v4:
>>>>>> - remove bootinfo.device_memory_start/device_memory_size
>>>>>> - rename VIRT_HOTPLUG_MEM into VIRT_DEVICE_MEM
>>>>>> ---
>>>>>>  hw/arm/virt.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 36 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>>>> index 783468ba77..b683902991 100644
>>>>>> --- a/hw/arm/virt.c
>>>>>> +++ b/hw/arm/virt.c
>>>>>> @@ -61,6 +61,7 @@
>>>>>>  #include "hw/arm/smmuv3.h"
>>>>>>  #include "hw/mem/pc-dimm.h"
>>>>>>  #include "hw/mem/nvdimm.h"
>>>>>> +#include "hw/acpi/acpi.h"
>>>>>>  
>>>>>>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>>>>>>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
>>>>>> @@ -1260,6 +1261,37 @@ static void create_secure_ram(VirtMachineState *vms,
>>>>>>      g_free(nodename);
>>>>>>  }
>>>>>>  
>>>>>> +static void create_device_memory(VirtMachineState *vms, MemoryRegion *sysmem)
>>>>>> +{
>>>>>> +    MachineState *ms = MACHINE(vms);
>>>>>> +    uint64_t device_memory_size = ms->maxram_size - ms->ram_size;  
>>>>> should size it with 1Gb alignment per slot from the start (to avoid x86 mistakes),
>>>>> see enforce_aligned_dimm usage and associated commit for more details  
>>>> I don't understand the computation done in pc machine. eventually we are
>>>> likely to have more device memory than requested by the user. Why don't
>>>> we check (machine->maxram_size - machine->ram_size) >=
>>>> machine->ram_slots * GiB
>>>> instead of adding 1GiB/slot to the initial user requirements?
>>>>
>>>> Also machine->maxram_size - machine->ram_size is checked to be aligned
>>>> with TARGET_PAGE_SIZE. Is TARGET_PAGE_SIZE representative of the guest
>>>> PAGE in accelerated mode? Is it valid ro require an alignment on 1GB
>>>> boundary as I do in this patch?
>>> See commit 085f8e88b for explanation,
>>> What we are basically are doing there is sizing hotpluggbale address space
>>> to allow max possible huge page aligned DIMM to be successfully plugged in
>>> even if address space if fragmented.
>> In v7, I also added ram_slots * GiB to (maxram_size - ram_size).
>>
> 
> Depending on the way the system handles it, this might be confusing for
> the end user and has to be documented somewhere.
> 
> E.g. if there are certain memory limits (say 2TB) and the user specifies
> something like "maxmem=2TB,slots=20" it might be confusing if he gets an
> error like "more than 2TB are not supported".
I Agree. On ARM we also intend to put high IO regions above the RAM so
if we overshoot the host limit, we warn the user the memory map requires
more PA bits than the host can support and the end user is invited to
lower maxmem/slots.

Thanks

Eric
> 
>> Thanks
>>
>> Eric
