Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D226FC4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03C520709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrvZs818"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03C520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJuL-0001Jz-OW
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jFJs2-0007JI-K6
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jFJs0-00060T-UW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:47:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57091)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jFJs0-0005zj-PC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584719255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ilC8KwGDz/CQ02ddp+qbmntN6dYKnhQXGe+TwdF4Wg=;
 b=JrvZs818gL0+fBdvgI+b1+gRhI+zZb1ZgpkJZ84NSp5df4RBmpMX6N57GTwZ7houkCZI6f
 KxowZD50mQa5g1vNQfJSSgyhVPwASkzbxDG6xt46uiFxztIun0LfUIQqyr4u6r42dUorEI
 qevtF1FTHoC0zSWupZ24IhsnkOk+46Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-jAAo-4OfP5Sd35fQlZ-hMQ-1; Fri, 20 Mar 2020 11:47:31 -0400
X-MC-Unique: jAAo-4OfP5Sd35fQlZ-hMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C72E11005514;
 Fri, 20 Mar 2020 15:47:28 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C1C1912B5;
 Fri, 20 Mar 2020 15:47:27 +0000 (UTC)
Date: Fri, 20 Mar 2020 09:47:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v14 Kernel 5/7] vfio iommu: Update UNMAP_DMA ioctl to
 get dirty bitmap before unmap
Message-ID: <20200320094727.12aba30e@w520.home>
In-Reply-To: <20200320094039.4d99408d@w520.home>
References: <1584560474-19946-1-git-send-email-kwankhede@nvidia.com>
 <1584560474-19946-6-git-send-email-kwankhede@nvidia.com>
 <20200320083529.GA5456@joy-OptiPlex-7040>
 <20200320094039.4d99408d@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On Fri, 20 Mar 2020 09:40:39 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Fri, 20 Mar 2020 04:35:29 -0400
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > On Thu, Mar 19, 2020 at 03:41:12AM +0800, Kirti Wankhede wrote:  
> > > DMA mapped pages, including those pinned by mdev vendor drivers, might
> > > get unpinned and unmapped while migration is active and device is still
> > > running. For example, in pre-copy phase while guest driver could access
> > > those pages, host device or vendor driver can dirty these mapped pages.
> > > Such pages should be marked dirty so as to maintain memory consistency
> > > for a user making use of dirty page tracking.
> > > 
> > > To get bitmap during unmap, user should set flag
> > > VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP, bitmap memory should be allocated and
> > > zeroed by user space application. Bitmap size and page size should be set
> > > by user application.
> > > 
> > > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > > ---
> > >  drivers/vfio/vfio_iommu_type1.c | 55 ++++++++++++++++++++++++++++++++++++++---
> > >  include/uapi/linux/vfio.h       | 11 +++++++++
> > >  2 files changed, 62 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > > index d6417fb02174..aa1ac30f7854 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -939,7 +939,8 @@ static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
> > >  }
> > >  
> > >  static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> > > -			     struct vfio_iommu_type1_dma_unmap *unmap)
> > > +			     struct vfio_iommu_type1_dma_unmap *unmap,
> > > +			     struct vfio_bitmap *bitmap)
> > >  {
> > >  	uint64_t mask;
> > >  	struct vfio_dma *dma, *dma_last = NULL;
> > > @@ -990,6 +991,10 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> > >  	 * will be returned if these conditions are not met.  The v2 interface
> > >  	 * will only return success and a size of zero if there were no
> > >  	 * mappings within the range.
> > > +	 *
> > > +	 * When VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP flag is set, unmap request
> > > +	 * must be for single mapping. Multiple mappings with this flag set is
> > > +	 * not supported.
> > >  	 */
> > >  	if (iommu->v2) {
> > >  		dma = vfio_find_dma(iommu, unmap->iova, 1);
> > > @@ -997,6 +1002,13 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> > >  			ret = -EINVAL;
> > >  			goto unlock;
> > >  		}
> > > +
> > > +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> > > +		    (dma->iova != unmap->iova || dma->size != unmap->size)) {    
> > dma is probably NULL here!  
> 
> Yep, I didn't look closely enough there.  This is situated right
> between the check to make sure we're not bisecting a mapping at the
> start of the unmap and the check to make sure we're not bisecting a
> mapping at the end of the unmap.  There's no guarantee that we have a
> valid pointer here.  The test should be in the while() loop below this
> code.

Actually the test could remain here, we can exit here if we can't find
a dma at the start of the unmap range with the GET_DIRTY_BITMAP flag,
but we absolutely cannot deref dma without testing it.

> > And this restriction on UNMAP would make some UNMAP operations of vIOMMU
> > fail.
> > 
> > e.g. below condition indeed happens in reality.
> > an UNMAP ioctl comes for IOVA range from 0xff800000, of size 0x200000
> > However, IOVAs in this range are mapped page by page.i.e., dma->size is 0x1000.
> > 
> > Previous, this UNMAP ioctl could unmap successfully as a whole.  
> 
> What triggers this in the guest?  Note that it's only when using the
> GET_DIRTY_BITMAP flag that this is restricted.  Does the event you're
> referring to potentially occur under normal circumstances in that mode?
> Thanks,
> 
> Alex
> 
> 
> > > +			ret = -EINVAL;
> > > +			goto unlock;
> > > +		}
> > > +
> > >  		dma = vfio_find_dma(iommu, unmap->iova + unmap->size - 1, 0);
> > >  		if (dma && dma->iova + dma->size != unmap->iova + unmap->size) {
> > >  			ret = -EINVAL;
> > > @@ -1014,6 +1026,12 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> > >  		if (dma->task->mm != current->mm)
> > >  			break;
> > >  
> > > +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> > > +		     iommu->dirty_page_tracking)
> > > +			vfio_iova_dirty_bitmap(iommu, dma->iova, dma->size,
> > > +					bitmap->pgsize,
> > > +					(unsigned char __user *) bitmap->data);
> > > +
> > >  		if (!RB_EMPTY_ROOT(&dma->pfn_list)) {
> > >  			struct vfio_iommu_type1_dma_unmap nb_unmap;
> > >  
> > > @@ -2369,17 +2387,46 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
> > >  
> > >  	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
> > >  		struct vfio_iommu_type1_dma_unmap unmap;
> > > -		long ret;
> > > +		struct vfio_bitmap bitmap = { 0 };
> > > +		int ret;
> > >  
> > >  		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
> > >  
> > >  		if (copy_from_user(&unmap, (void __user *)arg, minsz))
> > >  			return -EFAULT;
> > >  
> > > -		if (unmap.argsz < minsz || unmap.flags)
> > > +		if (unmap.argsz < minsz ||
> > > +		    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
> > >  			return -EINVAL;
> > >  
> > > -		ret = vfio_dma_do_unmap(iommu, &unmap);
> > > +		if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
> > > +			unsigned long pgshift;
> > > +			uint64_t iommu_pgsize =
> > > +					 1 << __ffs(vfio_pgsize_bitmap(iommu));
> > > +
> > > +			if (unmap.argsz < (minsz + sizeof(bitmap)))
> > > +				return -EINVAL;
> > > +
> > > +			if (copy_from_user(&bitmap,
> > > +					   (void __user *)(arg + minsz),
> > > +					   sizeof(bitmap)))
> > > +				return -EFAULT;
> > > +
> > > +			/* allow only min supported pgsize */
> > > +			if (bitmap.pgsize != iommu_pgsize)
> > > +				return -EINVAL;
> > > +			if (!access_ok((void __user *)bitmap.data, bitmap.size))
> > > +				return -EINVAL;
> > > +
> > > +			pgshift = __ffs(bitmap.pgsize);
> > > +			ret = verify_bitmap_size(unmap.size >> pgshift,
> > > +						 bitmap.size);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +		}
> > > +
> > > +		ret = vfio_dma_do_unmap(iommu, &unmap, &bitmap);
> > >  		if (ret)
> > >  			return ret;
> > >  
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 043e9eafb255..a704e5380f04 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -1010,12 +1010,23 @@ struct vfio_bitmap {
> > >   * field.  No guarantee is made to the user that arbitrary unmaps of iova
> > >   * or size different from those used in the original mapping call will
> > >   * succeed.
> > > + * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get dirty bitmap
> > > + * before unmapping IO virtual addresses. When this flag is set, user must
> > > + * provide data[] as structure vfio_bitmap. User must allocate memory to get
> > > + * bitmap, clear the bitmap memory by setting zero and must set size of
> > > + * allocated memory in vfio_bitmap.size field. One bit in bitmap
> > > + * represents per page, page of user provided page size in 'pgsize',
> > > + * consecutively starting from iova offset. Bit set indicates page at that
> > > + * offset from iova is dirty. Bitmap of pages in the range of unmapped size is
> > > + * returned in vfio_bitmap.data
> > >   */
> > >  struct vfio_iommu_type1_dma_unmap {
> > >  	__u32	argsz;
> > >  	__u32	flags;
> > > +#define VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP (1 << 0)
> > >  	__u64	iova;				/* IO virtual address */
> > >  	__u64	size;				/* Size of mapping (bytes) */
> > > +	__u8    data[];
> > >  };
> > >  
> > >  #define VFIO_IOMMU_UNMAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 14)
> > > -- 
> > > 2.7.0
> > >     
> >   
> 


