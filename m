Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67716C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31BED218AC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpL50YCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BED218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j007x-0003VA-Dr
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 04:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j000z-00082z-1K
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j000x-0004ym-Fx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:33:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30691
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j000x-0004yg-BE
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581068011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjj53LrBeIGvvcEYnT7uMO64MjbtojY7047hfucRt3o=;
 b=UpL50YCDrT1N0QEjpVb29cocEkjsyEJr4qp5ZYDh9LztQI9nRD6iYs6UnKmrqquxhlwXre
 ZRbIC2vHTRy0jV2Ut+JNsxT3aphLavaXPW4OOiij/g3wrxjdUZWTZZ23tLIwP+IwNdkMoo
 Ld514k0gYaD9BwaFZ+IBTRFOVaEL5Kg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-ac-2EBjkM3O3EQTH3kWx7A-1; Fri, 07 Feb 2020 04:33:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9290518A6EC0;
 Fri,  7 Feb 2020 09:33:27 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0708F790E4;
 Fri,  7 Feb 2020 09:33:21 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, jean-philippe@linaro.org,
 dgilbert@redhat.com, quintela@redhat.com, mst@redhat.com, peterx@redhat.com
Subject: [PATCH v14 07/11] virtio-iommu-pci: Add virtio iommu pci support
Date: Fri,  7 Feb 2020 10:31:59 +0100
Message-Id: <20200207093203.3788-8-eric.auger@redhat.com>
In-Reply-To: <20200207093203.3788-1-eric.auger@redhat.com>
References: <20200207093203.3788-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ac-2EBjkM3O3EQTH3kWx7A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kevin.tian@intel.com, bharatb.linux@gmail.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds virtio-iommu-pci, which is the pci proxy for
the virtio-iommu device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

---

v13 -> v14:
- add device_class_set_props

v11 -> v12:
- added Jean's R-b
- remove the array of intervals. Will be introduced later?

v10 -> v11:
- add the reserved_regions array property

v9 -> v10:
- include "hw/qdev-properties.h" header

v8 -> v9:
- add the msi-bypass property
- create virtio-iommu-pci.c
---
 hw/virtio/Makefile.objs          |  1 +
 hw/virtio/virtio-iommu-pci.c     | 88 ++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h             |  1 +
 include/hw/virtio/virtio-iommu.h |  1 +
 qdev-monitor.c                   |  1 +
 5 files changed, 92 insertions(+)
 create mode 100644 hw/virtio/virtio-iommu-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 2fd9da7410..4e4d39a0a4 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -29,6 +29,7 @@ obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-host-pc=
i.o
 obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-pci.o
 obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng-pci.o
 obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon-pci.o
+obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu-pci.o
 obj-$(CONFIG_VIRTIO_9P) +=3D virtio-9p-pci.o
 obj-$(CONFIG_VIRTIO_SCSI) +=3D virtio-scsi-pci.o
 obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk-pci.o
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
new file mode 100644
index 0000000000..d539fcce75
--- /dev/null
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -0,0 +1,88 @@
+/*
+ * Virtio IOMMU PCI Bindings
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ * Written by Eric Auger
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+
+#include "virtio-pci.h"
+#include "hw/virtio/virtio-iommu.h"
+#include "hw/qdev-properties.h"
+
+typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
+
+/*
+ * virtio-iommu-pci: This extends VirtioPCIProxy.
+ *
+ */
+#define VIRTIO_IOMMU_PCI(obj) \
+        OBJECT_CHECK(VirtIOIOMMUPCI, (obj), TYPE_VIRTIO_IOMMU_PCI)
+
+struct VirtIOIOMMUPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOIOMMU vdev;
+};
+
+static Property virtio_iommu_pci_properties[] =3D {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err=
p)
+{
+    VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(vpci_dev);
+    DeviceState *vdev =3D DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_link(OBJECT(dev),
+                             OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
+                             "primary-bus", errp);
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_iommu_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
+    k->realize =3D virtio_iommu_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, virtio_iommu_pci_properties);
+    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_IOMMU;
+    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id =3D PCI_CLASS_OTHERS;
+}
+
+static void virtio_iommu_pci_instance_init(Object *obj)
+{
+    VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_IOMMU);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_iommu_pci_info =3D {
+    .base_name             =3D TYPE_VIRTIO_IOMMU_PCI,
+    .generic_name          =3D "virtio-iommu-pci",
+    .transitional_name     =3D "virtio-iommu-pci-transitional",
+    .non_transitional_name =3D "virtio-iommu-pci-non-transitional",
+    .instance_size =3D sizeof(VirtIOIOMMUPCI),
+    .instance_init =3D virtio_iommu_pci_instance_init,
+    .class_init    =3D virtio_iommu_pci_class_init,
+};
+
+static void virtio_iommu_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_iommu_pci_info);
+}
+
+type_init(virtio_iommu_pci_register)
+
+
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 2acd8321af..cfedf5a995 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -86,6 +86,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
 #define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
+#define PCI_DEVICE_ID_VIRTIO_IOMMU       0x1014
=20
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-io=
mmu.h
index ae88f730cf..6f67f1020a 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -25,6 +25,7 @@
 #include "hw/pci/pci.h"
=20
 #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
+#define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-device-base"
 #define VIRTIO_IOMMU(obj) \
         OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
=20
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 8ce71a206b..dbbe92dfa1 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -67,6 +67,7 @@ static const QDevAlias qdev_alias_table[] =3D {
     { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_S390X },
     { "virtio-input-host-pci", "virtio-input-host",
             QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
+    { "virtio-iommu-pci", "virtio-iommu", QEMU_ARCH_ALL & ~QEMU_ARCH_S390X=
 },
     { "virtio-keyboard-ccw", "virtio-keyboard", QEMU_ARCH_S390X },
     { "virtio-keyboard-pci", "virtio-keyboard",
             QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
--=20
2.20.1


