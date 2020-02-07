Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E271C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E0D20715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BuP2SuHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E0D20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0A6e-00034n-E4
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 15:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1j0A3c-0006K4-0K
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1j0A3a-0007Lh-DT
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:16:55 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1j0A3a-0007LH-5A
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:16:54 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e3dc5a60000>; Fri, 07 Feb 2020 12:16:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Fri, 07 Feb 2020 12:16:52 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Fri, 07 Feb 2020 12:16:52 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 20:16:53 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 7 Feb 2020 20:16:46 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v12 Kernel 5/7] vfio iommu: Update UNMAP_DMA ioctl to get
 dirty bitmap before unmap
Date: Sat, 8 Feb 2020 01:12:32 +0530
Message-ID: <1581104554-10704-6-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1581104554-10704-1-git-send-email-kwankhede@nvidia.com>
References: <1581104554-10704-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1581106599; bh=aoFkyD1phMFO3EyRxvdVkmH6qXD9Mf9B75hip54fN0Q=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=BuP2SuHKgaiqgbkGJACrFXh2ODFC1bU+2KUiJF9Rhc0r9h5p1z6yDqD6hkzvVsEq2
 jOWoGkl9QJWncyOXUmOvUY9FfCxmyKewU2yE2VQ9at1RlKyvvMu3KFZbfsHlH8ur/Q
 gFg6sQCs3mmUAqVELxPmuA0P29RVEox/43tX4vXO5eBcXTJIaMi3FdHrEsxiMIlgJO
 UNc/Cnf9KzDAaOp5WF0nWjpyL51kCHd4nEwzRyQtyOz9zJE3pU1oBXlwrq0mTp3QCx
 xqlaT5QIo4/vOy70pAsfNhan0TUM9iHzJTP3NZ/WmpbZYLsp1Q+Us9H7GosZN6qYG7
 1R4yn8FAxRo8Q==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.65
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
 yan.y.zhao@intel.com, kvm@vger.kernel.org, eskultet@redhat.com,
 ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pages, pinned by external interface for requested IO virtual address
range,  might get unpinned  and unmapped while migration is active and
device is still running, that is, in pre-copy phase while guest driver
still could access those pages. Host device can write to these pages while
those were mapped. Such pages should be marked dirty so that after
migration guest driver should still be able to complete the operation.

To get bitmap during unmap, user should set flag
VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP, bitmap memory should be allocated and
zeroed by user space application. Bitmap size and page size should be set
by user application.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 drivers/vfio/vfio_iommu_type1.c | 56 +++++++++++++++++++++++++++++++++++++----
 include/uapi/linux/vfio.h       | 12 +++++++++
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index df358dc1c85b..4e6ad0513932 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1032,7 +1032,8 @@ static long verify_bitmap_size(unsigned long npages, unsigned long bitmap_size)
 }
 
 static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
-			     struct vfio_iommu_type1_dma_unmap *unmap)
+			     struct vfio_iommu_type1_dma_unmap *unmap,
+			     unsigned long *bitmap)
 {
 	uint64_t mask;
 	struct vfio_dma *dma, *dma_last = NULL;
@@ -1107,6 +1108,15 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 		if (dma->task->mm != current->mm)
 			break;
 
+		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
+		    (dma_last != dma))
+			vfio_iova_dirty_bitmap(iommu, dma->iova, dma->size,
+					       unmap->bitmap_pgsize,
+					      (unsigned char __user *) bitmap);
+		else
+			vfio_remove_unpinned_from_pfn_list(dma);
+
+
 		if (!RB_EMPTY_ROOT(&dma->pfn_list)) {
 			struct vfio_iommu_type1_dma_unmap nb_unmap;
 
@@ -1132,6 +1142,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 						    &nb_unmap);
 			goto again;
 		}
+
 		unmapped += dma->size;
 		vfio_remove_dma(iommu, dma);
 	}
@@ -2462,22 +2473,57 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
 	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
 		struct vfio_iommu_type1_dma_unmap unmap;
-		long ret;
+		unsigned long *bitmap = NULL;
+		long ret, bsize;
 
 		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
 
 		if (copy_from_user(&unmap, (void __user *)arg, minsz))
 			return -EFAULT;
 
-		if (unmap.argsz < minsz || unmap.flags)
+		if (unmap.argsz < minsz ||
+		    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
 			return -EINVAL;
 
-		ret = vfio_dma_do_unmap(iommu, &unmap);
+		if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
+			unsigned long pgshift;
+			uint64_t iommu_pgsizes = vfio_pgsize_bitmap(iommu);
+			uint64_t iommu_pgmask =
+				 ((uint64_t)1 << __ffs(iommu_pgsizes)) - 1;
+
+			if (copy_from_user(&unmap, (void __user *)arg,
+					   sizeof(unmap)))
+				return -EFAULT;
+
+			pgshift = __ffs(unmap.bitmap_pgsize);
+
+			if (((unmap.bitmap_pgsize - 1) & iommu_pgmask) !=
+			     (unmap.bitmap_pgsize - 1))
+				return -EINVAL;
+
+			if ((unmap.bitmap_pgsize & iommu_pgsizes) !=
+			     unmap.bitmap_pgsize)
+				return -EINVAL;
+			if (unmap.iova + unmap.size < unmap.iova)
+				return -EINVAL;
+			if (!access_ok((void __user *)unmap.bitmap,
+				       unmap.bitmap_size))
+				return -EINVAL;
+
+			bsize = verify_bitmap_size(unmap.size >> pgshift,
+						   unmap.bitmap_size);
+			if (bsize < 0)
+				return bsize;
+			bitmap = unmap.bitmap;
+		}
+
+		ret = vfio_dma_do_unmap(iommu, &unmap, bitmap);
 		if (ret)
 			return ret;
 
-		return copy_to_user((void __user *)arg, &unmap, minsz) ?
+		ret = copy_to_user((void __user *)arg, &unmap, minsz) ?
 			-EFAULT : 0;
+		return ret;
 	} else if (cmd == VFIO_IOMMU_DIRTY_PAGES) {
 		struct vfio_iommu_type1_dirty_bitmap range;
 		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index b1b03c720749..a852e729b5a2 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -985,12 +985,24 @@ struct vfio_iommu_type1_dma_map {
  * field.  No guarantee is made to the user that arbitrary unmaps of iova
  * or size different from those used in the original mapping call will
  * succeed.
+ * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get dirty bitmap
+ * before unmapping IO virtual addresses. When this flag is set, user should
+ * allocate memory to get bitmap, clear the bitmap memory by setting zero and
+ * should set size of allocated memory in bitmap_size field. One bit in bitmap
+ * represents per page , page of user provided page size in 'bitmap_pgsize',
+ * consecutively starting from iova offset. Bit set indicates page at that
+ * offset from iova is dirty. Bitmap of pages in the range of unmapped size is
+ * returned in bitmap.
  */
 struct vfio_iommu_type1_dma_unmap {
 	__u32	argsz;
 	__u32	flags;
+#define VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP (1 << 0)
 	__u64	iova;				/* IO virtual address */
 	__u64	size;				/* Size of mapping (bytes) */
+	__u64        bitmap_pgsize;		/* page size for bitmap */
+	__u64        bitmap_size;               /* in bytes */
+	void __user *bitmap;                    /* one bit per page */
 };
 
 #define VFIO_IOMMU_UNMAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 14)
-- 
2.7.0


