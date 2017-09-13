Received: from eggs.gnu.org ([2001:4830:134:3::10]:36850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2Iv-00058a-IP
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2Iu-0003Pd-Jo
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds2Iu-0003OF-DG
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 745334E047
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:41:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 09:41:40 +0200
Message-Id: <20170913074140.5160-7-kraxel@redhat.com>
In-Reply-To: <20170913074140.5160-1-kraxel@redhat.com>
References: <20170913074140.5160-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/6] virtio-gpu: don't clear QemuUIInfo
 information on reset
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

Don't reset window layout information (passed via virtio_gpu_ui_info) on
device reset, so the user interface window layout will be kept intact
over reboots.  The head size and position was commented out already, so
this patch just drops the dead code.  Additionally the enabled head mask
must be kept so multihead setups work properly too.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1460595
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20170906142058.2460-1-kraxel@redhat.com
---
 hw/display/virtio-gpu.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index f0761cf18b..622ee300f9 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1195,17 +1195,6 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
         virtio_gpu_resource_destroy(g, res);
     }
     for (i =3D 0; i < g->conf.max_outputs; i++) {
-#if 0
-        g->req_state[i].x =3D 0;
-        g->req_state[i].y =3D 0;
-        if (i =3D=3D 0) {
-            g->req_state[0].width =3D 1024;
-            g->req_state[0].height =3D 768;
-        } else {
-            g->req_state[i].width =3D 0;
-            g->req_state[i].height =3D 0;
-        }
-#endif
         g->scanout[i].resource_id =3D 0;
         g->scanout[i].width =3D 0;
         g->scanout[i].height =3D 0;
@@ -1213,7 +1202,6 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
         g->scanout[i].y =3D 0;
         g->scanout[i].ds =3D NULL;
     }
-    g->enabled_output_bitmask =3D 1;
=20
 #ifdef CONFIG_VIRGL
     if (g->use_virgl_renderer) {
--=20
2.9.3
