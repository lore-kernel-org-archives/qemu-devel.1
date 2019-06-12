Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B923C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73298208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73298208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBhb-0004Hg-MT
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45694)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBSG-0007uc-AD
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBSF-0007mW-3x
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBSC-0007k9-Fr; Wed, 12 Jun 2019 18:10:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BF1267EBBD;
 Wed, 12 Jun 2019 22:10:47 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5070A7E672;
 Wed, 12 Jun 2019 22:10:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:38 +0200
Message-Id: <20190612221004.2317-17-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 12 Jun 2019 22:10:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 16/42] block: Use child access functions
 when flushing
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

If the driver does not support .bdrv_co_flush() so bdrv_co_flush()
itself has to flush the children of the given node, it should not flush
just bs->file->bs, but in fact both the child that stores data, and the
one that stores metadata (if they are separate).

In any case, the BLKDBG_EVENT() should be emitted on the primary child,
because that is where a blkdebug node would be if there is any.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 53aabf86b5..64408cf19a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2533,6 +2533,8 @@ static void coroutine_fn bdrv_flush_co_entry(void *=
opaque)
=20
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 {
+    BdrvChild *primary_child =3D bdrv_primary_child(bs);
+    BlockDriverState *storage_bs, *metadata_bs;
     int current_gen;
     int ret =3D 0;
=20
@@ -2562,7 +2564,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs=
)
     }
=20
     /* Write back cached data to the OS even with cache=3Dunsafe */
-    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_OS);
+    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_OS);
     if (bs->drv->bdrv_co_flush_to_os) {
         ret =3D bs->drv->bdrv_co_flush_to_os(bs);
         if (ret < 0) {
@@ -2580,7 +2582,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs=
)
         goto flush_parent;
     }
=20
-    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
+    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_DISK);
     if (!bs->drv) {
         /* bs->drv->bdrv_co_flush() might have ejected the BDS
          * (even in case of apparent success) */
@@ -2625,7 +2627,20 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *b=
s)
      * in the case of cache=3Dunsafe, so there are no useless flushes.
      */
 flush_parent:
-    ret =3D bs->file ? bdrv_co_flush(bs->file->bs) : 0;
+    storage_bs =3D bdrv_storage_bs(bs);
+    metadata_bs =3D bdrv_metadata_bs(bs);
+
+    ret =3D 0;
+    if (storage_bs) {
+        ret =3D bdrv_co_flush(storage_bs);
+    }
+    if (metadata_bs && metadata_bs !=3D storage_bs) {
+        int ret_metadata =3D bdrv_co_flush(metadata_bs);
+        if (!ret) {
+            ret =3D ret_metadata;
+        }
+    }
+
 out:
     /* Notify any pending flushes that we have completed */
     if (ret =3D=3D 0) {
--=20
2.21.0


