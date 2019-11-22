Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0627C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7592068F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D61oZeyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7592068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDmd-00056J-Dm
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iYDhl-0008H7-Bu
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iYDhk-0000AU-5e
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:30:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37035
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iYDhk-0000AG-1j
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574447451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0ACkwGHuTAl+zNilTLyl19bEIp0WiTEJD5IwjDPAak=;
 b=D61oZeyYQm9gMOn11DMZ5yzgxvJRXJEO5Ed1v5DowR3+8VdfPUR7/O9t2cUiAXErtP2AaZ
 ddcjNQpYKnFi+OKutLb7MVN/1Z5Ks0r8MBFQvDCUHbPE/asjRNbbk6YoV6I7Jc6/Lvkwrk
 ZCt09YemaIdtwny3SyDgjEmN2+SwEtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-Tg2joNn_NZKiNIsD2oYoXA-1; Fri, 22 Nov 2019 13:30:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E55718A43CE;
 Fri, 22 Nov 2019 18:30:48 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EC859F47;
 Fri, 22 Nov 2019 18:30:45 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, jean-philippe.brucker@arm.com, bharatb.linux@gmail.com,
 yang.zhong@intel.com, dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH for-5.0 v11 06/20] virtio-iommu: Implement attach/detach
 command
Date: Fri, 22 Nov 2019 19:29:29 +0100
Message-Id: <20191122182943.4656-7-eric.auger@redhat.com>
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Tg2joNn_NZKiNIsD2oYoXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: kevin.tian@intel.com, peterx@redhat.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements the endpoint attach/detach to/from
a domain.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
---
 hw/virtio/virtio-iommu.c | 43 ++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 235bde2203..138d5b2a9c 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -77,11 +77,12 @@ static gint interval_cmp(gconstpointer a, gconstpointer=
 b, gpointer user_data)
 static void virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep)
 {
     QLIST_REMOVE(ep, next);
+    g_tree_unref(ep->domain->mappings);
     ep->domain =3D NULL;
 }
=20
-viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep_id)=
;
-viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s, uint32_t ep_id)
+static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
+                                                  uint32_t ep_id)
 {
     viommu_endpoint *ep;
=20
@@ -102,15 +103,14 @@ static void virtio_iommu_put_endpoint(gpointer data)
=20
     if (ep->domain) {
         virtio_iommu_detach_endpoint_from_domain(ep);
-        g_tree_unref(ep->domain->mappings);
     }
=20
     trace_virtio_iommu_put_endpoint(ep->id);
     g_free(ep);
 }
=20
-viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain_id)=
;
-viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain_id)
+static viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s,
+                                              uint32_t domain_id)
 {
     viommu_domain *domain;
=20
@@ -137,7 +137,6 @@ static void virtio_iommu_put_domain(gpointer data)
     QLIST_FOREACH_SAFE(iter, &domain->endpoint_list, next, tmp) {
         virtio_iommu_detach_endpoint_from_domain(iter);
     }
-    g_tree_destroy(domain->mappings);
     trace_virtio_iommu_put_domain(domain->id);
     g_free(domain);
 }
@@ -186,10 +185,27 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
 {
     uint32_t domain_id =3D le32_to_cpu(req->domain);
     uint32_t ep_id =3D le32_to_cpu(req->endpoint);
+    viommu_domain *domain;
+    viommu_endpoint *ep;
=20
     trace_virtio_iommu_attach(domain_id, ep_id);
=20
-    return VIRTIO_IOMMU_S_UNSUPP;
+    ep =3D virtio_iommu_get_endpoint(s, ep_id);
+    if (ep->domain) {
+        /*
+         * the device is already attached to a domain,
+         * detach it first
+         */
+        virtio_iommu_detach_endpoint_from_domain(ep);
+    }
+
+    domain =3D virtio_iommu_get_domain(s, domain_id);
+    QLIST_INSERT_HEAD(&domain->endpoint_list, ep, next);
+
+    ep->domain =3D domain;
+    g_tree_ref(domain->mappings);
+
+    return VIRTIO_IOMMU_S_OK;
 }
=20
 static int virtio_iommu_detach(VirtIOIOMMU *s,
@@ -197,10 +213,21 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
 {
     uint32_t domain_id =3D le32_to_cpu(req->domain);
     uint32_t ep_id =3D le32_to_cpu(req->endpoint);
+    viommu_endpoint *ep;
=20
     trace_virtio_iommu_detach(domain_id, ep_id);
=20
-    return VIRTIO_IOMMU_S_UNSUPP;
+    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
+    if (!ep) {
+        return VIRTIO_IOMMU_S_NOENT;
+    }
+
+    if (!ep->domain) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
+    virtio_iommu_detach_endpoint_from_domain(ep);
+    return VIRTIO_IOMMU_S_OK;
 }
=20
 static int virtio_iommu_map(VirtIOIOMMU *s,
--=20
2.20.1


