Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B885EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885CB20726
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+Xp0n4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885CB20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDmS-00051z-Ej
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iYDhU-00087W-AY
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iYDhS-0008Rw-AG
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:30:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25320
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iYDhS-0008RN-5O
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574447433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IYq9Kbn8tUyBJ5YbMtHCok3UyrIzqucJ1IOR+X4VnBk=;
 b=J+Xp0n4uIdbR+ujSr+Ekf1F8leYR/7nufOkxvC4O1yZt1fh8BT82Stnzham19x1nmY1Q22
 iUFgCa/iUffmFqVijtr1pgSbIHFE8E1RLUFGXfbkne4xVrhSlnny//LHBNbM6m0aw6VXH5
 j+3xASownj16pfVJLBWwE7EVITT5GI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-tMeRrcjlNSme2BkKYasAVw-1; Fri, 22 Nov 2019 13:30:32 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83A70108C303;
 Fri, 22 Nov 2019 18:30:30 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 273536E712;
 Fri, 22 Nov 2019 18:30:26 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, jean-philippe.brucker@arm.com, bharatb.linux@gmail.com,
 yang.zhong@intel.com, dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH for-5.0 v11 04/20] virtio-iommu: Add the iommu regions
Date: Fri, 22 Nov 2019 19:29:27 +0100
Message-Id: <20191122182943.4656-5-eric.auger@redhat.com>
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: tMeRrcjlNSme2BkKYasAVw-1
X-Mimecast-Spam-Score: 0
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
Cc: kevin.tian@intel.com, peterx@redhat.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch initializes the iommu memory regions so that
PCIe end point transactions get translated. The translation
function is not yet implemented though.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v10 -> v11:
- use g_hash_table_new_full for allocating as_by_busptr

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
@@ -65,3 +65,5 @@ virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id) "=
domain=3D%d endpoint=3D%d"
 virtio_iommu_detach(uint32_t domain_id, uint32_t ep_id) "domain=3D%d endpo=
int=3D%d"
 virtio_iommu_map(uint32_t domain_id, uint64_t virt_start, uint64_t virt_en=
d, uint64_t phys_start, uint32_t flags) "domain=3D%d virt_start=3D0x%"PRIx6=
4" virt_end=3D0x%"PRIx64 " phys_start=3D0x%"PRIx64" flags=3D%d"
 virtio_iommu_unmap(uint32_t domain_id, uint64_t virt_start, uint64_t virt_=
end) "domain=3D%d virt_start=3D0x%"PRIx64" virt_end=3D0x%"PRIx64
+virtio_iommu_translate(const char *name, uint32_t rid, uint64_t iova, int =
flag) "mr=3D%s rid=3D%d addr=3D0x%"PRIx64" flag=3D%d"
+virtio_iommu_init_iommu_mr(char *iommu_mr) "init %s"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index afd6397ac9..2d7b1752b7 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -23,6 +23,8 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "sysemu/kvm.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "trace.h"
=20
 #include "standard-headers/linux/virtio_ids.h"
@@ -34,6 +36,50 @@
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
+        memory_region_init_iommu(&sdev->iommu_mr, sizeof(sdev->iommu_mr),
+                                 TYPE_VIRTIO_IOMMU_MEMORY_REGION,
+                                 OBJECT(s), name,
+                                 UINT64_MAX);
+        address_space_init(&sdev->as,
+                           MEMORY_REGION(&sdev->iommu_mr), TYPE_VIRTIO_IOM=
MU);
+        g_free(name);
+    }
+    return &sdev->as;
+}
+
 static int virtio_iommu_attach(VirtIOIOMMU *s,
                                struct virtio_iommu_req_attach *req)
 {
@@ -172,6 +218,27 @@ out:
     }
 }
=20
+static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr =
addr,
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
 static void virtio_iommu_get_config(VirtIODevice *vdev, uint8_t *config_da=
ta)
 {
     VirtIOIOMMU *dev =3D VIRTIO_IOMMU(vdev);
@@ -252,6 +319,15 @@ static void virtio_iommu_device_realize(DeviceState *d=
ev, Error **errp)
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
=20
     qemu_mutex_init(&s->mutex);
+
+    memset(s->as_by_bus_num, 0, sizeof(s->as_by_bus_num));
+    s->as_by_busptr =3D g_hash_table_new_full(NULL, NULL, NULL, g_free);
+
+    if (s->primary_bus) {
+        pci_setup_iommu(s->primary_bus, virtio_iommu_find_add_as, s);
+    } else {
+        error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!");
+    }
 }
=20
 static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp)
@@ -310,6 +386,14 @@ static void virtio_iommu_class_init(ObjectClass *klass=
, void *data)
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
@@ -318,9 +402,17 @@ static const TypeInfo virtio_iommu_info =3D {
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
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-io=
mmu.h
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


