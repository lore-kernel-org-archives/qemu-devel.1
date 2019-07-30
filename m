Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7EDC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E546420693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E546420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVvK-0004FG-8X
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32940)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hsVqZ-0002YK-KY
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hsVqY-0001M9-BT
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:23:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hsVqV-0001Kb-GB; Tue, 30 Jul 2019 13:23:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA747308218D;
 Tue, 30 Jul 2019 17:23:30 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A655160BE5;
 Tue, 30 Jul 2019 17:23:25 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, peter.maydell@linaro.org,
 alex.williamson@redhat.com, jean-philippe@linaro.org, kevin.tian@intel.com
Date: Tue, 30 Jul 2019 19:21:34 +0200
Message-Id: <20190730172137.23114-13-eric.auger@redhat.com>
In-Reply-To: <20190730172137.23114-1-eric.auger@redhat.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 30 Jul 2019 17:23:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 v10 12/15] virtio-iommu: Implement
 fault reporting
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

The event queue allows to report asynchronous errors.
The translate function now injects faults when relevant.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/trace-events   |  1 +
 hw/virtio/virtio-iommu.c | 67 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 2e557dffb4..046290a971 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -77,3 +77,4 @@ virtio_iommu_unmap_inc_interval(uint64_t low, uint64_t =
high) "Unmap inc [0x%"PRI
 virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint3=
2_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
 virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_=
t start, uint64_t end, uint32_t flags, size_t filled) "dev=3D %d, subtype=
=3D%d start=3D0x%"PRIx64" end=3D0x%"PRIx64" flags=3D%d filled=3D0x%lx"
 virtio_iommu_fill_none_property(uint32_t devid) "devid=3D%d"
+virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpo=
int, uint64_t addr) "FAULT reason=3D%d flags=3D%d endpoint=3D%d address =3D=
0x%"PRIx64
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 74038288b0..8e54a17227 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -654,17 +654,63 @@ push:
     }
 }
=20
+static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reaso=
n,
+                                      uint32_t flags, uint32_t endpoint,
+                                      uint64_t address)
+{
+    VirtIODevice *vdev =3D &viommu->parent_obj;
+    VirtQueue *vq =3D viommu->event_vq;
+    struct virtio_iommu_fault fault;
+    VirtQueueElement *elem;
+    size_t sz;
+
+    memset(&fault, 0, sizeof(fault));
+    fault.reason =3D reason;
+    fault.flags =3D flags;
+    fault.endpoint =3D endpoint;
+    fault.address =3D address;
+
+    for (;;) {
+        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
+
+        if (!elem) {
+            virtio_error(vdev,
+                         "no buffer available in event queue to report e=
vent");
+            return;
+        }
+
+        if (iov_size(elem->in_sg, elem->in_num) < sizeof(fault)) {
+            virtio_error(vdev, "error buffer of wrong size");
+            virtqueue_detach_element(vq, elem, 0);
+            g_free(elem);
+            continue;
+        }
+        break;
+    }
+    /* we have a buffer to fill in */
+    sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
+                      &fault, sizeof(fault));
+    assert(sz =3D=3D sizeof(fault));
+
+    trace_virtio_iommu_report_fault(reason, flags, endpoint, address);
+    virtqueue_push(vq, elem, sz);
+    virtio_notify(vdev, vq);
+    g_free(elem);
+
+}
+
 static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwadd=
r addr,
                                             IOMMUAccessFlags flag,
                                             int iommu_idx)
 {
     IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
     VirtIOIOMMU *s =3D sdev->viommu;
-    uint32_t sid;
+    uint32_t sid, flags;
     viommu_endpoint *ep;
     viommu_mapping *mapping;
     viommu_interval interval;
     bool bypass_allowed;
+    bool read_fault, write_fault;
=20
     interval.low =3D addr;
     interval.high =3D addr + 1;
@@ -689,6 +735,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemo=
ryRegion *mr, hwaddr addr,
     if (!ep) {
         if (!bypass_allowed) {
             error_report("%s sid=3D%d is not known!!", __func__, sid);
+            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_UNKNOWN,
+                                      0, sid, 0);
         } else {
             entry.perm =3D flag;
         }
@@ -701,6 +749,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemo=
ryRegion *mr, hwaddr addr,
                           "%s %02x:%02x.%01x not attached to any domain\=
n",
                           __func__, PCI_BUS_NUM(sid),
                           PCI_SLOT(sid), PCI_FUNC(sid));
+            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_DOMAIN,
+                                      0, sid, 0);
         } else {
             entry.perm =3D flag;
         }
@@ -712,14 +762,25 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMe=
moryRegion *mr, hwaddr addr,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s no mapping for 0x%"PRIx64" for sid=3D%d\n",
                       __func__, addr, sid);
+        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
+                                  0, sid, addr);
         goto unlock;
     }
=20
-    if (((flag & IOMMU_RO) && !(mapping->flags & VIRTIO_IOMMU_MAP_F_READ=
)) ||
-        ((flag & IOMMU_WO) && !(mapping->flags & VIRTIO_IOMMU_MAP_F_WRIT=
E))) {
+    read_fault =3D (flag & IOMMU_RO) &&
+                    !(mapping->flags & VIRTIO_IOMMU_MAP_F_READ);
+    write_fault =3D (flag & IOMMU_WO) &&
+                    !(mapping->flags & VIRTIO_IOMMU_MAP_F_WRITE);
+
+    flags =3D read_fault ? VIRTIO_IOMMU_FAULT_F_READ : 0;
+    flags |=3D write_fault ? VIRTIO_IOMMU_FAULT_F_WRITE : 0;
+    if (flags) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Permission error on 0x%"PRIx64"(%d): allowed=3D%d=
\n",
                       addr, flag, mapping->flags);
+        flags |=3D VIRTIO_IOMMU_FAULT_F_ADDRESS;
+        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
+                                  flags, sid, addr);
         goto unlock;
     }
     entry.translated_addr =3D addr - mapping->virt_addr + mapping->phys_=
addr;
--=20
2.20.1


