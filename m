Received: from eggs.gnu.org ([2001:4830:134:3::10]:41702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUw-0000uh-Uo
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUw-0006Zo-3g
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUv-0006YQ-Ry
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:14 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUu-0002x3-Tm
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:52 +0100
Message-Id: <20180531142357.904-21-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/25] Make address_space_get_iotlb_entry() take
 a MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to address_space_get_iotlb_entry().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180521140402.23318-12-peter.maydell@linaro.org
---
 include/exec/memory.h | 2 +-
 exec.c                | 2 +-
 hw/virtio/vhost.c     | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 28a694970a..67ea7fe1ee 100644
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
index d54a56fefa..57c64c6c13 100644
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
index b08290036d..4565b69f83 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -897,7 +897,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
     trace_vhost_iotlb_miss(dev, 1);
 
     iotlb = address_space_get_iotlb_entry(dev->vdev->dma_as,
-                                          iova, write);
+                                          iova, write,
+                                          MEMTXATTRS_UNSPECIFIED);
     if (iotlb.target_as != NULL) {
         ret = vhost_memory_region_lookup(dev, iotlb.translated_addr,
                                          &uaddr, &len);
-- 
2.17.1
