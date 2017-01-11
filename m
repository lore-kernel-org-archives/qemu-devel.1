Received: from eggs.gnu.org ([2001:4830:134:3::10]:33583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRG97-0001aA-UG
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRG97-0003Qf-0q
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRG96-0003QR-Qv
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:44 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 11:28:35 +0100
Message-Id: <1484130518-18873-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
References: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] virtio-gpu: Recalculate VirtIOGPU::hostmem
 on VM load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

The 'hostmem' field in VirtIOGPU is used to track the total memory
used in pixmaps so that we can impose a maximum limit on it.
However this field is neither migrated nor recalculated on
VM load, which means that after a migration it will be incorrectly
too low, which can allow the guest to use more pixmap memory
than it should. The per-resource hostmem fields are not filled
in either as we reallocate them in the load function.

Recalculate the memory used for each pixmap and the total memory
used as we reallocate the pixmaps in virtio_gpu_load().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1483969123-14839-2-git-send-email-peter.maydell@linaro.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ca88cf4..c3cf47e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1038,6 +1038,8 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size)
     uint32_t resource_id, pformat;
     int i;
 
+    g->hostmem = 0;
+
     resource_id = qemu_get_be32(f);
     while (resource_id != 0) {
         res = g_new0(struct virtio_gpu_simple_resource, 1);
@@ -1059,6 +1061,8 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size)
             return -EINVAL;
         }
 
+        res->hostmem = PIXMAN_FORMAT_BPP(pformat) * res->width * res->height;
+
         res->addrs = g_new(uint64_t, res->iov_cnt);
         res->iov = g_new(struct iovec, res->iov_cnt);
 
@@ -1081,6 +1085,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size)
         }
 
         QTAILQ_INSERT_HEAD(&g->reslist, res, next);
+        g->hostmem += res->hostmem;
 
         resource_id = qemu_get_be32(f);
     }
-- 
1.8.3.1
