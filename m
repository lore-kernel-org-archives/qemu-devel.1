Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82085C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6E221582
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fKkhG0Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6E221582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igxQe-00039w-6q
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 15:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1igxKc-00033u-RZ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1igxKb-0007Q5-C2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:51:06 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1igxKb-0007Ps-3h
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:51:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5df7ee1c0000>; Mon, 16 Dec 2019 12:50:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 16 Dec 2019 12:51:03 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 16 Dec 2019 12:51:03 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Dec
 2019 20:51:03 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 16 Dec 2019 20:50:56 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v10 Kernel 5/5] vfio iommu: Update UNMAP_DMA ioctl to get
 dirty bitmap before unmap
Date: Tue, 17 Dec 2019 01:51:40 +0530
Message-ID: <1576527700-21805-6-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
References: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1576529437; bh=NNfqr2vUhNMQwsoU1oTVwnAsTm+8VgO1yNM6gGnpjxc=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=fKkhG0Rpo2uQO3Ql7u1tPsMGHIrYdi6htp/An+VH/Rvc607coS/qlLMRR2QUvsDC1
 7dBFjQZnMzH8nLwiVjV7INjbuglDcYU9M63kFCdHRjqRURv2qOOpmEKFyBjLzitEzZ
 MpAd3lAe1qFlWZPCv7Rva8/WRBhoenFNPyqLK3RvnRRvBHcPkxa3w9b9VcW/8mzi+N
 ftVxx2IXJH8fwB0t2GBDUyGP5ycpL8fgEVRicp2I9FX+Tiwd5lyC+IcHOmgVCeqZ5s
 m//kTO1RkQm3OnALZAXCquXHX6fwIaSISKpvcbowUCqSJP8X9fK0lntKTS5XoD1LLl
 a0rGHPE6//LAg==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.143
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
 drivers/vfio/vfio_iommu_type1.c | 63 ++++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/vfio.h       | 12 ++++++++
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 264449654d3f..6bd02a13903b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -970,7 +970,8 @@ static long verify_bitmap_size(unsigned long npages, unsigned long bitmap_size)
 }
 
 static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
-			     struct vfio_iommu_type1_dma_unmap *unmap)
+			     struct vfio_iommu_type1_dma_unmap *unmap,
+			     unsigned long *bitmap)
 {
 	uint64_t mask;
 	struct vfio_dma *dma, *dma_last = NULL;
@@ -1045,6 +1046,15 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 		if (dma->task->mm != current->mm)
 			break;
 
+		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
+		    (dma_last != dma))
+			vfio_iova_dirty_bitmap(iommu, dma->iova, dma->size,
+					     unmap->bitmap_pgsize, unmap->iova,
+					     bitmap);
+		else
+			vfio_remove_unpinned_from_pfn_list(dma, true);
+
+
 		if (!RB_EMPTY_ROOT(&dma->pfn_list)) {
 			struct vfio_iommu_type1_dma_unmap nb_unmap;
 
@@ -1070,6 +1080,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 						    &nb_unmap);
 			goto again;
 		}
+
 		unmapped += dma->size;
 		vfio_remove_dma(iommu, dma);
 	}
@@ -2401,22 +2412,60 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
 	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
 		struct vfio_iommu_type1_dma_unmap unmap;
-		long ret;
+		unsigned long *bitmap = NULL;
+		long ret, bsize;
 
 		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
 
-		if (copy_from_user(&unmap, (void __user *)arg, minsz))
+		if (copy_from_user(&unmap, (void __user *)arg, sizeof(unmap)))
 			return -EFAULT;
 
-		if (unmap.argsz < minsz || unmap.flags)
+		if (unmap.argsz < minsz ||
+		    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
 			return -EINVAL;
 
-		ret = vfio_dma_do_unmap(iommu, &unmap);
+		if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
+			unsigned long pgshift = __ffs(unmap.bitmap_pgsize);
+			uint64_t iommu_pgmask =
+			 ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
+
+			if (((unmap.bitmap_pgsize - 1) & iommu_pgmask) !=
+			     (unmap.bitmap_pgsize - 1))
+				return -EINVAL;
+
+			bsize = verify_bitmap_size(unmap.size >> pgshift,
+						   unmap.bitmap_size);
+			if (bsize < 0)
+				return bsize;
+
+			bitmap = kmalloc(bsize, GFP_KERNEL);
+			if (!bitmap)
+				return -ENOMEM;
+
+			if (copy_from_user(bitmap, (void __user *)unmap.bitmap,
+					   bsize)) {
+				ret = -EFAULT;
+				goto unmap_exit;
+			}
+		}
+
+		ret = vfio_dma_do_unmap(iommu, &unmap, bitmap);
 		if (ret)
-			return ret;
+			goto unmap_exit;
 
-		return copy_to_user((void __user *)arg, &unmap, minsz) ?
+		if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
+			if (copy_to_user((void __user *)unmap.bitmap, bitmap,
+					  bsize)) {
+				ret = -EFAULT;
+				goto unmap_exit;
+			}
+		}
+
+		ret = copy_to_user((void __user *)arg, &unmap, minsz) ?
 			-EFAULT : 0;
+unmap_exit:
+		kfree(bitmap);
+		return ret;
 	} else if (cmd == VFIO_IOMMU_DIRTY_PAGES) {
 		struct vfio_iommu_type1_dirty_bitmap range;
 		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 4ad54fbb4698..7705aea7bdaf 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -958,12 +958,24 @@ struct vfio_iommu_type1_dma_map {
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


