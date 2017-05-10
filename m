Received: from eggs.gnu.org ([2001:4830:134:3::10]:57663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8Ma4-00068v-CK
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8Ma2-00016B-8x
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8Ma2-00015y-07
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:02:42 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 10 May 2017 16:01:47 +0800
Message-Id: <1494403315-12760-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1494403315-12760-1-git-send-email-peterx@redhat.com>
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/12] memory: fix
 address_space_get_iotlb_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This function has an assumption that we will definitely call translate()
once (or say, the addr will be located inside one IOMMU memory region),
otherwise an empty IOTLB will be returned. Nevertheless, this is not
what we want. When there is no IOMMU memory region, we should build up a
static mapping for the caller, instead of an invalid IOTLB.

We won't trigger this path before VT-d passthrough mode. When
passthrough mode for a vhost device is setup, VT-d is possible to
disable the IOMMU region for that device. Without current patch, we'll
get a vhost boot failure, and it'll be failed over to virtio userspace
mode.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 exec.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 072de5d..5cfdacd 100644
--- a/exec.c
+++ b/exec.c
@@ -463,12 +463,13 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
 }
 
 /* Called from RCU critical section */
-IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
+IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr iova,
                                             bool is_write)
 {
     IOMMUTLBEntry iotlb = {0};
     MemoryRegionSection *section;
     MemoryRegion *mr;
+    hwaddr addr = iova, psize;
 
     for (;;) {
         AddressSpaceDispatch *d = atomic_rcu_read(&as->dispatch);
@@ -478,6 +479,23 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
         mr = section->mr;
 
         if (!mr->iommu_ops) {
+            /*
+             * We didn't translate() but reached here. It possibly
+             * means it's a static mapping. If so (it should be RAM),
+             * we set the IOTLB up.
+             */
+            if (!iotlb.target_as && memory_region_is_ram(mr) &&
+                !memory_region_is_rom(mr)) {
+                psize = mr->ram_block->page_size;
+                iova &= ~(psize - 1);
+                iotlb = (IOMMUTLBEntry) {
+                    .target_as = &address_space_memory,
+                    .iova = iova,
+                    .translated_addr = iova,
+                    .addr_mask = psize - 1,
+                    .perm = IOMMU_RW,
+                };
+            }
             break;
         }
 
-- 
2.7.4
