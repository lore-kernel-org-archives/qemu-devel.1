Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA610C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A371C207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="McSWxwJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A371C207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jePkn-0003Za-Ru
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 17:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jePhf-0006bD-UU
 for qemu-devel@nongnu.org; Thu, 28 May 2020 17:04:39 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jePhe-0006Bj-9x
 for qemu-devel@nongnu.org; Thu, 28 May 2020 17:04:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ed027090000>; Thu, 28 May 2020 14:03:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 28 May 2020 14:04:36 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 28 May 2020 14:04:36 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 May
 2020 21:04:29 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 28 May 2020 21:04:22 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH Kernel v24 3/8] vfio iommu: Cache pgsize_bitmap in struct
 vfio_iommu
Date: Fri, 29 May 2020 02:00:49 +0530
Message-ID: <1590697854-21364-4-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1590697854-21364-1-git-send-email-kwankhede@nvidia.com>
References: <1590697854-21364-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1590699785; bh=ql2Pfzwxu4aFf4qdx+nxrZVXCxpsxaEJS3vW79ACydk=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=McSWxwJVH6q22nOwBDqrsU5LXZwdv7RQRVYV1Ry+6Yj9VpFr1WTQjVWfuQUiCM0UE
 nFkhFLLj9SMUqDaYuXljNXpPIiY9fhp7KEcrAr5iypMmbgzOiFnrRv/QCWGC3ynLCX
 NkdvHCKDAc96VEV7c49U2x1zSowT3WcCDqJWxdhqrdMp8a1qJzWJKlV4jZw6k9tsfb
 IrEIDglGIryi4hth3okbK+yWJQshJhFGMHIiYRxAaqROoTK1RXK/YzBwq4lKiyJCfy
 ZbDxclK/Gyd9fk+gP8PA4da8Wzq2xg6bYU6g47x+pLQxB5x4ScKLAlNmx/rehj6ey3
 /9gcA+uE07qPA==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 17:03:51
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

Calculate and cache pgsize_bitmap when iommu->domain_list is updated
and iommu->external_domain is set for mdev device.
Add iommu->lock protection when cached pgsize_bitmap is accessed.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 88 +++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index fef7cd9a1747..814c795a2543 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -69,6 +69,7 @@ struct vfio_iommu {
 	struct rb_root		dma_list;
 	struct blocking_notifier_head notifier;
 	unsigned int		dma_avail;
+	uint64_t		pgsize_bitmap;
 	bool			v2;
 	bool			nesting;
 };
@@ -835,15 +836,14 @@ static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
 	iommu->dma_avail++;
 }
 
-static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
+static void vfio_update_pgsize_bitmap(struct vfio_iommu *iommu)
 {
 	struct vfio_domain *domain;
-	unsigned long bitmap = ULONG_MAX;
 
-	mutex_lock(&iommu->lock);
+	iommu->pgsize_bitmap = ULONG_MAX;
+
 	list_for_each_entry(domain, &iommu->domain_list, next)
-		bitmap &= domain->domain->pgsize_bitmap;
-	mutex_unlock(&iommu->lock);
+		iommu->pgsize_bitmap &= domain->domain->pgsize_bitmap;
 
 	/*
 	 * In case the IOMMU supports page sizes smaller than PAGE_SIZE
@@ -853,12 +853,10 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
 	 * granularity while iommu driver can use the sub-PAGE_SIZE size
 	 * to map the buffer.
 	 */
-	if (bitmap & ~PAGE_MASK) {
-		bitmap &= PAGE_MASK;
-		bitmap |= PAGE_SIZE;
+	if (iommu->pgsize_bitmap & ~PAGE_MASK) {
+		iommu->pgsize_bitmap &= PAGE_MASK;
+		iommu->pgsize_bitmap |= PAGE_SIZE;
 	}
-
-	return bitmap;
 }
 
 static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
@@ -869,19 +867,28 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 	size_t unmapped = 0;
 	int ret = 0, retries = 0;
 
-	mask = ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
+	mutex_lock(&iommu->lock);
+
+	mask = ((uint64_t)1 << __ffs(iommu->pgsize_bitmap)) - 1;
+
+	if (unmap->iova & mask) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (!unmap->size || unmap->size & mask) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
-	if (unmap->iova & mask)
-		return -EINVAL;
-	if (!unmap->size || unmap->size & mask)
-		return -EINVAL;
 	if (unmap->iova + unmap->size - 1 < unmap->iova ||
-	    unmap->size > SIZE_MAX)
-		return -EINVAL;
+	    unmap->size > SIZE_MAX) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
 	WARN_ON(mask & PAGE_MASK);
 again:
-	mutex_lock(&iommu->lock);
 
 	/*
 	 * vfio-iommu-type1 (v1) - User mappings were coalesced together to
@@ -960,6 +967,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 			blocking_notifier_call_chain(&iommu->notifier,
 						    VFIO_IOMMU_NOTIFY_DMA_UNMAP,
 						    &nb_unmap);
+			mutex_lock(&iommu->lock);
 			goto again;
 		}
 		unmapped += dma->size;
@@ -1075,24 +1083,28 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 	if (map->size != size || map->vaddr != vaddr || map->iova != iova)
 		return -EINVAL;
 
-	mask = ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
-
-	WARN_ON(mask & PAGE_MASK);
-
 	/* READ/WRITE from device perspective */
 	if (map->flags & VFIO_DMA_MAP_FLAG_WRITE)
 		prot |= IOMMU_WRITE;
 	if (map->flags & VFIO_DMA_MAP_FLAG_READ)
 		prot |= IOMMU_READ;
 
-	if (!prot || !size || (size | iova | vaddr) & mask)
-		return -EINVAL;
+	mutex_lock(&iommu->lock);
 
-	/* Don't allow IOVA or virtual address wrap */
-	if (iova + size - 1 < iova || vaddr + size - 1 < vaddr)
-		return -EINVAL;
+	mask = ((uint64_t)1 << __ffs(iommu->pgsize_bitmap)) - 1;
 
-	mutex_lock(&iommu->lock);
+	WARN_ON(mask & PAGE_MASK);
+
+	if (!prot || !size || (size | iova | vaddr) & mask) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* Don't allow IOVA or virtual address wrap */
+	if (iova + size - 1 < iova || vaddr + size - 1 < vaddr) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 
 	if (vfio_find_dma(iommu, iova, size)) {
 		ret = -EEXIST;
@@ -1698,6 +1710,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			if (!iommu->external_domain) {
 				INIT_LIST_HEAD(&domain->group_list);
 				iommu->external_domain = domain;
+				vfio_update_pgsize_bitmap(iommu);
 			} else {
 				kfree(domain);
 			}
@@ -1823,6 +1836,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	}
 
 	list_add(&domain->next, &iommu->domain_list);
+	vfio_update_pgsize_bitmap(iommu);
 done:
 	/* Delete the old one and insert new iova list */
 	vfio_iommu_iova_insert_copy(iommu, &iova_copy);
@@ -2034,6 +2048,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 			list_del(&domain->next);
 			kfree(domain);
 			vfio_iommu_aper_expand(iommu, &iova_copy);
+			vfio_update_pgsize_bitmap(iommu);
 		}
 		break;
 	}
@@ -2166,8 +2181,6 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 	size_t size;
 	int iovas = 0, i = 0, ret;
 
-	mutex_lock(&iommu->lock);
-
 	list_for_each_entry(iova, &iommu->iova_list, list)
 		iovas++;
 
@@ -2176,17 +2189,14 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 		 * Return 0 as a container with a single mdev device
 		 * will have an empty list
 		 */
-		ret = 0;
-		goto out_unlock;
+		return 0;
 	}
 
 	size = sizeof(*cap_iovas) + (iovas * sizeof(*cap_iovas->iova_ranges));
 
 	cap_iovas = kzalloc(size, GFP_KERNEL);
-	if (!cap_iovas) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
+	if (!cap_iovas)
+		return -ENOMEM;
 
 	cap_iovas->nr_iovas = iovas;
 
@@ -2199,8 +2209,6 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 	ret = vfio_iommu_iova_add_cap(caps, cap_iovas, size);
 
 	kfree(cap_iovas);
-out_unlock:
-	mutex_unlock(&iommu->lock);
 	return ret;
 }
 
@@ -2245,11 +2253,13 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 			info.cap_offset = 0; /* output, no-recopy necessary */
 		}
 
+		mutex_lock(&iommu->lock);
 		info.flags = VFIO_IOMMU_INFO_PGSIZES;
 
-		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
+		info.iova_pgsizes = iommu->pgsize_bitmap;
 
 		ret = vfio_iommu_iova_build_caps(iommu, &caps);
+		mutex_unlock(&iommu->lock);
 		if (ret)
 			return ret;
 
-- 
2.7.0


