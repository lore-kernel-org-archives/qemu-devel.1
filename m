Received: from eggs.gnu.org ([2001:4830:134:3::10]:33230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eM4Ep-0001NY-QR
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eM4Eo-0007LT-HS
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:32277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eM4Eo-0007JF-4v
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:42 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  5 Dec 2017 11:33:11 +0800
Message-Id: <1512444796-30615-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 2/7] vhost-pci-net: add vhost-pci-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Cc: jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com, Wei Wang <wei.w.wang@intel.com>

Add the vhost-pci-net device emulation. The device uses bar 2 to expose
the remote VM's memory to the guest. The first 4KB of the the bar area
stores the metadata which describes the remote memory and vring info.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/Makefile.objs                           |   2 +-
 hw/net/vhost_pci_net.c                         | 106 +++++++++++++++++++++++++
 include/hw/virtio/vhost-pci-net.h              |  37 +++++++++
 include/standard-headers/linux/vhost_pci_net.h |  60 ++++++++++++++
 include/standard-headers/linux/virtio_ids.h    |   1 +
 5 files changed, 205 insertions(+), 1 deletion(-)
 create mode 100644 hw/net/vhost_pci_net.c
 create mode 100644 include/hw/virtio/vhost-pci-net.h
 create mode 100644 include/standard-headers/linux/vhost_pci_net.h

diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index 4171af0..8b392fb 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -36,7 +36,7 @@ obj-$(CONFIG_MILKYMIST) += milkymist-minimac2.o
 obj-$(CONFIG_PSERIES) += spapr_llan.o
 obj-$(CONFIG_XILINX_ETHLITE) += xilinx_ethlite.o
 
-obj-$(CONFIG_VIRTIO) += virtio-net.o
+obj-$(CONFIG_VIRTIO) += virtio-net.o vhost_pci_net.o
 obj-y += vhost_net.o
 
 obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
diff --git a/hw/net/vhost_pci_net.c b/hw/net/vhost_pci_net.c
new file mode 100644
index 0000000..db8f954
--- /dev/null
+++ b/hw/net/vhost_pci_net.c
@@ -0,0 +1,106 @@
+/*
+ * vhost-pci-net support
+ *
+ * Copyright Intel, Inc. 2017
+ *
+ * Authors:
+ *  Wei Wang <wei.w.wang@intel.com>
+ *  Zhiyong Yang <zhiyong.yang@intel.com>
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
+#include "hw/pci/pci.h"
+#include "hw/virtio/virtio-access.h"
+#include "hw/virtio/vhost-pci-net.h"
+#include "hw/virtio/virtio-net.h"
+
+static uint64_t vpnet_get_features(VirtIODevice *vdev, uint64_t features,
+                                   Error **errp)
+{
+    VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
+    features |= vpnet->host_features;
+
+    return features;
+}
+
+static void vpnet_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
+    struct vpnet_config netcfg;
+
+    virtio_stw_p(vdev, &netcfg.status, vpnet->status);
+    memcpy(config, &netcfg, vpnet->config_size);
+}
+
+static void vpnet_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
+
+    virtio_init(vdev, "vhost-pci-net", VIRTIO_ID_VHOST_PCI_NET,
+                vpnet->config_size);
+
+    memory_region_init_ram(&vpnet->metadata_region, NULL,
+                           "Metadata", METADATA_SIZE, NULL);
+    memory_region_add_subregion(&vpnet->bar_region, 0,
+                                &vpnet->metadata_region);
+    vpnet->metadata = memory_region_get_ram_ptr(&vpnet->metadata_region);
+    memset(vpnet->metadata, 0, METADATA_SIZE);
+}
+
+static void vpnet_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+
+    virtio_cleanup(vdev);
+}
+
+static Property vpnet_properties[] = {
+    DEFINE_PROP_BIT("mrg_rxbuf", VhostPCINet, host_features,
+                    VIRTIO_NET_F_MRG_RXBUF, true),
+    DEFINE_PROP_CHR("chardev", VhostPCINet, chr_be),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vpnet_instance_init(Object *obj)
+{
+    VhostPCINet *vpnet = VHOST_PCI_NET(obj);
+
+    vpnet->config_size = sizeof(struct vpnet_config);
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
+    vdc->get_features = vpnet_get_features;
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
index 0000000..0c6886d
--- /dev/null
+++ b/include/hw/virtio/vhost-pci-net.h
@@ -0,0 +1,37 @@
+/*
+ * Virtio Network Device
+ *
+ * Copyright Intel, Corp. 2017
+ *
+ * Authors:
+ *  Wei Wang <wei.w.wang@intel.com>
+ *  Zhiyong Yang <zhiyong.yang@intel.com>
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
+#include "chardev/char-fe.h"
+
+#define TYPE_VHOST_PCI_NET "vhost-pci-net-device"
+#define VHOST_PCI_NET(obj) \
+        OBJECT_CHECK(VhostPCINet, (obj), TYPE_VHOST_PCI_NET)
+
+typedef struct VhostPCINet {
+    VirtIODevice parent_obj;
+    MemoryRegion bar_region;
+    MemoryRegion metadata_region;
+    struct vpnet_metadata *metadata;
+    uint32_t host_features;
+    size_t config_size;
+    uint16_t status;
+    CharBackend chr_be;
+} VhostPCINet;
+
+#endif
diff --git a/include/standard-headers/linux/vhost_pci_net.h b/include/standard-headers/linux/vhost_pci_net.h
new file mode 100644
index 0000000..cfb2413
--- /dev/null
+++ b/include/standard-headers/linux/vhost_pci_net.h
@@ -0,0 +1,60 @@
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
+#define METADATA_SIZE 4096
+#define MAX_REMOTE_REGION 8
+
+struct vpnet_config {
+	uint16_t status;
+};
+
+struct vpnet_remote_mem {
+	uint64_t gpa;
+	uint64_t size;
+};
+
+struct vpnet_remote_vq {
+	uint16_t last_avail_idx;
+	int32_t  vring_enabled;
+	uint32_t vring_num;
+	uint64_t desc_gpa;
+	uint64_t avail_gpa;
+	uint64_t used_gpa;
+};
+
+struct vpnet_metadata {
+	uint32_t nregions;
+	uint32_t nvqs;
+	struct vpnet_remote_mem mem[MAX_REMOTE_REGION];
+	struct vpnet_remote_vq vq[0];
+};
+
+#endif
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 6d5c3b2..333bbd1 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -43,5 +43,6 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_VHOST_PCI_NET 21 /* vhost-pci-net */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.7.4
