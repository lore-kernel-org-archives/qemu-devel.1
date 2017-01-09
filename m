Received: from eggs.gnu.org ([2001:4830:134:3::10]:38493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQaaa-0000IO-M8
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQaaZ-0002Qc-Ht
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:06:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQaaZ-0002QI-Ab
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:06:19 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 13:38:42 +0000
Message-Id: <1483969123-14839-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483969123-14839-1-git-send-email-peter.maydell@linaro.org>
References: <1483969123-14839-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] virtio-gpu: Recalculate VirtIOGPU::hostmem
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
Cc: patches@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

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
2.7.4
