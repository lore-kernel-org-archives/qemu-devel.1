Received: from eggs.gnu.org ([2001:4830:134:3::10]:48519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cMX12-00033I-I9
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 04:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cMX0z-0006uZ-DG
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 04:28:52 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:34118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cMX0z-0006uV-98
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 04:28:49 -0500
Received: by mail-io0-x243.google.com with SMTP id n85so18968111ioi.1
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 01:28:49 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 29 Dec 2016 04:28:41 -0500
Message-Id: <1483003721-65360-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] virtio-gpu: fix memory leak in resource attach
 backing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: liqiang6-s@360.cn, Li Qiang <liq3ea@gmail.com>

In the resource attach backing function, everytime it will
allocate 'res->iov' thus can leading a memory leak. This
patch avoid this.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/display/virtio-gpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5f32e1a..045f296 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -705,6 +705,11 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
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
