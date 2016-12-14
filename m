Received: from eggs.gnu.org ([2001:4830:134:3::10]:39260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cH3Zo-0000BL-4o
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cH3Zj-0003da-SF
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:02:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cH3Zj-0003dS-MM
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:02:03 -0500
From: P J P <ppandit@redhat.com>
Date: Wed, 14 Dec 2016 12:31:56 +0530
Message-Id: <20161214070156.23368-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] display: virtio-gpu-3d: check virgl
 capabilities max_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Zhenhao Hong <zhenhaohong@gmail.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Virtio GPU device while processing 'VIRTIO_GPU_CMD_GET_CAPSET'
command, retrieves the maximum capabilities size to fill in the
response object. It continues to fill in capabilities even if
retrieved 'max_size' is zero(0), thus resulting in OOB access.
Add check to avoid it.

Reported-by: Zhenhao Hong <zhenhaohong@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/display/virtio-gpu-3d.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 758d33a..6ceeba3 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -370,8 +370,12 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
 
     virgl_renderer_get_cap_set(gc.capset_id, &max_ver,
                                &max_size);
+    if (!max_size) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
     resp = g_malloc(sizeof(*resp) + max_size);
-
     resp->hdr.type = VIRTIO_GPU_RESP_OK_CAPSET;
     virgl_renderer_fill_caps(gc.capset_id,
                              gc.capset_version,
-- 
2.9.3
