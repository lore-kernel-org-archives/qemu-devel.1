Received: from eggs.gnu.org ([2001:4830:134:3::10]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIqzt-0002ou-Ae
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIqzp-0004VN-HK
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:37265)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIqzp-0004V0-5Z
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:25 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:58:36 +0800
Message-Id: <1482127152-84732-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 01/37] vhost-pci-net: the fundamental
 vhost-pci-net device emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

This patch introduces the fundamental parts of the device emulation.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/Makefile.objs                           |   2 +-
 hw/net/vhost-pci-net.c                         | 138 +++++++++++++++++++++++++
 include/hw/virtio/vhost-pci-net.h              |  36 +++++++
 include/standard-headers/linux/vhost_pci_net.h |  43 ++++++++
 include/standard-headers/linux/virtio_ids.h    |  29 +++---
 5 files changed, 233 insertions(+), 15 deletions(-)
 create mode 100644 hw/net/vhost-pci-net.c
 create mode 100644 include/hw/virtio/vhost-pci-net.h
 create mode 100644 include/standard-headers/linux/vhost_pci_net.h

diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index 610ed3e..71d6d2e 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -33,7 +33,7 @@ obj-$(CONFIG_MILKYMIST) += milkymist-minimac2.o
 obj-$(CONFIG_PSERIES) += spapr_llan.o
 obj-$(CONFIG_XILINX_ETHLITE) += xilinx_ethlite.o
 
-obj-$(CONFIG_VIRTIO) += virtio-net.o
+obj-$(CONFIG_VIRTIO) += virtio-net.o vhost-pci-net.o
 obj-y += vhost_net.o
 
 obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
new file mode 100644
index 0000000..b9141fd
--- /dev/null
+++ b/hw/net/vhost-pci-net.c
@@ -0,0 +1,138 @@
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
+#include "hw/virtio/virtio-access.h"
+#include "hw/virtio/vhost-pci-net.h"
+
+#define VPNET_CQ_SIZE 32
+#define VPNET_RQ_SIZE 256
+
+static void vpnet_handle_rq(VirtIODevice *vdev, VirtQueue *vq)
+{
+}
+
+static void vpnet_handle_crq(VirtIODevice *vdev, VirtQueue *vq)
+{
+}
+
+static void vpnet_set_status(struct VirtIODevice *vdev, uint8_t status)
+{
+}
+
+static uint64_t vpnet_get_features(VirtIODevice *vdev, uint64_t features,
+                                   Error **errp)
+{
+    VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
+
+    return vpnet->device_features;
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
+    virtio_stw_p(vdev, &netcfg.peer_vq_num, vpnet->peer_vq_num);
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
+    uint16_t i, rq_num = vpnet->peer_vq_num / 2;
+
+    virtio_init(vdev, "vhost-pci-net", VIRTIO_ID_VHOST_PCI_NET,
+                vpnet->config_size);
+
+    /* control receive quque: host to guest */
+    vpnet->crq = virtio_add_queue(vdev, VPNET_CQ_SIZE, vpnet_handle_crq);
+    /* datapath receive queue */
+    vpnet->rqs = g_malloc0(sizeof(VirtQueue *) * rq_num);
+    for (i = 0; i < rq_num; i++) {
+        vpnet->rqs[i] = virtio_add_queue(vdev, VPNET_RQ_SIZE,
+                                         vpnet_handle_rq);
+    }
+    vpnet->status = 0;
+}
+
+static void vpnet_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
+    uint16_t i, rq_num = vpnet->peer_vq_num / 2;
+
+    for (i = 0; i < rq_num + 2; i++) {
+        virtio_del_queue(vdev, i);
+    }
+
+    g_free(vpnet->rqs);
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
diff --git a/include/hw/virtio/vhost-pci-net.h b/include/hw/virtio/vhost-pci-net.h
new file mode 100644
index 0000000..8f2e65f
--- /dev/null
+++ b/include/hw/virtio/vhost-pci-net.h
@@ -0,0 +1,36 @@
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
+
+#define TYPE_VHOST_PCI_NET "vhost-pci-net-device"
+#define VHOST_PCI_NET(obj) \
+        OBJECT_CHECK(VhostPCINet, (obj), TYPE_VHOST_PCI_NET)
+
+typedef struct VhostPCINet {
+    VirtIODevice parent_obj;
+    /* Control receiveq: msg from host to guest */
+    VirtQueue *crq;
+    /* Datapath receiveq */
+    VirtQueue **rqs;
+    uint16_t status;
+    uint16_t peer_vq_num;
+    size_t config_size;
+    uint64_t device_features;
+} VhostPCINet;
+
+#endif
diff --git a/include/standard-headers/linux/vhost_pci_net.h b/include/standard-headers/linux/vhost_pci_net.h
new file mode 100644
index 0000000..bac293f
--- /dev/null
+++ b/include/standard-headers/linux/vhost_pci_net.h
@@ -0,0 +1,43 @@
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
+	uint16_t peer_vq_num;
+	/* See VPNET_S_* above */
+	uint16_t status;
+} QEMU_PACKED;
+
+#endif
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index fe74e42..d581c92 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -29,18 +29,19 @@
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  * SUCH DAMAGE. */
 
-#define VIRTIO_ID_NET		1 /* virtio net */
-#define VIRTIO_ID_BLOCK		2 /* virtio block */
-#define VIRTIO_ID_CONSOLE	3 /* virtio console */
-#define VIRTIO_ID_RNG		4 /* virtio rng */
-#define VIRTIO_ID_BALLOON	5 /* virtio balloon */
-#define VIRTIO_ID_RPMSG		7 /* virtio remote processor messaging */
-#define VIRTIO_ID_SCSI		8 /* virtio scsi */
-#define VIRTIO_ID_9P		9 /* 9p virtio console */
-#define VIRTIO_ID_RPROC_SERIAL 11 /* virtio remoteproc serial link */
-#define VIRTIO_ID_CAIF	       12 /* Virtio caif */
-#define VIRTIO_ID_GPU          16 /* virtio GPU */
-#define VIRTIO_ID_INPUT        18 /* virtio input */
-#define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
-#define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_NET		 1 /* virtio net */
+#define VIRTIO_ID_BLOCK		 2 /* virtio block */
+#define VIRTIO_ID_CONSOLE	 3 /* virtio console */
+#define VIRTIO_ID_RNG		 4 /* virtio rng */
+#define VIRTIO_ID_BALLOON	 5 /* virtio balloon */
+#define VIRTIO_ID_RPMSG		 7 /* virtio remote processor messaging */
+#define VIRTIO_ID_SCSI		 8 /* virtio scsi */
+#define VIRTIO_ID_9P		 9 /* 9p virtio console */
+#define VIRTIO_ID_RPROC_SERIAL  11 /* virtio remoteproc serial link */
+#define VIRTIO_ID_CAIF	        12 /* Virtio caif */
+#define VIRTIO_ID_GPU           16 /* virtio GPU */
+#define VIRTIO_ID_INPUT         18 /* virtio input */
+#define VIRTIO_ID_VSOCK         19 /* virtio vsock transport */
+#define VIRTIO_ID_CRYPTO        20 /* virtio crypto */
+#define VIRTIO_ID_VHOST_PCI_NET 21 /* vhost-pci-net */
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.7.4
