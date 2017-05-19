Received: from eggs.gnu.org ([2001:4830:134:3::10]:35357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBYSx-0006s5-Cm
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBYSn-0005Wl-4l
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBYSm-0005WZ-Rr
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:25 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 May 2017 11:19:41 +0800
Message-Id: <1495163989-9994-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1495163989-9994-1-git-send-email-peterx@redhat.com>
References: <1495163989-9994-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 02/10] memory: remove the last param in
 memory_region_iommu_replay()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

We were always passing in that one as "false" to assume that's an read
operation, and we also assume that IOMMU translation would always have
that read permission. A better permission would be IOMMU_NONE since the
replay is after all not a real read operation, but just a page table
rebuilding process.

CC: David Gibson <david@gibson.dropbear.id.au>
CC: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/common.c      | 2 +-
 include/exec/memory.h | 5 +----
 memory.c              | 8 +++-----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a8f12ee..b9abe77 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -502,7 +502,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
 
         memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
-        memory_region_iommu_replay(giommu->iommu, &giommu->n, false);
+        memory_region_iommu_replay(giommu->iommu, &giommu->n);
 
         return;
     }
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 97fd0c2..bfdc685 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -731,11 +731,8 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
  *
  * @mr: the memory region to observe
  * @n: the notifier to which to replay iommu mappings
- * @is_write: Whether to treat the replay as a translate "write"
- *     through the iommu
  */
-void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
-                                bool is_write);
+void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n);
 
 /**
  * memory_region_iommu_replay_all: replay existing IOMMU translations
diff --git a/memory.c b/memory.c
index 3f0aae8..0ddc4cc 100644
--- a/memory.c
+++ b/memory.c
@@ -1620,12 +1620,10 @@ uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr)
     return TARGET_PAGE_SIZE;
 }
 
-void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
-                                bool is_write)
+void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
 {
     hwaddr addr, granularity;
     IOMMUTLBEntry iotlb;
-    IOMMUAccessFlags flag = is_write ? IOMMU_WO : IOMMU_RO;
 
     /* If the IOMMU has its own replay callback, override */
     if (mr->iommu_ops->replay) {
@@ -1636,7 +1634,7 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
     granularity = memory_region_iommu_get_min_page_size(mr);
 
     for (addr = 0; addr < memory_region_size(mr); addr += granularity) {
-        iotlb = mr->iommu_ops->translate(mr, addr, flag);
+        iotlb = mr->iommu_ops->translate(mr, addr, IOMMU_NONE);
         if (iotlb.perm != IOMMU_NONE) {
             n->notify(n, &iotlb);
         }
@@ -1654,7 +1652,7 @@ void memory_region_iommu_replay_all(MemoryRegion *mr)
     IOMMUNotifier *notifier;
 
     IOMMU_NOTIFIER_FOREACH(notifier, mr) {
-        memory_region_iommu_replay(mr, notifier, false);
+        memory_region_iommu_replay(mr, notifier);
     }
 }
 
-- 
2.7.4
