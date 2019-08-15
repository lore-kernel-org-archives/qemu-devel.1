Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C31C41514
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A092084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A092084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKdv-0000pC-2t
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hyKXC-00030o-HO
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hyKX6-0001s3-9t
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hyKWz-0001db-Cp; Thu, 15 Aug 2019 14:31:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9497DC0BAA0D;
 Thu, 15 Aug 2019 18:31:21 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CF5E8388F;
 Thu, 15 Aug 2019 18:30:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 13:30:32 -0500
Message-Id: <20190815183039.4264-3-eblake@redhat.com>
In-Reply-To: <20190815183039.4264-1-eblake@redhat.com>
References: <20190815183039.4264-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 15 Aug 2019 18:31:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/9] block: implement BDRV_REQ_PREFETCH
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block I/O path" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Do effective copy-on-read request when we don't need data actually. It
will be used for block-stream and NBD_CMD_CACHE.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190725100550.33801-2-vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
[eblake: comment grammar fix]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block.h |  8 +++++++-
 block/io.c            | 18 ++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 50a07c1c3385..a9df34ff94b6 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -88,8 +88,14 @@ typedef enum {
      * fallback. */
     BDRV_REQ_NO_FALLBACK        =3D 0x100,

+    /*
+     * BDRV_REQ_PREFETCH may be used only together with BDRV_REQ_COPY_ON=
_READ
+     * on read request and means that caller doesn't really need data to=
 be
+     * written to qiov parameter which may be NULL.
+     */
+    BDRV_REQ_PREFETCH  =3D 0x200,
     /* Mask of valid flags */
-    BDRV_REQ_MASK               =3D 0x1ff,
+    BDRV_REQ_MASK               =3D 0x3ff,
 } BdrvRequestFlags;

 typedef struct BlockSizes {
diff --git a/block/io.c b/block/io.c
index 06305c6ea62e..9d99858b554b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1167,7 +1167,8 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs=
, uint64_t offset,
 }

 static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
-        int64_t offset, unsigned int bytes, QEMUIOVector *qiov)
+        int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+        int flags)
 {
     BlockDriverState *bs =3D child->bs;

@@ -1278,9 +1279,11 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(B=
drvChild *child,
                 goto err;
             }

-            qemu_iovec_from_buf(qiov, progress, bounce_buffer + skip_byt=
es,
-                                pnum - skip_bytes);
-        } else {
+            if (!(flags & BDRV_REQ_PREFETCH)) {
+                qemu_iovec_from_buf(qiov, progress, bounce_buffer + skip=
_bytes,
+                                    pnum - skip_bytes);
+            }
+        } else if (!(flags & BDRV_REQ_PREFETCH)) {
             /* Read directly into the destination */
             qemu_iovec_init(&local_qiov, qiov->niov);
             qemu_iovec_concat(&local_qiov, qiov, progress, pnum - skip_b=
ytes);
@@ -1331,7 +1334,8 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChi=
ld *child,
      * potential fallback support, if we ever implement any read flags
      * to pass through to drivers.  For now, there aren't any
      * passthrough flags.  */
-    assert(!(flags & ~(BDRV_REQ_NO_SERIALISING | BDRV_REQ_COPY_ON_READ))=
);
+    assert(!(flags & ~(BDRV_REQ_NO_SERIALISING | BDRV_REQ_COPY_ON_READ |
+                       BDRV_REQ_PREFETCH)));

     /* Handle Copy on Read and associated serialisation */
     if (flags & BDRV_REQ_COPY_ON_READ) {
@@ -1359,7 +1363,9 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChi=
ld *child,
         }

         if (!ret || pnum !=3D bytes) {
-            ret =3D bdrv_co_do_copy_on_readv(child, offset, bytes, qiov)=
;
+            ret =3D bdrv_co_do_copy_on_readv(child, offset, bytes, qiov,=
 flags);
+            goto out;
+        } else if (flags & BDRV_REQ_PREFETCH) {
             goto out;
         }
     }
--=20
2.20.1


