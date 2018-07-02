Received: from eggs.gnu.org ([2001:4830:134:3::10]:44367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa1dF-0006Oy-M9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa1dE-0007vg-Nu
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:24:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa1dE-0007vE-Hq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:24:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D21C85F72D
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:24:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  2 Jul 2018 18:24:41 +0200
Message-Id: <20180702162443.16796-2-kraxel@redhat.com>
In-Reply-To: <20180702162443.16796-1-kraxel@redhat.com>
References: <20180702162443.16796-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] virtio-gpu: tweak scanout disable.
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

- Factor out the code to virtio_gpu_disable_scanout().
- Allow disable scanout 0, show a message then.
- Clear scanout->resource_id.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 2dd3c3481a..054ec73c0a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -399,6 +399,34 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
     g->hostmem += res->hostmem;
 }
 
+static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
+{
+    struct virtio_gpu_scanout *scanout = &g->scanout[scanout_id];
+    struct virtio_gpu_simple_resource *res;
+    DisplaySurface *ds = NULL;
+
+    if (scanout->resource_id == 0) {
+        return;
+    }
+
+    res = virtio_gpu_find_resource(g, scanout->resource_id);
+    if (res) {
+        res->scanout_bitmask &= ~(1 << scanout_id);
+    }
+
+    if (scanout_id == 0) {
+        /* primary head */
+        ds = qemu_create_message_surface(scanout->width  ?: 640,
+                                         scanout->height ?: 480,
+                                         "Guest disabled display.");
+    }
+    dpy_gfx_replace_surface(scanout->con, ds);
+    scanout->resource_id = 0;
+    scanout->ds = NULL;
+    scanout->width = 0;
+    scanout->height = 0;
+}
+
 static void virtio_gpu_resource_destroy(VirtIOGPU *g,
                                         struct virtio_gpu_simple_resource *res)
 {
@@ -583,24 +611,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
 
     g->enable = 1;
     if (ss.resource_id == 0) {
-        scanout = &g->scanout[ss.scanout_id];
-        if (scanout->resource_id) {
-            res = virtio_gpu_find_resource(g, scanout->resource_id);
-            if (res) {
-                res->scanout_bitmask &= ~(1 << ss.scanout_id);
-            }
-        }
-        if (ss.scanout_id == 0) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s: illegal scanout id specified %d",
-                          __func__, ss.scanout_id);
-            cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
-            return;
-        }
-        dpy_gfx_replace_surface(g->scanout[ss.scanout_id].con, NULL);
-        scanout->ds = NULL;
-        scanout->width = 0;
-        scanout->height = 0;
+        virtio_gpu_disable_scanout(g, ss.scanout_id);
         return;
     }
 
-- 
2.9.3
