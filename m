Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72270C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBEF20693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBEF20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVqX-0001vM-Jl
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60920)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hsVpr-0000WT-7o
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hsVpp-0000th-RP
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:22:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48685)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hsVpm-0000qh-NF; Tue, 30 Jul 2019 13:22:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8D703086211;
 Tue, 30 Jul 2019 17:22:45 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6B6860BE5;
 Tue, 30 Jul 2019 17:22:40 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, peter.maydell@linaro.org,
 alex.williamson@redhat.com, jean-philippe@linaro.org, kevin.tian@intel.com
Date: Tue, 30 Jul 2019 19:21:27 +0200
Message-Id: <20190730172137.23114-6-eric.auger@redhat.com>
In-Reply-To: <20190730172137.23114-1-eric.auger@redhat.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 30 Jul 2019 17:22:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 v10 05/15] virtio-iommu: Add the iommu
 regions
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
Cc: tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch initializes the iommu memory regions so that
PCIe end point transactions get translated. The translation
function is not yet implemented though.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v9 -> v10:
- remove pc/virt machine headers
- virtio_iommu_find_add_as: mr_index introduced in that patch
  and name properly freed

v6 -> v7:
- use primary_bus
- rebase on new translate proto featuring iommu_idx

v5 -> v6:
- include qapi/error.h
- fix g_hash_table_lookup key in virtio_iommu_find_add_as

v4 -> v5:
- use PCI bus handle as a key
- use get_primary_pci_bus() callback

v3 -> v4:
- add trace_virtio_iommu_init_iommu_mr

v2 -> v3:
- use IOMMUMemoryRegion
- iommu mr name built with BDF
- rename smmu_get_sid into virtio_iommu_get_sid and use PCI_BUILD_BDF
---
 hw/virtio/trace-events           |  2 +
 hw/virtio/virtio-iommu.c         | 92 ++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-iommu.h |  2 +
 3 files changed, 96 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index c7276116e7..b32169d56c 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -65,3 +65,5 @@ virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id)=
 "domain=3D%d endpoint=3D%d"
 virtio_iommu_detach(uint32_t domain_id, uint32_t ep_id) "domain=3D%d end=
point=3D%d"
 virtio_iommu_map(uint32_t domain_id, uint64_t virt_start, uint64_t virt_=
end, uint64_t phys_start, uint32_t flags) "domain=3D%d virt_start=3D0x%"P=
RIx64" virt_end=3D0x%"PRIx64 " phys_start=3D0x%"PRIx64" flags=3D%d"
 virtio_iommu_unmap(uint32_t domain_id, uint64_t virt_start, uint64_t vir=
t_end) "domain=3D%d virt_start=3D0x%"PRIx64" virt_end=3D0x%"PRIx64
+virtio_iommu_translate(const char *name, uint32_t rid, uint64_t iova, in=
t flag) "mr=3D%s rid=3D%d addr=3D0x%"PRIx64" flag=3D%d"
+virtio_iommu_init_iommu_mr(char *iommu_mr) "init %s"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 658249c81e..1610e2f773 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -22,6 +22,8 @@
 #include "qemu-common.h"
 #include "hw/virtio/virtio.h"
 #include "sysemu/kvm.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "trace.h"
=20
 #include "standard-headers/linux/virtio_ids.h"
@@ -33,6 +35,50 @@
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
=20
+static inline uint16_t virtio_iommu_get_sid(IOMMUDevice *dev)
+{
+    return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
+}
+
+static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
+                                              int devfn)
+{
+    VirtIOIOMMU *s =3D opaque;
+    IOMMUPciBus *sbus =3D g_hash_table_lookup(s->as_by_busptr, bus);
+    static uint32_t mr_index;
+    IOMMUDevice *sdev;
+
+    if (!sbus) {
+        sbus =3D g_malloc0(sizeof(IOMMUPciBus) +
+                         sizeof(IOMMUDevice *) * IOMMU_PCI_DEVFN_MAX);
+        sbus->bus =3D bus;
+        g_hash_table_insert(s->as_by_busptr, bus, sbus);
+    }
+
+    sdev =3D sbus->pbdev[devfn];
+    if (!sdev) {
+        char *name =3D g_strdup_printf("%s-%d-%d",
+                                     TYPE_VIRTIO_IOMMU_MEMORY_REGION,
+                                     mr_index++, devfn);
+        sdev =3D sbus->pbdev[devfn] =3D g_malloc0(sizeof(IOMMUDevice));
+
+        sdev->viommu =3D s;
+        sdev->bus =3D bus;
+        sdev->devfn =3D devfn;
+
+        trace_virtio_iommu_init_iommu_mr(name);
+
+        memory_region_init_iommu(&sdev->iommu_mr, sizeof(sdev->iommu_mr)=
,
+                                 TYPE_VIRTIO_IOMMU_MEMORY_REGION,
+                                 OBJECT(s), name,
+                                 UINT64_MAX);
+        address_space_init(&sdev->as,
+                           MEMORY_REGION(&sdev->iommu_mr), TYPE_VIRTIO_I=
OMMU);
+        g_free(name);
+    }
+    return &sdev->as;
+}
+
 static int virtio_iommu_attach(VirtIOIOMMU *s,
                                struct virtio_iommu_req_attach *req)
 {
@@ -192,6 +238,27 @@ out:
     }
 }
=20
+static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwadd=
r addr,
+                                            IOMMUAccessFlags flag,
+                                            int iommu_idx)
+{
+    IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
+    uint32_t sid;
+
+    IOMMUTLBEntry entry =3D {
+        .target_as =3D &address_space_memory,
+        .iova =3D addr,
+        .translated_addr =3D addr,
+        .addr_mask =3D ~(hwaddr)0,
+        .perm =3D IOMMU_NONE,
+    };
+
+    sid =3D virtio_iommu_get_sid(sdev);
+
+    trace_virtio_iommu_translate(mr->parent_obj.name, sid, addr, flag);
+    return entry;
+}
+
 static void virtio_iommu_get_config(VirtIODevice *vdev, uint8_t *config_=
data)
 {
     VirtIOIOMMU *dev =3D VIRTIO_IOMMU(vdev);
@@ -266,6 +333,15 @@ static void virtio_iommu_device_realize(DeviceState =
*dev, Error **errp)
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
+
+    memset(s->as_by_bus_num, 0, sizeof(s->as_by_bus_num));
+    s->as_by_busptr =3D g_hash_table_new(NULL, NULL);
+
+    if (s->primary_bus) {
+        pci_setup_iommu(s->primary_bus, virtio_iommu_find_add_as, s);
+    } else {
+        error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!")=
;
+    }
 }
=20
 static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp=
)
@@ -324,6 +400,14 @@ static void virtio_iommu_class_init(ObjectClass *kla=
ss, void *data)
     vdc->vmsd =3D &vmstate_virtio_iommu_device;
 }
=20
+static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
+                                                  void *data)
+{
+    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
+
+    imrc->translate =3D virtio_iommu_translate;
+}
+
 static const TypeInfo virtio_iommu_info =3D {
     .name =3D TYPE_VIRTIO_IOMMU,
     .parent =3D TYPE_VIRTIO_DEVICE,
@@ -332,9 +416,17 @@ static const TypeInfo virtio_iommu_info =3D {
     .class_init =3D virtio_iommu_class_init,
 };
=20
+static const TypeInfo virtio_iommu_memory_region_info =3D {
+    .parent =3D TYPE_IOMMU_MEMORY_REGION,
+    .name =3D TYPE_VIRTIO_IOMMU_MEMORY_REGION,
+    .class_init =3D virtio_iommu_memory_region_class_init,
+};
+
+
 static void virtio_register_types(void)
 {
     type_register_static(&virtio_iommu_info);
+    type_register_static(&virtio_iommu_memory_region_info);
 }
=20
 type_init(virtio_register_types)
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-=
iommu.h
index 4d47b6abeb..f55f48d304 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -28,6 +28,8 @@
 #define VIRTIO_IOMMU(obj) \
         OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
=20
+#define TYPE_VIRTIO_IOMMU_MEMORY_REGION "virtio-iommu-memory-region"
+
 #define IOMMU_PCI_BUS_MAX      256
 #define IOMMU_PCI_DEVFN_MAX    256
=20
--=20
2.20.1


