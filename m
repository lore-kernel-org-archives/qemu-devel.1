Received: from eggs.gnu.org ([2001:4830:134:3::10]:44835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cltaw-0006SF-FG
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 03:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cltar-000125-Kr
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 03:38:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cltar-00011Z-FM
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 03:38:41 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0A2480F7C
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 08:38:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Mar 2017 09:38:27 +0100
Message-Id: <1489048710-22084-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1489048710-22084-1-git-send-email-kraxel@redhat.com>
References: <1489048710-22084-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/4] virtio-gpu: add xres and yres properties
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

So the default resolution is configurable.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c        | 6 ++++--
 include/hw/virtio/virtio-gpu.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 9b530ab..01bceb4 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1170,8 +1170,8 @@ static void virtio_gpu_device_realize(DeviceState *=
qdev, Error **errp)
     virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
                 g->config_size);
=20
-    g->req_state[0].width =3D 1024;
-    g->req_state[0].height =3D 768;
+    g->req_state[0].width =3D g->conf.xres;
+    g->req_state[0].height =3D g->conf.yres;
=20
     if (virtio_gpu_virgl_enabled(g->conf)) {
         /* use larger control queue in 3d mode */
@@ -1291,6 +1291,8 @@ static Property virtio_gpu_properties[] =3D {
     DEFINE_PROP_BIT("stats", VirtIOGPU, conf.flags,
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
 #endif
+    DEFINE_PROP_UINT32("xres", VirtIOGPU, conf.xres, 1024),
+    DEFINE_PROP_UINT32("yres", VirtIOGPU, conf.yres, 768),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index f3a98a3..f3ffdce 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -72,6 +72,8 @@ struct virtio_gpu_conf {
     uint64_t max_hostmem;
     uint32_t max_outputs;
     uint32_t flags;
+    uint32_t xres;
+    uint32_t yres;
 };
=20
 struct virtio_gpu_ctrl_command {
--=20
1.8.3.1
