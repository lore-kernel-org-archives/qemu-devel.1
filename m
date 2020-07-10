Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B17C433EA
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9948206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gI15HNww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9948206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvre-00027h-UE
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jtvfS-0003EZ-03; Fri, 10 Jul 2020 12:14:30 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:43846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jtvfJ-0004w9-KI; Fri, 10 Jul 2020 12:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=m+3OCOC5/GSkJv0QsvUW6R6r3B15ZJKKLGEVM/tHqVA=; 
 b=gI15HNwwzHXwDkVHJyOvtiL49cnKj+GCWnDDujav/ybuYQ/YC6RCsJ6Mdq9JbPnaqGjVi0t0/cEfpj59Ogjj7k3pnzVNThjmpPEI3RXlvRpxH1QnKL0G/2RLf5BsiItQ1iKk7sn3sIjYFd9Km+ItoBuhs+dNt5e01cniK5rSWJpjFKYhwCRfkQsLacMiU5hWlymNhdMqlAyP5A8tErxxCilj8goOf2mUI+0WqTStBo9sey8cXlZLBgDUdHRGjeApJizlvAF7BGlWEIbtqKIchMzLESYyZwcxlAQZytiVMbFmozSXwxBzOm6EwNRsSrmVxtBdkN48y0QneWvf+EyP2w==;
Received: from [81.0.43.0] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jtvea-0003k8-Od; Fri, 10 Jul 2020 18:13:36 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jtveL-0001RT-JC; Fri, 10 Jul 2020 18:13:21 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 30/34] qcow2: Add prealloc field to QCowL2Meta
Date: Fri, 10 Jul 2020 18:13:12 +0200
Message-Id: <960d4c444a4f5a870e2b47e5da322a73cd9a2f5a.1594396418.git.berto@igalia.com>
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

This field allows us to indicate that the L2 metadata update does not
come from a write request with actual data but from a preallocation
request.

For traditional images this does not make any difference, but for
images with extended L2 entries this means that the clusters are
allocated normally in the L2 table but individual subclusters are
marked as unallocated.

This will allow preallocating images that have a backing file.

There is one special case: when we resize an existing image we can
also request that the new clusters are preallocated. If the image
already had a backing file then we have to hide any possible stale
data and zero out the new clusters (see commit 955c7d6687 for more
details).

In this case the subclusters cannot be left as unallocated so the L2
bitmap must be updated.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         | 8 ++++++++
 block/qcow2-cluster.c | 2 +-
 block/qcow2.c         | 6 ++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 4ef4ae4ab0..f3499e53bf 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -463,6 +463,14 @@ typedef struct QCowL2Meta
      */
     bool skip_cow;
 
+    /**
+     * Indicates that this is not a normal write request but a preallocation.
+     * If the image has extended L2 entries this means that no new individual
+     * subclusters will be marked as allocated in the L2 bitmap (but any
+     * existing contents of that bitmap will be kept).
+     */
+    bool prealloc;
+
     /**
      * The I/O vector with the data from the actual guest write request.
      * If non-NULL, this is meant to be merged together with the data
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index e023bc4b01..bbf373ad21 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1067,7 +1067,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
         set_l2_entry(s, l2_slice, l2_index + i, offset | QCOW_OFLAG_COPIED);
 
         /* Update bitmap with the subclusters that were just written */
-        if (has_subclusters(s)) {
+        if (has_subclusters(s) && !m->prealloc) {
             uint64_t l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
             unsigned written_from = m->cow_start.offset;
             unsigned written_to = m->cow_end.offset + m->cow_end.nb_bytes ?:
diff --git a/block/qcow2.c b/block/qcow2.c
index 9ab2a91c8b..8ca0f22069 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2096,6 +2096,7 @@ static coroutine_fn int qcow2_handle_l2meta(BlockDriverState *bs,
         QCowL2Meta *next;
 
         if (link_l2) {
+            assert(!l2meta->prealloc);
             ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
             if (ret) {
                 goto out;
@@ -3130,6 +3131,7 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
 
         while (meta) {
             QCowL2Meta *next = meta->next;
+            meta->prealloc = true;
 
             ret = qcow2_alloc_cluster_link_l2(bs, meta);
             if (ret < 0) {
@@ -4217,6 +4219,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         int64_t clusters_allocated;
         int64_t old_file_size, last_cluster, new_file_size;
         uint64_t nb_new_data_clusters, nb_new_l2_tables;
+        bool subclusters_need_allocation = false;
 
         /* With a data file, preallocation means just allocating the metadata
          * and forwarding the truncate request to the data file */
@@ -4298,6 +4301,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
                                    BDRV_REQ_ZERO_WRITE, NULL);
             if (ret >= 0) {
                 flags &= ~BDRV_REQ_ZERO_WRITE;
+                /* Ensure that we read zeroes and not backing file data */
+                subclusters_need_allocation = true;
             }
         } else {
             ret = -1;
@@ -4336,6 +4341,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
                     .offset       = nb_clusters << s->cluster_bits,
                     .nb_bytes     = 0,
                 },
+                .prealloc     = !subclusters_need_allocation,
             };
             qemu_co_queue_init(&allocation.dependent_requests);
 
-- 
2.20.1


