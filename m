Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABF4CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306C720863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sImEZbbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306C720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUa4-00008Y-CP
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTZw-0000XU-NX
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZv-0005RY-Fh
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:32 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZu-0005F0-V9; Sat, 26 Oct 2019 17:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=+xwWu6J6i01LK6MbAXCYF+RWfBl8802Gr2qymDso1KI=; 
 b=sImEZbbkG53YVA24MupgydUL/6GJXz+Ca4xJ6MscYNtSKHSXAL3pxMmJn8//EKvgNAxKOaoskeSu4xzKrGgfc6IOZHtqHBEIYW7UXlkrPudASGMZPeVeoW13Di7inx8i2pKEDiWm8XkjS++AALBdxN0ft4oiIoY+2+WhYq8IA9E8N4DJAFeyRYJ9+FPUcZDDNHcwngsNL5UBjKpv8a2pXR4zLqUwCzlcDQgwy9eaErpe5zcwyi+qFy0NL8AjAsegqdMts32MYo8nq+BTI6jdYWNYPvOU5TGOEqZUdRn5XZuJ2ZTGvRq33qSDtzmPVkqmOjqlPq50z5smdIR6TfXp+g==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZI-00045y-OF; Sat, 26 Oct 2019 23:25:52 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ0-0001PP-IW; Sun, 27 Oct 2019 00:25:34 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 12/26] qcow2: Handle
 QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER
Date: Sun, 27 Oct 2019 00:25:14 +0300
Message-Id: <2a6b34635cac78e76150a72c69669b3d9ec0fb8c.1572125022.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1572125022.git.berto@igalia.com>
References: <cover.1572125022.git.berto@igalia.com>
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

In the previous patch we added a new QCow2ClusterType named
QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER. There is a couple of places
where this new value needs to be handled, and that is what this patch
does.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ab40ae36ea..0261e87709 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1938,8 +1938,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
 
     *pnum = bytes;
 
-    if ((ret == QCOW2_CLUSTER_NORMAL || ret == QCOW2_CLUSTER_ZERO_ALLOC) &&
-        !s->crypto) {
+    if ((ret == QCOW2_CLUSTER_NORMAL || ret == QCOW2_CLUSTER_ZERO_ALLOC ||
+         ret == QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER) && !s->crypto) {
         index_in_cluster = offset & (s->cluster_size - 1);
         *map = cluster_offset | index_in_cluster;
         *file = s->data_file->bs;
@@ -1947,7 +1947,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     }
     if (ret == QCOW2_CLUSTER_ZERO_PLAIN || ret == QCOW2_CLUSTER_ZERO_ALLOC) {
         status |= BDRV_BLOCK_ZERO;
-    } else if (ret != QCOW2_CLUSTER_UNALLOCATED) {
+    } else if (ret != QCOW2_CLUSTER_UNALLOCATED &&
+               ret != QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER) {
         status |= BDRV_BLOCK_DATA;
     }
     if (s->metadata_preallocation && (status & BDRV_BLOCK_DATA) &&
@@ -2117,6 +2118,7 @@ static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
         g_assert_not_reached();
 
     case QCOW2_CLUSTER_UNALLOCATED:
+    case QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER:
         assert(bs->backing); /* otherwise handled in qcow2_co_preadv_part */
 
         BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
@@ -2187,7 +2189,8 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
 
         if (ret == QCOW2_CLUSTER_ZERO_PLAIN ||
             ret == QCOW2_CLUSTER_ZERO_ALLOC ||
-            (ret == QCOW2_CLUSTER_UNALLOCATED && !bs->backing))
+            (ret == QCOW2_CLUSTER_UNALLOCATED && !bs->backing) ||
+            (ret == QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER && !bs->backing))
         {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
         } else {
@@ -3701,6 +3704,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         nr = s->cluster_size;
         ret = qcow2_get_cluster_offset(bs, offset, &nr, &off);
         if (ret != QCOW2_CLUSTER_UNALLOCATED &&
+            ret != QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER &&
             ret != QCOW2_CLUSTER_ZERO_PLAIN &&
             ret != QCOW2_CLUSTER_ZERO_ALLOC) {
             qemu_co_mutex_unlock(&s->lock);
@@ -3771,6 +3775,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
 
         switch (ret) {
         case QCOW2_CLUSTER_UNALLOCATED:
+        case QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER:
             if (bs->backing && bs->backing->bs) {
                 int64_t backing_length = bdrv_getlength(bs->backing->bs);
                 if (src_offset >= backing_length) {
-- 
2.20.1


