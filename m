Received: from eggs.gnu.org ([2001:4830:134:3::10]:58508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fwioA-0001oo-1d
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fwio8-0008IK-Qr
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:57:57 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Sep 2018 08:57:44 +0200
Message-Id: <20180903065745.23055-5-kraxel@redhat.com>
In-Reply-To: <20180903065745.23055-1-kraxel@redhat.com>
References: <20180903065745.23055-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] virtio-gpu: pass down VirtIOGPU pointer to
 a bunch of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>

No functional change, just preparation for a followup patch
which needs a VirtIOGPU pointer.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20180829122101.29852-2-kraxel@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  6 ++++--
 hw/display/virtio-gpu-3d.c     |  8 ++++----
 hw/display/virtio-gpu.c        | 25 +++++++++++++++----------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 2374f022e8..c8c599f1b9 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -159,10 +159,12 @@ void virtio_gpu_ctrl_response_nodata(VirtIOGPU *g,
                                      enum virtio_gpu_ctrl_type type);
 void virtio_gpu_get_display_info(VirtIOGPU *g,
                                  struct virtio_gpu_ctrl_command *cmd);
-int virtio_gpu_create_mapping_iov(struct virtio_gpu_resource_attach_backing *ab,
+int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
+                                  struct virtio_gpu_resource_attach_backing *ab,
                                   struct virtio_gpu_ctrl_command *cmd,
                                   uint64_t **addr, struct iovec **iov);
-void virtio_gpu_cleanup_mapping_iov(struct iovec *iov, uint32_t count);
+void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
+                                    struct iovec *iov, uint32_t count);
 void virtio_gpu_process_cmdq(VirtIOGPU *g);
 
 /* virtio-gpu-3d.c */
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 3558f38fe8..55d76405a9 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -86,7 +86,7 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
                                        &res_iovs,
                                        &num_iovs);
     if (res_iovs != NULL && num_iovs != 0) {
-        virtio_gpu_cleanup_mapping_iov(res_iovs, num_iovs);
+        virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
     }
     virgl_renderer_resource_unref(unref.resource_id);
 }
@@ -291,7 +291,7 @@ static void virgl_resource_attach_backing(VirtIOGPU *g,
     VIRTIO_GPU_FILL_CMD(att_rb);
     trace_virtio_gpu_cmd_res_back_attach(att_rb.resource_id);
 
-    ret = virtio_gpu_create_mapping_iov(&att_rb, cmd, NULL, &res_iovs);
+    ret = virtio_gpu_create_mapping_iov(g, &att_rb, cmd, NULL, &res_iovs);
     if (ret != 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
@@ -301,7 +301,7 @@ static void virgl_resource_attach_backing(VirtIOGPU *g,
                                              res_iovs, att_rb.nr_entries);
 
     if (ret != 0)
-        virtio_gpu_cleanup_mapping_iov(res_iovs, att_rb.nr_entries);
+        virtio_gpu_cleanup_mapping_iov(g, res_iovs, att_rb.nr_entries);
 }
 
 static void virgl_resource_detach_backing(VirtIOGPU *g,
@@ -320,7 +320,7 @@ static void virgl_resource_detach_backing(VirtIOGPU *g,
     if (res_iovs == NULL || num_iovs == 0) {
         return;
     }
-    virtio_gpu_cleanup_mapping_iov(res_iovs, num_iovs);
+    virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
 }
 
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 410cf0c98a..cf31b5f710 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -29,7 +29,8 @@
 static struct virtio_gpu_simple_resource*
 virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id);
 
-static void virtio_gpu_cleanup_mapping(struct virtio_gpu_simple_resource *res);
+static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
+                                       struct virtio_gpu_simple_resource *res);
 
 static void
 virtio_gpu_ctrl_hdr_bswap(struct virtio_gpu_ctrl_hdr *hdr)
@@ -442,7 +443,7 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
     }
 
     pixman_image_unref(res->image);
-    virtio_gpu_cleanup_mapping(res);
+    virtio_gpu_cleanup_mapping(g, res);
     QTAILQ_REMOVE(&g->reslist, res, next);
     g->hostmem -= res->hostmem;
     g_free(res);
@@ -688,7 +689,8 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     scanout->height = ss.r.height;
 }
 
-int virtio_gpu_create_mapping_iov(struct virtio_gpu_resource_attach_backing *ab,
+int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
+                                  struct virtio_gpu_resource_attach_backing *ab,
                                   struct virtio_gpu_ctrl_command *cmd,
                                   uint64_t **addr, struct iovec **iov)
 {
@@ -732,7 +734,7 @@ int virtio_gpu_create_mapping_iov(struct virtio_gpu_resource_attach_backing *ab,
             qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
                           " resource %d element %d\n",
                           __func__, ab->resource_id, i);
-            virtio_gpu_cleanup_mapping_iov(*iov, i);
+            virtio_gpu_cleanup_mapping_iov(g, *iov, i);
             g_free(ents);
             *iov = NULL;
             if (addr) {
@@ -746,7 +748,8 @@ int virtio_gpu_create_mapping_iov(struct virtio_gpu_resource_attach_backing *ab,
     return 0;
 }
 
-void virtio_gpu_cleanup_mapping_iov(struct iovec *iov, uint32_t count)
+void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
+                                    struct iovec *iov, uint32_t count)
 {
     int i;
 
@@ -757,9 +760,10 @@ void virtio_gpu_cleanup_mapping_iov(struct iovec *iov, uint32_t count)
     g_free(iov);
 }
 
-static void virtio_gpu_cleanup_mapping(struct virtio_gpu_simple_resource *res)
+static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
+                                       struct virtio_gpu_simple_resource *res)
 {
-    virtio_gpu_cleanup_mapping_iov(res->iov, res->iov_cnt);
+    virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
     res->iov = NULL;
     res->iov_cnt = 0;
     g_free(res->addrs);
@@ -791,7 +795,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
         return;
     }
 
-    ret = virtio_gpu_create_mapping_iov(&ab, cmd, &res->addrs, &res->iov);
+    ret = virtio_gpu_create_mapping_iov(g, &ab, cmd, &res->addrs, &res->iov);
     if (ret != 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
@@ -818,7 +822,7 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
         return;
     }
-    virtio_gpu_cleanup_mapping(res);
+    virtio_gpu_cleanup_mapping(g, res);
 }
 
 static void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
@@ -1144,6 +1148,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             hwaddr len = res->iov[i].iov_len;
             res->iov[i].iov_base =
                 cpu_physical_memory_map(res->addrs[i], &len, 1);
+
             if (!res->iov[i].iov_base || len != res->iov[i].iov_len) {
                 /* Clean up the half-a-mapping we just created... */
                 if (res->iov[i].iov_base) {
@@ -1152,7 +1157,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
                 }
                 /* ...and the mappings for previous loop iterations */
                 res->iov_cnt = i;
-                virtio_gpu_cleanup_mapping(res);
+                virtio_gpu_cleanup_mapping(g, res);
                 pixman_image_unref(res->image);
                 g_free(res);
                 return -EINVAL;
-- 
2.9.3
