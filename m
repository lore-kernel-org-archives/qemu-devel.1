Received: from eggs.gnu.org ([2001:4830:134:3::10]:33188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX8dY-0002O2-92
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX8dX-0007iv-4c
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:28 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:36192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX8dW-0007iJ-Tv
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:27 -0500
Received: by mail-wj0-x243.google.com with SMTP id kq3so6230164wjc.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 07:40:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 16:40:13 +0100
Message-Id: <1485531620-121182-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
References: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/9] virtio: add virtio_*_phys_cached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/virtio/virtio-access.h | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 91ae14d..2e92074 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -156,6 +156,58 @@ static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
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
