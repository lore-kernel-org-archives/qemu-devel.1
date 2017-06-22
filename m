Received: from eggs.gnu.org ([2001:4830:134:3::10]:45504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1SL-0006yT-8B
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1SK-0006hh-D1
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1SK-0006hQ-6j
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AA8030AF43
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:43:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:48 +0200
Message-Id: <20170622124204.19407-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/31] virtio-gpu: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 58dc0b2737..641f57e7c5 100644
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
