Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778E8C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 10:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AB12070D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 10:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AB12070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs3Id-0001LE-Hd
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 06:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hs3Hy-0000sO-Si
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 06:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hs3Hx-0001cg-RI
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 06:53:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45128)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hs3Hv-0001Ta-G8; Mon, 29 Jul 2019 06:53:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 53C903084212;
 Mon, 29 Jul 2019 10:53:53 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-188.ams2.redhat.com
 [10.36.116.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43E145D9C3;
 Mon, 29 Jul 2019 10:53:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 29 Jul 2019 12:53:43 +0200
Message-Id: <20190729105343.19250-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 29 Jul 2019 10:53:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1] block/copy-on-read: Fix permissions
 for inactive node
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The copy-on-read drive must not request the WRITE_UNCHANGED permission
for its child if the node is inactive, otherwise starting a migration
destination with -incoming will fail because the child cannot provide
write access yet:

  qemu-system-x86_64: -blockdev copy-on-read,file=3Dimg,node-name=3Dcor: =
Block node is read-only

Earlier QEMU versions additionally ran into an abort() on the migration
source side: bdrv_inactivate_recurse() failed to update permissions.
This is silently ignored today because it was only supposed to loosen
restrictions. This is the symptom that was originally reported here:

  https://bugzilla.redhat.com/show_bug.cgi?id=3D1733022

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/copy-on-read.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 22f24fd0db..6631f30205 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -56,16 +56,14 @@ static void cor_child_perm(BlockDriverState *bs, Bdrv=
Child *c,
                            uint64_t perm, uint64_t shared,
                            uint64_t *nperm, uint64_t *nshared)
 {
-    if (c =3D=3D NULL) {
-        *nperm =3D (perm & PERM_PASSTHROUGH) | BLK_PERM_WRITE_UNCHANGED;
-        *nshared =3D (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
-        return;
-    }
+    *nperm =3D perm & PERM_PASSTHROUGH;
+    *nshared =3D (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
=20
-    *nperm =3D (perm & PERM_PASSTHROUGH) |
-             (c->perm & PERM_UNCHANGED);
-    *nshared =3D (shared & PERM_PASSTHROUGH) |
-               (c->shared_perm & PERM_UNCHANGED);
+    /* We must not request write permissions for an inactive node, the c=
hild
+     * cannot provide it. */
+    if (!(bs->open_flags & BDRV_O_INACTIVE)) {
+        *nperm |=3D BLK_PERM_WRITE_UNCHANGED;
+    }
 }
=20
=20
--=20
2.20.1


