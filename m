Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870ACC2D0F2
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A4A20772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UmExCIHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A4A20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJhmY-0007BX-Ct
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 14:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jJhj8-0001nL-6B
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jJhj5-0004s6-R7
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:04:33 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11222)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jJhj5-0004ml-8x
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:04:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e84d77b0000>; Wed, 01 Apr 2020 11:03:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 01 Apr 2020 11:04:29 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 01 Apr 2020 11:04:29 -0700
Received: from [10.40.163.116] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Apr
 2020 18:04:20 +0000
Subject: Re: [PATCH v16 Kernel 5/7] vfio iommu: Update UNMAP_DMA ioctl to get
 dirty bitmap before unmap
To: Yan Zhao <yan.y.zhao@intel.com>
References: <1585078359-20124-1-git-send-email-kwankhede@nvidia.com>
 <1585078359-20124-6-git-send-email-kwankhede@nvidia.com>
 <20200325021800.GC20109@joy-OptiPlex-7040>
 <3cabb357-b9c5-f8b3-5d57-1178ec0dde5a@nvidia.com>
 <20200327000426.GA26419@joy-OptiPlex-7040>
 <b6524b4a-e6a0-7328-5003-7286f2fd61a8@nvidia.com>
 <20200330021506.GC30683@joy-OptiPlex-7040>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <ba44bbd6-aefa-9060-8153-b91b4cfd1404@nvidia.com>
Date: Wed, 1 Apr 2020 23:34:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330021506.GC30683@joy-OptiPlex-7040>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585764220; bh=MOnuluRkkIp2V7pG78z5TXRgfKzjDonC+wFs8RG+qvg=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=UmExCIHCWboYryVvMIkf8GSstxBWZtIMIoMRT6RBTwvlVh2GXBKeCOcN/IXfHU06j
 byWUI18ueJgJD7LEVWQP/pf5DCNGfZ+ncfB+EwBlY0DQnSyUm/GuZ0XHlQab+1Lw1B
 cGFP0fi4FL/Tl0GMils3+NNi46ZiyZ6De28DLA7ZopWiPeeEsPeDrWS+YtCBuThb8i
 08kp4XaYO83dEP/Uw1k9cDoBY32n3I6U9zrkBukPsqG/eCg0+K2i/5uQhQiUQxyFT4
 lyvtUkbVhwh/Onrgb8tmrbKntAqOTlFQBzAdM9STe2YKxL8Zl7CdysrJzttzgZn0an
 gevKtL9GZPa+A==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.64
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/30/2020 7:45 AM, Yan Zhao wrote:
> On Fri, Mar 27, 2020 at 12:42:43PM +0800, Kirti Wankhede wrote:
>>
>>
>> On 3/27/2020 5:34 AM, Yan Zhao wrote:
>>> On Fri, Mar 27, 2020 at 05:39:44AM +0800, Kirti Wankhede wrote:
>>>>
>>>>
>>>> On 3/25/2020 7:48 AM, Yan Zhao wrote:
>>>>> On Wed, Mar 25, 2020 at 03:32:37AM +0800, Kirti Wankhede wrote:
>>>>>> DMA mapped pages, including those pinned by mdev vendor drivers, might
>>>>>> get unpinned and unmapped while migration is active and device is still
>>>>>> running. For example, in pre-copy phase while guest driver could access
>>>>>> those pages, host device or vendor driver can dirty these mapped pages.
>>>>>> Such pages should be marked dirty so as to maintain memory consistency
>>>>>> for a user making use of dirty page tracking.
>>>>>>
>>>>>> To get bitmap during unmap, user should allocate memory for bitmap, set
>>>>>> size of allocated memory, set page size to be considered for bitmap and
>>>>>> set flag VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP.
>>>>>>
>>>>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>>>>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>>>>>> ---
>>>>>>     drivers/vfio/vfio_iommu_type1.c | 54 ++++++++++++++++++++++++++++++++++++++---
>>>>>>     include/uapi/linux/vfio.h       | 10 ++++++++
>>>>>>     2 files changed, 60 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>>>> index 27ed069c5053..b98a8d79e13a 100644
>>>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>>>> @@ -982,7 +982,8 @@ static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
>>>>>>     }
>>>>>>     
>>>>>>     static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>>>>> -			     struct vfio_iommu_type1_dma_unmap *unmap)
>>>>>> +			     struct vfio_iommu_type1_dma_unmap *unmap,
>>>>>> +			     struct vfio_bitmap *bitmap)
>>>>>>     {
>>>>>>     	uint64_t mask;
>>>>>>     	struct vfio_dma *dma, *dma_last = NULL;
>>>>>> @@ -1033,6 +1034,10 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>>>>>     	 * will be returned if these conditions are not met.  The v2 interface
>>>>>>     	 * will only return success and a size of zero if there were no
>>>>>>     	 * mappings within the range.
>>>>>> +	 *
>>>>>> +	 * When VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP flag is set, unmap request
>>>>>> +	 * must be for single mapping. Multiple mappings with this flag set is
>>>>>> +	 * not supported.
>>>>>>     	 */
>>>>>>     	if (iommu->v2) {
>>>>>>     		dma = vfio_find_dma(iommu, unmap->iova, 1);
>>>>>> @@ -1040,6 +1045,13 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>>>>>     			ret = -EINVAL;
>>>>>>     			goto unlock;
>>>>>>     		}
>>>>>> +
>>>>>> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
>>>>>> +		    (dma->iova != unmap->iova || dma->size != unmap->size)) {
>>>>> potential NULL pointer!
>>>>>
>>>>> And could you address the comments in v14?
>>>>> How to handle DSI unmaps in vIOMMU
>>>>> (https://lore.kernel.org/kvm/20200323011041.GB5456@joy-OptiPlex-7040/)
>>>>>
>>>>
>>>> Sorry, I drafted reply to it, but I missed to send, it remained in my drafts
>>>>
>>>>    >
>>>>    > it happens in vIOMMU Domain level invalidation of IOTLB
>>>>    > (domain-selective invalidation, see vtd_iotlb_domain_invalidate() in
>>>> qemu).
>>>>    > common in VTD lazy mode, and NOT just happening once at boot time.
>>>>    > rather than invalidate page by page, it batches the page invalidation.
>>>>    > so, when this invalidation takes place, even higher level page tables
>>>>    > have been invalid and therefore it has to invalidate a bigger
>>>> combined range.
>>>>    > That's why we see IOVAs are mapped in 4k pages, but are unmapped in 2M
>>>>    > pages.
>>>>    >
>>>>    > I think those UNMAPs should also have GET_DIRTY_BIMTAP flag on, right?
>>>>
>>>>
>>>> vtd_iotlb_domain_invalidate()
>>>>      vtd_sync_shadow_page_table()
>>>>        vtd_sync_shadow_page_table_range(vtd_as, &ce, 0, UINT64_MAX)
>>>>          vtd_page_walk()
>>>>            vtd_page_walk_level() - walk over specific level for IOVA range
>>>>              vtd_page_walk_one()
>>>>                memory_region_notify_iommu()
>>>>                ...
>>>>                  vfio_iommu_map_notify()
>>>>
>>>> In the above trace, isn't page walk will take care of creating proper
>>>> IOTLB entry which should be same as created during mapping for that
>>>> IOTLB entry?
>>>>
>>> No. It does walk the page table, but as it's dsi (delay & batched unmap),
>>> pages table entry for a whole 2M (the higher level, not last level for 4K)
>>> range is invalid, so the iotlb->addr_mask what vfio_iommu_map_notify()
>>> receives is (2M - 1), not the same as the size for map.
>>>
>>
>> When do this happen? during my testing I never hit this case. How can I
>> hit this case?
> 
> Just common settings to enable vIOMMU:
> Qemu: -device intel-iommu,caching-mode=true
> guest kernel parameter: intel_iommu=on
> 
> (intel_iommu=on turns on lazy mode by default)
> 
> In lazy mode, guest notifies DMA MAP on page level, but notifies DMA UNMAPs
> in batch.
> with a pass-through NVMe, there are 89 DSI unmaps in 1 second for a typical fio.
> With a pass-through GPU, there 22 DSI unmaps in total for benchmark openArena
> (lasting around 55 secs)
>>
>> In this case, will adjacent whole vfio_dmas will be clubbed together or
>> will there be any intersection of vfio_dmas?
>>
> clubbed together.
> 

Even if support for clubbing bitmap together is added, still there will 
be limitation that clubbed vfio_dmas size shouldn't exceed INT_MAX pages.

Thanks,
Kirti

