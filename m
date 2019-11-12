Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97393C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6721221A49
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Oa9jIzdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6721221A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaCb-0007CZ-D2
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iUa7M-00015P-2z
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iUa7K-0005OS-Pf
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:38:16 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iUa7K-0005O2-HY
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:38:14 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcaeca00000>; Tue, 12 Nov 2019 09:32:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 12 Nov 2019 09:33:12 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 09:33:12 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 17:33:11 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 17:33:11 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Nov 2019 17:33:05 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v9 Kernel 4/5] vfio iommu: Implementation of ioctl to get
 dirty pages bitmap.
Date: Tue, 12 Nov 2019 22:33:39 +0530
Message-ID: <1573578220-7530-5-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573579936; bh=U7o8nopuwa5svw0kgwL12cP5oHdgEJ1PRVw74v24iMA=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=Oa9jIzdSNDv8nSrjw2gE/HEM5+chCLs5VFmZT1f6pXZk2cFN2f9W961uIXq4C6J9A
 0wbQ+0xoH0eWsgA3rGKkd/gky0UIN++q7AC3MnvsywmVH7DJzmCoyPdKJ/uf4Wue6u
 CDCX1KhJPZulX2UrjHmKmiI+IiztBcspQsdKf+zomDq1oNFRvyiGPBgyiEa/9xKtvs
 r61NvcpH54uToWIdrnMcGwiyNyq2UJptvqwmFsa2K/Vr1zTsnAUp+I22nbw2pWEoNN
 TplD8/9Vf9QAcl4os7DY6lFZGzZXG2iJp4aBxkG2VQgl1zytul1kVTRvgfWiTOhoSi
 EunXiz8XRiqMA==
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

IOMMU container maintains list of external pinned pages. Bitmap of pinned
pages for input IO virtual address range is created and returned.
IO virtual address range should be from a single mapping created by
map request. Input bitmap_size is validated by calculating the size of
requested range.
This ioctl returns bitmap of dirty pages, its user space application
responsibility to copy content of dirty pages from source to destination
during migration.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 drivers/vfio/vfio_iommu_type1.c | 92 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 2ada8e6cdb88..ac176e672857 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -850,6 +850,81 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
 	return bitmap;
 }
 
+/*
+ * start_iova is the reference from where bitmaping started. This is called
+ * from DMA_UNMAP where start_iova can be different than iova
+ */
+
+static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
+				  size_t size, dma_addr_t start_iova,
+				  unsigned long *bitmap)
+{
+	struct vfio_dma *dma;
+	dma_addr_t temp_iova = iova;
+
+	dma = vfio_find_dma(iommu, iova, size);
+	if (!dma)
+		return -EINVAL;
+
+	/*
+	 * Range should be from a single mapping created by map request.
+	 */
+
+	if ((iova < dma->iova) ||
+	    ((dma->iova + dma->size) < (iova + size)))
+		return -EINVAL;
+
+	while (temp_iova < iova + size) {
+		struct vfio_pfn *vpfn = NULL;
+
+		vpfn = vfio_find_vpfn(dma, temp_iova);
+		if (vpfn)
+			__bitmap_set(bitmap, vpfn->iova - start_iova, 1);
+
+		temp_iova += PAGE_SIZE;
+	}
+
+	return 0;
+}
+
+static int verify_bitmap_size(unsigned long npages, unsigned long bitmap_size)
+{
+	unsigned long bsize = ALIGN(npages, BITS_PER_LONG) / 8;
+
+	if ((bitmap_size == 0) || (bitmap_size < bsize))
+		return -EINVAL;
+	return 0;
+}
+
+static int vfio_iova_get_dirty_bitmap(struct vfio_iommu *iommu,
+				struct vfio_iommu_type1_dirty_bitmap *range)
+{
+	unsigned long *bitmap;
+	int ret;
+
+	ret = verify_bitmap_size(range->size >> PAGE_SHIFT, range->bitmap_size);
+	if (ret)
+		return ret;
+
+	/* one bit per page */
+	bitmap = bitmap_zalloc(range->size >> PAGE_SHIFT, GFP_KERNEL);
+	if (!bitmap)
+		return -ENOMEM;
+
+	mutex_lock(&iommu->lock);
+	ret = vfio_iova_dirty_bitmap(iommu, range->iova, range->size,
+				     range->iova, bitmap);
+	mutex_unlock(&iommu->lock);
+
+	if (!ret) {
+		if (copy_to_user(range->bitmap, bitmap, range->bitmap_size))
+			ret = -EFAULT;
+	}
+
+	bitmap_free(bitmap);
+	return ret;
+}
+
 static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 			     struct vfio_iommu_type1_dma_unmap *unmap)
 {
@@ -2297,6 +2372,23 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
 		return copy_to_user((void __user *)arg, &unmap, minsz) ?
 			-EFAULT : 0;
+	} else if (cmd == VFIO_IOMMU_GET_DIRTY_BITMAP) {
+		struct vfio_iommu_type1_dirty_bitmap range;
+
+		/* Supported for v2 version only */
+		if (!iommu->v2)
+			return -EACCES;
+
+		minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap,
+					bitmap);
+
+		if (copy_from_user(&range, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (range.argsz < minsz)
+			return -EINVAL;
+
+		return vfio_iova_get_dirty_bitmap(iommu, &range);
 	}
 
 	return -ENOTTY;
-- 
2.7.0


