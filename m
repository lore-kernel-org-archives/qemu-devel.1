Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F09C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52CE218AC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpLM8q2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52CE218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j009V-000681-Pc
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 04:42:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j001A-0008Oc-NF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j0019-00050J-Jv
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:33:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33860
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j0019-000508-Fs
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581068023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+FSfpCqYhX3vQLABhToXbkcS42+ejiK6nNxnywqqoM=;
 b=dpLM8q2s5Qt5Am9XwOVvKh9UlIQgtyiQdxPxjuUgavrGNri+FfhQOqrm1WzTkkuD/3OvfX
 h7DHY7CBdv/r4ioKM6yeJMG7bLYfYwJsEK6M2PYh4605JIByV1xTBoOhdpoh+z0+XP/sSh
 WXUdlm48NQ2xR1ykZKUbN6+zgErIxjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-py5o6Y_FOI2BiIrsDdqplg-1; Fri, 07 Feb 2020 04:33:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 255258010F0;
 Fri,  7 Feb 2020 09:33:40 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E28C790EB;
 Fri,  7 Feb 2020 09:33:27 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, jean-philippe@linaro.org,
 dgilbert@redhat.com, quintela@redhat.com, mst@redhat.com, peterx@redhat.com
Subject: [PATCH v14 08/11] virtio-iommu-pci: Introduce the x-dt-binding option
Date: Fri,  7 Feb 2020 10:32:00 +0100
Message-Id: <20200207093203.3788-9-eric.auger@redhat.com>
In-Reply-To: <20200207093203.3788-1-eric.auger@redhat.com>
References: <20200207093203.3788-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: py5o6Y_FOI2BiIrsDdqplg-1
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

At the moment, the kernel only supports device tree
integration of the virtio-iommu. DT bindings between the
PCI root complex and the IOMMU must be created by the machine
in conformance to:

Documentation/devicetree/bindings/virtio/iommu.txt.

To make sure the end-user is aware of this, force him to use the
temporary device option "x-dt-binding" and also double check the
machine has a hotplug handler for the virtio-iommu-pci device.
This hotplug handler is in charge of creating those DT bindings.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>

---

May be squashed with previous patch
---
 hw/virtio/virtio-iommu-pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index d539fcce75..3d06e14000 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -14,6 +14,7 @@
 #include "virtio-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/qdev-properties.h"
+#include "qapi/error.h"
=20
 typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
=20
@@ -27,10 +28,12 @@ typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
 struct VirtIOIOMMUPCI {
     VirtIOPCIProxy parent_obj;
     VirtIOIOMMU vdev;
+    bool dt_binding;
 };
=20
 static Property virtio_iommu_pci_properties[] =3D {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_BOOL("x-dt-binding", VirtIOIOMMUPCI, dt_binding, false),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -39,6 +42,21 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpc=
i_dev, Error **errp)
     VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(vpci_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
=20
+    if (!dev->dt_binding) {
+        error_setg(errp,
+                   "Instantiation currently only is possible if the machin=
e "
+                   "creates device tree iommu-map bindings, ie. ACPI is no=
t "
+                   "yet supported");
+        error_append_hint(errp, "use -virtio-iommu-pci,x-dt-binding\n");
+        return;
+    }
+
+    if (!qdev_get_machine_hotplug_handler(DEVICE(vpci_dev))) {
+        error_setg(errp,
+                   "The machine does not implement a virtio-iommu-pci hotp=
lug "
+                   " handler that creates the device tree iommu-map bindin=
gs");
+       return;
+    }
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
     object_property_set_link(OBJECT(dev),
                              OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
--=20
2.20.1


