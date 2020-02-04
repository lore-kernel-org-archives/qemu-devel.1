Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7931BC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459672084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/xMvO0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459672084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1sy-0006tB-GH
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1hq-0003b6-Q9
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hp-0003FF-21
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32621
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1ho-0003Cu-Ul
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABj1BfovrQUil+mOpE24JuscIZIbCTS4R2SMAW7WVGU=;
 b=O/xMvO0sv2+S3ckBPjvBlAygUaa6Ol410Rvj36dLdCUurgGFeH18UcI0G2FvFUFA7Vn+xc
 +E5pu+JNn+PFpJJVjQn7f+sb5LbqB3x036nZOHGGM05SCEJFn2sdB7EIQYYe8Ari1MrZ4I
 mrngDFMuECoYo3mrggCm+eD0HMzvuUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-ORnub8KMPoijtc9XvdLyWw-1; Tue, 04 Feb 2020 12:09:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 970E48010EF;
 Tue,  4 Feb 2020 17:09:38 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EBFB5D9E2;
 Tue,  4 Feb 2020 17:09:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 16/33] block: Pull out bdrv_default_perms_for_storage()
Date: Tue,  4 Feb 2020 18:08:31 +0100
Message-Id: <20200204170848.614480-17-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ORnub8KMPoijtc9XvdLyWw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 71 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/block.c b/block.c
index b26ec10cce..b7999696d4 100644
--- a/block.c
+++ b/block.c
@@ -2318,6 +2318,50 @@ static void bdrv_default_perms_for_backing(BlockDriv=
erState *bs, BdrvChild *c,
     *nshared =3D shared;
 }
=20
+static void bdrv_default_perms_for_storage(BlockDriverState *bs, BdrvChild=
 *c,
+                                           const BdrvChildClass *child_cla=
ss,
+                                           BdrvChildRole role,
+                                           BlockReopenQueue *reopen_queue,
+                                           uint64_t perm, uint64_t shared,
+                                           uint64_t *nperm, uint64_t *nsha=
red)
+{
+    int flags;
+
+    assert(child_class =3D=3D &child_file ||
+           (child_class =3D=3D &child_of_bds &&
+            (role & (BDRV_CHILD_METADATA | BDRV_CHILD_DATA))));
+
+    flags =3D bdrv_reopen_get_flags(reopen_queue, bs);
+
+    /*
+     * Apart from the modifications below, the same permissions are
+     * forwarded and left alone as for filters
+     */
+    bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+                              perm, shared, &perm, &shared);
+
+    /* Format drivers may touch metadata even if the guest doesn't write *=
/
+    if (bdrv_is_writable_after_reopen(bs, reopen_queue)) {
+        perm |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
+    }
+
+    /*
+     * bs->file always needs to be consistent because of the metadata. We
+     * can never allow other users to resize or write to it.
+     */
+    if (!(flags & BDRV_O_NO_IO)) {
+        perm |=3D BLK_PERM_CONSISTENT_READ;
+    }
+    shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
+
+    if (bs->open_flags & BDRV_O_INACTIVE) {
+        shared |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
+    }
+
+    *nperm =3D perm;
+    *nshared =3D shared;
+}
+
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildClass *child_class,
                                BdrvChildRole role,
@@ -2329,31 +2373,8 @@ void bdrv_format_default_perms(BlockDriverState *bs,=
 BdrvChild *c,
     assert(child_class =3D=3D &child_backing || child_class =3D=3D &child_=
file);
=20
     if (!backing) {
-        int flags =3D bdrv_reopen_get_flags(reopen_queue, bs);
-
-        /* Apart from the modifications below, the same permissions are
-         * forwarded and left alone as for filters */
-        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
-                                  perm, shared, &perm, &shared);
-
-        /* Format drivers may touch metadata even if the guest doesn't wri=
te */
-        if (bdrv_is_writable_after_reopen(bs, reopen_queue)) {
-            perm |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
-        }
-
-        /* bs->file always needs to be consistent because of the metadata.=
 We
-         * can never allow other users to resize or write to it. */
-        if (!(flags & BDRV_O_NO_IO)) {
-            perm |=3D BLK_PERM_CONSISTENT_READ;
-        }
-        shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
-
-        if (bs->open_flags & BDRV_O_INACTIVE) {
-            shared |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
-        }
-
-        *nperm =3D perm;
-        *nshared =3D shared;
+        bdrv_default_perms_for_storage(bs, c, child_class, role, reopen_qu=
eue,
+                                       perm, shared, nperm, nshared);
     } else {
         bdrv_default_perms_for_backing(bs, c, child_class, role, reopen_qu=
eue,
                                        perm, shared, nperm, nshared);
--=20
2.24.1


