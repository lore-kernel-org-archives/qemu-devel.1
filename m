Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97C7C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A4F20707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWJtKaRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A4F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDuo-0006c7-KV
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iYDiN-0000gJ-MI
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iYDiM-0000MK-4S
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24188
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iYDiL-0000MF-W2
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574447489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iuvJrdkj+jiCFJbEGxVZxnxKHKNSAoCsIkt5jQKyK5o=;
 b=jWJtKaRFKzWYErKHu+NKIS8j4zrVCw79cB5rnpYbIldoEb8qtn8U3aoj4sK81Cx8pQx/tg
 UIKIM0Tz6DRpB78TSSzjbJEJ+E0N4Ca01b5dMaHozSEcrDkBZyqE99XOpjZWIPEQqyUZ1R
 7N67OKwR/gzqeuUQ+iSzRE/Nt/sA8/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-fj9fONsDO5ePGKTNViJrCw-1; Fri, 22 Nov 2019 13:31:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E08F8018A1;
 Fri, 22 Nov 2019 18:31:25 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3CFE6E712;
 Fri, 22 Nov 2019 18:31:14 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, jean-philippe.brucker@arm.com, bharatb.linux@gmail.com,
 yang.zhong@intel.com, dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH for-5.0 v11 11/20] hw/arm/virt: Add the virtio-iommu device
 tree mappings
Date: Fri, 22 Nov 2019 19:29:34 +0100
Message-Id: <20191122182943.4656-12-eric.auger@redhat.com>
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: fj9fONsDO5ePGKTNViJrCw-1
X-Mimecast-Spam-Score: 0
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
Cc: kevin.tian@intel.com, peterx@redhat.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds the "virtio,pci-iommu" node in the host bridge node and
the RID mapping, excluding the IOMMU RID.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

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
 hw/arm/virt.c                | 53 +++++++++++++++++++++++++++++++-----
 hw/virtio/virtio-iommu-pci.c |  3 --
 include/hw/arm/virt.h        |  2 ++
 3 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d4bedc2607..cb6a95e7c8 100644
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
@@ -1181,6 +1184,30 @@ static void create_smmu(const VirtMachineState *vms,=
 qemu_irq *pic,
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
 static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
 {
     hwaddr base_mmio =3D vms->memmap[VIRT_PCIE_MMIO].base;
@@ -1258,7 +1285,7 @@ static void create_pcie(VirtMachineState *vms, qemu_i=
rq *pic)
         }
     }
=20
-    nodename =3D g_strdup_printf("/pcie@%" PRIx64, base);
+    nodename =3D vms->pciehb_nodename =3D g_strdup_printf("/pcie@%" PRIx64=
, base);
     qemu_fdt_add_subnode(vms->fdt, nodename);
     qemu_fdt_setprop_string(vms->fdt, nodename,
                             "compatible", "pci-host-ecam-generic");
@@ -1301,13 +1328,17 @@ static void create_pcie(VirtMachineState *vms, qemu=
_irq *pic)
     if (vms->iommu) {
         vms->iommu_phandle =3D qemu_fdt_alloc_phandle(vms->fdt);
=20
-        create_smmu(vms, pic, pci->bus);
+        switch (vms->iommu) {
+        case VIRT_IOMMU_SMMUV3:
+            create_smmu(vms, pic, pci->bus);
+            qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
+                                   0x0, vms->iommu_phandle, 0x0, 0x10000);
+            break;
+        default:
+            g_assert_not_reached();
+        }
=20
-        qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
-                               0x0, vms->iommu_phandle, 0x0, 0x10000);
     }
-
-    g_free(nodename);
 }
=20
 static void create_platform_bus(VirtMachineState *vms, qemu_irq *pic)
@@ -1972,6 +2003,13 @@ static void virt_machine_device_plug_cb(HotplugHandl=
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
@@ -1985,7 +2023,8 @@ static HotplugHandler *virt_machine_get_hotplug_handl=
er(MachineState *machine,
                                                         DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
-       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
+       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) ||
+       (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI))) {
         return HOTPLUG_HANDLER(machine);
     }
=20
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 280230b31e..4cfae1f9df 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -31,9 +31,6 @@ struct VirtIOIOMMUPCI {
=20
 static Property virtio_iommu_pci_properties[] =3D {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
-    DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
-                      vdev.nb_reserved_regions, vdev.reserved_regions,
-                      qdev_prop_interval, Interval),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 0b41083e9d..32fb1142ef 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -124,8 +124,10 @@ typedef struct {
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


