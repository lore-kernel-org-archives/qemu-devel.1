Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B10C4742C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B352320791
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNcwOMts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B352320791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYb6Y-0000j3-LA
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 16:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYb55-0007Or-Eb
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYb53-0000X9-Jv
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604089980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oEBVNOLK3VgfxIONcRm45nNux8I0osCz7cTnlDCpsoE=;
 b=FNcwOMtsZmGFsigEbOWa3yWUgPBDk+4X+ssTK81QqCX8ey0xdTnjwRB6zwuKl+LX6xDVtN
 fQwb8xRzcrWErvak6wY963vAFTUlzZXzy3U43fnUddA1YjFGsGgoWB81lBy1sxzDO4OT72
 GovBprVZBLo0vA0+WRF4uHMWJFa2yS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-BTVnnAcTO0GIl3IKYr1uLw-1; Fri, 30 Oct 2020 16:32:55 -0400
X-MC-Unique: BTVnnAcTO0GIl3IKYr1uLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44624805EF4;
 Fri, 30 Oct 2020 20:32:54 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-218.phx2.redhat.com [10.3.113.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4C3B19D61;
 Fri, 30 Oct 2020 20:32:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/12] block: Return depth level during
 bdrv_is_allocated_above
Date: Fri, 30 Oct 2020 15:32:29 -0500
Message-Id: <20201030203231.107486-11-eblake@redhat.com>
In-Reply-To: <20201030203231.107486-1-eblake@redhat.com>
References: <20201030203231.107486-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block Jobs" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When checking for allocation across a chain, it's already easy to
count the depth within the chain at which the allocation is found.
Instead of throwing that information away, return it to the caller.
Existing callers only cared about allocated/non-allocated, but having
a depth available will be used by NBD in the next patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20201027050556.269064-9-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[eblake: rebase to master]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/coroutines.h |  6 ++++--
 block/io.c         | 31 +++++++++++++++++++++++--------
 block/commit.c     |  2 +-
 block/mirror.c     |  2 +-
 block/stream.c     |  2 +-
 5 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 1cb3128b942c..4cfb4946e65e 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -47,7 +47,8 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   int64_t bytes,
                                   int64_t *pnum,
                                   int64_t *map,
-                                  BlockDriverState **file);
+                                  BlockDriverState **file,
+                                  int *depth);
 int generated_co_wrapper
 bdrv_common_block_status_above(BlockDriverState *bs,
                                BlockDriverState *base,
@@ -57,7 +58,8 @@ bdrv_common_block_status_above(BlockDriverState *bs,
                                int64_t bytes,
                                int64_t *pnum,
                                int64_t *map,
-                               BlockDriverState **file);
+                               BlockDriverState **file,
+                               int *depth);

 int coroutine_fn bdrv_co_readv_vmstate(BlockDriverState *bs,
                                        QEMUIOVector *qiov, int64_t pos);
diff --git a/block/io.c b/block/io.c
index 9918f2499c19..ec5e152bb70f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2362,20 +2362,28 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   int64_t bytes,
                                   int64_t *pnum,
                                   int64_t *map,
-                                  BlockDriverState **file)
+                                  BlockDriverState **file,
+                                  int *depth)
 {
     int ret;
     BlockDriverState *p;
     int64_t eof = 0;
+    int dummy;

     assert(!include_base || base); /* Can't include NULL base */

+    if (!depth) {
+        depth = &dummy;
+    }
+    *depth = 0;
+
     if (!include_base && bs == base) {
         *pnum = bytes;
         return 0;
     }

     ret = bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, map, file);
+    ++*depth;
     if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED || bs == base) {
         return ret;
     }
@@ -2392,6 +2400,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
+        ++*depth;
         if (ret < 0) {
             return ret;
         }
@@ -2450,7 +2459,7 @@ int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                             int64_t *map, BlockDriverState **file)
 {
     return bdrv_common_block_status_above(bs, base, false, true, offset, bytes,
-                                          pnum, map, file);
+                                          pnum, map, file, NULL);
 }

 int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
@@ -2478,7 +2487,7 @@ int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
     }

     ret = bdrv_common_block_status_above(bs, NULL, false, false, offset,
-                                         bytes, &pnum, NULL, NULL);
+                                         bytes, &pnum, NULL, NULL, NULL);

     if (ret < 0) {
         return ret;
@@ -2495,7 +2504,7 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,

     ret = bdrv_common_block_status_above(bs, bs, true, false, offset,
                                          bytes, pnum ? pnum : &dummy, NULL,
-                                         NULL);
+                                         NULL, NULL);
     if (ret < 0) {
         return ret;
     }
@@ -2505,8 +2514,9 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
 /*
  * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
  *
- * Return 1 if (a prefix of) the given range is allocated in any image
- * between BASE and TOP (BASE is only included if include_base is set).
+ * Return a positive depth if (a prefix of) the given range is allocated
+ * in any image between BASE and TOP (BASE is only included if include_base
+ * is set).  Depth 1 is TOP, 2 is the first backing layer, and so forth.
  * BASE can be NULL to check if the given offset is allocated in any
  * image of the chain.  Return 0 otherwise, or negative errno on
  * failure.
@@ -2523,13 +2533,18 @@ int bdrv_is_allocated_above(BlockDriverState *top,
                             bool include_base, int64_t offset,
                             int64_t bytes, int64_t *pnum)
 {
+    int depth;
     int ret = bdrv_common_block_status_above(top, base, include_base, false,
-                                             offset, bytes, pnum, NULL, NULL);
+                                             offset, bytes, pnum, NULL, NULL,
+                                             &depth);
     if (ret < 0) {
         return ret;
     }

-    return !!(ret & BDRV_BLOCK_ALLOCATED);
+    if (ret & BDRV_BLOCK_ALLOCATED) {
+        return depth;
+    }
+    return 0;
 }

 int coroutine_fn
diff --git a/block/commit.c b/block/commit.c
index 1e85c306cc41..71db7ba7472e 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -156,7 +156,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
         /* Copy if allocated above the base */
         ret = bdrv_is_allocated_above(blk_bs(s->top), s->base_overlay, true,
                                       offset, COMMIT_BUFFER_SIZE, &n);
-        copy = (ret == 1);
+        copy = (ret > 0);
         trace_commit_one_iteration(s, offset, n, ret);
         if (copy) {
             assert(n < SIZE_MAX);
diff --git a/block/mirror.c b/block/mirror.c
index 26acf4af6fb7..8e1ad6eceb57 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -846,7 +846,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         }

         assert(count);
-        if (ret == 1) {
+        if (ret > 0) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, offset, count);
         }
         offset += count;
diff --git a/block/stream.c b/block/stream.c
index 8ce6729a33da..236384f2f739 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -167,7 +167,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
                 n = len - offset;
             }

-            copy = (ret == 1);
+            copy = (ret > 0);
         }
         trace_stream_one_iteration(s, offset, n, ret);
         if (copy) {
-- 
2.29.2


