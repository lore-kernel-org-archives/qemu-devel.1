Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58020C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306A1206B8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306A1206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqae4-00085Z-8c
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49296)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqadN-0005WG-CF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqadJ-0006Q6-Mj
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:05:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:45720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqadI-0006O1-7y; Thu, 25 Jul 2019 06:05:57 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqadC-0001mQ-Vy; Thu, 25 Jul 2019 13:05:51 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 13:05:49 +0300
Message-Id: <20190725100550.33801-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190725100550.33801-1-vsementsov@virtuozzo.com>
References: <20190725100550.33801-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 2/3] block/stream: use BDRV_REQ_PREFETCH
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
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This helps to avoid extra io, allocations and memory copying.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/stream.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 6ac1e7bec4..170e3b43be 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -22,11 +22,11 @@
 
 enum {
     /*
-     * Size of data buffer for populating the image file.  This should be large
+     * Maximum chunk size to feed it to copy-on-read.  This should be large
      * enough to process multiple clusters in a single call, so that populating
      * contiguous regions of the image is efficient.
      */
-    STREAM_BUFFER_SIZE = 512 * 1024, /* in bytes */
+    STREAM_CHUNK = 512 * 1024, /* in bytes */
 };
 
 typedef struct StreamBlockJob {
@@ -39,13 +39,12 @@ typedef struct StreamBlockJob {
 } StreamBlockJob;
 
 static int coroutine_fn stream_populate(BlockBackend *blk,
-                                        int64_t offset, uint64_t bytes,
-                                        void *buf)
+                                        int64_t offset, uint64_t bytes)
 {
     assert(bytes < SIZE_MAX);
 
-    /* Copy-on-read the unallocated clusters */
-    return blk_co_pread(blk, offset, bytes, buf, BDRV_REQ_COPY_ON_READ);
+    return blk_co_preadv(blk, offset, bytes, NULL,
+                         BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
 }
 
 static void stream_abort(Job *job)
@@ -117,7 +116,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     int error = 0;
     int ret = 0;
     int64_t n = 0; /* bytes */
-    void *buf;
 
     if (bs == s->bottom) {
         /* Nothing to stream */
@@ -130,8 +128,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     }
     job_progress_set_remaining(&s->common.job, len);
 
-    buf = qemu_blockalign(bs, STREAM_BUFFER_SIZE);
-
     /* Turn on copy-on-read for the whole block device so that guest read
      * requests help us make progress.  Only do this when copying the entire
      * backing chain since the copy-on-read operation does not take base into
@@ -154,7 +150,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
 
         copy = false;
 
-        ret = bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &n);
+        ret = bdrv_is_allocated(bs, offset, STREAM_CHUNK, &n);
         if (ret == 1) {
             /* Allocated in the top, no need to copy.  */
         } else if (ret >= 0) {
@@ -171,7 +167,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         }
         trace_stream_one_iteration(s, offset, n, ret);
         if (copy) {
-            ret = stream_populate(blk, offset, n, buf);
+            ret = stream_populate(blk, offset, n);
         }
         if (ret < 0) {
             BlockErrorAction action =
@@ -202,8 +198,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         bdrv_disable_copy_on_read(bs);
     }
 
-    qemu_vfree(buf);
-
     /* Do not remove the backing file if an error was there but ignored. */
     return error;
 }
-- 
2.18.0


