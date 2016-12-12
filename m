Received: from eggs.gnu.org ([2001:4830:134:3::10]:39294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdT-0004dD-R4
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdS-0000Rx-Ek
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cGOdS-0000R9-6j
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:10 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Dec 2016 12:18:52 +0100
Message-Id: <20161212111857.23399-7-pbonzini@redhat.com>
In-Reply-To: <20161212111857.23399-1-pbonzini@redhat.com>
References: <20161212111857.23399-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/11] virtio: add virtio_*_phys_cached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/virtio/virtio-access.h | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 440b455..0771ca0 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -145,6 +145,58 @@ static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
 #endif
 }
 
+static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
+                                               MemoryRegionCache *cache,
+                                               hwaddr pa)
+{
+    if (virtio_access_is_big_endian(vdev)) {
+        return lduw_be_phys_cached(cache, pa);
+    }
+    return lduw_le_phys_cached(cache, pa);
+}
+
+static inline uint32_t virtio_ldl_phys_cached(VirtIODevice *vdev,
+                                              MemoryRegionCache *cache,
+                                              hwaddr pa)
+{
+    if (virtio_access_is_big_endian(vdev)) {
+        return ldl_be_phys_cached(cache, pa);
+    }
+    return ldl_le_phys_cached(cache, pa);
+}
+
+static inline uint64_t virtio_ldq_phys_cached(VirtIODevice *vdev,
+                                              MemoryRegionCache *cache,
+                                              hwaddr pa)
+{
+    if (virtio_access_is_big_endian(vdev)) {
+        return ldq_be_phys_cached(cache, pa);
+    }
+    return ldq_le_phys_cached(cache, pa);
+}
+
+static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
+                                          MemoryRegionCache *cache,
+                                          hwaddr pa, uint16_t value)
+{
+    if (virtio_access_is_big_endian(vdev)) {
+        stw_be_phys_cached(cache, pa, value);
+    } else {
+        stw_le_phys_cached(cache, pa, value);
+    }
+}
+
+static inline void virtio_stl_phys_cached(VirtIODevice *vdev,
+                                          MemoryRegionCache *cache,
+                                          hwaddr pa, uint32_t value)
+{
+    if (virtio_access_is_big_endian(vdev)) {
+        stl_be_phys_cached(cache, pa, value);
+    } else {
+        stl_le_phys_cached(cache, pa, value);
+    }
+}
+
 static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
 {
     *s = virtio_tswap16(vdev, *s);
-- 
1.8.3.1
