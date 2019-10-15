Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A37C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B13F20854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B13F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKRTH-00088i-NP
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 14:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKRR6-0005oM-6G
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 14:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKRR4-0001Su-T0
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 14:20:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:35020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iKRR4-0001RH-LQ; Tue, 15 Oct 2019 14:20:42 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iKRQz-0003ry-6u; Tue, 15 Oct 2019 21:20:37 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v3 4/5] block-stream: add compress option
Date: Tue, 15 Oct 2019 21:20:24 +0300
Message-Id: <1571163625-642312-5-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571163625-642312-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1571163625-642312-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow data compression during block-stream job for backup backing chain.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c | 10 ++++++++--
 blockdev.c     | 12 +++++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 5562ccb..25f9324 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -41,10 +41,16 @@ typedef struct StreamBlockJob {
 static int coroutine_fn stream_populate(BlockBackend *blk,
                                         int64_t offset, uint64_t bytes)
 {
+    BlockDriverState *bs = blk_bs(blk);
+    int flags = BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH;
+
+    if (bs->all_write_compressed) {
+        flags |= BDRV_REQ_WRITE_COMPRESSED;
+    }
+
     assert(bytes < SIZE_MAX);
 
-    return blk_co_preadv(blk, offset, bytes, NULL,
-                         BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
+    return blk_co_preadv(blk, offset, bytes, NULL, flags);
 }
 
 static void stream_abort(Job *job)
diff --git a/blockdev.c b/blockdev.c
index 2103730..fd824da 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -471,7 +471,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
     int bdrv_flags = 0;
     int on_read_error, on_write_error;
     bool account_invalid, account_failed;
-    bool writethrough, read_only;
+    bool writethrough, read_only, compress;
     BlockBackend *blk;
     BlockDriverState *bs;
     ThrottleConfig cfg;
@@ -570,6 +570,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
     }
 
     read_only = qemu_opt_get_bool(opts, BDRV_OPT_READ_ONLY, false);
+    compress = qemu_opt_get_bool(opts, BDRV_OPT_COMPRESS, false);
 
     /* init */
     if ((!file || !*file) && !qdict_size(bs_opts)) {
@@ -595,6 +596,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
         qdict_set_default_str(bs_opts, BDRV_OPT_READ_ONLY,
                               read_only ? "on" : "off");
         qdict_set_default_str(bs_opts, BDRV_OPT_AUTO_READ_ONLY, "on");
+        qdict_set_default_str(bs_opts, BDRV_OPT_COMPRESS,
+                              compress ? "on" : "off");
         assert((bdrv_flags & BDRV_O_CACHE_MASK) == 0);
 
         if (runstate_check(RUN_STATE_INMIGRATE)) {
@@ -3308,6 +3311,13 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         goto out;
     }
 
+    if (bs->all_write_compressed &&
+        bs->drv->bdrv_co_pwritev_compressed_part == NULL) {
+        error_setg(errp, "Compression is not supported for this drive %s",
+                   bdrv_get_device_name(bs));
+        goto out;
+    }
+
     /* backing_file string overrides base bs filename */
     base_name = has_backing_file ? backing_file : base_name;
 
-- 
1.8.3.1


