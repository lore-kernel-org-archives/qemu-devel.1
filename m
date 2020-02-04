Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256CBC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E9D21582
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDtJuCTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E9D21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1r6-0003Vj-3Z
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1hq-0003b5-Q8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hp-0003GU-CI
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23276
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1hp-0003DQ-7J
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zz724iZnzx4SDirgrVw+jnOdkfzzfzGIqqsVVd2Wf/M=;
 b=WDtJuCTJb+qhlFgGwP5SONObUx4/sH/FMFTFVgZIqfuCtxmSjO6AhXM9GIRUCA1Z/SlIcq
 D2e2nkjq755FRbkVRIozHEOZ2vjly/DgN1EY3HXQhVmIhbwHw3SELDLVW84gB54CaB1BlN
 R9XzeVuI3rJmo8t4jWA2K7Px8g+7Nt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-SUZU0gfePkmkKbxPkR_1Hg-1; Tue, 04 Feb 2020 12:09:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13ED61336563;
 Tue,  4 Feb 2020 17:09:41 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C7CA857A5;
 Tue,  4 Feb 2020 17:09:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 17/33] block: Split bdrv_default_perms_for_storage()
Date: Tue,  4 Feb 2020 18:08:32 +0100
Message-Id: <20200204170848.614480-18-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: SUZU0gfePkmkKbxPkR_1Hg-1
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

We can be less restrictive about pure data children than those with
metadata on them.

For bdrv_format_default_perms(), we keep the safe option of
bdrv_default_perms_for_metadata() (until we drop
bdrv_format_default_perms() altogether).

That means that bdrv_default_perms_for_data() is unused at this point.
We will use it for all children that have the DATA role, but not the
METADATA role.  So far, no child has any role, so we do not use it, but
that will change.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 53 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index b7999696d4..3619756175 100644
--- a/block.c
+++ b/block.c
@@ -2318,18 +2318,17 @@ static void bdrv_default_perms_for_backing(BlockDri=
verState *bs, BdrvChild *c,
     *nshared =3D shared;
 }
=20
-static void bdrv_default_perms_for_storage(BlockDriverState *bs, BdrvChild=
 *c,
-                                           const BdrvChildClass *child_cla=
ss,
-                                           BdrvChildRole role,
-                                           BlockReopenQueue *reopen_queue,
-                                           uint64_t perm, uint64_t shared,
-                                           uint64_t *nperm, uint64_t *nsha=
red)
+static void bdrv_default_perms_for_metadata(BlockDriverState *bs, BdrvChil=
d *c,
+                                            const BdrvChildClass *child_cl=
ass,
+                                            BdrvChildRole role,
+                                            BlockReopenQueue *reopen_queue=
,
+                                            uint64_t perm, uint64_t shared=
,
+                                            uint64_t *nperm, uint64_t *nsh=
ared)
 {
     int flags;
=20
     assert(child_class =3D=3D &child_file ||
-           (child_class =3D=3D &child_of_bds &&
-            (role & (BDRV_CHILD_METADATA | BDRV_CHILD_DATA))));
+           (child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_METADAT=
A)));
=20
     flags =3D bdrv_reopen_get_flags(reopen_queue, bs);
=20
@@ -2362,6 +2361,40 @@ static void bdrv_default_perms_for_storage(BlockDriv=
erState *bs, BdrvChild *c,
     *nshared =3D shared;
 }
=20
+/* TODO: Use */
+static void __attribute__((unused))
+bdrv_default_perms_for_data(BlockDriverState *bs, BdrvChild *c,
+                            const BdrvChildClass *child_class,
+                            BdrvChildRole role,
+                            BlockReopenQueue *reopen_queue,
+                            uint64_t perm, uint64_t shared,
+                            uint64_t *nperm, uint64_t *nshared)
+{
+    assert(child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_DATA));
+
+    /*
+     * Apart from the modifications below, the same permissions are
+     * forwarded and left alone as for filters
+     */
+    bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+                              perm, shared, &perm, &shared);
+
+    /*
+     * We cannot allow other users to resize the file because the
+     * format driver might have some assumptions about the size
+     * (e.g. because it is stored in metadata, or because the file is
+     * split into fixed-size data files).
+     */
+    shared &=3D ~BLK_PERM_RESIZE;
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
@@ -2373,8 +2406,8 @@ void bdrv_format_default_perms(BlockDriverState *bs, =
BdrvChild *c,
     assert(child_class =3D=3D &child_backing || child_class =3D=3D &child_=
file);
=20
     if (!backing) {
-        bdrv_default_perms_for_storage(bs, c, child_class, role, reopen_qu=
eue,
-                                       perm, shared, nperm, nshared);
+        bdrv_default_perms_for_metadata(bs, c, child_class, role, reopen_q=
ueue,
+                                        perm, shared, nperm, nshared);
     } else {
         bdrv_default_perms_for_backing(bs, c, child_class, role, reopen_qu=
eue,
                                        perm, shared, nperm, nshared);
--=20
2.24.1


