Received: from eggs.gnu.org ([2001:4830:134:3::10]:44157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwrI-0002Ge-Qa
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwrH-0005Ll-Te
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fUwrH-0005L3-PP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64421401DE60
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 16:18:23 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Jun 2018 18:17:26 +0200
Message-Id: <20180618161729.334-24-marcandre.lureau@redhat.com>
In-Reply-To: <20180618161729.334-1-marcandre.lureau@redhat.com>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 23/26] virtio-gpu: remove useless 'waiting'
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
Cc: berrange@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Let's check renderer_blocked instead directly.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 1 -
 hw/display/virtio-gpu.c        | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index fb74fba4a9..5b19b0d9d4 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -86,7 +86,6 @@ struct virtio_gpu_ctrl_command {
     VirtQueue *vq;
     struct virtio_gpu_ctrl_hdr cmd_hdr;
     uint32_t error;
-    bool waiting;
     bool finished;
     QTAILQ_ENTRY(virtio_gpu_ctrl_command) next;
 };
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 48b3e0ceaa..37055926d3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -813,8 +813,7 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd =3D QTAILQ_FIRST(&g->cmdq);
=20
-        cmd->waiting =3D g->renderer_blocked;
-        if (cmd->waiting) {
+        if (g->renderer_blocked) {
             break;
         }
=20
@@ -863,7 +862,6 @@ static void virtio_gpu_handle_ctrl(VirtIODevice *vdev=
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
2.18.0.rc1
