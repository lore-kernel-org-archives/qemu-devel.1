Received: from eggs.gnu.org ([2001:4830:134:3::10]:34168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Tomasz.Nowicki@cavium.com>) id 1dtshk-0003nk-Cm
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Tomasz.Nowicki@cavium.com>) id 1dtshj-0000HV-8v
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:51:04 -0400
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-14-git-send-email-eric.auger@redhat.com>
	<20170914092751.GA3336@virtx40>
	<4dbbccae-64e1-f4ac-4dcc-3abd9766f324@caviumnetworks.com>
	<795d99ba-e492-04ce-dda4-709682baf6cd@caviumnetworks.com>
	<4f9fc697-9e6c-5dd7-65c7-92326135aa56@redhat.com>
	<MWHPR0701MB3660656E62CF668F057621A7F36C0@MWHPR0701MB3660.namprd07.prod.outlook.com>
	<64e946b3-8fb6-b918-e389-1a01c084fb47@redhat.com>
From: Tomasz Nowicki <tnowicki@caviumnetworks.com>
Message-ID: <eae88f57-d570-86d8-cbca-fd5b266c07d8@caviumnetworks.com>
Date: Mon, 18 Sep 2017 11:50:39 +0200
MIME-Version: 1.0
In-Reply-To: <64e946b3-8fb6-b918-e389-1a01c084fb47@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v7 13/20] hw/arm/smmuv3:
 Implement IOMMU memory region replay callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, tn <Tomasz.Nowicki@caviumnetworks.com>, Linu Cherian <linuc.decode@gmail.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com, mohun106@gmail.com, drjones@redhat.com, tcain@qti.qualcomm.com, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mst@redhat.com, jean-philippe.brucker@arm.com, will.deacon@arm.com, robin.murphy@arm.com, peterx@redhat.com, bharat.bhushan@nxp.com, christoffer.dall@linaro.org, wtownsen@redhat.com, linu.cherian@cavium.com

Hi Eric,

On 15.09.2017 16:50, Auger Eric wrote:
> Hi,
> 
> On 15/09/2017 12:42, tn wrote:
>> Hi Eric,
>>
>> On 15.09.2017 09:30, Auger Eric wrote:
>>> Hi Tomasz,
>>>
>>> On 14/09/2017 16:43, Tomasz Nowicki wrote:
>>>> On 14.09.2017 16:31, Tomasz Nowicki wrote:
>>>>> Hi Eric,
>>>>>
>>>>> On 14.09.2017 11:27, Linu Cherian wrote:
>>>>>> Hi Eric,
>>>>>>
>>>>>> On Fri Sep 01, 2017 at 07:21:16PM +0200, Eric Auger wrote:
>>>>>>> memory_region_iommu_replay() is used for VFIO integration.
>>>>>>>
>>>>>>> However its default implementation is not adapted to SMMUv3
>>>>>>> IOMMU memory region. Indeed the input address range is too
>>>>>>> huge and its execution is too slow as it calls the translate()
>>>>>>> callback on each granule.
>>>>>>>
>>>>>>> Let's implement the replay callback which hierarchically walk
>>>>>>> over the page table structure and notify only the segments
>>>>>>> that are populated with valid entries.
>>>>>>>
>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>> ---
>>>>>>>     hw/arm/smmuv3.c     | 36 ++++++++++++++++++++++++++++++++++++
>>>>>>>     hw/arm/trace-events |  1 +
>>>>>>>     2 files changed, 37 insertions(+)
>>>>>>>
>>>>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>>>>> index 8e7d10d..c43bd93 100644
>>>>>>> --- a/hw/arm/smmuv3.c
>>>>>>> +++ b/hw/arm/smmuv3.c
>>>>>>> @@ -657,6 +657,41 @@ static int smmuv3_notify_entry(IOMMUTLBEntry
>>>>>>> *entry, void *private)
>>>>>>>         return 0;
>>>>>>>     }
>>>>>>> +/* Unmap the whole notifier's range */
>>>>>>> +static void smmuv3_unmap_notifier_range(IOMMUNotifier *n)
>>>>>>> +{
>>>>>>> +    IOMMUTLBEntry entry;
>>>>>>> +    hwaddr size = n->end - n->start + 1;
>>>>>>> +
>>>>>>> +    entry.target_as = &address_space_memory;
>>>>>>> +    entry.iova = n->start & ~(size - 1);
>>>>>>> +    entry.perm = IOMMU_NONE;
>>>>>>> +    entry.addr_mask = size - 1;
>>>>>>> +
>>>>>>> +    memory_region_notify_one(n, &entry);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void smmuv3_replay(IOMMUMemoryRegion *mr, IOMMUNotifier *n)
>>>>>>> +{
>>>>>>> +    SMMUTransCfg cfg = {};
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    trace_smmuv3_replay(mr->parent_obj.name, n, n->start, n->end);
>>>>>>> +    smmuv3_unmap_notifier_range(n);
>>>>>>> +
>>>>>>> +    ret = smmuv3_decode_config(mr, &cfg);
>>>>>>> +    if (ret) {
>>>>>>> +        error_report("%s error decoding the configuration for iommu
>>>>>>> mr=%s",
>>>>>>> +                     __func__, mr->parent_obj.name);
>>>>>>> +    }
>>>>>>>
>>>>>>
>>>>>> On an invalid config being found, shouldnt we return rather than
>>>>>> proceeding with
>>>>>> page table walk. For example on an invalid Stream table entry.
>>>>>
>>>>> Indeed, without return here vhost case is not working for me.
>>>>
>>>> I was just lucky one time. return here has no influence. Vhost still not
>>>> working. Sorry for noise.
>>>
>>> As far as I understand the replay() callback only is called in VFIO use
>>> case. So this shouldn't impact vhost.
>>>
>>> I can't reproduce your vhost issue on my side. I will review the
>>> invalidate code again and compare against the last version.
>>>
>>> What is the page size used by your guest?
>>
>> 64K page size for guest as well as for host.
>>
>> However, I've just checked 4K page size for guest and then vhost is
>> working fine.
> So the bug stems from the incorrect target page size used on
> SMMU_CMD_TLBI_NH_VA invalidation. This is now corrected by using the
> actual config granule size and this fixes the issue with vhost use case
> and 64KB page guest. I will release this fix early next week. Sorry for
> the inconvenience.
> 

Yes, that was it. I will provide my t-b for the next series version.

Thanks,
Tomasz
