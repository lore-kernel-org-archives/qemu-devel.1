Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76579C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF9420578
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sRCnJr+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF9420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyDW-0000Qi-Dp
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jIy9L-0000da-AQ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:24:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jIy9J-0002gO-W8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:24:35 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3667)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jIy9J-0002f9-Pt
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:24:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e822b200000>; Mon, 30 Mar 2020 10:23:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 30 Mar 2020 10:24:32 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 30 Mar 2020 10:24:32 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Mar
 2020 17:24:31 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 30 Mar 2020 17:24:25 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v17 Kernel 3/7] vfio iommu: Add ioctl definition for dirty
 pages tracking.
Date: Mon, 30 Mar 2020 22:20:40 +0530
Message-ID: <1585587044-2408-4-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1585587044-2408-1-git-send-email-kwankhede@nvidia.com>
References: <1585587044-2408-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585589024; bh=Pu5BHXcZShd6c+5u/kqLE2uBbBNpCDtgeh212QBRLK8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=sRCnJr+HN1CczEapwLVPfq9hDgriuP3dvpHwyVcJUz0hRRr0qOeFbuqXVAY4wBMZs
 KkFg2wMF4osHH8bZtSTM18eSQNb6B2/SvuI3HmRWD7Rl+DupGa69XCFTYbPWrsnSm1
 YoWyYAYEURqU1e5X8A3PzoY4DTZbsyy24kaUGmEVU2H0JL15LLwM+WitmyIGqdONGG
 eEd9o2SMSecJ5E3urqig3jbdCaFL9CK/uPtnlQGGLdEW730wle5/SXQKPC9UX8udci
 GFGJc9sCzwio8z7umC3lKdZTj1CdpevJKFlXikVlqMbPkziSou7z7HAE2baiiBU5Dv
 7ER7B8Rus3JLQ==
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
Added support to start/stop dirtied pages tracking and to get bitmap of all
dirtied pages for requested IO virtual address range.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 include/uapi/linux/vfio.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index ad9bb5af3463..5f359c63f5ef 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1033,6 +1033,12 @@ struct vfio_iommu_type1_dma_map {
 
 #define VFIO_IOMMU_MAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 13)
 
+struct vfio_bitmap {
+	__u64        pgsize;	/* page size for bitmap in bytes */
+	__u64        size;	/* in bytes */
+	__u64 __user *data;	/* one bit per page */
+};
+
 /**
  * VFIO_IOMMU_UNMAP_DMA - _IOWR(VFIO_TYPE, VFIO_BASE + 14,
  *							struct vfio_dma_unmap)
@@ -1059,6 +1065,56 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/**
+ * VFIO_IOMMU_DIRTY_PAGES - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
+ *                                     struct vfio_iommu_type1_dirty_bitmap)
+ * IOCTL is used for dirty pages tracking.
+ * Caller should set flag depending on which operation to perform, details as
+ * below:
+ *
+ * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_START set, indicates
+ * migration is active and IOMMU module should track pages which are dirtied or
+ * potentially dirtied by device.
+ * Dirty pages are tracked until tracking is stopped by user application by
+ * setting VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag.
+ *
+ * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP set, indicates
+ * IOMMU should stop tracking dirtied pages.
+ *
+ * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP flag set,
+ * IOCTL returns dirty pages bitmap for IOMMU container during migration for
+ * given IOVA range. User must provide data[] as the structure
+ * vfio_iommu_type1_dirty_bitmap_get through which user provides IOVA range and
+ * pgsize. IOVA range must match to that used in original mapping call. This
+ * interface supports to get bitmap of smallest supported pgsize only and can
+ * be modified in future to get bitmap of specified pgsize.
+ * User must allocate memory for bitmap and set size of allocated memory in
+ * bitmap.size field. One bit is used to represent one page consecutively
+ * starting from iova offset. User should provide page size in bitmap.pgsize
+ * field. Bit set in bitmap indicates page at that offset from iova is
+ * dirty. Caller must set argsz including size of structure
+ * vfio_iommu_type1_dirty_bitmap_get.
+ *
+ * Only one of the flags _START, STOP and _GET may be specified at a time.
+ *
+ */
+struct vfio_iommu_type1_dirty_bitmap {
+	__u32        argsz;
+	__u32        flags;
+#define VFIO_IOMMU_DIRTY_PAGES_FLAG_START	(1 << 0)
+#define VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP	(1 << 1)
+#define VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP	(1 << 2)
+	__u8         data[];
+};
+
+struct vfio_iommu_type1_dirty_bitmap_get {
+	__u64              iova;	/* IO virtual address */
+	__u64              size;	/* Size of iova range */
+	struct vfio_bitmap bitmap;
+};
+
+#define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.7.0


