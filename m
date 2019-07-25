Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E0BC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003D4206B8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003D4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqadi-0006Wp-SK
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49297)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqadN-0005WH-CN
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqadJ-0006QP-QU
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:05:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:45734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqadJ-0006O2-FE; Thu, 25 Jul 2019 06:05:57 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqadC-0001mQ-Tn; Thu, 25 Jul 2019 13:05:50 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 13:05:48 +0300
Message-Id: <20190725100550.33801-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190725100550.33801-1-vsementsov@virtuozzo.com>
References: <20190725100550.33801-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 1/3] block: implement BDRV_REQ_PREFETCH
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do effective copy-on-read request when we don't need data actually. It
will be used for block-stream and NBD_CMD_CACHE.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h |  8 +++++++-
 block/io.c            | 18 ++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 50a07c1c33..73c3fc4daa 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -88,8 +88,14 @@ typedef enum {
      * fallback. */
     BDRV_REQ_NO_FALLBACK        = 0x100,
 
+    /*
+     * BDRV_REQ_PREFETCH may be used only together with BDRV_REQ_COPY_ON_READ
+     * on read request and means that caller don't really need data to be
+     * written to qiov parameter which may be NULL.
+     */
+    BDRV_REQ_PREFETCH  = 0x200,
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x1ff,
+    BDRV_REQ_MASK               = 0x3ff,
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
diff --git a/block/io.c b/block/io.c
index 06305c6ea6..9d99858b55 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1167,7 +1167,8 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 }
 
 static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
-        int64_t offset, unsigned int bytes, QEMUIOVector *qiov)
+        int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+        int flags)
 {
     BlockDriverState *bs = child->bs;
 
@@ -1278,9 +1279,11 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
                 goto err;
             }
 
-            qemu_iovec_from_buf(qiov, progress, bounce_buffer + skip_bytes,
-                                pnum - skip_bytes);
-        } else {
+            if (!(flags & BDRV_REQ_PREFETCH)) {
+                qemu_iovec_from_buf(qiov, progress, bounce_buffer + skip_bytes,
+                                    pnum - skip_bytes);
+            }
+        } else if (!(flags & BDRV_REQ_PREFETCH)) {
             /* Read directly into the destination */
             qemu_iovec_init(&local_qiov, qiov->niov);
             qemu_iovec_concat(&local_qiov, qiov, progress, pnum - skip_bytes);
@@ -1331,7 +1334,8 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
      * potential fallback support, if we ever implement any read flags
      * to pass through to drivers.  For now, there aren't any
      * passthrough flags.  */
-    assert(!(flags & ~(BDRV_REQ_NO_SERIALISING | BDRV_REQ_COPY_ON_READ)));
+    assert(!(flags & ~(BDRV_REQ_NO_SERIALISING | BDRV_REQ_COPY_ON_READ |
+                       BDRV_REQ_PREFETCH)));
 
     /* Handle Copy on Read and associated serialisation */
     if (flags & BDRV_REQ_COPY_ON_READ) {
@@ -1359,7 +1363,9 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         }
 
         if (!ret || pnum != bytes) {
-            ret = bdrv_co_do_copy_on_readv(child, offset, bytes, qiov);
+            ret = bdrv_co_do_copy_on_readv(child, offset, bytes, qiov, flags);
+            goto out;
+        } else if (flags & BDRV_REQ_PREFETCH) {
             goto out;
         }
     }
-- 
2.18.0


