Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF49C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084DA20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dKHnLWYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084DA20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGqK-0008QL-5j
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGma-0002oF-W7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmZ-0007VK-1O
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:17:40 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmX-0005Yd-Ap; Tue, 17 Mar 2020 14:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=jOIbxftiwi29Ma/CLOJsLFbSYwwFwEOm5EzACtLvpZQ=; 
 b=dKHnLWYDw6smhGytUfXVQJ/TSGK4ZxJiv2MmDAhdVC6KeZeVlzEjhgyke0H1goeP9hNYk4Eyu3zddLjQ4m/VzwVSE9xGxuIjsqhxmfeYKhXDCi+Cn2e2AJVHVFbxMsfsPY4neQ9Wq6mtdRDLwx+3FV3BhfSRnN/6v6GJYzNhI+lcOUdnni3mSTKc5e8t2IxHB3jAHjea8Qf9LxyV/4XQyVXL6esPSsRKmi+cnulJL3sNGOPiZBibpe7t3uzU5zlw0Pf6guRd+XaZ7e9beK5Hmr4W+9AThUt7wTgR2Sm6tez2v/BlXLuAOzDI9g5hAUpHYbg7mMnRmkcErGAc5Vc8lQ==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmD-00014q-33; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006OZ-J9; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/30] qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
Date: Tue, 17 Mar 2020 19:16:13 +0100
Message-Id: <8d7d7287935141177c6a6f92196acc638ea5225b.1584468723.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584468723.git.berto@igalia.com>
References: <cover.1584468723.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When dealing with subcluster types there is a new value called
QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC that has no equivalent in
QCow2ClusterType.

This patch handles that value in all places where subcluster types
are processed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index f8788d6305..88daaf11a0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1992,7 +1992,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     *pnum = bytes;
 
     if ((type == QCOW2_SUBCLUSTER_NORMAL ||
-         type == QCOW2_SUBCLUSTER_ZERO_ALLOC) && !s->crypto) {
+         type == QCOW2_SUBCLUSTER_ZERO_ALLOC ||
+         type == QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC) && !s->crypto) {
         *map = host_offset;
         *file = s->data_file->bs;
         status |= BDRV_BLOCK_OFFSET_VALID;
@@ -2000,7 +2001,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     if (type == QCOW2_SUBCLUSTER_ZERO_PLAIN ||
         type == QCOW2_SUBCLUSTER_ZERO_ALLOC) {
         status |= BDRV_BLOCK_ZERO;
-    } else if (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN) {
+    } else if (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&
+               type != QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC) {
         status |= BDRV_BLOCK_DATA;
     }
     if (s->metadata_preallocation && (status & BDRV_BLOCK_DATA) &&
@@ -2163,6 +2165,7 @@ static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
         g_assert_not_reached();
 
     case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
+    case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
         assert(bs->backing); /* otherwise handled in qcow2_co_preadv_part */
 
         BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
@@ -2231,7 +2234,8 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
 
         if (type == QCOW2_SUBCLUSTER_ZERO_PLAIN ||
             type == QCOW2_SUBCLUSTER_ZERO_ALLOC ||
-            (type == QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN && !bs->backing))
+            (type == QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN && !bs->backing) ||
+            (type == QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC && !bs->backing))
         {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
         } else {
@@ -3740,6 +3744,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         ret = qcow2_get_host_offset(bs, offset, &nr, &off, &type);
         if (ret < 0 ||
             (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&
+             type != QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC &&
              type != QCOW2_SUBCLUSTER_ZERO_PLAIN &&
              type != QCOW2_SUBCLUSTER_ZERO_ALLOC)) {
             qemu_co_mutex_unlock(&s->lock);
@@ -3812,6 +3817,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
 
         switch (type) {
         case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
             if (bs->backing && bs->backing->bs) {
                 int64_t backing_length = bdrv_getlength(bs->backing->bs);
                 if (src_offset >= backing_length) {
-- 
2.20.1


