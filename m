Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9F3C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CB82084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DODPrW6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CB82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6skm-00008U-Sw
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6seh-0004g4-6G
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sef-0008HE-UF
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53727
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sef-0008H3-MA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlqnYTiCL5sSu8La8pKbwI5Hcn1vRF70/ll/0BpTLCk=;
 b=DODPrW6m7vnkmu5Uti08Fck+4erwkBNdr2z9D1WcnQdmkA0wnM2MWft1MbYTw3InHkyA4b
 8SVg14DEeO5V/9Ed1YJBNz9ctbUizdhhHlGChp7CJD57bo3PGunmMnU2y/EPWVa+guoSkN
 atVnJNaNzH3XoYyfvx71NzT8nkIdOHI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-h6aqFM8JOTGxQ8HO-0sMqg-1; Wed, 26 Feb 2020 04:06:53 -0500
X-MC-Unique: h6aqFM8JOTGxQ8HO-0sMqg-1
Received: by mail-wr1-f72.google.com with SMTP id w18so288759wro.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lHLed9bH8w5j/vQYZvogfr5RN4RsIFaxj1zVa5/6ti0=;
 b=REbufrGB0pK0qlrN7Lbj3nzwsyMIXxfAh46l4nOBvsi/pbq9sd8zlJAKFLQjLoJ5tg
 O3/KqiA07w0Mc0Kl4sa9pxrO5o0ubeuvQluoEvyxMZzXuU+VtF7aX1F6W8FsTDMGUmB4
 w6pm4UuAvymDJS085iAdFEZhxVsgdGSw5EbLc+ppGdoW3TBSK4r5uOupe7eAyMuSo6xp
 UwiJYeAH15KLMgsZPBBkW+oj1vSMf0Sw55cfKJERCkFVKiyGzdFwS1o+KlBa0u3++7z/
 jSMJD2T8Tq+4/OkEBquVf6XaqJnqL/pPsS0JP5lDMTjUWbb7o9IrNAITQX/DQ9VJkB/E
 EwLg==
X-Gm-Message-State: APjAAAUu0gYwPLLd4oXdzBARi7ae9xSkH0jAgodXqvMMuIUwyawAE55B
 mwgYws5S7UF50p1+l4djHHQC3gOBsDtRqo+LPtAB7HCZV3gyy2hzgJAKxYQhY08QTsS3XRSyOgS
 RlMdzmOhYVyStkFY=
X-Received: by 2002:a5d:5263:: with SMTP id l3mr4208569wrc.405.1582708011842; 
 Wed, 26 Feb 2020 01:06:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4z2Rao03tjHq4kJvIfxSe0N5//PKDVfG6wKpUCMSGlOcUhvCxubm34r5YXhKBJvYv9HhtZQ==
X-Received: by 2002:a5d:5263:: with SMTP id l3mr4208552wrc.405.1582708011579; 
 Wed, 26 Feb 2020 01:06:51 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 e11sm2245992wrm.80.2020.02.26.01.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:06:50 -0800 (PST)
Date: Wed, 26 Feb 2020 04:06:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 15/30] virtio-iommu: Implement map/unmap
Message-ID: <20200226090010.708934-16-mst@redhat.com>
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
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

This patch implements virtio_iommu_map/unmap.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Message-Id: <20200214132745.23392-5-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 63 ++++++++++++++++++++++++++++++++++++++--
 hw/virtio/trace-events   |  1 +
 2 files changed, 62 insertions(+), 2 deletions(-)

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
--=20
MST


