Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D648BC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 18:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49D8206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 18:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cEFSnzBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49D8206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCScz-0002bq-U0
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 14:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jCSYT-0005bL-5U
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 14:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jCSYR-0008IL-Mc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 14:27:37 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jCSYR-0008FJ-EM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 14:27:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e6a7eb90000>; Thu, 12 Mar 2020 11:26:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 12 Mar 2020 11:27:34 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 12 Mar 2020 11:27:34 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Mar
 2020 18:27:33 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 12 Mar 2020 18:27:27 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v13 Kernel 5/7] vfio iommu: Update UNMAP_DMA ioctl to get
 dirty bitmap before unmap
Date: Thu, 12 Mar 2020 23:23:25 +0530
Message-ID: <1584035607-23166-6-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1584035607-23166-1-git-send-email-kwankhede@nvidia.com>
References: <1584035607-23166-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1584037562; bh=XbfkPb9JALItDbjfR2T2PdOeDcWn14Xs+YRsP0GceN4=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=cEFSnzBazpsFF6SuR/lSyznxVEyvwWysixjxoRhKYTXZzvtyFDHHeM3wtoD4t00EI
 sGl92p0cOpI71PYWfysExNMkramzCJRr0Qt8zR6LlE4+Gv3kGp+NKkaJv9smNMBEt0
 HEL4d/0KaoBI8s8kI6or9WepFJCsya5tMK2XPiXEWtcX5XcA7bs+czFyRXVJ353d8L
 F2L6OskCFCxXVNScsfPNmv4zuXhBp9cfNvnv3Zvxdep8dLbN1A8a1OI479ewQe6cMW
 mJuiDAsFjaAg9q3hM3VMTnrc+p2ET1kqCewHeVCWEJO1523Pgxnhd01HbMwavEJ65u
 Ep+rf9KINuysA==
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
 drivers/vfio/vfio_iommu_type1.c | 63 +++++++++++++++++++++++++++++++++++++----
 include/uapi/linux/vfio.h       | 12 ++++++++
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 435e84269a28..4037b82c6db0 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -976,7 +976,8 @@ static int verify_bitmap_size(unsigned long npages, unsigned long bitmap_size)
 }
 
 static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
-			     struct vfio_iommu_type1_dma_unmap *unmap)
+			     struct vfio_iommu_type1_dma_unmap *unmap,
+			     unsigned long *bitmap)
 {
 	uint64_t mask;
 	struct vfio_dma *dma, *dma_last = NULL;
@@ -1027,6 +1028,10 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 	 * will be returned if these conditions are not met.  The v2 interface
 	 * will only return success and a size of zero if there were no
 	 * mappings within the range.
+	 *
+	 * When VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP flag is set, unmap request
+	 * must be for single mapping. Multiple mappings with this flag set is
+	 * not supported.
 	 */
 	if (iommu->v2) {
 		dma = vfio_find_dma(iommu, unmap->iova, 1);
@@ -1034,6 +1039,13 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 			ret = -EINVAL;
 			goto unlock;
 		}
+
+		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
+		    (dma->iova != unmap->iova || dma->size != unmap->size)) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+
 		dma = vfio_find_dma(iommu, unmap->iova + unmap->size - 1, 0);
 		if (dma && dma->iova + dma->size != unmap->iova + unmap->size) {
 			ret = -EINVAL;
@@ -1051,6 +1063,11 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 		if (dma->task->mm != current->mm)
 			break;
 
+		if (unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
+			vfio_iova_dirty_bitmap(iommu, dma->iova, dma->size,
+					       unmap->bitmap_pgsize,
+					      (unsigned char __user *) bitmap);
+
 		if (!RB_EMPTY_ROOT(&dma->pfn_list)) {
 			struct vfio_iommu_type1_dma_unmap nb_unmap;
 
@@ -1076,6 +1093,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 						    &nb_unmap);
 			goto again;
 		}
+
 		unmapped += dma->size;
 		vfio_remove_dma(iommu, dma);
 	}
@@ -2406,22 +2424,57 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
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
 		struct vfio_iommu_type1_dirty_bitmap dirty;
 		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 02d555cc7036..12b2094f887e 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1004,12 +1004,24 @@ struct vfio_iommu_type1_dma_map {
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


