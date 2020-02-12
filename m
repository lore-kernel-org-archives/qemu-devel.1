Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A85C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0F420659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUmhtLCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0F420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sGf-0002oT-0I
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sBo-0001uN-IE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sBn-0006Eh-53
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sBn-0006Dc-0z
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bM2sLCVmdoxBoIAr1ChW/OgRh7L93CZY2ADROzfXC+w=;
 b=GUmhtLCMzkq6ubWsrqwSuhW9xCIOrBDjCKLsGJyomISbrmGVeFETlNxfvBcE+cAOs0BFeb
 zLihwDF0DAXSCXBjOX/fseZ3g5sNtzpefozJbkfIWYiaDF4ma1tG7vKj0b6E/L0MEgM3jV
 FEVwXxU4/r7cyvX/wUW8V/1P3sZZgz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-ZfL7LalrN6OLFr_Fabu8OA-1; Wed, 12 Feb 2020 08:36:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70739800D48;
 Wed, 12 Feb 2020 13:36:21 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACA5526FB6;
 Wed, 12 Feb 2020 13:36:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/16] pc: Support for virtio-mem-pci
Date: Wed, 12 Feb 2020 14:35:50 +0100
Message-Id: <20200212133601.10555-6-david@redhat.com>
In-Reply-To: <20200212133601.10555-1-david@redhat.com>
References: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ZfL7LalrN6OLFr_Fabu8OA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/Kconfig |  1 +
 hw/i386/pc.c    | 42 ++++++++++++++++++++++++------------------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index cdc851598c..e8ce582edd 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -35,6 +35,7 @@ config PC
     select ACPI_PCI
     select ACPI_VMGENID
     select VIRTIO_PMEM_SUPPORTED
+    select VIRTIO_MEM_SUPPORTED
=20
 config PC_PCI
     bool
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ddce4230a..ed8850f31d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -85,6 +85,7 @@
 #include "hw/net/ne2000-isa.h"
 #include "standard-headers/asm-x86/bootparam.h"
 #include "hw/virtio/virtio-pmem-pci.h"
+#include "hw/virtio/virtio-mem-pci.h"
 #include "hw/mem/memory-device.h"
 #include "sysemu/replay.h"
 #include "qapi/qmp/qerror.h"
@@ -1648,8 +1649,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_d=
ev,
     numa_cpu_pre_plug(cpu_slot, dev, errp);
 }
=20
-static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
-                                        DeviceState *dev, Error **errp)
+static void pc_virtio_md_pci_pre_plug(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
 {
     HotplugHandler *hotplug_dev2 =3D qdev_get_bus_hotplug_handler(dev);
     Error *local_err =3D NULL;
@@ -1660,7 +1661,7 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandle=
r *hotplug_dev,
          * order. This should never be the case on x86, however better add
          * a safety net.
          */
-        error_setg(errp, "virtio-pmem-pci not supported on this bus.");
+        error_setg(errp, "virtio based memory devices not supported on thi=
s bus.");
         return;
     }
     /*
@@ -1675,8 +1676,8 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandle=
r *hotplug_dev,
     error_propagate(errp, local_err);
 }
=20
-static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
-                                    DeviceState *dev, Error **errp)
+static void pc_virtio_md_pci_plug(HotplugHandler *hotplug_dev,
+                                  DeviceState *dev, Error **errp)
 {
     HotplugHandler *hotplug_dev2 =3D qdev_get_bus_hotplug_handler(dev);
     Error *local_err =3D NULL;
@@ -1694,15 +1695,15 @@ static void pc_virtio_pmem_pci_plug(HotplugHandler =
*hotplug_dev,
     error_propagate(errp, local_err);
 }
=20
-static void pc_virtio_pmem_pci_unplug_request(HotplugHandler *hotplug_dev,
-                                              DeviceState *dev, Error **er=
rp)
+static void pc_virtio_md_pci_unplug_request(HotplugHandler *hotplug_dev,
+                                            DeviceState *dev, Error **errp=
)
 {
     /* We don't support virtio pmem hot unplug */
     error_setg(errp, "virtio pmem device unplug not supported.");
 }
=20
-static void pc_virtio_pmem_pci_unplug(HotplugHandler *hotplug_dev,
-                                      DeviceState *dev, Error **errp)
+static void pc_virtio_md_pci_unplug(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
 {
     /* We don't support virtio pmem hot unplug */
 }
@@ -1714,8 +1715,9 @@ static void pc_machine_device_pre_plug_cb(HotplugHand=
ler *hotplug_dev,
         pc_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_pre_plug(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
-        pc_virtio_pmem_pci_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        pc_virtio_md_pci_pre_plug(hotplug_dev, dev, errp);
     }
 }
=20
@@ -1726,8 +1728,9 @@ static void pc_machine_device_plug_cb(HotplugHandler =
*hotplug_dev,
         pc_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_plug(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
-        pc_virtio_pmem_pci_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        pc_virtio_md_pci_plug(hotplug_dev, dev, errp);
     }
 }
=20
@@ -1738,8 +1741,9 @@ static void pc_machine_device_unplug_request_cb(Hotpl=
ugHandler *hotplug_dev,
         pc_memory_unplug_request(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
-        pc_virtio_pmem_pci_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        pc_virtio_md_pci_unplug_request(hotplug_dev, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for not supported de=
vice"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -1753,8 +1757,9 @@ static void pc_machine_device_unplug_cb(HotplugHandle=
r *hotplug_dev,
         pc_memory_unplug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_unplug_cb(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
-        pc_virtio_pmem_pci_unplug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        pc_virtio_md_pci_unplug(hotplug_dev, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -1766,7 +1771,8 @@ static HotplugHandler *pc_get_hotplug_handler(Machine=
State *machine,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
=20
--=20
2.24.1


