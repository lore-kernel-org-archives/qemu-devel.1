Received: from eggs.gnu.org ([2001:4830:134:3::10]:59686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZZ9t-0006Yy-7B
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZZ9s-0004oL-D3
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:23:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cZZ9s-0004o1-7G
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:23:52 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  3 Feb 2017 16:22:38 +0800
Message-Id: <1486110164-13797-13-git-send-email-peterx@redhat.com>
In-Reply-To: <1486110164-13797-1-git-send-email-peterx@redhat.com>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 12/18] memory: provide iommu_replay_all()
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

This is an "global" version of exising memory_region_iommu_replay() - we
announce the translations to all the registered notifiers, instead of a
specific one.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 8 ++++++++
 memory.c              | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index f76e174..606ce88 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -707,6 +707,14 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
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
index 523c43f..9e1bb75 100644
--- a/memory.c
+++ b/memory.c
@@ -1646,6 +1646,15 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
     }
 }
 
+void memory_region_iommu_replay_all(MemoryRegion *mr)
+{
+    IOMMUNotifier *notifier;
+
+    IOMMU_NOTIFIER_FOREACH(notifier, mr) {
+        memory_region_iommu_replay(mr, notifier, false);
+    }
+}
+
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
                                              IOMMUNotifier *n)
 {
-- 
2.7.4
