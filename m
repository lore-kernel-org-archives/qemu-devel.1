Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E24C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D1D2063F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D1D2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKaZ-0005IL-MP
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hyKXA-0002zr-DJ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hyKX7-0001wy-Td
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38626)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hyKWz-0001ey-C6; Thu, 15 Aug 2019 14:31:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 297F230BB8E8;
 Thu, 15 Aug 2019 18:31:23 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A359F84BBA;
 Thu, 15 Aug 2019 18:31:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 13:30:34 -0500
Message-Id: <20190815183039.4264-5-eblake@redhat.com>
In-Reply-To: <20190815183039.4264-1-eblake@redhat.com>
References: <20190815183039.4264-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 15 Aug 2019 18:31:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/9] nbd: improve CMD_CACHE: use
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This helps to avoid extra io, allocations and memory copying.
We assume here that CMD_CACHE is always used with copy-on-read, as
otherwise it's a noop.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190725100550.33801-4-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 10faedcfc55d..a2cf085f7635 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2104,12 +2104,15 @@ static int nbd_co_receive_request(NBDRequestData =
*req, NBDRequest *request,
             return -EINVAL;
         }

-        req->data =3D blk_try_blockalign(client->exp->blk, request->len)=
;
-        if (req->data =3D=3D NULL) {
-            error_setg(errp, "No memory");
-            return -ENOMEM;
+        if (request->type !=3D NBD_CMD_CACHE) {
+            req->data =3D blk_try_blockalign(client->exp->blk, request->=
len);
+            if (req->data =3D=3D NULL) {
+                error_setg(errp, "No memory");
+                return -ENOMEM;
+            }
         }
     }
+
     if (request->type =3D=3D NBD_CMD_WRITE) {
         if (nbd_read(client->ioc, req->data, request->len, "CMD_WRITE da=
ta",
                      errp) < 0)
@@ -2194,7 +2197,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *=
client, NBDRequest *request,
     int ret;
     NBDExport *exp =3D client->exp;

-    assert(request->type =3D=3D NBD_CMD_READ || request->type =3D=3D NBD=
_CMD_CACHE);
+    assert(request->type =3D=3D NBD_CMD_READ);

     /* XXX: NBD Protocol only documents use of FUA with WRITE */
     if (request->flags & NBD_CMD_FLAG_FUA) {
@@ -2206,7 +2209,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *=
client, NBDRequest *request,
     }

     if (client->structured_reply && !(request->flags & NBD_CMD_FLAG_DF) =
&&
-        request->len && request->type !=3D NBD_CMD_CACHE)
+        request->len)
     {
         return nbd_co_send_sparse_read(client, request->handle, request-=
>from,
                                        data, request->len, errp);
@@ -2214,7 +2217,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *=
client, NBDRequest *request,

     ret =3D blk_pread(exp->blk, request->from + exp->dev_offset, data,
                     request->len);
-    if (ret < 0 || request->type =3D=3D NBD_CMD_CACHE) {
+    if (ret < 0) {
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "reading from file failed", errp);
     }
@@ -2233,6 +2236,28 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient =
*client, NBDRequest *request,
     }
 }

+/*
+ * nbd_do_cmd_cache
+ *
+ * Handle NBD_CMD_CACHE request.
+ * Return -errno if sending fails. Other errors are reported directly to=
 the
+ * client as an error reply.
+ */
+static coroutine_fn int nbd_do_cmd_cache(NBDClient *client, NBDRequest *=
request,
+                                         Error **errp)
+{
+    int ret;
+    NBDExport *exp =3D client->exp;
+
+    assert(request->type =3D=3D NBD_CMD_CACHE);
+
+    ret =3D blk_co_preadv(exp->blk, request->from + exp->dev_offset, req=
uest->len,
+                        NULL, BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH)=
;
+
+    return nbd_send_generic_reply(client, request->handle, ret,
+                                  "caching data failed", errp);
+}
+
 /* Handle NBD request.
  * Return -errno if sending fails. Other errors are reported directly to=
 the
  * client as an error reply. */
@@ -2246,8 +2271,10 @@ static coroutine_fn int nbd_handle_request(NBDClie=
nt *client,
     char *msg;

     switch (request->type) {
-    case NBD_CMD_READ:
     case NBD_CMD_CACHE:
+        return nbd_do_cmd_cache(client, request, errp);
+
+    case NBD_CMD_READ:
         return nbd_do_cmd_read(client, request, data, errp);

     case NBD_CMD_WRITE:
--=20
2.20.1


