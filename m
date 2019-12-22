Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881CEC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 11:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BAA2070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 11:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dVnN2wMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BAA2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiznV-0001zt-8n
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 06:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iizZ8-0003Ls-Vm
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iizZ7-0006o0-Me
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:30 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:34967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iizZ7-0004Un-9Q; Sun, 22 Dec 2019 06:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=i05ULFbw66+cnut3ZhVJxSLNIOEckOUgveo/uLuVGKE=; 
 b=dVnN2wMQWmCdO0Aok2hl/6IF2q27sfq7aRm48rqtg6Cjp1jmEcg2MSX+3aX2gPpJidbfbRI3XOq2sVa+hRWCY/qVGavottWpy9x9y3djcsnYcUnFa4/H1hJ/kBnHevLy6QY4X0bVneYnP9w7qHXaBiFdzcTBtVsH16aJrvBk6ZjsYB5Yidkaslb8axlXFl8bvFwU5xer4U9sS3s1dbtgasb70Pohl8qjASJnOB58zbw1pVntvIROUjCMJczOgQV9Wz+WV4Tmqnzjbn6R1gM8rETJQRUkmRTyYYP2ib+BZ7gRpNbCzFo6/yqHd6llIgKmYlxUzMqmGocQgomQ+js23Q==;
Received: from [80.30.182.172] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iizYU-0005dF-OV; Sun, 22 Dec 2019 12:37:51 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iizXu-0001Vs-K3; Sun, 22 Dec 2019 12:37:14 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 13/27] qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
Date: Sun, 22 Dec 2019 12:36:54 +0100
Message-Id: <6b6c430112937f628d91fe085121c09d23dece24.1577014346.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1577014346.git.berto@igalia.com>
References: <cover.1577014346.git.berto@igalia.com>
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
---
 block/qcow2.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 9277d680ef..1d3da0ccf6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1985,7 +1985,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     *pnum = bytes;
 
     if ((type == QCOW2_SUBCLUSTER_NORMAL ||
-         type == QCOW2_SUBCLUSTER_ZERO_ALLOC) && !s->crypto) {
+         type == QCOW2_SUBCLUSTER_ZERO_ALLOC ||
+         type == QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC) && !s->crypto) {
         *map = cluster_offset | offset_into_cluster(s, offset);
         *file = s->data_file->bs;
         status |= BDRV_BLOCK_OFFSET_VALID;
@@ -1993,7 +1994,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
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
@@ -2236,7 +2239,8 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
 
         if (type == QCOW2_SUBCLUSTER_ZERO_PLAIN ||
             type == QCOW2_SUBCLUSTER_ZERO_ALLOC ||
-            (type == QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN && !bs->backing))
+            (type == QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN && !bs->backing) ||
+            (type == QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC && !bs->backing))
         {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
         } else {
@@ -3750,6 +3754,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
             return -ENOTSUP;
         }
         if (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&
+            type != QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC &&
             type != QCOW2_SUBCLUSTER_ZERO_PLAIN &&
             type != QCOW2_SUBCLUSTER_ZERO_ALLOC) {
             qemu_co_mutex_unlock(&s->lock);
@@ -3822,6 +3827,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
 
         switch (type) {
         case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
             if (bs->backing && bs->backing->bs) {
                 int64_t backing_length = bdrv_getlength(bs->backing->bs);
                 if (src_offset >= backing_length) {
-- 
2.20.1


