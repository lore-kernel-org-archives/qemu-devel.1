Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AE4C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7274620C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7274620C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7ix-0002Tq-Oe
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7XW-0001cz-4J
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7XU-0004CZ-V1
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7XS-0004B9-P1; Fri, 09 Aug 2019 12:14:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E83A30D47F6;
 Fri,  9 Aug 2019 16:14:46 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7AD3600CE;
 Fri,  9 Aug 2019 16:14:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:41 +0200
Message-Id: <20190809161407.11920-17-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 09 Aug 2019 16:14:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 16/42] block: Flush all children in generic
 code
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
just bs->file->bs, but in fact all children.

In any case, the BLKDBG_EVENT() should be emitted on the primary child,
because that is where a blkdebug node would be if there is any.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index c5a8e3e6a3..bcc770d336 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2572,6 +2572,8 @@ static void coroutine_fn bdrv_flush_co_entry(void *=
opaque)
=20
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 {
+    BdrvChild *primary_child =3D bdrv_primary_child(bs);
+    BdrvChild *child;
     int current_gen;
     int ret =3D 0;
=20
@@ -2601,7 +2603,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs=
)
     }
=20
     /* Write back cached data to the OS even with cache=3Dunsafe */
-    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_OS);
+    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_OS);
     if (bs->drv->bdrv_co_flush_to_os) {
         ret =3D bs->drv->bdrv_co_flush_to_os(bs);
         if (ret < 0) {
@@ -2611,15 +2613,15 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *=
bs)
=20
     /* But don't actually force it to the disk with cache=3Dunsafe */
     if (bs->open_flags & BDRV_O_NO_FLUSH) {
-        goto flush_parent;
+        goto flush_children;
     }
=20
     /* Check if we really need to flush anything */
     if (bs->flushed_gen =3D=3D current_gen) {
-        goto flush_parent;
+        goto flush_children;
     }
=20
-    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
+    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_DISK);
     if (!bs->drv) {
         /* bs->drv->bdrv_co_flush() might have ejected the BDS
          * (even in case of apparent success) */
@@ -2663,8 +2665,17 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *b=
s)
     /* Now flush the underlying protocol.  It will also have BDRV_O_NO_F=
LUSH
      * in the case of cache=3Dunsafe, so there are no useless flushes.
      */
-flush_parent:
-    ret =3D bs->file ? bdrv_co_flush(bs->file->bs) : 0;
+flush_children:
+    ret =3D 0;
+    QLIST_FOREACH(child, &bs->children, next) {
+        int this_child_ret;
+
+        this_child_ret =3D bdrv_co_flush(child->bs);
+        if (!ret) {
+            ret =3D this_child_ret;
+        }
+    }
+
 out:
     /* Notify any pending flushes that we have completed */
     if (ret =3D=3D 0) {
--=20
2.21.0


