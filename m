Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DA6C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF4E218DA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF4E218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqaeN-0000wn-La
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49320)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqadO-0005WJ-9D
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqadN-0006R5-65
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:06:02 -0400
Received: from relay.sw.ru ([185.231.240.75]:45726)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqadJ-0006O5-JR; Thu, 25 Jul 2019 06:05:57 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqadD-0001mQ-2y; Thu, 25 Jul 2019 13:05:51 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 13:05:50 +0300
Message-Id: <20190725100550.33801-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190725100550.33801-1-vsementsov@virtuozzo.com>
References: <20190725100550.33801-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 3/3] nbd: improve CMD_CACHE: use
 BDRV_REQ_PREFETCH
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
We assume here that CMD_CACHE is always used with copy-on-read, as
otherwise it's a noop.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 10faedcfc5..a2cf085f76 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2104,12 +2104,15 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
             return -EINVAL;
         }
 
-        req->data = blk_try_blockalign(client->exp->blk, request->len);
-        if (req->data == NULL) {
-            error_setg(errp, "No memory");
-            return -ENOMEM;
+        if (request->type != NBD_CMD_CACHE) {
+            req->data = blk_try_blockalign(client->exp->blk, request->len);
+            if (req->data == NULL) {
+                error_setg(errp, "No memory");
+                return -ENOMEM;
+            }
         }
     }
+
     if (request->type == NBD_CMD_WRITE) {
         if (nbd_read(client->ioc, req->data, request->len, "CMD_WRITE data",
                      errp) < 0)
@@ -2194,7 +2197,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     int ret;
     NBDExport *exp = client->exp;
 
-    assert(request->type == NBD_CMD_READ || request->type == NBD_CMD_CACHE);
+    assert(request->type == NBD_CMD_READ);
 
     /* XXX: NBD Protocol only documents use of FUA with WRITE */
     if (request->flags & NBD_CMD_FLAG_FUA) {
@@ -2206,7 +2209,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     }
 
     if (client->structured_reply && !(request->flags & NBD_CMD_FLAG_DF) &&
-        request->len && request->type != NBD_CMD_CACHE)
+        request->len)
     {
         return nbd_co_send_sparse_read(client, request->handle, request->from,
                                        data, request->len, errp);
@@ -2214,7 +2217,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
 
     ret = blk_pread(exp->blk, request->from + exp->dev_offset, data,
                     request->len);
-    if (ret < 0 || request->type == NBD_CMD_CACHE) {
+    if (ret < 0) {
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "reading from file failed", errp);
     }
@@ -2233,6 +2236,28 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     }
 }
 
+/*
+ * nbd_do_cmd_cache
+ *
+ * Handle NBD_CMD_CACHE request.
+ * Return -errno if sending fails. Other errors are reported directly to the
+ * client as an error reply.
+ */
+static coroutine_fn int nbd_do_cmd_cache(NBDClient *client, NBDRequest *request,
+                                         Error **errp)
+{
+    int ret;
+    NBDExport *exp = client->exp;
+
+    assert(request->type == NBD_CMD_CACHE);
+
+    ret = blk_co_preadv(exp->blk, request->from + exp->dev_offset, request->len,
+                        NULL, BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
+
+    return nbd_send_generic_reply(client, request->handle, ret,
+                                  "caching data failed", errp);
+}
+
 /* Handle NBD request.
  * Return -errno if sending fails. Other errors are reported directly to the
  * client as an error reply. */
@@ -2246,8 +2271,10 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
     char *msg;
 
     switch (request->type) {
-    case NBD_CMD_READ:
     case NBD_CMD_CACHE:
+        return nbd_do_cmd_cache(client, request, errp);
+
+    case NBD_CMD_READ:
         return nbd_do_cmd_read(client, request, data, errp);
 
     case NBD_CMD_WRITE:
-- 
2.18.0


