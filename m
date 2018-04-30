Received: from eggs.gnu.org ([2001:4830:134:3::10]:49548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDDOO-00033O-Af
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDDON-0007K0-Cv
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:19:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fDDON-0007Hg-57
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:19:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 19:19:03 +0100
Message-Id: <20180430181905.32327-10-peter.maydell@linaro.org>
In-Reply-To: <20180430181905.32327-1-peter.maydell@linaro.org>
References: <20180430181905.32327-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC PATCH 09/11] Make address_space_get_iotlb_entry()
 take a MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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
