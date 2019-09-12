Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E36C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE972081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE972081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Qpa-0003pw-BQ
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 11:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8Qn5-00024y-83
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8Qn3-00036S-8B
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:13:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:57858)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8Qmz-00034B-SZ; Thu, 12 Sep 2019 11:13:42 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8Qmw-0000kk-Tj; Thu, 12 Sep 2019 18:13:39 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 18:13:36 +0300
Message-Id: <20190912151338.21225-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912151338.21225-1-vsementsov@virtuozzo.com>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 2/4] block/block-backend: add
 blk_co_pwritev_part
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add blk write function with qiov_offset parameter. It's needed for the
following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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


