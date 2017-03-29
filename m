Received: from eggs.gnu.org ([2001:4830:134:3::10]:36993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct6qu-0004De-Vy
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 02:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct6qq-00043W-V2
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 02:13:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ct6qq-00043O-Mw
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 02:13:00 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Mar 2017 14:12:50 +0800
Message-Id: <1490767970-23689-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH] exec: don't return int64_t in
 address_space_cache_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, mst@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

We return int64_t as the length of region cache but accept hwaddr as
the required length. This is wrong and may confuse the caller since
the it can lead comparison between signed and unsigned types. The
caller can not catch the failure in this case. Fixing this by
returning hwaddr and return zero on failure.

Fixes: 5eba0404b9829 ("virtio: use MemoryRegionCache to access descriptors")
Fixes: e45da65322386 ("virtio: validate address space cache during init")
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 exec.c                | 12 ++++++------
 hw/virtio/virtio.c    |  7 +++----
 include/exec/memory.h | 13 ++++++-------
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/exec.c b/exec.c
index e57a8a2..9b71174 100644
--- a/exec.c
+++ b/exec.c
@@ -3230,11 +3230,11 @@ void cpu_physical_memory_unmap(void *buffer, hwaddr len,
 #define RCU_READ_UNLOCK(...)     rcu_read_unlock()
 #include "memory_ldst.inc.c"
 
-int64_t address_space_cache_init(MemoryRegionCache *cache,
-                                 AddressSpace *as,
-                                 hwaddr addr,
-                                 hwaddr len,
-                                 bool is_write)
+hwaddr address_space_cache_init(MemoryRegionCache *cache,
+                                AddressSpace *as,
+                                hwaddr addr,
+                                hwaddr len,
+                                bool is_write)
 {
     hwaddr l, xlat;
     MemoryRegion *mr;
@@ -3245,7 +3245,7 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
     l = len;
     mr = address_space_translate(as, addr, &xlat, &l, is_write);
     if (!memory_access_is_direct(mr, is_write)) {
-        return -EINVAL;
+        return 0;
     }
 
     l = address_space_extend_translation(as, addr, len, mr, xlat, l, is_write);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 03592c5..3482be2 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -129,9 +129,8 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     VirtQueue *vq = &vdev->vq[n];
     VRingMemoryRegionCaches *old = vq->vring.caches;
     VRingMemoryRegionCaches *new;
-    hwaddr addr, size;
+    hwaddr addr, size, len;
     int event_size;
-    int64_t len;
 
     event_size = virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 
@@ -586,7 +585,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     unsigned int total_bufs, in_total, out_total;
     VRingMemoryRegionCaches *caches;
     MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
-    int64_t len = 0;
+    hwaddr len = 0;
     int rc;
 
     if (unlikely(!vq->vring.desc)) {
@@ -831,7 +830,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     VRingMemoryRegionCaches *caches;
     MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
     MemoryRegionCache *desc_cache;
-    int64_t len;
+    hwaddr len;
     VirtIODevice *vdev = vq->vdev;
     VirtQueueElement *elem = NULL;
     unsigned out_num, in_num;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e39256a..932dd00 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1444,8 +1444,7 @@ struct MemoryRegionCache {
  * @is_write: indicates the transfer direction
  *
  * Will only work with RAM, and may map a subset of the requested range by
- * returning a value that is less than @len.  On failure, return a negative
- * errno value.
+ * returning a value that is less than @len.  On failure, return zero.
  *
  * Because it only works with RAM, this function can be used for
  * read-modify-write operations.  In this case, is_write should be %true.
@@ -1453,11 +1452,11 @@ struct MemoryRegionCache {
  * Note that addresses passed to the address_space_*_cached functions
  * are relative to @addr.
  */
-int64_t address_space_cache_init(MemoryRegionCache *cache,
-                                 AddressSpace *as,
-                                 hwaddr addr,
-                                 hwaddr len,
-                                 bool is_write);
+hwaddr address_space_cache_init(MemoryRegionCache *cache,
+                                AddressSpace *as,
+                                hwaddr addr,
+                                hwaddr len,
+                                bool is_write);
 
 /**
  * address_space_cache_invalidate: complete a write to a #MemoryRegionCache
-- 
2.7.4
