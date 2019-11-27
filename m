Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9759BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622D020674
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikrbFEOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622D020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38593 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxiX-0004zp-15
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxCc-0004cK-Lh
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxCa-0007Lv-GO
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxCY-0007Ec-6q
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Rx7MLvX3l6xuNksjFfh00b3GGo+qju7CE9FGBRdD7w=;
 b=ikrbFEOCAngDSSOwWIai6cUa3pFiOnz+BDBf+e37K6PGPopPfa5i6jFCVmPVznSd+BTr4N
 oh9WHQyR3GpazTj/OPkQ7iOYpbhaOF6BY+p0rzeDVl7mzSg2fQbO4YgTN57gi9XAzVmTZr
 uBFv6Cv+4LTNJ9ARHvghM8yHGTvPMuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-S4wdWozfOiWNhdcUpk-Nag-1; Wed, 27 Nov 2019 08:17:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3EDB107ACE4;
 Wed, 27 Nov 2019 13:17:36 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67E58600C8;
 Wed, 27 Nov 2019 13:17:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 29/31] block: Drop child_file
Date: Wed, 27 Nov 2019 14:16:22 +0100
Message-Id: <20191127131624.1062403-30-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: S4wdWozfOiWNhdcUpk-Nag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                   | 30 +-----------------------------
 include/block/block_int.h |  1 -
 tests/test-bdrv-drain.c   |  8 +++-----
 3 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/block.c b/block.c
index 3fcd56aaae..b2dc05b028 100644
--- a/block.c
+++ b/block.c
@@ -1077,33 +1077,6 @@ const BdrvChildClass child_of_bds =3D {
     .update_filename =3D bdrv_child_cb_update_filename,
 };
=20
-/*
- * Returns the options and flags that bs->file should get if a protocol dr=
iver
- * is expected, based on the given options and flags for the parent BDS
- */
-static void bdrv_inherited_file_options(BdrvChildRole role,
-                                        int *child_flags, QDict *child_opt=
ions,
-                                        int parent_flags, QDict *parent_op=
tions)
-{
-    bdrv_inherited_options(BDRV_CHILD_IMAGE,
-                           child_flags, child_options,
-                           parent_flags, parent_options);
-}
-
-const BdrvChildClass child_file =3D {
-    .parent_is_bds   =3D true,
-    .get_parent_desc =3D bdrv_child_get_parent_desc,
-    .inherit_options =3D bdrv_inherited_file_options,
-    .drained_begin   =3D bdrv_child_cb_drained_begin,
-    .drained_poll    =3D bdrv_child_cb_drained_poll,
-    .drained_end     =3D bdrv_child_cb_drained_end,
-    .attach          =3D bdrv_child_cb_attach,
-    .detach          =3D bdrv_child_cb_detach,
-    .inactivate      =3D bdrv_child_cb_inactivate,
-    .can_set_aio_ctx =3D bdrv_child_cb_can_set_aio_ctx,
-    .set_aio_ctx     =3D bdrv_child_cb_set_aio_ctx,
-};
-
 static void bdrv_backing_attach(BdrvChild *c)
 {
     BlockDriverState *parent =3D c->opaque;
@@ -2228,8 +2201,7 @@ static void bdrv_default_perms_for_metadata(BlockDriv=
erState *bs, BdrvChild *c,
 {
     int flags;
=20
-    assert(child_class =3D=3D &child_file ||
-           (child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_METADAT=
A)));
+    assert(child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_METADATA=
));
=20
     flags =3D bdrv_reopen_get_flags(reopen_queue, bs);
=20
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 05e7a27318..04eab10eda 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -730,7 +730,6 @@ struct BdrvChildClass {
 };
=20
 extern const BdrvChildClass child_of_bds;
-extern const BdrvChildClass child_file;
=20
 struct BdrvChild {
     BlockDriverState *bs;
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 0da5a3a6a1..655fd0d085 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -93,12 +93,10 @@ static void bdrv_test_child_perm(BlockDriverState *bs, =
BdrvChild *c,
                                  uint64_t *nperm, uint64_t *nshared)
 {
     /*
-     * bdrv_default_perms() accepts only these two, so disguise
-     * detach_by_driver_cb_parent as one of them.
+     * bdrv_default_perms() accepts nothing else, so disguise
+     * detach_by_driver_cb_parent.
      */
-    if (child_class !=3D &child_file && child_class !=3D &child_of_bds) {
-        child_class =3D &child_of_bds;
-    }
+    child_class =3D &child_of_bds;
=20
     bdrv_default_perms(bs, c, child_class, role, reopen_queue,
                        perm, shared, nperm, nshared);
--=20
2.23.0


