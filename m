Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE9EC3403B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5AA20659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjmhOgSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5AA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42Ol-0007AT-CF
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42Dy-0005Dq-Lo
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42Dx-0001Pz-J1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25093
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42Dx-0001Pa-Ex
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LfVKdqV835QiWGlotzClIHLXhou0szKpLXr41gud1rg=;
 b=UjmhOgSSC8qNp2fm2MTul1sdbfod0OhcTQ6zCFqm8owOgVJjWoR5VTiYakc+fCq3/u9dDr
 u5+/tpsWDvpu04vfzI63dakPe0x2148kYkDhTKpcqtGvCbRXlfTqE/gCJImJwNerC5mM4N
 EV/W80/IypSajzSWnRm/TCAN/L35UvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-klkNwiDcOvq8oCtfbHM4ig-1; Tue, 18 Feb 2020 07:43:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6008D800D50;
 Tue, 18 Feb 2020 12:43:34 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D317D5C1B2;
 Tue, 18 Feb 2020 12:43:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 15/33] block: Pull out bdrv_default_perms_for_backing()
Date: Tue, 18 Feb 2020 13:42:24 +0100
Message-Id: <20200218124242.584644-16-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: klkNwiDcOvq8oCtfbHM4ig-1
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 62 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/block.c b/block.c
index 982785b15a..8b97412cbc 100644
--- a/block.c
+++ b/block.c
@@ -2302,6 +2302,44 @@ void bdrv_filter_default_perms(BlockDriverState *bs,=
 BdrvChild *c,
     *nshared =3D (shared & DEFAULT_PERM_PASSTHROUGH) | DEFAULT_PERM_UNCHAN=
GED;
 }
=20
+static void bdrv_default_perms_for_backing(BlockDriverState *bs, BdrvChild=
 *c,
+                                           const BdrvChildClass *child_cla=
ss,
+                                           BdrvChildRole role,
+                                           BlockReopenQueue *reopen_queue,
+                                           uint64_t perm, uint64_t shared,
+                                           uint64_t *nperm, uint64_t *nsha=
red)
+{
+    assert(child_class =3D=3D &child_backing ||
+           (child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_COW)));
+
+    /*
+     * We want consistent read from backing files if the parent needs it.
+     * No other operations are performed on backing files.
+     */
+    perm &=3D BLK_PERM_CONSISTENT_READ;
+
+    /*
+     * If the parent can deal with changing data, we're okay with a
+     * writable and resizable backing file.
+     * TODO Require !(perm & BLK_PERM_CONSISTENT_READ), too?
+     */
+    if (shared & BLK_PERM_WRITE) {
+        shared =3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
+    } else {
+        shared =3D 0;
+    }
+
+    shared |=3D BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
+              BLK_PERM_WRITE_UNCHANGED;
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
@@ -2339,28 +2377,8 @@ void bdrv_format_default_perms(BlockDriverState *bs,=
 BdrvChild *c,
         *nperm =3D perm;
         *nshared =3D shared;
     } else {
-        /* We want consistent read from backing files if the parent needs =
it.
-         * No other operations are performed on backing files. */
-        perm &=3D BLK_PERM_CONSISTENT_READ;
-
-        /* If the parent can deal with changing data, we're okay with a
-         * writable and resizable backing file. */
-        /* TODO Require !(perm & BLK_PERM_CONSISTENT_READ), too? */
-        if (shared & BLK_PERM_WRITE) {
-            shared =3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
-        } else {
-            shared =3D 0;
-        }
-
-        shared |=3D BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
-                  BLK_PERM_WRITE_UNCHANGED;
-
-        if (bs->open_flags & BDRV_O_INACTIVE) {
-            shared |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
-        }
-
-        *nperm =3D perm;
-        *nshared =3D shared;
+        bdrv_default_perms_for_backing(bs, c, child_class, role, reopen_qu=
eue,
+                                       perm, shared, nperm, nshared);
     }
 }
=20
--=20
2.24.1


