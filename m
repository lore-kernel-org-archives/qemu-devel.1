Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D195C54EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5501C20658
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SuN7n6oO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5501C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGrLK-0007E8-Ar
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 17:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jGrKD-0005XB-3H
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jGrKB-0004dL-Vh
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:43:04 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jGrKB-0004bF-Pb
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:43:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7a7ed80001>; Tue, 24 Mar 2020 14:42:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 24 Mar 2020 14:43:01 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 24 Mar 2020 14:43:01 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Mar
 2020 21:43:01 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 24 Mar 2020 21:42:55 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v16 QEMU 03/16] vfio: Add vfio_get_object callback to
 VFIODeviceOps
Date: Wed, 25 Mar 2020 02:39:01 +0530
Message-ID: <1585084154-29461-4-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585086168; bh=RQyD3Vak9+vtQi5zZdaNzLlTlIKg3CpA3v/dVe1gFhQ=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=SuN7n6oO4WfiZApwVtLBT/TFOxMRa0Hjharrys+k5dwey/T6MWpb/XDG9VgAmBSYp
 LKAXo7O093wTnmYwvQ+eYhPfvxlC+GX6scrP1ejlgr9IzTtx8vh0cmMPQw1hoNfSdB
 Qly6rJG1eUUc9qm8wfTivFSylZG4NZ8pmaZTH+n6JGLiZgUzVjo029mCsFK6ygprbn
 NtshqGOq3SCmvG4k04VHn0yRoKpEH+H5kGbS1N2MpvxDrjILB1rPanuZoBCD7S0mA9
 fqMcVg+FJfQ867b5raMnyMKSMulpz462OXS+GrGUgZjVOeCLpfqwYLQvIYEJ3om6R6
 DXcKYzC0eRKQw==
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
 yan.y.zhao@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hook vfio_get_object callback for PCI devices.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/pci.c                 | 8 ++++++++
 include/hw/vfio/vfio-common.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5e75a95129ac..6c77c12e44b9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2407,10 +2407,18 @@ static void vfio_pci_compute_needs_reset(VFIODevice *vbasedev)
     }
 }
 
+static Object *vfio_pci_get_object(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+
+    return OBJECT(vdev);
+}
+
 static VFIODeviceOps vfio_pci_ops = {
     .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
     .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
     .vfio_eoi = vfio_intx_eoi,
+    .vfio_get_object = vfio_pci_get_object,
 };
 
 int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8d7a0fbb1046..74261feaeac9 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -119,6 +119,7 @@ struct VFIODeviceOps {
     void (*vfio_compute_needs_reset)(VFIODevice *vdev);
     int (*vfio_hot_reset_multi)(VFIODevice *vdev);
     void (*vfio_eoi)(VFIODevice *vdev);
+    Object *(*vfio_get_object)(VFIODevice *vdev);
 };
 
 typedef struct VFIOGroup {
-- 
2.7.0


