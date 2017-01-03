Received: from eggs.gnu.org ([2001:4830:134:3::10]:49627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOQSD-000110-BO
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOQSA-0004RJ-Sb
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOQSA-0004QE-K1
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:42 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jan 2017 15:52:31 +0100
Message-Id: <1483455154-8106-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
References: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] virtio-gpu: track and limit host memory
 allocations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Dave Airlie <airlied@redhat.com>, =?UTF-8?q?=E6=9D=8E=E5=BC=BA?= <liqiang6-s@360.cn>, "Michael S. Tsirkin" <mst@redhat.com>

This patch makes virtio-gpu track host memory allocations for ressources
and applies a limit (configurable 256M by default).  When exceeding the
limit virtio-gpu throws VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY errors (like
it already does today when pixman image allocations fail).

This patch covers 2d mode only.  For 3d mode we have to figure how we
are going to handle this best.  qemu doesn't track resources in case
virglrenderer is used, so I guess we should extend virglrenderer to
allow setting a limit, then let qemu set the limit and catch
virgl_renderer_resource_create failures.

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: =E6=9D=8E=E5=BC=BA <liqiang6-s@360.cn>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 1480423356-22255-1-git-send-email-kraxel@redhat.com
---
 hw/display/virtio-gpu.c        | 16 ++++++++++++----
 include/hw/virtio/virtio-gpu.h |  3 +++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5f32e1a..ed2b6d3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -338,10 +338,14 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU=
 *g,
         cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
         return;
     }
-    res->image =3D pixman_image_create_bits(pformat,
-                                          c2d.width,
-                                          c2d.height,
-                                          NULL, 0);
+
+    res->hostmem =3D PIXMAN_FORMAT_BPP(pformat) * c2d.width * c2d.height=
;
+    if (res->hostmem + g->hostmem < g->conf.max_hostmem) {
+        res->image =3D pixman_image_create_bits(pformat,
+                                              c2d.width,
+                                              c2d.height,
+                                              NULL, 0);
+    }
=20
     if (!res->image) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -353,6 +357,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *=
g,
     }
=20
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
+    g->hostmem +=3D res->hostmem;
 }
=20
 static void virtio_gpu_resource_destroy(VirtIOGPU *g,
@@ -360,6 +365,7 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
 {
     pixman_image_unref(res->image);
     QTAILQ_REMOVE(&g->reslist, res, next);
+    g->hostmem -=3D res->hostmem;
     g_free(res);
 }
=20
@@ -1241,6 +1247,8 @@ static const VMStateDescription vmstate_virtio_gpu =
=3D {
=20
 static Property virtio_gpu_properties[] =3D {
     DEFINE_PROP_UINT32("max_outputs", VirtIOGPU, conf.max_outputs, 1),
+    DEFINE_PROP_SIZE("max_hostmem", VirtIOGPU, conf.max_hostmem,
+                     256 * 1024 * 1024),
 #ifdef CONFIG_VIRGL
     DEFINE_PROP_BIT("virgl", VirtIOGPU, conf.flags,
                     VIRTIO_GPU_FLAG_VIRGL_ENABLED, true),
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index 20d1cd6..f3a98a3 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -38,6 +38,7 @@ struct virtio_gpu_simple_resource {
     unsigned int iov_cnt;
     uint32_t scanout_bitmask;
     pixman_image_t *image;
+    uint64_t hostmem;
     QTAILQ_ENTRY(virtio_gpu_simple_resource) next;
 };
=20
@@ -68,6 +69,7 @@ enum virtio_gpu_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_STATS_ENABLED))
=20
 struct virtio_gpu_conf {
+    uint64_t max_hostmem;
     uint32_t max_outputs;
     uint32_t flags;
 };
@@ -103,6 +105,7 @@ typedef struct VirtIOGPU {
     struct virtio_gpu_requested_state req_state[VIRTIO_GPU_MAX_SCANOUTS]=
;
=20
     struct virtio_gpu_conf conf;
+    uint64_t hostmem;
     int enabled_output_bitmask;
     struct virtio_gpu_config virtio_config;
=20
--=20
1.8.3.1
