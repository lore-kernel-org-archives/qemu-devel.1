Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3F2C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888E620739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="axHbL3gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888E620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFN79-00044W-K7
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 15:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jFN6X-0003Zk-1m
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jFN6V-0003SP-6S
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:14:48 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jFN6U-0003LC-Vd
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:14:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7515f10000>; Fri, 20 Mar 2020 12:13:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 20 Mar 2020 12:14:44 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 20 Mar 2020 12:14:44 -0700
Received: from [10.40.103.10] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Mar
 2020 19:14:36 +0000
Subject: Re: [PATCH v14 Kernel 5/7] vfio iommu: Update UNMAP_DMA ioctl to get
 dirty bitmap before unmap
To: Alex Williamson <alex.williamson@redhat.com>, Yan Zhao
 <yan.y.zhao@intel.com>
References: <1584560474-19946-1-git-send-email-kwankhede@nvidia.com>
 <1584560474-19946-6-git-send-email-kwankhede@nvidia.com>
 <20200320083529.GA5456@joy-OptiPlex-7040> <20200320094039.4d99408d@w520.home>
 <20200320094727.12aba30e@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <aa76ad96-394f-f1fb-2e8d-a453bd69a39b@nvidia.com>
Date: Sat, 21 Mar 2020 00:44:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320094727.12aba30e@w520.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1584731634; bh=528tuGcpedSGkPlvPwNWSbpIROZ1laa2lT/gg/YXaIg=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=axHbL3gw8Sdcu+OIXj4NIBQh3CzlDWLI9C4uen2Seu0T9zHCDS4pOJPqYuMpZu82w
 BUXy3lcF81arZL0OHNyq0wVQa5OQB/JGbfu/wf4eSAXQ3wRhO2hjlyR8fpPLAHrEdv
 yUQm5M4YYpvVIr1VJP1f5wtwFdu0h8NnfsDRVpM2SOE6xMFmHUpB/P+5nnJcnP1Dix
 p9xGt28b11xGTwVzrjqxXytzJ6xbvRasbzRvm80b6xAFWBmY56E4+LEtZEGJmm+Byf
 +5goJjLtKuunOzKi7Ci2WwNEBjqw5LpwN35+/mLnB76NhU7UUnr4ey7/LZWlLylvJY
 cqjYXZNhgZSDQ==
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
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/20/2020 9:17 PM, Alex Williamson wrote:
> On Fri, 20 Mar 2020 09:40:39 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
>> On Fri, 20 Mar 2020 04:35:29 -0400
>> Yan Zhao <yan.y.zhao@intel.com> wrote:
>>
>>> On Thu, Mar 19, 2020 at 03:41:12AM +0800, Kirti Wankhede wrote:
>>>> DMA mapped pages, including those pinned by mdev vendor drivers, might
>>>> get unpinned and unmapped while migration is active and device is still
>>>> running. For example, in pre-copy phase while guest driver could access
>>>> those pages, host device or vendor driver can dirty these mapped pages.
>>>> Such pages should be marked dirty so as to maintain memory consistency
>>>> for a user making use of dirty page tracking.
>>>>
>>>> To get bitmap during unmap, user should set flag
>>>> VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP, bitmap memory should be allocated and
>>>> zeroed by user space application. Bitmap size and page size should be set
>>>> by user application.
>>>>
>>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>>>> ---
>>>>   drivers/vfio/vfio_iommu_type1.c | 55 ++++++++++++++++++++++++++++++++++++++---
>>>>   include/uapi/linux/vfio.h       | 11 +++++++++
>>>>   2 files changed, 62 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>> index d6417fb02174..aa1ac30f7854 100644
>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>> @@ -939,7 +939,8 @@ static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
>>>>   }
>>>>   
>>>>   static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>>> -			     struct vfio_iommu_type1_dma_unmap *unmap)
>>>> +			     struct vfio_iommu_type1_dma_unmap *unmap,
>>>> +			     struct vfio_bitmap *bitmap)
>>>>   {
>>>>   	uint64_t mask;
>>>>   	struct vfio_dma *dma, *dma_last = NULL;
>>>> @@ -990,6 +991,10 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>>>   	 * will be returned if these conditions are not met.  The v2 interface
>>>>   	 * will only return success and a size of zero if there were no
>>>>   	 * mappings within the range.
>>>> +	 *
>>>> +	 * When VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP flag is set, unmap request
>>>> +	 * must be for single mapping. Multiple mappings with this flag set is
>>>> +	 * not supported.
>>>>   	 */
>>>>   	if (iommu->v2) {
>>>>   		dma = vfio_find_dma(iommu, unmap->iova, 1);
>>>> @@ -997,6 +1002,13 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>>>   			ret = -EINVAL;
>>>>   			goto unlock;
>>>>   		}
>>>> +
>>>> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
>>>> +		    (dma->iova != unmap->iova || dma->size != unmap->size)) {
>>> dma is probably NULL here!
>>
>> Yep, I didn't look closely enough there.  This is situated right
>> between the check to make sure we're not bisecting a mapping at the
>> start of the unmap and the check to make sure we're not bisecting a
>> mapping at the end of the unmap.  There's no guarantee that we have a
>> valid pointer here.  The test should be in the while() loop below this
>> code.
> 
> Actually the test could remain here, we can exit here if we can't find
> a dma at the start of the unmap range with the GET_DIRTY_BITMAP flag,
> but we absolutely cannot deref dma without testing it.
> 

In the check above newly added check, if dma is NULL then its an error 
condition, because Unmap requests must fully cover previous mappings, right?

>>> And this restriction on UNMAP would make some UNMAP operations of vIOMMU
>>> fail.
>>>
>>> e.g. below condition indeed happens in reality.
>>> an UNMAP ioctl comes for IOVA range from 0xff800000, of size 0x200000
>>> However, IOVAs in this range are mapped page by page.i.e., dma->size is 0x1000.
>>>
>>> Previous, this UNMAP ioctl could unmap successfully as a whole.
>>
>> What triggers this in the guest?  Note that it's only when using the
>> GET_DIRTY_BITMAP flag that this is restricted.  Does the event you're
>> referring to potentially occur under normal circumstances in that mode?
>> Thanks,
>>

Such unmap would callback vfio_iommu_map_notify() in QEMU. In 
vfio_iommu_map_notify(), unmap is called on same range <iova, 
iotlb->addr_mask + 1> which was used for map. Secondly unmap with bitmap 
will be called only when device state has _SAVING flag set.

Thanks,
Kirti

