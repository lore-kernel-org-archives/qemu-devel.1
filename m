Received: from eggs.gnu.org ([2001:4830:134:3::10]:34886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ffm4n-0001Sa-MH
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ffm4m-0001Lb-1l
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:01:05 -0400
Date: Wed, 18 Jul 2018 15:00:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180718150044.4c542d21@redhat.com>
In-Reply-To: <6047361a-be99-fc7f-5270-5ab3b4ab84e2@redhat.com>
References: <43c1349e-1ca6-4890-07c0-7bfa35ab914d@redhat.com>
	<5311fed5-7f13-a177-b967-db6e3ed028b9@redhat.com>
	<405e3f2b-3044-d7fc-8df4-b07a8487470f@redhat.com>
	<f2d61062-21df-4478-bc61-c32e92329cf8@redhat.com>
	<57030c9f-c3d1-49a8-090e-d6b316e7a818@redhat.com>
	<fc6a29d4-1094-8d29-d415-fc30d5e30c31@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA838712003@FRAEML521-MBX.china.huawei.com>
	<fd7e2831-86a8-c2a1-fe0c-d9784bc2d3cb@redhat.com>
	<20180711151740.3d119e95@redhat.com>
	<5e65f669-69f6-53aa-0337-2825ce353b5e@redhat.com>
	<20180712144516.zsjvfrruduirzqug@kamzik.brq.redhat.com>
	<6047361a-be99-fc7f-5270-5ab3b4ab84e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Auger Eric <eric.auger@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, "wei@redhat.com" <wei@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "agraf@suse.de" <agraf@suse.de>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>

On Thu, 12 Jul 2018 16:53:01 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Drew,
> 
> On 07/12/2018 04:45 PM, Andrew Jones wrote:
> > On Thu, Jul 12, 2018 at 04:22:05PM +0200, Auger Eric wrote:  
> >> Hi Igor,
> >>
> >> On 07/11/2018 03:17 PM, Igor Mammedov wrote:  
> >>> On Thu, 5 Jul 2018 16:27:05 +0200
> >>> Auger Eric <eric.auger@redhat.com> wrote:
> >>>  
> >>>> Hi Shameer,
> >>>>
> >>>> On 07/05/2018 03:19 PM, Shameerali Kolothum Thodi wrote:  
> >>>>>     
> >>>>>> -----Original Message-----
> >>>>>> From: Auger Eric [mailto:eric.auger@redhat.com]
> >>>>>> Sent: 05 July 2018 13:18
> >>>>>> To: David Hildenbrand <david@redhat.com>; eric.auger.pro@gmail.com;
> >>>>>> qemu-devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> >>>>>> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> >>>>>> imammedo@redhat.com
> >>>>>> Cc: wei@redhat.com; drjones@redhat.com; david@gibson.dropbear.id.au;
> >>>>>> dgilbert@redhat.com; agraf@suse.de
> >>>>>> Subject: Re: [Qemu-devel] [RFC v3 06/15] hw/arm/virt: Allocate
> >>>>>> device_memory
> >>>>>>
> >>>>>> Hi David,
> >>>>>>
> >>>>>> On 07/05/2018 02:09 PM, David Hildenbrand wrote:    
> >>>>>>> On 05.07.2018 14:00, Auger Eric wrote:    
> >>>>>>>> Hi David,
> >>>>>>>>
> >>>>>>>> On 07/05/2018 01:54 PM, David Hildenbrand wrote:    
> >>>>>>>>> On 05.07.2018 13:42, Auger Eric wrote:    
> >>>>>>>>>> Hi David,
> >>>>>>>>>>
> >>>>>>>>>> On 07/04/2018 02:05 PM, David Hildenbrand wrote:    
> >>>>>>>>>>> On 03.07.2018 21:27, Auger Eric wrote:    
> >>>>>>>>>>>> Hi David,
> >>>>>>>>>>>> On 07/03/2018 08:25 PM, David Hildenbrand wrote:    
> >>>>>>>>>>>>> On 03.07.2018 09:19, Eric Auger wrote:    
> >>>>>>>>>>>>>> We define a new hotpluggable RAM region (aka. device memory).
> >>>>>>>>>>>>>> Its base is 2TB GPA. This obviously requires 42b IPA support
> >>>>>>>>>>>>>> in KVM/ARM, FW and guest kernel. At the moment the device
> >>>>>>>>>>>>>> memory region is max 2TB.    
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Maybe a stupid question, but why exactly does it have to start at 2TB
> >>>>>>>>>>>>> (and not e.g. at 1TB)?    
> >>>>>>>>>>>> not a stupid question. See tentative answer below.    
> >>>>>>>>>>>>>    
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> This is largely inspired of device memory initialization in
> >>>>>>>>>>>>>> pc machine code.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>>>>>>>>>>>> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>  hw/arm/virt.c         | 104    
> >>>>>> ++++++++++++++++++++++++++++++++++++--------------    
> >>>>>>>>>>>>>>  include/hw/arm/arm.h  |   2 +
> >>>>>>>>>>>>>>  include/hw/arm/virt.h |   1 +
> >>>>>>>>>>>>>>  3 files changed, 79 insertions(+), 28 deletions(-)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >>>>>>>>>>>>>> index 5a4d0bf..6fefb78 100644
> >>>>>>>>>>>>>> --- a/hw/arm/virt.c
> >>>>>>>>>>>>>> +++ b/hw/arm/virt.c
> >>>>>>>>>>>>>> @@ -59,6 +59,7 @@
> >>>>>>>>>>>>>>  #include "qapi/visitor.h"
> >>>>>>>>>>>>>>  #include "standard-headers/linux/input.h"
> >>>>>>>>>>>>>>  #include "hw/arm/smmuv3.h"
> >>>>>>>>>>>>>> +#include "hw/acpi/acpi.h"
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
> >>>>>>>>>>>>>>      static void virt_##major##_##minor##_class_init(ObjectClass *oc,    
> >>>>>> \    
> >>>>>>>>>>>>>> @@ -94,34 +95,25 @@
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>  #define PLATFORM_BUS_NUM_IRQS 64
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> -/* RAM limit in GB. Since VIRT_MEM starts at the 1GB mark, this    
> >>>>>> means    
> >>>>>>>>>>>>>> - * RAM can go up to the 256GB mark, leaving 256GB of the physical
> >>>>>>>>>>>>>> - * address space unallocated and free for future use between 256G    
> >>>>>> and 512G.    
> >>>>>>>>>>>>>> - * If we need to provide more RAM to VMs in the future then we    
> >>>>>> need to:    
> >>>>>>>>>>>>>> - *  * allocate a second bank of RAM starting at 2TB and working up    
> >>>>>>>>>>>> I acknowledge this comment was the main justification. Now if you look    
> >>>>>> at    
> >>>>>>>>>>>>
> >>>>>>>>>>>> Principles of ARM Memory Maps
> >>>>>>>>>>>>    
> >>>>>> http://infocenter.arm.com/help/topic/com.arm.doc.den0001c/DEN0001C_princ
> >>>>>> iples_of_arm_memory_maps.pdf    
> >>>>>>>>>>>> chapter 2.3 you will find that when adding PA bits, you always leave
> >>>>>>>>>>>> space for reserved space and mapped IO.    
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks for the pointer!
> >>>>>>>>>>>
> >>>>>>>>>>> So ... we can fit
> >>>>>>>>>>>
> >>>>>>>>>>> a) 2GB at 2GB
> >>>>>>>>>>> b) 32GB at 32GB
> >>>>>>>>>>> c) 512GB at 512GB
> >>>>>>>>>>> d) 8TB at 8TB
> >>>>>>>>>>> e) 128TB at 128TB
> >>>>>>>>>>>
> >>>>>>>>>>> (this is a nice rule of thumb if I understand it correctly :) )
> >>>>>>>>>>>
> >>>>>>>>>>> We should strive for device memory (maxram_size - ram_size) to fit
> >>>>>>>>>>> exactly into one of these slots (otherwise things get nasty).
> >>>>>>>>>>>
> >>>>>>>>>>> Depending on the ram_size, we might have simpler setups and can    
> >>>>>> support    
> >>>>>>>>>>> more configurations, no?
> >>>>>>>>>>>
> >>>>>>>>>>> E.g. ram_size <= 34GB, device_memory <= 512GB    
> >>>>>>>>>>> -> move ram into a) and b)
> >>>>>>>>>>> -> move device memory into c)    
> >>>>>>>>>>
> >>>>>>>>>> The issue is machvirt doesn't comply with that document.
> >>>>>>>>>> At the moment we have
> >>>>>>>>>> 0 -> 1GB MMIO
> >>>>>>>>>> 1GB -> 256GB RAM
> >>>>>>>>>> 256GB -> 512GB is theoretically reserved for IO but most is free.
> >>>>>>>>>> 512GB -> 1T is reserved for ECAM MMIO range. This is the top of our
> >>>>>>>>>> existing 40b GPA space.
> >>>>>>>>>>
> >>>>>>>>>> We don't want to change this address map due to legacy reasons.
[...]

> >> Also there is the problematic of migration. How
> >> would you migrate between guests whose RAM is not laid out at the same
> >> place?  
> > 
> > I'm not sure what you mean here. Boot a guest with a new memory map,
> > probably by explicitly asking for it with a new machine property,
> > which means a new virt machine version. Then migrate at will to any
> > host that supports that machine type.  
> My concern rather was about holes in the memory map matching reserved
> regions.
> >   
> >> I understood hotplug memory relied on a specific device_memory
> >> region. So do you mean we would have 2 contiguous regions?  
> > 
> > I think Igor wants one contiguous region for RAM, where additional
> > space can be reserved for hotplugging.  
> This is not compliant with 2012 ARM white paper, although I don't really
> know if this document truly is a reference (did not get any reply).
it's upto QEMU to pick layout, if we have maxmem (upto 256Gb) we could
accommodate legacy req and put single device_memory in 1Gb-256Gb GPA gap,
if it's more we can move whole device_memory to 2Tb, 8Tb ...
that keeps things manageable for us and fits specs (if such exist).
WE should make selection of the next RAM base deterministic is possible
when layout changes due to maxram size or IOVA, so that we won't need
to use compat knobs/checks to keep machine migratable.

[...]
