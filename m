Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D6AC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 05:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C93A20663
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 05:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="b9hslWTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C93A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHhET-0008QM-Ln
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 01:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jHhDq-0007zl-Kp
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 01:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jHhDo-0004tA-4J
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 01:07:58 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jHhDn-0004pJ-Rf
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 01:07:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7d89cc0000>; Thu, 26 Mar 2020 22:06:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 26 Mar 2020 22:07:52 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 26 Mar 2020 22:07:52 -0700
Received: from [10.40.103.35] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Mar
 2020 05:07:42 +0000
Subject: Re: [PATCH v16 Kernel 4/7] vfio iommu: Implementation of ioctl for
 dirty pages tracking.
To: Yan Zhao <yan.y.zhao@intel.com>
References: <1585084732-18473-1-git-send-email-kwankhede@nvidia.com>
 <20200325021135.GB20109@joy-OptiPlex-7040>
 <33d38629-aeaf-1c30-26d4-958b998620b0@nvidia.com>
 <20200327003055.GB26419@joy-OptiPlex-7040>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <0fdf19d4-a45b-d0b1-b630-1ee9df087c15@nvidia.com>
Date: Fri, 27 Mar 2020 10:37:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327003055.GB26419@joy-OptiPlex-7040>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585285580; bh=Ug0s9R32r7hjmYYiUdYuvWHpJYX9eVQPruQ15CxYf1k=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=b9hslWTJC39ePMhsv2bPyhhcXcL1FSFnhYoKErrAF3MLqba9/2dWKaiOJr9VOuq1B
 ZZpyje/rRouHlQjn7eTMrF7ChMvdIqAWSQwR6DHHf22Z9C5BnWQNBNlpQOIlSR9dmK
 PtT/7sZmt6Mtmr2z79tHDbnj/Ji5PLii7NORI3anRonI5gQ4a/wALITCXCFRRa8afR
 +0iVSJgfPOiXTDsUahuJSezPbPrGg7zWm8IRKPXZgaOutZ1oRtkjfHrTF/Muy5Q1+a
 yNGBjbJth+2UCs8WeQTvPfw3eYJrr48N/acCrNgR/SK2TwED8ytjkHX0Mxxo0DM3p1
 74DFpYRgr2prA==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.143
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



On 3/27/2020 6:00 AM, Yan Zhao wrote:
> On Fri, Mar 27, 2020 at 05:39:01AM +0800, Kirti Wankhede wrote:
>>
>>
>> On 3/25/2020 7:41 AM, Yan Zhao wrote:
>>> On Wed, Mar 25, 2020 at 05:18:52AM +0800, Kirti Wankhede wrote:
>>>> VFIO_IOMMU_DIRTY_PAGES ioctl performs three operations:
>>>> - Start dirty pages tracking while migration is active
>>>> - Stop dirty pages tracking.
>>>> - Get dirty pages bitmap. Its user space application's responsibility to
>>>>     copy content of dirty pages from source to destination during migration.
>>>>
>>>> To prevent DoS attack, memory for bitmap is allocated per vfio_dma
>>>> structure. Bitmap size is calculated considering smallest supported page
>>>> size. Bitmap is allocated for all vfio_dmas when dirty logging is enabled
>>>>
>>>> Bitmap is populated for already pinned pages when bitmap is allocated for
>>>> a vfio_dma with the smallest supported page size. Update bitmap from
>>>> pinning functions when tracking is enabled. When user application queries
>>>> bitmap, check if requested page size is same as page size used to
>>>> populated bitmap. If it is equal, copy bitmap, but if not equal, return
>>>> error.
>>>>
>>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>>>> ---
>>>>    drivers/vfio/vfio_iommu_type1.c | 266 +++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 260 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>> index 70aeab921d0f..874a1a7ae925 100644
>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>> @@ -71,6 +71,7 @@ struct vfio_iommu {
>>>>    	unsigned int		dma_avail;
>>>>    	bool			v2;
>>>>    	bool			nesting;
>>>> +	bool			dirty_page_tracking;
>>>>    };
>>>>    
>>>>    struct vfio_domain {
>>>> @@ -91,6 +92,7 @@ struct vfio_dma {
>>>>    	bool			lock_cap;	/* capable(CAP_IPC_LOCK) */
>>>>    	struct task_struct	*task;
>>>>    	struct rb_root		pfn_list;	/* Ex-user pinned pfn list */
>>>> +	unsigned long		*bitmap;
>>>>    };
>>>>    
>>>>    struct vfio_group {
>>>> @@ -125,7 +127,21 @@ struct vfio_regions {
>>>>    #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
>>>>    					(!list_empty(&iommu->domain_list))
>>>>    
>>>> +#define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) / BITS_PER_BYTE)
>>>> +
>>>> +/*
>>>> + * Input argument of number of bits to bitmap_set() is unsigned integer, which
>>>> + * further casts to signed integer for unaligned multi-bit operation,
>>>> + * __bitmap_set().
>>>> + * Then maximum bitmap size supported is 2^31 bits divided by 2^3 bits/byte,
>>>> + * that is 2^28 (256 MB) which maps to 2^31 * 2^12 = 2^43 (8TB) on 4K page
>>>> + * system.
>>>> + */
>>>> +#define DIRTY_BITMAP_PAGES_MAX	(uint64_t)(INT_MAX - 1)
>>>> +#define DIRTY_BITMAP_SIZE_MAX	 DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
>>>> +
>>>>    static int put_pfn(unsigned long pfn, int prot);
>>>> +static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu);
>>>>    
>>>>    /*
>>>>     * This code handles mapping and unmapping of user data buffers
>>>> @@ -175,6 +191,77 @@ static void vfio_unlink_dma(struct vfio_iommu *iommu, struct vfio_dma *old)
>>>>    	rb_erase(&old->node, &iommu->dma_list);
>>>>    }
>>>>    
>>>> +
>>>> +static int vfio_dma_bitmap_alloc(struct vfio_dma *dma, uint64_t pgsize)
>>>> +{
>>>> +	uint64_t npages = dma->size / pgsize;
>>>> +
>>>> +	if (npages > DIRTY_BITMAP_PAGES_MAX)
>>>> +		return -EINVAL;
>>>> +
>>>> +	dma->bitmap = kvzalloc(DIRTY_BITMAP_BYTES(npages), GFP_KERNEL);
>>>> +	if (!dma->bitmap)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void vfio_dma_bitmap_free(struct vfio_dma *dma)
>>>> +{
>>>> +	kfree(dma->bitmap);
>>>> +	dma->bitmap = NULL;
>>>> +}
>>>> +
>>>> +static void vfio_dma_populate_bitmap(struct vfio_dma *dma, uint64_t pgsize)
>>>> +{
>>>> +	struct rb_node *p;
>>>> +
>>>> +	if (RB_EMPTY_ROOT(&dma->pfn_list))
>>>> +		return;
>>>> +
>>>> +	for (p = rb_first(&dma->pfn_list); p; p = rb_next(p)) {
>>>> +		struct vfio_pfn *vpfn = rb_entry(p, struct vfio_pfn, node);
>>>> +
>>>> +		bitmap_set(dma->bitmap, (vpfn->iova - dma->iova) / pgsize, 1);
>>>> +	}
>>>> +}
>>>> +
>>>> +static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu, uint64_t pgsize)
>>>> +{
>>>> +	struct rb_node *n = rb_first(&iommu->dma_list);
>>>> +
>>>> +	for (; n; n = rb_next(n)) {
>>>> +		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
>>>> +		int ret;
>>>> +
>>>> +		ret = vfio_dma_bitmap_alloc(dma, pgsize);
>>>> +		if (ret) {
>>>> +			struct rb_node *p = rb_prev(n);
>>>> +
>>>> +			for (; p; p = rb_prev(p)) {
>>>> +				struct vfio_dma *dma = rb_entry(n,
>>>> +							struct vfio_dma, node);
>>>> +
>>>> +				vfio_dma_bitmap_free(dma);
>>>> +			}
>>>> +			return ret;
>>>> +		}
>>>> +		vfio_dma_populate_bitmap(dma, pgsize);
>>>> +	}
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void vfio_dma_bitmap_free_all(struct vfio_iommu *iommu)
>>>> +{
>>>> +	struct rb_node *n = rb_first(&iommu->dma_list);
>>>> +
>>>> +	for (; n; n = rb_next(n)) {
>>>> +		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
>>>> +
>>>> +		vfio_dma_bitmap_free(dma);
>>>> +	}
>>>> +}
>>>> +
>>>>    /*
>>>>     * Helper Functions for host iova-pfn list
>>>>     */
>>>> @@ -567,6 +654,18 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>>>>    			vfio_unpin_page_external(dma, iova, do_accounting);
>>>>    			goto pin_unwind;
>>>>    		}
>>>> +
>>>> +		if (iommu->dirty_page_tracking) {
>>>> +			unsigned long pgshift =
>>>> +					 __ffs(vfio_pgsize_bitmap(iommu));
>>>> +
>>>> +			/*
>>>> +			 * Bitmap populated with the smallest supported page
>>>> +			 * size
>>>> +			 */
>>>> +			bitmap_set(dma->bitmap,
>>>> +				   (vpfn->iova - dma->iova) >> pgshift, 1);
>>>> +		}
>>>>    	}
>>>>    
>>>>    	ret = i;
>>>> @@ -801,6 +900,7 @@ static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
>>>>    	vfio_unmap_unpin(iommu, dma, true);
>>>>    	vfio_unlink_dma(iommu, dma);
>>>>    	put_task_struct(dma->task);
>>>> +	vfio_dma_bitmap_free(dma);
>>>>    	kfree(dma);
>>>>    	iommu->dma_avail++;
>>>>    }
>>>> @@ -831,6 +931,57 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
>>>>    	return bitmap;
>>>>    }
>>>>    
>>>> +static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
>>>> +				  size_t size, uint64_t pgsize,
>>>> +				  u64 __user *bitmap)
>>>> +{
>>>> +	struct vfio_dma *dma;
>>>> +	unsigned long pgshift = __ffs(pgsize);
>>>> +	unsigned int npages, bitmap_size;
>>>> +
>>>> +	dma = vfio_find_dma(iommu, iova, 1);
>>>> +
>>>> +	if (!dma)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (dma->iova != iova || dma->size != size)
>>>> +		return -EINVAL;
>>>> +
>>> Still don't sure if it's a good practice.
>>> I saw the qemu implementation.
>>> Qemu just iterates the whole IOVA address space,
>>> It needs to find IOTLB entry for an IOVA
>>> (1) if it can find an IOTLB for an IOVA, do the DIRTY_PAGES IOCTL and
>>> increment IOVA by (iotlb.addr_mask + 1)
>>>
>>> (2) if no existing IOTLB found, the imrc->translate needs to go searching shadow
>>> page table to try to generate one.
>>> if it still fails,(most probably case, as IOMMU only maps a small part in its address
>>> space).  increment IOVA by 1 page.
>>>
>>> So, if the address space width is 39bit, and if there's only one page
>>> mapped, you still have to translate IOVA for around 2^27 times in each
>>> query. Isn't it too inefficient?
>>>
>>
>> This is Qemu side implementation, let discuss it on QEMU patches.
>>
> But kernel has to support it first, right?
> 

Shadow page table will be in QEMU (?), as long as we support map and 
unmap in kernel space, QEMU part of changes should work. That shouldn't 
block kernel side patches.

>>> So, IMHO, why we could not just save an rb tree specific for dirty pages, then generate
>>> a bitmap for each query?
>>
>> This is looping back to implentation in v10 - v12 version. There are
>> problems discussed during v10 to v12 version of patches with this approach.
>> - populating dirty bitmap at the time of query will add more CPU cycles.
>> - If we save these CPU cyles means dirty pages need to be tracked when
>> they are pinned or dirtied by CPU, that is, inttoduced per vfio_dma
>> bitmap. If ranges are not vfio_dma aligned, then copying bitmap to user
>> space becomes complicated and unefficient.
>>
>> So we decided to go with the approach implemented here.
> 
> I checked v12, it's not like what I said.
> In v12, bitmaps are generated per vfio_dma, and combination of the
> bitmaps are required in order to generate a big bitmap suiting for dirty
> query. It can cause problem when offset not aligning.
> But what I propose here is to generate an rb tree orthogonal to the tree
> of vfio_dma.
> 
> as to CPU cycles saving, I don't think iterating/translating page by page
> would achieve that purpose.
> 
> 



> 
>>>
>>>> +	npages = dma->size >> pgshift;
>>>> +	bitmap_size = DIRTY_BITMAP_BYTES(npages);
>>>> +
>>>> +	/* mark all pages dirty if all pages are pinned and mapped. */
>>>> +	if (dma->iommu_mapped)
>>>> +		bitmap_set(dma->bitmap, 0, npages);
>>>> +
>>>> +	if (copy_to_user((void __user *)bitmap, dma->bitmap, bitmap_size))
>>>> +		return -EFAULT;
>>>> +
>>>> +	/*
>>>> +	 * Re-populate bitmap to include all pinned pages which are considered
>>>> +	 * as dirty but exclude pages which are unpinned and pages which are
>>>> +	 * marked dirty by vfio_dma_rw()
>>>> +	 */
>>>> +	bitmap_clear(dma->bitmap, 0, npages);
>>>> +	vfio_dma_populate_bitmap(dma, pgsize);
>>> will this also repopulate bitmap for pinned pages set by pass-through devices in
>>> patch 07 ?
>>>
>>
>> If pass through device's driver pins pages using vfio_pin_pages and all
>> devices in the group pins pages through vfio_pin_pages, then
>> iommu->pinned_page_dirty_scope is set true, then bitmap is repolutated.
>>
>>
> pass-through devices already have all guest memory pinned, it would have
> no reason to call vfio_pin_pages if not attempting to mark page dirty.
> Then if it calls vfio_pin_pages, it means "the pages are accessed, please
> mark them dirty, feel free to clean it when you get it",

if you see vfio_dma_populate_bitmap() function, then if vfio_pin_pages 
is called, dma->pfn_list rb_tree will be non-empty and bitmap gets 
populates as per pinned pages.

> not "the pages will be accesses, please mark them dirty continuously"
>

if vfio_pin_pages is not called, dma->pfn_list is empty, then it returns 
early.
If suppose there are 2 deviced in the group, one is IOMMU backed device 
and other non-IOMMU mdev device. In that case, all pages are pinned, 
iommu->pinned_page_dirty_scope is false, but dma->pfn_list is also not 
empty since non-IOMMU backed device pins pages using external API. We 
still have to populate bitmap according to dma->pfn_list here, because 
in prec-copy phase on first bitmap query, IOMMU backed device might pin 
pages using external API - with that iommu->pinned_page_dirty_scope will 
get updated to 'true', which means during next iteration report pinned 
pages by external API only.

Thanks,
Kirti



