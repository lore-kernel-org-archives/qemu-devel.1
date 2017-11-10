Received: from eggs.gnu.org ([2001:4830:134:3::10]:50877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD9Kf-0004j9-Hd
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD9Kc-0001WA-Pt
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:26:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eD9Kc-0001UF-Jv
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:26:50 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 10 Nov 2017 14:26:42 +0100
Message-Id: <20171110132644.8069-2-kraxel@redhat.com>
In-Reply-To: <20171110132644.8069-1-kraxel@redhat.com>
References: <20171110132644.8069-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] virtio-gpu: fix bug in host memory
 calculation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tao Wu <lepton@google.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Tao Wu <lepton@google.com>

The old code treats bits as bytes when calculating host memory usage.
Change it to be consistent with allocation logic in pixman library.

Signed-off-by: Tao Wu <lepton@google.com>
Message-Id: <20171109181741.31318-1-lepton@google.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 43bbe09ea0..274e365713 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -322,6 +322,18 @@ static pixman_format_code_t get_pixman_format(uint32=
_t virtio_gpu_format)
     }
 }
=20
+static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
+                                   uint32_t width, uint32_t height)
+{
+    /* Copied from pixman/pixman-bits-image.c, skip integer overflow che=
ck.
+     * pixman_image_create_bits will fail in case it overflow.
+     */
+
+    int bpp =3D PIXMAN_FORMAT_BPP(pformat);
+    int stride =3D ((width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
+    return height * stride;
+}
+
 static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
                                           struct virtio_gpu_ctrl_command=
 *cmd)
 {
@@ -366,7 +378,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *=
g,
         return;
     }
=20
-    res->hostmem =3D PIXMAN_FORMAT_BPP(pformat) * c2d.width * c2d.height=
;
+    res->hostmem =3D calc_image_hostmem(pformat, c2d.width, c2d.height);
     if (res->hostmem + g->hostmem < g->conf.max_hostmem) {
         res->image =3D pixman_image_create_bits(pformat,
                                               c2d.width,
@@ -1087,7 +1099,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaqu=
e, size_t size,
             return -EINVAL;
         }
=20
-        res->hostmem =3D PIXMAN_FORMAT_BPP(pformat) * res->width * res->=
height;
+        res->hostmem =3D calc_image_hostmem(pformat, res->width, res->he=
ight);
=20
         res->addrs =3D g_new(uint64_t, res->iov_cnt);
         res->iov =3D g_new(struct iovec, res->iov_cnt);
--=20
2.9.3
