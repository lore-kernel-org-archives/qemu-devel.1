Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572ABC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 22:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD3D2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 22:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL8FBU+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD3D2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihLmc-00059T-Uw
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 17:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1ihLl4-0003r4-IT
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 17:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1ihLl0-00075Z-VG
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 17:56:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32449
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1ihLl0-00071k-GF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 17:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576623357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGYUREhz14GULwzK2Yc0R7bE0hGIU0pT9Pdbf4FvK2s=;
 b=fL8FBU+UpavqDIZn/cn4zGhL1AhyNrJ6hFHFEI39skHpXhwOmvTKcBLG0xjDfgk0tlWcrO
 OLiejn2r5JptUtNDL+vBsBlQhqTJC4Emw1emTn4BCd2NvMwKUmRnxhtra65p+SHtXsRpAq
 Zkwla3HSa3NxzGEDitbHmkl4C6JXbZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-XK-F54CXOw-yosoE-P1tdg-1; Tue, 17 Dec 2019 17:55:54 -0500
X-MC-Unique: XK-F54CXOw-yosoE-P1tdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47671800D41;
 Tue, 17 Dec 2019 22:55:52 +0000 (UTC)
Received: from x1.home (ovpn-116-53.phx2.redhat.com [10.3.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A24C660BF1;
 Tue, 17 Dec 2019 22:55:50 +0000 (UTC)
Date: Tue, 17 Dec 2019 15:55:50 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v11 Kernel 4/6] vfio iommu: Update UNMAP_DMA ioctl to
 get dirty bitmap before unmap
Message-ID: <20191217155550.1f9408c0@x1.home>
In-Reply-To: <1576602651-15430-5-git-send-email-kwankhede@nvidia.com>
References: <1576602651-15430-1-git-send-email-kwankhede@nvidia.com>
 <1576602651-15430-5-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

On Tue, 17 Dec 2019 22:40:49 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Pages, pinned by external interface for requested IO virtual address
> range,  might get unpinned  and unmapped while migration is active and
> device is still running, that is, in pre-copy phase while guest driver
> still could access those pages. Host device can write to these pages while
> those were mapped. Such pages should be marked dirty so that after
> migration guest driver should still be able to complete the operation.
> 
> To get bitmap during unmap, user should set flag
> VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP, bitmap memory should be allocated and
> zeroed by user space application. Bitmap size and page size should be set
> by user application.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 63 ++++++++++++++++++++++++++++++++++++-----
>  include/uapi/linux/vfio.h       | 12 ++++++++
>  2 files changed, 68 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 215aecb25453..101c2b1e72b4 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -974,7 +974,8 @@ static long verify_bitmap_size(unsigned long npages, unsigned long bitmap_size)
>  }
>  
>  static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
> -			     struct vfio_iommu_type1_dma_unmap *unmap)
> +			     struct vfio_iommu_type1_dma_unmap *unmap,
> +			     unsigned long *bitmap)
>  {
>  	uint64_t mask;
>  	struct vfio_dma *dma, *dma_last = NULL;
> @@ -1049,6 +1050,15 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  		if (dma->task->mm != current->mm)
>  			break;
>  
> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
> +		    (dma_last != dma))
> +			vfio_iova_dirty_bitmap(iommu, dma->iova, dma->size,
> +					     unmap->bitmap_pgsize, unmap->iova,
> +					     bitmap);
> +		else
> +			vfio_remove_unpinned_from_pfn_list(dma, true);
> +
> +
>  		if (!RB_EMPTY_ROOT(&dma->pfn_list)) {
>  			struct vfio_iommu_type1_dma_unmap nb_unmap;
>  
> @@ -1074,6 +1084,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  						    &nb_unmap);
>  			goto again;
>  		}
> +
>  		unmapped += dma->size;
>  		vfio_remove_dma(iommu, dma);
>  	}
> @@ -2404,22 +2415,60 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  
>  	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
>  		struct vfio_iommu_type1_dma_unmap unmap;
> -		long ret;
> +		unsigned long *bitmap = NULL;
> +		long ret, bsize;
>  
>  		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
>  
> -		if (copy_from_user(&unmap, (void __user *)arg, minsz))
> +		if (copy_from_user(&unmap, (void __user *)arg, sizeof(unmap)))

If we only require minsz, how are we going to copy sizeof(unmap)?  This
breaks existing userspace.  You'll need to copy the remainder of the
user data after validating that they've provided it.

>  			return -EFAULT;
>  
> -		if (unmap.argsz < minsz || unmap.flags)
> +		if (unmap.argsz < minsz ||
> +		    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
>  			return -EINVAL;
>  
> -		ret = vfio_dma_do_unmap(iommu, &unmap);
> +		if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
> +			unsigned long pgshift = __ffs(unmap.bitmap_pgsize);
> +			uint64_t iommu_pgmask =
> +			 ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
> +
> +			if (((unmap.bitmap_pgsize - 1) & iommu_pgmask) !=
> +			     (unmap.bitmap_pgsize - 1))
> +				return -EINVAL;
> +
> +			bsize = verify_bitmap_size(unmap.size >> pgshift,
> +						   unmap.bitmap_size);
> +			if (bsize < 0)
> +				return bsize;
> +
> +			bitmap = kmalloc(bsize, GFP_KERNEL);

Same allocation that we cannot do.  Thanks,

Alex

> +			if (!bitmap)
> +				return -ENOMEM;
> +
> +			if (copy_from_user(bitmap, (void __user *)unmap.bitmap,
> +					   bsize)) {
> +				ret = -EFAULT;
> +				goto unmap_exit;
> +			}
> +		}
> +
> +		ret = vfio_dma_do_unmap(iommu, &unmap, bitmap);
>  		if (ret)
> -			return ret;
> +			goto unmap_exit;
>  
> -		return copy_to_user((void __user *)arg, &unmap, minsz) ?
> +		if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
> +			if (copy_to_user((void __user *)unmap.bitmap, bitmap,
> +					  bsize)) {
> +				ret = -EFAULT;
> +				goto unmap_exit;
> +			}
> +		}
> +
> +		ret = copy_to_user((void __user *)arg, &unmap, minsz) ?
>  			-EFAULT : 0;
> +unmap_exit:
> +		kfree(bitmap);
> +		return ret;
>  	} else if (cmd == VFIO_IOMMU_DIRTY_PAGES) {
>  		struct vfio_iommu_type1_dirty_bitmap range;
>  		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 8268634e7e08..e8e044c4974d 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -964,12 +964,24 @@ struct vfio_iommu_type1_dma_map {
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
>  };
>  
>  #define VFIO_IOMMU_UNMAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 14)


