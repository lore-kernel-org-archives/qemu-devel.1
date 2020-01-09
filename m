Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2C5C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B332067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yym0ODU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B332067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZAP-0001kb-WF
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ipZ2g-0007Fi-Ts
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ipZ2f-0007Qs-7g
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:44:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34493
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ipZ2f-0007NY-0J
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578581048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38N4qcJYR95yRipoU5JW40H01C77jDEOmw1BbBYXpuw=;
 b=Yym0ODU9bijMYn8ED5XRhGwzjYCKnOdrs6A9tHgPraF3UUlQ5w9Y7IBRpSs/MXC0/5Q6bm
 453WNrgyT/Tr8kZc4RhsydPuCmygZA9ps2YzdS/ouPbYichsNTvphkkNz/Dva2cFYiDTvn
 L5RpIeyTezpWO8/hkJf0PIgw1XUPmk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-43D7waCVOeasnjvWZY19PQ-1; Thu, 09 Jan 2020 09:44:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09F8D107ACC4;
 Thu,  9 Jan 2020 14:44:06 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF25B60FC6;
 Thu,  9 Jan 2020 14:43:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, jean-philippe@linaro.org,
 dgilbert@redhat.com, quintela@redhat.com, mst@redhat.com, peterx@redhat.com
Subject: [PATCH v12 05/13] virtio-iommu: Endpoint and domains structs and
 helpers
Date: Thu,  9 Jan 2020 15:43:11 +0100
Message-Id: <20200109144319.15912-6-eric.auger@redhat.com>
In-Reply-To: <20200109144319.15912-1-eric.auger@redhat.com>
References: <20200109144319.15912-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 43D7waCVOeasnjvWZY19PQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kevin.tian@intel.com, bharatb.linux@gmail.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduce domain and endpoint internal
datatypes. Both are stored in RB trees. The domain
owns a list of endpoints attached to it.

Helpers to get/put end points and domains are introduced.
get() helpers will become static in subsequent patches.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v11 -> v12:
- s/uint/guint (docker-mingw@fedora build test failure)
- s/viommu_/VirtIOIOMMU + CamelCase
- Before creating an endpoint, check the sid is one from a
  device protected by the iommu, otherwise returns NULL
- add assert of endpoint put to check the endpoint was detached
  from any domain
- destroy and re-allocate the trees on reset

v10 -> v11:
- fixed interval_cmp (<=3D -> < and >=3D -> >)
- removed unused viommu field from endpoint
- removed Bharat's R-b

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
 hw/virtio/virtio-iommu.c | 128 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 10a2b120f3..15595f8cd7 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -66,3 +66,7 @@ virtio_iommu_map(uint32_t domain_id, uint64_t virt_start,=
 uint64_t virt_end, uin
 virtio_iommu_unmap(uint32_t domain_id, uint64_t virt_start, uint64_t virt_=
end) "domain=3D%d virt_start=3D0x%"PRIx64" virt_end=3D0x%"PRIx64
 virtio_iommu_translate(const char *name, uint32_t rid, uint64_t iova, int =
flag) "mr=3D%s rid=3D%d addr=3D0x%"PRIx64" flag=3D%d"
 virtio_iommu_init_iommu_mr(char *iommu_mr) "init %s"
+virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc endpoint=3D%d"
+virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=3D%d"
+virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=3D%d"
+virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index acc939f334..6a03c3d7ae 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -32,10 +32,29 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci.h"
=20
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
=20
+typedef struct VirtIOIOMMUDomain {
+    uint32_t id;
+    GTree *mappings;
+    QLIST_HEAD(, VirtIOIOMMUEndpoint) endpoint_list;
+} VirtIOIOMMUDomain;
+
+typedef struct VirtIOIOMMUEndpoint {
+    uint32_t id;
+    VirtIOIOMMUDomain *domain;
+    QLIST_ENTRY(VirtIOIOMMUEndpoint) next;
+} VirtIOIOMMUEndpoint;
+
+typedef struct VirtIOIOMMUInterval {
+    uint64_t low;
+    uint64_t high;
+} VirtIOIOMMUInterval;
+
 static inline uint16_t virtio_iommu_get_sid(IOMMUDevice *dev)
 {
     return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
@@ -65,8 +84,7 @@ static IOMMUPciBus *iommu_find_iommu_pcibus(VirtIOIOMMU *=
s, uint8_t bus_num)
     return iommu_pci_bus;
 }
=20
-IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint32_t sid);
-IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint32_t sid)
+static IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint32_t sid)
 {
     uint8_t bus_n, devfn;
     IOMMUPciBus *iommu_pci_bus;
@@ -84,6 +102,88 @@ IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint=
32_t sid)
     return NULL;
 }
=20
+static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_d=
ata)
+{
+    VirtIOIOMMUInterval *inta =3D (VirtIOIOMMUInterval *)a;
+    VirtIOIOMMUInterval *intb =3D (VirtIOIOMMUInterval *)b;
+
+    if (inta->high < intb->low) {
+        return -1;
+    } else if (intb->high < inta->low) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *=
ep)
+{
+    QLIST_REMOVE(ep, next);
+    ep->domain =3D NULL;
+}
+
+VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep=
_id);
+VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep=
_id)
+{
+    VirtIOIOMMUEndpoint *ep;
+
+    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
+    if (ep) {
+        return ep;
+    }
+    if (!virtio_iommu_mr(s, ep_id)) {
+        return NULL;
+    }
+    ep =3D g_malloc0(sizeof(*ep));
+    ep->id =3D ep_id;
+    trace_virtio_iommu_get_endpoint(ep_id);
+    g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
+    return ep;
+}
+
+static void virtio_iommu_put_endpoint(gpointer data)
+{
+    VirtIOIOMMUEndpoint *ep =3D (VirtIOIOMMUEndpoint *)data;
+
+    assert(!ep->domain);
+
+    trace_virtio_iommu_put_endpoint(ep->id);
+    g_free(ep);
+}
+
+VirtIOIOMMUDomain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain=
_id);
+VirtIOIOMMUDomain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain=
_id)
+{
+    VirtIOIOMMUDomain *domain;
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
+    VirtIOIOMMUDomain *domain =3D (VirtIOIOMMUDomain *)data;
+    VirtIOIOMMUEndpoint *iter, *tmp;
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
@@ -328,6 +428,13 @@ static const VMStateDescription vmstate_virtio_iommu_d=
evice =3D {
     .unmigratable =3D 1,
 };
=20
+static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
+{
+    guint ua =3D GPOINTER_TO_UINT(a);
+    guint ub =3D GPOINTER_TO_UINT(b);
+    return (ua > ub) - (ua < ub);
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
@@ -369,13 +476,30 @@ static void virtio_iommu_device_realize(DeviceState *=
dev, Error **errp)
 static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtIOIOMMU *s =3D VIRTIO_IOMMU(dev);
+
+    g_tree_destroy(s->domains);
+    g_tree_destroy(s->endpoints);
=20
     virtio_cleanup(vdev);
 }
=20
 static void virtio_iommu_device_reset(VirtIODevice *vdev)
 {
+    VirtIOIOMMU *s =3D VIRTIO_IOMMU(vdev);
+
     trace_virtio_iommu_device_reset();
+
+    if (s->domains) {
+        g_tree_destroy(s->domains);
+    }
+    if (s->endpoints) {
+        g_tree_destroy(s->endpoints);
+    }
+    s->domains =3D g_tree_new_full((GCompareDataFunc)int_cmp,
+                                 NULL, NULL, virtio_iommu_put_domain);
+    s->endpoints =3D g_tree_new_full((GCompareDataFunc)int_cmp,
+                                   NULL, NULL, virtio_iommu_put_endpoint);
 }
=20
 static void virtio_iommu_set_status(VirtIODevice *vdev, uint8_t status)
--=20
2.20.1


