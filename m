Received: from eggs.gnu.org ([2001:4830:134:3::10]:36918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cb19X-0001xG-Ue
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cb19X-0004Vs-6S
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:29:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cb19X-0004VP-16
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:29:31 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  7 Feb 2017 16:28:13 +0800
Message-Id: <1486456099-7345-12-git-send-email-peterx@redhat.com>
In-Reply-To: <1486456099-7345-1-git-send-email-peterx@redhat.com>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 11/17] memory: provide
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 3 +++
 memory.c              | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 805a88a..f76e174 100644
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
index 4900bbf..523c43f 100644
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
         /*
          * Skip the notification if the notification does not overlap
          * with registered range.
-- 
2.7.4
