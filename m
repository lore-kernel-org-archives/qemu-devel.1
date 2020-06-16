Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D094C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F1320786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F1320786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlENg-0003z0-Nn
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jlEKN-0004yb-Va; Tue, 16 Jun 2020 12:20:48 -0400
Received: from relay.sw.ru ([185.231.240.75]:43691 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1jlEKJ-0006Zy-7N; Tue, 16 Jun 2020 12:20:47 -0400
Received: from [192.168.15.172] (helo=iris.lishka.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <den@openvz.org>)
 id 1jlEK1-0003Pf-Ew; Tue, 16 Jun 2020 19:20:25 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/5] block, migration: add bdrv_flush_vmstate helper
Date: Tue, 16 Jun 2020 19:20:34 +0300
Message-Id: <20200616162035.29857-5-den@openvz.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616162035.29857-1-den@openvz.org>
References: <20200616162035.29857-1-den@openvz.org>
Received-SPF: pass client-ip=185.231.240.75; envelope-from=den@openvz.org;
 helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 12:20:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Right now bdrv_fclose() is just calling bdrv_flush().

The problem is that migration code is working inefficently from black
layer terms and are frequently called for very small pieces of not
properly aligned data. Block layer is capable to work this way, but
this is very slow.

This patch is a preparation for the introduction of the intermediate
buffer at block driver state. It would be beneficial to separate
conventional bdrv_flush() from closing QEMU file from migration code.

The patch also forces bdrv_flush_vmstate() operation inside
synchronous blk_save_vmstate() operation. This helper is used from
qemu-io only.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Fam Zheng <fam@euphon.net>
CC: Juan Quintela <quintela@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block/block-backend.c |  6 +++++-
 block/io.c            | 15 +++++++++++++++
 include/block/block.h |  3 +++
 migration/savevm.c    |  3 +++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 6936b25c83..3afa0ff7d5 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2177,16 +2177,20 @@ int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size)
 {
-    int ret;
+    int ret, ret2;
 
     if (!blk_is_available(blk)) {
         return -ENOMEDIUM;
     }
 
     ret = bdrv_save_vmstate(blk_bs(blk), buf, pos, size);
+    ret2 = bdrv_flush_vmstate(blk_bs(blk));
     if (ret < 0) {
         return ret;
     }
+    if (ret2 < 0) {
+        return ret2;
+    }
 
     if (ret == size && !blk->enable_write_cache) {
         ret = bdrv_flush(blk_bs(blk));
diff --git a/block/io.c b/block/io.c
index df8f2a98d4..8718df4ea8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2724,6 +2724,21 @@ int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
     return bdrv_rw_vmstate(bs, qiov, pos, true);
 }
 
+static int coroutine_fn bdrv_co_flush_vmstate(BlockDriverState *bs)
+{
+    return 0;
+}
+
+static int coroutine_fn bdrv_flush_vmstate_co_entry(void *opaque)
+{
+    return bdrv_co_flush_vmstate(opaque);
+}
+
+int bdrv_flush_vmstate(BlockDriverState *bs)
+{
+    return bdrv_run_co(bs, bdrv_flush_vmstate_co_entry, bs);
+}
+
 /**************************************************************/
 /* async I/Os */
 
diff --git a/include/block/block.h b/include/block/block.h
index 25e299605e..e532bcffc8 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -572,6 +572,9 @@ int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
 
 int bdrv_load_vmstate(BlockDriverState *bs, uint8_t *buf,
                       int64_t pos, int size);
+/* bdrv_flush_vmstate() is mandatory to commit vmstate changes if
+   bdrv_save_vmstate() was ever called */
+int bdrv_flush_vmstate(BlockDriverState *bs);
 
 void bdrv_img_create(const char *filename, const char *fmt,
                      const char *base_filename, const char *base_fmt,
diff --git a/migration/savevm.c b/migration/savevm.c
index da3dead4e9..d984ce7aa1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -150,6 +150,9 @@ static ssize_t block_get_buffer(void *opaque, uint8_t *buf, int64_t pos,
 
 static int bdrv_fclose(void *opaque, Error **errp)
 {
+    int err = bdrv_flush_vmstate(opaque);
+    if (err < 0)
+        return err;
     return bdrv_flush(opaque);
 }
 
-- 
2.17.1


