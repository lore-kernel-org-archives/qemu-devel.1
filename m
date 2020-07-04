Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B0FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907C420720
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0r78Ywr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907C420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmzq-0003Ah-Rf
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvS-0003AQ-89
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21709
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvO-0001Oh-NA
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0fQeQikRy8Q2V3Lt7CmPVpto3iu6bzueyFNbeNFBh7o=;
 b=f0r78Ywrucy5JR9Wz9IIRp4TB9HjZK/fS+xEdWSJvI690MSZkrkfdzWkCOSIvETRAJkn42
 qky83JNPOoq1fD8IOwhImZhQdwNaow12BMwmzG8RAVr2JRHqheJwym8TbsKsCgPM9+LbJo
 nR3cVzin2m6Vr+gxB7U3V+eF49wMD+s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-DrLHUaS3P0WgTZFnrYzwDw-1; Sat, 04 Jul 2020 14:30:04 -0400
X-MC-Unique: DrLHUaS3P0WgTZFnrYzwDw-1
Received: by mail-wm1-f72.google.com with SMTP id g6so34361647wmk.4
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0fQeQikRy8Q2V3Lt7CmPVpto3iu6bzueyFNbeNFBh7o=;
 b=Rhg55JdPUrN7uR4z11mIARTfFNKJGKkBFitEdgFS2IQAlgIFlUv/gNMF/PlZIGcYf2
 Atvzas/bT54uY1PdATBGSBRES7F8y/syNmHgn0lJ5zZ//9mr2q1+ibFQZn7G8I2YfeKb
 P0w6Ida37affM4CUamqAaqsZp+IAvqiEs1TDKExVaasTb1/RyCBIRBpNPW8AEXjWZt5Q
 4w0z+GiQiTLu4QNO8Nj3IbP9gY4EAj1OWQdHmxeiuBsNKA2s8zpaYYb/7Pupo8Cjpudu
 yQnqkg95tNqsQlmKC48wAzLfMkqz3dSD3jMSX8OMiLxgKNO8Kb68QTvMG4nMJz8TGJJq
 MduA==
X-Gm-Message-State: AOAM533La/ARqobXWu1Jodh8qCL953GRh4PA74myZ0EyRD86Jwlr74nV
 P69UaN4mEgFYGZDpxj1GLXLFZU1z0/iy/YcQw6/U4dhlp4L+xBePUvRBMpFv4hX0Z/fBas1ICb0
 1GJu2HsMWL+z/OQ8=
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr13168585wra.118.1593887402976; 
 Sat, 04 Jul 2020 11:30:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0Ti6I3VvzltQfE1SULhddlz7M2/51SoTIFIO40tkyod0ZJnfKud/GG1oETZf5d6aSUJuS4Q==
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr13168571wra.118.1593887402772; 
 Sat, 04 Jul 2020 11:30:02 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 d2sm18177656wrs.95.2020.07.04.11.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:02 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 14/41] virtio-pci: Proxy for virtio-mem
Message-ID: <20200704182750.1088103-15-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:14
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let's add a proxy for virtio-mem, make it a memory device, and
pass-through the properties.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-12-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mem-pci.h |  33 ++++++++++
 include/hw/pci/pci.h       |   1 +
 hw/virtio/virtio-mem-pci.c | 129 +++++++++++++++++++++++++++++++++++++
 hw/virtio/Makefile.objs    |   1 +
 4 files changed, 164 insertions(+)
 create mode 100644 hw/virtio/virtio-mem-pci.h
 create mode 100644 hw/virtio/virtio-mem-pci.c

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
-- 
MST


