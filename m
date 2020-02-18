Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425D1C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD782067D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1bfpiZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD782067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42QP-0001na-62
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42E8-0005eV-AP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42E7-0001Xy-0g
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53380
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42E6-0001Xf-Sc
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gArPcFvrgWgPAU5UnPYON1w06SOWCsg0NzSVFmmLTmI=;
 b=W1bfpiZ+vkgEHzpUt8WDPk39bltL/fQfP3UESByxGAc3vIhiF0SlwQWgr5b9jqc2EDdBvK
 wTQdDk49yYQrkZYhCmooavTU4bsu6/gW0RbEw31vSOcK5zVrmw9ldbOGnvBnPykxagd4Hr
 CUDiqSyrbXwjNkvj0Qx00GWnHwUiJoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-E2tbPrHtOTyiCZhxTNASEA-1; Tue, 18 Feb 2020 07:43:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5E9B18A5500;
 Tue, 18 Feb 2020 12:43:37 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F6A660C80;
 Tue, 18 Feb 2020 12:43:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 16/33] block: Pull out bdrv_default_perms_for_storage()
Date: Tue, 18 Feb 2020 13:42:25 +0100
Message-Id: <20200218124242.584644-17-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: E2tbPrHtOTyiCZhxTNASEA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Right now, bdrv_format_default_perms() is used by format parents
(generally). We want to switch to a model where most parents use a
single BdrvChildClass, which then decides the permissions based on the
child role. To do so, we have to split bdrv_format_default_perms() into
separate functions for each such role.

Note that bdrv_default_perms_for_storage() currently handles all DATA |
METADATA children.  A follow-up patch is going to split it further into
one function for each case.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 71 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/block.c b/block.c
index 8b97412cbc..64b5635122 100644
--- a/block.c
+++ b/block.c
@@ -2340,6 +2340,50 @@ static void bdrv_default_perms_for_backing(BlockDriv=
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
@@ -2351,31 +2395,8 @@ void bdrv_format_default_perms(BlockDriverState *bs,=
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


