Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3524C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3E120857
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nrrav72j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3E120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joU7a-0000ot-Ji
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTjJ-0006sq-Tk
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46506
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTjF-0001Rr-KX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JioenUdI+5OpAM119kCaxHuOngeUa/Dn7gYWfjNr8I=;
 b=Nrrav72jjFjzVWLLdDdt9qyCL1ao8g9+phBKfSC9Wkw98YQuxzZGAONANOHH/LpvZl4Oyr
 plc4LTbhnR/IEFMmuW/f3pa5FJlHL0s6yAgsxxLioRaAtZEf0PgA7+dvgvfk6tJj4/tjrD
 fA1HMIH2StScBgVxtZFTm1wXdAu872Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-y8TOBTMcNHOsiT4S7L5t7g-1; Thu, 25 Jun 2020 11:23:48 -0400
X-MC-Unique: y8TOBTMcNHOsiT4S7L5t7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 492951005513;
 Thu, 25 Jun 2020 15:23:47 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B03562B4A8;
 Thu, 25 Jun 2020 15:23:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 40/47] block: Inline bdrv_co_block_status_from_*()
Date: Thu, 25 Jun 2020 17:22:08 +0200
Message-Id: <20200625152215.941773-41-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With bdrv_filter_bs(), we can easily handle this default filter behavior
in bdrv_co_block_status().

blkdebug wants to have an additional assertion, so it keeps its own
implementation, except bdrv_co_block_status_from_file() needs to be
inlined there.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 23 ------------------
 block/backup-top.c        |  2 --
 block/blkdebug.c          |  7 ++++--
 block/blklogwrites.c      |  1 -
 block/commit.c            |  1 -
 block/copy-on-read.c      |  2 --
 block/filter-compress.c   |  2 --
 block/io.c                | 51 +++++++++++++--------------------------
 block/mirror.c            |  1 -
 block/throttle.c          |  1 -
 10 files changed, 22 insertions(+), 69 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6e09e15ed4..e5a328c389 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1291,29 +1291,6 @@ void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
                         uint64_t perm, uint64_t shared,
                         uint64_t *nperm, uint64_t *nshared);
 
-/*
- * Default implementation for drivers to pass bdrv_co_block_status() to
- * their file.
- */
-int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
-                                                bool want_zero,
-                                                int64_t offset,
-                                                int64_t bytes,
-                                                int64_t *pnum,
-                                                int64_t *map,
-                                                BlockDriverState **file);
-/*
- * Default implementation for drivers to pass bdrv_co_block_status() to
- * their backing file.
- */
-int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
-                                                   bool want_zero,
-                                                   int64_t offset,
-                                                   int64_t bytes,
-                                                   int64_t *pnum,
-                                                   int64_t *map,
-                                                   BlockDriverState **file);
-
 int64_t bdrv_sum_allocated_file_size(BlockDriverState *bs);
 int64_t bdrv_primary_allocated_file_size(BlockDriverState *bs);
 int64_t bdrv_notsup_allocated_file_size(BlockDriverState *bs);
diff --git a/block/backup-top.c b/block/backup-top.c
index 89bd3937d0..bf5fc22fc7 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -185,8 +185,6 @@ BlockDriver bdrv_backup_top_filter = {
     .bdrv_co_pwritev_compressed = backup_top_co_pwritev_compressed,
     .bdrv_co_flush              = backup_top_co_flush,
 
-    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
-
     .bdrv_refresh_filename      = backup_top_refresh_filename,
 
     .bdrv_child_perm            = backup_top_child_perm,
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 7194bc7f06..cf78d8809e 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -757,8 +757,11 @@ static int coroutine_fn blkdebug_co_block_status(BlockDriverState *bs,
         return err;
     }
 
-    return bdrv_co_block_status_from_file(bs, want_zero, offset, bytes,
-                                          pnum, map, file);
+    assert(bs->file && bs->file->bs);
+    *pnum = bytes;
+    *map = offset;
+    *file = bs->file->bs;
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
 }
 
 static void blkdebug_close(BlockDriverState *bs)
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 6753bd9a3e..c6b2711fe5 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -517,7 +517,6 @@ static BlockDriver bdrv_blk_log_writes = {
     .bdrv_co_pwrite_zeroes  = blk_log_writes_co_pwrite_zeroes,
     .bdrv_co_flush_to_disk  = blk_log_writes_co_flush_to_disk,
     .bdrv_co_pdiscard       = blk_log_writes_co_pdiscard,
-    .bdrv_co_block_status   = bdrv_co_block_status_from_file,
 
     .is_filter              = true,
     .strong_runtime_opts    = blk_log_writes_strong_runtime_opts,
diff --git a/block/commit.c b/block/commit.c
index 4122b6736d..ea9282daea 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -238,7 +238,6 @@ static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
 static BlockDriver bdrv_commit_top = {
     .format_name                = "commit_top",
     .bdrv_co_preadv             = bdrv_commit_top_preadv,
-    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
     .bdrv_child_perm            = bdrv_commit_top_child_perm,
 
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index a6a864f147..2816e61afe 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -146,8 +146,6 @@ static BlockDriver bdrv_copy_on_read = {
     .bdrv_eject                         = cor_eject,
     .bdrv_lock_medium                   = cor_lock_medium,
 
-    .bdrv_co_block_status               = bdrv_co_block_status_from_file,
-
     .has_variable_length                = true,
     .is_filter                          = true,
 };
diff --git a/block/filter-compress.c b/block/filter-compress.c
index 8ec1991c1f..5136371bf8 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -146,8 +146,6 @@ static BlockDriver bdrv_compress = {
     .bdrv_eject                         = compress_eject,
     .bdrv_lock_medium                   = compress_lock_medium,
 
-    .bdrv_co_block_status               = bdrv_co_block_status_from_file,
-
     .has_variable_length                = true,
     .is_filter                          = true,
 };
diff --git a/block/io.c b/block/io.c
index 9e802804bb..e2196d438c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2253,36 +2253,6 @@ typedef struct BdrvCoBlockStatusData {
     BlockDriverState **file;
 } BdrvCoBlockStatusData;
 
-int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
-                                                bool want_zero,
-                                                int64_t offset,
-                                                int64_t bytes,
-                                                int64_t *pnum,
-                                                int64_t *map,
-                                                BlockDriverState **file)
-{
-    assert(bs->file && bs->file->bs);
-    *pnum = bytes;
-    *map = offset;
-    *file = bs->file->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
-}
-
-int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
-                                                   bool want_zero,
-                                                   int64_t offset,
-                                                   int64_t bytes,
-                                                   int64_t *pnum,
-                                                   int64_t *map,
-                                                   BlockDriverState **file)
-{
-    assert(bs->backing && bs->backing->bs);
-    *pnum = bytes;
-    *map = offset;
-    *file = bs->backing->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
-}
-
 /*
  * Returns the allocation status of the specified sectors.
  * Drivers not implementing the functionality are assumed to not support
@@ -2323,6 +2293,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     BlockDriverState *local_file = NULL;
     int64_t aligned_offset, aligned_bytes;
     uint32_t align;
+    bool has_filtered_child;
 
     assert(pnum);
     *pnum = 0;
@@ -2348,7 +2319,8 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
 
     /* Must be non-NULL or bdrv_getlength() would have failed */
     assert(bs->drv);
-    if (!bs->drv->bdrv_co_block_status) {
+    has_filtered_child = bdrv_filter_child(bs);
+    if (!bs->drv->bdrv_co_block_status && !has_filtered_child) {
         *pnum = bytes;
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
         if (offset + bytes == total_size) {
@@ -2369,9 +2341,20 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     aligned_offset = QEMU_ALIGN_DOWN(offset, align);
     aligned_bytes = ROUND_UP(offset + bytes, align) - aligned_offset;
 
-    ret = bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
-                                        aligned_bytes, pnum, &local_map,
-                                        &local_file);
+    if (bs->drv->bdrv_co_block_status) {
+        ret = bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
+                                            aligned_bytes, pnum, &local_map,
+                                            &local_file);
+    } else {
+        /* Default code for filters */
+
+        local_file = bdrv_filter_bs(bs);
+        assert(local_file);
+
+        *pnum = aligned_bytes;
+        local_map = aligned_offset;
+        ret = BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
+    }
     if (ret < 0) {
         *pnum = 0;
         goto out;
diff --git a/block/mirror.c b/block/mirror.c
index 770de3b34e..5a9e42e488 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1541,7 +1541,6 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
     .bdrv_co_pwritev_compressed = bdrv_mirror_top_pwritev_compressed,
     .bdrv_co_flush              = bdrv_mirror_top_flush,
-    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
 
diff --git a/block/throttle.c b/block/throttle.c
index f6e619aca2..473ea758df 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -263,7 +263,6 @@ static BlockDriver bdrv_throttle = {
     .bdrv_reopen_prepare                =   throttle_reopen_prepare,
     .bdrv_reopen_commit                 =   throttle_reopen_commit,
     .bdrv_reopen_abort                  =   throttle_reopen_abort,
-    .bdrv_co_block_status               =   bdrv_co_block_status_from_file,
 
     .bdrv_co_drain_begin                =   throttle_co_drain_begin,
     .bdrv_co_drain_end                  =   throttle_co_drain_end,
-- 
2.26.2


