Received: from eggs.gnu.org ([2001:4830:134:3::10]:36912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faHs8-0001kZ-RS
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faHs7-000536-No
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faHs7-00051U-EX
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:19 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7DF73082149
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 09:45:18 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 11:45:05 +0200
Message-Id: <20180703094508.25987-2-kraxel@redhat.com>
In-Reply-To: <20180703094508.25987-1-kraxel@redhat.com>
References: <20180703094508.25987-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] virtio-gpu: tweak scanout disable.
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180702162443.16796-2-kraxel@redhat.com
---
 hw/display/virtio-gpu.c | 47 +++++++++++++++++++++++++++++--------------=
----
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 2dd3c3481a..054ec73c0a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -399,6 +399,34 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU =
*g,
     g->hostmem +=3D res->hostmem;
 }
=20
+static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
+{
+    struct virtio_gpu_scanout *scanout =3D &g->scanout[scanout_id];
+    struct virtio_gpu_simple_resource *res;
+    DisplaySurface *ds =3D NULL;
+
+    if (scanout->resource_id =3D=3D 0) {
+        return;
+    }
+
+    res =3D virtio_gpu_find_resource(g, scanout->resource_id);
+    if (res) {
+        res->scanout_bitmask &=3D ~(1 << scanout_id);
+    }
+
+    if (scanout_id =3D=3D 0) {
+        /* primary head */
+        ds =3D qemu_create_message_surface(scanout->width  ?: 640,
+                                         scanout->height ?: 480,
+                                         "Guest disabled display.");
+    }
+    dpy_gfx_replace_surface(scanout->con, ds);
+    scanout->resource_id =3D 0;
+    scanout->ds =3D NULL;
+    scanout->width =3D 0;
+    scanout->height =3D 0;
+}
+
 static void virtio_gpu_resource_destroy(VirtIOGPU *g,
                                         struct virtio_gpu_simple_resourc=
e *res)
 {
@@ -583,24 +611,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
=20
     g->enable =3D 1;
     if (ss.resource_id =3D=3D 0) {
-        scanout =3D &g->scanout[ss.scanout_id];
-        if (scanout->resource_id) {
-            res =3D virtio_gpu_find_resource(g, scanout->resource_id);
-            if (res) {
-                res->scanout_bitmask &=3D ~(1 << ss.scanout_id);
-            }
-        }
-        if (ss.scanout_id =3D=3D 0) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s: illegal scanout id specified %d",
-                          __func__, ss.scanout_id);
-            cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
-            return;
-        }
-        dpy_gfx_replace_surface(g->scanout[ss.scanout_id].con, NULL);
-        scanout->ds =3D NULL;
-        scanout->width =3D 0;
-        scanout->height =3D 0;
+        virtio_gpu_disable_scanout(g, ss.scanout_id);
         return;
     }
=20
--=20
2.9.3
