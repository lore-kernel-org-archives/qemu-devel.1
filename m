Received: from eggs.gnu.org ([2001:4830:134:3::10]:55441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuzTF-0000j5-ST
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuzTC-0005BH-00
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:21:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuzTB-00058g-OR
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA8E440241CB
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 12:21:05 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 29 Aug 2018 14:21:01 +0200
Message-Id: <20180829122101.29852-3-kraxel@redhat.com>
In-Reply-To: <20180829122101.29852-1-kraxel@redhat.com>
References: <20180829122101.29852-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] virtio-gpu: add iommu support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Switch from cpu_physical_memory_map to dma_memory_map,
so iommu mappings for virtio-gpu objects work properly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 76e3542bf8..a564b3f3a3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -17,6 +17,7 @@
 #include "qemu/iov.h"
 #include "ui/console.h"
 #include "trace.h"
+#include "sysemu/dma.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-bus.h"
@@ -731,7 +732,8 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
         uint32_t l = le32_to_cpu(ents[i].length);
         hwaddr len = l;
         (*iov)[i].iov_len = l;
-        (*iov)[i].iov_base = cpu_physical_memory_map(a, &len, 1);
+        (*iov)[i].iov_base = dma_memory_map(VIRTIO_DEVICE(g)->dma_as,
+                                            a, &len, DMA_DIRECTION_TO_DEVICE);
         if (addr) {
             (*addr)[i] = a;
         }
@@ -759,8 +761,10 @@ void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
     int i;
 
     for (i = 0; i < count; i++) {
-        cpu_physical_memory_unmap(iov[i].iov_base, iov[i].iov_len, 1,
-                                  iov[i].iov_len);
+        dma_memory_unmap(VIRTIO_DEVICE(g)->dma_as,
+                         iov[i].iov_base, iov[i].iov_len,
+                         DMA_DIRECTION_TO_DEVICE,
+                         iov[i].iov_len);
     }
     g_free(iov);
 }
@@ -1152,13 +1156,17 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
         for (i = 0; i < res->iov_cnt; i++) {
             hwaddr len = res->iov[i].iov_len;
             res->iov[i].iov_base =
-                cpu_physical_memory_map(res->addrs[i], &len, 1);
+                dma_memory_map(VIRTIO_DEVICE(g)->dma_as,
+                               res->addrs[i], &len, DMA_DIRECTION_TO_DEVICE);
 
             if (!res->iov[i].iov_base || len != res->iov[i].iov_len) {
                 /* Clean up the half-a-mapping we just created... */
                 if (res->iov[i].iov_base) {
-                    cpu_physical_memory_unmap(res->iov[i].iov_base,
-                                              len, 0, 0);
+                    dma_memory_unmap(VIRTIO_DEVICE(g)->dma_as,
+                                     res->iov[i].iov_base,
+                                     res->iov[i].iov_len,
+                                     DMA_DIRECTION_TO_DEVICE,
+                                     res->iov[i].iov_len);
                 }
                 /* ...and the mappings for previous loop iterations */
                 res->iov_cnt = i;
@@ -1210,11 +1218,6 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     Error *local_err = NULL;
     int i;
 
-    if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
-        error_setg(errp, "virtio-gpu does not support vIOMMU yet");
-        return;
-    }
-
     if (g->conf.max_outputs > VIRTIO_GPU_MAX_SCANOUTS) {
         error_setg(errp, "invalid max_outputs > %d", VIRTIO_GPU_MAX_SCANOUTS);
         return;
-- 
2.9.3
