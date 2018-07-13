Received: from eggs.gnu.org ([2001:4830:134:3::10]:41479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxq7-0004ez-0S
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxq5-00064b-HZ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51562 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxq5-00063N-9k
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE019406C792
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:10:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:09:13 +0200
Message-Id: <20180713130916.4153-27-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 26/29] virtio-gpu: remove useless 'waiting'
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Let's check renderer_blocked instead directly.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 1 -
 hw/display/virtio-gpu.c        | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index 763e1291f1..6b07efc4f7 100644
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
index 26a2592c4a..b83982b0a3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -840,8 +840,7 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd =3D QTAILQ_FIRST(&g->cmdq);
=20
-        cmd->waiting =3D g->renderer_blocked;
-        if (cmd->waiting) {
+        if (g->renderer_blocked) {
             break;
         }
=20
@@ -890,7 +889,6 @@ static void virtio_gpu_handle_ctrl(VirtIODevice *vdev=
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
2.18.0.129.ge3331758f1
