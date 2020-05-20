Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1D4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4C720671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EhYqs4zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4C720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQTc-0003NX-Nv
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbQSm-0002vl-FY
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:16:56 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbQSl-0002RJ-1d
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:16:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ec549960000>; Wed, 20 May 2020 08:15:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 20 May 2020 08:16:53 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 20 May 2020 08:16:53 -0700
Received: from [10.40.103.233] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May
 2020 15:16:44 +0000
Subject: Re: [PATCH Kernel v22 6/8] vfio iommu: Update UNMAP_DMA ioctl to get
 dirty bitmap before unmap
To: Cornelia Huck <cohuck@redhat.com>
References: <1589781397-28368-7-git-send-email-kwankhede@nvidia.com>
 <1589871253-10650-1-git-send-email-kwankhede@nvidia.com>
 <20200520122738.351985a3.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <fedde2aa-5a07-aa17-19ee-c8593b9aa730@nvidia.com>
Date: Wed, 20 May 2020 20:46:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520122738.351985a3.cohuck@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1589987734; bh=UJ9vV+YnL/NN4PI8KUO0yTGEg1V53ovlglfGsOtXyH4=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=EhYqs4zpl3mrgJKrTx0fOzycSqqfA200Z86tgfVl3Fbn5IiPRa1FmaoSucFOYfk8Y
 f+jXnpxcXrwX8DvQbzOfak/noS0xJYNLq6RQ9BZxFuoqGo23PVx7lowlMBpEJFvf+G
 Eitb3aBJt6nfnsJxo+bTVcGCPq7yvfp7sVwQ5yMvwzyKJ9BugiPNbjt7ZHBje6FTwR
 uS7kfAq/DOR4IXldqgnxJCtoNp+IEmU+IOFyMq2LlxkIinb0G53aVl8AWo3rxeuT2D
 8NxKy9nEHoylkAEqPrUIvNXGVLnbx0WCZsXUArGWmTx8TijzBCzeE8XU4SKmElNjbT
 TdsS50pXWFLKA==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 09:40:22
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 alex.williamson@redhat.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/20/2020 3:57 PM, Cornelia Huck wrote:
> On Tue, 19 May 2020 12:24:13 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> DMA mapped pages, including those pinned by mdev vendor drivers, might
>> get unpinned and unmapped while migration is active and device is still
>> running. For example, in pre-copy phase while guest driver could access
>> those pages, host device or vendor driver can dirty these mapped pages.
>> Such pages should be marked dirty so as to maintain memory consistency
>> for a user making use of dirty page tracking.
>>
>> To get bitmap during unmap, user should allocate memory for bitmap, set
>> it all zeros, set size of allocated memory, set page size to be
>> considered for bitmap and set flag VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 62 +++++++++++++++++++++++++++++++++--------
>>   include/uapi/linux/vfio.h       | 10 +++++++
>>   2 files changed, 61 insertions(+), 11 deletions(-)
> 
> (...)
> 
>> @@ -1085,6 +1093,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>   			ret = -EINVAL;
>>   			goto unlock;
>>   		}
>> +
> 
> Nit: unrelated whitespace change.
> 
>>   		dma = vfio_find_dma(iommu, unmap->iova + unmap->size - 1, 0);
>>   		if (dma && dma->iova + dma->size != unmap->iova + unmap->size) {
>>   			ret = -EINVAL;
> 
> (...)
> 
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 4850c1fef1f8..a1dd2150971e 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1048,12 +1048,22 @@ struct vfio_bitmap {
>>    * field.  No guarantee is made to the user that arbitrary unmaps of iova
>>    * or size different from those used in the original mapping call will
>>    * succeed.
>> + * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get dirty bitmap
> 
> s/dirty bitmap/the dirty bitmap/
> 
>> + * before unmapping IO virtual addresses. When this flag is set, user must
> 
> s/user/the user/
> 
>> + * provide data[] as structure vfio_bitmap. User must allocate memory to get
> 
> "provide a struct vfio_bitmap in data[]" ?
> 
> 
>> + * bitmap, zero the bitmap memory and must set size of allocated memory in
>> + * vfio_bitmap.size field.
> 
> "The user must provide zero-allocated memory via vfio_bitmap.data and
> its size in the vfio_bitmap.size field." ?
> 
> 
>> A bit in bitmap represents one page of user provided
> 
> s/bitmap/the bitmap/
> 
>> + * page size in 'pgsize', consecutively starting from iova offset. Bit set
> 
> s/Bit set/A set bit/
> 
>> + * indicates page at that offset from iova is dirty. Bitmap of pages in the
> 
> s/indicates page/indicates that the page/
> 
>> + * range of unmapped size is returned in vfio_bitmap.data
> 
> "A bitmap of the pages in the range of the unmapped size is returned in
> the user-provided vfio_bitmap.data." ?
> 
>>    */
>>   struct vfio_iommu_type1_dma_unmap {
>>   	__u32	argsz;
>>   	__u32	flags;
>> +#define VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP (1 << 0)
>>   	__u64	iova;				/* IO virtual address */
>>   	__u64	size;				/* Size of mapping (bytes) */
>> +	__u8    data[];
>>   };
>>   
>>   #define VFIO_IOMMU_UNMAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 14)
> 
> With the nits addressed,

Done.

> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks.

Kirti

