Received: from eggs.gnu.org ([2001:4830:134:3::10]:51748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRsDd-0002h7-A6
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRsDa-0007f4-6e
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:07:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRsDZ-0007ex-U1
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:07:54 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 13 Jan 2017 11:06:35 +0800
Message-Id: <1484276800-26814-10-git-send-email-peterx@redhat.com>
In-Reply-To: <1484276800-26814-1-git-send-email-peterx@redhat.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 09/14] memory: introduce
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

Generalizing the notify logic in memory_region_notify_iommu() into a
single function. This can be further used in customized replay()
functions for IOMMUs.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 15 +++++++++++++++
 memory.c              | 29 ++++++++++++++++++-----------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2233f99..f367e54 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -669,6 +669,21 @@ void memory_region_notify_iommu(MemoryRegion *mr,
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
index df62bd1..6e4c872 100644
--- a/memory.c
+++ b/memory.c
@@ -1665,26 +1665,33 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
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
-
-    if (entry.perm & IOMMU_RW) {
+    if (entry->perm & IOMMU_RW) {
         request_flags = IOMMU_NOTIFIER_MAP;
     } else {
         request_flags = IOMMU_NOTIFIER_UNMAP;
     }
 
+    if (notifier->notifier_flags & request_flags &&
+        notifier->start <= entry->iova &&
+        notifier->end >= entry->iova) {
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
     QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
-        if (iommu_notifier->notifier_flags & request_flags &&
-            iommu_notifier->start <= entry.iova &&
-            iommu_notifier->end >= entry.iova) {
-            iommu_notifier->notify(iommu_notifier, &entry);
-        }
+        memory_region_notify_one(iommu_notifier, &entry);
     }
 }
 
-- 
2.7.4
