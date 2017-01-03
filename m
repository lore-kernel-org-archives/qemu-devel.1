Received: from eggs.gnu.org ([2001:4830:134:3::10]:49622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOQSD-00010y-Ah
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOQS9-0004Pv-Cx
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOQS9-0004PX-6P
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:41 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jan 2017 15:52:30 +0100
Message-Id: <1483455154-8106-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
References: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] display: virtio-gpu-3d: check virgl
 capabilities max_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Prasad J Pandit <pjp@fedoraproject.org>

Virtio GPU device while processing 'VIRTIO_GPU_CMD_GET_CAPSET'
command, retrieves the maximum capabilities size to fill in the
response object. It continues to fill in capabilities even if
retrieved 'max_size' is zero(0), thus resulting in OOB access.
Add check to avoid it.

Reported-by: Zhenhao Hong <zhenhaohong@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-id: 20161214070156.23368-1-ppandit@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu-3d.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 23f39de..e29f099 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -371,8 +371,12 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
 
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
1.8.3.1
