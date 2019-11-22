Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C0EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF4B20707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ecmc/wFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF4B20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYE0o-0003fs-JW
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iYDi4-0000Fm-Jl
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iYDi3-0000Hc-4T
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23718
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iYDi3-0000HH-01
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574447470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hP1XRUr8hBzDtWLyDgeKj1K15HOETKuvmw9ZYMPh4qw=;
 b=Ecmc/wFNh4U9DY5OXzMEjuyajO6JbbsPeIrQPIP4SifIo8qZO3+u9anvpaGdknR+VHbVxY
 n1Igj+frg46j9Uc8RiB0ecK7G180dLi6dwpF1ZN+OYSHEhZ3hcXjr3IARzOeb1xqYq/HGo
 kH/IgYB+ig8udJKi3CMbnvwWhQ9w14E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-Z1jxOUdkPhWfzFz-RbzO7A-1; Fri, 22 Nov 2019 13:31:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B137477;
 Fri, 22 Nov 2019 18:31:07 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CABC6E712;
 Fri, 22 Nov 2019 18:31:04 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, jean-philippe.brucker@arm.com, bharatb.linux@gmail.com,
 yang.zhong@intel.com, dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH for-5.0 v11 09/20] virtio-iommu: Implement fault reporting
Date: Fri, 22 Nov 2019 19:29:32 +0100
Message-Id: <20191122182943.4656-10-eric.auger@redhat.com>
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Z1jxOUdkPhWfzFz-RbzO7A-1
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
Cc: kevin.tian@intel.com, peterx@redhat.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The event queue allows to report asynchronous errors.
The translate function now injects faults when relevant.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v10 -> v11:
- change a virtio_error into an error_report_once
  (no buffer available for output faults)
---
 hw/virtio/trace-events   |  1 +
 hw/virtio/virtio-iommu.c | 69 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index de7cbb3c8f..a572eb71aa 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -73,3 +73,4 @@ virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=
=3D%d"
 virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=3D%d"
 virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
 virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_=
t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
+virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoin=
t, uint64_t addr) "FAULT reason=3D%d flags=3D%d endpoint=3D%d address =3D0x=
%"PRIx64
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index a83666557b..723616a5db 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -407,6 +407,51 @@ out:
     }
 }
=20
+static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
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
+            error_report_once(
+                "no buffer available in event queue to report event");
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
 static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr =
addr,
                                             IOMMUAccessFlags flag,
                                             int iommu_idx)
@@ -415,9 +460,10 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemor=
yRegion *mr, hwaddr addr,
     viommu_interval interval, *mapping_key;
     viommu_mapping *mapping_value;
     VirtIOIOMMU *s =3D sdev->viommu;
+    bool read_fault, write_fault;
     viommu_endpoint *ep;
+    uint32_t sid, flags;
     bool bypass_allowed;
-    uint32_t sid;
     bool found;
=20
     interval.low =3D addr;
@@ -443,6 +489,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemory=
Region *mr, hwaddr addr,
     if (!ep) {
         if (!bypass_allowed) {
             error_report_once("%s sid=3D%d is not known!!", __func__, sid)=
;
+            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_UNKNOWN,
+                                      0, sid, 0);
         } else {
             entry.perm =3D flag;
         }
@@ -455,6 +503,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemory=
Region *mr, hwaddr addr,
                           "%s %02x:%02x.%01x not attached to any domain\n"=
,
                           __func__, PCI_BUS_NUM(sid),
                           PCI_SLOT(sid), PCI_FUNC(sid));
+            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_DOMAIN,
+                                      0, sid, 0);
         } else {
             entry.perm =3D flag;
         }
@@ -468,16 +518,25 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemo=
ryRegion *mr, hwaddr addr,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s no mapping for 0x%"PRIx64" for sid=3D%d\n",
                       __func__, addr, sid);
+        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
+                                  0, sid, addr);
         goto unlock;
     }
=20
-    if (((flag & IOMMU_RO) &&
-            !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_READ)) ||
-        ((flag & IOMMU_WO) &&
-            !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_WRITE))) {
+    read_fault =3D (flag & IOMMU_RO) &&
+                    !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_READ);
+    write_fault =3D (flag & IOMMU_WO) &&
+                    !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_WRITE);
+
+    flags =3D read_fault ? VIRTIO_IOMMU_FAULT_F_READ : 0;
+    flags |=3D write_fault ? VIRTIO_IOMMU_FAULT_F_WRITE : 0;
+    if (flags) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Permission error on 0x%"PRIx64"(%d): allowed=3D%d\n=
",
                       addr, flag, mapping_value->flags);
+        flags |=3D VIRTIO_IOMMU_FAULT_F_ADDRESS;
+        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
+                                  flags, sid, addr);
         goto unlock;
     }
     entry.translated_addr =3D addr - mapping_key->low + mapping_value->phy=
s_addr;
--=20
2.20.1


