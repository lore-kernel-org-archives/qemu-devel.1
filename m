Received: from eggs.gnu.org ([2001:4830:134:3::10]:44844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1csn4s-0007QJ-Jb
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1csn4o-0003y3-OR
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:06:10 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 28 Mar 2017 20:05:28 +1100
Message-Id: <20170328090530.20052-2-aik@ozlabs.ru>
In-Reply-To: <20170328090530.20052-1-aik@ozlabs.ru>
References: <20170328090530.20052-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu 1/3] memory: Add get_fd() hook for
 IOMMU MR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/exec/memory.h | 2 ++
 hw/ppc/spapr_iommu.c  | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e39256ad03..925c10b35b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -174,6 +174,8 @@ struct MemoryRegionIOMMUOps {
     void (*notify_flag_changed)(MemoryRegion *iommu,
                                 IOMMUNotifierFlag old_flags,
                                 IOMMUNotifierFlag new_flags);
+    /* Returns a kernel fd for IOMMU */
+    int (*get_fd)(MemoryRegion *iommu);
 };
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 9e30e148d6..b61c8f053e 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -170,6 +170,13 @@ static void spapr_tce_notify_flag_changed(MemoryRegion *iommu,
     }
 }
 
+static int spapr_tce_get_fd(MemoryRegion *iommu)
+{
+    sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
+
+    return tcet->fd;
+}
+
 static int spapr_tce_table_post_load(void *opaque, int version_id)
 {
     sPAPRTCETable *tcet = SPAPR_TCE_TABLE(opaque);
@@ -251,6 +258,7 @@ static MemoryRegionIOMMUOps spapr_iommu_ops = {
     .translate = spapr_tce_translate_iommu,
     .get_min_page_size = spapr_tce_get_min_page_size,
     .notify_flag_changed = spapr_tce_notify_flag_changed,
+    .get_fd = spapr_tce_get_fd,
 };
 
 static int spapr_tce_table_realize(DeviceState *dev)
-- 
2.11.0
