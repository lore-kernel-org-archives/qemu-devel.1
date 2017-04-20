Received: from eggs.gnu.org ([2001:4830:134:3::10]:47005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H74-0001ZJ-Uc
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H73-0004NI-8q
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:47:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41777)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d1H73-0004NC-25
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:47:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 20 Apr 2017 15:46:52 -0300
Message-Id: <20170420184705.25018-3-ehabkost@redhat.com>
In-Reply-To: <20170420184705.25018-1-ehabkost@redhat.com>
References: <20170420184705.25018-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/15] memory: provide IOMMU_NOTIFIER_FOREACH
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

A new macro is provided to iterate all the IOMMU notifiers hooked
under specific IOMMU memory region.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: \"Michael S. Tsirkin\" <mst@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1491562755-23867-3-git-send-email-peterx@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/exec/memory.h | 3 +++
 memory.c              | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 0840c89489..07e43daf20 100644
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
index 75ac595073..7496b3d3d5 100644
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
2.11.0.259.g40922b1
