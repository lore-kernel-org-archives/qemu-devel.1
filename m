Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983A7C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF25206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMOKaLdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF25206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGq4-0003Ut-GH
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jWGhY-0005EA-Hw
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:50:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22514
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jWGhW-0004hz-3K
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588758649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsLyeZhBmtaI3y14ev+wnqkHN5tBcDSVj+6Qghyl2/M=;
 b=MMOKaLddODQ0dfMsEPRwyCgslehd2d15+/iTB81DJuF/ZuxXF1htKm1qpV1DJHfCKO52Nr
 FvOZBVm7nv8IK2AJE8lFqF3iGQAymqUFU4zKZISvdem+WDuhYgEKH+cd189uIYMbHl4ld2
 IR3YD3gsaWLMcs9ZVkoEikvFsUYgSw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-VsmSJsduPeeWnxO87wqI0Q-1; Wed, 06 May 2020 05:50:47 -0400
X-MC-Unique: VsmSJsduPeeWnxO87wqI0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B424460;
 Wed,  6 May 2020 09:50:46 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-17.ams2.redhat.com [10.36.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D154F5C1BD;
 Wed,  6 May 2020 09:50:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 11/17] virtio-pci: Proxy for virtio-mem
Date: Wed,  6 May 2020 11:49:42 +0200
Message-Id: <20200506094948.76388-12-david@redhat.com>
In-Reply-To: <20200506094948.76388-1-david@redhat.com>
References: <20200506094948.76388-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's add a proxy for virtio-mem, make it a memory device, and
pass-through the properties.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/Makefile.objs    |   1 +
 hw/virtio/virtio-mem-pci.c | 131 +++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-mem-pci.h |  33 ++++++++++
 include/hw/pci/pci.h       |   1 +
 4 files changed, 166 insertions(+)
 create mode 100644 hw/virtio/virtio-mem-pci.c
 create mode 100644 hw/virtio/virtio-mem-pci.h

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 7df70e977e..b9661f9c01 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -19,6 +19,7 @@ obj-$(call land,$(CONFIG_VHOST_USER_FS),$(CONFIG_VIRTIO=
_PCI)) +=3D vhost-user-fs-p
 obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o
 obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
 obj-$(CONFIG_VIRTIO_MEM) +=3D virtio-mem.o
+common-obj-$(call land,$(CONFIG_VIRTIO_MEM),$(CONFIG_VIRTIO_PCI)) +=3D v=
irtio-mem-pci.o
=20
 ifeq ($(CONFIG_VIRTIO_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock-pci.o
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
new file mode 100644
index 0000000000..a47d21c81f
--- /dev/null
+++ b/hw/virtio/virtio-mem-pci.c
@@ -0,0 +1,131 @@
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
+
+#include "virtio-mem-pci.h"
+#include "hw/mem/memory-device.h"
+#include "qapi/error.h"
+
+static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err=
p)
+{
+    VirtIOMEMPCI *mem_pci =3D VIRTIO_MEM_PCI(vpci_dev);
+    DeviceState *vdev =3D DEVICE(&mem_pci->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_mem_pci_set_addr(MemoryDeviceState *md, uint64_t addr=
,
+                                    Error **errp)
+{
+    object_property_set_uint(OBJECT(md), addr, VIRTIO_MEM_ADDR_PROP, err=
p);
+}
+
+static uint64_t virtio_mem_pci_get_addr(const MemoryDeviceState *md)
+{
+    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_ADDR_PROP,
+                                    &error_abort);
+}
+
+static MemoryRegion *virtio_mem_pci_get_memory_region(MemoryDeviceState =
*md,
+                                                      Error **errp)
+{
+    VirtIOMEMPCI *pci_mem =3D VIRTIO_MEM_PCI(md);
+    VirtIOMEM *vmem =3D VIRTIO_MEM(&pci_mem->vdev);
+    VirtIOMEMClass *vmc =3D VIRTIO_MEM_GET_CLASS(vmem);
+
+    return vmc->get_memory_region(vmem, errp);
+}
+
+static uint64_t virtio_mem_pci_get_plugged_size(const MemoryDeviceState =
*md,
+                                                Error **errp)
+{
+    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_SIZE_PROP,
+                                    errp);
+}
+
+static void virtio_mem_pci_fill_device_info(const MemoryDeviceState *md,
+                                            MemoryDeviceInfo *info)
+{
+    VirtioMEMDeviceInfo *vi =3D g_new0(VirtioMEMDeviceInfo, 1);
+    VirtIOMEMPCI *pci_mem =3D VIRTIO_MEM_PCI(md);
+    VirtIOMEM *vmem =3D VIRTIO_MEM(&pci_mem->vdev);
+    VirtIOMEMClass *vpc =3D VIRTIO_MEM_GET_CLASS(vmem);
+    DeviceState *dev =3D DEVICE(md);
+
+    if (dev->id) {
+        vi->has_id =3D true;
+        vi->id =3D g_strdup(dev->id);
+    }
+
+    /* let the real device handle everything else */
+    vpc->fill_device_info(vmem, vi);
+
+    info->u.virtio_mem.data =3D vi;
+    info->type =3D MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM;
+}
+
+static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
+    MemoryDeviceClass *mdc =3D MEMORY_DEVICE_CLASS(klass);
+
+    k->realize =3D virtio_mem_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_MEM;
+    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id =3D PCI_CLASS_OTHERS;
+
+    mdc->get_addr =3D virtio_mem_pci_get_addr;
+    mdc->set_addr =3D virtio_mem_pci_set_addr;
+    mdc->get_plugged_size =3D virtio_mem_pci_get_plugged_size;
+    mdc->get_memory_region =3D virtio_mem_pci_get_memory_region;
+    mdc->fill_device_info =3D virtio_mem_pci_fill_device_info;
+}
+
+static void virtio_mem_pci_instance_init(Object *obj)
+{
+    VirtIOMEMPCI *dev =3D VIRTIO_MEM_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_MEM);
+    object_property_add_alias(obj, VIRTIO_MEM_BLOCK_SIZE_PROP,
+                              OBJECT(&dev->vdev),
+                              VIRTIO_MEM_BLOCK_SIZE_PROP, &error_abort);
+    object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vd=
ev),
+                              VIRTIO_MEM_SIZE_PROP, &error_abort);
+    object_property_add_alias(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP,
+                              OBJECT(&dev->vdev),
+                              VIRTIO_MEM_REQUESTED_SIZE_PROP, &error_abo=
rt);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_mem_pci_info =3D {
+    .base_name =3D TYPE_VIRTIO_MEM_PCI,
+    .generic_name =3D "virtio-mem-pci",
+    .instance_size =3D sizeof(VirtIOMEMPCI),
+    .instance_init =3D virtio_mem_pci_instance_init,
+    .class_init =3D virtio_mem_pci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
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
index cfedf5a995..fec72d5a31 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -87,6 +87,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
 #define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
 #define PCI_DEVICE_ID_VIRTIO_IOMMU       0x1014
+#define PCI_DEVICE_ID_VIRTIO_MEM         0x1015
=20
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
--=20
2.25.3


