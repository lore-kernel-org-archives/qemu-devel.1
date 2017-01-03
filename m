Received: from eggs.gnu.org ([2001:4830:134:3::10]:49624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOQSD-00010z-B2
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOQS9-0004Q4-Dg
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOQS9-0004Pa-6x
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:41 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jan 2017 15:52:32 +0100
Message-Id: <1483455154-8106-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
References: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] virtio-gpu: call cleanup mapping function
 in resource destroy
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

If the guest destroy the resource before detach banking, the 'iov'
and 'addrs' field in resource is not freed thus leading memory
leak issue. This patch avoid this.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 1480386565-10077-1-git-send-email-liq3ea@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ed2b6d3..6a26258 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -28,6 +28,8 @@
 static struct virtio_gpu_simple_resource*
 virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id);
=20
+static void virtio_gpu_cleanup_mapping(struct virtio_gpu_simple_resource=
 *res);
+
 #ifdef CONFIG_VIRGL
 #include <virglrenderer.h>
 #define VIRGL(_g, _virgl, _simple, ...)                     \
@@ -364,6 +366,7 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
                                         struct virtio_gpu_simple_resourc=
e *res)
 {
     pixman_image_unref(res->image);
+    virtio_gpu_cleanup_mapping(res);
     QTAILQ_REMOVE(&g->reslist, res, next);
     g->hostmem -=3D res->hostmem;
     g_free(res);
--=20
1.8.3.1
