Received: from eggs.gnu.org ([2001:4830:134:3::10]:48764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYwm-0001hJ-7C
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYwi-0002X4-O7
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:09:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cUYwi-0002WY-I9
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:09:36 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 20 Jan 2017 21:08:47 +0800
Message-Id: <1484917736-32056-12-git-send-email-peterx@redhat.com>
In-Reply-To: <1484917736-32056-1-git-send-email-peterx@redhat.com>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v4 11/20] memory: provide
 IOMMU_NOTIFIER_FOREACH macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 3 +++
 memory.c              | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index ae4c9a9..f0cb631 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -243,6 +243,9 @@ struct MemoryRegion {
     IOMMUNotifierFlag iommu_notify_flags;
 };
 
+#define IOMMU_NOTIFIER_FOREACH(n, mr) \
+    QLIST_FOREACH((n), &(mr)->iommu_notify, node)
+
 /**
  * MemoryListener: callbacks structure for updates to the physical memory map
  *
diff --git a/memory.c b/memory.c
index 89104b1..d1ee3e0 100644
--- a/memory.c
+++ b/memory.c
@@ -1587,7 +1587,7 @@ static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
     IOMMUNotifierFlag flags = IOMMU_NOTIFIER_NONE;
     IOMMUNotifier *iommu_notifier;
 
-    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
+    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
         flags |= iommu_notifier->notifier_flags;
     }
 
@@ -1671,7 +1671,7 @@ void memory_region_notify_iommu(MemoryRegion *mr,
         request_flags = IOMMU_NOTIFIER_UNMAP;
     }
 
-    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
+    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
         if (iommu_notifier->notifier_flags & request_flags &&
             iommu_notifier->start <= entry.iova &&
             iommu_notifier->end >= entry.iova) {
-- 
2.7.4
