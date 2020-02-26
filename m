Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F271AC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36192084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WE4b1ReG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36192084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40721 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6spO-0000TP-RL
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sez-0005Km-HF
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sey-0000DJ-2X
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29233
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sex-0000CA-Un
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfB6vgxyzAB71+dIm3jms7txlRQYEIaRwa1XJn1djKE=;
 b=WE4b1ReGl/CEmvitWOXNUlCuLmnQG1WlhHfeCExMGK0XtwsMqrem/TZWdWZQboTKPl0lpE
 pvyO8FzzaWP2RBqOSVZotXbselWiy3q4/6n7cl0eTz8MRlycYmBuGtS9PiuEKpSI0hO/Bo
 XBWcZ3uJ6W2jTRQDOKjK4CVdb2jKdcU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-elaMNFpjNj-zv48GlSahLg-1; Wed, 26 Feb 2020 04:07:13 -0500
X-MC-Unique: elaMNFpjNj-zv48GlSahLg-1
Received: by mail-wr1-f70.google.com with SMTP id o9so1182042wrw.14
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XGike9/092nOdP42PsYQlAuujche/x1Md0Prv3YFBIc=;
 b=SMzgWhZ3Cd4YYqgBEL6dEDaYZ1t/vnGeiXlVa2oTePb7jPifZuiUgyFD3BhwFclYlQ
 JgYqKK1VFq9RWd5DADdwWpi2zWbD+/M3hwlPnh8xYLSmCI/e5mlaUP0G0TybWlwZrTDX
 PnWxmhEgd48Y0To/Bs+hQggXkKyrMbeK37lz95n+Qgce/IQUj9P/kfmdgLS4dP/1WhSU
 dd0MErRiY9I6S3UjsC/XC3/g2b7/+qoqdyg4W9G1hTGC/RKut8kjgjp90DJsNfEulICT
 7bYpjKoza0f0UZXlUPc8Dg4+9ciJi3didJFS737oVeOVSQcyxTV345PV/4ZDsgxZjpO0
 oeFA==
X-Gm-Message-State: APjAAAWFYN12H4T1VFcI6pwC0+5lDR6cyeGbsPik6kxa7buhEPEeRYh5
 SigjAuFLUxhLyMkheR9pDJ8+kbgKUmltOSXKJdYeCzRw2ZpS/0dRYnu3mTjKV3mfy/s/SCHTsiN
 nilDOBHdQyDFg7Mw=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr4431563wmd.39.1582708031241; 
 Wed, 26 Feb 2020 01:07:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/OcDu/sSdOProVr1ww2fUAfud7K79eQshVJExQnKz7muQE2U7D4nvK0lHZ2OGFaQnNN3BMg==
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr4431533wmd.39.1582708030962; 
 Wed, 26 Feb 2020 01:07:10 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 g25sm8467980wmh.3.2020.02.26.01.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:07:10 -0800 (PST)
Date: Wed, 26 Feb 2020 04:07:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 19/30] virtio-iommu-pci: Add virtio iommu pci support
Message-ID: <20200226090010.708934-20-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

This patch adds virtio-iommu-pci, which is the pci proxy for
the virtio-iommu device.

Currently non DT integration is not yet supported by the kernel.
So the machine must implement a hotplug handler for the
virtio-iommu-pci device that creates the device tree iommu-map
bindings as documented in kernel documentation:

Documentation/devicetree/bindings/virtio/iommu.txt

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Message-Id: <20200214132745.23392-9-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h             |   1 +
 include/hw/virtio/virtio-iommu.h |   1 +
 hw/virtio/virtio-iommu-pci.c     | 104 +++++++++++++++++++++++++++++++
 qdev-monitor.c                   |   1 +
 hw/virtio/Makefile.objs          |   1 +
 5 files changed, 108 insertions(+)
 create mode 100644 hw/virtio/virtio-iommu-pci.c

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
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
new file mode 100644
index 0000000000..3dfbf55b47
--- /dev/null
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -0,0 +1,104 @@
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
+#include "qapi/error.h"
+#include "hw/boards.h"
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
+    if (!qdev_get_machine_hotplug_handler(DEVICE(vpci_dev))) {
+        MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
+
+        error_setg(errp,
+                   "%s machine fails to create iommu-map device tree bindi=
ngs",
+                   mc->name);
+        error_append_hint(errp,
+                          "Check you machine implements a hotplug handler =
"
+                          "for the virtio-iommu-pci device\n");
+        error_append_hint(errp, "Check the guest is booted without FW or w=
ith "
+                          "-no-acpi\n");
+        return;
+    }
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
+    dc->hotpluggable =3D false;
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
--=20
MST


