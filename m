Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BF1C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60752089E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60752089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVtv-0000ua-4b
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hsVqT-0002DT-Jo
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hsVqS-0001JR-Ie
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:23:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hsVqQ-0001I1-3J; Tue, 30 Jul 2019 13:23:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4EB4D3082141;
 Tue, 30 Jul 2019 17:23:25 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D57D60BE5;
 Tue, 30 Jul 2019 17:23:20 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, peter.maydell@linaro.org,
 alex.williamson@redhat.com, jean-philippe@linaro.org, kevin.tian@intel.com
Date: Tue, 30 Jul 2019 19:21:33 +0200
Message-Id: <20190730172137.23114-12-eric.auger@redhat.com>
In-Reply-To: <20190730172137.23114-1-eric.auger@redhat.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 30 Jul 2019 17:23:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 v10 11/15] virtio-iommu: Expose the
 IOAPIC MSI reserved region when relevant
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

We introduce a new msi_bypass field which indicates whether
the IOAPIC MSI window [0xFEE00000 - 0xFEEFFFFF] must be exposed
as a reserved region. By default the field is set to true at
instantiation time. Later on we will introduce a property at
virtio pci proxy level to turn it off.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v8 -> v9:
- pass IOAPIC_RANGE_END to virtio_iommu_register_resv_region
- take into account the change in the struct virtio_iommu_probe_resv_mem
  definition
- We just introduce the field here. A property will be introduced later o=
n
  at pci proxy level.
---
 hw/virtio/virtio-iommu.c         | 36 ++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-iommu.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 66be9a4627..74038288b0 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -39,6 +39,9 @@
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
 #define VIOMMU_PROBE_SIZE 512
=20
+#define IOAPIC_RANGE_START      (0xfee00000)
+#define IOAPIC_RANGE_END        (0xfeefffff)
+
 #define SUPPORTED_PROBE_PROPERTIES (\
     1 << VIRTIO_IOMMU_PROBE_T_RESV_MEM)
=20
@@ -100,6 +103,30 @@ static void virtio_iommu_detach_endpoint_from_domain=
(viommu_endpoint *ep)
     ep->domain =3D NULL;
 }
=20
+static void virtio_iommu_register_resv_region(viommu_endpoint *ep,
+                                              uint8_t subtype,
+                                              uint64_t start, uint64_t e=
nd)
+{
+    viommu_interval *interval;
+    struct virtio_iommu_probe_resv_mem *resv_reg_prop;
+    size_t prop_size =3D sizeof(struct virtio_iommu_probe_resv_mem);
+    size_t value_size =3D prop_size -
+                sizeof(struct virtio_iommu_probe_property);
+
+    interval =3D g_malloc0(sizeof(*interval));
+    interval->low =3D start;
+    interval->high =3D end;
+
+    resv_reg_prop =3D g_malloc0(prop_size);
+    resv_reg_prop->head.type =3D VIRTIO_IOMMU_PROBE_T_RESV_MEM;
+    resv_reg_prop->head.length =3D cpu_to_le64(value_size);
+    resv_reg_prop->subtype =3D cpu_to_le64(subtype);
+    resv_reg_prop->start =3D cpu_to_le64(start);
+    resv_reg_prop->end =3D cpu_to_le64(end);
+
+    g_tree_insert(ep->reserved_regions, interval, resv_reg_prop);
+}
+
 static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
                                                   uint32_t ep_id)
 {
@@ -117,6 +144,12 @@ static viommu_endpoint *virtio_iommu_get_endpoint(Vi=
rtIOIOMMU *s,
     ep->reserved_regions =3D g_tree_new_full((GCompareDataFunc)interval_=
cmp,
                                             NULL, (GDestroyNotify)g_free=
,
                                             (GDestroyNotify)g_free);
+    if (s->msi_bypass) {
+        virtio_iommu_register_resv_region(ep, VIRTIO_IOMMU_RESV_MEM_T_MS=
I,
+                                          IOAPIC_RANGE_START,
+                                          IOAPIC_RANGE_END);
+    }
+
     return ep;
 }
=20
@@ -822,6 +855,9 @@ static void virtio_iommu_set_status(VirtIODevice *vde=
v, uint8_t status)
=20
 static void virtio_iommu_instance_init(Object *obj)
 {
+    VirtIOIOMMU *s =3D VIRTIO_IOMMU(obj);
+
+    s->msi_bypass =3D true;
 }
=20
 static const VMStateDescription vmstate_virtio_iommu =3D {
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-=
iommu.h
index f55f48d304..56c8b4e57f 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -59,6 +59,7 @@ typedef struct VirtIOIOMMU {
     GTree *domains;
     QemuMutex mutex;
     GTree *endpoints;
+    bool msi_bypass;
 } VirtIOIOMMU;
=20
 #endif
--=20
2.20.1


