Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E27C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B23320862
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B23320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia27Z-0003VY-9z
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia1kA-0006d8-EV
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia1k9-0003s8-Cq
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:08:50 -0500
Received: from relay.sw.ru ([185.231.240.75]:49986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia1k6-0003im-6M; Wed, 27 Nov 2019 13:08:46 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia1k0-0002UU-Sc; Wed, 27 Nov 2019 21:08:40 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/7] block/block-copy: factor out
 block_copy_find_inflight_req
Date: Wed, 27 Nov 2019 21:08:36 +0300
Message-Id: <20191127180840.11937-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191127180840.11937-1-vsementsov@virtuozzo.com>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
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

Split block_copy_find_inflight_req to be used in seprate.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 74295d93d5..94e7e855ef 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -24,23 +24,30 @@
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
 
+static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyState *s,
+                                                          int64_t start,
+                                                          int64_t end)
+{
+    BlockCopyInFlightReq *req;
+
+    QLIST_FOREACH(req, &s->inflight_reqs, list) {
+        if (end > req->start_byte && start < req->end_byte) {
+            return req;
+        }
+    }
+
+    return NULL;
+}
+
 static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
                                                        int64_t start,
                                                        int64_t end)
 {
     BlockCopyInFlightReq *req;
-    bool waited;
-
-    do {
-        waited = false;
-        QLIST_FOREACH(req, &s->inflight_reqs, list) {
-            if (end > req->start_byte && start < req->end_byte) {
-                qemu_co_queue_wait(&req->wait_queue, NULL);
-                waited = true;
-                break;
-            }
-        }
-    } while (waited);
+
+    while ((req = block_copy_find_inflight_req(s, start, end))) {
+        qemu_co_queue_wait(&req->wait_queue, NULL);
+    }
 }
 
 static void block_copy_inflight_req_begin(BlockCopyState *s,
-- 
2.21.0


