Received: from eggs.gnu.org ([2001:4830:134:3::10]:32919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfl-0001xm-Fz
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfk-0006Ru-C3
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:53 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfk-0006RO-3o
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:52 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfj-0003ro-54
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:51 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:17 +0100
Message-Id: <20180615142521.19143-40-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 39/43] iommu: Add IOMMU index concept to IOMMU
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If an IOMMU supports mappings that care about the memory
transaction attributes, then it no longer has a unique
address -> output mapping, but more than one. We can
represent these using an IOMMU index, analogous to TCG's
mmu indexes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180604152941.20374-2-peter.maydell@linaro.org
---
 include/exec/memory.h | 55 +++++++++++++++++++++++++++++++++++++++++++
 memory.c              | 23 ++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index eb2ba065195..fa6e98ee7be 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -206,6 +206,20 @@ enum IOMMUMemoryRegionAttr {
  * to report whenever mappings are changed, by calling
  * memory_region_notify_iommu() (or, if necessary, by calling
  * memory_region_notify_one() for each registered notifier).
+ *
+ * Conceptually an IOMMU provides a mapping from input address
+ * to an output TLB entry. If the IOMMU is aware of memory transaction
+ * attributes and the output TLB entry depends on the transaction
+ * attributes, we represent this using IOMMU indexes. Each index
+ * selects a particular translation table that the IOMMU has:
+ *   @attrs_to_index returns the IOMMU index for a set of transaction attributes
+ *   @translate takes an input address and an IOMMU index
+ * and the mapping returned can only depend on the input address and the
+ * IOMMU index.
+ *
+ * Most IOMMUs don't care about the transaction attributes and support
+ * only a single IOMMU index. A more complex IOMMU might have one index
+ * for secure transactions and one for non-secure transactions.
  */
 typedef struct IOMMUMemoryRegionClass {
     /* private */
@@ -290,6 +304,29 @@ typedef struct IOMMUMemoryRegionClass {
      */
     int (*get_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionAttr attr,
                     void *data);
+
+    /* Return the IOMMU index to use for a given set of transaction attributes.
+     *
+     * Optional method: if an IOMMU only supports a single IOMMU index then
+     * the default implementation of memory_region_iommu_attrs_to_index()
+     * will return 0.
+     *
+     * The indexes supported by an IOMMU must be contiguous, starting at 0.
+     *
+     * @iommu: the IOMMUMemoryRegion
+     * @attrs: memory transaction attributes
+     */
+    int (*attrs_to_index)(IOMMUMemoryRegion *iommu, MemTxAttrs attrs);
+
+    /* Return the number of IOMMU indexes this IOMMU supports.
+     *
+     * Optional method: if this method is not provided, then
+     * memory_region_iommu_num_indexes() will return 1, indicating that
+     * only a single IOMMU index is supported.
+     *
+     * @iommu: the IOMMUMemoryRegion
+     */
+    int (*num_indexes)(IOMMUMemoryRegion *iommu);
 } IOMMUMemoryRegionClass;
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -1054,6 +1091,24 @@ int memory_region_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
                                  enum IOMMUMemoryRegionAttr attr,
                                  void *data);
 
+/**
+ * memory_region_iommu_attrs_to_index: return the IOMMU index to
+ * use for translations with the given memory transaction attributes.
+ *
+ * @iommu_mr: the memory region
+ * @attrs: the memory transaction attributes
+ */
+int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
+                                       MemTxAttrs attrs);
+
+/**
+ * memory_region_iommu_num_indexes: return the total number of IOMMU
+ * indexes that this IOMMU supports.
+ *
+ * @iommu_mr: the memory region
+ */
+int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
+
 /**
  * memory_region_name: get a memory region's name
  *
diff --git a/memory.c b/memory.c
index 3212acc7f49..64f4a55d546 100644
--- a/memory.c
+++ b/memory.c
@@ -1915,6 +1915,29 @@ int memory_region_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
     return imrc->get_attr(iommu_mr, attr, data);
 }
 
+int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
+                                       MemTxAttrs attrs)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+
+    if (!imrc->attrs_to_index) {
+        return 0;
+    }
+
+    return imrc->attrs_to_index(iommu_mr, attrs);
+}
+
+int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+
+    if (!imrc->num_indexes) {
+        return 1;
+    }
+
+    return imrc->num_indexes(iommu_mr);
+}
+
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
 {
     uint8_t mask = 1 << client;
-- 
2.17.1
