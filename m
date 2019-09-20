Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B15C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EEC52080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEC52080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBK3b-0003Ek-W1
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBJmo-0004tQ-8i
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBJmn-000125-2r
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:21:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:43814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBJmk-0000gG-FN; Fri, 20 Sep 2019 10:21:22 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBJmO-0006b5-7C; Fri, 20 Sep 2019 17:21:00 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v13 12/15] block/io: refactor wait_serialising_requests
Date: Fri, 20 Sep 2019 17:20:53 +0300
Message-Id: <20190920142056.12778-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142056.12778-1-vsementsov@virtuozzo.com>
References: <20190920142056.12778-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split out do_wait_serialising_requests with additional possibility to
not actually wait but just check, that there is something to wait for.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/block/io.c b/block/io.c
index f8c3596131..f5f7b7357c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -786,12 +786,13 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
     bdrv_wakeup(bs);
 }
 
-static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
+static bool coroutine_fn do_wait_serialising_requests(BdrvTrackedRequest *self,
+                                                      bool wait)
 {
     BlockDriverState *bs = self->bs;
     BdrvTrackedRequest *req;
     bool retry;
-    bool waited = false;
+    bool found = false;
 
     if (!atomic_read(&bs->serialising_in_flight)) {
         return false;
@@ -817,11 +818,13 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
                  * will wait for us as soon as it wakes up, then just go on
                  * (instead of producing a deadlock in the former case). */
                 if (!req->waiting_for) {
-                    self->waiting_for = req;
-                    qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
-                    self->waiting_for = NULL;
-                    retry = true;
-                    waited = true;
+                    found = true;
+                    if (wait) {
+                        self->waiting_for = req;
+                        qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
+                        self->waiting_for = NULL;
+                        retry = true;
+                    }
                     break;
                 }
             }
@@ -829,7 +832,12 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
         qemu_co_mutex_unlock(&bs->reqs_lock);
     } while (retry);
 
-    return waited;
+    return found;
+}
+
+static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
+{
+    return do_wait_serialising_requests(self, true);
 }
 
 static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
-- 
2.21.0


