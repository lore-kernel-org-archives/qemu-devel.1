Received: from eggs.gnu.org ([2001:4830:134:3::10]:50557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7W-0002yz-Ec
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7V-0002X1-4o
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:25915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K7U-0002V7-Qc
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:25 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:42 +0800
Message-Id: <1493201210-14357-13-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 12/20] Memory: Add func to fire pasidt_bind
 notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

Add a separate function to fire pasid table bind notifier. In future
there may be more pasid bind type with different granularity. e.g.
binding pasid entry instead of binding pasid table. It can be supported
by adding bind_type, check bind_type in fire func and trigger correct
notifier.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 include/exec/memory.h | 11 +++++++++++
 memory.c              | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 49087ef..3b8f487 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -695,6 +695,17 @@ uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr);
 void memory_region_notify_iommu(MemoryRegion *mr,
                                 IOMMUTLBEntry entry);
 
+/*
+ * memory_region_notify_iommu_svm_bind notify SVM bind
+ * request from vIOMMU emulator.
+ *
+ * @mr: the memory region of IOMMU
+ * @data: IOMMU SVM data
+ */
+void memory_region_notify_iommu_svm_bind(MemoryRegion *mr,
+                                         void *data);
+
+
 /**
  * memory_region_notify_one: notify a change in an IOMMU translation
  *                           entry to a single notifier
diff --git a/memory.c b/memory.c
index 45ef069..ce0b0ff 100644
--- a/memory.c
+++ b/memory.c
@@ -1729,6 +1729,27 @@ void memory_region_notify_iommu(MemoryRegion *mr,
     }
 }
 
+void memory_region_notify_iommu_svm_bind(MemoryRegion *mr,
+                                         void *data)
+{
+    IOMMUNotifier *iommu_notifier;
+    IOMMUNotifierFlag request_flags;
+
+    assert(memory_region_is_iommu(mr));
+
+    /*TODO: support other bind requests with smaller gran,
+     * e.g. bind signle pasid entry
+     */
+    request_flags = IOMMU_NOTIFIER_SVM_PASIDT_BIND;
+
+    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
+        if (iommu_notifier->notifier_flags & request_flags) {
+            iommu_notifier->notify(iommu_notifier, data);
+            break;
+        }
+    }
+}
+
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
 {
     uint8_t mask = 1 << client;
-- 
1.9.1
