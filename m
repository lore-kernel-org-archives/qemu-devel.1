Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C09C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB5D20767
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jN8KUXiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB5D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFMtr-0004Br-Hd
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 15:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jFMre-0001zI-Bv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jFMrc-0004Vh-FR
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:59:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jFMrc-0004VO-9r
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584730763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Situe7CkKHU86H3iJ44BkECuWp01b+xagpPXOCTpCOY=;
 b=jN8KUXiuewQq5ELfhOSFC++CgIkKIlZyv3ouGCO4XPOPxaY5+reX5DOF4ytEbiWmH8bQ2b
 AqkXRl0O25NCd3VdLt5NarTDNXMsZKDaEvu8KAMQn6JpMW1YVqx0OZDLnh2tlJZiqvNcit
 r+5ikjKnINgCVAakouUSU7Klihi5w8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-2eeLGvj1OHWqJYT6I5UM3w-1; Fri, 20 Mar 2020 14:59:17 -0400
X-MC-Unique: 2eeLGvj1OHWqJYT6I5UM3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D5A7190681F;
 Fri, 20 Mar 2020 18:59:13 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 391151001938;
 Fri, 20 Mar 2020 18:59:11 +0000 (UTC)
Date: Fri, 20 Mar 2020 12:59:10 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v15 Kernel 4/7] vfio iommu: Implementation of ioctl for
 dirty pages tracking.
Message-ID: <20200320125910.028d7af5@w520.home>
In-Reply-To: <cf0ee134-c1c7-f60c-afc2-8948268d8880@nvidia.com>
References: <1584649004-8285-1-git-send-email-kwankhede@nvidia.com>
 <1584649004-8285-5-git-send-email-kwankhede@nvidia.com>
 <20200319165704.1f4eb36a@w520.home>
 <bc48ae5c-67f9-d95e-5d60-6c42359bb790@nvidia.com>
 <20200320120137.6acd89ee@x1.home>
 <cf0ee134-c1c7-f60c-afc2-8948268d8880@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Sat, 21 Mar 2020 00:12:04 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 3/20/2020 11:31 PM, Alex Williamson wrote:
> > On Fri, 20 Mar 2020 23:19:14 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 3/20/2020 4:27 AM, Alex Williamson wrote:  
> >>> On Fri, 20 Mar 2020 01:46:41 +0530
> >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>      
> 
> <snip>
> 
> >>>> +static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
> >>>> +				  size_t size, uint64_t pgsize,
> >>>> +				  u64 __user *bitmap)
> >>>> +{
> >>>> +	struct vfio_dma *dma;
> >>>> +	unsigned long pgshift = __ffs(pgsize);
> >>>> +	unsigned int npages, bitmap_size;
> >>>> +
> >>>> +	dma = vfio_find_dma(iommu, iova, 1);
> >>>> +
> >>>> +	if (!dma)
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	if (dma->iova != iova || dma->size != size)
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	npages = dma->size >> pgshift;
> >>>> +	bitmap_size = DIRTY_BITMAP_BYTES(npages);
> >>>> +
> >>>> +	/* mark all pages dirty if all pages are pinned and mapped. */
> >>>> +	if (dma->iommu_mapped)
> >>>> +		bitmap_set(dma->bitmap, 0, npages);
> >>>> +
> >>>> +	if (copy_to_user((void __user *)bitmap, dma->bitmap, bitmap_size))
> >>>> +		return -EFAULT;  
> >>>
> >>> We still need to reset the bitmap here, clearing and re-adding the
> >>> pages that are still pinned.
> >>>
> >>> https://lore.kernel.org/kvm/20200319070635.2ff5db56@x1.home/
> >>>      
> >>
> >> I thought you agreed on my reply to it
> >> https://lore.kernel.org/kvm/31621b70-02a9-2ea5-045f-f72b671fe703@nvidia.com/
> >>  
> >>   > Why re-populate when there will be no change since
> >>   > vfio_iova_dirty_bitmap() is called holding iommu->lock? If there is any
> >>   > pin request while vfio_iova_dirty_bitmap() is still working, it will
> >>   > wait till iommu->lock is released. Bitmap will be populated when page is
> >>   > pinned.  
> > 
> > As coded, dirty bits are only ever set in the bitmap, never cleared.
> > If a page is unpinned between iterations of the user recording the
> > dirty bitmap, it should be marked dirty in the iteration immediately
> > after the unpinning and not marked dirty in the following iteration.
> > That doesn't happen here.  We're reporting cumulative dirty pages since
> > logging was enabled, we need to be reporting dirty pages since the user
> > last retrieved the dirty bitmap.  The bitmap should be cleared and
> > currently pinned pages re-added after copying to the user.  Thanks,
> >   
> 
> Does that mean, we have to track every iteration? do we really need that 
> tracking?
> 
> Generally the flow is:
> - vendor driver pin x pages
> - Enter pre-copy-phase where vCPUs are running - user starts dirty pages 
> tracking, then user asks dirty bitmap, x pages reported dirty by 
> VFIO_IOMMU_DIRTY_PAGES ioctl with _GET flag
> - In pre-copy phase, vendor driver pins y more pages, now bitmap 
> consists of x+y bits set
> - In pre-copy phase, vendor driver unpins z pages, but bitmap is not 
> updated, so again bitmap consists of x+y bits set.
> - Enter in stop-and-copy phase, vCPUs are stopped, mdev devices are stopped
> - user asks dirty bitmap - Since here vCPU and mdev devices are stopped, 
> pages should not get dirty by guest driver or the physical device. 
> Hence, x+y dirty pages would be reported.
> 
> I don't think we need to track every iteration of bitmap reporting.

Yes, once a bitmap is read, it's reset.  In your example, after
unpinning z pages the user should still see a bitmap with x+y pages,
but once they've read that bitmap, the next bitmap should be x+y-z.
Userspace can make decisions about when to switch from pre-copy to
stop-and-copy based on convergence, ie. the slope of the line recording
dirty pages per iteration.  The implementation here never allows an
inflection point, dirty pages reported through vfio would always either
be flat or climbing.  There might also be a case that an iommu backed
device could start pinning pages during the course of a migration, how
would the bitmap ever revert from fully populated to only tracking the
pinned pages?  Thanks,

Alex


