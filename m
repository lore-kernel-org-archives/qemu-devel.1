Received: from eggs.gnu.org ([2001:4830:134:3::10]:56674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciiA9-0004Y0-7s
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciiA6-0005Gt-4S
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:49:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ciiA5-0005GY-Up
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:49:54 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6133B2172D
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 13:49:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 28 Feb 2017 14:49:46 +0100
Message-Id: <1488289786-22754-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-gpu: add xres and yres properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

So the default resolution is configurable.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c        | 6 ++++--
 include/hw/virtio/virtio-gpu.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 9b530ab..01bceb4 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1170,8 +1170,8 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
                 g->config_size);
 
-    g->req_state[0].width = 1024;
-    g->req_state[0].height = 768;
+    g->req_state[0].width = g->conf.xres;
+    g->req_state[0].height = g->conf.yres;
 
     if (virtio_gpu_virgl_enabled(g->conf)) {
         /* use larger control queue in 3d mode */
@@ -1291,6 +1291,8 @@ static Property virtio_gpu_properties[] = {
     DEFINE_PROP_BIT("stats", VirtIOGPU, conf.flags,
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
 #endif
+    DEFINE_PROP_UINT32("xres", VirtIOGPU, conf.xres, 1024),
+    DEFINE_PROP_UINT32("yres", VirtIOGPU, conf.yres, 768),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
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
 
 struct virtio_gpu_ctrl_command {
-- 
1.8.3.1
