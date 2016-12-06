Received: from eggs.gnu.org ([2001:4830:134:3::10]:54847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED7V-0007aN-Sa
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED7V-000217-01
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:37:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cED7U-00020z-QE
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:37:08 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Dec 2016 18:36:25 +0800
Message-Id: <1481020588-4245-11-git-send-email-peterx@redhat.com>
In-Reply-To: <1481020588-4245-1-git-send-email-peterx@redhat.com>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 10/13] memory: add
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, peterx@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com

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
index 9902e9e..6bdd12c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -183,6 +183,8 @@ struct MemoryRegionIOMMUOps {
     void (*notify_flag_changed)(MemoryRegion *iommu,
                                 IOMMUNotifierFlag old_flags,
                                 IOMMUNotifierFlag new_flags);
+    /* Set this up to provide customized IOMMU replay function */
+    void (*replay)(MemoryRegion *iommu, IOMMUNotifier *notifier);
 };
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
diff --git a/memory.c b/memory.c
index 84c91fa..9ad6319 100644
--- a/memory.c
+++ b/memory.c
@@ -1624,6 +1624,12 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
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
