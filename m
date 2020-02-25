Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A63C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E222064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMqIaKra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E222064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c1f-0005At-Gf
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6buE-0000Jz-ES
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6buD-0001Jz-7k
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6buD-0001Jc-2n
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Hdj7mMudGk1On0DfbPW0ZE9c8URLY6uwbzuI/qZJHc=;
 b=QMqIaKrayFywYXUFHmcrzaFMHVEwSr1rh5eFa7xdZoOZjVxxTwWvLh930sdAdXZ8T+gZra
 WFFViH90l3qgWknYPYQYlU/yEHRt+hDdce77pEiQsN9064XuDkBPhWf6w01GxSRbjj5Sz/
 eKRhOwc9+uwhAjlWYPuc3aN8BZNGb+Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-HRWsKFzuOciHhzTA-vSiqg-1; Tue, 25 Feb 2020 10:13:50 -0500
X-MC-Unique: HRWsKFzuOciHhzTA-vSiqg-1
Received: by mail-qt1-f200.google.com with SMTP id o24so15208192qtr.17
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=24gCc88fSkegGYSyr5CnQiCms+AAwtwlqsX/zbg/vTA=;
 b=UbTFrNGsQdbHvDt05EdwYacQIYPH24Ogb2EAe7swIOBlmfML+6v+99ngvLRUPWd2Oq
 7TtpR+9sguGtyBJ12/g41229yZ79dHQlr2wut0SI7xXqT+ww4Yzn175RsveVd+LntWnE
 4pkEbtCe0MLCwtC35ogqXvbmLKY9QSNbF77aam9Wc3HmB9wceX336Sb19acYmhPLSPYB
 QsAoflT9/NIKsbTkexQn5FHBLBIKOn9HOtNDWf84oNjsbBTMcM/NElokV5jXmb4Q8zH5
 wp64UXL6xSsX94KH6Ug+c3GJ6uq+thlISC07kCvtludUVgveWwOQDetmJnSBDO2VGgjQ
 8xFw==
X-Gm-Message-State: APjAAAX86PxQtdUibEdyojYHw/T0c4ZTht9niaVXFkRJe6AX19j+F+fJ
 Q5cFqmFn9Z9V9/Bg5u0TJJAg0hFCpHblTFNsBv0qEfmFLqyUl3cQ+7DSTHKCJ/C/dKYLI3yyqg2
 7ejupiQFxP5cO+q4=
X-Received: by 2002:a37:66c8:: with SMTP id a191mr13320071qkc.0.1582643629451; 
 Tue, 25 Feb 2020 07:13:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEmiANRPLpoRJld98WMa5sG0h0/Gd5C64IcqE8o38i2boTgLwdCWz1iD/PmtLdop/fy30Hyg==
X-Received: by 2002:a37:66c8:: with SMTP id a191mr13320048qkc.0.1582643629254; 
 Tue, 25 Feb 2020 07:13:49 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 w53sm7684910qtb.91.2020.02.25.07.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:13:48 -0800 (PST)
Date: Tue, 25 Feb 2020 10:13:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/32] virtio-iommu: Implement translate
Message-ID: <20200225151210.647797-17-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
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
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

This patch implements the translate callback

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Message-Id: <20200214132745.23392-6-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 60 +++++++++++++++++++++++++++++++++++++++-
 hw/virtio/trace-events   |  1 +
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 844d34c270..59e9cd3d9a 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -473,19 +473,77 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemo=
ryRegion *mr, hwaddr addr,
                                             int iommu_idx)
 {
     IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMUInterval interval, *mapping_key;
+    VirtIOIOMMUMapping *mapping_value;
+    VirtIOIOMMU *s =3D sdev->viommu;
+    VirtIOIOMMUEndpoint *ep;
+    bool bypass_allowed;
     uint32_t sid;
+    bool found;
+
+    interval.low =3D addr;
+    interval.high =3D addr + 1;
=20
     IOMMUTLBEntry entry =3D {
         .target_as =3D &address_space_memory,
         .iova =3D addr,
         .translated_addr =3D addr,
-        .addr_mask =3D ~(hwaddr)0,
+        .addr_mask =3D (1 << ctz32(s->config.page_size_mask)) - 1,
         .perm =3D IOMMU_NONE,
     };
=20
+    bypass_allowed =3D virtio_vdev_has_feature(&s->parent_obj,
+                                             VIRTIO_IOMMU_F_BYPASS);
+
     sid =3D virtio_iommu_get_bdf(sdev);
=20
     trace_virtio_iommu_translate(mr->parent_obj.name, sid, addr, flag);
+    qemu_mutex_lock(&s->mutex);
+
+    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(sid));
+    if (!ep) {
+        if (!bypass_allowed) {
+            error_report_once("%s sid=3D%d is not known!!", __func__, sid)=
;
+        } else {
+            entry.perm =3D flag;
+        }
+        goto unlock;
+    }
+
+    if (!ep->domain) {
+        if (!bypass_allowed) {
+            error_report_once("%s %02x:%02x.%01x not attached to any domai=
n",
+                              __func__, PCI_BUS_NUM(sid),
+                              PCI_SLOT(sid), PCI_FUNC(sid));
+        } else {
+            entry.perm =3D flag;
+        }
+        goto unlock;
+    }
+
+    found =3D g_tree_lookup_extended(ep->domain->mappings, (gpointer)(&int=
erval),
+                                   (void **)&mapping_key,
+                                   (void **)&mapping_value);
+    if (!found) {
+        error_report_once("%s no mapping for 0x%"PRIx64" for sid=3D%d",
+                          __func__, addr, sid);
+        goto unlock;
+    }
+
+    if (((flag & IOMMU_RO) &&
+            !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_READ)) ||
+        ((flag & IOMMU_WO) &&
+            !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_WRITE))) {
+        error_report_once("%s permission error on 0x%"PRIx64"(%d): allowed=
=3D%d",
+                          __func__, addr, flag, mapping_value->flags);
+        goto unlock;
+    }
+    entry.translated_addr =3D addr - mapping_key->low + mapping_value->phy=
s_addr;
+    entry.perm =3D flag;
+    trace_virtio_iommu_translate_out(addr, entry.translated_addr, sid);
+
+unlock:
+    qemu_mutex_unlock(&s->mutex);
     return entry;
 }
=20
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 22162d6583..095aa8b509 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -71,3 +71,4 @@ virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc endpoint=
=3D%d"
 virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=3D%d"
 virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=3D%d"
 virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
+virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_=
t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
--=20
MST


