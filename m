Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A85C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8615229F9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8615229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqc4Z-0006gY-R0
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51375)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hqc3b-0002Rc-6J
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hqc3a-0003Eq-2b
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42054)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hqc3Y-0003DW-3s; Thu, 25 Jul 2019 07:37:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 28681305B1C1;
 Thu, 25 Jul 2019 11:37:07 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-70.ams2.redhat.com [10.36.117.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EA505D71C;
 Thu, 25 Jul 2019 11:37:05 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 13:36:38 +0200
Message-Id: <20190725113638.4702-8-david@redhat.com>
In-Reply-To: <20190725113638.4702-1-david@redhat.com>
References: <20190725113638.4702-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 25 Jul 2019 11:37:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v4 7/7] virtio-balloon: No need to
 track subpages for the PBP anymore
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

As ramblocks cannot get removed/readded while we are processing a bulk
of inflation requests, there is no more need to track the page size
in form of the number of subpages.

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a6282d58d4..fe9664e42c 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -36,7 +36,6 @@
=20
 typedef struct PartiallyBalloonedPage {
     ram_addr_t base_gpa;
-    long subpages;
     unsigned long *bitmap;
 } PartiallyBalloonedPage;
=20
@@ -55,16 +54,15 @@ static PartiallyBalloonedPage *virtio_balloon_pbp_all=
oc(ram_addr_t base_gpa,
     PartiallyBalloonedPage *pbp =3D g_new0(PartiallyBalloonedPage, 1);
=20
     pbp->base_gpa =3D base_gpa;
-    pbp->subpages =3D subpages;
     pbp->bitmap =3D bitmap_new(subpages);
=20
     return pbp;
 }
=20
 static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
-                                       ram_addr_t base_gpa, long subpage=
s)
+                                       ram_addr_t base_gpa)
 {
-    return pbp->subpages =3D=3D subpages && pbp->base_gpa =3D=3D base_gp=
a;
+    return pbp->base_gpa =3D=3D base_gpa;
 }
=20
 static void balloon_inflate_page(VirtIOBalloon *balloon,
@@ -106,7 +104,7 @@ static void balloon_inflate_page(VirtIOBalloon *ballo=
on,
     base_gpa =3D memory_region_get_ram_addr(mr) + mr_offset -
                (rb_offset - rb_aligned_offset);
=20
-    if (*pbp && !virtio_balloon_pbp_matches(*pbp, base_gpa, subpages)) {
+    if (*pbp && !virtio_balloon_pbp_matches(*pbp, base_gpa)) {
         /* We've partially ballooned part of a host page, but now
          * we're trying to balloon part of a different one.  Too hard,
          * give up on the old partial page */
--=20
2.21.0


