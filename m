Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47548C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F181420758
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwdTQEjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F181420758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZaSG-00014F-7Q
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jZaRJ-0000WQ-3Y
 for qemu-devel@nongnu.org; Fri, 15 May 2020 09:31:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53310
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jZaRH-0004Ns-1F
 for qemu-devel@nongnu.org; Fri, 15 May 2020 09:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589549505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tw6YcOdTb57tTJEpjUT4XTUayFnAW1S4FhIT3XPkFRo=;
 b=GwdTQEjh0Twb1OtQSEToA2Sl7KYqm7imxTSHLOS1ZSIf5hcNtyfWFYin2p782QDaoxLcLB
 w/nogAGUF7rW9t4u6dW9z6pkJUIDGCdJW8dOrr3NBHjtZfYzFHk+KuUNYxXbnTLuXgDjRr
 F1eJ2SWm9KViW2cfHEiytKG1sOKpnjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-bmGYwxU8O_aB9rsqs8KIYw-1; Fri, 15 May 2020 09:31:41 -0400
X-MC-Unique: bmGYwxU8O_aB9rsqs8KIYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8474E460;
 Fri, 15 May 2020 13:31:38 +0000 (UTC)
Received: from x1.home (ovpn-112-50.phx2.redhat.com [10.3.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D9095C254;
 Fri, 15 May 2020 13:31:36 +0000 (UTC)
Date: Fri, 15 May 2020 07:31:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v20 6/8] vfio iommu: Update UNMAP_DMA ioctl to
 get dirty bitmap before unmap
Message-ID: <20200515073135.2370a17d@x1.home>
In-Reply-To: <268ec129-a1cb-530a-c9b2-7ec53ddf4d17@nvidia.com>
References: <1589488667-9683-1-git-send-email-kwankhede@nvidia.com>
 <1589488667-9683-7-git-send-email-kwankhede@nvidia.com>
 <20200514212706.036a336a@x1.home>
 <5256f488-2d11-eb0f-6980-eea23f4d3019@nvidia.com>
 <20200514234726.03c2e345@x1.home>
 <268ec129-a1cb-530a-c9b2-7ec53ddf4d17@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Fri, 15 May 2020 12:17:03 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 5/15/2020 11:17 AM, Alex Williamson wrote:
> > On Fri, 15 May 2020 09:46:43 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 5/15/2020 8:57 AM, Alex Williamson wrote:  
> >>> On Fri, 15 May 2020 02:07:45 +0530
> >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>      
> >>>> DMA mapped pages, including those pinned by mdev vendor drivers, might
> >>>> get unpinned and unmapped while migration is active and device is still
> >>>> running. For example, in pre-copy phase while guest driver could access
> >>>> those pages, host device or vendor driver can dirty these mapped pages.
> >>>> Such pages should be marked dirty so as to maintain memory consistency
> >>>> for a user making use of dirty page tracking.
> >>>>
> >>>> To get bitmap during unmap, user should allocate memory for bitmap, set
> >>>> it all zeros, set size of allocated memory, set page size to be
> >>>> considered for bitmap and set flag VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP.
> >>>>
> >>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >>>> ---
> >>>>    drivers/vfio/vfio_iommu_type1.c | 77 ++++++++++++++++++++++++++++++++++-------
> >>>>    include/uapi/linux/vfio.h       | 10 ++++++
> >>>>    2 files changed, 75 insertions(+), 12 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >>>> index b76d3b14abfd..a1dc57bcece5 100644
> >>>> --- a/drivers/vfio/vfio_iommu_type1.c
> >>>> +++ b/drivers/vfio/vfio_iommu_type1.c
> >>>> @@ -195,11 +195,15 @@ static void vfio_unlink_dma(struct vfio_iommu *iommu, struct vfio_dma *old)
> >>>>    static int vfio_dma_bitmap_alloc(struct vfio_dma *dma, size_t pgsize)
> >>>>    {
> >>>>    	uint64_t npages = dma->size / pgsize;
> >>>> +	size_t bitmap_size;
> >>>>    
> >>>>    	if (npages > DIRTY_BITMAP_PAGES_MAX)
> >>>>    		return -EINVAL;
> >>>>    
> >>>> -	dma->bitmap = kvzalloc(DIRTY_BITMAP_BYTES(npages), GFP_KERNEL);
> >>>> +	/* Allocate extra 64 bits which are used for bitmap manipulation */
> >>>> +	bitmap_size = DIRTY_BITMAP_BYTES(npages) + sizeof(u64);
> >>>> +
> >>>> +	dma->bitmap = kvzalloc(bitmap_size, GFP_KERNEL);
> >>>>    	if (!dma->bitmap)
> >>>>    		return -ENOMEM;
> >>>>    
> >>>> @@ -999,23 +1003,25 @@ static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
> >>>>    }
> >>>>    
> >>>>    static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >>>> -			     struct vfio_iommu_type1_dma_unmap *unmap)
> >>>> +			     struct vfio_iommu_type1_dma_unmap *unmap,
> >>>> +			     struct vfio_bitmap *bitmap)
> >>>>    {
> >>>> -	uint64_t mask;
> >>>>    	struct vfio_dma *dma, *dma_last = NULL;
> >>>> -	size_t unmapped = 0;
> >>>> +	size_t unmapped = 0, pgsize;
> >>>>    	int ret = 0, retries = 0;
> >>>> +	unsigned long pgshift;
> >>>>    
> >>>>    	mutex_lock(&iommu->lock);
> >>>>    
> >>>> -	mask = ((uint64_t)1 << __ffs(iommu->pgsize_bitmap)) - 1;
> >>>> +	pgshift = __ffs(iommu->pgsize_bitmap);
> >>>> +	pgsize = (size_t)1 << pgshift;
> >>>>    
> >>>> -	if (unmap->iova & mask) {
> >>>> +	if (unmap->iova & (pgsize - 1)) {
> >>>>    		ret = -EINVAL;
> >>>>    		goto unlock;
> >>>>    	}
> >>>>    
> >>>> -	if (!unmap->size || unmap->size & mask) {
> >>>> +	if (!unmap->size || unmap->size & (pgsize - 1)) {
> >>>>    		ret = -EINVAL;
> >>>>    		goto unlock;
> >>>>    	}
> >>>> @@ -1026,9 +1032,15 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >>>>    		goto unlock;
> >>>>    	}
> >>>>    
> >>>> -	WARN_ON(mask & PAGE_MASK);
> >>>> -again:
> >>>> +	/* When dirty tracking is enabled, allow only min supported pgsize */
> >>>> +	if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> >>>> +	    (!iommu->dirty_page_tracking || (bitmap->pgsize != pgsize))) {
> >>>> +		ret = -EINVAL;
> >>>> +		goto unlock;
> >>>> +	}
> >>>>    
> >>>> +	WARN_ON((pgsize - 1) & PAGE_MASK);
> >>>> +again:
> >>>>    	/*
> >>>>    	 * vfio-iommu-type1 (v1) - User mappings were coalesced together to
> >>>>    	 * avoid tracking individual mappings.  This means that the granularity
> >>>> @@ -1066,6 +1078,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >>>>    			ret = -EINVAL;
> >>>>    			goto unlock;
> >>>>    		}
> >>>> +
> >>>>    		dma = vfio_find_dma(iommu, unmap->iova + unmap->size - 1, 0);
> >>>>    		if (dma && dma->iova + dma->size != unmap->iova + unmap->size) {
> >>>>    			ret = -EINVAL;
> >>>> @@ -1083,6 +1096,23 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >>>>    		if (dma->task->mm != current->mm)
> >>>>    			break;
> >>>>    
> >>>> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> >>>> +		    (dma_last != dma)) {
> >>>> +
> >>>> +			/*
> >>>> +			 * mark all pages dirty if all pages are pinned and
> >>>> +			 * mapped
> >>>> +			 */
> >>>> +			if (dma->iommu_mapped)
> >>>> +				bitmap_set(dma->bitmap, 0,
> >>>> +					   dma->size >> pgshift);  
> >>>
> >>> Nit, all the callers of update_user_bitmap() precede the call with this
> >>> identical operation, we should probably push it into the function to do
> >>> it.
> >>>      
> >>>> +
> >>>> +			ret = update_user_bitmap(bitmap->data, dma,
> >>>> +						 unmap->iova, pgsize);
> >>>> +			if (ret)
> >>>> +				break;
> >>>> +		}
> >>>> +  
> >>>
> >>> As noted last time, the above is just busy work if pfn_list is not
> >>> already empty.  The entire code block above should be moved to after
> >>> the block below.  Thanks,
> >>>      
> >>
> >> pfn_list will be empty for IOMMU backed devices where all pages are
> >> pinned and mapped,  
> > 
> > Unless we're making use of the selective dirtying introduced in patch
> > 8/8 or the container is shared with non-IOMMU backed mdevs.
> >   
> >> but those should be reported as dirty.  
> > 
> > I'm confused how that justifies or requires this ordering.
> >   
> 
> 1. non IOMMU mdev device:
> - vendor driver pins pages
> - pfn_list is not empty
> - device dma or write to pinned pages
> 
> 2. IOMMU backed mdev device or vfio device, but smart driver which pins 
> required pages
> - vendor driver pins pages
> - pfn_list is not empty
> - device dma or write to pinned pages
> 
> 3. IOMMU backed mdev device or vfio device, driver is not smart
> - pages are pinned and mapped during attach
> - pfn_list is empty
> - device dma or write to any of pinned pages
> 
> For case 3, here this function does bitmap_set(dma->bitmap), that is 
> mark all pages dirty and then accordingly copy bitmap to user buffer.
> Copying dma->bitmap logic remains same.

What dependency does case 3 have on pfn_list?  Why does it matter if
that bitmap_set() occurs before or after we've drained pfn_list?  How
do we know we're in case 3 before we've looked at pfn_list?

> >> So moved it
> >> back above empty pfn_list check.  
> > 
> > Sorry, it still doesn't make any sense to me, and with no discussion I
> > can't differentiate ignored comments from discarded comments.
> > 
> > Pages in the pfn_list contribute to the dirty bitmap when they're
> > pinned, we don't depend on pfn_list when reporting the dirty bitmap
> > except for re-populating pfn_list dirtied pages after the bitmap has
> > been cleared.  We're unmapping the dma, so that's not the case here.
> > Also since update_user_bitmap() shifts the bitmap in place now, any
> > repetitive calls will give us incorrect results.  
> 
> Right, but this is unmapping and freeing vfio_dma
> 
> >  Therefore, as I see
> > it, we _can_ take the branch below and when we do any work we've done
> > above is not only wasted but may lead to incorrect data copied to
> > the user if we shift dma->bitmap in place more than once.  Please
> > explain in more detail if you believe this is still correct.  Thanks,
> >   
> 
> In this case also bitmap copy to user happens once, (dma_last != dma) 
> takes care of making sure that its called only once.

I did miss the dma_last check, so that prevents us from repeating this
path, BUT we release iommu->lock if we enter the pfn_list !empty path.
The moment we do that, we might unblock a vendor driver trying to pin
or rw more pages.  So the bitmap we've copied to the user might be stale
and incorrect.  I don't see why this is so contentious, what is the
actual disadvantage to moving this until after we've drained pfn_list?
The risks seem abundant to me.  Thanks,

Alex

> >>>      
> >>>>    		if (!RB_EMPTY_ROOT(&dma->pfn_list)) {
> >>>>    			struct vfio_iommu_type1_dma_unmap nb_unmap;
> >>>>    
> >>>> @@ -2447,17 +2477,40 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
> >>>>    
> >>>>    	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
> >>>>    		struct vfio_iommu_type1_dma_unmap unmap;
> >>>> -		long ret;
> >>>> +		struct vfio_bitmap bitmap = { 0 };
> >>>> +		int ret;
> >>>>    
> >>>>    		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
> >>>>    
> >>>>    		if (copy_from_user(&unmap, (void __user *)arg, minsz))
> >>>>    			return -EFAULT;
> >>>>    
> >>>> -		if (unmap.argsz < minsz || unmap.flags)
> >>>> +		if (unmap.argsz < minsz ||
> >>>> +		    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
> >>>>    			return -EINVAL;
> >>>>    
> >>>> -		ret = vfio_dma_do_unmap(iommu, &unmap);
> >>>> +		if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
> >>>> +			unsigned long pgshift;
> >>>> +
> >>>> +			if (unmap.argsz < (minsz + sizeof(bitmap)))
> >>>> +				return -EINVAL;
> >>>> +
> >>>> +			if (copy_from_user(&bitmap,
> >>>> +					   (void __user *)(arg + minsz),
> >>>> +					   sizeof(bitmap)))
> >>>> +				return -EFAULT;
> >>>> +
> >>>> +			if (!access_ok((void __user *)bitmap.data, bitmap.size))
> >>>> +				return -EINVAL;
> >>>> +
> >>>> +			pgshift = __ffs(bitmap.pgsize);
> >>>> +			ret = verify_bitmap_size(unmap.size >> pgshift,
> >>>> +						 bitmap.size);
> >>>> +			if (ret)
> >>>> +				return ret;
> >>>> +		}
> >>>> +
> >>>> +		ret = vfio_dma_do_unmap(iommu, &unmap, &bitmap);
> >>>>    		if (ret)
> >>>>    			return ret;
> >>>>    
> >>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >>>> index 123de3bc2dce..0a0c7315ddd6 100644
> >>>> --- a/include/uapi/linux/vfio.h
> >>>> +++ b/include/uapi/linux/vfio.h
> >>>> @@ -1048,12 +1048,22 @@ struct vfio_bitmap {
> >>>>     * field.  No guarantee is made to the user that arbitrary unmaps of iova
> >>>>     * or size different from those used in the original mapping call will
> >>>>     * succeed.
> >>>> + * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get dirty bitmap
> >>>> + * before unmapping IO virtual addresses. When this flag is set, user must
> >>>> + * provide data[] as structure vfio_bitmap. User must allocate memory to get
> >>>> + * bitmap, zero the bitmap memory and must set size of allocated memory in
> >>>> + * vfio_bitmap.size field. A bit in bitmap represents one page of user provided
> >>>> + * page size in 'pgsize', consecutively starting from iova offset. Bit set
> >>>> + * indicates page at that offset from iova is dirty. Bitmap of pages in the
> >>>> + * range of unmapped size is returned in vfio_bitmap.data
> >>>>     */
> >>>>    struct vfio_iommu_type1_dma_unmap {
> >>>>    	__u32	argsz;
> >>>>    	__u32	flags;
> >>>> +#define VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP (1 << 0)
> >>>>    	__u64	iova;				/* IO virtual address */
> >>>>    	__u64	size;				/* Size of mapping (bytes) */
> >>>> +	__u8    data[];
> >>>>    };
> >>>>    
> >>>>    #define VFIO_IOMMU_UNMAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 14)  
> >>>      
> >>  
> >   
> 


