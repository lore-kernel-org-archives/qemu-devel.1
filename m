Received: from eggs.gnu.org ([2001:4830:134:3::10]:33608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRG99-0001aZ-DY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRG97-0003R9-RM
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRG97-0003Qp-Ly
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:45 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 11:28:33 +0100
Message-Id: <1484130518-18873-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
References: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] virtio-gpu: fix information leak in capset
 get dispatch
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

In virgl_cmd_get_capset function, it uses g_malloc to allocate
a response struct to the guest. As the 'resp'struct hasn't been full
initialized it will lead the 'resp->padding' field to the guest.
Use g_malloc0 to avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 58188cae.4a6ec20a.3d2d1.aff2@mx.google.com

[ kraxel: resolved conflict ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu-3d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index b13ced3..f96a0c2 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -379,7 +379,7 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
         return;
     }
=20
-    resp =3D g_malloc(sizeof(*resp) + max_size);
+    resp =3D g_malloc0(sizeof(*resp) + max_size);
     resp->hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;
     virgl_renderer_fill_caps(gc.capset_id,
                              gc.capset_version,
--=20
1.8.3.1
