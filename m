Received: from eggs.gnu.org ([2001:4830:134:3::10]:40606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLfO-0007ro-Hf
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLfK-0004Qn-3Q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLfJ-0004QL-RX
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:30 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:35 +0200
Message-Id: <20170919164337.18555-37-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 36/38] virtio-gpu: Handle endian conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

Virtio GPU code currently only supports litte endian format,
and so using the Virtio GPU device on a big endian machine
does not work.

Let's fix it by supporting the correct host cpu byte order.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Message-Id: <dc748e15f36db808f90b4f2393bc29ba7556a9f6.1505485574.git.alifm@linux.vnet.ibm.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/display/virtio-gpu.c | 70 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 622ee300f9..3a8f1e1a2d 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -30,6 +30,48 @@ virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id);
 
 static void virtio_gpu_cleanup_mapping(struct virtio_gpu_simple_resource *res);
 
+static void
+virtio_gpu_ctrl_hdr_bswap(struct virtio_gpu_ctrl_hdr *hdr)
+{
+    le32_to_cpus(&hdr->type);
+    le32_to_cpus(&hdr->flags);
+    le64_to_cpus(&hdr->fence_id);
+    le32_to_cpus(&hdr->ctx_id);
+    le32_to_cpus(&hdr->padding);
+}
+
+static void virtio_gpu_bswap_32(void *ptr,
+                                size_t size)
+{
+#ifdef HOST_WORDS_BIGENDIAN
+
+    size_t i;
+    struct virtio_gpu_ctrl_hdr *hdr = (struct virtio_gpu_ctrl_hdr *) ptr;
+
+    virtio_gpu_ctrl_hdr_bswap(hdr);
+
+    i = sizeof(struct virtio_gpu_ctrl_hdr);
+    while (i < size) {
+        le32_to_cpus((uint32_t *)(ptr + i));
+        i = i + sizeof(uint32_t);
+    }
+
+#endif
+}
+
+static void
+virtio_gpu_t2d_bswap(struct virtio_gpu_transfer_to_host_2d *t2d)
+{
+    virtio_gpu_ctrl_hdr_bswap(&t2d->hdr);
+    le32_to_cpus(&t2d->r.x);
+    le32_to_cpus(&t2d->r.y);
+    le32_to_cpus(&t2d->r.width);
+    le32_to_cpus(&t2d->r.height);
+    le64_to_cpus(&t2d->offset);
+    le32_to_cpus(&t2d->resource_id);
+    le32_to_cpus(&t2d->padding);
+}
+
 #ifdef CONFIG_VIRGL
 #include <virglrenderer.h>
 #define VIRGL(_g, _virgl, _simple, ...)                     \
@@ -205,6 +247,7 @@ void virtio_gpu_ctrl_response(VirtIOGPU *g,
         resp->fence_id = cmd->cmd_hdr.fence_id;
         resp->ctx_id = cmd->cmd_hdr.ctx_id;
     }
+    virtio_gpu_ctrl_hdr_bswap(resp);
     s = iov_from_buf(cmd->elem.in_sg, cmd->elem.in_num, 0, resp, resp_len);
     if (s != resp_len) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -236,8 +279,8 @@ virtio_gpu_fill_display_info(VirtIOGPU *g,
     for (i = 0; i < g->conf.max_outputs; i++) {
         if (g->enabled_output_bitmask & (1 << i)) {
             dpy_info->pmodes[i].enabled = 1;
-            dpy_info->pmodes[i].r.width = g->req_state[i].width;
-            dpy_info->pmodes[i].r.height = g->req_state[i].height;
+            dpy_info->pmodes[i].r.width = cpu_to_le32(g->req_state[i].width);
+            dpy_info->pmodes[i].r.height = cpu_to_le32(g->req_state[i].height);
         }
     }
 }
@@ -287,6 +330,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
     struct virtio_gpu_resource_create_2d c2d;
 
     VIRTIO_GPU_FILL_CMD(c2d);
+    virtio_gpu_bswap_32(&c2d, sizeof(c2d));
     trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
                                        c2d.width, c2d.height);
 
@@ -360,6 +404,7 @@ static void virtio_gpu_resource_unref(VirtIOGPU *g,
     struct virtio_gpu_resource_unref unref;
 
     VIRTIO_GPU_FILL_CMD(unref);
+    virtio_gpu_bswap_32(&unref, sizeof(unref));
     trace_virtio_gpu_cmd_res_unref(unref.resource_id);
 
     res = virtio_gpu_find_resource(g, unref.resource_id);
@@ -383,6 +428,7 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
     struct virtio_gpu_transfer_to_host_2d t2d;
 
     VIRTIO_GPU_FILL_CMD(t2d);
+    virtio_gpu_t2d_bswap(&t2d);
     trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);
 
     res = virtio_gpu_find_resource(g, t2d.resource_id);
@@ -439,6 +485,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
     int i;
 
     VIRTIO_GPU_FILL_CMD(rf);
+    virtio_gpu_bswap_32(&rf, sizeof(rf));
     trace_virtio_gpu_cmd_res_flush(rf.resource_id,
                                    rf.r.width, rf.r.height, rf.r.x, rf.r.y);
 
@@ -511,6 +558,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     struct virtio_gpu_set_scanout ss;
 
     VIRTIO_GPU_FILL_CMD(ss);
+    virtio_gpu_bswap_32(&ss, sizeof(ss));
     trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
                                      ss.r.width, ss.r.height, ss.r.x, ss.r.y);
 
@@ -633,13 +681,15 @@ int virtio_gpu_create_mapping_iov(struct virtio_gpu_resource_attach_backing *ab,
         *addr = g_malloc0(sizeof(uint64_t) * ab->nr_entries);
     }
     for (i = 0; i < ab->nr_entries; i++) {
-        hwaddr len = ents[i].length;
-        (*iov)[i].iov_len = ents[i].length;
-        (*iov)[i].iov_base = cpu_physical_memory_map(ents[i].addr, &len, 1);
+        uint64_t a = le64_to_cpu(ents[i].addr);
+        uint32_t l = le32_to_cpu(ents[i].length);
+        hwaddr len = l;
+        (*iov)[i].iov_len = l;
+        (*iov)[i].iov_base = cpu_physical_memory_map(a, &len, 1);
         if (addr) {
-            (*addr)[i] = ents[i].addr;
+            (*addr)[i] = a;
         }
-        if (!(*iov)[i].iov_base || len != ents[i].length) {
+        if (!(*iov)[i].iov_base || len != l) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
                           " resource %d element %d\n",
                           __func__, ab->resource_id, i);
@@ -686,6 +736,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
     int ret;
 
     VIRTIO_GPU_FILL_CMD(ab);
+    virtio_gpu_bswap_32(&ab, sizeof(ab));
     trace_virtio_gpu_cmd_res_back_attach(ab.resource_id);
 
     res = virtio_gpu_find_resource(g, ab.resource_id);
@@ -718,6 +769,7 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
     struct virtio_gpu_resource_detach_backing detach;
 
     VIRTIO_GPU_FILL_CMD(detach);
+    virtio_gpu_bswap_32(&detach, sizeof(detach));
     trace_virtio_gpu_cmd_res_back_detach(detach.resource_id);
 
     res = virtio_gpu_find_resource(g, detach.resource_id);
@@ -734,6 +786,7 @@ static void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
                                           struct virtio_gpu_ctrl_command *cmd)
 {
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
+    virtio_gpu_ctrl_hdr_bswap(&cmd->cmd_hdr);
 
     switch (cmd->cmd_hdr.type) {
     case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
@@ -879,6 +932,7 @@ static void virtio_gpu_handle_cursor(VirtIODevice *vdev, VirtQueue *vq)
                           "%s: cursor size incorrect %zu vs %zu\n",
                           __func__, s, sizeof(cursor_info));
         } else {
+            virtio_gpu_bswap_32(&cursor_info, sizeof(cursor_info));
             update_cursor(g, &cursor_info);
         }
         virtqueue_push(vq, elem, 0);
@@ -1135,7 +1189,7 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     }
 
     g->config_size = sizeof(struct virtio_gpu_config);
-    g->virtio_config.num_scanouts = g->conf.max_outputs;
+    g->virtio_config.num_scanouts = cpu_to_le32(g->conf.max_outputs);
     virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
                 g->config_size);
 
-- 
2.13.5
