Received: from eggs.gnu.org ([2001:4830:134:3::10]:47078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H7J-0001iG-HR
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H7I-0004RU-3G
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:47:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d1H7H-0004R8-Q9
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:47:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 20 Apr 2017 15:46:54 -0300
Message-Id: <20170420184705.25018-5-ehabkost@redhat.com>
In-Reply-To: <20170420184705.25018-1-ehabkost@redhat.com>
References: <20170420184705.25018-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 04/15] memory: introduce
 memory_region_notify_one()
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

Generalizing the notify logic in memory_region_notify_iommu() into a
single function. This can be further used in customized replay()
functions for IOMMUs.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: \"Michael S. Tsirkin\" <mst@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1491562755-23867-5-git-send-email-peterx@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/exec/memory.h | 15 +++++++++++++++
 memory.c              | 40 ++++++++++++++++++++++++----------------
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index fb7dff3405..055b3a8b23 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -688,6 +688,21 @@ void memory_region_notify_iommu(MemoryRegion *mr,
                                 IOMMUTLBEntry entry);
 
 /**
+ * memory_region_notify_one: notify a change in an IOMMU translation
+ *                           entry to a single notifier
+ *
+ * This works just like memory_region_notify_iommu(), but it only
+ * notifies a specific notifier, not all of them.
+ *
+ * @notifier: the notifier to be notified
+ * @entry: the new entry in the IOMMU translation table.  The entry
+ *         replaces all old entries for the same virtual I/O address range.
+ *         Deleted entries have .@perm == 0.
+ */
+void memory_region_notify_one(IOMMUNotifier *notifier,
+                              IOMMUTLBEntry *entry);
+
+/**
  * memory_region_register_iommu_notifier: register a notifier for changes to
  * IOMMU translation entries.
  *
diff --git a/memory.c b/memory.c
index b4ed67b27a..ded4bf13d6 100644
--- a/memory.c
+++ b/memory.c
@@ -1662,32 +1662,40 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
     memory_region_update_iommu_notify_flags(mr);
 }
 
-void memory_region_notify_iommu(MemoryRegion *mr,
-                                IOMMUTLBEntry entry)
+void memory_region_notify_one(IOMMUNotifier *notifier,
+                              IOMMUTLBEntry *entry)
 {
-    IOMMUNotifier *iommu_notifier;
     IOMMUNotifierFlag request_flags;
 
-    assert(memory_region_is_iommu(mr));
+    /*
+     * Skip the notification if the notification does not overlap
+     * with registered range.
+     */
+    if (notifier->start > entry->iova + entry->addr_mask + 1 ||
+        notifier->end < entry->iova) {
+        return;
+    }
 
-    if (entry.perm & IOMMU_RW) {
+    if (entry->perm & IOMMU_RW) {
         request_flags = IOMMU_NOTIFIER_MAP;
     } else {
         request_flags = IOMMU_NOTIFIER_UNMAP;
     }
 
+    if (notifier->notifier_flags & request_flags) {
+        notifier->notify(notifier, entry);
+    }
+}
+
+void memory_region_notify_iommu(MemoryRegion *mr,
+                                IOMMUTLBEntry entry)
+{
+    IOMMUNotifier *iommu_notifier;
+
+    assert(memory_region_is_iommu(mr));
+
     IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
-        /*
-         * Skip the notification if the notification does not overlap
-         * with registered range.
-         */
-        if (iommu_notifier->start > entry.iova + entry.addr_mask + 1 ||
-            iommu_notifier->end < entry.iova) {
-            continue;
-        }
-        if (iommu_notifier->notifier_flags & request_flags) {
-            iommu_notifier->notify(iommu_notifier, &entry);
-        }
+        memory_region_notify_one(iommu_notifier, &entry);
     }
 }
 
-- 
2.11.0.259.g40922b1
