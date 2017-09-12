Received: from eggs.gnu.org ([2001:4830:134:3::10]:42578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1drm95-0000Qx-To
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1drm90-0003hP-27
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:26:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1drm8z-0003h5-QC
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:26:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8CEQFpa138023
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 10:26:28 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cxaumxus6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 10:26:28 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Tue, 12 Sep 2017 08:26:27 -0600
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Tue, 12 Sep 2017 10:26:20 -0400
In-Reply-To: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
References: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
References: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
Message-Id: <0a156f413f67b1bf55c5516d8263a15db3ec42c3.1505225353.git.alifm@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/2] virtio_gpu: Handle endian conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com, kraxel@redhat.com

Virtio GPU code currently only supports litte endian format,
and so using the Virtio GPU device on a big endian machine
does not work.

Let's fix it by supporting the correct host cpu byte order.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
---
 hw/display/virtio-gpu.c | 53 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6aae147..36e2414 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -236,8 +236,8 @@ virtio_gpu_fill_display_info(VirtIOGPU *g,
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
@@ -287,6 +287,12 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
     struct virtio_gpu_resource_create_2d c2d;
 
     VIRTIO_GPU_FILL_CMD(c2d);
+
+    c2d.resource_id = le32_to_cpu(c2d.resource_id);
+    c2d.format = le32_to_cpu(c2d.format);
+    c2d.width = le32_to_cpu(c2d.width);
+    c2d.height = le32_to_cpu(c2d.height);
+
     trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
                                        c2d.width, c2d.height);
 
@@ -383,6 +389,14 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
     struct virtio_gpu_transfer_to_host_2d t2d;
 
     VIRTIO_GPU_FILL_CMD(t2d);
+
+    t2d.r.x = le32_to_cpu(t2d.r.x);
+    t2d.r.y = le32_to_cpu(t2d.r.y);
+    t2d.r.width = le32_to_cpu(t2d.r.width);
+    t2d.r.height = le32_to_cpu(t2d.r.height);
+    t2d.resource_id = le32_to_cpu(t2d.resource_id);
+    t2d.offset = le64_to_cpu(t2d.offset);
+
     trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);
 
     res = virtio_gpu_find_resource(g, t2d.resource_id);
@@ -439,6 +453,13 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
     int i;
 
     VIRTIO_GPU_FILL_CMD(rf);
+
+    rf.resource_id = le32_to_cpu(rf.resource_id);
+    rf.r.width = le32_to_cpu(rf.r.width);
+    rf.r.height = le32_to_cpu(rf.r.height);
+    rf.r.x = le32_to_cpu(rf.r.x);
+    rf.r.y = le32_to_cpu(rf.r.y);
+
     trace_virtio_gpu_cmd_res_flush(rf.resource_id,
                                    rf.r.width, rf.r.height, rf.r.x, rf.r.y);
 
@@ -511,6 +532,14 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     struct virtio_gpu_set_scanout ss;
 
     VIRTIO_GPU_FILL_CMD(ss);
+
+    ss.scanout_id = le32_to_cpu(ss.scanout_id);
+    ss.resource_id = le32_to_cpu(ss.resource_id);
+    ss.r.width = le32_to_cpu(ss.r.width);
+    ss.r.height = le32_to_cpu(ss.r.height);
+    ss.r.x = le32_to_cpu(ss.r.x);
+    ss.r.y = le32_to_cpu(ss.r.y);
+
     trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
                                      ss.r.width, ss.r.height, ss.r.x, ss.r.y);
 
@@ -633,13 +662,15 @@ int virtio_gpu_create_mapping_iov(struct virtio_gpu_resource_attach_backing *ab,
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
@@ -686,6 +717,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
     int ret;
 
     VIRTIO_GPU_FILL_CMD(ab);
+
+    ab.resource_id = le32_to_cpu(ab.resource_id);
+    ab.nr_entries = le32_to_cpu(ab.nr_entries);
+
     trace_virtio_gpu_cmd_res_back_attach(ab.resource_id);
 
     res = virtio_gpu_find_resource(g, ab.resource_id);
@@ -735,7 +770,7 @@ static void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
 {
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
 
-    switch (cmd->cmd_hdr.type) {
+    switch (le32_to_cpu(cmd->cmd_hdr.type)) {
     case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
         virtio_gpu_get_display_info(g, cmd);
         break;
@@ -1135,7 +1170,7 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     }
 
     g->config_size = sizeof(struct virtio_gpu_config);
-    g->virtio_config.num_scanouts = g->conf.max_outputs;
+    g->virtio_config.num_scanouts = cpu_to_le32(g->conf.max_outputs);
     virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
                 g->config_size);
 
-- 
1.9.1
