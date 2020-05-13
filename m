Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3391C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE89205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="m7TaSUqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE89205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYyAv-0003GR-OZ
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 16:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jYy97-0007hG-IS
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:38:29 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jYy95-0006yT-Ur
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:38:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ebc5a390001>; Wed, 13 May 2020 13:36:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 13 May 2020 13:38:26 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 13 May 2020 13:38:26 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 May
 2020 20:38:26 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
 Frontend Transport; Wed, 13 May 2020 20:38:19 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH Kernel v19 5/8] vfio iommu: Implementation of ioctl for dirty
 pages tracking
Date: Thu, 14 May 2020 01:34:36 +0530
Message-ID: <1589400279-28522-6-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1589400279-28522-1-git-send-email-kwankhede@nvidia.com>
References: <1589400279-28522-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1589402170; bh=5QpnEsIgU8Be2ZaHD88qr3J2kTbb+5eSOoXP9lk4Qcs=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=m7TaSUqOrggx0LUHL9CY2VaBBDp7oB5f/vr9mO6m1kwQX3Sphhxu84O/G09DbOAnm
 VSARbNiE/C5AztJs45IzijrqwqgycceFNgHiVcj+PLjXVbRsp9MqeD4q0thW8w7/KB
 hl3ZwFqTNaQLIsC0C5AmxXb+jOBavvKJSjzHf8t9oWpYOPMOMykaqRIjpTrrTxZWFw
 Bsc5YKv7YmzB2tYZN14XTZARoTRmYbfozozRuIcwFrgL/WrQIY4I1dO+iIwkBdsmlC
 UnqhHHv1IfjqJYocEkOx2F25dUpRjhccDa//420tsxU4ISJQalxNeCBdq95+9lZjQz
 K6DEP/ekjlv+g==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 16:37:52
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 yan.y.zhao@intel.com, kvm@vger.kernel.org, eskultet@redhat.com,
 ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VFIO_IOMMU_DIRTY_PAGES ioctl performs three operations:
- Start dirty pages tracking while migration is active
- Stop dirty pages tracking.
- Get dirty pages bitmap. Its user space application's responsibility to
  copy content of dirty pages from source to destination during migration.

To prevent DoS attack, memory for bitmap is allocated per vfio_dma
structure. Bitmap size is calculated considering smallest supported page
size. Bitmap is allocated for all vfio_dmas when dirty logging is enabled

Bitmap is populated for already pinned pages when bitmap is allocated for
a vfio_dma with the smallest supported page size. Update bitmap from
pinning functions when tracking is enabled. When user application queries
bitmap, check if requested page size is same as page size used to
populated bitmap. If it is equal, copy bitmap, but if not equal, return
error.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>

Fixed error reported by build bot by changing pgsize type from uint64_t
to size_t.
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 274 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 268 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 6f09fbabed12..469b09185b83 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -72,6 +72,7 @@ struct vfio_iommu {
 	uint64_t		pgsize_bitmap;
 	bool			v2;
 	bool			nesting;
+	bool			dirty_page_tracking;
 };
 
 struct vfio_domain {
@@ -92,6 +93,7 @@ struct vfio_dma {
 	bool			lock_cap;	/* capable(CAP_IPC_LOCK) */
 	struct task_struct	*task;
 	struct rb_root		pfn_list;	/* Ex-user pinned pfn list */
+	unsigned long		*bitmap;
 };
 
 struct vfio_group {
@@ -126,6 +128,19 @@ struct vfio_regions {
 #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
 					(!list_empty(&iommu->domain_list))
 
+#define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) / BITS_PER_BYTE)
+
+/*
+ * Input argument of number of bits to bitmap_set() is unsigned integer, which
+ * further casts to signed integer for unaligned multi-bit operation,
+ * __bitmap_set().
+ * Then maximum bitmap size supported is 2^31 bits divided by 2^3 bits/byte,
+ * that is 2^28 (256 MB) which maps to 2^31 * 2^12 = 2^43 (8TB) on 4K page
+ * system.
+ */
+#define DIRTY_BITMAP_PAGES_MAX	 ((u64)INT_MAX)
+#define DIRTY_BITMAP_SIZE_MAX	 DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
+
 static int put_pfn(unsigned long pfn, int prot);
 
 /*
@@ -176,6 +191,77 @@ static void vfio_unlink_dma(struct vfio_iommu *iommu, struct vfio_dma *old)
 	rb_erase(&old->node, &iommu->dma_list);
 }
 
+
+static int vfio_dma_bitmap_alloc(struct vfio_dma *dma, size_t pgsize)
+{
+	uint64_t npages = dma->size / pgsize;
+
+	if (npages > DIRTY_BITMAP_PAGES_MAX)
+		return -EINVAL;
+
+	dma->bitmap = kvzalloc(DIRTY_BITMAP_BYTES(npages), GFP_KERNEL);
+	if (!dma->bitmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void vfio_dma_bitmap_free(struct vfio_dma *dma)
+{
+	kfree(dma->bitmap);
+	dma->bitmap = NULL;
+}
+
+static void vfio_dma_populate_bitmap(struct vfio_dma *dma, size_t pgsize)
+{
+	struct rb_node *p;
+
+	if (RB_EMPTY_ROOT(&dma->pfn_list))
+		return;
+
+	for (p = rb_first(&dma->pfn_list); p; p = rb_next(p)) {
+		struct vfio_pfn *vpfn = rb_entry(p, struct vfio_pfn, node);
+
+		bitmap_set(dma->bitmap, (vpfn->iova - dma->iova) / pgsize, 1);
+	}
+}
+
+static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu, size_t pgsize)
+{
+	struct rb_node *n = rb_first(&iommu->dma_list);
+
+	for (; n; n = rb_next(n)) {
+		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
+		int ret;
+
+		ret = vfio_dma_bitmap_alloc(dma, pgsize);
+		if (ret) {
+			struct rb_node *p = rb_prev(n);
+
+			for (; p; p = rb_prev(p)) {
+				struct vfio_dma *dma = rb_entry(n,
+							struct vfio_dma, node);
+
+				vfio_dma_bitmap_free(dma);
+			}
+			return ret;
+		}
+		vfio_dma_populate_bitmap(dma, pgsize);
+	}
+	return 0;
+}
+
+static void vfio_dma_bitmap_free_all(struct vfio_iommu *iommu)
+{
+	struct rb_node *n = rb_first(&iommu->dma_list);
+
+	for (; n; n = rb_next(n)) {
+		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
+
+		vfio_dma_bitmap_free(dma);
+	}
+}
+
 /*
  * Helper Functions for host iova-pfn list
  */
@@ -568,6 +654,17 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 			vfio_unpin_page_external(dma, iova, do_accounting);
 			goto pin_unwind;
 		}
+
+		if (iommu->dirty_page_tracking) {
+			unsigned long pgshift = __ffs(iommu->pgsize_bitmap);
+
+			/*
+			 * Bitmap populated with the smallest supported page
+			 * size
+			 */
+			bitmap_set(dma->bitmap,
+				   (vpfn->iova - dma->iova) >> pgshift, 1);
+		}
 	}
 
 	ret = i;
@@ -802,6 +899,7 @@ static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
 	vfio_unmap_unpin(iommu, dma, true);
 	vfio_unlink_dma(iommu, dma);
 	put_task_struct(dma->task);
+	vfio_dma_bitmap_free(dma);
 	kfree(dma);
 	iommu->dma_avail++;
 }
@@ -829,6 +927,57 @@ static void vfio_pgsize_bitmap(struct vfio_iommu *iommu)
 	}
 }
 
+static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
+				  size_t size, size_t pgsize,
+				  u64 __user *bitmap)
+{
+	struct vfio_dma *dma;
+	unsigned long pgshift = __ffs(pgsize);
+	unsigned int npages, bitmap_size;
+
+	dma = vfio_find_dma(iommu, iova, 1);
+
+	if (!dma)
+		return -EINVAL;
+
+	if (dma->iova != iova || dma->size != size)
+		return -EINVAL;
+
+	npages = dma->size >> pgshift;
+	bitmap_size = DIRTY_BITMAP_BYTES(npages);
+
+	/* mark all pages dirty if all pages are pinned and mapped. */
+	if (dma->iommu_mapped)
+		bitmap_set(dma->bitmap, 0, npages);
+
+	if (copy_to_user((void __user *)bitmap, dma->bitmap, bitmap_size))
+		return -EFAULT;
+
+	/*
+	 * Re-populate bitmap to include all pinned pages which are considered
+	 * as dirty but exclude pages which are unpinned and pages which are
+	 * marked dirty by vfio_dma_rw()
+	 */
+	bitmap_clear(dma->bitmap, 0, npages);
+	vfio_dma_populate_bitmap(dma, pgsize);
+	return 0;
+}
+
+static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
+{
+	uint64_t bsize;
+
+	if (!npages || !bitmap_size || (bitmap_size > DIRTY_BITMAP_SIZE_MAX))
+		return -EINVAL;
+
+	bsize = DIRTY_BITMAP_BYTES(npages);
+
+	if (bitmap_size < bsize)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 			     struct vfio_iommu_type1_dma_unmap *unmap)
 {
@@ -1046,7 +1195,7 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 	unsigned long vaddr = map->vaddr;
 	size_t size = map->size;
 	int ret = 0, prot = 0;
-	uint64_t mask;
+	size_t pgsize;
 	struct vfio_dma *dma;
 
 	/* Verify that none of our __u64 fields overflow */
@@ -1061,11 +1210,11 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 
 	mutex_lock(&iommu->lock);
 
-	mask = ((uint64_t)1 << __ffs(iommu->pgsize_bitmap)) - 1;
+	pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
 
-	WARN_ON(mask & PAGE_MASK);
+	WARN_ON((pgsize - 1) & PAGE_MASK);
 
-	if (!prot || !size || (size | iova | vaddr) & mask) {
+	if (!prot || !size || (size | iova | vaddr) & (pgsize - 1)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -1142,6 +1291,12 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 	else
 		ret = vfio_pin_map_dma(iommu, dma, size);
 
+	if (!ret && iommu->dirty_page_tracking) {
+		ret = vfio_dma_bitmap_alloc(dma, pgsize);
+		if (ret)
+			vfio_remove_dma(iommu, dma);
+	}
+
 out_unlock:
 	mutex_unlock(&iommu->lock);
 	return ret;
@@ -2287,6 +2442,104 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
 		return copy_to_user((void __user *)arg, &unmap, minsz) ?
 			-EFAULT : 0;
+	} else if (cmd == VFIO_IOMMU_DIRTY_PAGES) {
+		struct vfio_iommu_type1_dirty_bitmap dirty;
+		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
+				VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP |
+				VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
+		int ret = 0;
+
+		if (!iommu->v2)
+			return -EACCES;
+
+		minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap,
+				    flags);
+
+		if (copy_from_user(&dirty, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (dirty.argsz < minsz || dirty.flags & ~mask)
+			return -EINVAL;
+
+		/* only one flag should be set at a time */
+		if (__ffs(dirty.flags) != __fls(dirty.flags))
+			return -EINVAL;
+
+		if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
+			size_t pgsize;
+
+			mutex_lock(&iommu->lock);
+			pgsize = 1 << __ffs(iommu->pgsize_bitmap);
+			if (!iommu->dirty_page_tracking) {
+				ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
+				if (!ret)
+					iommu->dirty_page_tracking = true;
+			}
+			mutex_unlock(&iommu->lock);
+			return ret;
+		} else if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP) {
+			mutex_lock(&iommu->lock);
+			if (iommu->dirty_page_tracking) {
+				iommu->dirty_page_tracking = false;
+				vfio_dma_bitmap_free_all(iommu);
+			}
+			mutex_unlock(&iommu->lock);
+			return 0;
+		} else if (dirty.flags &
+				 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
+			struct vfio_iommu_type1_dirty_bitmap_get range;
+			unsigned long pgshift;
+			size_t data_size = dirty.argsz - minsz;
+			size_t iommu_pgsize;
+
+			if (!data_size || data_size < sizeof(range))
+				return -EINVAL;
+
+			if (copy_from_user(&range, (void __user *)(arg + minsz),
+					   sizeof(range)))
+				return -EFAULT;
+
+			if (range.iova + range.size < range.iova)
+				return -EINVAL;
+			if (!access_ok((void __user *)range.bitmap.data,
+				       range.bitmap.size))
+				return -EINVAL;
+
+			pgshift = __ffs(range.bitmap.pgsize);
+			ret = verify_bitmap_size(range.size >> pgshift,
+						 range.bitmap.size);
+			if (ret)
+				return ret;
+
+			mutex_lock(&iommu->lock);
+
+			iommu_pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
+
+			/* allow only smallest supported pgsize */
+			if (range.bitmap.pgsize != iommu_pgsize) {
+				ret = -EINVAL;
+				goto out_unlock;
+			}
+			if (range.iova & (iommu_pgsize - 1)) {
+				ret = -EINVAL;
+				goto out_unlock;
+			}
+			if (!range.size || range.size & (iommu_pgsize - 1)) {
+				ret = -EINVAL;
+				goto out_unlock;
+			}
+
+			if (iommu->dirty_page_tracking)
+				ret = vfio_iova_dirty_bitmap(iommu, range.iova,
+						range.size, range.bitmap.pgsize,
+						range.bitmap.data);
+			else
+				ret = -EINVAL;
+out_unlock:
+			mutex_unlock(&iommu->lock);
+
+			return ret;
+		}
 	}
 
 	return -ENOTTY;
@@ -2354,10 +2607,19 @@ static int vfio_iommu_type1_dma_rw_chunk(struct vfio_iommu *iommu,
 
 	vaddr = dma->vaddr + offset;
 
-	if (write)
+	if (write) {
 		*copied = copy_to_user((void __user *)vaddr, data,
 					 count) ? 0 : count;
-	else
+		if (*copied && iommu->dirty_page_tracking) {
+			unsigned long pgshift = __ffs(iommu->pgsize_bitmap);
+			/*
+			 * Bitmap populated with the smallest supported page
+			 * size
+			 */
+			bitmap_set(dma->bitmap, offset >> pgshift,
+				   *copied >> pgshift);
+		}
+	} else
 		*copied = copy_from_user(data, (void __user *)vaddr,
 					   count) ? 0 : count;
 	if (kthread)
-- 
2.7.0


