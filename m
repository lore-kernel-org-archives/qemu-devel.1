Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEE6C54FCF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC63820735
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W/vPTv4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC63820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGrVK-00053B-4U
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 17:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jGrPd-0005iW-CL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jGrPb-0007Nv-Nf
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:48:41 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6441)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jGrPb-0007LB-Fb
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:48:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7a80270000>; Tue, 24 Mar 2020 14:48:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 24 Mar 2020 14:48:37 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 24 Mar 2020 14:48:37 -0700
Received: from [10.40.103.72] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Mar
 2020 21:48:28 +0000
Subject: Re: [PATCH v16 Kernel 4/7] vfio iommu: Implementation of ioctl for
 dirty pages tracking.
To: Alex Williamson <alex.williamson@redhat.com>
References: <1585078359-20124-1-git-send-email-kwankhede@nvidia.com>
 <1585078359-20124-5-git-send-email-kwankhede@nvidia.com>
 <20200324143716.64cf0cc9@w520.home> <20200324144507.5e11a50d@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <983b1069-672d-765e-af55-bad42040fe61@nvidia.com>
Date: Wed, 25 Mar 2020 03:18:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324144507.5e11a50d@w520.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585086503; bh=Tb7ziKzjnZl41wOQ3/A9qoE7rgyuhIprawayput8U7Q=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=W/vPTv4kxOMETGr1kQrAwcfMUQ7pEXj6jW9DMbw1xZ2wm1SQiO3w/8TpJ0H3YXyzL
 v7mHBvwX4tOS4SIQSKZdArFMfAJX0fsbD2Pr6jIIZUODYDfBmY63EFk3VUM2GjFLAz
 uBY5PYEBdTHk0ngXnctKj81YL4FzoFQCkc6gclI0DZ1HU9RDi1huXYB9qj7SnW27HY
 xF+he49HCOAXCuEywOhz1FIJcEprx0Z9Jfs7ovwXG0JpUVkGSPD+jHHlPRBepOozmC
 UpYh05un+JbvgYhO5anLqn1xk9lomfWz+mIcAZK0es0ktANHs99YFoh8Jw2HUqibWW
 rQQq8d2S0dj+Q==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.65
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



On 3/25/2020 2:15 AM, Alex Williamson wrote:
> On Tue, 24 Mar 2020 14:37:16 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
>> On Wed, 25 Mar 2020 01:02:36 +0530
>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>
>>> VFIO_IOMMU_DIRTY_PAGES ioctl performs three operations:
>>> - Start dirty pages tracking while migration is active
>>> - Stop dirty pages tracking.
>>> - Get dirty pages bitmap. Its user space application's responsibility to
>>>    copy content of dirty pages from source to destination during migration.
>>>
>>> To prevent DoS attack, memory for bitmap is allocated per vfio_dma
>>> structure. Bitmap size is calculated considering smallest supported page
>>> size. Bitmap is allocated for all vfio_dmas when dirty logging is enabled
>>>
>>> Bitmap is populated for already pinned pages when bitmap is allocated for
>>> a vfio_dma with the smallest supported page size. Update bitmap from
>>> pinning functions when tracking is enabled. When user application queries
>>> bitmap, check if requested page size is same as page size used to
>>> populated bitmap. If it is equal, copy bitmap, but if not equal, return
>>> error.
>>>
>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>>> ---
>>>   drivers/vfio/vfio_iommu_type1.c | 265 +++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 259 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>> index 70aeab921d0f..27ed069c5053 100644
>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>> @@ -71,6 +71,7 @@ struct vfio_iommu {
>>>   	unsigned int		dma_avail;
>>>   	bool			v2;
>>>   	bool			nesting;
>>> +	bool			dirty_page_tracking;
>>>   };
>>>   
>>>   struct vfio_domain {
>>> @@ -91,6 +92,7 @@ struct vfio_dma {
>>>   	bool			lock_cap;	/* capable(CAP_IPC_LOCK) */
>>>   	struct task_struct	*task;
>>>   	struct rb_root		pfn_list;	/* Ex-user pinned pfn list */
>>> +	unsigned long		*bitmap;
>>>   };
>>>   
>>>   struct vfio_group {
>>> @@ -125,7 +127,21 @@ struct vfio_regions {
>>>   #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
>>>   					(!list_empty(&iommu->domain_list))
>>>   
>>> +#define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) / BITS_PER_BYTE)
>>> +
>>> +/*
>>> + * Input argument of number of bits to bitmap_set() is unsigned integer, which
>>> + * further casts to signed integer for unaligned multi-bit operation,
>>> + * __bitmap_set().
>>> + * Then maximum bitmap size supported is 2^31 bits divided by 2^3 bits/byte,
>>> + * that is 2^28 (256 MB) which maps to 2^31 * 2^12 = 2^43 (8TB) on 4K page
>>> + * system.
>>> + */
>>> +#define DIRTY_BITMAP_PAGES_MAX	(uint64_t)(INT_MAX - 1)
>>> +#define DIRTY_BITMAP_SIZE_MAX	 DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
>>> +
>>>   static int put_pfn(unsigned long pfn, int prot);
>>> +static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu);
>>>   
>>>   /*
>>>    * This code handles mapping and unmapping of user data buffers
>>> @@ -175,6 +191,77 @@ static void vfio_unlink_dma(struct vfio_iommu *iommu, struct vfio_dma *old)
>>>   	rb_erase(&old->node, &iommu->dma_list);
>>>   }
>>>   
>>> +
>>> +static int vfio_dma_bitmap_alloc(struct vfio_dma *dma, uint64_t pgsize)
>>> +{
>>> +	uint64_t npages = dma->size / pgsize;
>>> +
>>> +	if (npages > DIRTY_BITMAP_PAGES_MAX)
>>> +		return -EINVAL;
>>> +
>>> +	dma->bitmap = kvzalloc(DIRTY_BITMAP_BYTES(npages), GFP_KERNEL);
>>> +	if (!dma->bitmap)
>>> +		return -ENOMEM;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void vfio_dma_bitmap_free(struct vfio_dma *dma)
>>> +{
>>> +	kfree(dma->bitmap);
>>> +	dma->bitmap = NULL;
>>> +}
>>> +
>>> +static void vfio_dma_populate_bitmap(struct vfio_dma *dma, uint64_t pgsize)
>>> +{
>>> +	struct rb_node *p;
>>> +
>>> +	if (RB_EMPTY_ROOT(&dma->pfn_list))
>>> +		return;
>>> +
>>> +	for (p = rb_first(&dma->pfn_list); p; p = rb_next(p)) {
>>> +		struct vfio_pfn *vpfn = rb_entry(p, struct vfio_pfn, node);
>>> +
>>> +		bitmap_set(dma->bitmap, (vpfn->iova - dma->iova) / pgsize, 1);
>>> +	}
>>> +}
>>> +
>>> +static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu, uint64_t pgsize)
>>> +{
>>> +	struct rb_node *n = rb_first(&iommu->dma_list);
>>> +
>>> +	for (; n; n = rb_next(n)) {
>>> +		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
>>> +		int ret;
>>> +
>>> +		ret = vfio_dma_bitmap_alloc(dma, pgsize);
>>> +		if (ret) {
>>> +			struct rb_node *p = rb_prev(n);
>>> +
>>> +			for (; p; p = rb_prev(p)) {
>>> +				struct vfio_dma *dma = rb_entry(n,
>>> +							struct vfio_dma, node);
>>> +
>>> +				vfio_dma_bitmap_free(dma);
>>> +			}
>>> +			return ret;
>>> +		}
>>> +		vfio_dma_populate_bitmap(dma, pgsize);
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static void vfio_dma_bitmap_free_all(struct vfio_iommu *iommu)
>>> +{
>>> +	struct rb_node *n = rb_first(&iommu->dma_list);
>>> +
>>> +	for (; n; n = rb_next(n)) {
>>> +		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
>>> +
>>> +		vfio_dma_bitmap_free(dma);
>>> +	}
>>> +}
>>> +
>>>   /*
>>>    * Helper Functions for host iova-pfn list
>>>    */
>>> @@ -567,6 +654,18 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>>>   			vfio_unpin_page_external(dma, iova, do_accounting);
>>>   			goto pin_unwind;
>>>   		}
>>> +
>>> +		if (iommu->dirty_page_tracking) {
>>> +			unsigned long pgshift =
>>> +					 __ffs(vfio_pgsize_bitmap(iommu));
>>> +
>>> +			/*
>>> +			 * Bitmap populated with the smallest supported page
>>> +			 * size
>>> +			 */
>>> +			bitmap_set(dma->bitmap,
>>> +				   (vpfn->iova - dma->iova) >> pgshift, 1);
>>> +		}
>>>   	}
>>>   
>>>   	ret = i;
>>> @@ -801,6 +900,7 @@ static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
>>>   	vfio_unmap_unpin(iommu, dma, true);
>>>   	vfio_unlink_dma(iommu, dma);
>>>   	put_task_struct(dma->task);
>>> +	vfio_dma_bitmap_free(dma);
>>>   	kfree(dma);
>>>   	iommu->dma_avail++;
>>>   }
>>> @@ -831,6 +931,56 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
>>>   	return bitmap;
>>>   }
>>>   
>>> +static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
>>> +				  size_t size, uint64_t pgsize,
>>> +				  u64 __user *bitmap)
>>> +{
>>> +	struct vfio_dma *dma;
>>> +	unsigned long pgshift = __ffs(pgsize);
>>> +	unsigned int npages, bitmap_size;
>>> +
>>> +	dma = vfio_find_dma(iommu, iova, 1);
>>> +
>>> +	if (!dma)
>>> +		return -EINVAL;
>>> +
>>> +	if (dma->iova != iova || dma->size != size)
>>> +		return -EINVAL;
>>> +
>>> +	npages = dma->size >> pgshift;
>>> +	bitmap_size = DIRTY_BITMAP_BYTES(npages);
>>> +
>>> +	/* mark all pages dirty if all pages are pinned and mapped. */
>>> +	if (dma->iommu_mapped)
>>> +		bitmap_set(dma->bitmap, 0, npages);
>>> +
>>> +	if (copy_to_user((void __user *)bitmap, dma->bitmap, bitmap_size))
>>> +		return -EFAULT;
>>> +
>>> +	/*
>>> +	 * Re-populate bitmap to include all pinned pages which are considered
>>> +	 * as dirty but exclude pages which are unpinned and pages which are
>>> +	 * marked dirty by vfio_dma_rw()
>>> +	 */
>>> +	vfio_dma_populate_bitmap(dma, pgsize);
>>
>> vfio_dma_populate_bitmap() only sets bits, it doesn't clear them.
>> Shouldn't we do a memset() zero before calling this?  Thanks,
> 
> Or a bitmap_clear() would be better given we use bitmap_set() above.
> Thanks,
> 

Oh, I missed clearing bitmap. Resending only this patch again.

Thanks,
Kirti

