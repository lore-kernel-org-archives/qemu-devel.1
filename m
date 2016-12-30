Received: from eggs.gnu.org ([2001:4830:134:3::10]:50953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu8V-0001Dz-3M
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu8T-0005ck-2c
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cMu8S-0005cP-RC
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:05 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Dec 2016 18:09:13 +0800
Message-Id: <1483092559-24488-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
References: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V4 04/10] exec: introduce
 address_space_get_iotlb_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, cornelia.huck@de.ibm.com, wexu@redhat.com, vkaplans@redhat.com, Jason Wang <jasowang@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

This patch introduces a helper to query the iotlb entry for a
possible iova. This will be used by later device IOTLB API to enable
the capability for a dataplane (e.g vhost) to query the IOTLB.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 exec.c                | 33 +++++++++++++++++++++++++++++++++
 include/exec/memory.h |  5 +++++
 2 files changed, 38 insertions(+)

diff --git a/exec.c b/exec.c
index 8d4bb0e..47835c1 100644
--- a/exec.c
+++ b/exec.c
@@ -449,6 +449,39 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
 }
 
 /* Called from RCU critical section */
+IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
+                                            bool is_write)
+{
+    IOMMUTLBEntry iotlb = {0};
+    MemoryRegionSection *section;
+    MemoryRegion *mr;
+
+    for (;;) {
+        AddressSpaceDispatch *d = atomic_rcu_read(&as->dispatch);
+        section = address_space_lookup_region(d, addr, false);
+        addr = addr - section->offset_within_address_space
+               + section->offset_within_region;
+        mr = section->mr;
+
+        if (!mr->iommu_ops) {
+            break;
+        }
+
+        iotlb = mr->iommu_ops->translate(mr, addr, is_write);
+        if (!(iotlb.perm & (1 << is_write))) {
+            iotlb.target_as = NULL;
+            break;
+        }
+
+        addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
+                | (addr & iotlb.addr_mask));
+        as = iotlb.target_as;
+    }
+
+    return iotlb;
+}
+
+/* Called from RCU critical section */
 MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
                                       hwaddr *xlat, hwaddr *plen,
                                       bool is_write)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 64560f6..358edfb 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1537,6 +1537,11 @@ void stl_le_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
 void stl_be_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint32_t val);
 void stq_le_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val);
 void stq_be_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val);
+/* address_space_get_iotlb_entry: translate an address into an IOTLB
+ * entry. Should be called from an RCU critical section.
+ */
+IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
+                                            bool is_write);
 
 /* address_space_translate: translate an address range into an address space
  * into a MemoryRegion and an address range into that section.  Should be
-- 
2.7.4
