Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50607C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A032070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A032070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYsnB-0007iU-Gx
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:50:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYsku-0006L1-Ep
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYskg-0001j4-Rk
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:48:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:45560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYskf-0001Ha-3l; Thu, 06 Jun 2019 09:48:22 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYska-00004z-Ah; Thu, 06 Jun 2019 16:48:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu,  6 Jun 2019 16:48:14 +0300
Message-Id: <20190606134814.123689-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190606134814.123689-1-vsementsov@virtuozzo.com>
References: <20190606134814.123689-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 3/3] nbd: improve CMD_CACHE: use blk_co_pcache
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
We assume here that CMD_CACHE is always used with copy-on-read, as
otherwise it's a noop.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index aeca3893fe..a7e8dbaccd 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2101,12 +2101,15 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
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
@@ -2191,7 +2194,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     int ret;
     NBDExport *exp = client->exp;
 
-    assert(request->type == NBD_CMD_READ || request->type == NBD_CMD_CACHE);
+    assert(request->type == NBD_CMD_READ);
 
     /* XXX: NBD Protocol only documents use of FUA with WRITE */
     if (request->flags & NBD_CMD_FLAG_FUA) {
@@ -2203,7 +2206,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     }
 
     if (client->structured_reply && !(request->flags & NBD_CMD_FLAG_DF) &&
-        request->len && request->type != NBD_CMD_CACHE)
+        request->len)
     {
         return nbd_co_send_sparse_read(client, request->handle, request->from,
                                        data, request->len, errp);
@@ -2211,7 +2214,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
 
     ret = blk_pread(exp->blk, request->from + exp->dev_offset, data,
                     request->len);
-    if (ret < 0 || request->type == NBD_CMD_CACHE) {
+    if (ret < 0) {
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "reading from file failed", errp);
     }
@@ -2230,6 +2233,28 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
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
+    ret = blk_co_pcache(exp->blk, request->from + exp->dev_offset,
+                        request->len);
+
+    return nbd_send_generic_reply(client, request->handle, ret,
+                                  "caching data failed", errp);
+}
+
 /* Handle NBD request.
  * Return -errno if sending fails. Other errors are reported directly to the
  * client as an error reply. */
@@ -2243,8 +2268,10 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
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


