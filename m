Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC6CC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072F920652
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072F920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60949 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYspo-0001ig-Vy
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:53:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYskv-0006Is-3L
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYskg-0001im-Qe
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:48:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:45562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYskf-0001HZ-6G; Thu, 06 Jun 2019 09:48:22 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYska-00004z-6B; Thu, 06 Jun 2019 16:48:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu,  6 Jun 2019 16:48:13 +0300
Message-Id: <20190606134814.123689-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190606134814.123689-1-vsementsov@virtuozzo.com>
References: <20190606134814.123689-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 2/3] block/stream: use blk_co_pcache
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
 block/stream.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 1a906fd860..8478aa4a50 100644
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
@@ -39,13 +39,11 @@ typedef struct StreamBlockJob {
 } StreamBlockJob;
 
 static int coroutine_fn stream_populate(BlockBackend *blk,
-                                        int64_t offset, uint64_t bytes,
-                                        void *buf)
+                                        int64_t offset, uint64_t bytes)
 {
     assert(bytes < SIZE_MAX);
 
-    /* Copy-on-read the unallocated clusters */
-    return blk_co_pread(blk, offset, bytes, buf, BDRV_REQ_COPY_ON_READ);
+    return blk_co_pcache(blk, offset, bytes);
 }
 
 static void stream_abort(Job *job)
@@ -117,7 +115,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     int error = 0;
     int ret = 0;
     int64_t n = 0; /* bytes */
-    void *buf;
 
     if (!bs->backing) {
         goto out;
@@ -130,8 +127,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     }
     job_progress_set_remaining(&s->common.job, len);
 
-    buf = qemu_blockalign(bs, STREAM_BUFFER_SIZE);
-
     /* Turn on copy-on-read for the whole block device so that guest read
      * requests help us make progress.  Only do this when copying the entire
      * backing chain since the copy-on-read operation does not take base into
@@ -154,7 +149,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
 
         copy = false;
 
-        ret = bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &n);
+        ret = bdrv_is_allocated(bs, offset, STREAM_CHUNK, &n);
         if (ret == 1) {
             /* Allocated in the top, no need to copy.  */
         } else if (ret >= 0) {
@@ -172,7 +167,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         }
         trace_stream_one_iteration(s, offset, n, ret);
         if (copy) {
-            ret = stream_populate(blk, offset, n, buf);
+            ret = stream_populate(blk, offset, n);
         }
         if (ret < 0) {
             BlockErrorAction action =
@@ -206,8 +201,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     /* Do not remove the backing file if an error was there but ignored.  */
     ret = error;
 
-    qemu_vfree(buf);
-
 out:
     /* Modify backing chain and close BDSes in main loop */
     return ret;
-- 
2.18.0


