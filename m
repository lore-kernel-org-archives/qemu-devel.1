Received: from eggs.gnu.org ([2001:4830:134:3::10]:47558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fpt-0003x3-CN
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fps-0004Np-44
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3fpr-0004MV-Rl
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:40 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 27 Apr 2017 17:34:18 +0800
Message-Id: <1493285660-4470-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1493285660-4470-1-git-send-email-peterx@redhat.com>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 6/8] memory: introduce AddressSpaceOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

This is something similar to MemoryRegionOps, it's just for address
spaces to store arch-specific hooks.

The first hook I would like to introduce is iommu_get().

For systems that have IOMMUs, we will create a special address space per
device which is different from system default address space for
it (please refer to pci_device_iommu_address_space()). Normally when
that happens, there will be one specific IOMMU (or say, translation
unit) stands right behind that new address space.

This iommu_get() fetches that guy behind the address space. Here, the
guy is defined as IOMMUObject, which is currently a (void *). In the
future, maybe we can make it a better definition, but imho it's good
enough for now, considering it's arch-dependent.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 30 ++++++++++++++++++++++++++++++
 memory.c              |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e5707b3..0b0b58b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -183,6 +183,15 @@ struct MemoryRegionOps {
     const MemoryRegionMmio old_mmio;
 };
 
+/*
+ * This stands for an IOMMU unit. Normally it should be exactly the
+ * IOMMU device, however this can also be actually anything which is
+ * related to that translation unit. What it is should be totally
+ * arch-dependent. Maybe one day we can have something better than a
+ * (void *) here.
+ */
+typedef void *IOMMUObject;
+
 typedef struct MemoryRegionIOMMUOps MemoryRegionIOMMUOps;
 
 struct MemoryRegionIOMMUOps {
@@ -282,6 +291,19 @@ struct MemoryListener {
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
@@ -302,6 +324,7 @@ struct AddressSpace {
     MemoryListener dispatch_listener;
     QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
+    AddressSpaceOps as_ops;
 };
 
 /**
@@ -1800,6 +1823,13 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
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
index 6af523e..6aaad45 100644
--- a/memory.c
+++ b/memory.c
@@ -2500,6 +2500,14 @@ void address_space_destroy(AddressSpace *as)
     call_rcu(as, do_address_space_destroy, rcu);
 }
 
+IOMMUObject *address_space_iommu_get(AddressSpace *as)
+{
+    if (!as->as_ops.iommu_get) {
+        return NULL;
+    }
+    return as->as_ops.iommu_get(as);
+}
+
 static const char *memory_region_type(MemoryRegion *mr)
 {
     if (memory_region_is_ram_device(mr)) {
-- 
2.7.4
