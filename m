Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CCCC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CC52086A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CC52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8hyi-00070N-2r
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 05:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j8hxV-0004WR-Hs
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j8hxU-0007lh-CN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:05:57 -0500
Received: from relay.sw.ru ([185.231.240.75]:48176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j8hxR-0007jM-S7; Mon, 02 Mar 2020 05:05:54 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j8hxI-000350-77; Mon, 02 Mar 2020 13:05:44 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/5] block: add max_pwrite_zeroes_no_fallback to BlockLimits
Date: Mon,  2 Mar 2020 13:05:35 +0300
Message-Id: <20200302100537.29058-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200302100537.29058-1-vsementsov@virtuozzo.com>
References: <20200302100537.29058-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

NBD spec is updated, so that max_block doesn't relate to
NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which mirrors Qemu
flag BDRV_REQ_NO_FALLBACK). To drop the restriction we need new
max_pwrite_zeroes_no_fallback.

Default value of new max_pwrite_zeroes_no_fallback is zero and it means
no-restriction, so we are automatically done by this commit. Note that
nbd and blkdebug are the only drivers which in the same time define
max_pwrite_zeroes limit and support BDRV_REQ_NO_FALLBACK, so we need to
update only blkdebug.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h | 8 ++++++++
 block/blkdebug.c          | 7 ++++++-
 block/io.c                | 4 +++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6f9fd5e20e..c167e887c6 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -618,6 +618,14 @@ typedef struct BlockLimits {
      * pwrite_zeroes_alignment. May be 0 if no inherent 32-bit limit */
     int32_t max_pwrite_zeroes;
 
+    /*
+     * Maximum number of bytes that can zeroized at once if flag
+     * BDRV_REQ_NO_FALLBACK specified (since it is signed, it must be < 2G, if
+     * set). Must be multiple of pwrite_zeroes_alignment. May be 0 if no
+     * inherent 32-bit limit.
+     */
+    int32_t max_pwrite_zeroes_no_fallback;
+
     /* Optimal alignment for write zeroes requests in bytes. A power
      * of 2 is best but not mandatory.  Must be a multiple of
      * bl.request_alignment, and must be less than max_pwrite_zeroes
diff --git a/block/blkdebug.c b/block/blkdebug.c
index af44aa973f..7627fbcb3b 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -692,7 +692,11 @@ static int coroutine_fn blkdebug_co_pwrite_zeroes(BlockDriverState *bs,
     }
     assert(QEMU_IS_ALIGNED(offset, align));
     assert(QEMU_IS_ALIGNED(bytes, align));
-    if (bs->bl.max_pwrite_zeroes) {
+    if ((flags & BDRV_REQ_NO_FALLBACK) &&
+        bs->bl.max_pwrite_zeroes_no_fallback)
+    {
+        assert(bytes <= bs->bl.max_pwrite_zeroes_no_fallback);
+    } else if (bs->bl.max_pwrite_zeroes) {
         assert(bytes <= bs->bl.max_pwrite_zeroes);
     }
 
@@ -977,6 +981,7 @@ static void blkdebug_refresh_limits(BlockDriverState *bs, Error **errp)
     }
     if (s->max_write_zero) {
         bs->bl.max_pwrite_zeroes = s->max_write_zero;
+        bs->bl.max_pwrite_zeroes_no_fallback = s->max_write_zero;
     }
     if (s->opt_discard) {
         bs->bl.pdiscard_alignment = s->opt_discard;
diff --git a/block/io.c b/block/io.c
index 7e4cb74cf4..75fd5600c2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1752,7 +1752,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int head = 0;
     int tail = 0;
 
-    int max_write_zeroes = MIN_NON_ZERO(bs->bl.max_pwrite_zeroes, INT_MAX);
+    int max_write_zeroes = MIN_NON_ZERO((flags & BDRV_REQ_NO_FALLBACK) ?
+                                        bs->bl.max_pwrite_zeroes_no_fallback :
+                                        bs->bl.max_pwrite_zeroes, INT_MAX);
     int alignment = MAX(bs->bl.pwrite_zeroes_alignment,
                         bs->bl.request_alignment);
     int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFFER);
-- 
2.21.0


