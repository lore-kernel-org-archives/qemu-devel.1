Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEF6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D570B20B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D570B20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMsDN-0006sX-CC
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMsB4-0004Av-Ft
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMsB3-0007hP-7r
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:18:14 -0400
Received: from relay.sw.ru ([185.231.240.75]:51916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iMsB0-0007dl-Hy; Tue, 22 Oct 2019 07:18:10 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iMsAw-0003JX-ER; Tue, 22 Oct 2019 14:18:06 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 1/6] block/block-copy: allocate buffer in
 block_copy_with_bounce_buffer
Date: Tue, 22 Oct 2019 14:18:00 +0300
Message-Id: <20191022111805.3432-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022111805.3432-1-vsementsov@virtuozzo.com>
References: <20191022111805.3432-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move bounce_buffer allocation block_copy_with_bounce_buffer. This
commit simplifies further work on implementing copying by larger chunks
(of different size) and further asynchronous handling of block_copy
iterations (with help of block/aio_task API).

Allocation works fast, a lot faster than disk io, so it's not a problem
that we now allocate/free bounce_buffer more times. And we anyway will
have to allocate several bounce_buffers for parallel execution of loop
iterations in future.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 066e3a7274..ecd086010e 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -126,20 +126,17 @@ void block_copy_set_callbacks(
 static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
                                                       int64_t start,
                                                       int64_t end,
-                                                      bool *error_is_read,
-                                                      void **bounce_buffer)
+                                                      bool *error_is_read)
 {
     int ret;
     int nbytes;
+    void *bounce_buffer = qemu_blockalign(s->source->bs, s->cluster_size);
 
     assert(QEMU_IS_ALIGNED(start, s->cluster_size));
     bdrv_reset_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
     nbytes = MIN(s->cluster_size, s->len - start);
-    if (!*bounce_buffer) {
-        *bounce_buffer = qemu_blockalign(s->source->bs, s->cluster_size);
-    }
 
-    ret = bdrv_co_pread(s->source, start, nbytes, *bounce_buffer, 0);
+    ret = bdrv_co_pread(s->source, start, nbytes, bounce_buffer, 0);
     if (ret < 0) {
         trace_block_copy_with_bounce_buffer_read_fail(s, start, ret);
         if (error_is_read) {
@@ -148,7 +145,7 @@ static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
         goto fail;
     }
 
-    ret = bdrv_co_pwrite(s->target, start, nbytes, *bounce_buffer,
+    ret = bdrv_co_pwrite(s->target, start, nbytes, bounce_buffer,
                          s->write_flags);
     if (ret < 0) {
         trace_block_copy_with_bounce_buffer_write_fail(s, start, ret);
@@ -158,8 +155,11 @@ static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
         goto fail;
     }
 
+    qemu_vfree(bounce_buffer);
+
     return nbytes;
 fail:
+    qemu_vfree(bounce_buffer);
     bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
     return ret;
 
@@ -271,7 +271,6 @@ int coroutine_fn block_copy(BlockCopyState *s,
 {
     int ret = 0;
     int64_t end = bytes + start; /* bytes */
-    void *bounce_buffer = NULL;
     int64_t status_bytes;
     BlockCopyInFlightReq req;
 
@@ -324,7 +323,7 @@ int coroutine_fn block_copy(BlockCopyState *s,
         }
         if (!s->use_copy_range) {
             ret = block_copy_with_bounce_buffer(s, start, dirty_end,
-                                                error_is_read, &bounce_buffer);
+                                                error_is_read);
         }
         if (ret < 0) {
             break;
@@ -335,10 +334,6 @@ int coroutine_fn block_copy(BlockCopyState *s,
         ret = 0;
     }
 
-    if (bounce_buffer) {
-        qemu_vfree(bounce_buffer);
-    }
-
     block_copy_inflight_req_end(&req);
 
     return ret;
-- 
2.21.0


