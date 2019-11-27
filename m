Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A04C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716E120678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAtFofvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716E120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxZe-0001yP-1v
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxCc-0004c3-H9
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxCa-0007Lj-Ee
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55137
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxCW-0007By-Gc
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ae5Ho3fqHsH1pp1WzievJihrmFaKZ34OCTdttSeC8tg=;
 b=MAtFofvlheYShWMSHMuCI5JZNgrpmqTZ1BmWfJkeXPoenJLhsBKTiUg1DZmbiH+MsrmoB8
 4vNd/Wtxcv5veAkTCllb8pibp17Y6qoW6sZRYDh/T6J3v8gfPe4XMXHaAy4fcEIjWCFSG0
 x/DiUZc5n5FqhbVUlHyzTcp830fNjnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-_GQI7mkIPC2xtNGVBlR2hQ-1; Wed, 27 Nov 2019 08:17:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89928106C05D;
 Wed, 27 Nov 2019 13:17:34 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F6AF10842CB;
 Wed, 27 Nov 2019 13:17:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 28/31] block: Drop bdrv_format_default_perms()
Date: Wed, 27 Nov 2019 14:16:21 +0100
Message-Id: <20191127131624.1062403-29-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: _GQI7mkIPC2xtNGVBlR2hQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                   | 19 -------------------
 include/block/block_int.h | 11 -----------
 2 files changed, 30 deletions(-)

diff --git a/block.c b/block.c
index b6c92ef283..3fcd56aaae 100644
--- a/block.c
+++ b/block.c
@@ -2294,25 +2294,6 @@ static void bdrv_default_perms_for_data(BlockDriverS=
tate *bs, BdrvChild *c,
     *nshared =3D shared;
 }
=20
-void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildClass *child_class,
-                               BdrvChildRole role,
-                               BlockReopenQueue *reopen_queue,
-                               uint64_t perm, uint64_t shared,
-                               uint64_t *nperm, uint64_t *nshared)
-{
-    if (child_class =3D=3D &child_of_bds) {
-        bdrv_default_perms(bs, c, child_class, role, reopen_queue,
-                           perm, shared, nperm, nshared);
-        return;
-    }
-
-    assert(child_class =3D=3D &child_file);
-
-    bdrv_default_perms_for_metadata(bs, c, child_class, role, reopen_queue=
,
-                                    perm, shared, nperm, nshared);
-}
-
 void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
                         const BdrvChildClass *child_class, BdrvChildRole r=
ole,
                         BlockReopenQueue *reopen_queue,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7818734708..05e7a27318 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1243,17 +1243,6 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t p=
erm, uint64_t shared,
  */
 int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **e=
rrp);
=20
-/* Default implementation for BlockDriver.bdrv_child_perm() that can be us=
ed by
- * (non-raw) image formats: Like above for bs->backing, but for bs->file i=
t
- * requires WRITE | RESIZE for read-write images, always requires
- * CONSISTENT_READ and doesn't share WRITE. */
-void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
-                               const BdrvChildClass *child_class,
-                               BdrvChildRole child_role,
-                               BlockReopenQueue *reopen_queue,
-                               uint64_t perm, uint64_t shared,
-                               uint64_t *nperm, uint64_t *nshared);
-
 bool bdrv_recurse_can_replace(BlockDriverState *bs,
                               BlockDriverState *to_replace);
=20
--=20
2.23.0


