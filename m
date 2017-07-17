Received: from eggs.gnu.org ([2001:4830:134:3::10]:51746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2XZ-0002Ee-Ig
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2XY-0003Q9-F4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:42:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX2XY-0003Nc-8R
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:42:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BAFC7CB89
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:42:07 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 11:41:59 +0200
Message-Id: <20170717094159.16447-2-kraxel@redhat.com>
In-Reply-To: <20170717094159.16447-1-kraxel@redhat.com>
References: <20170717094159.16447-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] virtio-gpu: skip update cursor in post_load
 if we don't have one
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

If the cursor resource id isn't set the guest didn't define a cursor.
Skip the cursor update in post_load in that that case.

Reported-by: wanghaibin <wanghaibin.wang@huawei.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: wanghaibin <wanghaibin.wang@huawei.com>
Message-id: 20170710070432.856-1-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0506d2c1b0..6aae147324 100644
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
