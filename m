Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB42C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDD4207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NNGjqDBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDD4207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jePj8-0000bI-G9
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 17:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jePho-0006qy-Af
 for qemu-devel@nongnu.org; Thu, 28 May 2020 17:04:48 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jePhn-0006DL-4P
 for qemu-devel@nongnu.org; Thu, 28 May 2020 17:04:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ed027120000>; Thu, 28 May 2020 14:03:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 28 May 2020 14:04:45 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 28 May 2020 14:04:45 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 May
 2020 21:04:36 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 28 May 2020 21:04:29 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH Kernel v24 4/8] vfio iommu: Add ioctl definition for dirty
 pages tracking
Date: Fri, 29 May 2020 02:00:50 +0530
Message-ID: <1590697854-21364-5-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1590697854-21364-1-git-send-email-kwankhede@nvidia.com>
References: <1590697854-21364-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1590699794; bh=MAdh/taHvkt8ypYvS/kvFQ2uf0sas7Nt+CMV5JYv8dU=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=NNGjqDBlB0FfVC0UoHH+ufwiAPU/UNJRCr/ppRwrU8UzhPCN+fHkeQ8zplJ+uk0G3
 WFsbkbONqS2kkeA1n3vShEcoqDwiMtybas7reCeMT2+t+UGapoGst3NGqKvnPWk0gk
 nlnPQ/+OrqQRDECrILfb5+vcZ67uPYMmxZvD3sc5/L+hcShkS5gXxCV5wrth3sqT8I
 hXqaDDcv7YWb00gf5u1s/OvdLE7verRFdzXR2scPmXUpN9RmL5qu26e5STyUQJjqkw
 DoPSU+d2p6SW2n43RPS/VsqrdC/kGBwRYvVu7zGfHUk1+6/LNcncoAg9hkD/+cdKjD
 E5NdJyYUPbJmw==
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

IOMMU container maintains a list of all pages pinned by vfio_pin_pages API.
All pages pinned by vendor driver through this API should be considered as
dirty during migration. When container consists of IOMMU capable device and
all pages are pinned and mapped, then all pages are marked dirty.
Added support to start/stop dirtied pages tracking and to get bitmap of all
dirtied pages for requested IO virtual address range.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/uapi/linux/vfio.h | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index ad9bb5af3463..009a8c80079d 100644
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
@@ -1059,6 +1065,57 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/**
+ * VFIO_IOMMU_DIRTY_PAGES - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
+ *                                     struct vfio_iommu_type1_dirty_bitmap)
+ * IOCTL is used for dirty pages logging.
+ * Caller should set flag depending on which operation to perform, details as
+ * below:
+ *
+ * Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_START flag set, instructs
+ * the IOMMU driver to log pages that are dirtied or potentially dirtied by
+ * the device; designed to be used when a migration is in progress. Dirty pages
+ * are logged until logging is disabled by user application by calling the IOCTL
+ * with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag.
+ *
+ * Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag set, instructs
+ * the IOMMU driver to stop logging dirtied pages.
+ *
+ * Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP flag set
+ * returns the dirty pages bitmap for IOMMU container for a given IOVA range.
+ * The user must specify the IOVA range and the pgsize through the structure
+ * vfio_iommu_type1_dirty_bitmap_get in the data[] portion. This interface
+ * supports getting a bitmap of the smallest supported pgsize only and can be
+ * modified in future to get a bitmap of any specified supported pgsize. The
+ * user must provide a zeroed memory area for the bitmap memory and specify its
+ * size in bitmap.size. One bit is used to represent one page consecutively
+ * starting from iova offset. The user should provide page size in bitmap.pgsize
+ * field. A bit set in the bitmap indicates that the page at that offset from
+ * iova is dirty. The caller must set argsz to a value including the size of
+ * structure vfio_iommu_type1_dirty_bitmap_get, but excluding the size of the
+ * actual bitmap. If dirty pages logging is not enabled, an error will be
+ * returned.
+ *
+ * Only one of the flags _START, _STOP and _GET may be specified at a time.
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


