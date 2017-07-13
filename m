Received: from eggs.gnu.org ([2001:4830:134:3::10]:42993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh4B-0004VA-Bs
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh4A-0005JQ-Dx
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:34:15 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:32:04 +0200
Message-Id: <20170713163219.9024-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/29] virtio-gpu: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0506d2c1b0..669f36f8bb 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -408,7 +408,7 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU =
*g,
     }
=20
     format =3D pixman_image_get_format(res->image);
-    bpp =3D (PIXMAN_FORMAT_BPP(format) + 7) / 8;
+    bpp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
     stride =3D pixman_image_get_stride(res->image);
=20
     if (t2d.offset || t2d.r.x || t2d.r.y ||
@@ -570,7 +570,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     scanout =3D &g->scanout[ss.scanout_id];
=20
     format =3D pixman_image_get_format(res->image);
-    bpp =3D (PIXMAN_FORMAT_BPP(format) + 7) / 8;
+    bpp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
     offset =3D (ss.r.x * bpp) + ss.r.y * pixman_image_get_stride(res->im=
age);
     if (!scanout->ds || surface_data(scanout->ds)
         !=3D ((uint8_t *)pixman_image_get_data(res->image) + offset) ||
--=20
2.13.1.395.gf7b71de06
