Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC2C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D3420693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D3420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVsM-0006DV-Vo
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60953)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hsVpw-0000ng-Kg
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hsVpv-0000xM-8T
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:22:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46156)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hsVps-0000uv-2C; Tue, 30 Jul 2019 13:22:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5B220882EA;
 Tue, 30 Jul 2019 17:22:51 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A0DC60BF7;
 Tue, 30 Jul 2019 17:22:46 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, peter.maydell@linaro.org,
 alex.williamson@redhat.com, jean-philippe@linaro.org, kevin.tian@intel.com
Date: Tue, 30 Jul 2019 19:21:28 +0200
Message-Id: <20190730172137.23114-7-eric.auger@redhat.com>
In-Reply-To: <20190730172137.23114-1-eric.auger@redhat.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 30 Jul 2019 17:22:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 v10 06/15] virtio-iommu: Endpoint and
 domains structs and helpers
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

This patch introduce domain and endpoint internal
datatypes. Both are stored in RB trees. The domain
owns a list of endpoints attached to it.

Helpers to get/put end points and domains are introduced.
get() helpers will become static in subsequent patches.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Bharat Bhushan <bharat.bhushan@nxp.com>

---

v9 -> v10:
- added Bharat's R-b

v6 -> v7:
- on virtio_iommu_find_add_as the bus number computation may
  not be finalized yet so we cannot register the EPs at that time.
  Hence, let's remove the get_endpoint and also do not use the
  bus number for building the memory region name string (only
  used for debug though).

v4 -> v5:
- initialize as->endpoint_list

v3 -> v4:
- new separate patch
---
 hw/virtio/trace-events   |   4 ++
 hw/virtio/virtio-iommu.c | 121 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index b32169d56c..a373bdebb3 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -67,3 +67,7 @@ virtio_iommu_map(uint32_t domain_id, uint64_t virt_star=
t, uint64_t virt_end, uin
 virtio_iommu_unmap(uint32_t domain_id, uint64_t virt_start, uint64_t vir=
t_end) "domain=3D%d virt_start=3D0x%"PRIx64" virt_end=3D0x%"PRIx64
 virtio_iommu_translate(const char *name, uint32_t rid, uint64_t iova, in=
t flag) "mr=3D%s rid=3D%d addr=3D0x%"PRIx64" flag=3D%d"
 virtio_iommu_init_iommu_mr(char *iommu_mr) "init %s"
+virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc endpoint=3D%d"
+virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=3D%d"
+virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=3D%d"
+virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 1610e2f773..77dccecc0a 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -31,15 +31,118 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci.h"
=20
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
=20
+typedef struct viommu_domain {
+    uint32_t id;
+    GTree *mappings;
+    QLIST_HEAD(, viommu_endpoint) endpoint_list;
+} viommu_domain;
+
+typedef struct viommu_endpoint {
+    uint32_t id;
+    viommu_domain *domain;
+    QLIST_ENTRY(viommu_endpoint) next;
+    VirtIOIOMMU *viommu;
+} viommu_endpoint;
+
+typedef struct viommu_interval {
+    uint64_t low;
+    uint64_t high;
+} viommu_interval;
+
 static inline uint16_t virtio_iommu_get_sid(IOMMUDevice *dev)
 {
     return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
 }
=20
+static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user=
_data)
+{
+    viommu_interval *inta =3D (viommu_interval *)a;
+    viommu_interval *intb =3D (viommu_interval *)b;
+
+    if (inta->high <=3D intb->low) {
+        return -1;
+    } else if (intb->high <=3D inta->low) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+static void virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep=
)
+{
+    QLIST_REMOVE(ep, next);
+    ep->domain =3D NULL;
+}
+
+viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep_i=
d);
+viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep_i=
d)
+{
+    viommu_endpoint *ep;
+
+    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
+    if (ep) {
+        return ep;
+    }
+    ep =3D g_malloc0(sizeof(*ep));
+    ep->id =3D ep_id;
+    ep->viommu =3D s;
+    trace_virtio_iommu_get_endpoint(ep_id);
+    g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
+    return ep;
+}
+
+static void virtio_iommu_put_endpoint(gpointer data)
+{
+    viommu_endpoint *ep =3D (viommu_endpoint *)data;
+
+    if (ep->domain) {
+        virtio_iommu_detach_endpoint_from_domain(ep);
+        g_tree_unref(ep->domain->mappings);
+    }
+
+    trace_virtio_iommu_put_endpoint(ep->id);
+    g_free(ep);
+}
+
+viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain_i=
d);
+viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain_i=
d)
+{
+    viommu_domain *domain;
+
+    domain =3D g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
+    if (domain) {
+        return domain;
+    }
+    domain =3D g_malloc0(sizeof(*domain));
+    domain->id =3D domain_id;
+    domain->mappings =3D g_tree_new_full((GCompareDataFunc)interval_cmp,
+                                   NULL, (GDestroyNotify)g_free,
+                                   (GDestroyNotify)g_free);
+    g_tree_insert(s->domains, GUINT_TO_POINTER(domain_id), domain);
+    QLIST_INIT(&domain->endpoint_list);
+    trace_virtio_iommu_get_domain(domain_id);
+    return domain;
+}
+
+static void virtio_iommu_put_domain(gpointer data)
+{
+    viommu_domain *domain =3D (viommu_domain *)data;
+    viommu_endpoint *iter, *tmp;
+
+    QLIST_FOREACH_SAFE(iter, &domain->endpoint_list, next, tmp) {
+        virtio_iommu_detach_endpoint_from_domain(iter);
+    }
+    g_tree_destroy(domain->mappings);
+    trace_virtio_iommu_put_domain(domain->id);
+    g_free(domain);
+}
+
 static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
                                               int devfn)
 {
@@ -308,6 +411,13 @@ static const VMStateDescription vmstate_virtio_iommu=
_device =3D {
     .unmigratable =3D 1,
 };
=20
+static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data=
)
+{
+    uint ua =3D GPOINTER_TO_UINT(a);
+    uint ub =3D GPOINTER_TO_UINT(b);
+    return (ua > ub) - (ua < ub);
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
@@ -334,6 +444,8 @@ static void virtio_iommu_device_realize(DeviceState *=
dev, Error **errp)
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
=20
+    qemu_mutex_init(&s->mutex);
+
     memset(s->as_by_bus_num, 0, sizeof(s->as_by_bus_num));
     s->as_by_busptr =3D g_hash_table_new(NULL, NULL);
=20
@@ -342,11 +454,20 @@ static void virtio_iommu_device_realize(DeviceState=
 *dev, Error **errp)
     } else {
         error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!")=
;
     }
+
+    s->domains =3D g_tree_new_full((GCompareDataFunc)int_cmp,
+                                 NULL, NULL, virtio_iommu_put_domain);
+    s->endpoints =3D g_tree_new_full((GCompareDataFunc)int_cmp,
+                                   NULL, NULL, virtio_iommu_put_endpoint=
);
 }
=20
 static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp=
)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtIOIOMMU *s =3D VIRTIO_IOMMU(dev);
+
+    g_tree_destroy(s->domains);
+    g_tree_destroy(s->endpoints);
=20
     virtio_cleanup(vdev);
 }
--=20
2.20.1


