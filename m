Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D50C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A7F20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A7F20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dTQ-0002am-Ae
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7dJK-0000S7-Ha
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7dJI-0001ul-Cc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:23:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:60074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7dJB-0001oL-CN; Tue, 10 Sep 2019 06:23:37 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7dJ8-0007it-2d; Tue, 10 Sep 2019 13:23:34 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 13:23:30 +0300
Message-Id: <20190910102332.20560-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190910102332.20560-1-vsementsov@virtuozzo.com>
References: <20190910102332.20560-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v11 12/14] block: add lock/unlock range
 functions
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
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce lock/unlock range functionality, based on serialized
requests. This is needed to refactor backup, dropping local
tracked-request-like synchronization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  4 ++++
 block/io.c                | 44 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0422acdf1c..b59011ca97 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -65,6 +65,7 @@ enum BdrvTrackedRequestType {
     BDRV_TRACKED_WRITE,
     BDRV_TRACKED_DISCARD,
     BDRV_TRACKED_TRUNCATE,
+    BDRV_TRACKED_LOCK,
 };
 
 typedef struct BdrvTrackedRequest {
@@ -968,6 +969,9 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
 int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
     int64_t offset, unsigned int bytes,
     QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
+void *coroutine_fn bdrv_co_try_lock(BlockDriverState *bs,
+                                    int64_t offset, unsigned int bytes);
+void coroutine_fn bdrv_co_unlock(void *opaque);
 
 static inline int coroutine_fn bdrv_co_pread(BdrvChild *child,
     int64_t offset, unsigned int bytes, void *buf, BdrvRequestFlags flags)
diff --git a/block/io.c b/block/io.c
index e909736349..b9dd578d56 100644
--- a/block/io.c
+++ b/block/io.c
@@ -786,6 +786,15 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
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
@@ -802,7 +811,7 @@ static bool coroutine_fn do_wait_serialising_requests(BdrvTrackedRequest *self,
         retry = false;
         qemu_co_mutex_lock(&bs->reqs_lock);
         QLIST_FOREACH(req, &bs->tracked_requests, list) {
-            if (req == self || (!req->serialising && !self->serialising)) {
+            if (ignore_intersection(self, req)) {
                 continue;
             }
             if (tracked_request_overlaps(req, self->overlap_offset,
@@ -840,6 +849,12 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
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
@@ -3378,3 +3393,30 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
 
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


