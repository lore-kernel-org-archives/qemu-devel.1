Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5837AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C01820575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lWhz7mAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C01820575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6Up-00046s-8c
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jZ6UE-0003LJ-6j
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:32:50 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jZ6UC-0006BK-Cp
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:32:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ebcd7b30000>; Wed, 13 May 2020 22:31:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 13 May 2020 22:32:46 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 13 May 2020 22:32:46 -0700
Received: from [10.40.103.94] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 May
 2020 05:32:38 +0000
Subject: Re: [PATCH Kernel v19 6/8] vfio iommu: Update UNMAP_DMA ioctl to get
 dirty bitmap before unmap
To: Alex Williamson <alex.williamson@redhat.com>
References: <1589400279-28522-1-git-send-email-kwankhede@nvidia.com>
 <1589400279-28522-7-git-send-email-kwankhede@nvidia.com>
 <20200513230747.0d2f3bc3@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <65a90392-a140-6862-b7f2-2bddc6e71ba9@nvidia.com>
Date: Thu, 14 May 2020 11:02:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200513230747.0d2f3bc3@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1589434291; bh=sK8rPCmJuaL+HKpbTXNFyeWb5uWnk1KuDtH9md7ufc0=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=lWhz7mApEwTEzcKBRL9kkHGf2Av+Akr6OaB5kSVmARJh4l8xvCV5z6I5E94kenalH
 lJxaevCjB3mJmMgr0k73j0jKYepu5sEcJYfnfuBMW/tPYNmeubeaLO7T3S7R1yeWIq
 XI/o+T3/IgnYaUhGaLL++ofHzM9OS1n/DANxXJnBnvaxWL7zA5slx2WqGw2+fpEwV3
 QWEnPHkyFh1Q8NpHhg6FKXaAOQtPlXrQSOfL9RWsVWkC0DbLNcNIXRiN0PCIJq0JFU
 d5xiSsl8HCgkFMeypLw6piRMZBr40vWXyl/ZC3hl0wUVHKxa8dU4dlkfznQXNYfnma
 WyX1ZQ40/BjtQ==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 01:32:47
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



On 5/14/2020 10:37 AM, Alex Williamson wrote:
> On Thu, 14 May 2020 01:34:37 +0530
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
>>   drivers/vfio/vfio_iommu_type1.c | 102 +++++++++++++++++++++++++++++++++++-----
>>   include/uapi/linux/vfio.h       |  10 ++++
>>   2 files changed, 99 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 469b09185b83..4358be26ff80 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -195,11 +195,15 @@ static void vfio_unlink_dma(struct vfio_iommu *iommu, struct vfio_dma *old)
>>   static int vfio_dma_bitmap_alloc(struct vfio_dma *dma, size_t pgsize)
>>   {
>>   	uint64_t npages = dma->size / pgsize;
>> +	size_t bitmap_size;
>>   
>>   	if (npages > DIRTY_BITMAP_PAGES_MAX)
>>   		return -EINVAL;
>>   
>> -	dma->bitmap = kvzalloc(DIRTY_BITMAP_BYTES(npages), GFP_KERNEL);
>> +	/* Allocate extra 64 bits which are used for bitmap manipulation */
>> +	bitmap_size = DIRTY_BITMAP_BYTES(npages) + sizeof(u64);
>> +
>> +	dma->bitmap = kvzalloc(bitmap_size, GFP_KERNEL);
>>   	if (!dma->bitmap)
>>   		return -ENOMEM;
>>   
>> @@ -979,23 +983,25 @@ static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
>>   }
>>   
>>   static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>> -			     struct vfio_iommu_type1_dma_unmap *unmap)
>> +			     struct vfio_iommu_type1_dma_unmap *unmap,
>> +			     struct vfio_bitmap *bitmap)
>>   {
>> -	uint64_t mask;
>>   	struct vfio_dma *dma, *dma_last = NULL;
>> -	size_t unmapped = 0;
>> -	int ret = 0, retries = 0;
>> +	size_t unmapped = 0, pgsize;
>> +	int ret = 0, retries = 0, cnt = 0;
>> +	unsigned long pgshift, shift = 0, leftover;
>>   
>>   	mutex_lock(&iommu->lock);
>>   
>> -	mask = ((uint64_t)1 << __ffs(iommu->pgsize_bitmap)) - 1;
>> +	pgshift = __ffs(iommu->pgsize_bitmap);
>> +	pgsize = (size_t)1 << pgshift;
>>   
>> -	if (unmap->iova & mask) {
>> +	if (unmap->iova & (pgsize - 1)) {
>>   		ret = -EINVAL;
>>   		goto unlock;
>>   	}
>>   
>> -	if (!unmap->size || unmap->size & mask) {
>> +	if (!unmap->size || unmap->size & (pgsize - 1)) {
>>   		ret = -EINVAL;
>>   		goto unlock;
>>   	}
>> @@ -1006,9 +1012,15 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>   		goto unlock;
>>   	}
>>   
>> -	WARN_ON(mask & PAGE_MASK);
>> -again:
>> +	/* When dirty tracking is enabled, allow only min supported pgsize */
>> +	if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
>> +	    (!iommu->dirty_page_tracking || (bitmap->pgsize != pgsize))) {
>> +		ret = -EINVAL;
>> +		goto unlock;
>> +	}
>>   
>> +	WARN_ON((pgsize - 1) & PAGE_MASK);
>> +again:
>>   	/*
>>   	 * vfio-iommu-type1 (v1) - User mappings were coalesced together to
>>   	 * avoid tracking individual mappings.  This means that the granularity
>> @@ -1046,6 +1058,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>   			ret = -EINVAL;
>>   			goto unlock;
>>   		}
>> +
>>   		dma = vfio_find_dma(iommu, unmap->iova + unmap->size - 1, 0);
>>   		if (dma && dma->iova + dma->size != unmap->iova + unmap->size) {
>>   			ret = -EINVAL;
>> @@ -1063,6 +1076,39 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>   		if (dma->task->mm != current->mm)
>>   			break;
>>   
>> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
>> +		    (dma_last != dma)) {
>> +			unsigned int nbits = dma->size >> pgshift;
>> +			int curr_lcnt = nbits / BITS_PER_LONG;
>> +
>> +			/*
>> +			 * mark all pages dirty if all pages are pinned and
>> +			 * mapped.
>> +			 */
>> +			if (dma->iommu_mapped)
>> +				bitmap_set(dma->bitmap, 0, nbits);
>> +
>> +			if (shift) {
>> +				bitmap_shift_left(dma->bitmap, dma->bitmap,
>> +						  shift, nbits + shift);
>> +				bitmap_or(dma->bitmap, dma->bitmap, &leftover,
>> +					  shift);
>> +				nbits += shift;
>> +				curr_lcnt = nbits / BITS_PER_LONG;
>> +			}
>> +
>> +			if (copy_to_user((void __user *)bitmap->data + cnt,
>> +				       dma->bitmap, curr_lcnt * sizeof(u64))) {
>> +				ret = -EFAULT;
>> +				break;
>> +			}
>> +
>> +			shift = nbits % BITS_PER_LONG;
>> +			if (shift)
>> +				leftover = *(u64 *)(dma->bitmap + curr_lcnt);
>> +			cnt += curr_lcnt;
>> +		}
> 
> I don't think this works.  Let's say for example we have separate
> single page mappings at 4K and 12K (both dirty) and the user asked to
> unmap the range 0 - 16K. 

Unmap range should include adjacent mapped ranges, right?
In your example, if user asks for range 0-16k but mapping at 0 wasn't 
done, then this unmap would fail before even reaching control here.

There is a check which makes sure that mapping for start of range exist:

         dma = vfio_find_dma(iommu, unmap->iova, 1);
         if (dma && dma->iova != unmap->iova) {
                 ret = -EINVAL;
                 goto unlock;
         }

There is a check which makes sure that mapping for last address of range 
exist:
         dma = vfio_find_dma(iommu, unmap->iova + unmap->size - 1, 0);
         if (dma && dma->iova + dma->size != unmap->iova + unmap->size) {
                ret = -EINVAL;
                goto unlock;
         }
Then current implementation should work.

Thanks,
Kirti

> We find the mapping at 4K, shift is zero, cnt
> is zero, so we copy the bitmap with the zero bit set to the user
> buffer.  We're already wrong because we've just indicated the page at
> zero is dirty and there isn't a page at zero.  shift now becomes 1 and
> leftover is a bitmap with bit zero set.
> 
> We move on to the next page @12K.  We shift this bitmap by 1.  We OR in
> our leftover and again copy out to the user buffer.  We end up with a
> user bitmap with bits zero and one set, when we should have had bits 1
> and 3 set, we're essentially coalescing the mappings.
> 
> As I see it, shift needs to be calculated as the offset from the start
> of the user requested unmap buffer and I think an easier approach to
> handle the leftover bits preceding the shift is to copy it back out of
> the user buffer.
> 
> For example, shift should be:
> 
> ((dma->iova - unmap->iova) >> pgshift) % BITS_PER_LONG
> 
> This would give us a shift of 1 and 3 respectively for our mappings,
> which is correct.
> 
> Since our shifts are non-zero, we then need to collect the preceding
> leftovers, which is always going to be:
> 
> copy_from_user(&leftover, bitmap->data +
> 		((dma->iova - unmap->iova) >> pgshift) / BITS_PER_LONG,
> 		sizeof(leftover));
> 
> I don't think the curr_lcnt calculation for the copy-out is correct
> either, mappings are not required to be a multiple of BITS_PER_LONG
> pages, so we're truncating the size.
> 
> So we have:
> 
> bit_offset = (dma->iova - unmap->iova) >> pgshift;
> copy_offset = bit_offset / BITS_PER_LONG;
> shift = bit_offset % BITS_PER_LONG;
> 
> if (shift) {
> 	bitmap_shift_left(dma->bitmap, dma->bitmap, shift, nbits + shift);
> 	if (copy_from_user(&leftover, bitmap->data + copy_offset, sizeof(leftover))) {
> 		ret = -EFAULT;
> 		break;
> 	}
> 	bitmap_or(dma->bitmap, dma->bitmap, &leftover, shift);
> }
> 
> if (copy_to_user(bitmap->data + copy_offset, dma->bitmap,
> 		roundup(nbits + shift, BITS_PER_LONG)/BITS_PER_BYTE)) {
> 	ret = -EFAULT;
> 	break;
> }
> 
> Also this all needs to come after the below check of the pfn_list and
> call to the blocking notifier or else we're just wasting time because
> we'll need to do it all again anyway.
> 
> 
>> +
>>   		if (!RB_EMPTY_ROOT(&dma->pfn_list)) {
>>   			struct vfio_iommu_type1_dma_unmap nb_unmap;
>>   
>> @@ -1093,6 +1139,13 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>   		vfio_remove_dma(iommu, dma);
>>   	}
>>   
>> +	if (!ret && (unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
>> +	    shift) {
>> +		if (copy_to_user((void __user *)bitmap->data + cnt, &leftover,
>> +				 sizeof(leftover)))
>> +			ret = -EFAULT;
>> +	}
> 
> This is unnecessary with the algorithm I propose.
> 
>> +
>>   unlock:
>>   	mutex_unlock(&iommu->lock);
>>   
>> @@ -2426,17 +2479,40 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>>   
>>   	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
>>   		struct vfio_iommu_type1_dma_unmap unmap;
>> -		long ret;
>> +		struct vfio_bitmap bitmap = { 0 };
>> +		int ret;
>>   
>>   		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
>>   
>>   		if (copy_from_user(&unmap, (void __user *)arg, minsz))
>>   			return -EFAULT;
>>   
>> -		if (unmap.argsz < minsz || unmap.flags)
>> +		if (unmap.argsz < minsz ||
>> +		    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
>>   			return -EINVAL;
>>   
>> -		ret = vfio_dma_do_unmap(iommu, &unmap);
>> +		if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
>> +			unsigned long pgshift;
>> +
>> +			if (unmap.argsz < (minsz + sizeof(bitmap)))
>> +				return -EINVAL;
>> +
>> +			if (copy_from_user(&bitmap,
>> +					   (void __user *)(arg + minsz),
>> +					   sizeof(bitmap)))
>> +				return -EFAULT;
>> +
>> +			if (!access_ok((void __user *)bitmap.data, bitmap.size))
>> +				return -EINVAL;
>> +
>> +			pgshift = __ffs(bitmap.pgsize);
>> +			ret = verify_bitmap_size(unmap.size >> pgshift,
>> +						 bitmap.size);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +
>> +		ret = vfio_dma_do_unmap(iommu, &unmap, &bitmap);
>>   		if (ret)
>>   			return ret;
>>   
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 5f359c63f5ef..e3cbf8b78623 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1048,12 +1048,22 @@ struct vfio_bitmap {
>>    * field.  No guarantee is made to the user that arbitrary unmaps of iova
>>    * or size different from those used in the original mapping call will
>>    * succeed.
>> + * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get dirty bitmap
>> + * before unmapping IO virtual addresses. When this flag is set, user must
>> + * provide data[] as structure vfio_bitmap. User must allocate memory to get
>> + * bitmap and must set size of allocated memory in vfio_bitmap.size field.
>> + * A bit in bitmap represents one page of user provided page size in 'pgsize',
>> + * consecutively starting from iova offset. Bit set indicates page at that
>> + * offset from iova is dirty. Bitmap of pages in the range of unmapped size is
>> + * returned in vfio_bitmap.data
> 
> This needs to specify a user zero'd bitmap if we're only going to fill
> it sparsely.  Thanks,
> 
> Alex
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

