Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE36BC2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF09206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eNJvT0uK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF09206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYbZJ-0006Eb-Ns
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 16:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jYbYU-0005Gf-3Y
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:31:10 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jYbYR-0008Pi-VW
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:31:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ebb077c0000>; Tue, 12 May 2020 13:30:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 12 May 2020 13:31:04 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 12 May 2020 13:31:04 -0700
Received: from [10.40.103.94] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 May
 2020 20:30:58 +0000
Subject: Re: [PATCH Kernel v18 5/7] vfio iommu: Update UNMAP_DMA ioctl to get
 dirty bitmap before unmap
To: Alex Williamson <alex.williamson@redhat.com>
References: <1588607939-26441-1-git-send-email-kwankhede@nvidia.com>
 <1588607939-26441-6-git-send-email-kwankhede@nvidia.com>
 <20200506162511.032bb1e6@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <e4a5cb87-3bc3-ff1b-9ffb-479a4d418922@nvidia.com>
Date: Wed, 13 May 2020 02:00:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506162511.032bb1e6@w520.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1589315452; bh=SQJfdynECYAMsVxHU87JBCN1XEH3W8wqr29LA9gwC/Q=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=eNJvT0uKj+2qTv91QGkttQ2w17yFaiVHIx2xiHNV0zs9WzwZ+6TQ8Uwer2EjsDliw
 Ge7WjsKkdXCeNTADsEqE4DNz+szD7wvzVBBc01kYlHot7Jah84yqw5e2m6O4XKtsCB
 cvgTwrbizTOqIcKKnY5NP9+ErSrrEBoj2Z8LtA3TZf+vMJxSZvm9IE1KGuC2vNMYV8
 4cEw1gIjydr1RG1kZo8DvTJyuxH9Grx2+tIFrvk77gaQKivlo0gDbBcAzRDgNCs7Mr
 /WJo2kzIAL3tEj+6yZrm6KoWo5qXB+WalAKsED2OLdI/LpoDsWh2EFDAnMltsOqC4X
 l9xXE8VR1H/MA==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 16:31:05
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/7/2020 3:55 AM, Alex Williamson wrote:
> On Mon, 4 May 2020 21:28:57 +0530
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
>> size of allocated memory, set page size to be considered for bitmap and
>> set flag VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 84 +++++++++++++++++++++++++++++++++++++++--
>>   include/uapi/linux/vfio.h       | 10 +++++
>>   2 files changed, 90 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 01dcb417836f..8b27faf1ec38 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -983,12 +983,14 @@ static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
>>   }
>>   
>>   static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>> -			     struct vfio_iommu_type1_dma_unmap *unmap)
>> +			     struct vfio_iommu_type1_dma_unmap *unmap,
>> +			     struct vfio_bitmap *bitmap)
>>   {
>>   	uint64_t mask;
>>   	struct vfio_dma *dma, *dma_last = NULL;
>>   	size_t unmapped = 0;
>>   	int ret = 0, retries = 0;
>> +	unsigned long *final_bitmap = NULL, *temp_bitmap = NULL;
>>   
>>   	mask = ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
>>   
>> @@ -1041,6 +1043,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>   			ret = -EINVAL;
>>   			goto unlock;
>>   		}
>> +
>>   		dma = vfio_find_dma(iommu, unmap->iova + unmap->size - 1, 0);
>>   		if (dma && dma->iova + dma->size != unmap->iova + unmap->size) {
>>   			ret = -EINVAL;
>> @@ -1048,6 +1051,22 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>   		}
>>   	}
>>   
>> +	if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
>> +	     iommu->dirty_page_tracking) {
> 
> Why do we even accept VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP when not
> dirty page tracking rather than returning -EINVAL?  It would simplify
> things here to reject it at the ioctl and silently ignoring a flag is
> rarely if ever the right approach.
> 
>> +		final_bitmap = kvzalloc(bitmap->size, GFP_KERNEL);
>> +		if (!final_bitmap) {
>> +			ret = -ENOMEM;
>> +			goto unlock;
>> +		}
>> +
>> +		temp_bitmap = kvzalloc(bitmap->size, GFP_KERNEL);
>> +		if (!temp_bitmap) {
>> +			ret = -ENOMEM;
>> +			kfree(final_bitmap);
>> +			goto unlock;
>> +		}
> 
> YIKES!  So the user can instantly trigger the kernel to internally
> allocate 2 x 256MB, regardless of how much they can actually map.
> 

That is worst case senario. I don't think ideally that will ever hit. 
More comment below regarding this.

>> +	}
>> +
>>   	while ((dma = vfio_find_dma(iommu, unmap->iova, unmap->size))) {
>>   		if (!iommu->v2 && unmap->iova > dma->iova)
>>   			break;
>> @@ -1058,6 +1077,24 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>   		if (dma->task->mm != current->mm)
>>   			break;
>>   
>> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
>> +		     iommu->dirty_page_tracking) {
>> +			unsigned long pgshift = __ffs(bitmap->pgsize);
>> +			unsigned int npages = dma->size >> pgshift;
>> +			unsigned int shift;
>> +
>> +			vfio_iova_dirty_bitmap(iommu, dma->iova, dma->size,
>> +					bitmap->pgsize, (u64 *)temp_bitmap);
> 
> vfio_iova_dirty_bitmap() takes a __user bitmap, we're doing
> copy_to_user() on a kernel allocated buffer???
> 

Actually, there is no need to call vfio_iova_dirty_bitmap(), dma pointer 
is known here and since its getting unmapped, there is no need to 
repopulate bitmap. Removing vfio_iova_dirty_bitmap() and changing it as 
below:

if (unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
     unsigned long pgshift = __ffs(bitmap->pgsize);
     unsigned int npages = dma->size >> pgshift;
     unsigned int bitmap_size = DIRTY_BITMAP_BYTES(npages);
     unsigned int shift = (dma->iova - unmap->iova) >>
                                             pgshift;
     /*
      * mark all pages dirty if all pages are pinned and
      * mapped.
      */
     if (dma->iommu_mapped)
         bitmap_set(temp_bitmap, 0, npages);
     else
         memcpy(temp_bitmap, dma->bitmap, bitmap_size);

     if (shift)
         bitmap_shift_left(temp_bitmap, temp_bitmap,
                           shift, npages);
     bitmap_or(final_bitmap, final_bitmap, temp_bitmap,
               shift + npages);
     memset(temp_bitmap, 0, bitmap->size);
}

>> +
>> +			shift = (dma->iova - unmap->iova) >> pgshift;
>> +			if (shift)
>> +				bitmap_shift_left(temp_bitmap, temp_bitmap,
>> +						  shift, npages);
>> +			bitmap_or(final_bitmap, final_bitmap, temp_bitmap,
>> +				  shift + npages);
>> +			memset(temp_bitmap, 0, bitmap->size);
>> +		}
> 
> It seems like if the per vfio_dma dirty bitmap was oversized by a long
> that we could shift it in place, then we'd only need one working bitmap
> buffer and we could size that to fit the vfio_dma (or the largest
> vfio_dma if we don't want to free and re-alloc for each vfio_dma).
> We'd need to do more copy_to/from_user()s, but we'd also avoid copying
> between sparse mappings (user zero'd bitmap required) and we'd have a
> far more reasonable memory usage.  Thanks,
>

I thought about it, but couldn't optimize to use one bitmap buffer.
This case will only hit during migration with vIOMMU enabled.
Can we keep these 2 bitmap buffers for now and optimize it later?

Thanks,
Kirti

