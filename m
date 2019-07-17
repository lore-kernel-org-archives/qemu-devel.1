Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4DAC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CED2182B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CED2182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnhIf-0003ch-S5
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 06:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55942)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hnhI4-00022p-UD
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hnhI3-0001Zg-Lh
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:36:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hnhI3-0001Yu-FJ; Wed, 17 Jul 2019 06:36:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B479F81F2F;
 Wed, 17 Jul 2019 10:36:02 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-65.ams2.redhat.com [10.36.117.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FC6319C68;
 Wed, 17 Jul 2019 10:36:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 12:35:49 +0200
Message-Id: <20190717103550.24657-3-david@redhat.com>
In-Reply-To: <20190717103550.24657-1-david@redhat.com>
References: <20190717103550.24657-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 17 Jul 2019 10:36:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v2 2/3] virtio-balloon: fix memory leak
 on unrealize()
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

We could have tracking data for a pbp (PartiallyBalloonedPage)
allocated. Let's free it.

Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE <
                     host page size")
Cc: qemu-stable@nongnu.org #v4.0.0
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 669067d661..84d01bceb3 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -40,6 +40,12 @@ struct PartiallyBalloonedPage {
     unsigned long bitmap[];
 };
=20
+static void virtio_balloon_reset_pbp(VirtIOBalloon *balloon)
+{
+    g_free(balloon->pbp);
+    balloon->pbp =3D NULL;
+}
+
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr offset)
 {
@@ -82,8 +88,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon=
,
         /* We've partially ballooned part of a host page, but now
          * we're trying to balloon part of a different one.  Too hard,
          * give up on the old partial page */
-        g_free(balloon->pbp);
-        balloon->pbp =3D NULL;
+        virtio_balloon_reset_pbp(balloon);
     }
=20
     if (!balloon->pbp) {
@@ -106,8 +111,7 @@ static void balloon_inflate_page(VirtIOBalloon *ballo=
on,
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
=20
-        g_free(balloon->pbp);
-        balloon->pbp =3D NULL;
+        virtio_balloon_reset_pbp(balloon);
     }
 }
=20
@@ -143,8 +147,7 @@ static void balloon_deflate_page(VirtIOBalloon *ballo=
on,
                   balloon->pbp->bitmap);
=20
         if (bitmap_empty(balloon->pbp->bitmap, subpages)) {
-            g_free(balloon->pbp);
-            balloon->pbp =3D NULL;
+            virtio_balloon_reset_pbp(balloon);
         }
     }
=20
@@ -831,6 +834,7 @@ static void virtio_balloon_device_unrealize(DeviceSta=
te *dev, Error **errp)
         virtio_balloon_free_page_stop(s);
         precopy_remove_notifier(&s->free_page_report_notify);
     }
+    virtio_balloon_reset_pbp(s);
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
     virtio_cleanup(vdev);
--=20
2.21.0


