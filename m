Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C653C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D4B24650
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZEbpnsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D4B24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j006v-0001We-86
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 04:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j000P-000736-Cw
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j000N-0004rU-1W
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:32:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23195
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j000M-0004r1-Df
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581067973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V03eF9sU7VzMkxL7MWui4RKS0j5V2WUax8EcPcq9fh4=;
 b=LZEbpnsFIe6D8+nbIyg7rsqV2whd8JTxDJnj1Zea7zWNfS2ES6XNbzJnq+/vKaaPugSaqF
 q2dEoEHD5ZijISQQbZ7aU33+aTaJpjrqMkbgqlWguuwmI9Zo4RZ7mp/9BOEiazV5KwUsq3
 3CaR+8xqfuzdAHTuGKpsOJlinlz0HmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-3te8Iby8P-6I97iq9BEEZg-1; Fri, 07 Feb 2020 04:32:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 158AF800D5F;
 Fri,  7 Feb 2020 09:32:48 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC2AC790FF;
 Fri,  7 Feb 2020 09:32:42 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, jean-philippe@linaro.org,
 dgilbert@redhat.com, quintela@redhat.com, mst@redhat.com, peterx@redhat.com
Subject: [PATCH v14 03/11] virtio-iommu: Implement attach/detach command
Date: Fri,  7 Feb 2020 10:31:55 +0100
Message-Id: <20200207093203.3788-4-eric.auger@redhat.com>
In-Reply-To: <20200207093203.3788-1-eric.auger@redhat.com>
References: <20200207093203.3788-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3te8Iby8P-6I97iq9BEEZg-1
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

This patch implements the endpoint attach/detach to/from
a domain.

Domain and endpoint internal datatypes are introduced.
Both are stored in RB trees. The domain owns a list of
endpoints attached to it. Also helpers to get/put
end points and domains are introduced.

As for the IOMMU memory regions, a callback is called on
PCI bus enumeration that initializes for a given device
on the bus hierarchy an IOMMU memory region. The PCI bus
hierarchy is stored locally in IOMMUPciBus and IOMMUDevice
objects.

At the time of the enumeration, the bus number may not be
computed yet.

So operations that will need to retrieve the IOMMUdevice
and its IOMMU memory region from the bus number and devfn,
once the bus number is garanteed to be frozen, use an array
of IOMMUPciBus, lazily populated.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v13 -> v14:
- in virtio_iommu_put_endpoint, if the EP is attached to a
  domain, call virtio_iommu_detach_endpoint_from_domain()
- remove domain ref counting and simply delete the mappings
  gtree when the last EP is detached from the domain
- in virtio_iommu_detach_endpoint_from_domain(), return if the
  ep's domain is unset.

v12 -> v13:
- squashed v12 4, 5, 6 into this patch
- rename virtio_iommu_get_sid into virtio_iommu_get_bdf

v11 -> v12:
- check the device is protected by the iommu on attach
- on detach, check the domain id the device is attached to matches
  the one used in the detach command
- fix mapping ref counter and destroy the domain when no end-points
  are attached anymore
---
 hw/virtio/trace-events           |   6 +
 hw/virtio/virtio-iommu.c         | 311 ++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-iommu.h |   3 +
 3 files changed, 318 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index f7141aa2f6..15595f8cd7 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -64,3 +64,9 @@ virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id) "=
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
+virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc endpoint=3D%d"
+virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=3D%d"
+virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=3D%d"
+virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 86dcdc09a1..aa253eda0a 100644
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
@@ -30,19 +32,235 @@
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
+static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)
+{
+    return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
+}
+
+/**
+ * The bus number is used for lookup when SID based operations occur.
+ * In that case we lazily populate the IOMMUPciBus array from the bus hash
+ * table. At the time the IOMMUPciBus is created (iommu_find_add_as), the =
bus
+ * numbers may not be always initialized yet.
+ */
+static IOMMUPciBus *iommu_find_iommu_pcibus(VirtIOIOMMU *s, uint8_t bus_nu=
m)
+{
+    IOMMUPciBus *iommu_pci_bus =3D s->iommu_pcibus_by_bus_num[bus_num];
+
+    if (!iommu_pci_bus) {
+        GHashTableIter iter;
+
+        g_hash_table_iter_init(&iter, s->as_by_busptr);
+        while (g_hash_table_iter_next(&iter, NULL, (void **)&iommu_pci_bus=
)) {
+            if (pci_bus_num(iommu_pci_bus->bus) =3D=3D bus_num) {
+                s->iommu_pcibus_by_bus_num[bus_num] =3D iommu_pci_bus;
+                return iommu_pci_bus;
+            }
+        }
+        return NULL;
+    }
+    return iommu_pci_bus;
+}
+
+static IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint32_t sid)
+{
+    uint8_t bus_n, devfn;
+    IOMMUPciBus *iommu_pci_bus;
+    IOMMUDevice *dev;
+
+    bus_n =3D PCI_BUS_NUM(sid);
+    iommu_pci_bus =3D iommu_find_iommu_pcibus(s, bus_n);
+    if (iommu_pci_bus) {
+        devfn =3D sid & PCI_DEVFN_MAX;
+        dev =3D iommu_pci_bus->pbdev[devfn];
+        if (dev) {
+            return &dev->iommu_mr;
+        }
+    }
+    return NULL;
+}
+
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
+    if (!ep->domain) {
+        return;
+    }
+    QLIST_REMOVE(ep, next);
+    ep->domain =3D NULL;
+}
+
+static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
+                                                      uint32_t ep_id)
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
+    if (ep->domain) {
+        virtio_iommu_detach_endpoint_from_domain(ep);
+    }
+
+    trace_virtio_iommu_put_endpoint(ep->id);
+    g_free(ep);
+}
+
+static VirtIOIOMMUDomain *virtio_iommu_get_domain(VirtIOIOMMU *s,
+                                                  uint32_t domain_id)
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
+    trace_virtio_iommu_put_domain(domain->id);
+    g_free(domain);
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
+                         sizeof(IOMMUDevice *) * PCI_DEVFN_MAX);
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
     uint32_t domain_id =3D le32_to_cpu(req->domain);
     uint32_t ep_id =3D le32_to_cpu(req->endpoint);
+    VirtIOIOMMUDomain *domain;
+    VirtIOIOMMUEndpoint *ep;
=20
     trace_virtio_iommu_attach(domain_id, ep_id);
=20
-    return VIRTIO_IOMMU_S_UNSUPP;
+    ep =3D virtio_iommu_get_endpoint(s, ep_id);
+    if (!ep) {
+        return VIRTIO_IOMMU_S_NOENT;
+    }
+
+    if (ep->domain) {
+        VirtIOIOMMUDomain *previous_domain =3D ep->domain;
+        /*
+         * the device is already attached to a domain,
+         * detach it first
+         */
+        virtio_iommu_detach_endpoint_from_domain(ep);
+        if (QLIST_EMPTY(&previous_domain->endpoint_list)) {
+            g_tree_remove(s->domains, GUINT_TO_POINTER(previous_domain->id=
));
+        }
+    }
+
+    domain =3D virtio_iommu_get_domain(s, domain_id);
+    QLIST_INSERT_HEAD(&domain->endpoint_list, ep, next);
+
+    ep->domain =3D domain;
+
+    return VIRTIO_IOMMU_S_OK;
 }
=20
 static int virtio_iommu_detach(VirtIOIOMMU *s,
@@ -50,10 +268,29 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
 {
     uint32_t domain_id =3D le32_to_cpu(req->domain);
     uint32_t ep_id =3D le32_to_cpu(req->endpoint);
+    VirtIOIOMMUDomain *domain;
+    VirtIOIOMMUEndpoint *ep;
=20
     trace_virtio_iommu_detach(domain_id, ep_id);
=20
-    return VIRTIO_IOMMU_S_UNSUPP;
+    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
+    if (!ep) {
+        return VIRTIO_IOMMU_S_NOENT;
+    }
+
+    domain =3D ep->domain;
+
+    if (!domain || domain->id !=3D domain_id) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
+    virtio_iommu_detach_endpoint_from_domain(ep);
+
+    if (QLIST_EMPTY(&domain->endpoint_list)) {
+        g_tree_destroy(domain->mappings);
+        g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
+    }
+    return VIRTIO_IOMMU_S_OK;
 }
=20
 static int virtio_iommu_map(VirtIOIOMMU *s,
@@ -172,6 +409,27 @@ out:
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
+    sid =3D virtio_iommu_get_bdf(sdev);
+
+    trace_virtio_iommu_translate(mr->parent_obj.name, sid, addr, flag);
+    return entry;
+}
+
 static void virtio_iommu_get_config(VirtIODevice *vdev, uint8_t *config_da=
ta)
 {
     VirtIOIOMMU *dev =3D VIRTIO_IOMMU(vdev);
@@ -218,6 +476,13 @@ static const VMStateDescription vmstate_virtio_iommu_d=
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
@@ -226,6 +491,8 @@ static void virtio_iommu_device_realize(DeviceState *de=
v, Error **errp)
     virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
                 sizeof(struct virtio_iommu_config));
=20
+    memset(s->iommu_pcibus_by_bus_num, 0, sizeof(s->iommu_pcibus_by_bus_nu=
m));
+
     s->req_vq =3D virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
                              virtio_iommu_handle_command);
     s->event_vq =3D virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NULL=
);
@@ -244,18 +511,43 @@ static void virtio_iommu_device_realize(DeviceState *=
dev, Error **errp)
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
=20
     qemu_mutex_init(&s->mutex);
+
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
@@ -301,6 +593,14 @@ static void virtio_iommu_class_init(ObjectClass *klass=
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
@@ -309,9 +609,16 @@ static const TypeInfo virtio_iommu_info =3D {
     .class_init =3D virtio_iommu_class_init,
 };
=20
+static const TypeInfo virtio_iommu_memory_region_info =3D {
+    .parent =3D TYPE_IOMMU_MEMORY_REGION,
+    .name =3D TYPE_VIRTIO_IOMMU_MEMORY_REGION,
+    .class_init =3D virtio_iommu_memory_region_class_init,
+};
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
index d24ba63305..ae88f730cf 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -28,6 +28,8 @@
 #define VIRTIO_IOMMU(obj) \
         OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
=20
+#define TYPE_VIRTIO_IOMMU_MEMORY_REGION "virtio-iommu-memory-region"
+
 typedef struct IOMMUDevice {
     void         *viommu;
     PCIBus       *bus;
@@ -48,6 +50,7 @@ typedef struct VirtIOIOMMU {
     struct virtio_iommu_config config;
     uint64_t features;
     GHashTable *as_by_busptr;
+    IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
     PCIBus *primary_bus;
     GTree *domains;
     QemuMutex mutex;
--=20
2.20.1


