Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B65EC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C2620726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxGd/90f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C2620726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Otv-0007d6-Vn
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 07:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j0Oo2-0006Ya-JH
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j0Oo1-0000ZU-63
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:01:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34555
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j0Oo1-0000Yz-1F
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581163308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N6F+urxqIb4bw2+jdRab69JKVLlY6lFsqKuHOAjpVU8=;
 b=KxGd/90fp/oSB9pYsNKyDEIPn6+LT+x/geKG9QdnfZs0XrRNeOBRznu9FQhE/sZzQ3Rv8Z
 YxuoL5TBcBBk58Ldvw2PUfopQNR4fGTCKpBEReSPdbGUHv6ckSYnzu3LBXUsEg7A6cK5/W
 PTKCs1tii9LBwaugS0uouX1GfXSJPgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-CsNV7baZM42_COzkZwuFrg-1; Sat, 08 Feb 2020 07:01:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24F2C8018A9;
 Sat,  8 Feb 2020 12:01:45 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC9E55C545;
 Sat,  8 Feb 2020 12:01:40 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, jean-philippe@linaro.org,
 dgilbert@redhat.com, quintela@redhat.com, mst@redhat.com, peterx@redhat.com
Subject: [PATCH v15 8/9] hw/arm/virt: Add the virtio-iommu device tree mappings
Date: Sat,  8 Feb 2020 13:00:21 +0100
Message-Id: <20200208120022.1920-9-eric.auger@redhat.com>
In-Reply-To: <20200208120022.1920-1-eric.auger@redhat.com>
References: <20200208120022.1920-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: CsNV7baZM42_COzkZwuFrg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Adds the "virtio,pci-iommu" node in the host bridge node and
the RID mapping, excluding the IOMMU RID.

This is done in the virtio-iommu-pci hotplug handler which
gets called only if no firmware is loaded or if -no-acpi is
passed on the command line. As non DT integration is
not yet supported by the kernel we must make sure we
are in DT mode. This limitation will be removed as soon
as the topology description feature gets supported.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v14 -> v15:
- only support the hotplug handler for virtio-iommu-pci if
  dt can be guaranteed

v11 -> v12:
- Added Jean's R-b

v10 -> v11:
- remove msi_bypass

v8 -> v9:
- disable msi-bypass property
- addition of the subnode is handled is the hotplug handler
  and IOMMU RID is notimposed anymore

v6 -> v7:
- align to the smmu instantiation code

v4 -> v5:
- VirtMachineClass no_iommu added in this patch
- Use object_resolve_path_type
---
 hw/arm/virt.c         | 57 +++++++++++++++++++++++++++++++++++++------
 include/hw/arm/virt.h |  2 ++
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f788fe27d6..784e70c89d 100644
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
+static void create_virtio_iommu(VirtMachineState *vms, Error **errp)
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
+        create_virtio_iommu(vms, errp);
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
--=20
2.20.1


