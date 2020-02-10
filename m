Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB00C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729FE20715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHc6QfLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729FE20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1F44-0007Wf-Hs
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 14:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1j1EzX-0004R9-3t
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1j1EzR-0007W6-Mr
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:45:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46655
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1j1EzR-0007Tt-Ha
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581363904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CB7ogxanCwTl3KhojwycpYzXdMiK9Zrb4b+oeBFh5K4=;
 b=MHc6QfLEH5oHgQILt5BcTPWe2EP0dzCrB2z8v1Q3ChifN7N6sCCrUWpV3IGZ8TIkLs13mr
 6eHhVpdhCjzW/P0YSCbETqPgKukkGKXp21QvOB/zXoMvrPXVb8fhhVKLJdL1HTlOH4GaAW
 AE2kT2aYdxTkSROVOa5e4f/7fkAtRYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-4L9-IKF6O4SPIY1jAdRc0Q-1; Mon, 10 Feb 2020 14:44:59 -0500
X-MC-Unique: 4L9-IKF6O4SPIY1jAdRc0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8FEA107ACC5;
 Mon, 10 Feb 2020 19:44:56 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA0F019C70;
 Mon, 10 Feb 2020 19:44:54 +0000 (UTC)
Date: Mon, 10 Feb 2020 12:44:54 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v12 Kernel 4/7] vfio iommu: Implementation of ioctl to
 for dirty pages tracking.
Message-ID: <20200210124454.12e0419a@w520.home>
In-Reply-To: <20200210094954.GA4530@joy-OptiPlex-7040>
References: <1581104554-10704-1-git-send-email-kwankhede@nvidia.com>
 <1581104554-10704-5-git-send-email-kwankhede@nvidia.com>
 <20200210094954.GA4530@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Feb 2020 04:49:54 -0500
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Sat, Feb 08, 2020 at 03:42:31AM +0800, Kirti Wankhede wrote:
> > VFIO_IOMMU_DIRTY_PAGES ioctl performs three operations:
> > - Start pinned and unpinned pages tracking while migration is active
> > - Stop pinned and unpinned dirty pages tracking. This is also used to
> >   stop dirty pages tracking if migration failed or cancelled.
> > - Get dirty pages bitmap. This ioctl returns bitmap of dirty pages, its
> >   user space application responsibility to copy content of dirty pages
> >   from source to destination during migration.
> > 
> > To prevent DoS attack, memory for bitmap is allocated per vfio_dma
> > structure. Bitmap size is calculated considering smallest supported page
> > size. Bitmap is allocated when dirty logging is enabled for those
> > vfio_dmas whose vpfn list is not empty or whole range is mapped, in
> > case of pass-through device.
> > 
> > There could be multiple option as to when bitmap should be populated:
> > * Polulate bitmap for already pinned pages when bitmap is allocated for
> >   a vfio_dma with the smallest supported page size. Updates bitmap from
> >   page pinning and unpinning functions. When user application queries
> >   bitmap, check if requested page size is same as page size used to
> >   populated bitmap. If it is equal, copy bitmap. But if not equal,
> >   re-populated bitmap according to requested page size and then copy to
> >   user.
> >   Pros: Bitmap gets populated on the fly after dirty tracking has
> >         started.
> >   Cons: If requested page size is different than smallest supported
> >         page size, then bitmap has to be re-populated again, with
> >         additional overhead of allocating bitmap memory again for
> >         re-population of bitmap.
> > 
> > * Populate bitmap when bitmap is queried by user application.
> >   Pros: Bitmap is populated with requested page size. This eliminates
> >         the need to re-populate bitmap if requested page size is
> >         different than smallest supported pages size.
> >   Cons: There is one time processing time, when bitmap is queried.
> > 
> > I prefer later option with simple logic and to eliminate over-head of
> > bitmap repopulation in case of differnt page sizes. Later option is
> > implemented in this patch.
> > 
> > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 299 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 287 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index d386461e5d11..df358dc1c85b 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
[snip]
> > @@ -830,6 +924,113 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
> >  	return bitmap;
> >  }
> >  
> > +static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
> > +				  size_t size, uint64_t pgsize,
> > +				  unsigned char __user *bitmap)
> > +{
> > +	struct vfio_dma *dma;
> > +	dma_addr_t i = iova, iova_limit;
> > +	unsigned int bsize, nbits = 0, l = 0;
> > +	unsigned long pgshift = __ffs(pgsize);
> > +
> > +	while ((dma = vfio_find_dma(iommu, i, pgsize))) {
> > +		int ret, j;
> > +		unsigned int npages = 0, shift = 0;
> > +		unsigned char temp = 0;
> > +
> > +		/* mark all pages dirty if all pages are pinned and mapped. */
> > +		if (dma->iommu_mapped) {
> > +			iova_limit = min(dma->iova + dma->size, iova + size);
> > +			npages = iova_limit/pgsize;
> > +			bitmap_set(dma->bitmap, 0, npages);  
> for pass-through devices, it's not good to always return all pinned pages as
> dirty. could it also call vfio_pin_pages to track dirty pages? or any
> other interface provided to do that?

See patch 7/7.  Thanks,

Alex


