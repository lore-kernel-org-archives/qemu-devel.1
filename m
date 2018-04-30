Received: from eggs.gnu.org ([2001:4830:134:3::10]:46946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fD7qr-0002ki-1j
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fD7qp-0002qP-KU
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:24:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fD7qp-0002hq-CF
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:24:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 13:24:04 +0100
Message-Id: <20180430122404.10741-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] memory.h: Improve IOMMU related documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

Add more detail to the documentation for memory_region_init_iommu()
and other IOMMU-related functions and data structures.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I've been trying to understand how the IOMMU support works,
with a vague idea of extending it to be able to use it to
implement the Arm TrustZone Memory Protection Controller (which
is a bit of bus fabric that can configurably allow or deny
NonSecure access to RAM that sits behind it). I found the API
documentation comments a bit brief, so I thought I'd start by
expanding them as I figured out how the bits fit together.
Please check for inaccuracies :-)

I haven't documented the 'replay' method because I don't understand
that bit.

 include/exec/memory.h | 66 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4402ba6c0d..e62965a0c8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -194,6 +194,14 @@ enum IOMMUMemoryRegionAttr {
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
@@ -203,20 +211,58 @@ typedef struct IOMMUMemoryRegionClass {
      * be the access permission of this translation operation. We can
      * set flag to IOMMU_NONE to mean that we don't need any
      * read/write permission checks, like, when for region replay.
+     *
+     * Once the IOMMU has returned a TLB entry, it must notify
+     * the IOMMU's users if that TLB entry changes, using
+     * memory_region_notify_iommu() (or, if necessary, by calling
+     * memory_region_notify_one() for each registered notifier).
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
+    /* Set this up to provide customized IOMMU replay function.
+     * Optional method.
+     */
     void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
 
-    /* Get IOMMU misc attributes */
-    int (*get_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionAttr,
+    /* Get IOMMU misc attributes. This is an optional method that
+     * can be used to allow users of the IOMMU to get implementation-specific
+     * information. The IOMMU implements this method to handle calls
+     * by IOMMU users to memory_region_iommu_get_attr() by filling in
+     * the arbitrary data pointer for any IOMMUMemoryRegionAttr valuess that
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
 
@@ -705,6 +751,14 @@ static inline void memory_region_init_reservation(MemoryRegion *mr,
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
@@ -981,7 +1035,7 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
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
