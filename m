Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678F3C17440
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374EE21925
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HvyAOKaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374EE21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaCN-0006qf-4E
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iUa7Z-0001Gy-LI
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iUa7Y-0005Tp-Fa
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:38:29 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8033)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iUa7Y-0005TI-7W
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:38:28 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcaeca60000>; Tue, 12 Nov 2019 09:32:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 12 Nov 2019 09:33:18 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 12 Nov 2019 09:33:18 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 17:33:18 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Nov 2019 17:33:11 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v9 Kernel 5/5] vfio iommu: Implementation of ioctl to get
 dirty bitmap before unmap
Date: Tue, 12 Nov 2019 22:33:40 +0530
Message-ID: <1573578220-7530-6-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573579942; bh=b76VG1CtaF0t0W+2xw926JIpF08VPIo1rVi43atlLHw=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=HvyAOKaOIfCq27eIY++DpFpn6cLVxF3V9P5LNQc9uHf11GXj1ihxcOK+JmcFRfsNz
 qvqi0Y5BiUG3bMqb3O30JBCjnkRBpCjljKVmo8xzhXzA5TF1XXxsLCCr14DuAoyHfl
 Qo2Dd4hGGU1XLz/cieVBumRSxOb89vDZ0LGD9edGUniATX0P0/9q1juq0UC+DLN8pu
 zXqeqlU5ymQHbnV9/Kw3Y/OcJzWOKlRfE708v93GHAAFVF4tG+gR8Q6gdtU9xdagVl
 PSo1vUk/qp063s+/tkvt5n0jKmsNVHF2ht2VU1NM25ZfCEAIkMylqMnKAUPL3fvm5L
 8o9hcZnmFuIJg==
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

If pages are pinned by external interface for requested IO virtual address
range, bitmap of such pages is created and then that range is unmapped.
To get bitmap during unmap, user should set flag
VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP, bitmap memory should be allocated and
bitmap_size should be set. If flag is not set, then it behaves same as
VFIO_IOMMU_UNMAP_DMA ioctl.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 drivers/vfio/vfio_iommu_type1.c | 71 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index ac176e672857..d6b988452ba6 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -926,7 +926,8 @@ static int vfio_iova_get_dirty_bitmap(struct vfio_iommu *iommu,
 }
 
 static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
-			     struct vfio_iommu_type1_dma_unmap *unmap)
+			     struct vfio_iommu_type1_dma_unmap *unmap,
+			     unsigned long *bitmap)
 {
 	uint64_t mask;
 	struct vfio_dma *dma, *dma_last = NULL;
@@ -1026,6 +1027,12 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 						    &nb_unmap);
 			goto again;
 		}
+
+		if (bitmap) {
+			vfio_iova_dirty_bitmap(iommu, dma->iova, dma->size,
+					       unmap->iova, bitmap);
+		}
+
 		unmapped += dma->size;
 		vfio_remove_dma(iommu, dma);
 	}
@@ -1039,6 +1046,43 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 	return ret;
 }
 
+static int vfio_dma_do_unmap_bitmap(struct vfio_iommu *iommu,
+		struct vfio_iommu_type1_dma_unmap_bitmap *unmap_bitmap)
+{
+	struct vfio_iommu_type1_dma_unmap unmap;
+	unsigned long *bitmap = NULL;
+	int ret;
+
+	/* check bitmap size */
+	if ((unmap_bitmap->flags | VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)) {
+		ret = verify_bitmap_size(unmap_bitmap->size >> PAGE_SHIFT,
+					 unmap_bitmap->bitmap_size);
+		if (ret)
+			return ret;
+
+		/* one bit per page */
+		bitmap = bitmap_zalloc(unmap_bitmap->size >> PAGE_SHIFT,
+					GFP_KERNEL);
+		if (!bitmap)
+			return -ENOMEM;
+	}
+
+	unmap.iova = unmap_bitmap->iova;
+	unmap.size = unmap_bitmap->size;
+	ret = vfio_dma_do_unmap(iommu, &unmap, bitmap);
+	if (!ret)
+		unmap_bitmap->size = unmap.size;
+
+	if (bitmap) {
+		if (!ret && copy_to_user(unmap_bitmap->bitmap, bitmap,
+					 unmap_bitmap->bitmap_size))
+			ret = -EFAULT;
+		bitmap_free(bitmap);
+	}
+
+	return ret;
+}
+
 static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 			  unsigned long pfn, long npage, int prot)
 {
@@ -2366,7 +2410,7 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		if (unmap.argsz < minsz || unmap.flags)
 			return -EINVAL;
 
-		ret = vfio_dma_do_unmap(iommu, &unmap);
+		ret = vfio_dma_do_unmap(iommu, &unmap, NULL);
 		if (ret)
 			return ret;
 
@@ -2389,6 +2433,29 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 			return -EINVAL;
 
 		return vfio_iova_get_dirty_bitmap(iommu, &range);
+	} else if (cmd == VFIO_IOMMU_UNMAP_DMA_GET_BITMAP) {
+		struct vfio_iommu_type1_dma_unmap_bitmap unmap_bitmap;
+		long ret;
+
+		/* Supported for v2 version only */
+		if (!iommu->v2)
+			return -EACCES;
+
+		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap_bitmap,
+				    bitmap);
+
+		if (copy_from_user(&unmap_bitmap, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (unmap_bitmap.argsz < minsz)
+			return -EINVAL;
+
+		ret = vfio_dma_do_unmap_bitmap(iommu, &unmap_bitmap);
+		if (ret)
+			return ret;
+
+		return copy_to_user((void __user *)arg, &unmap_bitmap, minsz) ?
+			-EFAULT : 0;
 	}
 
 	return -ENOTTY;
-- 
2.7.0


