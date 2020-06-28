Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545E9C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 11:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E62A208C7
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 11:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HYO1DwDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E62A208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpVCg-00016a-Ad
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 07:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jpV6O-0007Oa-WD; Sun, 28 Jun 2020 07:04:01 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jpV6J-0000X9-9t; Sun, 28 Jun 2020 07:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=JEa0mBV8UvnDyp5H8sfvCfcFuf5ZD0l+4WnlR2HdDiw=; 
 b=HYO1DwDWI9/BcpLvCFhlw23z0zZghXW34SqvfsdoVmV3/2+go/ca9JyVl05IcE4WEMpAQOsEnsniEkYF4y+NmRXUgK/T2p3MH3Lw6ykYDqRoE8Hk2TPMuWYo4q1E41YTAGaNgh48+woQyISYQFgITgR9HeAtZ0GFlU8yZ5nUIC3AA4qYpKIW7QibpKQh3AtWHMBb/q1BHV3JBDQVEMNNNtMXJU9HByUOdAOFUKjcl1XYCpnKm5FPDUXVx02rRohQQGi6kzWegRKjZuT+9h7lmq61cmBRzUsqk7Hrp5oXlje5urHq1FawPRIR94XbmeWsUTJO/VhnJgJ3c1EB10iDnw==;
Received: from 26.red-79-158-236.dynamicip.rima-tde.net ([79.158.236.26]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jpV5Y-0002gf-6Y; Sun, 28 Jun 2020 13:03:09 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jpV5I-00038j-1N; Sun, 28 Jun 2020 13:02:52 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 19/34] qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
Date: Sun, 28 Jun 2020 13:02:28 +0200
Message-Id: <220b64fa73ba1ab4eb94f2a68cd4df79e5a5cdd8.1593342067.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1593342067.git.berto@igalia.com>
References: <cover.1593342067.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 07:03:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
index 2f7a2a7c7a..a3481cd85b 100644
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


