Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775A4C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E46520659
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E46520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnfX1-0002Rz-Bv
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 04:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49937)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hnfWp-0001wf-Ba
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hnfWn-0005e0-Gg
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:43:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hnfWn-0005ak-9T; Wed, 17 Jul 2019 04:43:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C9B0300CB03;
 Wed, 17 Jul 2019 08:43:05 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-65.ams2.redhat.com [10.36.117.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B9FC19C68;
 Wed, 17 Jul 2019 08:42:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 10:42:55 +0200
Message-Id: <20190717084255.17173-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 17 Jul 2019 08:43:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1] virtio-balloon: fix QEMU crashes on
 pagesize > BALLOON_PAGE_SIZE
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

We are using the wrong functions to set/clear bits, effectively touching
multiple bits, writing out of range of the bitmap, resulting in memory
corruptions. We have to use set_bit()/clear_bit() instead.

Can easily be reproduced by starting a qemu guest on hugetlbfs memory,
inflating the balloon. QEMU crashes. This never could have worked
properly - especially, also pages would have been discarded when the
first sub-page would be inflated (the whole bitmap would be set).

While testing I realized, that on hugetlbfs it is pretty much impossible
to discard a page - the guest just frees the 4k sub-pages in random order
most of the time. I was only able to discard a hugepage a handful of
times - so I hope that now works correctly.

Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE <
                     host page size")
Fixes: b27b32391404 ("virtio-balloon: Fix possible guest memory corruptio=
n
                     with inflates & deflates")
Cc: qemu-stable@nongnu.org #v4.0.0
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index e85d1c0d5c..669067d661 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -94,9 +94,8 @@ static void balloon_inflate_page(VirtIOBalloon *balloon=
,
         balloon->pbp->base =3D host_page_base;
     }
=20
-    bitmap_set(balloon->pbp->bitmap,
-               (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
-               subpages);
+    set_bit((ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
+            balloon->pbp->bitmap);
=20
     if (bitmap_full(balloon->pbp->bitmap, subpages)) {
         /* We've accumulated a full host page, we can actually discard
@@ -140,9 +139,8 @@ static void balloon_deflate_page(VirtIOBalloon *ballo=
on,
          * for a guest to do this in practice, but handle it anyway,
          * since getting it wrong could mean discarding memory the
          * guest is still using. */
-        bitmap_clear(balloon->pbp->bitmap,
-                     (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SI=
ZE,
-                     subpages);
+        clear_bit((ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
+                  balloon->pbp->bitmap);
=20
         if (bitmap_empty(balloon->pbp->bitmap, subpages)) {
             g_free(balloon->pbp);
--=20
2.21.0


