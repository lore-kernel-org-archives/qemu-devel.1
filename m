Received: from eggs.gnu.org ([2001:4830:134:3::10]:41914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cVCnX-0006pD-Ic
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 02:42:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cVCnS-0003cB-Pe
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 02:42:47 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:35920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cVCnS-0003be-KA
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 02:42:42 -0500
Received: by mail-io0-x242.google.com with SMTP id q20so12070524ioi.3
	for <qemu-devel@nongnu.org>; Sat, 21 Jan 2017 23:42:40 -0800 (PST)
Message-ID: <5884626f.5b2f6b0a.1bfff.3037@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 21 Jan 2017 23:42:33 -0800
Subject: [Qemu-devel] [PATCH] virtio-gpu: fix memory leak in set scanout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liqiang6-s@360.cn>

In virtio_gpu_set_scanout function, when creating the 'rect'
its refcount is set to 2, by pixman_image_create_bits and
qemu_create_displaysurface_pixman function. This can lead 
a memory leak issues. This patch avoid this issue.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/display/virtio-gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 7a15c61..4aecea3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -608,6 +608,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
             cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
             return;
         }
+        pixman_image_unref(rect);
         dpy_gfx_replace_surface(g->scanout[ss.scanout_id].con, scanout->ds);
     }
 
-- 
1.8.3.1
