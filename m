Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B50C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FF92073D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbdLKDsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FF92073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GMa-0007ka-7m
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j7GBi-00041X-IE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j7GBh-000103-20
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j7GBg-0000z7-Tj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582798476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KMDvJ5mlpWKgYA3FKjQpwt+bcTDd3WLHazG7j+Anq/4=;
 b=ZbdLKDsgYoH+PVAA77/TGkGaolCIRCZGn44eJKrNyLs3/VTLHPDrkRcMD7LoSLh2Zk6rnq
 2bKgBVIA4f8hR1/jpxlF6Ib83KbOhKfVMNoYjmOI1P2f12vmkIjWEucyqEQ/nIJoXDBrIA
 U+X4Q6SIrO4xT2fycfJMGRd4ieHTbkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-pSBdSpkOMNKmI22A55bnZw-1; Thu, 27 Feb 2020 05:14:35 -0500
X-MC-Unique: pSBdSpkOMNKmI22A55bnZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AAC7DBA3;
 Thu, 27 Feb 2020 10:14:33 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC8D987B08;
 Thu, 27 Feb 2020 10:14:24 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/15] util: vfio-helpers: Implement ram_block_resized()
Date: Thu, 27 Feb 2020 11:12:02 +0100
Message-Id: <20200227101205.5616-13-david@redhat.com>
In-Reply-To: <20200227101205.5616-1-david@redhat.com>
References: <20200227101205.5616-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's implement ram_block_resized(), allowing resizeable mappings.

For resizeable mappings, we reserve $max_size IOVA address space, but only
map $size of it. When resizing, unmap the old part and remap the new
part. We'll need a new ioctl to do this atomically (e.g., to resize
while the guest is running - not allowed for now).

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/trace-events   |  5 ++--
 util/vfio-helpers.c | 70 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/util/trace-events b/util/trace-events
index 83b6639018..88b7dbf4a5 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -74,8 +74,9 @@ qemu_mutex_unlock(void *mutex, const char *file, const in=
t line) "released mutex
=20
 # vfio-helpers.c
 qemu_vfio_dma_reset_temporary(void *s) "s %p"
-qemu_vfio_ram_block_added(void *s, void *p, size_t size) "s %p host %p siz=
e 0x%zx"
-qemu_vfio_ram_block_removed(void *s, void *p, size_t size) "s %p host %p s=
ize 0x%zx"
+qemu_vfio_ram_block_added(void *s, void *p, size_t size, size_t max_size) =
"s %p host %p size 0x%zx max_size 0x%zx"
+qemu_vfio_ram_block_removed(void *s, void *p, size_t size, size_t max_size=
) "s %p host %p size 0x%zx max_size 0x%zx"
+qemu_vfio_ram_block_resized(void *s, void *p, size_t old_size, size_t new_=
sizze) "s %p host %p old_size 0x%zx new_size 0x%zx"
 qemu_vfio_find_mapping(void *s, void *p) "s %p host %p"
 qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_=
t iova) "s %p host %p size %zu index %d iova 0x%"PRIx64
 qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %=
p host %p size %zu iova 0x%"PRIx64
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index f0c77f0d69..566eb4e1eb 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -372,14 +372,20 @@ fail_container:
     return ret;
 }
=20
+static int qemu_vfio_dma_map_resizeable(QEMUVFIOState *s, void *host,
+                                        size_t size, size_t max_size,
+                                        bool temporary, uint64_t *iova);
+static void qemu_vfio_dma_map_resize(QEMUVFIOState *s, void *host,
+                                     size_t old_size, size_t new_size);
+
 static void qemu_vfio_ram_block_added(RAMBlockNotifier *n, void *host,
                                       size_t size, size_t max_size)
 {
     QEMUVFIOState *s =3D container_of(n, QEMUVFIOState, ram_notifier);
     int ret;
=20
-    trace_qemu_vfio_ram_block_added(s, host, max_size);
-    ret =3D qemu_vfio_dma_map(s, host, max_size, false, NULL);
+    trace_qemu_vfio_ram_block_added(s, host, size, max_size);
+    ret =3D qemu_vfio_dma_map_resizeable(s, host, size, max_size, false, N=
ULL);
     if (ret) {
         error_report("qemu_vfio_dma_map(%p, %zu) failed: %s", host, max_si=
ze,
                      strerror(-ret));
@@ -391,16 +397,28 @@ static void qemu_vfio_ram_block_removed(RAMBlockNotif=
ier *n, void *host,
 {
     QEMUVFIOState *s =3D container_of(n, QEMUVFIOState, ram_notifier);
     if (host) {
-        trace_qemu_vfio_ram_block_removed(s, host, max_size);
+        trace_qemu_vfio_ram_block_removed(s, host, size, max_size);
         qemu_vfio_dma_unmap(s, host);
     }
 }
=20
+static void qemu_vfio_ram_block_resized(RAMBlockNotifier *n, void *host,
+                                        size_t old_size, size_t new_size)
+{
+    QEMUVFIOState *s =3D container_of(n, QEMUVFIOState, ram_notifier);
+
+    if (host) {
+        trace_qemu_vfio_ram_block_resized(s, host, old_size, new_size);
+        qemu_vfio_dma_map_resize(s, host, old_size, new_size);
+    }
+}
+
 static void qemu_vfio_open_common(QEMUVFIOState *s)
 {
     qemu_mutex_init(&s->lock);
     s->ram_notifier.ram_block_added =3D qemu_vfio_ram_block_added;
     s->ram_notifier.ram_block_removed =3D qemu_vfio_ram_block_removed;
+    s->ram_notifier.ram_block_resized =3D qemu_vfio_ram_block_resized;
     s->low_water_mark =3D QEMU_VFIO_IOVA_MIN;
     s->high_water_mark =3D QEMU_VFIO_IOVA_MAX;
     ram_block_notifier_add(&s->ram_notifier);
@@ -597,9 +615,14 @@ static bool qemu_vfio_verify_mappings(QEMUVFIOState *s=
)
  * the result in @iova if not NULL. The caller need to make sure the area =
is
  * aligned to page size, and mustn't overlap with existing mapping areas (=
split
  * mapping status within this area is not allowed).
+ *
+ * If size < max_size, a region of max_size in IOVA address is reserved, s=
uch
+ * that the mapping can later be resized. Resizeable mappings are only all=
owed
+ * for !temporary mappings.
  */
-int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
-                      bool temporary, uint64_t *iova)
+static int qemu_vfio_dma_map_resizeable(QEMUVFIOState *s, void *host,
+                                        size_t size, size_t max_size,
+                                        bool temporary, uint64_t *iova)
 {
     int ret =3D 0;
     int index;
@@ -608,13 +631,17 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, s=
ize_t size,
=20
     assert(QEMU_PTR_IS_ALIGNED(host, qemu_real_host_page_size));
     assert(QEMU_IS_ALIGNED(size, qemu_real_host_page_size));
+    assert(QEMU_IS_ALIGNED(max_size, qemu_real_host_page_size));
+    assert(size =3D=3D max_size || !temporary);
+    assert(size <=3D max_size);
+
     trace_qemu_vfio_dma_map(s, host, size, temporary, iova);
     qemu_mutex_lock(&s->lock);
     mapping =3D qemu_vfio_find_mapping(s, host, &index);
     if (mapping) {
         iova0 =3D mapping->iova + ((uint8_t *)host - (uint8_t *)mapping->h=
ost);
     } else {
-        if (s->high_water_mark - s->low_water_mark + 1 < size) {
+        if (s->high_water_mark - s->low_water_mark + 1 < max_size) {
             ret =3D -ENOMEM;
             goto out;
         }
@@ -631,7 +658,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, siz=
e_t size,
                 qemu_vfio_remove_mapping(s, mapping);
                 goto out;
             }
-            s->low_water_mark +=3D size;
+            s->low_water_mark +=3D max_size;
             qemu_vfio_dump_mappings(s);
         } else {
             iova0 =3D s->high_water_mark - size;
@@ -650,6 +677,12 @@ out:
     return ret;
 }
=20
+int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
+                      bool temporary, uint64_t *iova)
+{
+    return qemu_vfio_dma_map_resizeable(s, host, size, size, temporary, io=
va);
+}
+
 /* Reset the high watermark and free all "temporary" mappings. */
 int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s)
 {
@@ -694,6 +727,29 @@ out:
     qemu_mutex_unlock(&s->lock);
 }
=20
+static void qemu_vfio_dma_map_resize(QEMUVFIOState *s, void *host,
+                                     size_t old_size, size_t new_size)
+{
+    IOVAMapping *m;
+    int index =3D 0;
+
+    qemu_mutex_lock(&s->lock);
+    m =3D qemu_vfio_find_mapping(s, host, &index);
+    if (!m) {
+        return;
+    }
+    assert(m->size =3D=3D old_size);
+
+    /* Note: Not atomic - we need a new ioctl for that. */
+    qemu_vfio_undo_mapping(s, m->iova, m->size);
+    qemu_vfio_do_mapping(s, host, m->iova, new_size);
+
+    m->size =3D new_size;
+    assert(qemu_vfio_verify_mappings(s));
+
+    qemu_mutex_unlock(&s->lock);
+}
+
 static void qemu_vfio_reset(QEMUVFIOState *s)
 {
     ioctl(s->device, VFIO_DEVICE_RESET);
--=20
2.24.1


