Received: from eggs.gnu.org ([2001:4830:134:3::10]:60638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDSNN-0007RJ-Vz
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDSNM-000615-93
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:19:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fDSNL-00060p-VB
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:19:12 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  1 May 2018 11:19:07 +0100
Message-Id: <20180501101907.22638-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/1] memory.h: Improve IOMMU related
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

Add more detail to the documentation for memory_region_init_iommu()
and other IOMMU-related functions and data structures.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1 -> v2 changes:
 * documented replay method
 * added note about wanting RCU or big qemu lock while calling
   translate

 include/exec/memory.h | 96 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 9 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4402ba6c0d..997598c664 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -194,29 +194,95 @@ enum IOMMUMemoryRegionAttr {
     IOMMU_ATTR_SPAPR_TCE_FD
 };
 
+/**
+ * IOMMUMemoryRegionClass:
+ *
+ * All IOMMU implementations need to subclass TYPE_IOMMU_MEMORY_REGION
+ * and provide implementations of at least some of the methods here
+ * to handle requests to the memory region. The minimum requirement
+ * is a @translate method.
+ */
 typedef struct IOMMUMemoryRegionClass {
     /* private */
     struct DeviceClass parent_class;
 
     /*
      * Return a TLB entry that contains a given address. Flag should
-     * be the access permission of this translation operation. We can
-     * set flag to IOMMU_NONE to mean that we don't need any
-     * read/write permission checks, like, when for region replay.
+     * be the access permission of this translation operation. The
+     * flag may be set to IOMMU_NONE to mean that we don't need any
+     * read/write permission checks; this is used by the default
+     * implementation of memory_region_iommu_replay(). (See the documentation
+     * of the replay method below for more details.)
+     *
+     * Once the IOMMU has returned a TLB entry, it must notify
+     * the IOMMU's users if that TLB entry changes, using
+     * memory_region_notify_iommu() (or, if necessary, by calling
+     * memory_region_notify_one() for each registered notifier).
+     *
+     * The returned information remains valid while the caller is
+     * holding the big QEMU lock or is inside an RCU critical section;
+     * if the caller wishes to cache the mapping beyond that it must
+     * register an IOMMU notifier so it can invalidate its cached
+     * information when the IOMMU mapping changes..
+     *
+     * @iommu: the IOMMUMemoryRegion
+     * @hwaddr: address to be translated within the memory region
+     * @flag: requested access permissions
      */
     IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
                                IOMMUAccessFlags flag);
-    /* Returns minimum supported page size */
+    /* Returns minimum supported page size in bytes.
+     * If this method is not provided then the minimum is assumed to
+     * be TARGET_PAGE_SIZE.
+     *
+     * @iommu: the IOMMUMemoryRegion
+     */
     uint64_t (*get_min_page_size)(IOMMUMemoryRegion *iommu);
-    /* Called when IOMMU Notifier flag changed */
+    /* Called when IOMMU Notifier flag changes (ie when the set of
+     * events which IOMMU users are requesting notification for changes).
+     * Optional method -- need not be provided if the IOMMU does not
+     * need to know exactly which events must be notified.
+     *
+     * @iommu: the IOMMUMemoryRegion
+     * @old_flags: events which previously needed to be notified
+     * @new_flags: events which now need to be notified
+     */
     void (*notify_flag_changed)(IOMMUMemoryRegion *iommu,
                                 IOMMUNotifierFlag old_flags,
                                 IOMMUNotifierFlag new_flags);
-    /* Set this up to provide customized IOMMU replay function */
+    /* Called to handle memory_region_iommu_replay().
+     *
+     * The default implementation of memory_region_iommu_replay() is to
+     * call the IOMMU translate method for every page in the address space
+     * with flag == IOMMU_NONE and then call the notifier if translate
+     * returns valid mapping. If this method is implemented then it
+     * overrides the default behaviour, and must provide the full semantics
+     * of memory_region_iommu_replay(), by calling @notifier for every
+     * translation present in the IOMMU.
+     *
+     * Optional method -- an IOMMU only needs to provide this method
+     * if the default is inefficient or produces undesirable side effects.
+     *
+     * Note: this is not related to record-and-replay functionality.
+     */
     void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
 
-    /* Get IOMMU misc attributes */
-    int (*get_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionAttr,
+    /* Get IOMMU misc attributes. This is an optional method that
+     * can be used to allow users of the IOMMU to get implementation-specific
+     * information. The IOMMU implements this method to handle calls
+     * by IOMMU users to memory_region_iommu_get_attr() by filling in
+     * the arbitrary data pointer for any IOMMUMemoryRegionAttr values that
+     * the IOMMU supports. If the method is unimplemented then
+     * memory_region_iommu_get_attr() will always return -EINVAL.
+     *
+     * @iommu: the IOMMUMemoryRegion
+     * @attr: attribute being queried
+     * @data: memory to fill in with the attribute data
+     *
+     * Returns 0 on success, or a negative errno; in particular
+     * returns -EINVAL for unrecognized or unimplemented attribute types.
+     */
+    int (*get_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionAttr attr,
                     void *data);
 } IOMMUMemoryRegionClass;
 
@@ -705,6 +771,14 @@ static inline void memory_region_init_reservation(MemoryRegion *mr,
  * An IOMMU region translates addresses and forwards accesses to a target
  * memory region.
  *
+ * The IOMMU implementation must define a subclass of TYPE_IOMMU_MEMORY_REGION.
+ * @_iommu_mr should be a pointer to enough memory for an instance of
+ * that subclass, @instance_size is the size of that subclass, and
+ * @mrtypename is its name. This function will initialize @_iommu_mr as an
+ * instance of the subclass, and its methods will then be called to handle
+ * accesses to the memory region. See the documentation of
+ * #IOMMUMemoryRegionClass for further details.
+ *
  * @_iommu_mr: the #IOMMUMemoryRegion to be initialized
  * @instance_size: the IOMMUMemoryRegion subclass instance size
  * @mrtypename: the type name of the #IOMMUMemoryRegion
@@ -953,6 +1027,8 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
  * a notifier with the minimum page granularity returned by
  * mr->iommu_ops->get_page_size().
  *
+ * Note: this is not related to record-and-replay functionality.
+ *
  * @iommu_mr: the memory region to observe
  * @n: the notifier to which to replay iommu mappings
  */
@@ -962,6 +1038,8 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n);
  * memory_region_iommu_replay_all: replay existing IOMMU translations
  * to all the notifiers registered.
  *
+ * Note: this is not related to record-and-replay functionality.
+ *
  * @iommu_mr: the memory region to observe
  */
 void memory_region_iommu_replay_all(IOMMUMemoryRegion *iommu_mr);
@@ -981,7 +1059,7 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
  * memory_region_iommu_get_attr: return an IOMMU attr if get_attr() is
  * defined on the IOMMU.
  *
- * Returns 0 if succeded, error code otherwise.
+ * Returns 0 on success, or a negative errno otherwise.
  *
  * @iommu_mr: the memory region
  * @attr: the requested attribute
-- 
2.17.0
