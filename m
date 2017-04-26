Received: from eggs.gnu.org ([2001:4830:134:3::10]:50595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7g-00037C-F4
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7e-0002a8-VZ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:30840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K7e-0002Z6-Lp
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:34 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:44 +0800
Message-Id: <1493201210-14357-15-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 14/20] intel_iommu: add
 FOR_EACH_ASSIGN_DEVICE macro
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

Add FOR_EACH_ASSIGN_DEVICE. It would be used to loop all assigned
devices when processing guest pasid table linking and iommu cache
invalidate propagation.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c          | 32 ++++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h | 11 +++++++++++
 2 files changed, 43 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0c412d2..f291995 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -55,6 +55,38 @@ static int vtd_dbgflags = VTD_DBGBIT(GENERAL) | VTD_DBGBIT(CSR);
 #define VTD_DPRINTF(what, fmt, ...) do {} while (0)
 #endif
 
+#define FOR_EACH_ASSIGN_DEVICE(__notify_info_type, \
+                               __opaque_type, \
+                               __hook_info, \
+                               __hook_fn) \
+do { \
+    IntelIOMMUNotifierNode *node; \
+    VTDNotifierIterator iterator; \
+    int ret = 0; \
+    __notify_info_type *notify_info; \
+    __opaque_type *opaq; \
+    int argsz; \
+    argsz = sizeof(*notify_info) + sizeof(*opaq); \
+    notify_info = g_malloc0(argsz); \
+    QLIST_FOREACH(node, &(s->notifiers_list), next) { \
+        VTDAddressSpace *vtd_as = node->vtd_as; \
+        VTDContextEntry ce[2]; \
+        iterator.bus = pci_bus_num(vtd_as->bus); \
+        ret = vtd_dev_to_context_entry(s, iterator.bus, \
+                               vtd_as->devfn, &ce[0]); \
+        if (ret != 0) { \
+            continue; \
+        } \
+        iterator.sid = vtd_make_source_id(iterator.bus, vtd_as->devfn); \
+        iterator.did =  VTD_CONTEXT_ENTRY_DID(ce[0].hi); \
+        iterator.host_sid = node->host_sid; \
+        iterator.vtd_as = vtd_as; \
+        iterator.ce = &ce[0]; \
+        __hook_fn(&iterator, __hook_info, notify_info); \
+    } \
+    g_free(notify_info); \
+} while (0)
+
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
 {
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index f2a7d12..5178398 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -439,6 +439,17 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_EXT_CONTEXT_TT_NO_DEV_IOTLB   (4ULL << 2)
 #define VTD_EXT_CONTEXT_TT_DEV_IOTLB      (5ULL << 2)
 
+struct VTDNotifierIterator {
+    VTDAddressSpace *vtd_as;
+    VTDContextEntry *ce;
+    uint16_t host_sid;
+    uint16_t sid;
+    uint16_t did;
+    uint8_t  bus;
+};
+
+typedef struct VTDNotifierIterator VTDNotifierIterator;
+
 /* Paging Structure common */
 #define VTD_SL_PT_PAGE_SIZE_MASK    (1ULL << 7)
 /* Bits to decide the offset for each level */
-- 
1.9.1
