Received: from eggs.gnu.org ([209.51.188.92]:50983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx68l-0002cP-My
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx68k-0007Iy-82
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:25:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx68j-0007DF-Se
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:25:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E02DE3082B21
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:24:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 09:24:36 +0100
Message-Id: <20190222082436.23029-6-kraxel@redhat.com>
In-Reply-To: <20190222082436.23029-1-kraxel@redhat.com>
References: <20190222082436.23029-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] display/virtio: add edid support.
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

This patch adds EDID support to the family of virtio-gpu devices.  It is
turned off by default, use the new edid property to enable it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20190221081054.13853-1-kraxel@redhat.com
---
 include/hw/virtio/virtio-gpu.h |  5 +++++
 hw/display/virtio-gpu-3d.c     |  3 +++
 hw/display/virtio-gpu.c        | 43 ++++++++++++++++++++++++++++++++++++++++++
 hw/display/trace-events        |  1 +
 4 files changed, 52 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 26a669826688..98504f907583 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -61,12 +61,15 @@ struct virtio_gpu_requested_state {
 enum virtio_gpu_conf_flags {
     VIRTIO_GPU_FLAG_VIRGL_ENABLED = 1,
     VIRTIO_GPU_FLAG_STATS_ENABLED,
+    VIRTIO_GPU_FLAG_EDID_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED))
 #define virtio_gpu_stats_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_STATS_ENABLED))
+#define virtio_gpu_edid_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_EDID_ENABLED))
 
 struct virtio_gpu_conf {
     uint64_t max_hostmem;
@@ -155,6 +158,8 @@ void virtio_gpu_ctrl_response_nodata(VirtIOGPU *g,
                                      enum virtio_gpu_ctrl_type type);
 void virtio_gpu_get_display_info(VirtIOGPU *g,
                                  struct virtio_gpu_ctrl_command *cmd);
+void virtio_gpu_get_edid(VirtIOGPU *g,
+                         struct virtio_gpu_ctrl_command *cmd);
 int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
                                   struct virtio_gpu_resource_attach_backing *ab,
                                   struct virtio_gpu_ctrl_command *cmd,
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index cb83479ed214..2d302526ab86 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -463,6 +463,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
         virtio_gpu_get_display_info(g, cmd);
         break;
+    case VIRTIO_GPU_CMD_GET_EDID:
+        virtio_gpu_get_edid(g, cmd);
+        break;
     default:
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         break;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0baa9ac0ad0e..a3627f58a9dd 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -21,6 +21,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-bus.h"
+#include "hw/display/edid.h"
 #include "migration/blocker.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
@@ -207,6 +208,9 @@ static uint64_t virtio_gpu_get_features(VirtIODevice *vdev, uint64_t features,
     if (virtio_gpu_virgl_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_VIRGL);
     }
+    if (virtio_gpu_edid_enabled(g->conf)) {
+        features |= (1 << VIRTIO_GPU_F_EDID);
+    }
     return features;
 }
 
@@ -301,6 +305,40 @@ void virtio_gpu_get_display_info(VirtIOGPU *g,
                              sizeof(display_info));
 }
 
+static void
+virtio_gpu_generate_edid(VirtIOGPU *g, int scanout,
+                         struct virtio_gpu_resp_edid *edid)
+{
+    qemu_edid_info info = {
+        .prefx = g->req_state[scanout].width,
+        .prefy = g->req_state[scanout].height,
+    };
+
+    edid->size = cpu_to_le32(sizeof(edid->edid));
+    qemu_edid_generate(edid->edid, sizeof(edid->edid), &info);
+}
+
+void virtio_gpu_get_edid(VirtIOGPU *g,
+                         struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_resp_edid edid;
+    struct virtio_gpu_cmd_get_edid get_edid;
+
+    VIRTIO_GPU_FILL_CMD(get_edid);
+    virtio_gpu_bswap_32(&get_edid, sizeof(get_edid));
+
+    if (get_edid.scanout >= g->conf.max_outputs) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
+    trace_virtio_gpu_cmd_get_edid(get_edid.scanout);
+    memset(&edid, 0, sizeof(edid));
+    edid.hdr.type = VIRTIO_GPU_RESP_OK_EDID;
+    virtio_gpu_generate_edid(g, get_edid.scanout, &edid);
+    virtio_gpu_ctrl_response(g, cmd, &edid.hdr, sizeof(edid));
+}
+
 static pixman_format_code_t get_pixman_format(uint32_t virtio_gpu_format)
 {
     switch (virtio_gpu_format) {
@@ -839,6 +877,9 @@ static void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
     case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
         virtio_gpu_get_display_info(g, cmd);
         break;
+    case VIRTIO_GPU_CMD_GET_EDID:
+        virtio_gpu_get_edid(g, cmd);
+        break;
     case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
         virtio_gpu_resource_create_2d(g, cmd);
         break;
@@ -1369,6 +1410,8 @@ static Property virtio_gpu_properties[] = {
     DEFINE_PROP_BIT("stats", VirtIOGPU, conf.flags,
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
 #endif
+    DEFINE_PROP_BIT("edid", VirtIOGPU, conf.flags,
+                    VIRTIO_GPU_FLAG_EDID_ENABLED, false),
     DEFINE_PROP_UINT32("xres", VirtIOGPU, conf.xres, 1024),
     DEFINE_PROP_UINT32("yres", VirtIOGPU, conf.yres, 768),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 387c6b893183..37d3264bb2e6 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -35,6 +35,7 @@ vmware_setmode(uint32_t w, uint32_t h, uint32_t bpp) "%dx%d @ %d bpp"
 # hw/display/virtio-gpu.c
 virtio_gpu_features(bool virgl) "virgl %d"
 virtio_gpu_cmd_get_display_info(void) ""
+virtio_gpu_cmd_get_edid(uint32_t scanout) "scanout %d"
 virtio_gpu_cmd_set_scanout(uint32_t id, uint32_t res, uint32_t w, uint32_t h, uint32_t x, uint32_t y) "id %d, res 0x%x, w %d, h %d, x %d, y %d"
 virtio_gpu_cmd_res_create_2d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h) "res 0x%x, fmt 0x%x, w %d, h %d"
 virtio_gpu_cmd_res_create_3d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h, uint32_t d) "res 0x%x, fmt 0x%x, w %d, h %d, d %d"
-- 
2.9.3
