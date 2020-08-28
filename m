Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B53C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF722074A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF722074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhfq-0006fi-45
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 12:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBhex-0004zQ-2v; Fri, 28 Aug 2020 12:55:27 -0400
Received: from relay.sw.ru ([185.231.240.75]:38086 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBhev-0001TZ-GJ; Fri, 28 Aug 2020 12:55:26 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBheR-001XPR-6Z; Fri, 28 Aug 2020 19:54:55 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, jsnow@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com
Subject: [PATCH v8 5/7] copy-on-read: limit guest writes to base in COR driver
Date: Fri, 28 Aug 2020 19:52:57 +0300
Message-Id: <1598633579-221780-6-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 12:53:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich via <qemu-devel@nongnu.org>

Limit the guest's COR operations by the base node in the backing chain
during a stream job.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/copy-on-read.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 1f858bb..ecbd1f8 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -57,6 +57,37 @@ static BlockDriverState *get_base_by_name(BlockDriverState *bs,
     return base_bs;
 }
 
+/*
+ * Returns 1 if the block is allocated in a node between cor_filter_bs->file->bs
+ * and the base_bs in the backing chain. Otherwise, returns 0.
+ * The COR operation is allowed if the base_bs is not specified - return 1.
+ * Returns negative errno on failure.
+ */
+static int node_above_base(BlockDriverState *cor_filter_bs, uint64_t offset,
+                           uint64_t bytes)
+{
+    int ret;
+    int64_t dummy;
+    BlockDriverState *file = NULL;
+    BDRVStateCOR *state = cor_filter_bs->opaque;
+
+    if (!state->base_bs) {
+        return 1;
+    }
+
+    ret = bdrv_block_status_above(cor_filter_bs->file->bs, state->base_bs,
+                                  offset, bytes, &dummy, NULL, &file);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (file) {
+        return 1;
+    }
+
+    return 0;
+}
+
 static int cor_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
@@ -153,6 +184,12 @@ static int coroutine_fn cor_co_pwritev_part(BlockDriverState *bs,
                                             QEMUIOVector *qiov,
                                             size_t qiov_offset, int flags)
 {
+    int ret = node_above_base(bs, offset, bytes);
+
+    if (!ret || ret < 0) {
+        return ret;
+    }
+
     return bdrv_co_pwritev_part(bs->file, offset, bytes, qiov, qiov_offset,
                                 flags);
 }
@@ -162,6 +199,12 @@ static int coroutine_fn cor_co_pwrite_zeroes(BlockDriverState *bs,
                                              int64_t offset, int bytes,
                                              BdrvRequestFlags flags)
 {
+    int ret = node_above_base(bs, offset, bytes);
+
+    if (!ret || ret < 0) {
+        return ret;
+    }
+
     return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
 }
 
@@ -178,6 +221,12 @@ static int coroutine_fn cor_co_pwritev_compressed(BlockDriverState *bs,
                                                   uint64_t bytes,
                                                   QEMUIOVector *qiov)
 {
+    int ret = node_above_base(bs, offset, bytes);
+
+    if (!ret || ret < 0) {
+        return ret;
+    }
+
     return bdrv_co_pwritev(bs->file, offset, bytes, qiov,
                            BDRV_REQ_WRITE_COMPRESSED);
 }
-- 
1.8.3.1


