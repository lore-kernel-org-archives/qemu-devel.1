Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D89C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60A52068F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T30Ea0E7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60A52068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDmN-0004r3-DU
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iYDhP-000868-Nf
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iYDhN-0008NY-Sp
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:30:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49315
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iYDhN-0008Mz-OC
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574447429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hhhgWsyNc3pla/vGmQZILIxsZVrcOAjmqOxlbdFndM=;
 b=T30Ea0E7HqtkIRisBXCLVmac7edfsyDVylsQg9/Jh3aTQ9Gsxs43oQQOJO65/uk1NwIZRS
 xPudb1wbYbPXpFOqUJ08G+HfhPSqIngVAz9thf6LlVSakAziHNjkLFfy8gs4jCDPK1dv8d
 CDUrlNznaQXNEuFS5Gg7/6b7aoora0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-xA-7bsoSNDedgquKPaJDHQ-1; Fri, 22 Nov 2019 13:30:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB12B2F34;
 Fri, 22 Nov 2019 18:30:26 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B8346E71C;
 Fri, 22 Nov 2019 18:30:23 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, jean-philippe.brucker@arm.com, bharatb.linux@gmail.com,
 yang.zhong@intel.com, dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH for-5.0 v11 03/20] virtio-iommu: Decode the command payload
Date: Fri, 22 Nov 2019 19:29:26 +0100
Message-Id: <20191122182943.4656-4-eric.auger@redhat.com>
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: xA-7bsoSNDedgquKPaJDHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kevin.tian@intel.com, peterx@redhat.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds the command payload decoding and
introduces the functions that will do the actual
command handling. Those functions are not yet implemented.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v10 -> v11:
- use a macro for handle command functions

v9 -> v10:
- make virtio_iommu_handle_* more compact and
  remove get_payload_size

v7 -> v8:
- handle new domain parameter in detach
- remove reserved checks

v5 -> v6:
- change map/unmap semantics (remove size)

v4 -> v5:
- adopt new v0.5 terminology

v3 -> v4:
- no flags field anymore in struct virtio_iommu_req_unmap
- test reserved on attach/detach, change trace proto
- rebase on v2.10.0.
---
 hw/virtio/trace-events   |  4 +++
 hw/virtio/virtio-iommu.c | 76 +++++++++++++++++++++++++++++++++-------
 2 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index f7dac39213..c7276116e7 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -61,3 +61,7 @@ virtio_iommu_set_features(uint64_t features) "features ac=
cepted by the driver =3D0
 virtio_iommu_device_status(uint8_t status) "driver status =3D %d"
 virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_t =
end, uint32_t domain_range, uint32_t probe_size) "page_size_mask=3D0x%"PRIx=
64" start=3D0x%"PRIx64" end=3D0x%"PRIx64" domain_range=3D%d probe_size=3D0x=
%x"
 virtio_iommu_set_config(uint64_t page_size_mask, uint64_t start, uint64_t =
end, uint32_t domain_range, uint32_t probe_size) "page_size_mask=3D0x%"PRIx=
64" start=3D0x%"PRIx64" end=3D0x%"PRIx64" domain_bits=3D%d probe_size=3D0x%=
x"
+virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id) "domain=3D%d endpo=
int=3D%d"
+virtio_iommu_detach(uint32_t domain_id, uint32_t ep_id) "domain=3D%d endpo=
int=3D%d"
+virtio_iommu_map(uint32_t domain_id, uint64_t virt_start, uint64_t virt_en=
d, uint64_t phys_start, uint32_t flags) "domain=3D%d virt_start=3D0x%"PRIx6=
4" virt_end=3D0x%"PRIx64 " phys_start=3D0x%"PRIx64" flags=3D%d"
+virtio_iommu_unmap(uint32_t domain_id, uint64_t virt_start, uint64_t virt_=
end) "domain=3D%d virt_start=3D0x%"PRIx64" virt_end=3D0x%"PRIx64
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 7b25db3713..afd6397ac9 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -34,31 +34,83 @@
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
=20
-static int virtio_iommu_handle_attach(VirtIOIOMMU *s,
-                                      struct iovec *iov,
-                                      unsigned int iov_cnt)
+static int virtio_iommu_attach(VirtIOIOMMU *s,
+                               struct virtio_iommu_req_attach *req)
 {
+    uint32_t domain_id =3D le32_to_cpu(req->domain);
+    uint32_t ep_id =3D le32_to_cpu(req->endpoint);
+
+    trace_virtio_iommu_attach(domain_id, ep_id);
+
     return VIRTIO_IOMMU_S_UNSUPP;
 }
-static int virtio_iommu_handle_detach(VirtIOIOMMU *s,
-                                      struct iovec *iov,
-                                      unsigned int iov_cnt)
+
+static int virtio_iommu_detach(VirtIOIOMMU *s,
+                               struct virtio_iommu_req_detach *req)
 {
+    uint32_t domain_id =3D le32_to_cpu(req->domain);
+    uint32_t ep_id =3D le32_to_cpu(req->endpoint);
+
+    trace_virtio_iommu_detach(domain_id, ep_id);
+
     return VIRTIO_IOMMU_S_UNSUPP;
 }
-static int virtio_iommu_handle_map(VirtIOIOMMU *s,
-                                   struct iovec *iov,
-                                   unsigned int iov_cnt)
+
+static int virtio_iommu_map(VirtIOIOMMU *s,
+                            struct virtio_iommu_req_map *req)
 {
+    uint32_t domain_id =3D le32_to_cpu(req->domain);
+    uint64_t phys_start =3D le64_to_cpu(req->phys_start);
+    uint64_t virt_start =3D le64_to_cpu(req->virt_start);
+    uint64_t virt_end =3D le64_to_cpu(req->virt_end);
+    uint32_t flags =3D le32_to_cpu(req->flags);
+
+    trace_virtio_iommu_map(domain_id, virt_start, virt_end, phys_start, fl=
ags);
+
     return VIRTIO_IOMMU_S_UNSUPP;
 }
-static int virtio_iommu_handle_unmap(VirtIOIOMMU *s,
-                                     struct iovec *iov,
-                                     unsigned int iov_cnt)
+
+static int virtio_iommu_unmap(VirtIOIOMMU *s,
+                              struct virtio_iommu_req_unmap *req)
 {
+    uint32_t domain_id =3D le32_to_cpu(req->domain);
+    uint64_t virt_start =3D le64_to_cpu(req->virt_start);
+    uint64_t virt_end =3D le64_to_cpu(req->virt_end);
+
+    trace_virtio_iommu_unmap(domain_id, virt_start, virt_end);
+
     return VIRTIO_IOMMU_S_UNSUPP;
 }
=20
+static int virtio_iommu_iov_to_req(struct iovec *iov,
+                                   unsigned int iov_cnt,
+                                   void *req, size_t req_sz)
+{
+    size_t sz, payload_sz =3D req_sz - sizeof(struct virtio_iommu_req_tail=
);
+
+    sz =3D iov_to_buf(iov, iov_cnt, 0, req, payload_sz);
+    if (unlikely(sz !=3D payload_sz)) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+    return 0;
+}
+
+#define virtio_iommu_handle_req(__req)                                  \
+static int virtio_iommu_handle_ ## __req(VirtIOIOMMU *s,                \
+                                         struct iovec *iov,             \
+                                         unsigned int iov_cnt)          \
+{                                                                       \
+    struct virtio_iommu_req_ ## __req req;                              \
+    int ret =3D virtio_iommu_iov_to_req(iov, iov_cnt, &req, sizeof(req)); =
\
+                                                                        \
+    return ret ? ret : virtio_iommu_ ## __req(s, &req);                 \
+}
+
+virtio_iommu_handle_req(attach)
+virtio_iommu_handle_req(detach)
+virtio_iommu_handle_req(map)
+virtio_iommu_handle_req(unmap)
+
 static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOIOMMU *s =3D VIRTIO_IOMMU(vdev);
--=20
2.20.1


