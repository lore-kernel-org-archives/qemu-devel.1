Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0108EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2872067D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N60b60Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2872067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYE2n-0006js-Pd
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iYDj2-0001eZ-IV
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iYDj1-0000hy-6T
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:32:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iYDj1-0000h8-1u
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574447530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfZYIw3UEsPwHAATMfS141k0p6DtF7ITPQOxirCtQ/o=;
 b=N60b60Em4NjMiqzXOTPHqGA36wwda+WJ+zH4byA4Wi4bcTY+ybcLb5GaYo9e1tUOqw+XMD
 98vChgp9hCF4kBaLJuCdc9yHqUDemS6RxU7PPauhrtXwt4MEd+IN+b61rzhxftf2nyrZ2+
 ls4SkvKev9CNpmEc/q2J1MmwQPWoJ0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-gO6uWk4uOd2yIJgV7sIkWw-1; Fri, 22 Nov 2019 13:32:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBE18DB60;
 Fri, 22 Nov 2019 18:32:07 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6225361074;
 Fri, 22 Nov 2019 18:32:04 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, jean-philippe.brucker@arm.com, bharatb.linux@gmail.com,
 yang.zhong@intel.com, dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH for-5.0 v11 18/20] virtio-iommu: Support migration
Date: Fri, 22 Nov 2019 19:29:41 +0100
Message-Id: <20191122182943.4656-19-eric.auger@redhat.com>
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: gO6uWk4uOd2yIJgV7sIkWw-1
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
Cc: kevin.tian@intel.com, peterx@redhat.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add Migration support. We rely on recently added gtree and qlist
migration. Besides, we have to fixup end point <-> domain link.

Indeed each domain has a list of endpoints attached to it. And each
endpoint has a pointer to its domain.

Raw gtree and qlist migration cannot handle this as it re-allocates
all the nodes while reconstructing the trees/lists.

So in post_load we re-construct the relationship between endpoints
and domains.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 127 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index c5b202fab7..4e92fc0c95 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -692,16 +692,6 @@ static void virtio_iommu_set_features(VirtIODevice *vd=
ev, uint64_t val)
     trace_virtio_iommu_set_features(dev->acked_features);
 }
=20
-/*
- * Migration is not yet supported: most of the state consists
- * of balanced binary trees which are not yet ready for getting
- * migrated
- */
-static const VMStateDescription vmstate_virtio_iommu_device =3D {
-    .name =3D "virtio-iommu-device",
-    .unmigratable =3D 1,
-};
-
 static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
 {
     uint ua =3D GPOINTER_TO_UINT(a);
@@ -778,6 +768,123 @@ static void virtio_iommu_instance_init(Object *obj)
 {
 }
=20
+#define VMSTATE_INTERVAL                               \
+{                                                      \
+    .name =3D "interval",                                \
+    .version_id =3D 1,                                   \
+    .minimum_version_id =3D 1,                           \
+    .fields =3D (VMStateField[]) {                       \
+        VMSTATE_UINT64(low, viommu_interval),          \
+        VMSTATE_UINT64(high, viommu_interval),         \
+        VMSTATE_END_OF_LIST()                          \
+    }                                                  \
+}
+
+#define VMSTATE_MAPPING                               \
+{                                                     \
+    .name =3D "mapping",                                \
+    .version_id =3D 1,                                  \
+    .minimum_version_id =3D 1,                          \
+    .fields =3D (VMStateField[]) {                      \
+        VMSTATE_UINT64(phys_addr, viommu_mapping),    \
+        VMSTATE_UINT32(flags, viommu_mapping),        \
+        VMSTATE_END_OF_LIST()                         \
+    },                                                \
+}
+
+static const VMStateDescription vmstate_interval_mapping[2] =3D {
+    VMSTATE_MAPPING,   /* value */
+    VMSTATE_INTERVAL   /* key   */
+};
+
+static int domain_preload(void *opaque)
+{
+    viommu_domain *domain =3D opaque;
+
+    domain->mappings =3D g_tree_new_full((GCompareDataFunc)interval_cmp,
+                                       NULL, g_free, g_free);
+    return 0;
+}
+
+static const VMStateDescription vmstate_endpoint =3D {
+    .name =3D "endpoint",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(id, viommu_endpoint),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_domain =3D {
+    .name =3D "domain",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .pre_load =3D domain_preload,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(id, viommu_domain),
+        VMSTATE_GTREE_V(mappings, viommu_domain, 1,
+                        vmstate_interval_mapping,
+                        viommu_interval, viommu_mapping),
+        VMSTATE_QLIST_V(endpoint_list, viommu_domain, 1,
+                        vmstate_endpoint, viommu_endpoint, next),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static gboolean reconstruct_ep_domain_link(gpointer key, gpointer value,
+                                           gpointer data)
+{
+    viommu_domain *d =3D (viommu_domain *)value;
+    viommu_endpoint *iter, *tmp;
+    viommu_endpoint *ep =3D (viommu_endpoint *)data;
+
+    QLIST_FOREACH_SAFE(iter, &d->endpoint_list, next, tmp) {
+        if (iter->id =3D=3D ep->id) {
+            /* remove the ep */
+            QLIST_REMOVE(iter, next);
+            g_free(iter);
+            /* replace it with the good one */
+            QLIST_INSERT_HEAD(&d->endpoint_list, ep, next);
+            /* update the domain */
+            ep->domain =3D d;
+            return true; /* stop the search */
+        }
+    }
+    return false; /* continue the traversal */
+}
+
+static gboolean fix_endpoint(gpointer key, gpointer value, gpointer data)
+{
+    VirtIOIOMMU *s =3D (VirtIOIOMMU *)data;
+
+    g_tree_foreach(s->domains, reconstruct_ep_domain_link, value);
+    return false;
+}
+
+static int iommu_post_load(void *opaque, int version_id)
+{
+    VirtIOIOMMU *s =3D opaque;
+
+    g_tree_foreach(s->endpoints, fix_endpoint, s);
+    return 0;
+}
+
+static const VMStateDescription vmstate_virtio_iommu_device =3D {
+    .name =3D "virtio-iommu-device",
+    .minimum_version_id =3D 1,
+    .version_id =3D 1,
+    .post_load =3D iommu_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 1,
+                                   &vmstate_domain, viommu_domain),
+        VMSTATE_GTREE_DIRECT_KEY_V(endpoints, VirtIOIOMMU, 1,
+                                   &vmstate_endpoint, viommu_endpoint),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+
 static const VMStateDescription vmstate_virtio_iommu =3D {
     .name =3D "virtio-iommu",
     .minimum_version_id =3D 1,
--=20
2.20.1


