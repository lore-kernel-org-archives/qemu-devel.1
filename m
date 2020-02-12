Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A90C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF70206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiD1rfHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF70206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sPs-0002IW-Ev
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sIh-0006vd-Kl
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sIg-00040Y-AC
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:43:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49261
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sIg-000408-5y
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581515013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qepC1WP47Sat3hY176Yi0qhBDAWOu4/qmPiAqR1VGoI=;
 b=OiD1rfHCqmrbWUFBgXqN1iANkXv1+AZmiJG7MT146fAs5CX89B7JOnPSsP7lCELsyhfu3j
 qhRJ7lI012GukJ0+DvmVPudbzo59vuhXL5MaoejHWx4tlTJh9oDzwWPxuYKmarzhVVPzbg
 B9p9uLbU/u2n2otxh89g08BfG+eXX5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-9MvaIf2aOqmiAlzZkmZ4HQ-1; Wed, 12 Feb 2020 08:43:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3AB9107ACC9;
 Wed, 12 Feb 2020 13:43:30 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9096E1001DDE;
 Wed, 12 Feb 2020 13:43:28 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 fixed 04/16] util: vfio-helpers: Factor out removal from
 qemu_vfio_undo_mapping()
Date: Wed, 12 Feb 2020 14:42:42 +0100
Message-Id: <20200212134254.11073-5-david@redhat.com>
In-Reply-To: <20200212134254.11073-1-david@redhat.com>
References: <20200212134254.11073-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 9MvaIf2aOqmiAlzZkmZ4HQ-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor it out and properly use it where applicable. Make
qemu_vfio_undo_mapping() look like qemu_vfio_do_mapping(), passing the
size and iova, not the mapping.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/vfio-helpers.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 13dd962d95..b3adc328db 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -517,6 +517,20 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOStat=
e *s,
     return insert;
 }
=20
+/**
+ * Remove the mapping from @s and free it.
+ */
+static void qemu_vfio_remove_mapping(QEMUVFIOState *s, IOVAMapping *mappin=
g)
+{
+    const int index =3D mapping - s->mappings;
+
+    assert(index >=3D 0 && index < s->nr_mappings);
+    memmove(mapping, &s->mappings[index + 1],
+            sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
+    s->nr_mappings--;
+    s->mappings =3D g_renew(IOVAMapping, s->mappings, s->nr_mappings);
+}
+
 /* Do the DMA mapping with VFIO. */
 static int qemu_vfio_do_mapping(QEMUVFIOState *s, void *host, size_t size,
                                 uint64_t iova)
@@ -538,29 +552,22 @@ static int qemu_vfio_do_mapping(QEMUVFIOState *s, voi=
d *host, size_t size,
 }
=20
 /**
- * Undo the DMA mapping from @s with VFIO, and remove from mapping list.
+ * Undo the DMA mapping from @s with VFIO.
  */
-static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping)
+static void qemu_vfio_undo_mapping(QEMUVFIOState *s, size_t size, uint64_t=
 iova)
 {
-    int index;
     struct vfio_iommu_type1_dma_unmap unmap =3D {
         .argsz =3D sizeof(unmap),
         .flags =3D 0,
-        .iova =3D mapping->iova,
-        .size =3D mapping->size,
+        .iova =3D iova,
+        .size =3D size,
     };
=20
-    index =3D mapping - s->mappings;
-    assert(mapping->size > 0);
-    assert(QEMU_IS_ALIGNED(mapping->size, qemu_real_host_page_size));
-    assert(index >=3D 0 && index < s->nr_mappings);
+    assert(size > 0);
+    assert(QEMU_IS_ALIGNED(size, qemu_real_host_page_size));
     if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
         error_report("VFIO_UNMAP_DMA failed: %d", -errno);
     }
-    memmove(mapping, &s->mappings[index + 1],
-            sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
-    s->nr_mappings--;
-    s->mappings =3D g_renew(IOVAMapping, s->mappings, s->nr_mappings);
 }
=20
 /* Check if the mapping list is (ascending) ordered. */
@@ -620,7 +627,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, siz=
e_t size,
             assert(qemu_vfio_verify_mappings(s));
             ret =3D qemu_vfio_do_mapping(s, host, size, iova0);
             if (ret) {
-                qemu_vfio_undo_mapping(s, mapping);
+                qemu_vfio_remove_mapping(s, mapping);
                 goto out;
             }
             s->low_water_mark +=3D size;
@@ -680,7 +687,8 @@ void qemu_vfio_dma_unmap(QEMUVFIOState *s, void *host)
     if (!m) {
         goto out;
     }
-    qemu_vfio_undo_mapping(s, m);
+    qemu_vfio_undo_mapping(s, m->size, m->iova);
+    qemu_vfio_remove_mapping(s, m);
 out:
     qemu_mutex_unlock(&s->lock);
 }
@@ -697,7 +705,10 @@ void qemu_vfio_close(QEMUVFIOState *s)
         return;
     }
     while (s->nr_mappings) {
-        qemu_vfio_undo_mapping(s, &s->mappings[s->nr_mappings - 1]);
+        IOVAMapping *m =3D &s->mappings[s->nr_mappings - 1];
+
+        qemu_vfio_undo_mapping(s, m->size, m->iova);
+        qemu_vfio_remove_mapping(s, m);
     }
     ram_block_notifier_remove(&s->ram_notifier);
     qemu_vfio_reset(s);
--=20
2.24.1


