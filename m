Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E14C35E08
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66FC521744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJkuIlJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FC521744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c2w-0008Af-Jv
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6buR-0000mM-Gk
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6buQ-0001Pi-Bj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6buQ-0001PE-6E
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqQOGMqpF8zLfZoLuq6v/gKM+lP+WgY9/qrFc0P3cXk=;
 b=EJkuIlJRf9zLopsR30BK+waW9c25uPiMJ/7iWzs5ZpFb7KnCThmfTOw3/kFKzs62DjgaaJ
 yROkenaA6OB2AjvffY2dsUpCrhrR5voTjB4/WD5etVWthaxZv9uwPZQsRcuuqZzQQCKrQO
 ATlwHjBXiTPqz9YdiQF2M1GHwiNbC6g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-mJF-QnWwNpaFLo3yOum-wg-1; Tue, 25 Feb 2020 10:14:00 -0500
X-MC-Unique: mJF-QnWwNpaFLo3yOum-wg-1
Received: by mail-qv1-f72.google.com with SMTP id ce2so13168334qvb.23
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RR/ShafzTvz59NAOcgecA6nlXnHQkJaS9Z0Tyemhwi0=;
 b=NrSVW1U9sjY9C549Dr8Tw6fEZFcUCOR3K6rou4Z/92qBeHv+FYaSaesx6BacfST8ep
 ks6JztMETAtQgWQ4kPeWMI78ao1JrKOcb4ARzBUK6R9FPLZZ696jRieuYAOTbsICcYNV
 XFqYP1sClFh5nF8m9a6KbzRZG1hsLpySOvMscjcdGKtwj4pBOaUw/bbCuxW8+4SAIo3G
 dH6F7MAWmqNTsAdMSAWeU3dd6PUXATOqdGW9WCTE4Z/93h+ijnubQHyqC2OMeUnsoUS9
 rpNNm2NXTe2QmmqLuTFWprzdfrvE+gliihAAAu/IDmrOkGTnfIupEBf59/bOqXaAxgxz
 fjSQ==
X-Gm-Message-State: APjAAAW7o7u9bxNj3CwL7h0LNjyS/0WbTrSZ+szemoKtBLGHxpEimf6S
 kAmLPNu/k2Y05cb1lrwmP/MKkPPWxyXteeX4dXMqrbnvKyid1g20lq8PDPxXh9s1WtjLaABERcn
 iKkGJN2folt8pCR8=
X-Received: by 2002:ac8:7152:: with SMTP id h18mr54977072qtp.349.1582643639912; 
 Tue, 25 Feb 2020 07:13:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUICXfW1EfQhBNm85yUh2n5EDWEDM3kNdt8OlnNAcs6kwTbQ13Z14hWMC4XtF+xHrTC3T0MQ==
X-Received: by 2002:ac8:7152:: with SMTP id h18mr54977042qtp.349.1582643639646; 
 Tue, 25 Feb 2020 07:13:59 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 z21sm7540632qka.122.2020.02.25.07.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:13:58 -0800 (PST)
Date: Tue, 25 Feb 2020 10:13:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/32] virtio-iommu: Support migration
Message-ID: <20200225151210.647797-19-mst@redhat.com>
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
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Add Migration support. We rely on recently added gtree and qlist
migration. We only migrate the domain gtree. The endpoint gtree
is re-constructed in a post-load operation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Message-Id: <20200214132745.23392-8-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 109 +++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 8509f64004..4cee8083bc 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -643,16 +643,6 @@ static uint64_t virtio_iommu_get_features(VirtIODevice=
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
@@ -736,9 +726,108 @@ static void virtio_iommu_instance_init(Object *obj)
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
MST


