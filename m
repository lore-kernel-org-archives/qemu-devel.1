Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963DDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6405820758
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SNYMq6nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6405820758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZcLY-0002NP-K8
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jZcKq-0001lS-AB
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:33:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jZcKo-00010L-Nh
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:33:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ebeb62c0000>; Fri, 15 May 2020 08:33:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 15 May 2020 08:33:12 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 15 May 2020 08:33:12 -0700
Received: from [10.40.103.94] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 May
 2020 15:33:04 +0000
Subject: Re: [PATCH Kernel v20 5/8] vfio iommu: Implementation of ioctl for
 dirty pages tracking
To: Alex Williamson <alex.williamson@redhat.com>
References: <1589488667-9683-1-git-send-email-kwankhede@nvidia.com>
 <1589488667-9683-6-git-send-email-kwankhede@nvidia.com>
 <20200515100553.GA5559@joy-OptiPlex-7040>
 <be9ff834-04b5-56c2-b103-44eff794bd3a@nvidia.com>
 <20200515091533.53259392@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <8eb95e03-87f3-677a-698e-826ee0060deb@nvidia.com>
Date: Fri, 15 May 2020 21:03:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200515091533.53259392@w520.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1589556780; bh=sBb4QJGBqFoY/7NqZIfplcyZOFjamlsLitNHDE9hqCw=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=SNYMq6nnW7P5oF33pNTInNAff7nLFrD5i7WWwd5UMohg+YYQ8AQ2eUcGwcXWUaoLJ
 VkgVvAVd+RcSSJ6lI/D2gU28UbEgBxf10zv/WiHDuyF0epnKUPd3Co5m7BaqQviON7
 MkW2Y30G7sNm2ZzPYidxFkDme3KV4rXoQaFoJ5agLadTrEfah/1tphpti1jQbcyfOs
 UYd4b8YiV9+/caD0z/hsO7s5sWyx6bGTtwwLpDF1NFiq3em9/4FKYQFmmbzMxgrRFs
 rXoLEwByeN2A55/nqSwbLSMmWf/sKAbSUVYKKcjE/ueiK7HoTQSt1KFR0/GTJpGAcp
 JsE/eESOdLATg==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 11:33:13
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
 jonathan.davies@nutanix.com, Yan Zhao <yan.y.zhao@intel.com>,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/15/2020 8:45 PM, Alex Williamson wrote:
> On Fri, 15 May 2020 16:44:38 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 5/15/2020 3:35 PM, Yan Zhao wrote:
>>> On Fri, May 15, 2020 at 02:07:44AM +0530, Kirti Wankhede wrote:
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
>>>>
>>>> Fixed error reported by build bot by changing pgsize type from uint64_t
>>>> to size_t.
>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>> ---
>>>>    drivers/vfio/vfio_iommu_type1.c | 294 +++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 288 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>> index de17787ffece..b76d3b14abfd 100644
>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>> @@ -72,6 +72,7 @@ struct vfio_iommu {
>>>>    	uint64_t		pgsize_bitmap;
>>>>    	bool			v2;
>>>>    	bool			nesting;
>>>> +	bool			dirty_page_tracking;
>>>>    };
>>>>    
>>>>    struct vfio_domain {
>>>> @@ -92,6 +93,7 @@ struct vfio_dma {
>>>>    	bool			lock_cap;	/* capable(CAP_IPC_LOCK) */
>>>>    	struct task_struct	*task;
>>>>    	struct rb_root		pfn_list;	/* Ex-user pinned pfn list */
>>>> +	unsigned long		*bitmap;
>>>>    };
>>>>    
>>>>    struct vfio_group {
>>>> @@ -126,6 +128,19 @@ struct vfio_regions {
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
>>>> +#define DIRTY_BITMAP_PAGES_MAX	 ((u64)INT_MAX)
>>>> +#define DIRTY_BITMAP_SIZE_MAX	 DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
>>>> +
>>>>    static int put_pfn(unsigned long pfn, int prot);
>>>>    
>>>>    /*
>>>> @@ -176,6 +191,74 @@ static void vfio_unlink_dma(struct vfio_iommu *iommu, struct vfio_dma *old)
>>>>    	rb_erase(&old->node, &iommu->dma_list);
>>>>    }
>>>>    
>>>> +
>>>> +static int vfio_dma_bitmap_alloc(struct vfio_dma *dma, size_t pgsize)
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
>>>> +static void vfio_dma_populate_bitmap(struct vfio_dma *dma, size_t pgsize)
>>>> +{
>>>> +	struct rb_node *p;
>>>> +
>>>> +	for (p = rb_first(&dma->pfn_list); p; p = rb_next(p)) {
>>>> +		struct vfio_pfn *vpfn = rb_entry(p, struct vfio_pfn, node);
>>>> +
>>>> +		bitmap_set(dma->bitmap, (vpfn->iova - dma->iova) / pgsize, 1);
>>>> +	}
>>>> +}
>>>> +
>>>> +static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu, size_t pgsize)
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
>>>> @@ -568,6 +651,17 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>>>>    			vfio_unpin_page_external(dma, iova, do_accounting);
>>>>    			goto pin_unwind;
>>>>    		}
>>>> +
>>>> +		if (iommu->dirty_page_tracking) {
>>>> +			unsigned long pgshift = __ffs(iommu->pgsize_bitmap);
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
>>>> @@ -802,6 +896,7 @@ static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
>>>>    	vfio_unmap_unpin(iommu, dma, true);
>>>>    	vfio_unlink_dma(iommu, dma);
>>>>    	put_task_struct(dma->task);
>>>> +	vfio_dma_bitmap_free(dma);
>>>>    	kfree(dma);
>>>>    	iommu->dma_avail++;
>>>>    }
>>>> @@ -829,6 +924,80 @@ static void vfio_pgsize_bitmap(struct vfio_iommu *iommu)
>>>>    	}
>>>>    }
>>>>    
>>>> +static int update_user_bitmap(u64 __user *bitmap, struct vfio_dma *dma,
>>>> +			      dma_addr_t base_iova, size_t pgsize)
>>>> +{
>>>> +	unsigned long pgshift = __ffs(pgsize);
>>>> +	unsigned long nbits = dma->size >> pgshift;
>>>> +	unsigned long bit_offset = (dma->iova - base_iova) >> pgshift;
>>>> +	unsigned long copy_offset = bit_offset / BITS_PER_LONG;
>>>> +	unsigned long shift = bit_offset % BITS_PER_LONG;
>>>> +	unsigned long leftover;
>>>> +
>>>> +	if (shift) {
>>>> +		bitmap_shift_left(dma->bitmap, dma->bitmap, shift,
>>>> +				  nbits + shift);
>>>> +
>>>> +		if (copy_from_user(&leftover, (u64 *)bitmap + copy_offset,
>>>> +				   sizeof(leftover)))
>>>> +			return -EFAULT;
>>>> +
>>>> +		bitmap_or(dma->bitmap, dma->bitmap, &leftover, shift);
>>>> +	}
>>>> +
>>>> +	if (copy_to_user((u64 *)bitmap + copy_offset, dma->bitmap,
>>>> +			 DIRTY_BITMAP_BYTES(nbits + shift)))
>>>> +		return -EFAULT;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int vfio_iova_dirty_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
>>>> +				  dma_addr_t iova, size_t size, size_t pgsize)
>>>> +{
>>>> +	struct vfio_dma *dma;
>>>> +	dma_addr_t i = iova, limit = iova + size;
>>>> +	unsigned long pgshift = __ffs(pgsize);
>>>> +	size_t sz = size;
>>>> +	int ret;
>>>> +
>>>> +	while ((dma = vfio_find_dma(iommu, i, sz))) {
>>> not quite get the logic here.
>>> if (i, i + size) is intersecting with (dma->iova, dma->iova + dma->size),
>>> and a dma is found here, why the whole bitmap is cleared and copied?
>>>    
>>
>> This works with multiple but full vfio_dma, not intersects of vfio_dma,
>> similar to unmap ioctl.
> 
> I don't see that the VFIO_IOMMU_DIRTY_PAGES ioctl validates that like
> VFIO_IOMMU_UNMAP_DMA does though.  We should have the same test as
> vfio_dma_do_unmap() to verify that they user range doesn't bisect a
> mapping, otherwise Yan is right, it looks like we allow the user to
> specify an arbitrary range that might bisect a bitmap, but we clear and
> attempt to copy the entire bitmap to the user buffer regardless.

Sure, updating patch. I'll send next version in some time.

Thanks,
Kirti

