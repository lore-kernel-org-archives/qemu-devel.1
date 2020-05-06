Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8626C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 22:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA3A20753
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 22:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGZP43EC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA3A20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWSUQ-00005f-Px
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 18:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jWSTo-00083H-8o
 for qemu-devel@nongnu.org; Wed, 06 May 2020 18:25:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jWSTl-00033g-Te
 for qemu-devel@nongnu.org; Wed, 06 May 2020 18:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588803923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E3U+gsBilIHMZ4uPxCytIc/RMmv38zJeb/Hi2ox4QaI=;
 b=RGZP43ECvlygbzmatp6o94TYzwf6ONRUJTelu4+RdXdQcuv4hrzKkUaxsQtqynDjgkqI0u
 iHpPhoHB7JX65bkPC6KZPc/xPDAOPoT6SIxd9sQ6cdObfeWqZbkDC4WezK9Wiggci6NRX8
 OsTf2FFSKyjShF2QzuWmfqAxWfQAT2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-_N0XuafGPgq7bt-1I3bQFQ-1; Wed, 06 May 2020 18:25:19 -0400
X-MC-Unique: _N0XuafGPgq7bt-1I3bQFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CB5E460;
 Wed,  6 May 2020 22:25:17 +0000 (UTC)
Received: from w520.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D03F1001920;
 Wed,  6 May 2020 22:25:14 +0000 (UTC)
Date: Wed, 6 May 2020 16:25:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v18 5/7] vfio iommu: Update UNMAP_DMA ioctl to
 get dirty bitmap before unmap
Message-ID: <20200506162511.032bb1e6@w520.home>
In-Reply-To: <1588607939-26441-6-git-send-email-kwankhede@nvidia.com>
References: <1588607939-26441-1-git-send-email-kwankhede@nvidia.com>
 <1588607939-26441-6-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 16:22:47
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

On Mon, 4 May 2020 21:28:57 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> DMA mapped pages, including those pinned by mdev vendor drivers, might
> get unpinned and unmapped while migration is active and device is still
> running. For example, in pre-copy phase while guest driver could access
> those pages, host device or vendor driver can dirty these mapped pages.
> Such pages should be marked dirty so as to maintain memory consistency
> for a user making use of dirty page tracking.
> 
> To get bitmap during unmap, user should allocate memory for bitmap, set
> size of allocated memory, set page size to be considered for bitmap and
> set flag VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 84 +++++++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/vfio.h       | 10 +++++
>  2 files changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 01dcb417836f..8b27faf1ec38 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -983,12 +983,14 @@ static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
>  }
>  
>  static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> -			     struct vfio_iommu_type1_dma_unmap *unmap)
> +			     struct vfio_iommu_type1_dma_unmap *unmap,
> +			     struct vfio_bitmap *bitmap)
>  {
>  	uint64_t mask;
>  	struct vfio_dma *dma, *dma_last = NULL;
>  	size_t unmapped = 0;
>  	int ret = 0, retries = 0;
> +	unsigned long *final_bitmap = NULL, *temp_bitmap = NULL;
>  
>  	mask = ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
>  
> @@ -1041,6 +1043,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  			ret = -EINVAL;
>  			goto unlock;
>  		}
> +
>  		dma = vfio_find_dma(iommu, unmap->iova + unmap->size - 1, 0);
>  		if (dma && dma->iova + dma->size != unmap->iova + unmap->size) {
>  			ret = -EINVAL;
> @@ -1048,6 +1051,22 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  		}
>  	}
>  
> +	if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> +	     iommu->dirty_page_tracking) {

Why do we even accept VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP when not
dirty page tracking rather than returning -EINVAL?  It would simplify
things here to reject it at the ioctl and silently ignoring a flag is
rarely if ever the right approach.

> +		final_bitmap = kvzalloc(bitmap->size, GFP_KERNEL);
> +		if (!final_bitmap) {
> +			ret = -ENOMEM;
> +			goto unlock;
> +		}
> +
> +		temp_bitmap = kvzalloc(bitmap->size, GFP_KERNEL);
> +		if (!temp_bitmap) {
> +			ret = -ENOMEM;
> +			kfree(final_bitmap);
> +			goto unlock;
> +		}

YIKES!  So the user can instantly trigger the kernel to internally
allocate 2 x 256MB, regardless of how much they can actually map.

> +	}
> +
>  	while ((dma = vfio_find_dma(iommu, unmap->iova, unmap->size))) {
>  		if (!iommu->v2 && unmap->iova > dma->iova)
>  			break;
> @@ -1058,6 +1077,24 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  		if (dma->task->mm != current->mm)
>  			break;
>  
> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> +		     iommu->dirty_page_tracking) {
> +			unsigned long pgshift = __ffs(bitmap->pgsize);
> +			unsigned int npages = dma->size >> pgshift;
> +			unsigned int shift;
> +
> +			vfio_iova_dirty_bitmap(iommu, dma->iova, dma->size,
> +					bitmap->pgsize, (u64 *)temp_bitmap);

vfio_iova_dirty_bitmap() takes a __user bitmap, we're doing
copy_to_user() on a kernel allocated buffer???

> +
> +			shift = (dma->iova - unmap->iova) >> pgshift;
> +			if (shift)
> +				bitmap_shift_left(temp_bitmap, temp_bitmap,
> +						  shift, npages);
> +			bitmap_or(final_bitmap, final_bitmap, temp_bitmap,
> +				  shift + npages);
> +			memset(temp_bitmap, 0, bitmap->size);
> +		}

It seems like if the per vfio_dma dirty bitmap was oversized by a long
that we could shift it in place, then we'd only need one working bitmap
buffer and we could size that to fit the vfio_dma (or the largest
vfio_dma if we don't want to free and re-alloc for each vfio_dma).
We'd need to do more copy_to/from_user()s, but we'd also avoid copying
between sparse mappings (user zero'd bitmap required) and we'd have a
far more reasonable memory usage.  Thanks,

Alex

> +
>  		if (!RB_EMPTY_ROOT(&dma->pfn_list)) {
>  			struct vfio_iommu_type1_dma_unmap nb_unmap;
>  
> @@ -1088,6 +1125,16 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  	}
>  
>  unlock:
> +	if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> +	     iommu->dirty_page_tracking && final_bitmap) {
> +		if (copy_to_user((void __user *)bitmap->data, final_bitmap,
> +				 bitmap->size))
> +			ret = -EFAULT;
> +
> +		kfree(final_bitmap);
> +		kfree(temp_bitmap);
> +	}
> +
>  	mutex_unlock(&iommu->lock);
>  
>  	/* Report how much was unmapped */
> @@ -2419,17 +2466,46 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  
>  	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
>  		struct vfio_iommu_type1_dma_unmap unmap;
> -		long ret;
> +		struct vfio_bitmap bitmap = { 0 };
> +		int ret;
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
> +			size_t iommu_pgsize =
> +				(size_t)1 << __ffs(vfio_pgsize_bitmap(iommu));
> +
> +			if (unmap.argsz < (minsz + sizeof(bitmap)))
> +				return -EINVAL;
> +
> +			if (copy_from_user(&bitmap,
> +					   (void __user *)(arg + minsz),
> +					   sizeof(bitmap)))
> +				return -EFAULT;
> +
> +			/* allow only min supported pgsize */
> +			if (bitmap.pgsize != iommu_pgsize)
> +				return -EINVAL;
> +			if (!access_ok((void __user *)bitmap.data, bitmap.size))
> +				return -EINVAL;
> +
> +			pgshift = __ffs(bitmap.pgsize);
> +			ret = verify_bitmap_size(unmap.size >> pgshift,
> +						 bitmap.size);
> +			if (ret)
> +				return ret;
> +
> +		}
> +
> +		ret = vfio_dma_do_unmap(iommu, &unmap, &bitmap);
>  		if (ret)
>  			return ret;
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5f359c63f5ef..e3cbf8b78623 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1048,12 +1048,22 @@ struct vfio_bitmap {
>   * field.  No guarantee is made to the user that arbitrary unmaps of iova
>   * or size different from those used in the original mapping call will
>   * succeed.
> + * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get dirty bitmap
> + * before unmapping IO virtual addresses. When this flag is set, user must
> + * provide data[] as structure vfio_bitmap. User must allocate memory to get
> + * bitmap and must set size of allocated memory in vfio_bitmap.size field.
> + * A bit in bitmap represents one page of user provided page size in 'pgsize',
> + * consecutively starting from iova offset. Bit set indicates page at that
> + * offset from iova is dirty. Bitmap of pages in the range of unmapped size is
> + * returned in vfio_bitmap.data
>   */
>  struct vfio_iommu_type1_dma_unmap {
>  	__u32	argsz;
>  	__u32	flags;
> +#define VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP (1 << 0)
>  	__u64	iova;				/* IO virtual address */
>  	__u64	size;				/* Size of mapping (bytes) */
> +	__u8    data[];
>  };
>  
>  #define VFIO_IOMMU_UNMAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 14)


