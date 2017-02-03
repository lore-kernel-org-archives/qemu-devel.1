Received: from eggs.gnu.org ([2001:4830:134:3::10]:59719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZZA0-0006fm-UH
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZZ9x-0004rD-RA
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:24:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cZZ9x-0004qS-J1
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:23:57 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  3 Feb 2017 16:22:39 +0800
Message-Id: <1486110164-13797-14-git-send-email-peterx@redhat.com>
In-Reply-To: <1486110164-13797-1-git-send-email-peterx@redhat.com>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 13/18] memory: introduce
 memory_region_notify_one()
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

Generalizing the notify logic in memory_region_notify_iommu() into a
single function. This can be further used in customized replay()
functions for IOMMUs.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 15 +++++++++++++++
 memory.c              | 40 ++++++++++++++++++++++++----------------
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 606ce88..0767888 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -682,6 +682,21 @@ void memory_region_notify_iommu(MemoryRegion *mr,
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
index 9e1bb75..7a4f2f9 100644
--- a/memory.c
+++ b/memory.c
@@ -1666,32 +1666,40 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
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
2.7.4
