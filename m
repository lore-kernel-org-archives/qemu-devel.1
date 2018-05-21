Received: from eggs.gnu.org ([2001:4830:134:3::10]:42709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQI-0002pp-6u
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQG-0000zd-OP
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:26 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 15:03:46 +0100
Message-Id: <20180521140402.23318-12-peter.maydell@linaro.org>
In-Reply-To: <20180521140402.23318-1-peter.maydell@linaro.org>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 11/27] Make address_space_get_iotlb_entry()
 take a MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to address_space_get_iotlb_entry().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h | 2 +-
 exec.c                | 2 +-
 hw/virtio/vhost.c     | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3980ab47ed..309fdfb89b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1896,7 +1896,7 @@ void address_space_cache_destroy(MemoryRegionCache *cache);
  * entry. Should be called from an RCU critical section.
  */
 IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
-                                            bool is_write);
+                                            bool is_write, MemTxAttrs attrs);
 
 /* address_space_translate: translate an address range into an address space
  * into a MemoryRegion and an address range into that section.  Should be
diff --git a/exec.c b/exec.c
index b818ba87f4..84f2c21ecb 100644
--- a/exec.c
+++ b/exec.c
@@ -582,7 +582,7 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
 
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
