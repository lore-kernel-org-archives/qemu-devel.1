Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A4CC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840C62084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bc5K1/6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840C62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sly-0002fY-Nm
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6seo-0004xq-SH
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sen-0008R9-AG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33177
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sen-0008Qc-5q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCHf9L72V/C0Pq98N5gIZEjtBfCuRngk9tHaSFXAuXI=;
 b=Bc5K1/6K3RbFGzaFQv40GGFU+wF42Zd4S9s+JwYQ18n2iJFi+N8Hk6glo7S51+yhoVPpwy
 no+aEcBBAr9XMgZwpliDTqPLpcta6437hJXVV5FNUHcLIc2ooBc9qHKXxqYzyBjd7lK5hY
 zDqG+eT9xgJcfOAP5Zpd23nuKJtcTWw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-u-k_nLEZO-OwvVtkrN3SEQ-1; Wed, 26 Feb 2020 04:07:02 -0500
X-MC-Unique: u-k_nLEZO-OwvVtkrN3SEQ-1
Received: by mail-wr1-f71.google.com with SMTP id z1so1186802wrs.9
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fMIucinzsx9/9CFPWzNLF6NCV2892T+sCnYLhAijSBk=;
 b=fms9zmihMHsPSbOORf87vvN3MkW9kv1ZXRTXDjL3Cz4k3JShs5op3/9VypSazxeFjv
 Htx3MZiK0M+goEUXMJ82l4W7A3T7lyAis2Hnh3dIjDXMUzQrTG5Si9ryVqDxw2YNFJ43
 EV9WEY/5jff4X3mG8Wy9DwNpddcPnRXgB7/xYKuox7uEZmu9KCX84YqC19c/VgLCLhJm
 1A8HTwXv+jopkpC0/ZrhxNXG5txbIIWeg8LhB2v+8h6cRcakvTer9cN5TnfDzQELwORc
 4aDaxXwcO35U0YbqWB4lAhW42VR7LkP2XmDdOgeBthkYWb/t57cdMo7N44w29V4Jl0Z3
 o9sw==
X-Gm-Message-State: APjAAAV23CQLbFW/lXYNUNDXFqf2k/JYFxjyidBKejBqGCdE5DrjYnJA
 Hkjq/vnE+t/iF+RbEzVIsy6KpiieC0gEQVxXDOkwBm1Du1a5CqLw5QDShMqnGvz5X3ndBIYRhU3
 adJG44tfxW3PzPY4=
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr4237888wmf.63.1582708021339; 
 Wed, 26 Feb 2020 01:07:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEe9qGtTSjnph2l+n4efoPvZ0fCNimm1TcNOPQJDpuzMJUAjGGueNeLYWJy1fNh3q+uXjNeQ==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr4237858wmf.63.1582708021049; 
 Wed, 26 Feb 2020 01:07:01 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 133sm2158279wme.32.2020.02.26.01.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:07:00 -0800 (PST)
Date: Wed, 26 Feb 2020 04:07:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 17/30] virtio-iommu: Implement fault reporting
Message-ID: <20200226090010.708934-18-mst@redhat.com>
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

The event queue allows to report asynchronous errors.
The translate function now injects faults when relevant.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Message-Id: <20200214132745.23392-7-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 70 +++++++++++++++++++++++++++++++++++++---
 hw/virtio/trace-events   |  1 +
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 59e9cd3d9a..8509f64004 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -468,6 +468,48 @@ out:
     }
 }
=20
+static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
+                                      int flags, uint32_t endpoint,
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
+    fault.flags =3D cpu_to_le32(flags);
+    fault.endpoint =3D cpu_to_le32(endpoint);
+    fault.address =3D cpu_to_le64(address);
+
+    elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
+
+    if (!elem) {
+        error_report_once(
+            "no buffer available in event queue to report event");
+        return;
+    }
+
+    if (iov_size(elem->in_sg, elem->in_num) < sizeof(fault)) {
+        virtio_error(vdev, "error buffer of wrong size");
+        virtqueue_detach_element(vq, elem, 0);
+        g_free(elem);
+        return;
+    }
+
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
@@ -476,9 +518,10 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemor=
yRegion *mr, hwaddr addr,
     VirtIOIOMMUInterval interval, *mapping_key;
     VirtIOIOMMUMapping *mapping_value;
     VirtIOIOMMU *s =3D sdev->viommu;
+    bool read_fault, write_fault;
     VirtIOIOMMUEndpoint *ep;
+    uint32_t sid, flags;
     bool bypass_allowed;
-    uint32_t sid;
     bool found;
=20
     interval.low =3D addr;
@@ -504,6 +547,9 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemory=
Region *mr, hwaddr addr,
     if (!ep) {
         if (!bypass_allowed) {
             error_report_once("%s sid=3D%d is not known!!", __func__, sid)=
;
+            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_UNKNOWN,
+                                      VIRTIO_IOMMU_FAULT_F_ADDRESS,
+                                      sid, addr);
         } else {
             entry.perm =3D flag;
         }
@@ -515,6 +561,9 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemory=
Region *mr, hwaddr addr,
             error_report_once("%s %02x:%02x.%01x not attached to any domai=
n",
                               __func__, PCI_BUS_NUM(sid),
                               PCI_SLOT(sid), PCI_FUNC(sid));
+            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_DOMAIN,
+                                      VIRTIO_IOMMU_FAULT_F_ADDRESS,
+                                      sid, addr);
         } else {
             entry.perm =3D flag;
         }
@@ -527,15 +576,26 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemo=
ryRegion *mr, hwaddr addr,
     if (!found) {
         error_report_once("%s no mapping for 0x%"PRIx64" for sid=3D%d",
                           __func__, addr, sid);
+        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
+                                  VIRTIO_IOMMU_FAULT_F_ADDRESS,
+                                  sid, addr);
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
         error_report_once("%s permission error on 0x%"PRIx64"(%d): allowed=
=3D%d",
                           __func__, addr, flag, mapping_value->flags);
+        flags |=3D VIRTIO_IOMMU_FAULT_F_ADDRESS;
+        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
+                                  flags | VIRTIO_IOMMU_FAULT_F_ADDRESS,
+                                  sid, addr);
         goto unlock;
     }
     entry.translated_addr =3D addr - mapping_key->low + mapping_value->phy=
s_addr;
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 095aa8b509..e83500bee9 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -72,3 +72,4 @@ virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=
=3D%d"
 virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=3D%d"
 virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
 virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_=
t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
+virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoin=
t, uint64_t addr) "FAULT reason=3D%d flags=3D%d endpoint=3D%d address =3D0x=
%"PRIx64
--=20
MST


