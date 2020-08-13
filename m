Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D048C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BF9206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TE0j4/NU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BF9206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GC4-0002xk-Hs
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7T-0002Xl-6D
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7R-0001N9-3k
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5n33koo/nU4AJfebC0/VU2gJKoJYZDYyejA0Hlgalo=;
 b=TE0j4/NUnOxk0W0m2JKI5+q+osd5DBlQREGduf4+xwLIGZQS0vbwleAMQ0ljae2g0n3mx4
 KkWCsAq+0hqPnA8Gjs2WIh9VzTBm0IZ+aZuQfoV0+SRYvbIKGPAaktZND2RNIeYBM6muaw
 vInaXOEtsR3DA6bOYIh6uyFORLYlzOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-4vHalRXDMmG3pZA2aZ8WEQ-1; Thu, 13 Aug 2020 12:30:17 -0400
X-MC-Unique: 4vHalRXDMmG3pZA2aZ8WEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6A481014DEC;
 Thu, 13 Aug 2020 16:30:16 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 933365C1A3;
 Thu, 13 Aug 2020 16:30:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 14/22] block/export: Move AioContext from NBDExport to
 BlockExport
Date: Thu, 13 Aug 2020 18:29:27 +0200
Message-Id: <20200813162935.210070-15-kwolf@redhat.com>
In-Reply-To: <20200813162935.210070-1-kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:44:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/export.h |  6 ++++++
 nbd/server.c           | 26 +++++++++++++-------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/block/export.h b/include/block/export.h
index f44290a4a2..5459f79469 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -33,6 +33,12 @@ struct BlockExport {
      * the export.
      */
     int refcount;
+
+    /*
+     * The AioContex whose lock needs to be held while calling
+     * BlockExportDriver callbacks.
+     */
+    AioContext *ctx;
 };
 
 extern const BlockExportDriver blk_exp_nbd;
diff --git a/nbd/server.c b/nbd/server.c
index 2bf30bb731..b735a68429 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -92,8 +92,6 @@ struct NBDExport {
     QTAILQ_HEAD(, NBDClient) clients;
     QTAILQ_ENTRY(NBDExport) next;
 
-    AioContext *ctx;
-
     BlockBackend *eject_notifier_blk;
     Notifier eject_notifier;
 
@@ -1333,8 +1331,8 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
     }
 
     /* Attach the channel to the same AioContext as the export */
-    if (client->exp && client->exp->ctx) {
-        qio_channel_attach_aio_context(client->ioc, client->exp->ctx);
+    if (client->exp && client->exp->common.ctx) {
+        qio_channel_attach_aio_context(client->ioc, client->exp->common.ctx);
     }
 
     assert(!client->optlen);
@@ -1466,7 +1464,7 @@ static void blk_aio_attached(AioContext *ctx, void *opaque)
 
     trace_nbd_blk_aio_attached(exp->name, ctx);
 
-    exp->ctx = ctx;
+    exp->common.ctx = ctx;
 
     QTAILQ_FOREACH(client, &exp->clients, next) {
         qio_channel_attach_aio_context(client->ioc, ctx);
@@ -1484,13 +1482,13 @@ static void blk_aio_detach(void *opaque)
     NBDExport *exp = opaque;
     NBDClient *client;
 
-    trace_nbd_blk_aio_detach(exp->name, exp->ctx);
+    trace_nbd_blk_aio_detach(exp->name, exp->common.ctx);
 
     QTAILQ_FOREACH(client, &exp->clients, next) {
         qio_channel_detach_aio_context(client->ioc);
     }
 
-    exp->ctx = NULL;
+    exp->common.ctx = NULL;
 }
 
 static void nbd_eject_notifier(Notifier *n, void *data)
@@ -1498,7 +1496,7 @@ static void nbd_eject_notifier(Notifier *n, void *data)
     NBDExport *exp = container_of(n, NBDExport, eject_notifier);
     AioContext *aio_context;
 
-    aio_context = exp->ctx;
+    aio_context = exp->common.ctx;
     aio_context_acquire(aio_context);
     nbd_export_close(exp);
     aio_context_release(aio_context);
@@ -1534,10 +1532,13 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
         return NULL;
     }
 
+    ctx = bdrv_get_aio_context(bs);
+
     exp = g_new0(NBDExport, 1);
     exp->common = (BlockExport) {
         .drv        = &blk_exp_nbd,
         .refcount   = 1,
+        .ctx        = ctx,
     };
 
     /*
@@ -1547,7 +1548,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
      * ctx was acquired in the caller.
      */
     assert(name && strlen(name) <= NBD_MAX_STRING_SIZE);
-    ctx = bdrv_get_aio_context(bs);
+
     bdrv_invalidate_cache(bs, NULL);
 
     /* Don't allow resize while the NBD server is running, otherwise we don't
@@ -1622,7 +1623,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
         assert(strlen(exp->export_bitmap_context) < NBD_MAX_STRING_SIZE);
     }
 
-    exp->ctx = ctx;
     blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, exp);
 
     blk_exp_ref(&exp->common);
@@ -1653,7 +1653,7 @@ NBDExport *nbd_export_find(const char *name)
 AioContext *
 nbd_export_aio_context(NBDExport *exp)
 {
-    return exp->ctx;
+    return exp->common.ctx;
 }
 
 void nbd_export_close(NBDExport *exp)
@@ -1738,7 +1738,7 @@ void nbd_export_close_all(void)
     AioContext *aio_context;
 
     QTAILQ_FOREACH_SAFE(exp, &exports, next, next) {
-        aio_context = exp->ctx;
+        aio_context = exp->common.ctx;
         aio_context_acquire(aio_context);
         nbd_export_close(exp);
         aio_context_release(aio_context);
@@ -2519,7 +2519,7 @@ static void nbd_client_receive_next_request(NBDClient *client)
     if (!client->recv_coroutine && client->nb_requests < MAX_NBD_REQUESTS) {
         nbd_client_get(client);
         client->recv_coroutine = qemu_coroutine_create(nbd_trip, client);
-        aio_co_schedule(client->exp->ctx, client->recv_coroutine);
+        aio_co_schedule(client->exp->common.ctx, client->recv_coroutine);
     }
 }
 
-- 
2.25.4


