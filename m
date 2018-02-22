Received: from eggs.gnu.org ([2001:4830:134:3::10]:45975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <airlied@gmail.com>) id 1ep0aY-0000uM-4O
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <airlied@gmail.com>) id 1ep0Zu-0003t8-Hx
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:47:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <airlied@gmail.com>) id 1ep0Zu-0003q2-0N
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:47:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 080CF40201A0
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 23:47:05 +0000 (UTC)
Received: from dreadlord-bne-redhat-com.bne.redhat.com
	(dhcp-40-179.bne.redhat.com [10.64.40.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4941B217B42F
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 23:47:04 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 23 Feb 2018 09:47:02 +1000
Message-Id: <20180222234702.15705-1-airlied@gmail.com>
Subject: [Qemu-devel] [PATCH] virtio-gpu-3d: add support for second
 capability set (v3)
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
v3: fix compilation when virglrenderer disabled

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 hw/display/virtio-gpu-3d.c                  | 18 ++++++++++++++++++
 hw/display/virtio-gpu.c                     |  7 ++++++-
 include/hw/virtio/virtio-gpu.h              |  2 +-
 include/standard-headers/linux/virtio_gpu.h |  1 +
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 7db84efe89..05e7106396 100644
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
@@ -635,4 +640,17 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     return 0;
 }
 
+int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
+{
+    uint32_t capset2_max_ver, capset2_max_size;
+    virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
+                              &capset2_max_ver,
+                              &capset2_max_size);
+
+    if (capset2_max_ver)
+        return 2;
+    else
+        return 1;
+}
+
 #endif /* CONFIG_VIRGL */
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6658f6c6a6..2dd3c3481a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1215,7 +1215,12 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
         /* use larger control queue in 3d mode */
         g->ctrl_vq   = virtio_add_queue(vdev, 256, virtio_gpu_handle_ctrl_cb);
         g->cursor_vq = virtio_add_queue(vdev, 16, virtio_gpu_handle_cursor_cb);
-        g->virtio_config.num_capsets = 1;
+
+#if defined(CONFIG_VIRGL)
+        g->virtio_config.num_capsets = virtio_gpu_virgl_get_num_capsets(g);
+#else
+        g->virtio_config.num_capsets = 0;
+#endif
     } else {
         g->ctrl_vq   = virtio_add_queue(vdev, 64, virtio_gpu_handle_ctrl_cb);
         g->cursor_vq = virtio_add_queue(vdev, 16, virtio_gpu_handle_cursor_cb);
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 83f474ffc3..22ac3c2d0e 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -171,5 +171,5 @@ void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 void virtio_gpu_gl_block(void *opaque, bool block);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
-
+int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
 #endif
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
