Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AD5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E9D2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WqXbfirP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E9D2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVkXJ-0000Hp-7g
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkNA-0002Dk-V3
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:19:40 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkN7-00082T-LS
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:19:40 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb0a2fa0000>; Mon, 04 May 2020 16:19:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 04 May 2020 16:19:35 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 04 May 2020 16:19:35 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 23:19:35 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
 Frontend Transport; Mon, 4 May 2020 23:19:28 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v18 QEMU 11/18] iommu: add callback to get address limit IOMMU
 supports
Date: Tue, 5 May 2020 04:14:46 +0530
Message-ID: <1588632293-18932-12-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588632293-18932-1-git-send-email-kwankhede@nvidia.com>
References: <1588632293-18932-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1588634363; bh=O9XV7D5FxmOFBmprNRbpwsU4to7+MGZBhc9zVXWkdKk=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=WqXbfirPqU4OtM5t8sLxbiG00sBgWtJQRmrAa6ypGcAiiom0jFE2Nxdz2FZCtFOdg
 +lSjOgXN8a4WaM+ZRP71ndwmqqa2aq1AfgI/B61zTTFS2hfcbQVnygToy8eCoiFHQO
 UoBLux277YZFVvWtxt8S95Q8tXkcsPXUwJAFztgVJXY+bfmmNIvlbMLmjzP+8U8b5+
 apVYcIqDmhzVV5FVqPIHT6ocuY0a0+fq+5eZw431iAGKWevRdeyYeBGhoVpDniercB
 8WOj1JDZPvUKsNx4RKmWTmnNLfXcmyUD0WGZGHcLMbFV7Jy1JdWFgAp7JhCXQ2Cz1t
 SRHcge+6uYeMg==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 19:18:18
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
Cc: cohuck@redhat.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add optional method to get address limit IOMMU supports

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
---
 hw/i386/intel_iommu.c |  9 +++++++++
 include/exec/memory.h | 18 ++++++++++++++++++
 memory.c              | 11 +++++++++++
 3 files changed, 38 insertions(+)

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
index e000bd2f97b2..2d0cbd46d2a6 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -355,6 +355,16 @@ typedef struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      */
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
+
+    /*
+     * Return address limit this IOMMU supports.
+     *
+     * Optional method: if this method is not provided, then
+     * memory_region_iommu_get_address_limit() will return 0.
+     *
+     * @iommu: the IOMMUMemoryRegion
+     */
+    hwaddr (*get_address_limit)(IOMMUMemoryRegion *iommu);
 } IOMMUMemoryRegionClass;
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -1364,6 +1374,14 @@ int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
 int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
 
 /**
+ * memory_region_iommu_get_address_limit : return the maximum address limit
+ * that this IOMMU supports.
+ *
+ * @iommu_mr: the memory region
+ */
+hwaddr memory_region_iommu_get_address_limit(IOMMUMemoryRegion *iommu_mr);
+
+/**
  * memory_region_name: get a memory region's name
  *
  * Returns the string that was used to initialize the memory region.
diff --git a/memory.c b/memory.c
index 601b74990620..52f1a4cd37f0 100644
--- a/memory.c
+++ b/memory.c
@@ -1887,6 +1887,17 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     }
 }
 
+hwaddr memory_region_iommu_get_address_limit(IOMMUMemoryRegion *iommu_mr)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+
+    if (imrc->get_address_limit) {
+        return imrc->get_address_limit(iommu_mr);
+    }
+
+    return 0;
+}
+
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
                                              IOMMUNotifier *n)
 {
-- 
2.7.0


