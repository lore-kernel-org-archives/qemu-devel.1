Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84861C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 18:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542EA20736
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 18:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hMMd2u+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542EA20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCSdw-0003vf-J8
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 14:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jCSYZ-0005nz-2Z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 14:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jCSYY-0008V7-3q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 14:27:43 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jCSYX-0008UT-U6
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 14:27:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e6a7ec00000>; Thu, 12 Mar 2020 11:26:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 12 Mar 2020 11:27:40 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 12 Mar 2020 11:27:40 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Mar
 2020 18:27:40 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 12 Mar 2020 18:27:34 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v13 Kernel 6/7] vfio iommu: Adds flag to indicate dirty pages
 tracking capability support
Date: Thu, 12 Mar 2020 23:23:26 +0530
Message-ID: <1584035607-23166-7-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1584035607-23166-1-git-send-email-kwankhede@nvidia.com>
References: <1584035607-23166-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1584037568; bh=wffUtCPToUD96RVkVsFm7jm6cVCQwNMnwaDaxOdEy9Q=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=hMMd2u+Vrbxr9ldQIafIk4ym1R4tm1ODXIvlwqVjmnL2uUNU8hW/Cc8oWxMlHFRe7
 jfkBnUX+UHvthnz5ue5YMjzw9SnAfYPnbjxoOWX3PlMZkvn39tqosWcIQjPYuimXGO
 mKhba716ukG8phlmmEWbZI+iHpEfLTPI9ycZ/UfVquYetZBgaRqeHEgesd8lRJMx52
 hMVlrHYnhMD7VzVfT+4PLZLpcTl3QbtIp4TAcGiQ8SNcaWV1HZ+KIw0d0an4hWRIwk
 tEMlAkxKsResKjb+2Hi/ejjOw67QcOzIOHunSx9iiycN6PJtL4rNFrFdQ5YzyDI/Zj
 8e9kKp2TyC+Yw==
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

Flag VFIO_IOMMU_INFO_DIRTY_PGS in VFIO_IOMMU_GET_INFO indicates that driver
support dirty pages tracking.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 drivers/vfio/vfio_iommu_type1.c | 3 ++-
 include/uapi/linux/vfio.h       | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 4037b82c6db0..4f1f116feabc 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2377,7 +2377,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 			info.cap_offset = 0; /* output, no-recopy necessary */
 		}
 
-		info.flags = VFIO_IOMMU_INFO_PGSIZES;
+		info.flags = VFIO_IOMMU_INFO_PGSIZES |
+			     VFIO_IOMMU_INFO_DIRTY_PGS;
 
 		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 12b2094f887e..217eaeec1eba 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -947,8 +947,9 @@ struct vfio_device_ioeventfd {
 struct vfio_iommu_type1_info {
 	__u32	argsz;
 	__u32	flags;
-#define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
-#define VFIO_IOMMU_INFO_CAPS	(1 << 1)	/* Info supports caps */
+#define VFIO_IOMMU_INFO_PGSIZES   (1 << 0) /* supported page sizes info */
+#define VFIO_IOMMU_INFO_CAPS      (1 << 1) /* Info supports caps */
+#define VFIO_IOMMU_INFO_DIRTY_PGS (1 << 2) /* supports dirty page tracking */
 	__u64	iova_pgsizes;	/* Bitmap of supported page sizes */
 	__u32   cap_offset;	/* Offset within info struct of first cap */
 };
-- 
2.7.0


