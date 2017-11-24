Received: from eggs.gnu.org ([2001:4830:134:3::10]:48413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eI9zK-00043T-Tf
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eI9zG-0000Ge-DD
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:26004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eI9zG-00006q-4p
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:30 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Fri, 24 Nov 2017 16:52:37 +0800
Message-Id: <1511513560-28611-5-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1511513560-28611-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1511513560-28611-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 4/7] memory: introduce AddressSpaceOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, tianyu.lan@intel.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

From: Peter Xu <peterx@redhat.com>

This patch is going to introduce AddressSpaceOps which is to link an
AddressSpace to the IOMMU abstraction behind it.

The basic idea here is to associate an IOMMUObject with an AddressSpace.
This is still an open so far. Needs to have more inputs on it. Here is
my thoughts, and any other idea is welcomed.

For systems with IOMMU, the DMA isolation is introduced, the isolation
may be multiple DMA AddressSpaces or multiple DMA windows. Without IOMMU,
the DMA AddressSpace would be a single and shared address space across
the system. So if IOMMU exists, a DMA AddressSpace should always has an
IOMMU abstract behind it. This IOMMU abstract may mean the AddressSpace
is an individual isolation space or the AddressSpace is divided into
multiple DMA windows. So my thought is getting the IOMMU abstract by
AddressSpaceOps. And the IOMMU abstract is the new IOMMUObject introduced
in this patchset.

The first AddressSpaceOps added here is iommu_get(). Return an IOMMUObject
behind the AddressSpace.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 include/exec/memory.h | 22 ++++++++++++++++++++++
 memory.c              | 10 ++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 03595e3..8350973 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -26,6 +26,7 @@
 #include "qom/object.h"
 #include "qemu/rcu.h"
 #include "hw/qdev-core.h"
+#include "hw/core/iommu.h"
 
 #define RAM_ADDR_INVALID (~(ram_addr_t)0)
 
@@ -301,6 +302,19 @@ struct MemoryListener {
 };
 
 /**
+ * AddressSpaceOps: callbacks structure for address space specific operations
+ *
+ * @iommu_get: returns an IOMMU object that backs the address space.
+ *             Normally this should be NULL for generic address
+ *             spaces, and it's only used when there is one
+ *             translation unit behind this address space.
+ */
+struct AddressSpaceOps {
+    IOMMUObject *(*iommu_get)(AddressSpace *as);
+};
+typedef struct AddressSpaceOps AddressSpaceOps;
+
+/**
  * AddressSpace: describes a mapping of addresses to #MemoryRegion objects
  */
 struct AddressSpace {
@@ -316,6 +330,7 @@ struct AddressSpace {
     struct MemoryRegionIoeventfd *ioeventfds;
     QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
+    AddressSpaceOps as_ops;
 };
 
 FlatView *address_space_to_flatview(AddressSpace *as);
@@ -1988,6 +2003,13 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
     address_space_write(cache->as, cache->xlat + addr, MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
+/**
+ * address_space_iommu_get: Get the backend IOMMU for the address space
+ *
+ * @as: the address space to fetch IOMMU from
+ */
+IOMMUObject *address_space_iommu_get(AddressSpace *as);
+
 #endif
 
 #endif
diff --git a/memory.c b/memory.c
index 77fb3ef..307f665 100644
--- a/memory.c
+++ b/memory.c
@@ -235,8 +235,6 @@ struct FlatView {
     MemoryRegion *root;
 };
 
-typedef struct AddressSpaceOps AddressSpaceOps;
-
 #define FOR_EACH_FLAT_RANGE(var, view)          \
     for (var = (view)->ranges; var < (view)->ranges + (view)->nr; ++var)
 
@@ -2793,6 +2791,14 @@ static void do_address_space_destroy(AddressSpace *as)
     memory_region_unref(as->root);
 }
 
+IOMMUObject *address_space_iommu_get(AddressSpace *as)
+{
+    if (!as->as_ops.iommu_get) {
+        return NULL;
+    }
+    return as->as_ops.iommu_get(as);
+}
+
 void address_space_destroy(AddressSpace *as)
 {
     MemoryRegion *root = as->root;
-- 
1.9.1
