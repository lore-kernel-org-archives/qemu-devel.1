Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A2DC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57FD2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MCicwBYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57FD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGrQZ-0006v6-RN
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 17:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jGrL4-000786-PN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jGrL3-0004uL-Ft
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:43:58 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jGrL3-0004tz-A2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:43:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7a7f0e0001>; Tue, 24 Mar 2020 14:43:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 24 Mar 2020 14:43:56 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 24 Mar 2020 14:43:56 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Mar
 2020 21:43:55 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 24 Mar 2020 21:43:49 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v16 QEMU 11/16] iommu: add callback to get address limit IOMMU
 supports
Date: Wed, 25 Mar 2020 02:39:09 +0530
Message-ID: <1585084154-29461-12-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585086222; bh=SGokuzyK15XQbSaJXhwUASXV/zbDfGbkpeQEfjLqKAI=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=MCicwBYxJjtyhMDu6Y2/LnJEGNLTAVz6iSt0fSxqGMSIZCgsaatBP8wiIHoexxdvX
 rWZR3J46x33I+6rK1Sxb97LrpUPwTVM+kNUQdsd6JYIqIH6FZc2cGfVv6jEYo5LBcr
 pV89nvD/tFIglV7wNgS8g5bZQysqqyO4Sgcs2kkr6uSsZ6oAe5zi5ULvcYQO7QQQqh
 vjFBkgrYlOx08aNUuf5gX87P/HXXmg3i10xwF9HeCQGZXJ/9lvFEJ8MVns9pJEPmSF
 QI3SpvemY9BnwckOKobF/3I/i/6GzO4/TzbSySdMLhdPODYiuXXAdPQ7wjKvUadrzz
 hYaufXVeALMRA==
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

Add optional method to get address limit IOMMU supports

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
---
 hw/i386/intel_iommu.c |  9 +++++++++
 include/exec/memory.h | 19 +++++++++++++++++++
 memory.c              | 11 +++++++++++
 3 files changed, 39 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index df7ad254ac15..d0b88c20c31e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3577,6 +3577,14 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     return;
 }
 
+static hwaddr vtd_iommu_get_address_limit(IOMMUMemoryRegion *iommu_mr)
+{
+    VTDAddressSpace *vtd_as = container_of(iommu_mr, VTDAddressSpace, iommu);
+    IntelIOMMUState *s = vtd_as->iommu_state;
+
+    return VTD_ADDRESS_SIZE(s->aw_bits) - 1;
+}
+
 /* Do the initialization. It will also be called when reset, so pay
  * attention when adding new initialization stuff.
  */
@@ -3878,6 +3886,7 @@ static void vtd_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->translate = vtd_iommu_translate;
     imrc->notify_flag_changed = vtd_iommu_notify_flag_changed;
     imrc->replay = vtd_iommu_replay;
+    imrc->get_address_limit = vtd_iommu_get_address_limit;
 }
 
 static const TypeInfo vtd_iommu_memory_region_info = {
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1614d9a02c0c..f7d92bf6e6a9 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -355,6 +355,17 @@ typedef struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      */
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
+
+    /*
+     * Return address limit this IOMMU supports.
+     *
+     * Optional method: if this method is not provided, then
+     * memory_region_iommu_address_limit() will return the limit which input
+     * argument to this function.
+     *
+     * @iommu: the IOMMUMemoryRegion
+     */
+    hwaddr (*get_address_limit)(IOMMUMemoryRegion *iommu);
 } IOMMUMemoryRegionClass;
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -1364,6 +1375,14 @@ int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
 int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
 
 /**
+ * memory_region_iommu_get_address_limit : return the maximum address limit
+ * that this IOMMU supports.
+ *
+ * @iommu_mr: the memory region
+ */
+hwaddr memory_region_iommu_get_address_limit(IOMMUMemoryRegion *iommu_mr,
+                                             hwaddr limit);
+/**
  * memory_region_name: get a memory region's name
  *
  * Returns the string that was used to initialize the memory region.
diff --git a/memory.c b/memory.c
index 601b74990620..acb7546971c3 100644
--- a/memory.c
+++ b/memory.c
@@ -1887,6 +1887,17 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     }
 }
 
+hwaddr memory_region_iommu_get_address_limit(IOMMUMemoryRegion *iommu_mr,
+                                             hwaddr limit)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+
+    if (imrc->get_address_limit) {
+        return imrc->get_address_limit(iommu_mr);
+    }
+    return limit;
+}
+
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
                                              IOMMUNotifier *n)
 {
-- 
2.7.0


