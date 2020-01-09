Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A20AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B2820673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxNmlS/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B2820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZ4q-0000yo-Q9
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ipZ2r-0007WT-LY
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ipZ2q-0008KH-7n
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:44:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ipZ2q-0008Hr-1b
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578581059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbGzhuyDV3kWquhNPkHwxDawppvqT0DJ6GLTMkO+8XM=;
 b=UxNmlS/4U7klU4vL2q8wPztRMyx9ggl5KlB4q1JESfMswhBqS4A++uZZSpdEiwowEpyoQc
 EtU13Mz0R0sfcj0/lnB/Fx0+RMMitHLT0xiDtXI5Mw3tagPir72du3cpAUUczV0vfgicHC
 92tfjRdgrNWzGAiRnPm6Buh5z3gxI58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-ALVZslyBMzi0465emQW0Zw-1; Thu, 09 Jan 2020 09:44:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1F0B800EBF;
 Thu,  9 Jan 2020 14:44:16 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6292960FC6;
 Thu,  9 Jan 2020 14:44:06 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, jean-philippe@linaro.org,
 dgilbert@redhat.com, quintela@redhat.com, mst@redhat.com, peterx@redhat.com
Subject: [PATCH v12 06/13] virtio-iommu: Implement attach/detach command
Date: Thu,  9 Jan 2020 15:43:12 +0100
Message-Id: <20200109144319.15912-7-eric.auger@redhat.com>
In-Reply-To: <20200109144319.15912-1-eric.auger@redhat.com>
References: <20200109144319.15912-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ALVZslyBMzi0465emQW0Zw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: kevin.tian@intel.com, bharatb.linux@gmail.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements the endpoint attach/detach to/from
a domain.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v11 -> v12:
- check the device is protected by the iommu on attach
- on detach, check the domain id the device is attached to matches
  the one used in the detach command
- fix mapping ref counter and destroy the domain when no end-points
  are attached anymore
---
 hw/virtio/virtio-iommu.c | 65 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 6a03c3d7ae..63b2d30f28 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -119,11 +119,12 @@ static gint interval_cmp(gconstpointer a, gconstpoint=
er b, gpointer user_data)
 static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *=
ep)
 {
     QLIST_REMOVE(ep, next);
+    g_tree_unref(ep->domain->mappings);
     ep->domain =3D NULL;
 }
=20
-VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep=
_id);
-VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep=
_id)
+static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
+                                                      uint32_t ep_id)
 {
     VirtIOIOMMUEndpoint *ep;
=20
@@ -151,8 +152,8 @@ static void virtio_iommu_put_endpoint(gpointer data)
     g_free(ep);
 }
=20
-VirtIOIOMMUDomain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain=
_id);
-VirtIOIOMMUDomain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain=
_id)
+static VirtIOIOMMUDomain *virtio_iommu_get_domain(VirtIOIOMMU *s,
+                                                  uint32_t domain_id)
 {
     VirtIOIOMMUDomain *domain;
=20
@@ -179,7 +180,6 @@ static void virtio_iommu_put_domain(gpointer data)
     QLIST_FOREACH_SAFE(iter, &domain->endpoint_list, next, tmp) {
         virtio_iommu_detach_endpoint_from_domain(iter);
     }
-    g_tree_destroy(domain->mappings);
     trace_virtio_iommu_put_domain(domain->id);
     g_free(domain);
 }
@@ -228,10 +228,37 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
 {
     uint32_t domain_id =3D le32_to_cpu(req->domain);
     uint32_t ep_id =3D le32_to_cpu(req->endpoint);
+    VirtIOIOMMUDomain *domain;
+    VirtIOIOMMUEndpoint *ep;
=20
     trace_virtio_iommu_attach(domain_id, ep_id);
=20
-    return VIRTIO_IOMMU_S_UNSUPP;
+    ep =3D virtio_iommu_get_endpoint(s, ep_id);
+    if (!ep) {
+        return VIRTIO_IOMMU_S_NOENT;
+    }
+
+    if (ep->domain) {
+        VirtIOIOMMUDomain *previous_domain =3D ep->domain;
+        /*
+         * the device is already attached to a domain,
+         * detach it first
+         */
+        virtio_iommu_detach_endpoint_from_domain(ep);
+        if (QLIST_EMPTY(&previous_domain->endpoint_list)) {
+            g_tree_remove(s->domains, GUINT_TO_POINTER(previous_domain->id=
));
+        }
+    }
+
+    domain =3D virtio_iommu_get_domain(s, domain_id);
+    if (!QLIST_EMPTY(&domain->endpoint_list)) {
+        g_tree_ref(domain->mappings);
+    }
+    QLIST_INSERT_HEAD(&domain->endpoint_list, ep, next);
+
+    ep->domain =3D domain;
+
+    return VIRTIO_IOMMU_S_OK;
 }
=20
 static int virtio_iommu_detach(VirtIOIOMMU *s,
@@ -239,10 +266,34 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
 {
     uint32_t domain_id =3D le32_to_cpu(req->domain);
     uint32_t ep_id =3D le32_to_cpu(req->endpoint);
+    VirtIOIOMMUDomain *domain;
+    VirtIOIOMMUEndpoint *ep;
=20
     trace_virtio_iommu_detach(domain_id, ep_id);
=20
-    return VIRTIO_IOMMU_S_UNSUPP;
+    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
+    if (!ep) {
+        return VIRTIO_IOMMU_S_NOENT;
+    }
+
+    domain =3D ep->domain;
+
+    if (!domain || domain->id !=3D domain_id) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
+    virtio_iommu_detach_endpoint_from_domain(ep);
+
+    /*
+     * when the last EP is detached, simply remove the domain for
+     * the domain list and destroy it. Note its mappings were already
+     * freed by the ref count mechanism. Next operation involving
+     * the same domain id will re-create one domain object.
+     */
+    if (QLIST_EMPTY(&domain->endpoint_list)) {
+        g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
+    }
+    return VIRTIO_IOMMU_S_OK;
 }
=20
 static int virtio_iommu_map(VirtIOIOMMU *s,
--=20
2.20.1


