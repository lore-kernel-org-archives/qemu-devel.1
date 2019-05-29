Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BBDC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752EE23BBA
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752EE23BBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56939 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW0sK-0008Qk-Mu
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 11:52:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hW0n9-0004V7-0V
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hW0n7-00053F-RP
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:47:02 -0400
Received: from relay.sw.ru ([185.231.240.75]:43142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hW0n7-00051x-IO; Wed, 29 May 2019 11:47:01 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hW0n2-0004iP-Pv; Wed, 29 May 2019 18:46:56 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 29 May 2019 18:46:53 +0300
Message-Id: <20190529154654.95870-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190529154654.95870-1-vsementsov@virtuozzo.com>
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v8 6/7] block: add lock/unlock range functions
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <etendren@gmail.com>

Introduce lock/unlock range functionality, based on serialized
requests. This is needed to refactor backup, dropping local
tracked-request-like synchronization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <etendren@gmail.com>
---
 include/block/block_int.h |  4 ++++
 block/io.c                | 44 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1eebc7c8f3..9d9d4346e9 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -66,6 +66,7 @@ enum BdrvTrackedRequestType {
     BDRV_TRACKED_WRITE,
     BDRV_TRACKED_DISCARD,
     BDRV_TRACKED_TRUNCATE,
+    BDRV_TRACKED_LOCK,
 };
 
 typedef struct BdrvTrackedRequest {
@@ -928,6 +929,9 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
+void *coroutine_fn bdrv_co_try_lock(BlockDriverState *bs,
+                                    int64_t offset, unsigned int bytes);
+void coroutine_fn bdrv_co_unlock(void *opaque);
 
 static inline int coroutine_fn bdrv_co_pread(BdrvChild *child,
     int64_t offset, unsigned int bytes, void *buf, BdrvRequestFlags flags)
diff --git a/block/io.c b/block/io.c
index c347f90722..488e01e0a1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -720,6 +720,15 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
     bdrv_wakeup(bs);
 }
 
+static bool ignore_intersection(BdrvTrackedRequest *a, BdrvTrackedRequest *b)
+{
+    return a == b || (!a->serialising && !b->serialising) ||
+        (a->type == BDRV_TRACKED_LOCK && b->type == BDRV_TRACKED_READ &&
+         !b->serialising) ||
+        (b->type == BDRV_TRACKED_LOCK && a->type == BDRV_TRACKED_READ &&
+         !a->serialising);
+}
+
 static bool coroutine_fn do_wait_serialising_requests(BdrvTrackedRequest *self,
                                                       bool wait)
 {
@@ -736,7 +745,7 @@ static bool coroutine_fn do_wait_serialising_requests(BdrvTrackedRequest *self,
         retry = false;
         qemu_co_mutex_lock(&bs->reqs_lock);
         QLIST_FOREACH(req, &bs->tracked_requests, list) {
-            if (req == self || (!req->serialising && !self->serialising)) {
+            if (ignore_intersection(self, req)) {
                 continue;
             }
             if (tracked_request_overlaps(req, self->overlap_offset,
@@ -774,6 +783,12 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
     return do_wait_serialising_requests(self, true);
 }
 
+static bool coroutine_fn should_wait_serialising_requests(
+        BdrvTrackedRequest *self)
+{
+    return do_wait_serialising_requests(self, false);
+}
+
 static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
                                    size_t size)
 {
@@ -3184,3 +3199,30 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
 
     return tco.ret;
 }
+
+void *coroutine_fn bdrv_co_try_lock(BlockDriverState *bs,
+                                    int64_t offset, unsigned int bytes)
+{
+    BdrvTrackedRequest *req = g_new(BdrvTrackedRequest, 1);
+
+    tracked_request_begin(req, bs, offset, bytes, BDRV_TRACKED_LOCK);
+    mark_request_serialising(req, bdrv_get_cluster_size(bs));
+
+    if (should_wait_serialising_requests(req)) {
+        tracked_request_end(req);
+        g_free(req);
+        return NULL;
+    }
+
+    return req;
+}
+
+void coroutine_fn bdrv_co_unlock(void *opaque)
+{
+    BdrvTrackedRequest *req = opaque;
+
+    assert(req->type == BDRV_TRACKED_LOCK);
+
+    tracked_request_end(req);
+    g_free(req);
+}
-- 
2.18.0


