Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26247C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D2F229F9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D2F229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqc4E-00051H-MM
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51380)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hqc3b-0002Sl-Cv
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hqc3a-0003F1-3F
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hqc3Z-0003CW-QQ; Thu, 25 Jul 2019 07:37:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C2BD3092647;
 Thu, 25 Jul 2019 11:37:05 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-70.ams2.redhat.com [10.36.117.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06E2A546E0;
 Thu, 25 Jul 2019 11:36:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 13:36:37 +0200
Message-Id: <20190725113638.4702-7-david@redhat.com>
In-Reply-To: <20190725113638.4702-1-david@redhat.com>
References: <20190725113638.4702-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 25 Jul 2019 11:37:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v4 6/7] virtio-balloon: Use temporary
 PBP only
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We still have multiple issues in the current code
- The PBP is not freed during unrealize()
- The PBP is not reset on device resets: After a reset, the PBP is stale.
- We are not indicating VIRTIO_BALLOON_F_MUST_TELL_HOST, therefore
  guests (esp. legacy guests) will reuse pages without deflating,
  turning the PBP stale. Adding that would require compat handling.

Instead, let's use the PBP only temporarily, when processing one bulk of
inflation requests. This will keep guest_page_size > 4k working (with
Linux guests). There is nothing to do for deflation requests anymore.
The pbp is only used for a limited amount of time.

Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE <
                     host page size")
Cc: qemu-stable@nongnu.org #v4.0.0
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c         | 21 +++++++++------------
 include/hw/virtio/virtio-balloon.h |  3 ---
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 40d493a31a..a6282d58d4 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -34,11 +34,11 @@
=20
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
=20
-struct PartiallyBalloonedPage {
+typedef struct PartiallyBalloonedPage {
     ram_addr_t base_gpa;
     long subpages;
     unsigned long *bitmap;
-};
+} PartiallyBalloonedPage;
=20
 static void virtio_balloon_pbp_free(PartiallyBalloonedPage *pbp)
 {
@@ -68,11 +68,11 @@ static bool virtio_balloon_pbp_matches(PartiallyBallo=
onedPage *pbp,
 }
=20
 static void balloon_inflate_page(VirtIOBalloon *balloon,
-                                 MemoryRegion *mr, hwaddr mr_offset)
+                                 MemoryRegion *mr, hwaddr mr_offset,
+                                 PartiallyBalloonedPage **pbp)
 {
     void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
     ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
-    PartiallyBalloonedPage **pbp =3D &balloon->pbp;
     RAMBlock *rb;
     size_t rb_page_size;
     int subpages;
@@ -149,12 +149,6 @@ static void balloon_deflate_page(VirtIOBalloon *ball=
oon,
     rb =3D qemu_ram_block_from_host(addr, false, &rb_offset);
     rb_page_size =3D qemu_ram_pagesize(rb);
=20
-    if (balloon->pbp) {
-        /* Let's play safe and always reset the pbp on deflation request=
s. */
-        virtio_balloon_pbp_free(balloon->pbp);
-        balloon->pbp =3D NULL;
-    }
-
     host_addr =3D (void *)((uintptr_t)addr & ~(rb_page_size - 1));
=20
     /* When a page is deflated, we hint the whole host page it lives
@@ -336,6 +330,7 @@ static void balloon_stats_set_poll_interval(Object *o=
bj, Visitor *v,
 static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *=
vq)
 {
     VirtIOBalloon *s =3D VIRTIO_BALLOON(vdev);
+    PartiallyBalloonedPage *pbp =3D NULL;
     VirtQueueElement *elem;
     MemoryRegionSection section;
=20
@@ -344,7 +339,7 @@ static void virtio_balloon_handle_output(VirtIODevice=
 *vdev, VirtQueue *vq)
         uint32_t pfn;
         elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
-            return;
+            break;
         }
=20
         while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) =
=3D=3D 4) {
@@ -373,7 +368,7 @@ static void virtio_balloon_handle_output(VirtIODevice=
 *vdev, VirtQueue *vq)
             if (!qemu_balloon_is_inhibited()) {
                 if (vq =3D=3D s->ivq) {
                     balloon_inflate_page(s, section.mr,
-                                         section.offset_within_region);
+                                         section.offset_within_region, &=
pbp);
                 } else if (vq =3D=3D s->dvq) {
                     balloon_deflate_page(s, section.mr, section.offset_w=
ithin_region);
                 } else {
@@ -387,6 +382,8 @@ static void virtio_balloon_handle_output(VirtIODevice=
 *vdev, VirtQueue *vq)
         virtio_notify(vdev, vq);
         g_free(elem);
     }
+
+    virtio_balloon_pbp_free(pbp);
 }
=20
 static void virtio_balloon_receive_stats(VirtIODevice *vdev, VirtQueue *=
vq)
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virti=
o-balloon.h
index 5a99293a45..d1c968d237 100644
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
@@ -70,7 +68,6 @@ typedef struct VirtIOBalloon {
     int64_t stats_last_update;
     int64_t stats_poll_interval;
     uint32_t host_features;
-    PartiallyBalloonedPage *pbp;
=20
     bool qemu_4_0_config_size;
 } VirtIOBalloon;
--=20
2.21.0


