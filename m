Received: from eggs.gnu.org ([2001:4830:134:3::10]:57694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dUSkO-0001pU-Os
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dUSkK-00037k-2o
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:04:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dUSkJ-00037N-Sb
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:04:40 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 10 Jul 2017 09:04:32 +0200
Message-Id: <20170710070432.856-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-gpu: skip update cursor in post_load if
 we don't have one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wanghaibin.wang@huawei.com, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

If the cursor resource id isn't set the guest didn't define a cursor.
Skip the cursor update in post_load in that that case.

Reported-by: wanghaibin <wanghaibin.wang@huawei.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 58dc0b2737..eef11083d7 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1092,7 +1092,9 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
 
         dpy_gfx_replace_surface(scanout->con, scanout->ds);
         dpy_gfx_update(scanout->con, 0, 0, scanout->width, scanout->height);
-        update_cursor(g, &scanout->cursor);
+        if (scanout->cursor.resource_id) {
+            update_cursor(g, &scanout->cursor);
+        }
         res->scanout_bitmask |= (1 << i);
     }
 
-- 
2.9.3
