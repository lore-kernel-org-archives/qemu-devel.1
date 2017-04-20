Received: from eggs.gnu.org ([2001:4830:134:3::10]:47030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H7E-0001g9-KJ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H7A-0004P7-Pe
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:47:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d1H7A-0004Om-JC
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:47:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 20 Apr 2017 15:46:53 -0300
Message-Id: <20170420184705.25018-4-ehabkost@redhat.com>
In-Reply-To: <20170420184705.25018-1-ehabkost@redhat.com>
References: <20170420184705.25018-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 03/15] memory: provide iommu_replay_all()
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

This is an "global" version of existing memory_region_iommu_replay() -
we announce the translations to all the registered notifiers, instead of
a specific one.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: \"Michael S. Tsirkin\" <mst@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1491562755-23867-4-git-send-email-peterx@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/exec/memory.h | 8 ++++++++
 memory.c              | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 07e43daf20..fb7dff3405 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -713,6 +713,14 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
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
index 7496b3d3d5..b4ed67b27a 100644
--- a/memory.c
+++ b/memory.c
@@ -1642,6 +1642,15 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
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
2.11.0.259.g40922b1
