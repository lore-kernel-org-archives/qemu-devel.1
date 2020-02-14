Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740BBC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26C5222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUo418uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26C5222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2b61-0000Lk-Sd
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 08:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j2b1X-0001Fe-Ux
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j2b1W-0007o3-Hr
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:28:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39900
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j2b1W-0007jw-C1
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581686930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LirlY2hiNQE5OdFGRUpttOcqMzEe2dgN7vuotOCoeE=;
 b=OUo418uonazWIORzO73BaK383hxlXtyXtgr6+WqSGucYfGHdE1eKewQe31MgbisgllSrL/
 qs2U3oQ97eFZOU9d61Bk0CqcWmBphO2XVRjuml3TwII+2a4OROCokaZwesJcmt/IsQnbb5
 lhBqHu8xJxfShw89mlSWxVG+53euUBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-sA4FoMqIMWCg_CT2jL7cJw-1; Fri, 14 Feb 2020 08:28:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E8818A6EC3;
 Fri, 14 Feb 2020 13:28:44 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EB985DA7D;
 Fri, 14 Feb 2020 13:28:31 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, jean-philippe@linaro.org,
 dgilbert@redhat.com, quintela@redhat.com, mst@redhat.com, peterx@redhat.com
Subject: [PATCH v16 04/10] virtio-iommu: Implement map/unmap
Date: Fri, 14 Feb 2020 14:27:39 +0100
Message-Id: <20200214132745.23392-5-eric.auger@redhat.com>
In-Reply-To: <20200214132745.23392-1-eric.auger@redhat.com>
References: <20200214132745.23392-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: sA4FoMqIMWCg_CT2jL7cJw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

This patch implements virtio_iommu_map/unmap.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

---

v11 -> v12:
- check unmanaged managed flags on map
- removed 2 qemu_log_mask in unmap()
- fix leak

v10 -> v11:
- revisit the implementation of unmap according to Peter's suggestion
- removed virt_addr and size from viommu_mapping struct
- use g_tree_lookup_extended()
- return VIRTIO_IOMMU_S_RANGE in case a mapping were
  to be split on unmap (instead of INVAL)

v5 -> v6:
- use new v0.6 fields
- replace error_report by qemu_log_mask

v3 -> v4:
- implement unmap semantics as specified in v0.4
---
 hw/virtio/trace-events   |  1 +
 hw/virtio/virtio-iommu.c | 63 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 15595f8cd7..22162d6583 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -64,6 +64,7 @@ virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id) "=
domain=3D%d endpoint=3D%d"
 virtio_iommu_detach(uint32_t domain_id, uint32_t ep_id) "domain=3D%d endpo=
int=3D%d"
 virtio_iommu_map(uint32_t domain_id, uint64_t virt_start, uint64_t virt_en=
d, uint64_t phys_start, uint32_t flags) "domain=3D%d virt_start=3D0x%"PRIx6=
4" virt_end=3D0x%"PRIx64 " phys_start=3D0x%"PRIx64" flags=3D%d"
 virtio_iommu_unmap(uint32_t domain_id, uint64_t virt_start, uint64_t virt_=
end) "domain=3D%d virt_start=3D0x%"PRIx64" virt_end=3D0x%"PRIx64
+virtio_iommu_unmap_done(uint32_t domain_id, uint64_t virt_start, uint64_t =
virt_end) "domain=3D%d virt_start=3D0x%"PRIx64" virt_end=3D0x%"PRIx64
 virtio_iommu_translate(const char *name, uint32_t rid, uint64_t iova, int =
flag) "mr=3D%s rid=3D%d addr=3D0x%"PRIx64" flag=3D%d"
 virtio_iommu_init_iommu_mr(char *iommu_mr) "init %s"
 virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc endpoint=3D%d"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index d9fe83f530..844d34c270 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qemu/iov.h"
 #include "qemu-common.h"
 #include "hw/qdev-properties.h"
@@ -55,6 +56,11 @@ typedef struct VirtIOIOMMUInterval {
     uint64_t high;
 } VirtIOIOMMUInterval;
=20
+typedef struct VirtIOIOMMUMapping {
+    uint64_t phys_addr;
+    uint32_t flags;
+} VirtIOIOMMUMapping;
+
 static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)
 {
     return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
@@ -301,10 +307,39 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
     uint64_t virt_start =3D le64_to_cpu(req->virt_start);
     uint64_t virt_end =3D le64_to_cpu(req->virt_end);
     uint32_t flags =3D le32_to_cpu(req->flags);
+    VirtIOIOMMUDomain *domain;
+    VirtIOIOMMUInterval *interval;
+    VirtIOIOMMUMapping *mapping;
+
+    if (flags & ~VIRTIO_IOMMU_MAP_F_MASK) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
+    domain =3D g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
+    if (!domain) {
+        return VIRTIO_IOMMU_S_NOENT;
+    }
+
+    interval =3D g_malloc0(sizeof(*interval));
+
+    interval->low =3D virt_start;
+    interval->high =3D virt_end;
+
+    mapping =3D g_tree_lookup(domain->mappings, (gpointer)interval);
+    if (mapping) {
+        g_free(interval);
+        return VIRTIO_IOMMU_S_INVAL;
+    }
=20
     trace_virtio_iommu_map(domain_id, virt_start, virt_end, phys_start, fl=
ags);
=20
-    return VIRTIO_IOMMU_S_UNSUPP;
+    mapping =3D g_malloc0(sizeof(*mapping));
+    mapping->phys_addr =3D phys_start;
+    mapping->flags =3D flags;
+
+    g_tree_insert(domain->mappings, interval, mapping);
+
+    return VIRTIO_IOMMU_S_OK;
 }
=20
 static int virtio_iommu_unmap(VirtIOIOMMU *s,
@@ -313,10 +348,34 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
     uint32_t domain_id =3D le32_to_cpu(req->domain);
     uint64_t virt_start =3D le64_to_cpu(req->virt_start);
     uint64_t virt_end =3D le64_to_cpu(req->virt_end);
+    VirtIOIOMMUMapping *iter_val;
+    VirtIOIOMMUInterval interval, *iter_key;
+    VirtIOIOMMUDomain *domain;
+    int ret =3D VIRTIO_IOMMU_S_OK;
=20
     trace_virtio_iommu_unmap(domain_id, virt_start, virt_end);
=20
-    return VIRTIO_IOMMU_S_UNSUPP;
+    domain =3D g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
+    if (!domain) {
+        return VIRTIO_IOMMU_S_NOENT;
+    }
+    interval.low =3D virt_start;
+    interval.high =3D virt_end;
+
+    while (g_tree_lookup_extended(domain->mappings, &interval,
+                                  (void **)&iter_key, (void**)&iter_val)) =
{
+        uint64_t current_low =3D iter_key->low;
+        uint64_t current_high =3D iter_key->high;
+
+        if (interval.low <=3D current_low && interval.high >=3D current_hi=
gh) {
+            g_tree_remove(domain->mappings, iter_key);
+            trace_virtio_iommu_unmap_done(domain_id, current_low, current_=
high);
+        } else {
+            ret =3D VIRTIO_IOMMU_S_RANGE;
+            break;
+        }
+    }
+    return ret;
 }
=20
 static int virtio_iommu_iov_to_req(struct iovec *iov,
--=20
2.20.1


