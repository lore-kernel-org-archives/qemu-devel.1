Received: from eggs.gnu.org ([2001:4830:134:3::10]:41731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw1Xu-0003d6-Cf
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw1Xr-0002Rh-6B
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:09:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cw1Xr-0002RD-0u
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:09:27 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu,  6 Apr 2017 15:08:37 +0800
Message-Id: <1491462524-1617-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1491462524-1617-1-git-send-email-peterx@redhat.com>
References: <1491462524-1617-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 2/9] memory: provide IOMMU_NOTIFIER_FOREACH
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 3 +++
 memory.c              | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 0840c89..07e43da 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -239,6 +239,9 @@ struct MemoryRegion {
     IOMMUNotifierFlag iommu_notify_flags;
 };
 
+#define IOMMU_NOTIFIER_FOREACH(n, mr) \
+    QLIST_FOREACH((n), &(mr)->iommu_notify, node)
+
 /**
  * MemoryListener: callbacks structure for updates to the physical memory map
  *
diff --git a/memory.c b/memory.c
index 75ac595..7496b3d 100644
--- a/memory.c
+++ b/memory.c
@@ -1583,7 +1583,7 @@ static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
     IOMMUNotifierFlag flags = IOMMU_NOTIFIER_NONE;
     IOMMUNotifier *iommu_notifier;
 
-    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
+    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
         flags |= iommu_notifier->notifier_flags;
     }
 
@@ -1667,7 +1667,7 @@ void memory_region_notify_iommu(MemoryRegion *mr,
         request_flags = IOMMU_NOTIFIER_UNMAP;
     }
 
-    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
+    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
         /*
          * Skip the notification if the notification does not overlap
          * with registered range.
-- 
2.7.4
