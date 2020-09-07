Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848F6C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DF820738
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXP5IUDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DF820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLr9-0000mB-Tz
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLl9-0005N1-8w
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:20:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27594
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLl0-0004Vu-GE
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599502845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbqVe6JGkNq+PJJ48CcAI3Q247uYJgPwb4VmaUhxqSY=;
 b=LXP5IUDTQxwhAMAY24+0sEQPv6U1J/q6MDTD+VXspo4n+Sd3YOr3mRWtR9dAp1gYWR6pNr
 DKck0QjImgMjhSEA7/CxB0g/tM+eoPpkJwSxwjwYng8NTYZ5NOV7SOxfNY3K/RRXxan0mk
 RxKqOV2O4kbCrZhNLSJjqiT6uHU5dn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-KKaPejNnOmCxbkaoK12g5g-1; Mon, 07 Sep 2020 14:20:44 -0400
X-MC-Unique: KKaPejNnOmCxbkaoK12g5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B4F5807335;
 Mon,  7 Sep 2020 18:20:43 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00D5160BF3;
 Mon,  7 Sep 2020 18:20:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 13/29] block/export: Move refcount from NBDExport to
 BlockExport
Date: Mon,  7 Sep 2020 20:19:55 +0200
Message-Id: <20200907182011.521007-14-kwolf@redhat.com>
In-Reply-To: <20200907182011.521007-1-kwolf@redhat.com>
References: <20200907182011.521007-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Having a refcount makes sense for all types of block exports. It is also
a prerequisite for keeping a list of all exports at the BlockExport
level.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/export.h | 15 +++++++++
 include/block/nbd.h    |  2 --
 block/export/export.c  | 14 ++++++++
 blockdev-nbd.c         |  2 +-
 nbd/server.c           | 72 +++++++++++++++++++-----------------------
 5 files changed, 63 insertions(+), 42 deletions(-)

diff --git a/include/block/export.h b/include/block/export.h
index e7af2c7687..5236a35e12 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -24,12 +24,27 @@ typedef struct BlockExportDriver {
 
     /* Creates and starts a new block export */
     BlockExport *(*create)(BlockExportOptions *, Error **);
+
+    /*
+     * Frees a removed block export. This function is only called after all
+     * references have been dropped.
+     */
+    void (*delete)(BlockExport *);
 } BlockExportDriver;
 
 struct BlockExport {
     const BlockExportDriver *drv;
+
+    /*
+     * Reference count for this block export. This includes strong references
+     * both from the owner (qemu-nbd or the monitor) and clients connected to
+     * the export.
+     */
+    int refcount;
 };
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
+void blk_exp_ref(BlockExport *exp);
+void blk_exp_unref(BlockExport *exp);
 
 #endif
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 1dafe70615..e3bd112227 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -338,8 +338,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
 void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);
 void nbd_export_close(NBDExport *exp);
 void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
-void nbd_export_get(NBDExport *exp);
-void nbd_export_put(NBDExport *exp);
 
 AioContext *nbd_export_aio_context(NBDExport *exp);
 NBDExport *nbd_export_find(const char *name);
diff --git a/block/export/export.c b/block/export/export.c
index 05bc5e3744..baba4e94ff 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -49,6 +49,20 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     return drv->create(export, errp);
 }
 
+void blk_exp_ref(BlockExport *exp)
+{
+    assert(exp->refcount > 0);
+    exp->refcount++;
+}
+
+void blk_exp_unref(BlockExport *exp)
+{
+    assert(exp->refcount > 0);
+    if (--exp->refcount == 0) {
+        exp->drv->delete(exp);
+    }
+}
+
 void qmp_block_export_add(BlockExportOptions *export, Error **errp)
 {
     blk_exp_add(export, errp);
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 7bb0b09697..e208324d42 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -236,7 +236,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
     /* The list of named exports has a strong reference to this export now and
      * our only way of accessing it is through nbd_export_find(), so we can drop
      * the strong reference that is @exp. */
-    nbd_export_put(exp);
+    blk_exp_unref((BlockExport*) exp);
 
  out:
     aio_context_release(aio_context);
diff --git a/nbd/server.c b/nbd/server.c
index fb70374df5..7be81c7bda 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -83,7 +83,6 @@ struct NBDRequestData {
 
 struct NBDExport {
     BlockExport common;
-    int refcount;
 
     BlockBackend *blk;
     char *name;
@@ -499,7 +498,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
     }
 
     QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
-    nbd_export_get(client->exp);
+    blk_exp_ref(&client->exp->common);
     nbd_check_meta_export(client);
 
     return 0;
@@ -707,7 +706,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
         client->exp = exp;
         client->check_align = check_align;
         QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
-        nbd_export_get(client->exp);
+        blk_exp_ref(&client->exp->common);
         nbd_check_meta_export(client);
         rc = 1;
     }
@@ -1406,7 +1405,7 @@ void nbd_client_put(NBDClient *client)
         g_free(client->tlsauthz);
         if (client->exp) {
             QTAILQ_REMOVE(&client->exp->clients, client, next);
-            nbd_export_put(client->exp);
+            blk_exp_unref(&client->exp->common);
         }
         g_free(client);
     }
@@ -1538,7 +1537,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
 
     exp = g_new0(NBDExport, 1);
     exp->common = (BlockExport) {
-        .drv = &blk_exp_nbd,
+        .drv        = &blk_exp_nbd,
+        .refcount   = 1,
     };
 
     /*
@@ -1567,7 +1567,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
     blk_set_enable_write_cache(blk, !writethrough);
     blk_set_allow_aio_context_change(blk, true);
 
-    exp->refcount = 1;
     QTAILQ_INIT(&exp->clients);
     exp->blk = blk;
     exp->name = g_strdup(name);
@@ -1626,8 +1625,9 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
     exp->ctx = ctx;
     blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, exp);
 
+    blk_exp_ref(&exp->common);
     QTAILQ_INSERT_TAIL(&exports, exp, next);
-    nbd_export_get(exp);
+
     return exp;
 
 fail:
@@ -1660,7 +1660,7 @@ void nbd_export_close(NBDExport *exp)
 {
     NBDClient *client, *next;
 
-    nbd_export_get(exp);
+    blk_exp_ref(&exp->common);
     /*
      * TODO: Should we expand QMP NbdServerRemoveNode enum to allow a
      * close mode that stops advertising the export to new clients but
@@ -1672,13 +1672,13 @@ void nbd_export_close(NBDExport *exp)
         client_close(client, true);
     }
     if (exp->name) {
-        nbd_export_put(exp);
+        blk_exp_unref(&exp->common);
         g_free(exp->name);
         exp->name = NULL;
         QTAILQ_REMOVE(&exports, exp, next);
         QTAILQ_INSERT_TAIL(&closed_exports, exp, next);
     }
-    nbd_export_put(exp);
+    blk_exp_unref(&exp->common);
 }
 
 void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp)
@@ -1695,47 +1695,41 @@ void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp)
     error_append_hint(errp, "Use mode='hard' to force client disconnect\n");
 }
 
-void nbd_export_get(NBDExport *exp)
-{
-    assert(exp->refcount > 0);
-    exp->refcount++;
-}
-
-void nbd_export_put(NBDExport *exp)
+static void nbd_export_delete(BlockExport *blk_exp)
 {
-    assert(exp->refcount > 0);
-    if (--exp->refcount == 0) {
-        assert(exp->name == NULL);
-        assert(QTAILQ_EMPTY(&exp->clients));
+    NBDExport *exp = container_of(blk_exp, NBDExport, common);
 
-        g_free(exp->description);
-        exp->description = NULL;
+    assert(exp->name == NULL);
+    assert(QTAILQ_EMPTY(&exp->clients));
 
-        if (exp->blk) {
-            if (exp->eject_notifier_blk) {
-                notifier_remove(&exp->eject_notifier);
-                blk_unref(exp->eject_notifier_blk);
-            }
-            blk_remove_aio_context_notifier(exp->blk, blk_aio_attached,
-                                            blk_aio_detach, exp);
-            blk_unref(exp->blk);
-            exp->blk = NULL;
-        }
+    g_free(exp->description);
+    exp->description = NULL;
 
-        if (exp->export_bitmap) {
-            bdrv_dirty_bitmap_set_busy(exp->export_bitmap, false);
-            g_free(exp->export_bitmap_context);
+    if (exp->blk) {
+        if (exp->eject_notifier_blk) {
+            notifier_remove(&exp->eject_notifier);
+            blk_unref(exp->eject_notifier_blk);
         }
+        blk_remove_aio_context_notifier(exp->blk, blk_aio_attached,
+                                        blk_aio_detach, exp);
+        blk_unref(exp->blk);
+        exp->blk = NULL;
+    }
 
-        QTAILQ_REMOVE(&closed_exports, exp, next);
-        g_free(exp);
-        aio_wait_kick();
+    if (exp->export_bitmap) {
+        bdrv_dirty_bitmap_set_busy(exp->export_bitmap, false);
+        g_free(exp->export_bitmap_context);
     }
+
+    QTAILQ_REMOVE(&closed_exports, exp, next);
+    g_free(exp);
+    aio_wait_kick();
 }
 
 const BlockExportDriver blk_exp_nbd = {
     .type               = BLOCK_EXPORT_TYPE_NBD,
     .create             = nbd_export_create,
+    .delete             = nbd_export_delete,
 };
 
 void nbd_export_close_all(void)
-- 
2.25.4


