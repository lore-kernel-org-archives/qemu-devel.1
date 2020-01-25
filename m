Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA0DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 17:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA792070A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 17:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZ6DyQV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA792070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivPDs-0000RH-OP
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 12:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ivP7w-0000LE-GT
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 12:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ivP7v-0006qQ-AU
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 12:21:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ivP7v-0006oq-6P
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 12:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579972902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSGNxYFqQiUMxXpBMll+KUH7vlXCIEz4YZEkAy+zE/Q=;
 b=aZ6DyQV1Jf9ez5CwhnfZbrnh7GPzz1AjzocCESqsrF13wjAC/wA9kaDFN7QDuFBiIzpt5F
 L+v3kLYWT6ztR2CPUSqxT4l5qJnW48CejY9i4H64N2nJPn8EraGE3vnl1Yev39zl5TegQR
 d7mguH5Lmnjn05jB0+beEf53smTDpME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-SyHz6aTcM02IimmmP9FWSg-1; Sat, 25 Jan 2020 12:21:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB3F518543A4;
 Sat, 25 Jan 2020 17:21:39 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E88186E19;
 Sat, 25 Jan 2020 17:21:34 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, jean-philippe@linaro.org,
 dgilbert@redhat.com, quintela@redhat.com, mst@redhat.com, peterx@redhat.com
Subject: [PATCH v13 09/10] virtio-iommu: Support migration
Date: Sat, 25 Jan 2020 18:19:54 +0100
Message-Id: <20200125171955.12825-10-eric.auger@redhat.com>
In-Reply-To: <20200125171955.12825-1-eric.auger@redhat.com>
References: <20200125171955.12825-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: SyHz6aTcM02IimmmP9FWSg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kevin.tian@intel.com, bharatb.linux@gmail.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add Migration support. We rely on recently added gtree and qlist
migration. We only migrate the domain gtree. The endpoint gtree
is re-constructed in a post-load operation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>

---

v11 -> v12:
- do not migrate the endpoint gtree but reconstruct it from the
  domain gtree (Peter's suggestion)
- add MIG_PRI_IOMMU
---
 hw/virtio/virtio-iommu.c | 109 +++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index ec8f42e167..8f5c6f17df 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -650,16 +650,6 @@ static uint64_t virtio_iommu_get_features(VirtIODevice=
 *vdev, uint64_t f,
     return f;
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
     guint ua =3D GPOINTER_TO_UINT(a);
@@ -743,9 +733,108 @@ static void virtio_iommu_instance_init(Object *obj)
 {
 }
=20
+#define VMSTATE_INTERVAL                               \
+{                                                      \
+    .name =3D "interval",                                \
+    .version_id =3D 1,                                   \
+    .minimum_version_id =3D 1,                           \
+    .fields =3D (VMStateField[]) {                       \
+        VMSTATE_UINT64(low, VirtIOIOMMUInterval),      \
+        VMSTATE_UINT64(high, VirtIOIOMMUInterval),     \
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
+        VMSTATE_UINT64(phys_addr, VirtIOIOMMUMapping),\
+        VMSTATE_UINT32(flags, VirtIOIOMMUMapping),    \
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
+    VirtIOIOMMUDomain *domain =3D opaque;
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
+        VMSTATE_UINT32(id, VirtIOIOMMUEndpoint),
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
+        VMSTATE_UINT32(id, VirtIOIOMMUDomain),
+        VMSTATE_GTREE_V(mappings, VirtIOIOMMUDomain, 1,
+                        vmstate_interval_mapping,
+                        VirtIOIOMMUInterval, VirtIOIOMMUMapping),
+        VMSTATE_QLIST_V(endpoint_list, VirtIOIOMMUDomain, 1,
+                        vmstate_endpoint, VirtIOIOMMUEndpoint, next),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static gboolean reconstruct_endpoints(gpointer key, gpointer value,
+                                      gpointer data)
+{
+    VirtIOIOMMU *s =3D (VirtIOIOMMU *)data;
+    VirtIOIOMMUDomain *d =3D (VirtIOIOMMUDomain *)value;
+    VirtIOIOMMUEndpoint *iter;
+
+    QLIST_FOREACH(iter, &d->endpoint_list, next) {
+        iter->domain =3D d;
+        g_tree_insert(s->endpoints, GUINT_TO_POINTER(iter->id), iter);
+    }
+    return false; /* continue the domain traversal */
+}
+
+static int iommu_post_load(void *opaque, int version_id)
+{
+    VirtIOIOMMU *s =3D opaque;
+
+    g_tree_foreach(s->domains, reconstruct_endpoints, s);
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
+                                   &vmstate_domain, VirtIOIOMMUDomain),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_virtio_iommu =3D {
     .name =3D "virtio-iommu",
     .minimum_version_id =3D 1,
+    .priority =3D MIG_PRI_IOMMU,
     .version_id =3D 1,
     .fields =3D (VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
--=20
2.20.1


