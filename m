Received: from eggs.gnu.org ([2001:4830:134:3::10]:50500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcfU-0006mz-E0
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcfS-0001Hw-0w
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:08:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcfR-0001HP-RO
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:08:01 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DCFE8124D
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 17:08:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 18:07:52 +0100
Message-Id: <20170120170757.30308-3-pbonzini@redhat.com>
In-Reply-To: <20170120170757.30308-1-pbonzini@redhat.com>
References: <20170120170757.30308-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] virtio: add virtio_*_phys_cached
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
