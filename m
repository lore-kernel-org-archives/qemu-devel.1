Received: from eggs.gnu.org ([2001:4830:134:3::10]:49619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOQSD-00010v-A4
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOQSA-0004Qx-M6
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOQSA-0004Q9-GK
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:42 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jan 2017 15:52:34 +0100
Message-Id: <1483455154-8106-6-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
References: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] virtio-gpu: fix memory leak in resource
 attach backing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Li Qiang <liq3ea@gmail.com>

In the resource attach backing function, everytime it will
allocate 'res->iov' thus can leading a memory leak. This
patch avoid this.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Message-id: 1483003721-65360-1-git-send-email-liq3ea@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6a26258..ca88cf4 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -714,6 +714,11 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
         return;
     }
 
+    if (res->iov) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
+
     ret = virtio_gpu_create_mapping_iov(&ab, cmd, &res->addrs, &res->iov);
     if (ret != 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
-- 
1.8.3.1
