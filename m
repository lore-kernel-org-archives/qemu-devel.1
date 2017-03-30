Received: from eggs.gnu.org ([2001:4830:134:3::10]:37842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ctYiF-0003oX-HR
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ctYiB-00030E-MW
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:57:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34603)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ctYiB-0002zo-E4
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:57:55 -0400
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-15-git-send-email-peterx@redhat.com>
	<A2975661238FB949B60364EF0F2C257439032C79@shsmsx102.ccr.corp.intel.com>
	<20170327091208.GG11497@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257439032D78@shsmsx102.ccr.corp.intel.com>
	<A2975661238FB949B60364EF0F2C25743903553F@shsmsx102.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9c3cda64-b4a3-6f9b-f951-bf73f6613faa@redhat.com>
Date: Thu, 30 Mar 2017 19:57:38 +0800
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743903553F@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 14/17] memory: add
 MemoryRegionIOMMUOps.replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>, 'Peter Xu' <peterx@redhat.com>
Cc: "'alex.williamson@redhat.com'" <alex.williamson@redhat.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, "'mst@redhat.com'" <mst@redhat.com>, "'jan.kiszka@siemens.com'" <jan.kiszka@siemens.com>, "'bd.aviv@gmail.com'" <bd.aviv@gmail.com>, 'David Gibson' <david@gibson.dropbear.id.au>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>



On 2017=E5=B9=B403=E6=9C=8830=E6=97=A5 19:06, Liu, Yi L wrote:
>> -----Original Message-----
>> From: Liu, Yi L
>> Sent: Monday, March 27, 2017 5:22 PM
>> To: Peter Xu <peterx@redhat.com>
>> Cc: alex.williamson@redhat.com; Lan, Tianyu <tianyu.lan@intel.com>; Ti=
an, Kevin
>> <kevin.tian@intel.com>; mst@redhat.com; jan.kiszka@siemens.com;
>> jasowang@redhat.com; bd.aviv@gmail.com; David Gibson
>> <david@gibson.dropbear.id.au>; qemu-devel@nongnu.org
>> Subject: RE: [Qemu-devel] [PATCH v7 14/17] memory: add
>> MemoryRegionIOMMUOps.replay() callback
>>
>>> -----Original Message-----
>>> From: Peter Xu [mailto:peterx@redhat.com]
>>> Sent: Monday, March 27, 2017 5:12 PM
>>> To: Liu, Yi L <yi.l.liu@intel.com>
>>> Cc: alex.williamson@redhat.com; Lan, Tianyu <tianyu.lan@intel.com>;
>>> Tian, Kevin <kevin.tian@intel.com>; mst@redhat.com;
>>> jan.kiszka@siemens.com; jasowang@redhat.com; bd.aviv@gmail.com; David
>>> Gibson <david@gibson.dropbear.id.au>; qemu-devel@nongnu.org
>>> Subject: Re: [Qemu-devel] [PATCH v7 14/17] memory: add
>>> MemoryRegionIOMMUOps.replay() callback
>>>
>>> On Mon, Mar 27, 2017 at 08:35:05AM +0000, Liu, Yi L wrote:
>>>>> -----Original Message-----
>>>>> From: Qemu-devel
>>>>> [mailto:qemu-devel-bounces+yi.l.liu=3Dintel.com@nongnu.org] On
>>>>> Behalf Of Peter Xu
>>>>> Sent: Tuesday, February 7, 2017 4:28 PM
>>>>> To: qemu-devel@nongnu.org
>>>>> Cc: Lan, Tianyu <tianyu.lan@intel.com>; Tian, Kevin
>>>>> <kevin.tian@intel.com>; mst@redhat.com; jan.kiszka@siemens.com;
>>>>> jasowang@redhat.com; peterx@redhat.com;
>>>>> alex.williamson@redhat.com; bd.aviv@gmail.com; David Gibson
>>>>> <david@gibson.dropbear.id.au>
>>>>> Subject: [Qemu-devel] [PATCH v7 14/17] memory: add
>>>>> MemoryRegionIOMMUOps.replay() callback
>>>>>
>>>>> Originally we have one memory_region_iommu_replay() function,
>>>>> which is the default behavior to replay the translations of the
>>>>> whole IOMMU region. However, on some platform like x86, we may
>>>>> want our own
>>> replay logic for IOMMU regions.
>>>>> This patch add one more hook for IOMMUOps for the callback, and
>>>>> it'll override the default if set.
>>>>>
>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>> ---
>>>>>   include/exec/memory.h | 2 ++
>>>>>   memory.c              | 6 ++++++
>>>>>   2 files changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/include/exec/memory.h b/include/exec/memory.h index
>>>>> 0767888..30b2a74 100644
>>>>> --- a/include/exec/memory.h
>>>>> +++ b/include/exec/memory.h
>>>>> @@ -191,6 +191,8 @@ struct MemoryRegionIOMMUOps {
>>>>>       void (*notify_flag_changed)(MemoryRegion *iommu,
>>>>>                                   IOMMUNotifierFlag old_flags,
>>>>>                                   IOMMUNotifierFlag new_flags);
>>>>> +    /* Set this up to provide customized IOMMU replay function */
>>>>> +    void (*replay)(MemoryRegion *iommu, IOMMUNotifier *notifier);
>>>>>   };
>>>>>
>>>>>   typedef struct CoalescedMemoryRange CoalescedMemoryRange; diff
>>>>> --git a/memory.c b/memory.c index 7a4f2f9..9c253cc 100644
>>>>> --- a/memory.c
>>>>> +++ b/memory.c
>>>>> @@ -1630,6 +1630,12 @@ void
>>>>> memory_region_iommu_replay(MemoryRegion
>>>>> *mr, IOMMUNotifier *n,
>>>>>       hwaddr addr, granularity;
>>>>>       IOMMUTLBEntry iotlb;
>>>>> +    /* If the IOMMU has its own replay callback, override */
>>>>> +    if (mr->iommu_ops->replay) {
>>>>> +        mr->iommu_ops->replay(mr, n);
>>>>> +        return;
>>>>> +    }
>>>> Hi Alex, Peter,
>>>>
>>>> Will all the other vendors(e.g. PPC, s390, ARM) add their own replay
>>>> callback as well? I guess it depends on whether the original replay
>>>> algorithm work well for them? Do you have such knowledge?
>>> I guess so. At least for VT-d we had this callback since the default
>>> replay mechanism did not work well on x86 due to its extremely large
>>> memory region size. Thanks,
>> thx. that would make sense.
> Peter,
>
> Just come to mind that there may be a corner case here.
>
> Intel VT-d actually has a "pt" mode which allows device use physical ad=
dress
> even when VT-d is enabled. In kernel, there is a iommu_identity_mapping=
.
> If a device is in this map, then it would use "pt" mode. So that IOMMU =
driver
> would not build second-level page table for it.

Yes, but qemu does not support ECAP_PT now, so guest will still have a=20
page table in this case.

>
> Back to the virtual IOVA implementation, if an assigned device is in th=
e
> iommu_identity_mapping(e.g. VGA controller), it uses GPA directly to do=
 DMA.
> So it demands a GPA->HPA mapping in host. However, the iommu->ops.repla=
y
> is not able to build it when guest SL page table is empty.
>
> So I think building an entire guest PA->HPA mapping before guest kernel=
 boot
> would be recommended. Any thoughts?

We plan to add PT in 2.10, a possible rough idea is disabled iommu dmar=20
region and use another region without iommu_ops. Then=20
vfio_listener_region_add() will just do the correct mappings.

Thanks

>
> Regards,
> Yi L
