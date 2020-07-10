Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47717C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E4C20657
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BJgt/8t5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E4C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvpL-0005cs-9g
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jtvfK-0002vT-Po; Fri, 10 Jul 2020 12:14:22 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:43695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jtvfH-0004vZ-Iz; Fri, 10 Jul 2020 12:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=i3zbC+W1jm5Y+b2qDqKso8xaRYj01unY16Edf1znrLY=; 
 b=BJgt/8t5HPaPgx5HDenFngC5AQIXXtTKeJsFGdKJA/Nf6Ce5I1yGnb+UKYzFvm5j6l+9jhqfufEDwgJd6OZ3sKC88virLnO8W+g7tc6F8rU3025tjXbEfIzBPCiMKTDEuOpue0hx0UDzsZ9XjMyGUDfcBMSPAQS/F/Www4IBk/sqaWDje6S8cx9DfMXah0lm++OyY96wlBfgaTE/3ZvieQEtUc2VvyAPV1qDIMpSi7536lE3xiDafhMmO1okLBXJpEB6eK+Qs+mzUQd+8t5HfWLMwowyOR2Yz3MLrgp+/PJvJvOTaxfxVMCBDrVOyXoMTNGxFUACEI+/oplOZpkK0Q==;
Received: from [81.0.43.0] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jtvea-0003jm-Dy; Fri, 10 Jul 2020 18:13:36 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jtveL-0001Qx-7a; Fri, 10 Jul 2020 18:13:21 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 19/34] qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
Date: Fri, 10 Jul 2020 18:13:01 +0200
Message-Id: <bf09e2e2439a468a901bb96ace411eed9ee50295.1594396418.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1594396418.git.berto@igalia.com>
References: <cover.1594396418.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 12:13:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
index 6fbc73ff19..854a2fbd9b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2064,7 +2064,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     *pnum = bytes;
 
     if ((type == QCOW2_SUBCLUSTER_NORMAL ||
-         type == QCOW2_SUBCLUSTER_ZERO_ALLOC) && !s->crypto) {
+         type == QCOW2_SUBCLUSTER_ZERO_ALLOC ||
+         type == QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC) && !s->crypto) {
         *map = host_offset;
         *file = s->data_file->bs;
         status |= BDRV_BLOCK_OFFSET_VALID;
@@ -2072,7 +2073,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     if (type == QCOW2_SUBCLUSTER_ZERO_PLAIN ||
         type == QCOW2_SUBCLUSTER_ZERO_ALLOC) {
         status |= BDRV_BLOCK_ZERO;
-    } else if (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN) {
+    } else if (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&
+               type != QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC) {
         status |= BDRV_BLOCK_DATA;
     }
     if (s->metadata_preallocation && (status & BDRV_BLOCK_DATA) &&
@@ -2235,6 +2237,7 @@ static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
         g_assert_not_reached();
 
     case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
+    case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
         assert(bs->backing); /* otherwise handled in qcow2_co_preadv_part */
 
         BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
@@ -2303,7 +2306,8 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
 
         if (type == QCOW2_SUBCLUSTER_ZERO_PLAIN ||
             type == QCOW2_SUBCLUSTER_ZERO_ALLOC ||
-            (type == QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN && !bs->backing))
+            (type == QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN && !bs->backing) ||
+            (type == QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC && !bs->backing))
         {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
         } else {
@@ -3858,6 +3862,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         ret = qcow2_get_host_offset(bs, offset, &nr, &off, &type);
         if (ret < 0 ||
             (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&
+             type != QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC &&
              type != QCOW2_SUBCLUSTER_ZERO_PLAIN &&
              type != QCOW2_SUBCLUSTER_ZERO_ALLOC)) {
             qemu_co_mutex_unlock(&s->lock);
@@ -3936,6 +3941,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
 
         switch (type) {
         case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
             if (bs->backing && bs->backing->bs) {
                 int64_t backing_length = bdrv_getlength(bs->backing->bs);
                 if (src_offset >= backing_length) {
-- 
2.20.1


