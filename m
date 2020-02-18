Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED13FC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C102176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFM8cY88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C102176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42X0-0005Vj-TK
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42El-0007Ao-IT
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:44:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42Ek-0001rb-Dm
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:44:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42Ek-0001rK-9m
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hRA2oPB+6Kw4HC508F4CPC1l1NDHMCsSmfoIKimhgM=;
 b=cFM8cY88ZvncaHjDFE4YcdFDwubz9xwCP889NXDdsoSiAqpiaHOilS8mW+AaevigwzEi2J
 lqTTIVnolWk6cEdcHiF5aIYRsygb96KpwnbKMVlEwcWgK0Ing1YFJjTM18EbYm8cDM4X3o
 8836+sTp4sCtY6O7UD8v62IaVb81OCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-lH7k7QzpPoW_09b0SoDgIw-1; Tue, 18 Feb 2020 07:44:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 001F613E5;
 Tue, 18 Feb 2020 12:44:21 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 743ED5C241;
 Tue, 18 Feb 2020 12:44:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 30/33] block: Drop bdrv_format_default_perms()
Date: Tue, 18 Feb 2020 13:42:39 +0100
Message-Id: <20200218124242.584644-31-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: lH7k7QzpPoW_09b0SoDgIw-1
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c                   | 19 -------------------
 include/block/block_int.h | 11 -----------
 2 files changed, 30 deletions(-)

diff --git a/block.c b/block.c
index a7c2ad6c5b..16eb790ea6 100644
--- a/block.c
+++ b/block.c
@@ -2344,25 +2344,6 @@ static void bdrv_default_perms_for_data(BlockDriverS=
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
index c2fb6b8899..28a35cd5d1 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1253,17 +1253,6 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t p=
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
2.24.1


