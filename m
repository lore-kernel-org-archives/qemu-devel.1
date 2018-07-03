Received: from eggs.gnu.org ([2001:4830:134:3::10]:36904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faHs8-0001kB-Az
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faHs6-00050m-C8
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faHs6-0004z1-6a
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60418308404B
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 09:45:17 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 11:45:07 +0200
Message-Id: <20180703094508.25987-4-kraxel@redhat.com>
In-Reply-To: <20180703094508.25987-1-kraxel@redhat.com>
References: <20180703094508.25987-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] virtio-gpu: disable scanout when backing
 resource is destroyed
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180702162443.16796-4-kraxel@redhat.com
---
 hw/display/virtio-gpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 336dc59007..08cd567218 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -430,6 +430,16 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g,=
 int scanout_id)
 static void virtio_gpu_resource_destroy(VirtIOGPU *g,
                                         struct virtio_gpu_simple_resourc=
e *res)
 {
+    int i;
+
+    if (res->scanout_bitmask) {
+        for (i =3D 0; i < g->conf.max_outputs; i++) {
+            if (res->scanout_bitmask & (1 << i)) {
+                virtio_gpu_disable_scanout(g, i);
+            }
+        }
+    }
+
     pixman_image_unref(res->image);
     virtio_gpu_cleanup_mapping(res);
     QTAILQ_REMOVE(&g->reslist, res, next);
--=20
2.9.3
