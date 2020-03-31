Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307BEC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 19:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36AF208E0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 19:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTF4KtBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36AF208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJMEH-0000Fc-0F
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 15:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jJMDb-0008EB-Jc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 15:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jJMDZ-0000bE-Sd
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 15:06:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59679
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jJMDZ-0000ac-LD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 15:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585681592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgxHMDFHS7EdhZt/y8v9VvwjbCh3+IDnijixAq81LLE=;
 b=jTF4KtBaCGmF63FFv1qcbJPXMKU2oIjCJfrnNs3bEqMU/E2MC2V22SOJpYd/AlUFv+i/Ei
 FXGaSWAAEhiiHGZDw5rMUZtsWzLVx+vrlVuPQ6/td8idUsAsLG6seC2/BJt47AM9yy6gTA
 tjgqVjxvcZG0tB+7aIG7AxQVJRDKz6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-uqrVF3hiNaKxOqicctyvDQ-1; Tue, 31 Mar 2020 15:06:30 -0400
X-MC-Unique: uqrVF3hiNaKxOqicctyvDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7B288017CC;
 Tue, 31 Mar 2020 19:06:27 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 889775C1BB;
 Tue, 31 Mar 2020 19:06:25 +0000 (UTC)
Date: Tue, 31 Mar 2020 13:06:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v17 Kernel 5/7] vfio iommu: Update UNMAP_DMA ioctl to
 get dirty bitmap before unmap
Message-ID: <20200331130625.77851747@w520.home>
In-Reply-To: <66af06b5-4e87-9f7a-be85-08a68d6ab982@nvidia.com>
References: <1585587044-2408-1-git-send-email-kwankhede@nvidia.com>
 <1585587044-2408-6-git-send-email-kwankhede@nvidia.com>
 <20200330153421.6246c2c6@w520.home>
 <66af06b5-4e87-9f7a-be85-08a68d6ab982@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Wed, 1 Apr 2020 00:16:13 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 3/31/2020 3:04 AM, Alex Williamson wrote:
> > On Mon, 30 Mar 2020 22:20:42 +0530
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
> >>   drivers/vfio/vfio_iommu_type1.c | 55 ++++++++++++++++++++++++++++++++++++++---
> >>   include/uapi/linux/vfio.h       | 10 ++++++++
> >>   2 files changed, 61 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >> index 5efebc2b60e1..266550bd7307 100644
> >> --- a/drivers/vfio/vfio_iommu_type1.c
> >> +++ b/drivers/vfio/vfio_iommu_type1.c
> >> @@ -983,7 +983,8 @@ static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
> >>   }
> >>   
> >>   static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >> -			     struct vfio_iommu_type1_dma_unmap *unmap)
> >> +			     struct vfio_iommu_type1_dma_unmap *unmap,
> >> +			     struct vfio_bitmap *bitmap)
> >>   {
> >>   	uint64_t mask;
> >>   	struct vfio_dma *dma, *dma_last = NULL;
> >> @@ -1034,6 +1035,10 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >>   	 * will be returned if these conditions are not met.  The v2 interface
> >>   	 * will only return success and a size of zero if there were no
> >>   	 * mappings within the range.
> >> +	 *
> >> +	 * When VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP flag is set, unmap request
> >> +	 * must be for single mapping. Multiple mappings with this flag set is
> >> +	 * not supported.
> >>   	 */
> >>   	if (iommu->v2) {
> >>   		dma = vfio_find_dma(iommu, unmap->iova, 1);
> >> @@ -1041,6 +1046,14 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> >>   			ret = -EINVAL;
> >>   			goto unlock;
> >>   		}
> >> +
> >> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> >> +		    dma &&
> >> +		    (dma->iova != unmap->iova || dma->size != unmap->size)) {  
> > 
> > 
> > I think your intention was to return error if the user asked for the
> > dirty bitmap and the requested unmap range doesn't exactly match the
> > vfio_dma.  Not finding a vfio_dma should therefore also be an error.
> > For example, if we had a single mapping at {0x1000-0x1fff} and the user
> > unmapped with dirty bitmap {0x0-0x2fff}, that should return an error,
> > but it's not caught by the above because there is no vfio_dma @0x0.
> > Therefore I think you want:
> > 
> > ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> >   (!dma || dma->iova != unmap->iova || dma->size != unmap->size))
> > 
> > Right?  Thanks,
> >   
> 
> 
> Yes, updating check.
> 
> Is !dma here also error case when VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP 
> flag is not set?

No it's not.

> DMA_UNMAP ioctl returns how much was unmapped, from user space 
> perspective this would be from start of range (unmap->iova), right?

It's the actual amount of memory that was unmapped within the provided
range, without getting the dirty bitmap the range doesn't need to start
or end at a vfio_dma, it just cannot bisect a vfio_dma.  Thanks,

Alex


