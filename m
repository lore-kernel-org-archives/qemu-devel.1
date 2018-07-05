Received: from eggs.gnu.org ([2001:4830:134:3::10]:46535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fb2eV-0002yO-E0
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fb2eU-0007Oa-56
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:42:23 -0400
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
	<1530602398-16127-7-git-send-email-eric.auger@redhat.com>
	<a856ba3a-c211-5f35-4023-97ef73eb5c31@redhat.com>
	<df091f31-6f85-64d8-0c3b-7fd463d31c63@redhat.com>
	<43c1349e-1ca6-4890-07c0-7bfa35ab914d@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5311fed5-7f13-a177-b967-db6e3ed028b9@redhat.com>
Date: Thu, 5 Jul 2018 13:42:08 +0200
MIME-Version: 1.0
In-Reply-To: <43c1349e-1ca6-4890-07c0-7bfa35ab914d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 06/15] hw/arm/virt: Allocate device_memory
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

On 07/04/2018 02:05 PM, David Hildenbrand wrote:
> On 03.07.2018 21:27, Auger Eric wrote:
>> Hi David,
>> On 07/03/2018 08:25 PM, David Hildenbrand wrote:
>>> On 03.07.2018 09:19, Eric Auger wrote:
>>>> We define a new hotpluggable RAM region (aka. device memory).
>>>> Its base is 2TB GPA. This obviously requires 42b IPA support
>>>> in KVM/ARM, FW and guest kernel. At the moment the device
>>>> memory region is max 2TB.
>>>
>>> Maybe a stupid question, but why exactly does it have to start at 2TB
>>> (and not e.g. at 1TB)?
>> not a stupid question. See tentative answer below.
>>>
>>>>
>>>> This is largely inspired of device memory initialization in
>>>> pc machine code.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
>>>> ---
>>>>  hw/arm/virt.c         | 104 ++++++++++++++++++++++++++++++++++++--------------
>>>>  include/hw/arm/arm.h  |   2 +
>>>>  include/hw/arm/virt.h |   1 +
>>>>  3 files changed, 79 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>> index 5a4d0bf..6fefb78 100644
>>>> --- a/hw/arm/virt.c
>>>> +++ b/hw/arm/virt.c
>>>> @@ -59,6 +59,7 @@
>>>>  #include "qapi/visitor.h"
>>>>  #include "standard-headers/linux/input.h"
>>>>  #include "hw/arm/smmuv3.h"
>>>> +#include "hw/acpi/acpi.h"
>>>>  
>>>>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>>>>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
>>>> @@ -94,34 +95,25 @@
>>>>  
>>>>  #define PLATFORM_BUS_NUM_IRQS 64
>>>>  
>>>> -/* RAM limit in GB. Since VIRT_MEM starts at the 1GB mark, this means
>>>> - * RAM can go up to the 256GB mark, leaving 256GB of the physical
>>>> - * address space unallocated and free for future use between 256G and 512G.
>>>> - * If we need to provide more RAM to VMs in the future then we need to:
>>>> - *  * allocate a second bank of RAM starting at 2TB and working up
>> I acknowledge this comment was the main justification. Now if you look at
>>
>> Principles of ARM Memory Maps
>> http://infocenter.arm.com/help/topic/com.arm.doc.den0001c/DEN0001C_principles_of_arm_memory_maps.pdf
>> chapter 2.3 you will find that when adding PA bits, you always leave
>> space for reserved space and mapped IO.
> 
> Thanks for the pointer!
> 
> So ... we can fit
> 
> a) 2GB at 2GB
> b) 32GB at 32GB
> c) 512GB at 512GB
> d) 8TB at 8TB
> e) 128TB at 128TB
> 
> (this is a nice rule of thumb if I understand it correctly :) )
> 
> We should strive for device memory (maxram_size - ram_size) to fit
> exactly into one of these slots (otherwise things get nasty).
> 
> Depending on the ram_size, we might have simpler setups and can support
> more configurations, no?
> 
> E.g. ram_size <= 34GB, device_memory <= 512GB
> -> move ram into a) and b)
> -> move device memory into c)

The issue is machvirt doesn't comply with that document.
At the moment we have
0 -> 1GB MMIO
1GB -> 256GB RAM
256GB -> 512GB is theoretically reserved for IO but most is free.
512GB -> 1T is reserved for ECAM MMIO range. This is the top of our
existing 40b GPA space.

We don't want to change this address map due to legacy reasons.

Another question! do you know if it would be possible to have
device_memory region split into several discontinuous segments?

Thanks

Eric
> 
> We should make up our mind right from the beginning how our setup will
> look, so we can avoid (possibly complicated) compatibility handling
> later on.
> 
>>
>> On the other hand, if you look at chapter 5, "Proposed 44-bit and 48bit
>> Address Maps", we should logically put the additional RAM at 8TB if we
>> want to comply with that doc.
> 
> I agree, 2TB es in the reserved area.
> 
>>
>> Peter, was there any other justification why we should put the RAM at 2TB?
>>
>> Thanks
>>
>> Eric
> 
> 
