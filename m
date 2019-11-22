Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E13C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFF920707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmszZgCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFF920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDzp-0002TK-Nu
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iYDiW-0000sh-DN
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iYDiU-0000S8-UR
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42624
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iYDiU-0000Ro-QN
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574447498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tigei1AT8gTpq4W3JA9zJ/vbvpERCvoUOccYM5U+v/U=;
 b=UmszZgCX2Sos7s+1yjgp3pRLCUA7uH4vJJ8OzeLdmSQvdWPdp3ngtV61R9F5YhPE6qlEvK
 LQjAnaUpjECAHS7sXZg7urd6dr5YKmAzOLqAGAxnm7f/ITJcTaJJSnHXMFdlq7BPIqoTzD
 T6qaWzzHWDX3JFFGNDkAQvjOBxyilCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-ttrazPEAP1K2IIP8UOTcJg-1; Fri, 22 Nov 2019 13:31:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A51478018A1;
 Fri, 22 Nov 2019 18:31:35 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D4446E712;
 Fri, 22 Nov 2019 18:31:29 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, jean-philippe.brucker@arm.com, bharatb.linux@gmail.com,
 yang.zhong@intel.com, dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH for-5.0 v11 13/20] virtio-iommu: Implement probe request
Date: Fri, 22 Nov 2019 19:29:36 +0100
Message-Id: <20191122182943.4656-14-eric.auger@redhat.com>
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ttrazPEAP1K2IIP8UOTcJg-1
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

This patch implements the PROBE request. At the moment,
no reserved regions are returned as none are registered
per device. Only a NONE property is returned.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v9 -> v10
- fully rewrite the code in preparation of
  reserved_regions array property introduction

v8 -> v9:
- fix filling of properties (changes induced by v0.7 -> v0.8 spec
  evolution)
- return VIRTIO_IOMMU_S_INVAL in case of error

v7 -> v8:
- adapt to removal of value filed in virtio_iommu_probe_property

v6 -> v7:
- adapt to the change in virtio_iommu_probe_resv_mem fields
- use get_endpoint() instead of directly checking the EP
  was registered.

v4 -> v5:
- initialize bufstate.error to false
- add cpu_to_le64(size)
---
 hw/virtio/trace-events           |  1 +
 hw/virtio/virtio-iommu.c         | 89 +++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-iommu.h |  2 +
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index a572eb71aa..b7bc8ac6d1 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -74,3 +74,4 @@ virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=
=3D%d"
 virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
 virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_=
t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
 virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoin=
t, uint64_t addr) "FAULT reason=3D%d flags=3D%d endpoint=3D%d address =3D0x=
%"PRIx64
+virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t =
start, uint64_t end) "dev=3D %d, type=3D%d start=3D0x%"PRIx64" end=3D0x%"PR=
Ix64
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 723616a5db..1ce2218935 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -38,6 +38,7 @@
=20
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
+#define VIOMMU_PROBE_SIZE 512
=20
 typedef struct viommu_domain {
     uint32_t id;
@@ -317,6 +318,61 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
     return ret;
 }
=20
+static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep=
,
+                                               uint8_t *buf, size_t free)
+{
+    struct virtio_iommu_probe_resv_mem prop =3D {};
+    size_t size =3D sizeof(prop), length =3D size - sizeof(prop.head), tot=
al;
+    int i;
+
+    total =3D size * s->nb_reserved_regions;
+
+    if (total > free) {
+        return -ENOSPC;
+    }
+
+    for (i =3D 0; i < s->nb_reserved_regions; i++) {
+        prop.head.type =3D VIRTIO_IOMMU_PROBE_T_RESV_MEM;
+        prop.head.length =3D cpu_to_le64(length);
+        prop.subtype =3D cpu_to_le64(s->reserved_regions[i].type);
+        prop.start =3D cpu_to_le64(s->reserved_regions[i].low);
+        prop.end =3D cpu_to_le64(s->reserved_regions[i].high);
+
+        memcpy(buf, &prop, size);
+
+        trace_virtio_iommu_fill_resv_property(ep, prop.subtype,
+                                              prop.start, prop.end);
+        buf +=3D size;
+    }
+    return total;
+}
+
+/**
+ * virtio_iommu_probe - Fill the probe request buffer with
+ * the properties the device is able to return and add a NONE
+ * property at the end.
+ */
+static int virtio_iommu_probe(VirtIOIOMMU *s,
+                              struct virtio_iommu_req_probe *req,
+                              uint8_t *buf)
+{
+    uint32_t ep_id =3D le32_to_cpu(req->endpoint);
+    struct virtio_iommu_probe_property last =3D {};
+    size_t free =3D VIOMMU_PROBE_SIZE - sizeof(last);
+    ssize_t count;
+
+    count =3D virtio_iommu_fill_resv_mem_prop(s, ep_id, buf, free);
+    if (count < 0) {
+            return VIRTIO_IOMMU_S_INVAL;
+    }
+    buf +=3D count;
+    free -=3D count;
+
+    memcpy(buf, &last, sizeof(last));
+
+    return VIRTIO_IOMMU_S_OK;
+}
+
 static int virtio_iommu_iov_to_req(struct iovec *iov,
                                    unsigned int iov_cnt,
                                    void *req, size_t req_sz)
@@ -346,6 +402,17 @@ virtio_iommu_handle_req(detach)
 virtio_iommu_handle_req(map)
 virtio_iommu_handle_req(unmap)
=20
+static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
+                                     struct iovec *iov,
+                                     unsigned int iov_cnt,
+                                     uint8_t *buf)
+{
+    struct virtio_iommu_req_probe req;
+    int ret =3D virtio_iommu_iov_to_req(iov, iov_cnt, &req, sizeof(req));
+
+    return ret ? ret : virtio_iommu_probe(s, &req, buf);
+}
+
 static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOIOMMU *s =3D VIRTIO_IOMMU(vdev);
@@ -391,17 +458,33 @@ static void virtio_iommu_handle_command(VirtIODevice =
*vdev, VirtQueue *vq)
         case VIRTIO_IOMMU_T_UNMAP:
             tail.status =3D virtio_iommu_handle_unmap(s, iov, iov_cnt);
             break;
+        case VIRTIO_IOMMU_T_PROBE:
+        {
+            struct virtio_iommu_req_tail *ptail;
+            uint8_t *buf =3D g_malloc0(s->config.probe_size + sizeof(tail)=
);
+
+            ptail =3D (struct virtio_iommu_req_tail *)
+                        (buf + s->config.probe_size);
+            ptail->status =3D virtio_iommu_handle_probe(s, iov, iov_cnt, b=
uf);
+
+            sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
+                              buf, s->config.probe_size + sizeof(tail));
+            g_free(buf);
+            assert(sz =3D=3D s->config.probe_size + sizeof(tail));
+            goto push;
+        }
         default:
             tail.status =3D VIRTIO_IOMMU_S_UNSUPP;
         }
-        qemu_mutex_unlock(&s->mutex);
=20
 out:
         sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
                           &tail, sizeof(tail));
         assert(sz =3D=3D sizeof(tail));
=20
-        virtqueue_push(vq, elem, sizeof(tail));
+push:
+        qemu_mutex_unlock(&s->mutex);
+        virtqueue_push(vq, elem, sz);
         virtio_notify(vdev, vq);
         g_free(elem);
     }
@@ -624,6 +707,7 @@ static void virtio_iommu_device_realize(DeviceState *de=
v, Error **errp)
     s->config.page_size_mask =3D TARGET_PAGE_MASK;
     s->config.input_range.end =3D -1UL;
     s->config.domain_range.end =3D 32;
+    s->config.probe_size =3D VIOMMU_PROBE_SIZE;
=20
     virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
     virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
@@ -633,6 +717,7 @@ static void virtio_iommu_device_realize(DeviceState *de=
v, Error **errp)
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_PROBE);
=20
     qemu_mutex_init(&s->mutex);
=20
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-io=
mmu.h
index 1ab6993d29..4176785368 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -57,6 +57,8 @@ typedef struct VirtIOIOMMU {
     GHashTable *as_by_busptr;
     IOMMUPciBus *as_by_bus_num[IOMMU_PCI_BUS_MAX];
     PCIBus *primary_bus;
+    Interval *reserved_regions;
+    uint32_t nb_reserved_regions;
     GTree *domains;
     QemuMutex mutex;
     GTree *endpoints;
--=20
2.20.1


