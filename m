Received: from eggs.gnu.org ([2001:4830:134:3::10]:44328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW5SF-0006D7-Oj
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW5SC-000093-Pt
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:27 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cW5SC-00008w-Jw
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:24 -0500
Received: by mail-wm0-x243.google.com with SMTP id r126so36415608wmr.3
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:04:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Jan 2017 19:04:14 +0100
Message-Id: <20170124180420.12430-3-pbonzini@redhat.com>
In-Reply-To: <20170124180420.12430-1-pbonzini@redhat.com>
References: <20170124180420.12430-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/8] virtio: add virtio_*_phys_cached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com

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
2.9.3
