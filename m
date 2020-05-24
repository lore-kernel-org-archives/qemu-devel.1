Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE925C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 15:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43702075F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 15:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GTDGfwrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43702075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcs7a-0001sJ-6Y
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 11:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzz-0002y9-8s; Sun, 24 May 2020 10:53:11 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:37989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzx-0002li-O4; Sun, 24 May 2020 10:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=F0FbtLHp/tFb8Js7vRBObZ35IdcVYY6f5imTzfrCOkM=; 
 b=GTDGfwrNJ3LC8Dd1H02p/fLNkVk+4hn4NrLJFddz5AJjihcG8floh8m35a/o7pgQSCzSTR43x1pgQQDGydIy2IlebH63N5EqkShsKO58x0DHgA6u7ZKcD1/Pt8PGpNsj7iRT7ioatda7YlXfponmDHh1FMFg7Y5GVm7eRMawEGyefARJdjhX9J5f+7j7xcBwthDRZYJ6Wgw3+HoIodmjhT9xQXisRygzwq+5+C5LCk2s/jcKvWKEfZ5fgphqyF1OiY0g6TuFcSKXhOp1EC0+TDsqDo+gEA6xjGtOHPqlgZ/dSMYwf07u7IB4Sh4Nwl/T3lQwBnYvkgSPut7g8rVhgQ==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jcrzF-0007GY-OY; Sun, 24 May 2020 16:52:25 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jcryv-0005Ka-81; Sun, 24 May 2020 16:52:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 19/32] qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
Date: Sun, 24 May 2020 16:51:39 +0200
Message-Id: <713ce0bef5ef711b5defc75539972aae7d0eded2.1590331741.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590331741.git.berto@igalia.com>
References: <cover.1590331741.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 10:52:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Derek Su <dereksu@qnap.com>, Max Reitz <mreitz@redhat.com>
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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 5303b0070b..8126ad8fa0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2054,7 +2054,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     *pnum = bytes;
 
     if ((type == QCOW2_SUBCLUSTER_NORMAL ||
-         type == QCOW2_SUBCLUSTER_ZERO_ALLOC) && !s->crypto) {
+         type == QCOW2_SUBCLUSTER_ZERO_ALLOC ||
+         type == QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC) && !s->crypto) {
         *map = host_offset;
         *file = s->data_file->bs;
         status |= BDRV_BLOCK_OFFSET_VALID;
@@ -2062,7 +2063,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     if (type == QCOW2_SUBCLUSTER_ZERO_PLAIN ||
         type == QCOW2_SUBCLUSTER_ZERO_ALLOC) {
         status |= BDRV_BLOCK_ZERO;
-    } else if (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN) {
+    } else if (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&
+               type != QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC) {
         status |= BDRV_BLOCK_DATA;
     }
     if (s->metadata_preallocation && (status & BDRV_BLOCK_DATA) &&
@@ -2225,6 +2227,7 @@ static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
         g_assert_not_reached();
 
     case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
+    case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
         assert(bs->backing); /* otherwise handled in qcow2_co_preadv_part */
 
         BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
@@ -2293,7 +2296,8 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
 
         if (type == QCOW2_SUBCLUSTER_ZERO_PLAIN ||
             type == QCOW2_SUBCLUSTER_ZERO_ALLOC ||
-            (type == QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN && !bs->backing))
+            (type == QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN && !bs->backing) ||
+            (type == QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC && !bs->backing))
         {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
         } else {
@@ -3865,6 +3869,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         ret = qcow2_get_host_offset(bs, offset, &nr, &off, &type);
         if (ret < 0 ||
             (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&
+             type != QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC &&
              type != QCOW2_SUBCLUSTER_ZERO_PLAIN &&
              type != QCOW2_SUBCLUSTER_ZERO_ALLOC)) {
             qemu_co_mutex_unlock(&s->lock);
@@ -3943,6 +3948,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
 
         switch (type) {
         case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
             if (bs->backing && bs->backing->bs) {
                 int64_t backing_length = bdrv_getlength(bs->backing->bs);
                 if (src_offset >= backing_length) {
-- 
2.20.1


