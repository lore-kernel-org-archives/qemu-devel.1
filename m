Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5C2C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949142086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949142086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyYik-00060P-I5
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 05:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hyYdK-0008K1-RN
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hyYdJ-0003at-DF
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:34:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hyYdH-0003Xw-1r; Fri, 16 Aug 2019 05:34:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 58D0F306046D;
 Fri, 16 Aug 2019 09:34:50 +0000 (UTC)
Received: from localhost.localdomain.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 924B35C1D6;
 Fri, 16 Aug 2019 09:34:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 16 Aug 2019 11:34:29 +0200
Message-Id: <20190816093439.14262-7-kwolf@redhat.com>
In-Reply-To: <20190816093439.14262-1-kwolf@redhat.com>
References: <20190816093439.14262-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 16 Aug 2019 09:34:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/16] block: Simplify
 bdrv_filter_default_perms()
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The same change as commit 2b23f28639 ('block/copy-on-read: Fix
permissions for inactive node') made for the copy-on-read driver can be
made for bdrv_filter_default_perms(): Retaining the old permissions from
the BdrvChild if it is given complicates things unnecessarily when in
the end this only means that the options set in the c =3D=3D NULL case (i=
.e.
during child creation) are retained.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index cbd8da5f3b..6db8ecd62b 100644
--- a/block.c
+++ b/block.c
@@ -2168,16 +2168,8 @@ void bdrv_filter_default_perms(BlockDriverState *b=
s, BdrvChild *c,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
 {
-    if (c =3D=3D NULL) {
-        *nperm =3D perm & DEFAULT_PERM_PASSTHROUGH;
-        *nshared =3D (shared & DEFAULT_PERM_PASSTHROUGH) | DEFAULT_PERM_=
UNCHANGED;
-        return;
-    }
-
-    *nperm =3D (perm & DEFAULT_PERM_PASSTHROUGH) |
-             (c->perm & DEFAULT_PERM_UNCHANGED);
-    *nshared =3D (shared & DEFAULT_PERM_PASSTHROUGH) |
-               (c->shared_perm & DEFAULT_PERM_UNCHANGED);
+    *nperm =3D perm & DEFAULT_PERM_PASSTHROUGH;
+    *nshared =3D (shared & DEFAULT_PERM_PASSTHROUGH) | DEFAULT_PERM_UNCH=
ANGED;
 }
=20
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
--=20
2.20.1


