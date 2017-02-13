Received: from eggs.gnu.org ([2001:4830:134:3::10]:54355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdBpR-0004vc-EY
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdBpN-0004b3-0G
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:17:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cdBpM-0004ZL-RO
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:17:40 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 13 Feb 2017 09:17:26 +0100
Message-Id: <1486973851-21645-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486973851-21645-1-git-send-email-kraxel@redhat.com>
References: <1486973851-21645-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/6] virtio-gpu: fix memory leak in set scanout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Li Qiang <liqiang6-s@360.cn>

In virtio_gpu_set_scanout function, when creating the 'rect'
its refcount is set to 2, by pixman_image_create_bits and
qemu_create_displaysurface_pixman function. This can lead
a memory leak issues. This patch avoid this issue.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 5884626f.5b2f6b0a.1bfff.3037@mx.google.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 444ca06..9b530ab 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -608,6 +608,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
             cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
             return;
         }
+        pixman_image_unref(rect);
         dpy_gfx_replace_surface(g->scanout[ss.scanout_id].con, scanout->=
ds);
     }
=20
--=20
1.8.3.1
