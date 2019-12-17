Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D441C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFFF206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XmmXOTHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFFF206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGqr-0003dM-U9
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1ihGp9-0001lV-JZ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1ihGp8-0000rr-Ch
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:39:55 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11847)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1ihGp8-0000qK-6p
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:39:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5df912df0000>; Tue, 17 Dec 2019 09:39:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 17 Dec 2019 09:39:52 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 17 Dec 2019 09:39:52 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 17:39:52 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 17 Dec 2019 17:39:45 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v11 Kernel 2/6] vfio iommu: Add ioctl definition for dirty
 pages tracking.
Date: Tue, 17 Dec 2019 22:40:47 +0530
Message-ID: <1576602651-15430-3-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1576602651-15430-1-git-send-email-kwankhede@nvidia.com>
References: <1576602651-15430-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1576604383; bh=Y7ec53IcGD4zcnvo82N9DW1lEyMmknttTvvdgtYF6eY=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=XmmXOTHza0I3A7M92DGGBDPTAiijyH4b3PtWvzx6LN4FAkplgwuxEv/34DZMEGJPE
 FJdk/9s4dpOJp9EFlm0/as/N3jNOHhAdG9PxgZWG7SG9ycOfodVBOs9gVSUMqqKhRG
 9DhzHPxngovCyiUJwhw/BAdW8/i2K683VQ90okFApxf544bHEQ9l8fkrEoihnlL5qB
 zbnm5SD9ykykg3RlC4tq4xzWAAln4TBLcmH77Srugc0L6BPb6z+ivSpyN/g+1MDNXP
 85asmmCdCFA+kK88/051bY1/KyOCGeQp/58HZiQra+Q3dsJPaxEcHo/D8CjIbi0f6h
 8JvcxeoAP66YA==
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
 yan.y.zhao@intel.com, kvm@vger.kernel.org, eskultet@redhat.com,
 ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IOMMU container maintains a list of all pages pinned by vfio_pin_pages API.
All pages pinned by vendor driver through this API should be considered as
dirty during migration. When container consists of IOMMU capable device and
all pages are pinned and mapped, then all pages are marked dirty.
Added support to start/stop unpinned pages tracking and to get bitmap of
all dirtied pages for requested IO virtual address range. Unpinned page
tracking is cleared either when bitmap is read by user application or
unpinned page tracking is stopped.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 include/uapi/linux/vfio.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index b7ac8f7c0d3c..8268634e7e08 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -981,6 +981,49 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/**
+ * VFIO_IOMMU_DIRTY_PAGES - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
+ *                                     struct vfio_iommu_type1_dirty_bitmap)
+ * IOCTL is used for dirty pages tracking. Caller sets argsz, which is size of
+ * struct vfio_iommu_type1_dirty_bitmap. Caller set flag depend on which
+ * operation to perform, details as below:
+ *
+ * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_START set, indicates
+ * migration is active and IOMMU module should track pages which are being
+ * unpinned. Unpinned pages are tracked until bitmap for that range is queried
+ * or tracking is stopped by user application by setting
+ * VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag.
+ *
+ * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP set, indicates
+ * IOMMU should stop tracking unpinned pages and also free previously tracked
+ * unpinned pages data.
+ *
+ * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP flag set,
+ * IOCTL returns dirty pages bitmap for IOMMU container during migration for
+ * given IOVA range. User must allocate memory to get bitmap, zero the bitmap
+ * memory and set size of allocated memory in bitmap_size field. One bit is
+ * used to represent one page consecutively starting from iova offset. User
+ * should provide page size in 'pgsize'. Bit set in bitmap indicates page at
+ * that offset from iova is dirty.
+ *
+ * Only one flag should be set at a time.
+ *
+ */
+struct vfio_iommu_type1_dirty_bitmap {
+	__u32        argsz;
+	__u32        flags;
+#define VFIO_IOMMU_DIRTY_PAGES_FLAG_START	(1 << 0)
+#define VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP	(1 << 1)
+#define VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP	(1 << 2)
+	__u64        iova;		/* IO virtual address */
+	__u64        size;		/* Size of iova range */
+	__u64	     pgsize;		/* page size for bitmap */
+	__u64        bitmap_size;	/* in bytes */
+	void __user *bitmap;		/* one bit per page */
+};
+
+#define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.7.0


