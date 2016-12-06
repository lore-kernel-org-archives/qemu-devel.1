Received: from eggs.gnu.org ([2001:4830:134:3::10]:54811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED7Q-0007VJ-67
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED7P-00020D-2z
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:37:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cED7O-0001zI-TS
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:37:03 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Dec 2016 18:36:23 +0800
Message-Id: <1481020588-4245-9-git-send-email-peterx@redhat.com>
In-Reply-To: <1481020588-4245-1-git-send-email-peterx@redhat.com>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 08/13] memory: provide iommu_replay_all()
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

This is an "global" version of exising memory_region_iommu_replay() - we
announce the translations to all the registered notifiers, instead of a
specific one.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 8 ++++++++
 memory.c              | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index cb2d432..1669c7b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -693,6 +693,14 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
                                 bool is_write);
 
 /**
+ * memory_region_iommu_replay_all: replay existing IOMMU translations
+ * to all the notifiers registered.
+ *
+ * @mr: the memory region to observe
+ */
+void memory_region_iommu_replay_all(MemoryRegion *mr);
+
+/**
  * memory_region_unregister_iommu_notifier: unregister a notifier for
  * changes to IOMMU translation entries.
  *
diff --git a/memory.c b/memory.c
index f73c897..62ca6e0 100644
--- a/memory.c
+++ b/memory.c
@@ -1641,6 +1641,15 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
     }
 }
 
+void memory_region_iommu_replay_all(MemoryRegion *mr)
+{
+    IOMMUNotifier *notifier;
+
+    QLIST_FOREACH(notifier, &mr->iommu_notify, node) {
+        memory_region_iommu_replay(mr, notifier, false);
+    }
+}
+
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
                                              IOMMUNotifier *n)
 {
-- 
2.7.4
