Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F5C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F9A20C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F9A20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7cm-0005Vl-Rb
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56910)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7XK-0000ug-1T
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7XI-00042q-Qc
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7XF-000410-5q; Fri, 09 Aug 2019 12:14:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 808283082B1F;
 Fri,  9 Aug 2019 16:14:32 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19784600CC;
 Fri,  9 Aug 2019 16:14:31 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:35 +0200
Message-Id: <20190809161407.11920-11-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 09 Aug 2019 16:14:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 10/42] block: Drop bdrv_is_encrypted()
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

The original purpose of bdrv_is_encrypted() was to inquire whether a BDS
can be used without the user entering a password or not.  It has not
been used for that purpose for quite some time.

Actually, it is not even fit for that purpose, because to answer that
question, it would have recursively query all of the given node's
children.

So now we have to decide in which direction we want to fix
bdrv_is_encrypted(): Recursively query all children, or drop it and just
use bs->encrypted to get the current node's status?

Nowadays, its only purpose is to report through bdrv_query_image_info()
whether the given image is encrypted or not.  For this purpose, it is
probably more interesting to see whether a given node itself is
encrypted or not (otherwise, a management application cannot discern for
certain which nodes are really encrypted and which just have encrypted
children).

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h | 1 -
 block.c               | 8 --------
 block/qapi.c          | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index f6f09b95cd..9cfe77abaf 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -487,7 +487,6 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it);
 void bdrv_next_cleanup(BdrvNextIterator *it);
=20
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
-bool bdrv_is_encrypted(BlockDriverState *bs);
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
                          void *opaque, bool read_only);
 const char *bdrv_get_node_name(const BlockDriverState *bs);
diff --git a/block.c b/block.c
index 650c00d182..415c555bf5 100644
--- a/block.c
+++ b/block.c
@@ -4696,14 +4696,6 @@ bool bdrv_is_sg(BlockDriverState *bs)
     return bs->sg;
 }
=20
-bool bdrv_is_encrypted(BlockDriverState *bs)
-{
-    if (bs->backing && bs->backing->bs->encrypted) {
-        return true;
-    }
-    return bs->encrypted;
-}
-
 const char *bdrv_get_format_name(BlockDriverState *bs)
 {
     return bs->drv ? bs->drv->format_name : NULL;
diff --git a/block/qapi.c b/block/qapi.c
index 15f1030264..9a185cba48 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -281,7 +281,7 @@ void bdrv_query_image_info(BlockDriverState *bs,
     info->virtual_size    =3D size;
     info->actual_size     =3D bdrv_get_allocated_file_size(bs);
     info->has_actual_size =3D info->actual_size >=3D 0;
-    if (bdrv_is_encrypted(bs)) {
+    if (bs->encrypted) {
         info->encrypted =3D true;
         info->has_encrypted =3D true;
     }
--=20
2.21.0


