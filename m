Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058B9C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C445F206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8PGEkN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C445F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sNh-00062u-W5
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sIe-0006o6-If
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sId-0003xL-FI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:43:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23538
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sId-0003x3-BA
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581515011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/W0Rnt5R1bACGOIM7oXhJcO9iZmEXLI8cWkfuHUQwA=;
 b=U8PGEkN8XX/ti8SN1jK9uvVmehtDuC2hOgrfXqf255ZdErOpSelHh7TyvrzRyYI7zKi9ov
 gIkv2zxpSokb3SoMkvvj556qqs6kOjcA8ivLcGRtKH29+64ckbZyvQvdLscpTyyd5fLMWH
 Wcc62YLEw9Y1TI/br6OWBSnHYl0w5EU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-bxJFlNPqM5K9syowjz41hQ-1; Wed, 12 Feb 2020 08:43:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 443CC10054E3;
 Wed, 12 Feb 2020 13:43:28 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DE451001281;
 Wed, 12 Feb 2020 13:43:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 fixed 03/16] util: vfio-helpers: Remove Error parameter
 from qemu_vfio_undo_mapping()
Date: Wed, 12 Feb 2020 14:42:41 +0100
Message-Id: <20200212134254.11073-4-david@redhat.com>
In-Reply-To: <20200212134254.11073-1-david@redhat.com>
References: <20200212134254.11073-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: bxJFlNPqM5K9syowjz41hQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Everybody discards the error. Let's error_report() instead so this error
doesn't get lost.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/vfio-helpers.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index d6332522c1..13dd962d95 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -540,8 +540,7 @@ static int qemu_vfio_do_mapping(QEMUVFIOState *s, void =
*host, size_t size,
 /**
  * Undo the DMA mapping from @s with VFIO, and remove from mapping list.
  */
-static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping,
-                                   Error **errp)
+static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping)
 {
     int index;
     struct vfio_iommu_type1_dma_unmap unmap =3D {
@@ -556,7 +555,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IO=
VAMapping *mapping,
     assert(QEMU_IS_ALIGNED(mapping->size, qemu_real_host_page_size));
     assert(index >=3D 0 && index < s->nr_mappings);
     if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
-        error_setg(errp, "VFIO_UNMAP_DMA failed: %d", -errno);
+        error_report("VFIO_UNMAP_DMA failed: %d", -errno);
     }
     memmove(mapping, &s->mappings[index + 1],
             sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
@@ -621,7 +620,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, siz=
e_t size,
             assert(qemu_vfio_verify_mappings(s));
             ret =3D qemu_vfio_do_mapping(s, host, size, iova0);
             if (ret) {
-                qemu_vfio_undo_mapping(s, mapping, NULL);
+                qemu_vfio_undo_mapping(s, mapping);
                 goto out;
             }
             s->low_water_mark +=3D size;
@@ -681,7 +680,7 @@ void qemu_vfio_dma_unmap(QEMUVFIOState *s, void *host)
     if (!m) {
         goto out;
     }
-    qemu_vfio_undo_mapping(s, m, NULL);
+    qemu_vfio_undo_mapping(s, m);
 out:
     qemu_mutex_unlock(&s->lock);
 }
@@ -698,7 +697,7 @@ void qemu_vfio_close(QEMUVFIOState *s)
         return;
     }
     while (s->nr_mappings) {
-        qemu_vfio_undo_mapping(s, &s->mappings[s->nr_mappings - 1], NULL);
+        qemu_vfio_undo_mapping(s, &s->mappings[s->nr_mappings - 1]);
     }
     ram_block_notifier_remove(&s->ram_notifier);
     qemu_vfio_reset(s);
--=20
2.24.1


