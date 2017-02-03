Received: from eggs.gnu.org ([2001:4830:134:3::10]:59737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZZA2-0006hz-BM
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZZA1-0004uL-H1
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:24:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cZZA1-0004tU-CE
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:24:01 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  3 Feb 2017 16:22:40 +0800
Message-Id: <1486110164-13797-15-git-send-email-peterx@redhat.com>
In-Reply-To: <1486110164-13797-1-git-send-email-peterx@redhat.com>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 14/18] memory: add
 MemoryRegionIOMMUOps.replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

Originally we have one memory_region_iommu_replay() function, which is
the default behavior to replay the translations of the whole IOMMU
region. However, on some platform like x86, we may want our own replay
logic for IOMMU regions. This patch add one more hook for IOMMUOps for
the callback, and it'll override the default if set.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 2 ++
 memory.c              | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 0767888..30b2a74 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -191,6 +191,8 @@ struct MemoryRegionIOMMUOps {
     void (*notify_flag_changed)(MemoryRegion *iommu,
                                 IOMMUNotifierFlag old_flags,
                                 IOMMUNotifierFlag new_flags);
+    /* Set this up to provide customized IOMMU replay function */
+    void (*replay)(MemoryRegion *iommu, IOMMUNotifier *notifier);
 };
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
diff --git a/memory.c b/memory.c
index 7a4f2f9..9c253cc 100644
--- a/memory.c
+++ b/memory.c
@@ -1630,6 +1630,12 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
     hwaddr addr, granularity;
     IOMMUTLBEntry iotlb;
 
+    /* If the IOMMU has its own replay callback, override */
+    if (mr->iommu_ops->replay) {
+        mr->iommu_ops->replay(mr, n);
+        return;
+    }
+
     granularity = memory_region_iommu_get_min_page_size(mr);
 
     for (addr = 0; addr < memory_region_size(mr); addr += granularity) {
-- 
2.7.4
