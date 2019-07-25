Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C5BC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9FF22BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9FF22BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqc3p-000372-Nt
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51248)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hqc3O-0001Sq-93
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hqc3M-00038K-9B
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:36:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hqc3K-000379-Au; Thu, 25 Jul 2019 07:36:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 195E83092641;
 Thu, 25 Jul 2019 11:36:53 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-70.ams2.redhat.com [10.36.117.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 928DD5437A;
 Thu, 25 Jul 2019 11:36:51 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 13:36:34 +0200
Message-Id: <20190725113638.4702-4-david@redhat.com>
In-Reply-To: <20190725113638.4702-1-david@redhat.com>
References: <20190725113638.4702-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 25 Jul 2019 11:36:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v4 3/7] virtio-balloon: Simplify
 deflate with pbp
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

Let's simplify this - the case we are optimizing for is very hard to
trigger and not worth the effort. If we're switching from inflation to
deflation, let's reset the pbp.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a78d2d2184..04a7e6c772 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -117,7 +117,7 @@ static void balloon_deflate_page(VirtIOBalloon *ballo=
on,
     void *addr =3D memory_region_get_ram_ptr(mr) + offset;
     RAMBlock *rb;
     size_t rb_page_size;
-    ram_addr_t ram_offset, host_page_base;
+    ram_addr_t ram_offset;
     void *host_addr;
     int ret;
=20
@@ -125,27 +125,11 @@ static void balloon_deflate_page(VirtIOBalloon *bal=
loon,
      * host address? */
     rb =3D qemu_ram_block_from_host(addr, false, &ram_offset);
     rb_page_size =3D qemu_ram_pagesize(rb);
-    host_page_base =3D ram_offset & ~(rb_page_size - 1);
-
-    if (balloon->pbp
-        && rb =3D=3D balloon->pbp->rb
-        && host_page_base =3D=3D balloon->pbp->base) {
-        int subpages =3D rb_page_size / BALLOON_PAGE_SIZE;
=20
-        /*
-         * This means the guest has asked to discard some of the 4kiB
-         * subpages of a host page, but then changed its mind and
-         * asked to keep them after all.  It's exceedingly unlikely
-         * for a guest to do this in practice, but handle it anyway,
-         * since getting it wrong could mean discarding memory the
-         * guest is still using. */
-        clear_bit((ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
-                  balloon->pbp->bitmap);
-
-        if (bitmap_empty(balloon->pbp->bitmap, subpages)) {
-            g_free(balloon->pbp);
-            balloon->pbp =3D NULL;
-        }
+    if (balloon->pbp) {
+        /* Let's play safe and always reset the pbp on deflation request=
s. */
+        g_free(balloon->pbp);
+        balloon->pbp =3D NULL;
     }
=20
     host_addr =3D (void *)((uintptr_t)addr & ~(rb_page_size - 1));
--=20
2.21.0


