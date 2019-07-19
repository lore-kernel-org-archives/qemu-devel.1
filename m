Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70550C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457E62186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457E62186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoVNF-0003ti-HS
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 12:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hoVN3-0003Q0-3G
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hoVMr-0005PM-O1
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:04:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1hoVMn-0003bw-FT
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:04:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC2D43093385;
 Fri, 19 Jul 2019 16:01:34 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90BF01001B02;
 Fri, 19 Jul 2019 16:01:33 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 18:01:20 +0200
Message-Id: <20190719160120.26581-4-david@redhat.com>
In-Reply-To: <20190719160120.26581-1-david@redhat.com>
References: <20190719160120.26581-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 19 Jul 2019 16:01:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 3/3] virtio-balloon: Rework pbp tracking data
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using the address of a RAMBlock to test for a matching pbp is not really
safe. Instead, let's use the guest physical address of the base page
along with the page size (via the number of subpages).

While at it, move "struct PartiallyBalloonedPage" to virtio-balloon.h
now (previously most probably avoided to te the ramblock), renaming it.

Also, let's only dynamically allocating the bitmap. This makes the code
easier to read and maintain - we can reuse bitmap_new().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c         | 52 +++++++++++++++++-------------
 include/hw/virtio/virtio-balloon.h | 15 +++++++--
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 29cee344b2..8e5f9459c2 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -34,23 +34,31 @@
=20
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
=20
-struct PartiallyBalloonedPage {
-    RAMBlock *rb;
-    ram_addr_t base;
-    unsigned long bitmap[];
-};
-
 static void virtio_balloon_reset_pbp(VirtIOBalloon *balloon)
 {
-    g_free(balloon->pbp);
-    balloon->pbp =3D NULL;
+    balloon->pbp.base_gpa =3D 0;
+    balloon->pbp.subpages =3D 0;
+    g_free(balloon->pbp.bitmap);
+    balloon->pbp.bitmap =3D NULL;
+}
+
+static bool virtio_balloon_pbp_valid(VirtIOBalloon *balloon)
+{
+    return balloon->pbp.bitmap;
+}
+
+static bool virtio_balloon_pbp_matches(VirtIOBalloon *balloon,
+                                       ram_addr_t base_gpa, long subpage=
s)
+{
+    return balloon->pbp.subpages =3D=3D subpages &&
+           balloon->pbp.base_gpa =3D=3D base_gpa;
 }
=20
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr mr_offset)
 {
     void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
-    ram_addr_t rb_offset, rb_aligned_offset;
+    ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
     RAMBlock *rb;
     size_t rb_page_size;
     int subpages;
@@ -81,32 +89,32 @@ static void balloon_inflate_page(VirtIOBalloon *ballo=
on,
=20
     rb_aligned_offset =3D QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
     subpages =3D rb_page_size / BALLOON_PAGE_SIZE;
+    base_gpa =3D memory_region_get_ram_addr(mr) + mr_offset -
+               (rb_offset - rb_aligned_offset);
=20
-    if (balloon->pbp
-        && (rb !=3D balloon->pbp->rb
-            || rb_aligned_offset !=3D balloon->pbp->base)) {
+    if (virtio_balloon_pbp_valid(balloon) &&
+        !virtio_balloon_pbp_matches(balloon, base_gpa, subpages)) {
         /* We've partially ballooned part of a host page, but now
          * we're trying to balloon part of a different one.  Too hard,
          * give up on the old partial page */
         virtio_balloon_reset_pbp(balloon);
     }
=20
-    if (!balloon->pbp) {
+    if (!virtio_balloon_pbp_valid(balloon)) {
         /* Starting on a new host page */
-        size_t bitlen =3D BITS_TO_LONGS(subpages) * sizeof(unsigned long=
);
-        balloon->pbp =3D g_malloc0(sizeof(PartiallyBalloonedPage) + bitl=
en);
-        balloon->pbp->rb =3D rb;
-        balloon->pbp->base =3D rb_aligned_offset;
+        balloon->pbp.base_gpa =3D base_gpa;
+        balloon->pbp.subpages =3D subpages;
+        balloon->pbp.bitmap =3D bitmap_new(subpages);
     }
=20
-    set_bit((rb_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
-            balloon->pbp->bitmap);
+    set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
+            balloon->pbp.bitmap);
=20
-    if (bitmap_full(balloon->pbp->bitmap, subpages)) {
+    if (bitmap_full(balloon->pbp.bitmap, subpages)) {
         /* We've accumulated a full host page, we can actually discard
          * it now */
=20
-        ram_block_discard_range(rb, balloon->pbp->base, rb_page_size);
+        ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
@@ -130,7 +138,7 @@ static void balloon_deflate_page(VirtIOBalloon *ballo=
on,
     rb =3D qemu_ram_block_from_host(addr, false, &rb_offset);
     rb_page_size =3D qemu_ram_pagesize(rb);
=20
-    if (balloon->pbp) {
+    if (virtio_balloon_pbp_valid(balloon)) {
         /* Let's play safe and always reset the pbp on deflation request=
s. */
         virtio_balloon_reset_pbp(balloon);
     }
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virti=
o-balloon.h
index 5a99293a45..0190d78d71 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -33,8 +33,6 @@ typedef struct virtio_balloon_stat_modern {
        uint64_t val;
 } VirtIOBalloonStatModern;
=20
-typedef struct PartiallyBalloonedPage PartiallyBalloonedPage;
-
 enum virtio_balloon_free_page_report_status {
     FREE_PAGE_REPORT_S_STOP =3D 0,
     FREE_PAGE_REPORT_S_REQUESTED =3D 1,
@@ -42,6 +40,12 @@ enum virtio_balloon_free_page_report_status {
     FREE_PAGE_REPORT_S_DONE =3D 3,
 };
=20
+typedef struct VirtIOPartiallyBalloonedPage {
+    ram_addr_t base_gpa;
+    long subpages;
+    unsigned long *bitmap;
+} VirtIOPartiallyBalloonedPage;
+
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
     VirtQueue *ivq, *dvq, *svq, *free_page_vq;
@@ -70,7 +74,12 @@ typedef struct VirtIOBalloon {
     int64_t stats_last_update;
     int64_t stats_poll_interval;
     uint32_t host_features;
-    PartiallyBalloonedPage *pbp;
+
+    /*
+     * Information about a partially ballooned page - does not have to b=
e
+     * migrated and has to be reset on every device reset.
+     */
+    VirtIOPartiallyBalloonedPage pbp;
=20
     bool qemu_4_0_config_size;
 } VirtIOBalloon;
--=20
2.21.0


