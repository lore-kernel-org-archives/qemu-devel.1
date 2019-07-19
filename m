Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A63C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54B02186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54B02186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoVMz-00032T-2s
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 12:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38125)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hoVMn-0002bC-G8
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hoVMe-00058P-Q5
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:04:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43156)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1hoVMX-0003Z7-Nh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:04:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B54B317915D;
 Fri, 19 Jul 2019 16:01:31 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1441F1001B02;
 Fri, 19 Jul 2019 16:01:29 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 18:01:18 +0200
Message-Id: <20190719160120.26581-2-david@redhat.com>
In-Reply-To: <20190719160120.26581-1-david@redhat.com>
References: <20190719160120.26581-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 19 Jul 2019 16:01:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 1/3] virtio-balloon: simplify deflate with
 pbp
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

Let's simplify this - the case we are optimizing for is very hard to
trigger and not worth the effort. If we're switching from inflation to
deflation, let's reset the pbp.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 9de3c030bf..287d5d4c97 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -121,7 +121,7 @@ static void balloon_deflate_page(VirtIOBalloon *ballo=
on,
     void *addr =3D memory_region_get_ram_ptr(mr) + offset;
     RAMBlock *rb;
     size_t rb_page_size;
-    ram_addr_t ram_offset, host_page_base;
+    ram_addr_t ram_offset;
     void *host_addr;
     int ret;
=20
@@ -129,26 +129,10 @@ static void balloon_deflate_page(VirtIOBalloon *bal=
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
-            virtio_balloon_reset_pbp(balloon);
-        }
+    if (balloon->pbp) {
+        /* Let's play safe and always reset the pbp on deflation request=
s. */
+        virtio_balloon_reset_pbp(balloon);
     }
=20
     host_addr =3D (void *)((uintptr_t)addr & ~(rb_page_size - 1));
--=20
2.21.0


