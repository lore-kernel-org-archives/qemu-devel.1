Received: from eggs.gnu.org ([2001:4830:134:3::10]:33439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dsWU7-0001dj-Mi
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dsWU2-0006Zn-Qg
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:55:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36594
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dsWU2-0006ZQ-LK
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:55:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8EFs7h4096282
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:55:17 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cyur8br60-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:55:16 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 09:55:15 -0600
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Thu, 14 Sep 2017 11:55:08 -0400
In-Reply-To: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
References: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
References: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
Message-Id: <f6c9e7ec8ad585ce7c8f401aae2ec1fddf157fd7.1505403478.git.alifm@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/2] virtio-gpu: Handle endian conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, kraxel@redhat.com, cohuck@redhat.com

Virtio GPU code currently only supports litte endian format,
and so using the Virtio GPU device on a big endian machine
does not work.

Let's fix it by supporting the correct host cpu byte order.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
---
 hw/display/virtio-gpu.c | 75 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 8 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6aae147..001d94b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -30,6 +30,54 @@ virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id);
 
 static void virtio_gpu_cleanup_mapping(struct virtio_gpu_simple_resource *res);
 
+static void
+virtio_gpu_ctrl_hdr_bswap_cpu(struct virtio_gpu_ctrl_hdr *hdr)
+{
+    hdr->type =  le32_to_cpu(hdr->type);
+    hdr->flags = le32_to_cpu(hdr->flags);
+    hdr->fence_id = le64_to_cpu(hdr->fence_id);
+    hdr->ctx_id = le32_to_cpu(hdr->ctx_id);
+    hdr->padding = le32_to_cpu(hdr->padding);
+}
+
+static void
+virtio_gpu_ctrl_hdr_bswap_le(struct virtio_gpu_ctrl_hdr *hdr)
+{
+    hdr->type =  cpu_to_le32(hdr->type);
+    hdr->flags = cpu_to_le32(hdr->flags);
+    hdr->fence_id = cpu_to_le64(hdr->fence_id);
+    hdr->ctx_id = cpu_to_le32(hdr->ctx_id);
+    hdr->padding = cpu_to_le32(hdr->padding);
+}
+
+static void virtio_gpu_bswap_cpu_32(void *ptr,
+                                    size_t size)
+{
+    size_t i;
+    struct virtio_gpu_ctrl_hdr *hdr = (struct virtio_gpu_ctrl_hdr *) ptr;
+
+    virtio_gpu_ctrl_hdr_bswap_cpu(hdr);
+
+    i = sizeof(struct virtio_gpu_ctrl_hdr);
+    while (i < size) {
+        *(uint32_t *)(ptr + i) = le32_to_cpu(*(uint32_t *)(ptr + i));
+        i = i + sizeof(uint32_t);
+    }
+}
+
+static void
+virtio_gpu_t2d_bswap_cpu(struct virtio_gpu_transfer_to_host_2d *t2d)
+{
+    virtio_gpu_ctrl_hdr_bswap_cpu(&t2d->hdr);
+    t2d->r.x = le32_to_cpu(t2d->r.x);
+    t2d->r.y = le32_to_cpu(t2d->r.y);
+    t2d->r.width = le32_to_cpu(t2d->r.width);
+    t2d->r.height = le32_to_cpu(t2d->r.height);
+    t2d->offset = le64_to_cpu(t2d->offset);
+    t2d->resource_id = le32_to_cpu(t2d->resource_id);
+    t2d->padding = le32_to_cpu(t2d->padding);
+}
+
 #ifdef CONFIG_VIRGL
 #include <virglrenderer.h>
 #define VIRGL(_g, _virgl, _simple, ...)                     \
@@ -205,6 +253,7 @@ void virtio_gpu_ctrl_response(VirtIOGPU *g,
         resp->fence_id = cmd->cmd_hdr.fence_id;
         resp->ctx_id = cmd->cmd_hdr.ctx_id;
     }
+    virtio_gpu_ctrl_hdr_bswap_le(resp);
     s = iov_from_buf(cmd->elem.in_sg, cmd->elem.in_num, 0, resp, resp_len);
     if (s != resp_len) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -236,8 +285,8 @@ virtio_gpu_fill_display_info(VirtIOGPU *g,
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
@@ -287,6 +336,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
     struct virtio_gpu_resource_create_2d c2d;
 
     VIRTIO_GPU_FILL_CMD(c2d);
+    virtio_gpu_bswap_cpu_32(&c2d, sizeof(c2d));
     trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
                                        c2d.width, c2d.height);
 
@@ -360,6 +410,7 @@ static void virtio_gpu_resource_unref(VirtIOGPU *g,
     struct virtio_gpu_resource_unref unref;
 
     VIRTIO_GPU_FILL_CMD(unref);
+    virtio_gpu_bswap_cpu_32(&unref, sizeof(unref));
     trace_virtio_gpu_cmd_res_unref(unref.resource_id);
 
     res = virtio_gpu_find_resource(g, unref.resource_id);
@@ -383,6 +434,7 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
     struct virtio_gpu_transfer_to_host_2d t2d;
 
     VIRTIO_GPU_FILL_CMD(t2d);
+    virtio_gpu_t2d_bswap_cpu(&t2d);
     trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);
 
     res = virtio_gpu_find_resource(g, t2d.resource_id);
@@ -439,6 +491,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
     int i;
 
     VIRTIO_GPU_FILL_CMD(rf);
+    virtio_gpu_bswap_cpu_32(&rf, sizeof(rf));
     trace_virtio_gpu_cmd_res_flush(rf.resource_id,
                                    rf.r.width, rf.r.height, rf.r.x, rf.r.y);
 
@@ -511,6 +564,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     struct virtio_gpu_set_scanout ss;
 
     VIRTIO_GPU_FILL_CMD(ss);
+    virtio_gpu_bswap_cpu_32(&ss, sizeof(ss));
     trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
                                      ss.r.width, ss.r.height, ss.r.x, ss.r.y);
 
@@ -633,13 +687,15 @@ int virtio_gpu_create_mapping_iov(struct virtio_gpu_resource_attach_backing *ab,
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
@@ -686,6 +742,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
     int ret;
 
     VIRTIO_GPU_FILL_CMD(ab);
+    virtio_gpu_bswap_cpu_32(&ab, sizeof(ab));
     trace_virtio_gpu_cmd_res_back_attach(ab.resource_id);
 
     res = virtio_gpu_find_resource(g, ab.resource_id);
@@ -718,6 +775,7 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
     struct virtio_gpu_resource_detach_backing detach;
 
     VIRTIO_GPU_FILL_CMD(detach);
+    virtio_gpu_bswap_cpu_32(&detach, sizeof(detach));
     trace_virtio_gpu_cmd_res_back_detach(detach.resource_id);
 
     res = virtio_gpu_find_resource(g, detach.resource_id);
@@ -734,6 +792,7 @@ static void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
                                           struct virtio_gpu_ctrl_command *cmd)
 {
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
+    virtio_gpu_ctrl_hdr_bswap_cpu(&cmd->cmd_hdr);
 
     switch (cmd->cmd_hdr.type) {
     case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
@@ -1135,7 +1194,7 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     }
 
     g->config_size = sizeof(struct virtio_gpu_config);
-    g->virtio_config.num_scanouts = g->conf.max_outputs;
+    g->virtio_config.num_scanouts = cpu_to_le32(g->conf.max_outputs);
     virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
                 g->config_size);
 
-- 
1.9.1
