Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7777C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875042076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6JJ8U+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875042076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joima-00080v-NP
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 03:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1joiii-0000iK-0z
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:24:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51271
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1joiif-0003Wz-CC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593156256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljIQ3ZaTCs4uYzaG/XiSofjX7+syE+CfcORjuEhhfyk=;
 b=B6JJ8U+HmBIuDGsAtHp/5iuZoOjVCrbMrBUkod9CvL1Z51LHepK4KjT9jpCjjE1uSNMQy+
 4u4zaqIwCh9kNgHCktgwarftoW/jrjiapEwSyf76ZvFms+ndEXHuy4s4VMsZ+x9i5HhsKV
 DfkiT/9fVw84Lohrryyak4gzRrctn7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-LdieUo_CNQOz8UEc48Iu_A-1; Fri, 26 Jun 2020 03:24:14 -0400
X-MC-Unique: LdieUo_CNQOz8UEc48Iu_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D81B1005512;
 Fri, 26 Jun 2020 07:24:13 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-35.ams2.redhat.com [10.36.113.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48C7C1C8;
 Fri, 26 Jun 2020 07:24:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 11/21] virtio-pci: Proxy for virtio-mem
Date: Fri, 26 Jun 2020 09:22:38 +0200
Message-Id: <20200626072248.78761-12-david@redhat.com>
In-Reply-To: <20200626072248.78761-1-david@redhat.com>
References: <20200626072248.78761-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 02:19:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's add a proxy for virtio-mem, make it a memory device, and
pass-through the properties.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/Makefile.objs    |   1 +
 hw/virtio/virtio-mem-pci.c | 129 +++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-mem-pci.h |  33 ++++++++++
 include/hw/pci/pci.h       |   1 +
 4 files changed, 164 insertions(+)
 create mode 100644 hw/virtio/virtio-mem-pci.c
 create mode 100644 hw/virtio/virtio-mem-pci.h

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index f3a65e01b7..a986708186 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -20,6 +20,7 @@ obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-common.o vhost-vsock.o
 obj-$(CONFIG_VHOST_USER_VSOCK) += vhost-vsock-common.o vhost-user-vsock.o
 obj-$(CONFIG_VIRTIO_MEM) += virtio-mem.o
+common-obj-$(call land,$(CONFIG_VIRTIO_MEM),$(CONFIG_VIRTIO_PCI)) += virtio-mem-pci.o
 
 ifeq ($(CONFIG_VIRTIO_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
new file mode 100644
index 0000000000..b325303b32
--- /dev/null
+++ b/hw/virtio/virtio-mem-pci.c
@@ -0,0 +1,129 @@
+/*
+ * Virtio MEM PCI device
+ *
+ * Copyright (C) 2020 Red Hat, Inc.
+ *
+ * Authors:
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "virtio-mem-pci.h"
+#include "hw/mem/memory-device.h"
+#include "qapi/error.h"
+
+static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOMEMPCI *mem_pci = VIRTIO_MEM_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&mem_pci->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_mem_pci_set_addr(MemoryDeviceState *md, uint64_t addr,
+                                    Error **errp)
+{
+    object_property_set_uint(OBJECT(md), addr, VIRTIO_MEM_ADDR_PROP, errp);
+}
+
+static uint64_t virtio_mem_pci_get_addr(const MemoryDeviceState *md)
+{
+    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_ADDR_PROP,
+                                    &error_abort);
+}
+
+static MemoryRegion *virtio_mem_pci_get_memory_region(MemoryDeviceState *md,
+                                                      Error **errp)
+{
+    VirtIOMEMPCI *pci_mem = VIRTIO_MEM_PCI(md);
+    VirtIOMEM *vmem = VIRTIO_MEM(&pci_mem->vdev);
+    VirtIOMEMClass *vmc = VIRTIO_MEM_GET_CLASS(vmem);
+
+    return vmc->get_memory_region(vmem, errp);
+}
+
+static uint64_t virtio_mem_pci_get_plugged_size(const MemoryDeviceState *md,
+                                                Error **errp)
+{
+    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_SIZE_PROP,
+                                    errp);
+}
+
+static void virtio_mem_pci_fill_device_info(const MemoryDeviceState *md,
+                                            MemoryDeviceInfo *info)
+{
+    VirtioMEMDeviceInfo *vi = g_new0(VirtioMEMDeviceInfo, 1);
+    VirtIOMEMPCI *pci_mem = VIRTIO_MEM_PCI(md);
+    VirtIOMEM *vmem = VIRTIO_MEM(&pci_mem->vdev);
+    VirtIOMEMClass *vpc = VIRTIO_MEM_GET_CLASS(vmem);
+    DeviceState *dev = DEVICE(md);
+
+    if (dev->id) {
+        vi->has_id = true;
+        vi->id = g_strdup(dev->id);
+    }
+
+    /* let the real device handle everything else */
+    vpc->fill_device_info(vmem, vi);
+
+    info->u.virtio_mem.data = vi;
+    info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM;
+}
+
+static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(klass);
+
+    k->realize = virtio_mem_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_MEM;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_OTHERS;
+
+    mdc->get_addr = virtio_mem_pci_get_addr;
+    mdc->set_addr = virtio_mem_pci_set_addr;
+    mdc->get_plugged_size = virtio_mem_pci_get_plugged_size;
+    mdc->get_memory_region = virtio_mem_pci_get_memory_region;
+    mdc->fill_device_info = virtio_mem_pci_fill_device_info;
+}
+
+static void virtio_mem_pci_instance_init(Object *obj)
+{
+    VirtIOMEMPCI *dev = VIRTIO_MEM_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_MEM);
+    object_property_add_alias(obj, VIRTIO_MEM_BLOCK_SIZE_PROP,
+                              OBJECT(&dev->vdev), VIRTIO_MEM_BLOCK_SIZE_PROP);
+    object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
+                              VIRTIO_MEM_SIZE_PROP);
+    object_property_add_alias(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP,
+                              OBJECT(&dev->vdev),
+                              VIRTIO_MEM_REQUESTED_SIZE_PROP);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_mem_pci_info = {
+    .base_name = TYPE_VIRTIO_MEM_PCI,
+    .generic_name = "virtio-mem-pci",
+    .instance_size = sizeof(VirtIOMEMPCI),
+    .instance_init = virtio_mem_pci_instance_init,
+    .class_init = virtio_mem_pci_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_MEMORY_DEVICE },
+        { }
+    },
+};
+
+static void virtio_mem_pci_register_types(void)
+{
+    virtio_pci_types_register(&virtio_mem_pci_info);
+}
+type_init(virtio_mem_pci_register_types)
diff --git a/hw/virtio/virtio-mem-pci.h b/hw/virtio/virtio-mem-pci.h
new file mode 100644
index 0000000000..8820cd6628
--- /dev/null
+++ b/hw/virtio/virtio-mem-pci.h
@@ -0,0 +1,33 @@
+/*
+ * Virtio MEM PCI device
+ *
+ * Copyright (C) 2020 Red Hat, Inc.
+ *
+ * Authors:
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_VIRTIO_MEM_PCI_H
+#define QEMU_VIRTIO_MEM_PCI_H
+
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-mem.h"
+
+typedef struct VirtIOMEMPCI VirtIOMEMPCI;
+
+/*
+ * virtio-mem-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_MEM_PCI "virtio-mem-pci-base"
+#define VIRTIO_MEM_PCI(obj) \
+        OBJECT_CHECK(VirtIOMEMPCI, (obj), TYPE_VIRTIO_MEM_PCI)
+
+struct VirtIOMEMPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOMEM vdev;
+};
+
+#endif /* QEMU_VIRTIO_MEM_PCI_H */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index a4e9c33416..c1bf7d5356 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -87,6 +87,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
 #define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
 #define PCI_DEVICE_ID_VIRTIO_IOMMU       0x1014
+#define PCI_DEVICE_ID_VIRTIO_MEM         0x1015
 
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
-- 
2.26.2


