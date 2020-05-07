Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C03C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31B92083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vu9unK4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31B92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhce-0005It-5r
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jWhZe-0000Gq-IW
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:32:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jWhZd-0006Ma-BE
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588861948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxWzf4cwhQeaG5mJLeofeJ2I/Uf1lHJfocu+GuvW6Do=;
 b=Vu9unK4StRzKj4XRl80TWMFWTIGBgKE1PbNGIaezBtSH0nJXawTGMmREpdde4W9HtTL7iE
 KP4USKVSBzZ6wnSUwHJva3+vCih0/g7WrSfanr/21lNgNmaH1oiYc1wJX3WKZSeQCWOKVG
 eFhU+ZoXKR11kY5EEQMmiXQS4mcOVHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-z8gll3AVMU2jvN_r4QpTUQ-1; Thu, 07 May 2020 10:32:21 -0400
X-MC-Unique: z8gll3AVMU2jvN_r4QpTUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4ECE3845F29;
 Thu,  7 May 2020 14:32:20 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCBC7707B3;
 Thu,  7 May 2020 14:32:17 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, jean-philippe@linaro.org,
 bbhushan2@marvell.com, peterx@redhat.com, armbru@redhat.com
Subject: [PATCH 2/5] virtio-iommu: Implement RESV_MEM probe request
Date: Thu,  7 May 2020 16:31:58 +0200
Message-Id: <20200507143201.31080-3-eric.auger@redhat.com>
In-Reply-To: <20200507143201.31080-1-eric.auger@redhat.com>
References: <20200507143201.31080-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements the PROBE request. At the moment,
only THE RESV_MEM property is handled. The first goal is
to report iommu wide reserved regions such as the MSI regions
set by the machine code. On x86 this will be the IOAPIC MSI
region, [0xFEE00000 - 0xFEEFFFFF], on ARM this may be the ITS
doorbell.

In the future we may introduce per device reserved regions.
This will be useful when protecting host assigned devices
which may expose their own reserved regions

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

---

Previous version was reviewed by Peter and Jean-Philippe. I
simply removed the NONE property and memset the free space
and reworded the commit message. I dared to keep the R-b.
---
 include/hw/virtio/virtio-iommu.h |  2 +
 hw/virtio/virtio-iommu.c         | 90 +++++++++++++++++++++++++++++++-
 hw/virtio/trace-events           |  1 +
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-io=
mmu.h
index e653004d7c..49eb105cd8 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -53,6 +53,8 @@ typedef struct VirtIOIOMMU {
     GHashTable *as_by_busptr;
     IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
     PCIBus *primary_bus;
+    ReservedRegion *reserved_regions;
+    uint32_t nb_reserved_regions;
     GTree *domains;
     QemuMutex mutex;
     GTree *endpoints;
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 22ba8848c2..95059eff70 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -38,6 +38,7 @@
=20
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
+#define VIOMMU_PROBE_SIZE 512
=20
 typedef struct VirtIOIOMMUDomain {
     uint32_t id;
@@ -378,6 +379,62 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
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
+    /* Fill the rest with zeroes */
+    memset(buf, 0, free);
+
+    return VIRTIO_IOMMU_S_OK;
+}
+
 static int virtio_iommu_iov_to_req(struct iovec *iov,
                                    unsigned int iov_cnt,
                                    void *req, size_t req_sz)
@@ -407,6 +464,17 @@ virtio_iommu_handle_req(detach)
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
@@ -452,17 +520,33 @@ static void virtio_iommu_handle_command(VirtIODevice =
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
@@ -667,6 +751,7 @@ static void virtio_iommu_device_realize(DeviceState *de=
v, Error **errp)
     s->config.page_size_mask =3D TARGET_PAGE_MASK;
     s->config.input_range.end =3D -1UL;
     s->config.domain_range.end =3D 32;
+    s->config.probe_size =3D VIOMMU_PROBE_SIZE;
=20
     virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
     virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
@@ -676,6 +761,7 @@ static void virtio_iommu_device_realize(DeviceState *de=
v, Error **errp)
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_PROBE);
=20
     qemu_mutex_init(&s->mutex);
=20
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index e83500bee9..5550475691 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -73,3 +73,4 @@ virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=
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
--=20
2.20.1


