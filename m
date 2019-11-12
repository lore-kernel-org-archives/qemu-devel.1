Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAC7C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECE4206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SFH/QhUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECE4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaC0-0006Rt-7I
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iUa8q-0002PT-6S
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iUa8p-0005vi-27
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:39:48 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16165)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iUa8n-0005uT-5a
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:39:46 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcaed320001>; Tue, 12 Nov 2019 09:34:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 12 Nov 2019 09:34:42 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 09:34:42 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 17:34:42 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Nov 2019 17:34:36 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v9 QEMU 03/15] vfio iommu: Add ioctl defination to unmap IOVA
 and return dirty bitmap
Date: Tue, 12 Nov 2019 22:35:12 +0530
Message-ID: <1573578324-8389-4-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573580082; bh=mBFw/LnhWgqZegujyDzTd7ZuFq5BUp2TXXif72cZTDk=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=SFH/QhUAef2hqlfh+eMeHfixywcd2hEEm0bwBkMfj2S7Su806UXj1VWvMPvlacGui
 FHXtRLLJ9c+H+Qw6a3SHPCd1URC7ImTK4sHgONR1ffqQS/HPz2xzA1dVQQd5rEUEWu
 Oq3jbp6FCyrdBzkkzNNSVi11TS+cOvJjI9Tbo04w1yFGYVhCb5zmF3qrw2KOFIZohC
 n7l4UW8hi3A+MQWYNA6e9579qk1pd1yGBWlMKyKeMcqBeKvxh5L28m/lnvJf7LyFnE
 9ZKGWyFvLObuae4w/nBT/xLLjgXNLDtIwXQgmxjgk9PLqx8PqxS5J0z0KVoynsV+ow
 ODUuetLrICmoA==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.64
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
 yan.y.zhao@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With vIOMMU, during pre-copy phase of migration, while CPUs are still
running, IO virtual address unmap can happen while device still keeping
reference of guest pfns. Those pages should be reported as dirty before
unmap, so that VFIO user space application can copy content of those pages
from source to destination.

IOCTL defination added here add bitmap pointer, size and flag. If flag
VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is set and bitmap memory is allocated
and bitmap_size of set, then ioctl will create bitmap of pinned pages and
then unmap those.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 linux-headers/linux/vfio.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 2b00c732f313..520e952e3daf 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -925,6 +925,39 @@ struct vfio_iommu_type1_dirty_bitmap {
 
 #define VFIO_IOMMU_GET_DIRTY_BITMAP             _IO(VFIO_TYPE, VFIO_BASE + 17)
 
+/**
+ * VFIO_IOMMU_UNMAP_DMA_GET_BITMAP - _IOWR(VFIO_TYPE, VFIO_BASE + 18,
+                                     struct vfio_iommu_type1_dma_unmap_bitmap)
+ *
+ * Unmap IO virtual addresses using the provided struct
+ * vfio_iommu_type1_dma_unmap_bitmap.  Caller sets argsz.
+ * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get dirty bitmap
+ * before unmapping IO virtual addresses. If this flag is not set, only IO
+ * virtual address are unmapped, that is, behave same as VFIO_IOMMU_UNMAP_DMA
+ * ioctl.
+ * User should allocate memory to get bitmap and should set size of allocated
+ * memory in bitmap_size field. One bit is used to represent per page
+ * consecutively starting from iova offset. Bit set indicates page at that
+ * offset from iova is dirty.
+ * The actual unmapped size is returned in the size field and bitmap of pages
+ * in the range of unmapped size is retuned in bitmap if flag
+ * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP if set.
+ *
+ * No guarantee is made to the user that arbitrary unmaps of iova or size
+ * different from those used in the original mapping call will succeed.
+ */
+struct vfio_iommu_type1_dma_unmap_bitmap {
+	__u32        argsz;
+	__u32        flags;
+#define VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP (1 << 0)
+	__u64        iova;                        /* IO virtual address */
+	__u64        size;                        /* Size of mapping (bytes) */
+	__u64        bitmap_size;                 /* in bytes */
+	void        *bitmap;                      /* one bit per page */
+};
+
+#define VFIO_IOMMU_UNMAP_DMA_GET_BITMAP _IO(VFIO_TYPE, VFIO_BASE + 18)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.7.0


