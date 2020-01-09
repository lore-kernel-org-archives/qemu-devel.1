Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3243AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCAE2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQJ7Fnt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCAE2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZEt-0000LI-Um
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1ipZBl-0004Az-0x
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1ipZBi-0003Zk-T4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:53:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1ipZBi-0003Rl-Ly
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578581609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByYdTopOFsFIxMLyCUzGAcVQEKqnodxqLRl6jdvTal0=;
 b=WQJ7Fnt2ikXuF2Qio1d3FtV/LAetKTl033vB2PGAxTgMei7U4xeJsTkKIEUPxdXqkRw1T7
 mZfB+rv5I029qF5UcvRFg8hxgEO7izhzz8u3B68i8vN+67Ay8OA4vyAwAZhWmYzn8rBv3E
 8xp+pYhCrvq3oOJzkVmfxWvlm9zjLVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-h5j3maQAOtyl2XteOnk__Q-1; Thu, 09 Jan 2020 09:53:25 -0500
X-MC-Unique: h5j3maQAOtyl2XteOnk__Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EC7C1852E3E;
 Thu,  9 Jan 2020 14:53:23 +0000 (UTC)
Received: from x1.home (ovpn-116-128.phx2.redhat.com [10.3.116.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C03687EF6;
 Thu,  9 Jan 2020 14:53:05 +0000 (UTC)
Date: Thu, 9 Jan 2020 07:53:04 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v11 Kernel 3/6] vfio iommu: Implementation of ioctl to
 for dirty pages tracking.
Message-ID: <20200109075304.27c962dd@x1.home>
In-Reply-To: <f7db5eae-b650-6078-edb2-7fe20d71bd47@nvidia.com>
References: <1576602651-15430-1-git-send-email-kwankhede@nvidia.com>
 <1576602651-15430-4-git-send-email-kwankhede@nvidia.com>
 <20191217151203.342b686a@x1.home>
 <ebd08133-e258-9f5e-5c8f-f88d7165cd7a@nvidia.com>
 <20200107150223.0dab0a85@w520.home>
 <d2faa3fe-d656-5ba7-475a-9646298e3d50@nvidia.com>
 <20200108152934.68cd0e85@w520.home>
 <f7db5eae-b650-6078-edb2-7fe20d71bd47@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Thu, 9 Jan 2020 18:59:40 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 1/9/2020 3:59 AM, Alex Williamson wrote:
> > On Thu, 9 Jan 2020 01:31:16 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 1/8/2020 3:32 AM, Alex Williamson wrote:  
> >>> On Wed, 8 Jan 2020 01:37:03 +0530
> >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>      
> >>
> >> <snip>
> >>  
> >>>>>> +
> >>>>>> +	unlocked = vfio_iova_put_vfio_pfn(dma, vpfn, dirty_tracking);
> >>>>>>     
> >>>>>>     	if (do_accounting)
> >>>>>>     		vfio_lock_acct(dma, -unlocked, true);
> >>>>>> @@ -571,8 +606,12 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
> >>>>>>     
> >>>>>>     		vpfn = vfio_iova_get_vfio_pfn(dma, iova);
> >>>>>>     		if (vpfn) {
> >>>>>> -			phys_pfn[i] = vpfn->pfn;
> >>>>>> -			continue;
> >>>>>> +			if (vpfn->unpinned)
> >>>>>> +				vfio_remove_from_pfn_list(dma, vpfn);  
> >>>>>
> >>>>> This seems inefficient, we have an allocated vpfn at the right places
> >>>>> in the list, wouldn't it be better to repin the page?
> >>>>>         
> >>>>
> >>>> vfio_pin_page_external() takes care of pinning and accounting as well.  
> >>>
> >>> Yes, but could we call vfio_pin_page_external() without {unlinking,
> >>> freeing} and {re-allocating, linking} on either side of it since it's
> >>> already in the list?  That's the inefficient part.  Maybe at least a
> >>> TODO comment?
> >>>      
> >>
> >> Changing it as below:
> >>
> >>                   vpfn = vfio_iova_get_vfio_pfn(dma, iova);
> >>                   if (vpfn) {
> >> -                       phys_pfn[i] = vpfn->pfn;
> >> -                       continue;
> >> +                       if (vpfn->ref_count > 1) {
> >> +                               phys_pfn[i] = vpfn->pfn;
> >> +                               continue;
> >> +                       }
> >>                   }
> >>
> >>                   remote_vaddr = dma->vaddr + iova - dma->iova;
> >>                   ret = vfio_pin_page_external(dma, remote_vaddr,
> >> &phys_pfn[i],
> >>                                                do_accounting);
> >>                   if (ret)
> >>                           goto pin_unwind;
> >> -
> >> -               ret = vfio_add_to_pfn_list(dma, iova, phys_pfn[i]);
> >> -               if (ret) {
> >> -                       vfio_unpin_page_external(dma, iova, do_accounting);
> >> -                       goto pin_unwind;
> >> -               }
> >> +               if (!vpfn) {
> >> +                       ret = vfio_add_to_pfn_list(dma, iova, phys_pfn[i]);
> >> +                       if (ret) {
> >> +                               vfio_unpin_page_external(dma, iova,
> >> +                                                        do_accounting,
> >> false);
> >> +                               goto pin_unwind;
> >> +                       }
> >> +               } else
> >> +                       vpfn->pfn = phys_pfn[i];
> >>           }
> >>
> >>
> >>
> >>  
> >>>>>> +			else {
> >>>>>> +				phys_pfn[i] = vpfn->pfn;
> >>>>>> +				continue;
> >>>>>> +			}
> >>>>>>     		}
> >>>>>>     
> >>>>>>     		remote_vaddr = dma->vaddr + iova - dma->iova;
> >>>>>> @@ -583,7 +622,8 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
> >>>>>>     
> >>>>>>     		ret = vfio_add_to_pfn_list(dma, iova, phys_pfn[i]);
> >>>>>>     		if (ret) {
> >>>>>> -			vfio_unpin_page_external(dma, iova, do_accounting);
> >>>>>> +			vfio_unpin_page_external(dma, iova, do_accounting,
> >>>>>> +						 false);
> >>>>>>     			goto pin_unwind;
> >>>>>>     		}
> >>>>>>     	}  
> >>
> >> <snip>
> >>  
> >>>>     
> >>>>>> +		if (range.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
> >>>>>> +			iommu->dirty_page_tracking = true;
> >>>>>> +			return 0;
> >>>>>> +		} else if (range.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP) {
> >>>>>> +			iommu->dirty_page_tracking = false;
> >>>>>> +
> >>>>>> +			mutex_lock(&iommu->lock);
> >>>>>> +			vfio_remove_unpinned_from_dma_list(iommu);
> >>>>>> +			mutex_unlock(&iommu->lock);
> >>>>>> +			return 0;
> >>>>>> +
> >>>>>> +		} else if (range.flags &
> >>>>>> +				 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
> >>>>>> +			uint64_t iommu_pgmask;
> >>>>>> +			unsigned long pgshift = __ffs(range.pgsize);
> >>>>>> +			unsigned long *bitmap;
> >>>>>> +			long bsize;
> >>>>>> +
> >>>>>> +			iommu_pgmask =
> >>>>>> +			 ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
> >>>>>> +
> >>>>>> +			if (((range.pgsize - 1) & iommu_pgmask) !=
> >>>>>> +			    (range.pgsize - 1))
> >>>>>> +				return -EINVAL;
> >>>>>> +
> >>>>>> +			if (range.iova & iommu_pgmask)
> >>>>>> +				return -EINVAL;
> >>>>>> +			if (!range.size || range.size > SIZE_MAX)
> >>>>>> +				return -EINVAL;
> >>>>>> +			if (range.iova + range.size < range.iova)
> >>>>>> +				return -EINVAL;
> >>>>>> +
> >>>>>> +			bsize = verify_bitmap_size(range.size >> pgshift,
> >>>>>> +						   range.bitmap_size);
> >>>>>> +			if (bsize < 0)
> >>>>>> +				return ret;
> >>>>>> +
> >>>>>> +			bitmap = kmalloc(bsize, GFP_KERNEL);  
> >>>>>
> >>>>> I think I remember mentioning previously that we cannot allocate an
> >>>>> arbitrary buffer on behalf of the user, it's far too easy for them to
> >>>>> kill the kernel that way.  kmalloc is also limited in what it can
> >>>>> alloc.  
> >>>>
> >>>> That's the reason added verify_bitmap_size(), so that size is verified  
> >>>
> >>> That's only a consistency test, it only verifies that the user claims
> >>> to provide a bitmap sized sufficiently for the range they're trying to
> >>> request.  range.size is limited to SIZE_MAX, so 2^64, divided by page
> >>> size for 2^52 bits, 8bits per byte for 2^49 bytes of bitmap that we'd
> >>> try to kmalloc (512TB).  kmalloc is good for a couple MB AIUI.
> >>> Meanwhile the user doesn't actually need to allocate that bitmap in
> >>> order to crash the kernel.
> >>>      
> >>>>> Can't we use the user buffer directly or only work on a part of
> >>>>> it at a time?
> >>>>>         
> >>>>
> >>>> without copy_from_user(), how?  
> >>>
> >>> For starters, what's the benefit of copying the bitmap from the user
> >>> in the first place?  We presume the data is zero'd and if it's not,
> >>> that's the user's bug to sort out (we just need to define the API to
> >>> specify that).  Therefore the copy_from_user() is unnecessary anyway and
> >>> we really just need to copy_to_user() for any places we're setting
> >>> bits.  We could just walk through the range with an unsigned long
> >>> bitmap buffer, writing it out to userspace any time we reach the end
> >>> with bits set, zeroing it and shifting it as a window to the user
> >>> buffer.  We could improve batching by allocating a larger buffer in the
> >>> kernel, with a kernel defined maximum size and performing the same
> >>> windowing scheme.
> >>>      
> >>
> >> Ok removing copy_from_user().
> >> But AFAIK, calling copy_to_user() multiple times is not efficient in
> >> terms of performance.  
> > 
> > Right, but even with a modestly sized internal buffer for batching we
> > can cover quite a large address space.  128MB for a 4KB buffer, 32GB
> > with 1MB buffer.  __put_user() is more lightweight than copy_to_user(),
> > I wonder where the inflection point is in batching the latter versus
> > more iterations of the former.
> >   
> >> Checked code in virt/kvm/kvm_main.c: __kvm_set_memory_region() where
> >> dirty_bitmap is allocated, that has generic checks, user space address
> >> check, memory overflow check and KVM_MEM_MAX_NR_PAGES as below. I'll add
> >> access_ok check. I already added overflow check.
> >>
> >>           /* General sanity checks */
> >>           if (mem->memory_size & (PAGE_SIZE - 1))
> >>                   goto out;
> >>
> >>          !access_ok((void __user *)(unsigned long)mem->userspace_addr,
> >>                           mem->memory_size)))
> >>
> >>           if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
> >>                   goto out;
> >>
> >>           if (npages > KVM_MEM_MAX_NR_PAGES)
> >>                   goto out;
> >>
> >>
> >> Where KVM_MEM_MAX_NR_PAGES is:
> >>
> >> /*
> >>    * Some of the bitops functions do not support too long bitmaps.
> >>    * This number must be determined not to exceed such limits.
> >>    */
> >> #define KVM_MEM_MAX_NR_PAGES ((1UL << 31) - 1)
> >>
> >> But we can't use KVM specific KVM_MEM_MAX_NR_PAGES check in vfio module.
> >> Should we define similar limit in vfio module instead of SIZE_MAX?  
> > 
> > If we have ranges that are up to 2^31 pages, that's still 2^28 bytes.
> > Does it seem reasonable to have a kernel interface that potentially
> > allocates 256MB of kernel space with kmalloc accessible to users?  That
> > still seems like a DoS attack vector to me, especially since the user
> > doesn't need to be able to map that much memory (8TB) to access it.
> > 
> > I notice that KVM allocate the bitmap (kvzalloc) relative to the actual
> > size of the memory slot when dirty logging is enabled, maybe that's the
> > right approach rather than walking vpfn lists and maintaining unpinned
> > vpfns for the purposes of tracking.  For example, when dirty logging is
> > enabled, walk all vfio_dmas and allocate a dirty bitmap anywhere the
> > vpfn list is not empty and walk the vpfn list to set dirty bits in the
> > bitmap.   
> 
> Bitmap will be allocated per vfio_dma, not as per 
> VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP request, right?

Per vfio_dma when dirty logging is enabled, ie. between
VFIO_IOMMU_DIRTY_PAGES_FLAG_START and VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP.

> > When new pages are pinned, allocate a bitmap if not already
> > present and set the dirty bit.  When unpinned, update the vpfn list but
> > leave the dirty bit set.  When the dirty bitmap is read, copy out the
> > current bitmap to the user, memset it to zero, then re-walk the vpfn
> > list to set currently dirty pages.  
> 
> Why re-walk is required again? Pinning /unpinning or reporting dirty 
> pages are done holding iommu->lock, there shouldn't be race condition.

In order to "remember" that a page was dirtied, I proposed above that
we don't change the bitmap when a page is unpinned.  We can "forget"
that a page was dirtied if it's no longer pinned and we've told the
user about it.  Therefore we need to purge the not-currently-pinned
pages from the bitmap and rebuild it.

> >  A vfio_dma without a dirty bitmap
> > would consider the entire range dirty.  
> 
> That will depend on (!iommu->pinned_page_dirty_scope && 
> dma->iommu_mapped) condition to mark entire range dirty.

I assumed we wouldn't bother to maintain a bitmap unless these
conditions are already met.

> Here even if vpfn list is empty, memory for dirty_bitmap need to be 
> allocated, memset all bits to 1, then copy_to_user().

I was assuming we might use a __put_user() loop to fill such ranges
rather than waste memory tracking fully populated bitmaps.

> If we go with this approach, then I think there should be restriction to 
> get bitmap as per the way mappings were created, multiple mappings can 
> be clubbed together, but shouldn't bisect the mappings - similar to 
> unmap restriction.

Why?  It seems like it's just some pointer arithmetic to copy out the
section of the bitmap that the user requests.  Thanks,

Alex


