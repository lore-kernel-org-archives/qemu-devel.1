Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D5C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FF42084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FF42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqwk-0002py-RK
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqtM-0005wq-8V
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqtL-0004BM-7g
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:20 -0400
Received: from relay.sw.ru ([185.231.240.75]:60322)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqtH-00047A-MT; Fri, 11 Oct 2019 05:07:15 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqtE-0000XM-Ke; Fri, 11 Oct 2019 12:07:12 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/5] block/block-backend: add blk_co_pwritev_part
Date: Fri, 11 Oct 2019 12:07:09 +0300
Message-Id: <20191011090711.19940-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011090711.19940-1-vsementsov@virtuozzo.com>
References: <20191011090711.19940-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add blk write function with qiov_offset parameter. It's needed for the
following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/sysemu/block-backend.h |  4 ++++
 block/block-backend.c          | 17 +++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 368d53af77..73f2cef7fe 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -121,6 +121,10 @@ void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *opaque);
 int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
                                unsigned int bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
+int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
+                                     unsigned int bytes,
+                                     QEMUIOVector *qiov, size_t qiov_offset,
+                                     BdrvRequestFlags flags);
 int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
                                unsigned int bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
diff --git a/block/block-backend.c b/block/block-backend.c
index 1c605d5444..b3d00478af 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1176,9 +1176,10 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
     return ret;
 }
 
-int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
-                                unsigned int bytes, QEMUIOVector *qiov,
-                                BdrvRequestFlags flags)
+int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
+                                     unsigned int bytes,
+                                     QEMUIOVector *qiov, size_t qiov_offset,
+                                     BdrvRequestFlags flags)
 {
     int ret;
     BlockDriverState *bs;
@@ -1205,11 +1206,19 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
         flags |= BDRV_REQ_FUA;
     }
 
-    ret = bdrv_co_pwritev(blk->root, offset, bytes, qiov, flags);
+    ret = bdrv_co_pwritev_part(blk->root, offset, bytes, qiov, qiov_offset,
+                               flags);
     bdrv_dec_in_flight(bs);
     return ret;
 }
 
+int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
+                                unsigned int bytes, QEMUIOVector *qiov,
+                                BdrvRequestFlags flags)
+{
+    return blk_co_pwritev_part(blk, offset, bytes, qiov, 0, flags);
+}
+
 typedef struct BlkRwCo {
     BlockBackend *blk;
     int64_t offset;
-- 
2.21.0


