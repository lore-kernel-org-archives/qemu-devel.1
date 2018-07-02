Received: from eggs.gnu.org ([2001:4830:134:3::10]:44354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa1dF-0006Od-A3
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa1dC-0007uD-5P
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:24:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa1dB-0007tv-VF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:24:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A6E23003064
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:24:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  2 Jul 2018 18:24:42 +0200
Message-Id: <20180702162443.16796-3-kraxel@redhat.com>
In-Reply-To: <20180702162443.16796-1-kraxel@redhat.com>
References: <20180702162443.16796-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] virtio-gpu: update old resource too.
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

When switching scanout from one resource to another we must update the
scanout_bitmask field for both new (set bit) and old (clear bit)
resource.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 054ec73c0a..336dc59007 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -590,7 +590,7 @@ static void virtio_unref_resource(pixman_image_t *image, void *data)
 static void virtio_gpu_set_scanout(VirtIOGPU *g,
                                    struct virtio_gpu_ctrl_command *cmd)
 {
-    struct virtio_gpu_simple_resource *res;
+    struct virtio_gpu_simple_resource *res, *ores;
     struct virtio_gpu_scanout *scanout;
     pixman_format_code_t format;
     uint32_t offset;
@@ -664,6 +664,11 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
         dpy_gfx_replace_surface(g->scanout[ss.scanout_id].con, scanout->ds);
     }
 
+    ores = virtio_gpu_find_resource(g, scanout->resource_id);
+    if (ores) {
+        ores->scanout_bitmask &= ~(1 << ss.scanout_id);
+    }
+
     res->scanout_bitmask |= (1 << ss.scanout_id);
     scanout->resource_id = ss.resource_id;
     scanout->x = ss.r.x;
-- 
2.9.3
