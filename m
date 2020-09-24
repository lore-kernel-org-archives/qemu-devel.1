Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D6AC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5879523600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g58E0PUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5879523600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTXO-0007v2-5v
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAD-0001Sw-Fw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTA9-0005WX-Rr
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fKzT3UeYJ9sc1hti4D1wy89SYfS6DINx/n9breZw6iE=;
 b=g58E0PUTLgjo6ySzh+KoqZb3lfTpLfobwTT7YzUY3i1KyDjKschYnDxsgPF8WP2d2oLgEE
 QtbTDlo9TEjPjTs5BfrZoVHp6GDvio3c68KzxRqEZ5yi0JzID0guZv+/HFyEATEWoMixC3
 YDAlL0p3W2SogCwa8P073xmvWgp7Kh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-jkl4owRiPfCQhV8guItMeQ-1; Thu, 24 Sep 2020 11:27:59 -0400
X-MC-Unique: jkl4owRiPfCQhV8guItMeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40571195D578;
 Thu, 24 Sep 2020 15:27:56 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0114760C04;
 Thu, 24 Sep 2020 15:27:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 14/31] block/export: Move AioContext from NBDExport to
 BlockExport
Date: Thu, 24 Sep 2020 17:27:00 +0200
Message-Id: <20200924152717.287415-15-kwolf@redhat.com>
In-Reply-To: <20200924152717.287415-1-kwolf@redhat.com>
References: <20200924152717.287415-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/export.h |  3 +++
 block/export/export.c  |  2 ++
 nbd/server.c           | 26 +++++++++++++-------------
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/block/export.h b/include/block/export.h
index 5236a35e12..e6f96f4e1e 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -41,6 +41,9 @@ struct BlockExport {
      * the export.
      */
     int refcount;
+
+    /* The AioContext whose lock protects this BlockExport object. */
+    AioContext *ctx;
 };
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
diff --git a/block/export/export.c b/block/export/export.c
index baba4e94ff..8635318ef1 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -49,12 +49,14 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     return drv->create(export, errp);
 }
 
+/* Callers must hold exp->ctx lock */
 void blk_exp_ref(BlockExport *exp)
 {
     assert(exp->refcount > 0);
     exp->refcount++;
 }
 
+/* Callers must hold exp->ctx lock */
 void blk_exp_unref(BlockExport *exp)
 {
     assert(exp->refcount > 0);
diff --git a/nbd/server.c b/nbd/server.c
index 7be81c7bda..7cf81646fc 100644
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
@@ -1535,10 +1533,13 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
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
@@ -1548,7 +1549,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
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
@@ -2537,7 +2537,7 @@ static void nbd_client_receive_next_request(NBDClient *client)
     if (!client->recv_coroutine && client->nb_requests < MAX_NBD_REQUESTS) {
         nbd_client_get(client);
         client->recv_coroutine = qemu_coroutine_create(nbd_trip, client);
-        aio_co_schedule(client->exp->ctx, client->recv_coroutine);
+        aio_co_schedule(client->exp->common.ctx, client->recv_coroutine);
     }
 }
 
-- 
2.25.4


