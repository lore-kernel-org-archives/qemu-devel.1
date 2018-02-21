Received: from eggs.gnu.org ([2001:4830:134:3::10]:58927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <airlied@gmail.com>) id 1eoJYg-0000mF-5v
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 20:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <airlied@gmail.com>) id 1eoJYb-0004oM-5n
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 20:50:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <airlied@gmail.com>) id 1eoJYb-0004np-12
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 20:50:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D6DE8424F
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 01:50:41 +0000 (UTC)
Received: from dreadlord-bne-redhat-com.bne.redhat.com
	(dhcp-40-179.bne.redhat.com [10.64.40.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7397E10A9DFB
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 01:50:36 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 21 Feb 2018 11:50:35 +1000
Message-Id: <20180221015035.22964-1-airlied@gmail.com>
Subject: [Qemu-devel] [PATCH] virtio-gpu-3d: add support for second
 capability set (v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Dave Airlie <airlied@redhat.com>

Due to a kernel bug we can never increase the size of capability
set 1, so introduce a new capability set in parallel, old userspace
will continue to use the old set, new userspace will start using
the new one when it detects a fixed kernel.

v2: don't use a define from virglrenderer, just probe it.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 hw/display/virtio-gpu-3d.c                  | 5 +++++
 hw/display/virtio-gpu.c                     | 7 ++++++-
 include/standard-headers/linux/virtio_gpu.h | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 7db84efe89..c601b43810 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -362,6 +362,11 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
         virgl_renderer_get_cap_set(resp.capset_id,
                                    &resp.capset_max_version,
                                    &resp.capset_max_size);
+    } else if (info.capset_index == 1) {
+        resp.capset_id = VIRTIO_GPU_CAPSET_VIRGL2;
+        virgl_renderer_get_cap_set(resp.capset_id,
+                                   &resp.capset_max_version,
+                                   &resp.capset_max_size);
     } else {
         resp.capset_max_version = 0;
         resp.capset_max_size = 0;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6658f6c6a6..1418db1b88 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1212,10 +1212,15 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     g->req_state[0].height = g->conf.yres;
 
     if (virtio_gpu_virgl_enabled(g->conf)) {
+        uint32_t capset2_max_ver, capset2_max_size;
         /* use larger control queue in 3d mode */
         g->ctrl_vq   = virtio_add_queue(vdev, 256, virtio_gpu_handle_ctrl_cb);
         g->cursor_vq = virtio_add_queue(vdev, 16, virtio_gpu_handle_cursor_cb);
-        g->virtio_config.num_capsets = 1;
+
+        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
+                                   &capset2_max_ver,
+                                   &capset2_max_size);
+        g->virtio_config.num_capsets = capset2_max_ver > 0 ? 2 : 1;
     } else {
         g->ctrl_vq   = virtio_add_queue(vdev, 64, virtio_gpu_handle_ctrl_cb);
         g->cursor_vq = virtio_add_queue(vdev, 16, virtio_gpu_handle_cursor_cb);
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index c1c8f0751d..52a830dcf8 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -260,6 +260,7 @@ struct virtio_gpu_cmd_submit {
 };
 
 #define VIRTIO_GPU_CAPSET_VIRGL 1
+#define VIRTIO_GPU_CAPSET_VIRGL2 2
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.14.3
