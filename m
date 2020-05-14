Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5E0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8222065C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qskyBTjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8222065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZLA5-0006we-Bj
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 17:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jZL90-00054o-C9
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:11:54 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jZL8y-0000sy-1X
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:11:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ebdb40a0000>; Thu, 14 May 2020 14:11:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 14 May 2020 14:11:50 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 14 May 2020 14:11:50 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 May
 2020 21:11:50 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 14 May 2020 21:11:44 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH Kernel v20 7/8] vfio iommu: Add migration capability to report
 supported features
Date: Fri, 15 May 2020 02:07:46 +0530
Message-ID: <1589488667-9683-8-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1589488667-9683-1-git-send-email-kwankhede@nvidia.com>
References: <1589488667-9683-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1589490698; bh=7/FHdy4SAIGMgoLkaA5oW8uu18Kdw+ZqC1L5LJHsD+8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=qskyBTjj/xsk77LFTmyE6HqCbb9PSWwGs0/KuXSskJB3oZ9XrvA9O3+rTU6OBcRiL
 nufYmdIbzZL69LOzZ0TmH/ZcxFeVFmBDnogdcnI1B+AiZoriJSD9UR9EYkiBdrGGZ+
 QFcUgcq/lazeuOBehLDRxUnEOZi6UFPCLVHBMH4r4RGO0SPh5gYoZ/1l5Lg3IHhg7+
 dTyM2/YpngcB9EF4MermvheI7UgAAppef1v4yNawWqkpic4Q3SKaXBAUhMsTS8w99t
 ZPmHmnpEWOWiMWXyy48gbcZaqZHSHzf9H0jNopQn2EGs1Vl51AfgRp+mIBb9BTvcO3
 sX9OEoWuRTCKA==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 17:11:44
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

Added migration capability in IOMMU info chain.
User application should check IOMMU info chain for migration capability
to use dirty page tracking feature provided by kernel module.
User application must check page sizes supported and maximum dirty
bitmap size returned by this capability structure for ioctls used to get
dirty bitmap.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
---
 drivers/vfio/vfio_iommu_type1.c | 23 ++++++++++++++++++++++-
 include/uapi/linux/vfio.h       | 22 ++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index a1dc57bcece5..3edb3c3e6170 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2387,6 +2387,22 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 	return ret;
 }
 
+static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
+					   struct vfio_info_cap *caps)
+{
+	struct vfio_iommu_type1_info_cap_migration cap_mig;
+
+	cap_mig.header.id = VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION;
+	cap_mig.header.version = 1;
+
+	cap_mig.flags = 0;
+	/* support minimum pgsize */
+	cap_mig.pgsize_bitmap = (size_t)1 << __ffs(iommu->pgsize_bitmap);
+	cap_mig.max_dirty_bitmap_size = DIRTY_BITMAP_SIZE_MAX;
+
+	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
+}
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -2433,8 +2449,13 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
 		info.iova_pgsizes = iommu->pgsize_bitmap;
 
-		ret = vfio_iommu_iova_build_caps(iommu, &caps);
+		ret = vfio_iommu_migration_build_caps(iommu, &caps);
+
+		if (!ret)
+			ret = vfio_iommu_iova_build_caps(iommu, &caps);
+
 		mutex_unlock(&iommu->lock);
+
 		if (ret)
 			return ret;
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 0a0c7315ddd6..ab1d0150bbd3 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1013,6 +1013,28 @@ struct vfio_iommu_type1_info_cap_iova_range {
 	struct	vfio_iova_range iova_ranges[];
 };
 
+/*
+ * The migration capability allows to report supported features for migration.
+ *
+ * The structures below define version 1 of this capability.
+ *
+ * The existence of this capability indicates IOMMU kernel driver supports
+ * dirty page tracking.
+ *
+ * pgsize_bitmap: Kernel driver returns supported page sizes bitmap for dirty
+ * page tracking.
+ * max_dirty_bitmap_size: Kernel driver returns maximum supported dirty bitmap
+ * size in bytes to be used by user application for ioctls to get dirty bitmap.
+ */
+#define VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION  1
+
+struct vfio_iommu_type1_info_cap_migration {
+	struct	vfio_info_cap_header header;
+	__u32	flags;
+	__u64	pgsize_bitmap;
+	__u64	max_dirty_bitmap_size;		/* in bytes */
+};
+
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
 
 /**
-- 
2.7.0


