Received: from eggs.gnu.org ([209.51.188.92]:43444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmlm-0007tQ-4r
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmll-0003Bk-81
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:44:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmlk-00034f-Sm
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:44:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68643C049D67
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:43:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:43:30 +0100
Message-Id: <20190221114330.17968-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190221114330.17968-1-marcandre.lureau@redhat.com>
References: <20190221114330.17968-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] virtio-gpu: remove useless 'waiting' field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Let's check renderer_blocked instead directly.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 1 -
 hw/display/virtio-gpu.c        | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index f8cd8ee96f..26a6698266 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -81,7 +81,6 @@ struct virtio_gpu_ctrl_command {
     VirtQueue *vq;
     struct virtio_gpu_ctrl_hdr cmd_hdr;
     uint32_t error;
-    bool waiting;
     bool finished;
     QTAILQ_ENTRY(virtio_gpu_ctrl_command) next;
 };
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 7ada4b83ac..0baa9ac0ad 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -889,8 +889,7 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd =3D QTAILQ_FIRST(&g->cmdq);
=20
-        cmd->waiting =3D g->renderer_blocked;
-        if (cmd->waiting) {
+        if (g->renderer_blocked) {
             break;
         }
=20
@@ -939,7 +938,6 @@ static void virtio_gpu_handle_ctrl(VirtIODevice *vdev=
, VirtQueue *vq)
         cmd->vq =3D vq;
         cmd->error =3D 0;
         cmd->finished =3D false;
-        cmd->waiting =3D false;
         QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
         cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command)=
);
     }
--=20
2.21.0.rc1
