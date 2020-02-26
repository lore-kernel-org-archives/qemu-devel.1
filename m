Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5BBC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50BC2084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beOjqDMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50BC2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6shH-0001j4-2a
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6seX-0004JA-9F
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6seV-00085z-Tt
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21225
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6seV-00084m-PD
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/w2N230joZaIbVFEeZj6pkIIAP2Uumpk89HeYYYv1Q=;
 b=beOjqDMjZlo7FqmqqqdvIpl6dmD9EECD29C7XQbBQAktP+ItHJHQ5bJmWo4KCZ91Lz357D
 X1i06x1GAs7j0WBA2YyEzPVxchty9ygilhx2gVPLQdNi1yUoZUhGgITZL9hv9GqxuXLsaB
 64M3OXxrIARf63Nuy9o7GKnFUggy4mc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-WbEMKDZBNM2RsIuVw_qWIg-1; Wed, 26 Feb 2020 04:06:43 -0500
X-MC-Unique: WbEMKDZBNM2RsIuVw_qWIg-1
Received: by mail-wr1-f70.google.com with SMTP id o9so1181493wrw.14
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xgmvF32cDUq1wlORUl4l7hsilZtejs0VN2pRRuhnjaA=;
 b=fIfpWpujYWQt16MHNGySp2ndHktN4YE65Ge7/FprxOIjTTnosNx6WY4xMbtjQKtLAa
 9PSBcCy4zfsIxxnO9PXpPPSPO7WTjpaI932IydXlTGkN7gcVzD4G0Vtxv5HWddp5+4Wf
 WBeo6xmt/2nbSjcEHg+AmbZ2z0me6C2GMHoPhWqgBIwDWVqunpjWsaQqiuVBo9n9z/Fj
 kxot7SjNUDGDWNsMh/FCvP4XjYlbhT3tHHMi4asS+GdJwCIvUlPby56S4Bc4wLYmKOrQ
 bk1spjPsPp1F8mEtSxKlhf6KixHPg9YpwvOVRIyvKJOyGiIFm58vU4O+EGq2em4twQc0
 +8Jg==
X-Gm-Message-State: APjAAAUatvMrORs3Ma+C6lsa4mtcRkpXeb6/1Rg9UrfYKIeIxIOsZB4F
 5/BAd9tVwt/cHXSPEBIHOpJFaceeRZrUFqwxKH+qR1wW76LstC4zcBI6KJEqP+oUiLeKlkoouf4
 V3ZEUbdIxNVrXpF0=
X-Received: by 2002:a05:600c:2c13:: with SMTP id
 q19mr4390342wmg.144.1582708002284; 
 Wed, 26 Feb 2020 01:06:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcLs3ZAe4gT2cC2ok7Dym/BILiiM/24idm44dGufeiasREy0JuWf4BWNgSGIRbji/2dR8/Qg==
X-Received: by 2002:a05:600c:2c13:: with SMTP id
 q19mr4390323wmg.144.1582708002062; 
 Wed, 26 Feb 2020 01:06:42 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 j11sm2084667wmi.3.2020.02.26.01.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:06:41 -0800 (PST)
Date: Wed, 26 Feb 2020 04:06:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 13/30] virtio-iommu: Decode the command payload
Message-ID: <20200226090010.708934-14-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

This patch adds the command payload decoding and
introduces the functions that will do the actual
command handling. Those functions are not yet implemented.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Message-Id: <20200214132745.23392-3-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 76 +++++++++++++++++++++++++++++++++-------
 hw/virtio/trace-events   |  4 +++
 2 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 30579267d5..86dcdc09a1 100644
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
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 02d93d7f63..f7141aa2f6 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -60,3 +60,7 @@ virtio_iommu_get_features(uint64_t features) "device supp=
orts features=3D0x%"PRIx6
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
--=20
MST


