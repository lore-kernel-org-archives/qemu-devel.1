Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B62C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F63206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F63206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHQb-0004T1-Nl
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jKHOU-0000ua-Ae
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jKHOT-0005gH-8r
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:09:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:21024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jKHOS-0005cT-VM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:09:37 -0400
IronPort-SDR: yXWWt1MUAmpDtNzNsr9MQX0fLpeJKx+gJ3cInbGzxfAaynhDi4LgPKRBmo0gcPmAQ25BP+LZkv
 9thRbNpGL+jQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2020 01:09:33 -0700
IronPort-SDR: 5Zolj/Qeuu7/qv/+rfE4AznJe1L42UgCAFgeny6H3BNKCzCyFg8vQIEHmOCCQJ9vksaeAlZIpV
 A7L7le4ot2Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; d="scan'208";a="449944029"
Received: from dpdk-zhirun.sh.intel.com ([10.67.119.121])
 by fmsmga005.fm.intel.com with ESMTP; 03 Apr 2020 01:09:31 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] hw/vfio: drop guest writes to ro regions
Date: Fri,  3 Apr 2020 17:00:24 +0000
Message-Id: <20200403170024.20676-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200403165657.20566-1-yan.y.zhao@intel.com>
References: <20200403165657.20566-1-yan.y.zhao@intel.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.88
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
Cc: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com,
 alex.williamson@redhat.com, philmd@redhat.com, xin.zeng@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

for vfio regions that are without write permission,
drop guest writes to those regions.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Xin Zeng <xin.zeng@intel.com>
---
 hw/vfio/common.c     | 8 +++++++-
 hw/vfio/trace-events | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b3593b3c0..fd6ee1fe3e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -190,6 +190,11 @@ void vfio_region_write(void *opaque, hwaddr addr,
         uint64_t qword;
     } buf;
 
+    if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
+        trace_vfio_region_write(vbasedev->name, region->nr,
+                                   addr, data, size, true);
+        return;
+    }
     switch (size) {
     case 1:
         buf.byte = data;
@@ -215,7 +220,8 @@ void vfio_region_write(void *opaque, hwaddr addr,
                      addr, data, size);
     }
 
-    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
+    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size,
+                            false);
 
     /*
      * A read or write to a BAR always signals an INTx EOI.  This will
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index b1ef55a33f..fb9ff604e6 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -91,7 +91,7 @@ vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt, uint64_t siz
 vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link_speed) "%s link_speed=0x%x"
 
 # common.c
-vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
+vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size, bool readonly) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)" " is_readonly_region=%d."
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
 vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
 vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING region_add 0x%"PRIx64" - 0x%"PRIx64
-- 
2.17.1


