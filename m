Received: from eggs.gnu.org ([2001:4830:134:3::10]:60319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTr4S-0003aa-9n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fTr4R-0000qS-68
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:55:28 -0400
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
	<20180516152026.2920-7-shameerali.kolothum.thodi@huawei.com>
	<bd67ed40-81d6-58dc-ccaf-efd8a40ca96f@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8386F6E04@FRAEML521-MBX.china.huawei.com>
	<20180615154441.4rr5mtcnran5cf3s@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5723678f-fe68-2567-2827-beb63ac58598@redhat.com>
Date: Fri, 15 Jun 2018 17:55:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180615154441.4rr5mtcnran5cf3s@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 6/6] hw/arm: Populate non-contiguous
 memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, Linuxarm <linuxarm@huawei.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>

Hi Drew,

On 06/15/2018 05:44 PM, Andrew Jones wrote:
> On Tue, Jun 05, 2018 at 07:49:44AM +0000, Shameerali Kolothum Thodi wrote:
>>>> On 05/16/2018 05:20 PM, Shameer Kolothum wrote:
>>>>> In case valid iova regions are non-contiguous, split the
>>>>> RAM mem into a 1GB non-pluggable dimm and remaining as a
>>>>> single pc-dimm mem.
>>>>
>>>> Please can you explain where does this split come from? Currently we
>>>> have 254 GB non pluggable RAM. I read the discussion started with Drew
>>>> on RFC v1 where he explained we cannot change the RAM base without
>>>> crashing the FW. However we should at least document this  1GB split.
>>>
>>> The comments were mainly to use the pc-dimm model instead of "mem alias"
>>> method used on RFC v1 as this will help to add the mem hot-plug support
>>> in future.
>>>
>>> I am not sure about the motive behind Drew's idea of splitting the first
>>> 1GB as non-plug and remaining as a pc-dimm(cold). May it is to attempt a
>>> best effort scenario, but as I mentioned in reply to 0/6, the current solution
>>> will end up changing the base address if the 0x4000000 falls under a reserved
>>> region.
>>>
>>> Again, not sure whether we should enforce a strict check on base address
>>> start or just warn the user that it will fail on Guest with UEFI boot[1].
>>>
>>> Hi Drew,
>>>
>>> Please let me know your thoughts on this.
>>
>> Could you please take a look at the above discussion and let us
>> know your thoughts on the split of mem regions as 1GB non-pluggable
>> and rest as pc-dimm.
>>
> 
> Hi Shameer,
> 
> Sorry for the slow reply - I've been slowly catching back up after
> vacation. There are two reasons to have one non-pluggable memory region
> and the rest of memory in a single pluggable pc-dimm.
> 
> 1) For mach-virt we must have the base of memory at the 1G boundary,
>    both because otherwise we'll break ArmVirt UEFI and because that's
>    a guarantee that Peter has stated he'd like to keep for mach-virt.
> 
> 2) Memory split in this way already has precedent in the x86 PC
>    machine models.
> 
> It's debatable how much memory we should allocate to the non-pluggable
> region. It doesn't need to be 1G, it could be smaller. The default
> memory size allocated to a mach-virt guest that doesn't provide '-m'
> on the command line is 128M. Maybe we should use that size?
> 
> If 0x40000000 falls into a reserved address region on some host, then
> I'm afraid the mach-virt model won't work with those devices unless the
> guest doesn't use UEFI and Peter is open to providing a machine property
> that one can enable in order to move the base address of memory.
> 
> I know Eric is looking at this problem too. I hope you guys are
> coordinating your efforts.

Yes we sync'ed together. I will send an RFC beginning of next week
addressing both
- support of >40b PA VM (based on Suzuki's series)
- addition of DIMM at 2TB, reusing the standard PC-DIMM hotplug
framework. This is something standard and similar to what is done on PC
Q35. I am reusing some of Shameer's patches, rebased on top of Igor and
David recent works.

Then we need to understand how we can use 2 hotplug regions. This is not
obvsious to me as the framework currently uses a dedicated MemoryRegion,
if I understand it correctly.

Thanks

Eric
> 
> Thanks,
> drew
> 
