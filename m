Received: from eggs.gnu.org ([2001:4830:134:3::10]:51129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cP4zo-0007oa-LY
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cP4zk-0002Tz-Ul
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:10:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cP4zk-0002TD-OV
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:10:04 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A48761B96
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 10:10:05 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  5 Jan 2017 18:09:47 +0800
Message-Id: <1483610987-24331-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1483610987-24331-1-git-send-email-peterx@redhat.com>
References: <1483610987-24331-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] intel_iommu: allow migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Amit Shah <amit.shah@redhat.com>

IOMMU needs to be migrated before all the PCI devices (in case there are
devices that will request for address translation). So marking it with
priority 100. Migration framework helped to do all the rest.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5f3e351..535ed2c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1996,7 +1996,26 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
 
 static const VMStateDescription vtd_vmstate = {
     .name = "iommu-intel",
-    .unmigratable = 1,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .priority = 100,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(root, IntelIOMMUState),
+        VMSTATE_UINT64(intr_root, IntelIOMMUState),
+        VMSTATE_UINT64(iq, IntelIOMMUState),
+        VMSTATE_UINT32(intr_size, IntelIOMMUState),
+        VMSTATE_UINT16(iq_head, IntelIOMMUState),
+        VMSTATE_UINT16(iq_tail, IntelIOMMUState),
+        VMSTATE_UINT16(iq_size, IntelIOMMUState),
+        VMSTATE_UINT16(next_frcd_reg, IntelIOMMUState),
+        VMSTATE_UINT8(iq_last_desc_type, IntelIOMMUState),
+        VMSTATE_BOOL(root_extended, IntelIOMMUState),
+        VMSTATE_BOOL(dmar_enabled, IntelIOMMUState),
+        VMSTATE_BOOL(qi_enabled, IntelIOMMUState),
+        VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
+        VMSTATE_BOOL(intr_eime, IntelIOMMUState),
+        VMSTATE_END_OF_LIST()
+    }
 };
 
 static const MemoryRegionOps vtd_mem_ops = {
-- 
2.7.4
