Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5693AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255B4206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyoFtyDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255B4206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpLL-0002As-A9
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jCpJV-0007xh-2X
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jCpJT-0004lG-B4
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:45:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45080
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jCpJT-0004k1-46
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584125138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSvZm7PBRYTUrIttyG0arMITPwTPE8dNNadXvASK/f8=;
 b=EyoFtyDfEo3se75bc31tFz236YihUsjTFdpKugtuuvjHb2S8NN/MkdTj7CxEfqWszLed82
 HP7nCLOPp19OWh6KuwUXv+UOrAWEutAggK4nN59KoSqxRjERxIyfiX1vfGsZ79vQQZ6JTK
 cwdadcA9gbN3GJsLm6dP+fa058aaogA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-eRlh8g_QNlyQ1A_hRlR7Ug-1; Fri, 13 Mar 2020 14:45:34 -0400
X-MC-Unique: eRlh8g_QNlyQ1A_hRlR7Ug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 461E99B67B;
 Fri, 13 Mar 2020 18:45:32 +0000 (UTC)
Received: from x1.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A5BC61070;
 Fri, 13 Mar 2020 18:45:29 +0000 (UTC)
Date: Fri, 13 Mar 2020 12:45:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v13 Kernel 5/7] vfio iommu: Update UNMAP_DMA ioctl to
 get dirty bitmap before unmap
Message-ID: <20200313124529.402e01c3@x1.home>
In-Reply-To: <1584035607-23166-6-git-send-email-kwankhede@nvidia.com>
References: <1584035607-23166-1-git-send-email-kwankhede@nvidia.com>
 <1584035607-23166-6-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

On Thu, 12 Mar 2020 23:23:25 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Pages, pinned by external interface for requested IO virtual address
> range,  might get unpinned  and unmapped while migration is active and

"DMA mapped pages, including those pinned by mdev vendor drivers, might
get..."

> device is still running, that is, in pre-copy phase while guest driver

"...running.  For example, in pre-copy..."

> still could access those pages. Host device can write to these pages while
> those were mapped.

"...those pages, host device or vendor driver can dirty these mapped
pages."

> Such pages should be marked dirty so that after
> migration guest driver should still be able to complete the operation.

Complete what operation?  We need to report these dirty pages in order
to maintain memory consistency for a user making use of dirty page
tracking.

> To get bitmap during unmap, user should set flag
> VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP, bitmap memory should be allocated and
> zeroed by user space application. Bitmap size and page size should be set
> by user application.

It seems like zeroed pages are no longer strictly necessary now that we
require requests to match existing mappings, right?
 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 63 +++++++++++++++++++++++++++++++++++++----
>  include/uapi/linux/vfio.h       | 12 ++++++++
>  2 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 435e84269a28..4037b82c6db0 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -976,7 +976,8 @@ static int verify_bitmap_size(unsigned long npages, unsigned long bitmap_size)
>  }
>  
>  static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> -			     struct vfio_iommu_type1_dma_unmap *unmap)
> +			     struct vfio_iommu_type1_dma_unmap *unmap,
> +			     unsigned long *bitmap)
>  {
>  	uint64_t mask;
>  	struct vfio_dma *dma, *dma_last = NULL;
> @@ -1027,6 +1028,10 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  	 * will be returned if these conditions are not met.  The v2 interface
>  	 * will only return success and a size of zero if there were no
>  	 * mappings within the range.
> +	 *
> +	 * When VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP flag is set, unmap request
> +	 * must be for single mapping. Multiple mappings with this flag set is
> +	 * not supported.
>  	 */
>  	if (iommu->v2) {
>  		dma = vfio_find_dma(iommu, unmap->iova, 1);
> @@ -1034,6 +1039,13 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  			ret = -EINVAL;
>  			goto unlock;
>  		}
> +
> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> +		    (dma->iova != unmap->iova || dma->size != unmap->size)) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +
>  		dma = vfio_find_dma(iommu, unmap->iova + unmap->size - 1, 0);
>  		if (dma && dma->iova + dma->size != unmap->iova + unmap->size) {
>  			ret = -EINVAL;
> @@ -1051,6 +1063,11 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  		if (dma->task->mm != current->mm)
>  			break;
>  
> +		if (unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
> +			vfio_iova_dirty_bitmap(iommu, dma->iova, dma->size,
> +					       unmap->bitmap_pgsize,
> +					      (unsigned char __user *) bitmap);
> +
>  		if (!RB_EMPTY_ROOT(&dma->pfn_list)) {
>  			struct vfio_iommu_type1_dma_unmap nb_unmap;
>  
> @@ -1076,6 +1093,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  						    &nb_unmap);
>  			goto again;
>  		}
> +
>  		unmapped += dma->size;
>  		vfio_remove_dma(iommu, dma);
>  	}

Spurious white space.

> @@ -2406,22 +2424,57 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  
>  	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
>  		struct vfio_iommu_type1_dma_unmap unmap;
> -		long ret;
> +		unsigned long *bitmap = NULL;

Shouldn't this have a __user attribute?  Also long doesn't seem the
right type. void would be ok here.

> +		long ret, bsize;
>  
>  		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
>  
>  		if (copy_from_user(&unmap, (void __user *)arg, minsz))
>  			return -EFAULT;
>  
> -		if (unmap.argsz < minsz || unmap.flags)
> +		if (unmap.argsz < minsz ||
> +		    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
>  			return -EINVAL;
>  
> -		ret = vfio_dma_do_unmap(iommu, &unmap);
> +		if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
> +			unsigned long pgshift;
> +			uint64_t iommu_pgsizes = vfio_pgsize_bitmap(iommu);
> +			uint64_t iommu_pgmask =
> +				 ((uint64_t)1 << __ffs(iommu_pgsizes)) - 1;
> +

Need to test that unmap.argsz includes this.

> +			if (copy_from_user(&unmap, (void __user *)arg,
> +					   sizeof(unmap)))
> +				return -EFAULT;
> +
> +			pgshift = __ffs(unmap.bitmap_pgsize);
> +
> +			if (((unmap.bitmap_pgsize - 1) & iommu_pgmask) !=
> +			     (unmap.bitmap_pgsize - 1))
> +				return -EINVAL;
> +
> +			if ((unmap.bitmap_pgsize & iommu_pgsizes) !=
> +			     unmap.bitmap_pgsize)
> +				return -EINVAL;
> +			if (unmap.iova + unmap.size < unmap.iova)
> +				return -EINVAL;
> +			if (!access_ok((void __user *)unmap.bitmap,
> +				       unmap.bitmap_size))
> +				return -EINVAL;

These tests should be identical to the previous patch.

> +
> +			bsize = verify_bitmap_size(unmap.size >> pgshift,
> +						   unmap.bitmap_size);
> +			if (bsize < 0)
> +				return bsize;
> +			bitmap = unmap.bitmap;
> +		}
> +
> +		ret = vfio_dma_do_unmap(iommu, &unmap, bitmap);
>  		if (ret)
>  			return ret;
>  
> -		return copy_to_user((void __user *)arg, &unmap, minsz) ?
> +		ret = copy_to_user((void __user *)arg, &unmap, minsz) ?
>  			-EFAULT : 0;
> +		return ret;

Why?  Leftover debugging?

>  	} else if (cmd == VFIO_IOMMU_DIRTY_PAGES) {
>  		struct vfio_iommu_type1_dirty_bitmap dirty;
>  		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 02d555cc7036..12b2094f887e 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1004,12 +1004,24 @@ struct vfio_iommu_type1_dma_map {
>   * field.  No guarantee is made to the user that arbitrary unmaps of iova
>   * or size different from those used in the original mapping call will
>   * succeed.
> + * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get dirty bitmap
> + * before unmapping IO virtual addresses. When this flag is set, user should
> + * allocate memory to get bitmap, clear the bitmap memory by setting zero and
> + * should set size of allocated memory in bitmap_size field. One bit in bitmap
> + * represents per page , page of user provided page size in 'bitmap_pgsize',
> + * consecutively starting from iova offset. Bit set indicates page at that
> + * offset from iova is dirty. Bitmap of pages in the range of unmapped size is
> + * returned in bitmap.
>   */
>  struct vfio_iommu_type1_dma_unmap {
>  	__u32	argsz;
>  	__u32	flags;
> +#define VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP (1 << 0)
>  	__u64	iova;				/* IO virtual address */
>  	__u64	size;				/* Size of mapping (bytes) */
> +	__u64        bitmap_pgsize;		/* page size for bitmap */
> +	__u64        bitmap_size;               /* in bytes */
> +	void __user *bitmap;                    /* one bit per page */

This suggests to me that we should further split struct
vfio_iommu_type1_dirty_bitmap_get so that we can use the same
sub-structure here.  For example:

struct vfio_bitmap {
	__u64 pgsize;
	__u64 size;
	__u64 __user *data;
};

Note we still have a void* rather than __u64* in original above.

Also, why wouldn't we take the same data[] approach as the previous
patch, defining this as the data when the GET_DIRTY_BITMAP flag is set?

Previous patch would be updated to something like:

struct vfio_iommu_type1_dirty_bitmap_get {
	__u64 iova;
	__u64 size;
	struct vfio_bitmap bitmap;
}; 

>  };
>  
>  #define VFIO_IOMMU_UNMAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 14)


