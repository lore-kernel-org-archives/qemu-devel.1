Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF42C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4ED20848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP6NrN0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4ED20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rcz-0001Ep-W3
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j9rYF-0000tZ-AT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j9rYC-0003h7-Uq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31073
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j9rYC-0003gH-Ow
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583418755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NgzR8p5sGdHITGt0eLFva8UxByAMeItf9wW8PoeeJIs=;
 b=bP6NrN0rDnlx2Y8jIu1dBWH7sTEC6VygLDfJtW8r/JIkM9rtSbml9eI9gXOX0AysxJbSRY
 65LqK3hrkylJ2+XHKCZ28TcyFXRJpG66owVMx72PSxcWsVHmnv206ojYBUoX9W9CRGZ0tG
 kWzENVn3FX4L180C6SQ4m6llyUCU9rQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-urTWfxLcMnCbhqFogWRJDA-1; Thu, 05 Mar 2020 09:32:31 -0500
X-MC-Unique: urTWfxLcMnCbhqFogWRJDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DA9F800D50;
 Thu,  5 Mar 2020 14:32:30 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-120-166.rdu2.redhat.com [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6DC390538;
 Thu,  5 Mar 2020 14:32:17 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/15] util: vfio-helpers: Implement ram_block_resized()
Date: Thu,  5 Mar 2020 15:29:42 +0100
Message-Id: <20200305142945.216465-13-david@redhat.com>
In-Reply-To: <20200305142945.216465-1-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
part. We'll need e.g., new ioctl to do this atomically (e.g., to resize
while the guest is running).

Right now, we only resize RAM blocks during incoming migration (when
syncing RAM block sizes during the precopy phase) or after guest
resets when building acpi tables. Any future user of resizeable RAM has to
be aware that vfio has to be treated with care.

Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 util/trace-events   |  7 ++--
 util/vfio-helpers.c | 95 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/util/trace-events b/util/trace-events
index 83b6639018..a4d39eca5e 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -74,10 +74,11 @@ qemu_mutex_unlock(void *mutex, const char *file, const =
int line) "released mutex
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
-qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_=
t iova) "s %p host %p size %zu index %d iova 0x%"PRIx64
+qemu_vfio_new_mapping(void *s, void *host, size_t size, size_t max_size, i=
nt index, uint64_t iova) "s %p host %p size %zu max_size %zu index %d iova =
0x%"PRIx64
 qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %=
p host %p size %zu iova 0x%"PRIx64
 qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64=
_t *iova) "s %p host %p size %zu temporary %d iova %p"
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index f0c77f0d69..789faf38bd 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -36,6 +36,7 @@ typedef struct {
     /* Page aligned addr. */
     void *host;
     size_t size;
+    size_t max_size;
     uint64_t iova;
 } IOVAMapping;
=20
@@ -372,14 +373,20 @@ fail_container:
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
@@ -391,16 +398,28 @@ static void qemu_vfio_ram_block_removed(RAMBlockNotif=
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
@@ -495,16 +514,23 @@ static IOVAMapping *qemu_vfio_find_mapping(QEMUVFIOSt=
ate *s, void *host,
  */
 static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState *s,
                                           void *host, size_t size,
-                                          int index, uint64_t iova)
+                                          size_t max_size, int index,
+                                          uint64_t iova)
 {
+    const IOVAMapping m =3D {
+        .host =3D host,
+        .size =3D size,
+        .max_size =3D max_size,
+        .iova =3D iova,
+    };
     int shift;
-    IOVAMapping m =3D {.host =3D host, .size =3D size, .iova =3D iova};
     IOVAMapping *insert;
=20
     assert(QEMU_IS_ALIGNED(size, qemu_real_host_page_size));
+    assert(size <=3D max_size);
     assert(QEMU_IS_ALIGNED(s->low_water_mark, qemu_real_host_page_size));
     assert(QEMU_IS_ALIGNED(s->high_water_mark, qemu_real_host_page_size));
-    trace_qemu_vfio_new_mapping(s, host, size, index, iova);
+    trace_qemu_vfio_new_mapping(s, host, size, max_size, index, iova);
=20
     assert(index >=3D 0);
     s->nr_mappings++;
@@ -597,9 +623,14 @@ static bool qemu_vfio_verify_mappings(QEMUVFIOState *s=
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
@@ -608,19 +639,24 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, s=
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
         if (!temporary) {
             iova0 =3D s->low_water_mark;
-            mapping =3D qemu_vfio_add_mapping(s, host, size, index + 1, io=
va0);
+            mapping =3D qemu_vfio_add_mapping(s, host, size, max_size, ind=
ex + 1,
+                                            iova0);
             if (!mapping) {
                 ret =3D -ENOMEM;
                 goto out;
@@ -631,7 +667,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, siz=
e_t size,
                 qemu_vfio_remove_mapping(s, mapping);
                 goto out;
             }
-            s->low_water_mark +=3D size;
+            s->low_water_mark +=3D max_size;
             qemu_vfio_dump_mappings(s);
         } else {
             iova0 =3D s->high_water_mark - size;
@@ -650,6 +686,12 @@ out:
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
@@ -694,6 +736,37 @@ out:
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
+    assert(new_size <=3D m->max_size);
+
+    /*
+     * For now, we must unmap the whole mapped range first and remap with
+     * the new size. The reason is that VFIO_IOMMU_UNMAP_DMA might fail
+     * when partially unmapping previous mappings. Although we could add
+     * new mappings to extend the old range, we won't able to always
+     * shrink. The side effect is that it's never safe to resize during VM
+     * execution and we'll e.g., need a new IOCTL to make this work.
+     */
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


