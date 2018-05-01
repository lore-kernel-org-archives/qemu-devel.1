Received: from eggs.gnu.org ([2001:4830:134:3::10]:46185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDR8Z-0003aG-S0
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDR8Y-0007tc-SZ
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:51 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fDR8Y-0007sf-M7
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:50 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  1 May 2018 09:59:37 +0100
Message-Id: <20180501085939.6201-11-peter.maydell@linaro.org>
In-Reply-To: <20180501085939.6201-1-peter.maydell@linaro.org>
References: <20180501085939.6201-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC PATCH v2 10/12] Make
 address_space_get_iotlb_entry() take a MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to address_space_get_iotlb_entry().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h | 2 +-
 exec.c                | 2 +-
 hw/virtio/vhost.c     | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index bd50424804..16a82d9722 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1897,7 +1897,7 @@ void stq_be_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val);
  * entry. Should be called from an RCU critical section.
  */
 IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
-                                            bool is_write);
+                                            bool is_write, MemTxAttrs attrs);
 
 /* address_space_translate: translate an address range into an address space
  * into a MemoryRegion and an address range into that section.  Should be
diff --git a/exec.c b/exec.c
index 41f7a7f5c4..c29bf47ce2 100644
--- a/exec.c
+++ b/exec.c
@@ -547,7 +547,7 @@ translate_fail:
 
 /* Called from RCU critical section */
 IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
-                                            bool is_write)
+                                            bool is_write, MemTxAttrs attrs)
 {
     MemoryRegionSection section;
     hwaddr xlat, page_mask;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9d5850a7d7..48f4fd7cc9 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -895,7 +895,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
     rcu_read_lock();
 
     iotlb = address_space_get_iotlb_entry(dev->vdev->dma_as,
-                                          iova, write);
+                                          iova, write,
+                                          MEMTXATTRS_UNSPECIFIED);
     if (iotlb.target_as != NULL) {
         ret = vhost_memory_region_lookup(dev, iotlb.translated_addr,
                                          &uaddr, &len);
-- 
2.17.0
