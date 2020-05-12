Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1F7C2D0F8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 21:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2275C205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+5wAFST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2275C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYcME-0004np-7w
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 17:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jYcLP-00047z-2d
 for qemu-devel@nongnu.org; Tue, 12 May 2020 17:21:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52880
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jYcLN-0006cL-Bk
 for qemu-devel@nongnu.org; Tue, 12 May 2020 17:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589318498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQ2rl3aS9+2xWhKg7VyLlivpv3QAoa5GMGmyybxNF5U=;
 b=H+5wAFSTZbdxGHk7IcQLysFiWbJrh0ZRKMdgZzPLKE0i/fNpsRQJKCgmJ61o0TiKuY+J+F
 0Pbdkmsr/pqEEHgXcV+rFIIb/naptstEGTc2R9Qgrcl7M51MtLduScyiXS5+qaVCVLs2zb
 y8qC0knLW6K4SwbqFmZQDsNdJxYWEnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-fn0D0dGIPMKldi4vBl63qA-1; Tue, 12 May 2020 17:21:34 -0400
X-MC-Unique: fn0D0dGIPMKldi4vBl63qA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF67280B71D;
 Tue, 12 May 2020 21:21:31 +0000 (UTC)
Received: from x1.home (ovpn-113-111.phx2.redhat.com [10.3.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAE1A60F8D;
 Tue, 12 May 2020 21:21:29 +0000 (UTC)
Date: Tue, 12 May 2020 15:21:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v18 5/7] vfio iommu: Update UNMAP_DMA ioctl to
 get dirty bitmap before unmap
Message-ID: <20200512152129.0a17b702@x1.home>
In-Reply-To: <e4a5cb87-3bc3-ff1b-9ffb-479a4d418922@nvidia.com>
References: <1588607939-26441-1-git-send-email-kwankhede@nvidia.com>
 <1588607939-26441-6-git-send-email-kwankhede@nvidia.com>
 <20200506162511.032bb1e6@w520.home>
 <e4a5cb87-3bc3-ff1b-9ffb-479a4d418922@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

On Wed, 13 May 2020 02:00:54 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 5/7/2020 3:55 AM, Alex Williamson wrote:
> > On Mon, 4 May 2020 21:28:57 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> DMA mapped pages, including those pinned by mdev vendor drivers, might
> >> get unpinned and unmapped while migration is active and device is still
> >> running. For example, in pre-copy phase while guest driver could access
> >> those pages, host device or vendor driver can dirty these mapped pages.
> >> Such pages should be marked dirty so as to maintain memory consistency
> >> for a user making use of dirty page tracking.
> >>
> >> To get bitmap during unmap, user should allocate memory for bitmap, set
> >> size of allocated memory, set page size to be considered for bitmap and
> >> set flag VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> ---
> >>   drivers/vfio/vfio_iommu_type1.c | 84 +++++++++++++++++++++++++++++++++++++++--
> >>   include/uapi/linux/vfio.h       | 10 +++++
> >>   2 files changed, 90 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >> index 01dcb417836f..8b27faf1ec38 100644
> >> --- a/drivers/vfio/vfio_iommu_type1.c
> >> +++ b/drivers/vfio/vfio_iommu_type1.c
> >> @@ -983,12 +983,14 @@ static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
> >>   }
> >>   
> >>   static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >> -			     struct vfio_iommu_type1_dma_unmap *unmap)
> >> +			     struct vfio_iommu_type1_dma_unmap *unmap,
> >> +			     struct vfio_bitmap *bitmap)
> >>   {
> >>   	uint64_t mask;
> >>   	struct vfio_dma *dma, *dma_last = NULL;
> >>   	size_t unmapped = 0;
> >>   	int ret = 0, retries = 0;
> >> +	unsigned long *final_bitmap = NULL, *temp_bitmap = NULL;
> >>   
> >>   	mask = ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
> >>   
> >> @@ -1041,6 +1043,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >>   			ret = -EINVAL;
> >>   			goto unlock;
> >>   		}
> >> +
> >>   		dma = vfio_find_dma(iommu, unmap->iova + unmap->size - 1, 0);
> >>   		if (dma && dma->iova + dma->size != unmap->iova + unmap->size) {
> >>   			ret = -EINVAL;
> >> @@ -1048,6 +1051,22 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >>   		}
> >>   	}
> >>   
> >> +	if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> >> +	     iommu->dirty_page_tracking) {  
> > 
> > Why do we even accept VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP when not
> > dirty page tracking rather than returning -EINVAL?  It would simplify
> > things here to reject it at the ioctl and silently ignoring a flag is
> > rarely if ever the right approach.
> >   
> >> +		final_bitmap = kvzalloc(bitmap->size, GFP_KERNEL);
> >> +		if (!final_bitmap) {
> >> +			ret = -ENOMEM;
> >> +			goto unlock;
> >> +		}
> >> +
> >> +		temp_bitmap = kvzalloc(bitmap->size, GFP_KERNEL);
> >> +		if (!temp_bitmap) {
> >> +			ret = -ENOMEM;
> >> +			kfree(final_bitmap);
> >> +			goto unlock;
> >> +		}  
> > 
> > YIKES!  So the user can instantly trigger the kernel to internally
> > allocate 2 x 256MB, regardless of how much they can actually map.
> >   
> 
> That is worst case senario. I don't think ideally that will ever hit. 
> More comment below regarding this.

If a user has the ability to lock 8TB of memory, then yeah, triggering
the kernel to allocate 512MB might not be a big deal.  But in this case
a malicious user can trigger the kernel to allocate 512MB of memory
regardless of their locked memory limits.  I think that's unacceptable.
 
> >> +	}
> >> +
> >>   	while ((dma = vfio_find_dma(iommu, unmap->iova, unmap->size))) {
> >>   		if (!iommu->v2 && unmap->iova > dma->iova)
> >>   			break;
> >> @@ -1058,6 +1077,24 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >>   		if (dma->task->mm != current->mm)
> >>   			break;
> >>   
> >> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> >> +		     iommu->dirty_page_tracking) {
> >> +			unsigned long pgshift = __ffs(bitmap->pgsize);
> >> +			unsigned int npages = dma->size >> pgshift;
> >> +			unsigned int shift;
> >> +
> >> +			vfio_iova_dirty_bitmap(iommu, dma->iova, dma->size,
> >> +					bitmap->pgsize, (u64 *)temp_bitmap);  
> > 
> > vfio_iova_dirty_bitmap() takes a __user bitmap, we're doing
> > copy_to_user() on a kernel allocated buffer???
> >   
> 
> Actually, there is no need to call vfio_iova_dirty_bitmap(), dma pointer 
> is known here and since its getting unmapped, there is no need to 
> repopulate bitmap. Removing vfio_iova_dirty_bitmap() and changing it as 
> below:
> 
> if (unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
>      unsigned long pgshift = __ffs(bitmap->pgsize);
>      unsigned int npages = dma->size >> pgshift;
>      unsigned int bitmap_size = DIRTY_BITMAP_BYTES(npages);
>      unsigned int shift = (dma->iova - unmap->iova) >>
>                                              pgshift;
>      /*
>       * mark all pages dirty if all pages are pinned and
>       * mapped.
>       */
>      if (dma->iommu_mapped)
>          bitmap_set(temp_bitmap, 0, npages);
>      else
>          memcpy(temp_bitmap, dma->bitmap, bitmap_size);
> 
>      if (shift)
>          bitmap_shift_left(temp_bitmap, temp_bitmap,
>                            shift, npages);
>      bitmap_or(final_bitmap, final_bitmap, temp_bitmap,
>                shift + npages);
>      memset(temp_bitmap, 0, bitmap->size);
> }

Solves that problem, but I think also illustrates that if we could
shift dma->bitmap in place we could avoid a memcpy and a memset.

> >> +
> >> +			shift = (dma->iova - unmap->iova) >> pgshift;
> >> +			if (shift)
> >> +				bitmap_shift_left(temp_bitmap, temp_bitmap,
> >> +						  shift, npages);
> >> +			bitmap_or(final_bitmap, final_bitmap, temp_bitmap,
> >> +				  shift + npages);
> >> +			memset(temp_bitmap, 0, bitmap->size);
> >> +		}  
> > 
> > It seems like if the per vfio_dma dirty bitmap was oversized by a long
> > that we could shift it in place, then we'd only need one working bitmap
> > buffer and we could size that to fit the vfio_dma (or the largest
> > vfio_dma if we don't want to free and re-alloc for each vfio_dma).
> > We'd need to do more copy_to/from_user()s, but we'd also avoid copying
> > between sparse mappings (user zero'd bitmap required) and we'd have a
> > far more reasonable memory usage.  Thanks,
> >  
> 
> I thought about it, but couldn't optimize to use one bitmap buffer.
> This case will only hit during migration with vIOMMU enabled.
> Can we keep these 2 bitmap buffers for now and optimize it later?

I don't see how we can limit it to that use case, or why that use case
makes it any less important to avoid exploitable inefficiencies like
this.  We're also potentially changing the uapi from not requiring a
user zero'd buffer to requiring a user zero'd buffer, which means we'd
need to support a backwards compatible uapi, exposing a really
inefficient means for the kernel to zero user memory.

Can you identify what doesn't work about the above proposal?  TBH, once
we shift the dma->bitmap in place, we could make it so that we can
directly copy_to_user and we'd only need to fixup any unaligned
overlaps between mappings, which we could do with just a few bytes
rather than some large final_bitmap buffer.  Thanks,

Alex


