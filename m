Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6889AC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33ECD2084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1q/2W7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33ECD2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sgG-0007aw-9l
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sf4-0005Su-54
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sf2-0000Jz-Hu
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60435
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sf2-0000J8-DP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mH6Uh7KB+qDOlqySuiYCwzhwjo90oVgrXa4q2w401+k=;
 b=g1q/2W7Mpxu3M7TQ11s+NeiZkxDToNkzuYZrsbhUHxANPEN/NHPLOZkMDKiDF4tUenoI0H
 WaMlN07YwnqaoVdfwV3cE2Mt2UNyoz9ROJCQc2w3yohCd5/ETvWjvIPDxat+sA4QMte+BA
 Vq4bCZanaDV8CdUMAiUSoKEnIJItUI0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-Fdxw6sBNO5u5IGrAKChbGg-1; Wed, 26 Feb 2020 04:07:17 -0500
X-MC-Unique: Fdxw6sBNO5u5IGrAKChbGg-1
Received: by mail-wm1-f71.google.com with SMTP id 7so456875wmf.9
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=L8WBI983W+7RiE8lzDwmxcDHbYbc+B58tFNCqwSyA9I=;
 b=ncvcH2tEJEWByC4BT27Vy92QtjGdhQL+s283gaqj28jO368geuxigmDxu9aybfx6yD
 TGCw2brMIFRIHmwoOSDwfyPFKYHkg0yArkyqMcASlnspUIlOz5TtWbPG19akrD8WBh28
 6khZEmhcfB5QG+MBj4nvvewgyhaBaWVf26ACWth7Puez2BIl6Mqv9F/jGged3W8rtu8X
 FfOTPTuR5aHMCAWXr9qMsqgXp/DahrCI9hjHKVoRDPZbN+WaWEr4yGZWk6g+YPY7maNQ
 zsjLWVn/SdCgQTARea0Mt00104cPGJEbTJONVchP1N1dTG7lxNUOgi/XKTZLSYUgeRG4
 NhQw==
X-Gm-Message-State: APjAAAWHsy367MBmg6Cx90shGqHso3yGvCf99EgDmW8Q3l8105lWhOkn
 QCrYLnLKt0ZwsG4RAnt2cENdHGVKXQtZfm5D8y1ktMEMQxMyl1MeUQAqF5drhuz7faigKPfQzMh
 4BU2SLrZqndnFLog=
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr4344441wrs.386.1582708036183; 
 Wed, 26 Feb 2020 01:07:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqz34ljgP5zjupyOwfxmQfooIgBh8z5HRXBW5f+JaES3qFqankM2JosdUKwNSbHhqwh5pMIWSQ==
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr4344413wrs.386.1582708035947; 
 Wed, 26 Feb 2020 01:07:15 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 y7sm7010112wmd.1.2020.02.26.01.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:07:15 -0800 (PST)
Date: Wed, 26 Feb 2020 04:07:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 20/30] hw/arm/virt: Add the virtio-iommu device tree mappings
Message-ID: <20200226090010.708934-21-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Adds the "virtio,pci-iommu" node in the host bridge node and
the RID mapping, excluding the IOMMU RID.

This is done in the virtio-iommu-pci hotplug handler which
gets called only if no firmware is loaded or if -no-acpi is
passed on the command line. As non DT integration is
not yet supported by the kernel we must make sure we
are in DT mode. This limitation will be removed as soon
as the topology description feature gets supported.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

Message-Id: <20200214132745.23392-10-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h |  2 ++
 hw/arm/virt.c         | 57 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 71508bf40c..02f500cb8e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -125,8 +125,10 @@ typedef struct {
     bool virt;
     int32_t gic_version;
     VirtIOMMUType iommu;
+    uint16_t virtio_iommu_bdf;
     struct arm_boot_info bootinfo;
     MemMapEntry *memmap;
+    char *pciehb_nodename;
     const int *irqmap;
     int smp_cpus;
     void *fdt;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f788fe27d6..cfe317922f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -32,6 +32,7 @@
 #include "qemu-common.h"
 #include "qemu/units.h"
 #include "qemu/option.h"
+#include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
@@ -54,6 +55,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/arm/sysbus-fdt.h"
 #include "hw/platform-bus.h"
 #include "hw/qdev-properties.h"
@@ -71,6 +73,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
+#include "hw/virtio/virtio-iommu.h"
=20
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1180,6 +1183,30 @@ static void create_smmu(const VirtMachineState *vms,
     g_free(node);
 }
=20
+static void create_virtio_iommu_dt_bindings(VirtMachineState *vms, Error *=
*errp)
+{
+    const char compat[] =3D "virtio,pci-iommu";
+    uint16_t bdf =3D vms->virtio_iommu_bdf;
+    char *node;
+
+    vms->iommu_phandle =3D qemu_fdt_alloc_phandle(vms->fdt);
+
+    node =3D g_strdup_printf("%s/virtio_iommu@%d", vms->pciehb_nodename, b=
df);
+    qemu_fdt_add_subnode(vms->fdt, node);
+    qemu_fdt_setprop(vms->fdt, node, "compatible", compat, sizeof(compat))=
;
+    qemu_fdt_setprop_sized_cells(vms->fdt, node, "reg",
+                                 1, bdf << 8, 1, 0, 1, 0,
+                                 1, 0, 1, 0);
+
+    qemu_fdt_setprop_cell(vms->fdt, node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(vms->fdt, node, "phandle", vms->iommu_phandle);
+    g_free(node);
+
+    qemu_fdt_setprop_cells(vms->fdt, vms->pciehb_nodename, "iommu-map",
+                           0x0, vms->iommu_phandle, 0x0, bdf,
+                           bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff - =
bdf);
+}
+
 static void create_pcie(VirtMachineState *vms)
 {
     hwaddr base_mmio =3D vms->memmap[VIRT_PCIE_MMIO].base;
@@ -1258,7 +1285,7 @@ static void create_pcie(VirtMachineState *vms)
         }
     }
=20
-    nodename =3D g_strdup_printf("/pcie@%" PRIx64, base);
+    nodename =3D vms->pciehb_nodename =3D g_strdup_printf("/pcie@%" PRIx64=
, base);
     qemu_fdt_add_subnode(vms->fdt, nodename);
     qemu_fdt_setprop_string(vms->fdt, nodename,
                             "compatible", "pci-host-ecam-generic");
@@ -1301,13 +1328,16 @@ static void create_pcie(VirtMachineState *vms)
     if (vms->iommu) {
         vms->iommu_phandle =3D qemu_fdt_alloc_phandle(vms->fdt);
=20
-        create_smmu(vms, pci->bus);
-
-        qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
-                               0x0, vms->iommu_phandle, 0x0, 0x10000);
+        switch (vms->iommu) {
+        case VIRT_IOMMU_SMMUV3:
+            create_smmu(vms, pci->bus);
+            qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
+                                   0x0, vms->iommu_phandle, 0x0, 0x10000);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
-
-    g_free(nodename);
 }
=20
 static void create_platform_bus(VirtMachineState *vms)
@@ -1976,6 +2006,13 @@ static void virt_machine_device_plug_cb(HotplugHandl=
er *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_memory_plug(hotplug_dev, dev, errp);
     }
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        PCIDevice *pdev =3D PCI_DEVICE(dev);
+
+        vms->iommu =3D VIRT_IOMMU_VIRTIO;
+        vms->virtio_iommu_bdf =3D pci_get_bdf(pdev);
+        create_virtio_iommu_dt_bindings(vms, errp);
+    }
 }
=20
 static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_=
dev,
@@ -1992,7 +2029,13 @@ static HotplugHandler *virt_machine_get_hotplug_hand=
ler(MachineState *machine,
        (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
         return HOTPLUG_HANDLER(machine);
     }
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        VirtMachineState *vms =3D VIRT_MACHINE(machine);
=20
+        if (!vms->bootinfo.firmware_loaded || !acpi_enabled) {
+            return HOTPLUG_HANDLER(machine);
+        }
+    }
     return NULL;
 }
=20
--=20
MST


