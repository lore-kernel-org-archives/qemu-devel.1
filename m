Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A9CC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255392082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxtfDyPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255392082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1yY-0001vK-AD
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1iT-0004tV-6n
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1iS-0005WL-0a
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:10:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1iR-0005Ud-Sw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYJYtS4RN/u0AjQq2uaU4I6ycdYjaQdMlMiRamTBo6w=;
 b=hxtfDyPw2QtAmk4US9H97SsItEjgBsswBffQnkVup3a1EveUzGWlCnap/kPhyqLlKjVBrF
 xD/LzYFwVPbyGgMrZyWrnROM7uur2er5fXtBa/CRPyoLy4o0nDuqbflIM66th+s12bPXhg
 OI6u88zLa4EpT5/7iFGfC+vEQ9KFyW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-kxFa1RQcPwKJR4aEtuMzRg-1; Tue, 04 Feb 2020 12:10:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58ABC1085925;
 Tue,  4 Feb 2020 17:10:18 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E36625C1D4;
 Tue,  4 Feb 2020 17:10:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 29/33] block: Make bdrv_filter_default_perms() static
Date: Tue,  4 Feb 2020 18:08:44 +0100
Message-Id: <20200204170848.614480-30-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: kxFa1RQcPwKJR4aEtuMzRg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 block.c                   | 12 ++++++------
 include/block/block_int.h | 10 ----------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/block.c b/block.c
index 747a2973f5..091e9cc16a 100644
--- a/block.c
+++ b/block.c
@@ -2194,12 +2194,12 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, =
BdrvChild *c, Error **errp)
     return bdrv_child_try_set_perm(c, perms, shared, errp);
 }
=20
-void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildClass *child_class,
-                               BdrvChildRole role,
-                               BlockReopenQueue *reopen_queue,
-                               uint64_t perm, uint64_t shared,
-                               uint64_t *nperm, uint64_t *nshared)
+static void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
+                                      const BdrvChildClass *child_class,
+                                      BdrvChildRole role,
+                                      BlockReopenQueue *reopen_queue,
+                                      uint64_t perm, uint64_t shared,
+                                      uint64_t *nperm, uint64_t *nshared)
 {
     *nperm =3D perm & DEFAULT_PERM_PASSTHROUGH;
     *nshared =3D (shared & DEFAULT_PERM_PASSTHROUGH) | DEFAULT_PERM_UNCHAN=
GED;
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7b51866678..5e3f512ae8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1254,16 +1254,6 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t p=
erm, uint64_t shared,
  */
 int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **e=
rrp);
=20
-/* Default implementation for BlockDriver.bdrv_child_perm() that can be us=
ed by
- * block filters: Forward CONSISTENT_READ, WRITE, WRITE_UNCHANGED and RESI=
ZE to
- * all children */
-void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildClass *child_class,
-                               BdrvChildRole child_role,
-                               BlockReopenQueue *reopen_queue,
-                               uint64_t perm, uint64_t shared,
-                               uint64_t *nperm, uint64_t *nshared);
-
 /* Default implementation for BlockDriver.bdrv_child_perm() that can be us=
ed by
  * (non-raw) image formats: Like above for bs->backing, but for bs->file i=
t
  * requires WRITE | RESIZE for read-write images, always requires
--=20
2.24.1


