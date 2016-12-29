Received: from eggs.gnu.org ([2001:4830:134:3::10]:34606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cMVoJ-0000Yb-Sv
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cMVoG-0001k8-Qo
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:11:39 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:35765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cMVoG-0001j3-NI
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:11:36 -0500
Received: by mail-it0-x241.google.com with SMTP id b123so38394022itb.2
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 00:11:35 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 29 Dec 2016 03:11:26 -0500
Message-Id: <1482999086-59795-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] virtio-gpu-3d: fix memory leak in resource
 attach backing
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

If the virgl_renderer_resource_attach_iov function fails the
'res_iovs' will be leaked. Add check of the return value to
free the 'res_iovs' when failing.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/display/virtio-gpu-3d.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 23f39de..07b3691 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -291,8 +291,11 @@ static void virgl_resource_attach_backing(VirtIOGPU *g,
         return;
     }
 
-    virgl_renderer_resource_attach_iov(att_rb.resource_id,
-                                       res_iovs, att_rb.nr_entries);
+    ret = virgl_renderer_resource_attach_iov(att_rb.resource_id,
+                                             res_iovs, att_rb.nr_entries);
+
+    if (ret != 0)
+        virtio_gpu_cleanup_mapping_iov(res_iovs, att_rb.nr_entries);
 }
 
 static void virgl_resource_detach_backing(VirtIOGPU *g,
-- 
1.8.3.1
