Received: from eggs.gnu.org ([2001:4830:134:3::10]:49621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOQSD-00010x-AV
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOQS9-0004Q0-D5
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOQS9-0004PZ-6d
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:41 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jan 2017 15:52:33 +0100
Message-Id: <1483455154-8106-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
References: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] virtio-gpu-3d: fix memory leak in resource
 attach backing
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

If the virgl_renderer_resource_attach_iov function fails the
'res_iovs' will be leaked. Add check of the return value to
free the 'res_iovs' when failing.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 1482999086-59795-1-git-send-email-liq3ea@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu-3d.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index e29f099..b13ced3 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -291,8 +291,11 @@ static void virgl_resource_attach_backing(VirtIOGPU =
*g,
         return;
     }
=20
-    virgl_renderer_resource_attach_iov(att_rb.resource_id,
-                                       res_iovs, att_rb.nr_entries);
+    ret =3D virgl_renderer_resource_attach_iov(att_rb.resource_id,
+                                             res_iovs, att_rb.nr_entries=
);
+
+    if (ret !=3D 0)
+        virtio_gpu_cleanup_mapping_iov(res_iovs, att_rb.nr_entries);
 }
=20
 static void virgl_resource_detach_backing(VirtIOGPU *g,
--=20
1.8.3.1
