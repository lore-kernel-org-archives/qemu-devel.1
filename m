Received: from eggs.gnu.org ([2001:4830:134:3::10]:44855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968k-0005c1-00
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968i-0001q9-47
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d968h-0001je-Ll
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:32 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:36 +0800
Message-Id: <1494578148-102868-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 04/16] vhost-pci-net: add vhost-pci-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>

Add the vhost-pci-net device emulation.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost-pci-net.c                         | 248 +++++++++++++++++++++++++
 hw/virtio/vhost-pci-slave.c                    |   5 +
 include/hw/virtio/vhost-pci-net.h              |  34 ++++
 include/standard-headers/linux/vhost_pci_net.h |  74 ++++++++
 4 files changed, 361 insertions(+)
 create mode 100644 hw/net/vhost-pci-net.c
 create mode 100644 include/hw/virtio/vhost-pci-net.h
 create mode 100644 include/standard-headers/linux/vhost_pci_net.h

diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
new file mode 100644
index 0000000..8e194ba
--- /dev/null
+++ b/hw/net/vhost-pci-net.c
@@ -0,0 +1,248 @@
+/*
+ * vhost-pci-net support
+ *
+ * Copyright Intel, Inc. 2016
+ *
+ * Authors:
+ *  Wei Wang <wei.w.wang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "qemu/error-report.h"
+#include "hw/virtio/virtio-access.h"
+#include "hw/virtio/vhost-pci-net.h"
+
+#define VPNET_CTRLQ_SIZE 32
+#define VPNET_VQ_SIZE 256
+
+static void vpnet_handle_vq(VirtIODevice *vdev, VirtQueue *vq)
+{
+}
+
+static void vpnet_handle_ctrlq(VirtIODevice *vdev, VirtQueue *vq)
+{
+}
+
+/* Send a ctrlq message to the driver */
+static size_t vpnet_send_ctrlq_msg(VhostPCINet *vpnet,
+                                 struct vpnet_ctrlq_msg *msg)
+{
+    VirtQueueElement *elem;
+    VirtQueue *vq;
+    size_t msg_len = msg->size;
+
+    vq = vpnet->ctrlq;
+    if (!virtio_queue_ready(vq)) {
+        return 0;
+    }
+
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        return 0;
+    }
+
+    iov_from_buf(elem->in_sg, elem->in_num, 0, msg, msg_len);
+
+    virtqueue_push(vq, elem, msg_len);
+    virtio_notify(VIRTIO_DEVICE(vpnet), vq);
+    g_free(elem);
+
+    return msg_len;
+}
+
+/* Send a ctrlq message of the remote memory to the driver */
+static void vpnet_send_ctrlq_msg_remote_mem(VhostPCINet *vpnet)
+{
+    VhostPCIDev *vp_dev = get_vhost_pci_dev();
+    struct vpnet_ctrlq_msg *msg;
+    uint16_t payload_size, msg_size;
+
+    payload_size = vp_dev->remote_mem_num *
+                   sizeof(struct ctrlq_msg_remote_mem);
+    msg_size = payload_size + VPNET_CTRLQ_MSG_HDR_SIZE;
+    msg = g_malloc(msg_size);
+    msg->class = VHOST_PCI_CTRLQ_MSG_REMOTE_MEM;
+    msg->size = msg_size;
+    memcpy(msg->payload.msg_remote_mem, vp_dev->remote_mem, payload_size);
+    vpnet_send_ctrlq_msg(vpnet, msg);
+    g_free(msg);
+}
+
+static void vpnet_ctrlq_msg_remoteq_add_one(struct vpnet_ctrlq_msg *msg,
+                                            Remoteq *remoteq)
+{
+    uint32_t vring_num = remoteq->vring_num;
+    struct ctrlq_msg_remoteq *msg_remoteq;
+
+    msg_remoteq = &msg->payload.msg_remoteq[vring_num];
+    msg_remoteq->last_avail_idx = remoteq->last_avail_idx;
+    msg_remoteq->vring_num = vring_num;
+    msg_remoteq->vring_enable = remoteq->enabled;
+    msg_remoteq->desc_gpa = remoteq->addr.desc_user_addr;
+    msg_remoteq->avail_gpa = remoteq->addr.avail_user_addr;
+    msg_remoteq->used_gpa = remoteq->addr.used_user_addr;
+}
+
+/* Send a ctrlq message of the remoteq info to the driver */
+static void vpnet_send_ctrlq_msg_remoteq(VhostPCINet *vpnet)
+{
+    Remoteq *remoteq;
+    struct vpnet_ctrlq_msg *msg;
+    uint16_t remoteq_num, msg_size;
+    VhostPCIDev *vp_dev = get_vhost_pci_dev();
+
+    remoteq_num = vp_dev->remoteq_num;
+    msg_size = sizeof(struct ctrlq_msg_remoteq) * remoteq_num +
+               VPNET_CTRLQ_MSG_HDR_SIZE;
+    msg = g_malloc(msg_size);
+    msg->class = VHOST_PCI_CTRLQ_MSG_REMOTEQ;
+    msg->size = msg_size;
+
+    QLIST_FOREACH(remoteq, &vp_dev->remoteq_list, node) {
+        /* Get remoteqs from the list, and fill them into the ctrlq_msg */
+        vpnet_ctrlq_msg_remoteq_add_one(msg, remoteq);
+    }
+
+    vpnet_send_ctrlq_msg(vpnet, msg);
+    g_free(msg);
+}
+
+static void vpnet_set_status(struct VirtIODevice *vdev, uint8_t status)
+{
+    VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
+    uint16_t vq_num = vpnet->vq_pairs * 2;
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusState *vbus = VIRTIO_BUS(qbus);
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    VirtQueue *vq;
+    int r, i;
+
+    /* Send the ctrlq messages to the driver when the ctrlq is ready */
+    if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+        vpnet_send_ctrlq_msg_remote_mem(vpnet);
+        vpnet_send_ctrlq_msg_remoteq(vpnet);
+    }
+}
+
+static uint64_t vpnet_get_features(VirtIODevice *vdev, uint64_t features,
+                                   Error **errp)
+{
+    VhostPCIDev *vp_dev = get_vhost_pci_dev();
+
+    /*
+     * Give the driver the feature bits that have been negotiated with the
+     * remote device.
+     */
+    return vp_dev->feature_bits;
+}
+
+static void vpnet_set_features(VirtIODevice *vdev, uint64_t features)
+{
+}
+
+static void vpnet_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
+    struct vhost_pci_net_config netcfg;
+
+    virtio_stw_p(vdev, &netcfg.status, vpnet->status);
+    virtio_stw_p(vdev, &netcfg.vq_pairs, vpnet->vq_pairs);
+    memcpy(config, &netcfg, vpnet->config_size);
+}
+
+static void vpnet_set_config(VirtIODevice *vdev, const uint8_t *config)
+{
+}
+
+static void vpnet_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
+    uint16_t i, vq_num;
+    VhostPCIDev *vp_dev = get_vhost_pci_dev();
+
+    vq_num = vp_dev->remoteq_num;
+    vpnet->vq_pairs = vq_num / 2;
+    virtio_init(vdev, "vhost-pci-net", VIRTIO_ID_VHOST_PCI_NET,
+                vpnet->config_size);
+
+    /* Add local vqs */
+    for (i = 0; i < vq_num; i++) {
+        virtio_add_queue(vdev, VPNET_VQ_SIZE, vpnet_handle_vq);
+    }
+    /* Add the ctrlq */
+    vpnet->ctrlq = virtio_add_queue(vdev, VPNET_CTRLQ_SIZE, vpnet_handle_ctrlq);
+
+    vpnet->status = 0;
+    vp_dev->vdev = vdev;
+}
+
+static void vpnet_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
+    uint16_t i, vq_num = vpnet->vq_pairs * 2;
+
+    /* Delete the datapath vqs and the ctrlq */
+    for (i = 0; i < vq_num + 1; i++) {
+        virtio_del_queue(vdev, i);
+    }
+}
+
+static void vpnet_reset(VirtIODevice *vdev)
+{
+}
+
+static Property vpnet_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vpnet_instance_init(Object *obj)
+{
+    VhostPCINet *vpnet = VHOST_PCI_NET(obj);
+
+    /*
+     * The default config_size is sizeof(struct vhost_pci_net_config).
+     * Can be overriden with vpnet_set_config_size.
+     */
+    vpnet->config_size = sizeof(struct vhost_pci_net_config);
+}
+
+static void vpnet_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    dc->props = vpnet_properties;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    vdc->realize = vpnet_device_realize;
+    vdc->unrealize = vpnet_device_unrealize;
+    vdc->get_config = vpnet_get_config;
+    vdc->set_config = vpnet_set_config;
+    vdc->get_features = vpnet_get_features;
+    vdc->set_features = vpnet_set_features;
+    vdc->set_status = vpnet_set_status;
+    vdc->reset = vpnet_reset;
+}
+
+static const TypeInfo vpnet_info = {
+    .name = TYPE_VHOST_PCI_NET,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VhostPCINet),
+    .instance_init = vpnet_instance_init,
+    .class_init = vpnet_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&vpnet_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 464afa3..ab1d06b 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -39,6 +39,11 @@
 
 VhostPCISlave *vp_slave;
 
+VhostPCIDev *get_vhost_pci_dev(void)
+{
+    return vp_slave->vp_dev;
+}
+
 /* Clean up VhostPCIDev */
 static void vp_dev_cleanup(void)
 {
diff --git a/include/hw/virtio/vhost-pci-net.h b/include/hw/virtio/vhost-pci-net.h
new file mode 100644
index 0000000..e3a1c8b
--- /dev/null
+++ b/include/hw/virtio/vhost-pci-net.h
@@ -0,0 +1,34 @@
+/*
+ * Virtio Network Device
+ *
+ * Copyright Intel, Corp. 2016
+ *
+ * Authors:
+ *  Wei Wang   <wei.w.wang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef _QEMU_VHOST_PCI_NET_H
+#define _QEMU_VHOST_PCI_NET_H
+
+#include "standard-headers/linux/vhost_pci_net.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost-pci-slave.h"
+
+#define TYPE_VHOST_PCI_NET "vhost-pci-net-device"
+#define VHOST_PCI_NET(obj) \
+        OBJECT_CHECK(VhostPCINet, (obj), TYPE_VHOST_PCI_NET)
+
+typedef struct VhostPCINet {
+    VirtIODevice parent_obj;
+    VirtQueue *ctrlq;
+    uint16_t status;
+    uint16_t vq_pairs;
+    size_t config_size;
+    uint64_t device_features;
+} VhostPCINet;
+
+#endif
diff --git a/include/standard-headers/linux/vhost_pci_net.h b/include/standard-headers/linux/vhost_pci_net.h
new file mode 100644
index 0000000..bd8e09f
--- /dev/null
+++ b/include/standard-headers/linux/vhost_pci_net.h
@@ -0,0 +1,74 @@
+#ifndef _LINUX_VHOST_PCI_NET_H
+#define _LINUX_VHOST_PCI_NET_H
+
+/* This header is BSD licensed so anyone can use the definitions to implement
+ * compatible drivers/servers.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Intel nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL Intel OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE. */
+
+#include "standard-headers/linux/virtio_ids.h"
+
+#define VPNET_S_LINK_UP	1	/* Link is up */
+
+struct vhost_pci_net_config {
+	/*
+	 * Legal values are between 1 and 0x8000
+	 */
+	uint16_t vq_pairs;
+	/* See VPNET_S_* above */
+	uint16_t status;
+} QEMU_PACKED;
+
+struct ctrlq_msg_remote_mem {
+	uint64_t gpa;
+	uint64_t size;
+};
+
+struct ctrlq_msg_remoteq {
+	uint16_t last_avail_idx;
+        int32_t  vring_enable;
+	uint32_t vring_num;
+	uint64_t desc_gpa;
+	uint64_t avail_gpa;
+	uint64_t used_gpa;
+};
+
+#define VHOST_PCI_CTRLQ_MSG_REMOTE_MEM	0
+#define VHOST_PCI_CTRLQ_MSG_REMOTEQ	1
+struct vpnet_ctrlq_msg {
+	uint8_t class;
+	uint8_t cmd;
+	uint16_t size;
+        union {
+		struct ctrlq_msg_remote_mem msg_remote_mem[0];
+		struct ctrlq_msg_remoteq msg_remoteq[0];
+	} payload;
+} __attribute__((packed));
+
+static struct vpnet_ctrlq_msg vpnet_msg __attribute__ ((unused));
+#define VPNET_CTRLQ_MSG_HDR_SIZE (sizeof(vpnet_msg.class) \
+			      + sizeof(vpnet_msg.cmd)  \
+			      + sizeof(vpnet_msg.size))
+
+#endif
-- 
2.7.4
