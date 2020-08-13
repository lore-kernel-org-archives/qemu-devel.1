Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3EBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF8B206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBzF6YnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF8B206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GHf-0005yI-F6
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7Y-0002hj-5k
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59691
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7V-0001Os-L4
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VPRQm1UXA5+fW8O1I3o7UEA748AQPBgncNTscJTZMA=;
 b=EBzF6YnZrUjoarLBWGi30QwwKS0cnBhOGGIaB5bfg03Ra5tipw2a3FZNfhSpcrlWzunsmP
 HFKI2p3gHPaMhoVtHaILpZxwB0ALS2A5Q55vTGkgKnXJbZgc8uxkPJA6eJIdafIj3B5ilL
 fI1AhZDzdv3ACLW9MW8j9UJjq6k6oMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-B___ZwCDPk-UhFkaCkR8Kg-1; Thu, 13 Aug 2020 12:30:22 -0400
X-MC-Unique: B___ZwCDPk-UhFkaCkR8Kg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 115AB1006709;
 Thu, 13 Aug 2020 16:30:21 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4A005C1A3;
 Thu, 13 Aug 2020 16:30:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 17/22] block/export: Add blk_exp_close_all(_type)
Date: Thu, 13 Aug 2020 18:29:30 +0200
Message-Id: <20200813162935.210070-18-kwolf@redhat.com>
In-Reply-To: <20200813162935.210070-1-kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:45:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This adds a function to shut down all block exports, and another one to
shut down the block exports of a single type. The latter is used for now
when stopping the NBD server. As soon as we implement support for
multiple NBD servers, we'll need a per-server list of exports and it
will be replaced by a function using that.

As a side effect, the BlockExport layer has a list tracking all existing
exports now. closed_exports loses its only user and can go away.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/export.h |  8 +++++++
 include/block/nbd.h    |  2 --
 block.c                |  2 +-
 block/export/export.c  | 52 ++++++++++++++++++++++++++++++++++++++++++
 blockdev-nbd.c         |  2 +-
 nbd/server.c           | 34 ++++-----------------------
 qemu-nbd.c             |  2 +-
 7 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/include/block/export.h b/include/block/export.h
index 597fc58245..1698b68f09 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -15,6 +15,7 @@
 #define BLOCK_EXPORT_H
 
 #include "qapi/qapi-types-block-export.h"
+#include "qemu/queue.h"
 
 typedef struct BlockExport BlockExport;
 
@@ -23,6 +24,7 @@ typedef struct BlockExportDriver {
     size_t instance_size;
     int (*create)(BlockExport *, BlockExportOptions *, Error **);
     void (*delete)(BlockExport *);
+    void (*request_shutdown)(BlockExport *);
 } BlockExportDriver;
 
 struct BlockExport {
@@ -40,6 +42,9 @@ struct BlockExport {
      * BlockExportDriver callbacks.
      */
     AioContext *ctx;
+
+    /* List entry for block_exports */
+    QLIST_ENTRY(BlockExport) next;
 };
 
 extern const BlockExportDriver blk_exp_nbd;
@@ -47,5 +52,8 @@ extern const BlockExportDriver blk_exp_nbd;
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
 void blk_exp_ref(BlockExport *exp);
 void blk_exp_unref(BlockExport *exp);
+void blk_exp_request_shutdown(BlockExport *exp);
+void blk_exp_close_all(void);
+void blk_exp_close_all_type(BlockExportType type);
 
 #endif
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 602536feb2..91a9d4f96d 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -335,12 +335,10 @@ int nbd_export_new(BlockExport *blk_exp, BlockDriverState *bs,
                    const char *bitmap, bool readonly, bool shared,
                    bool writethrough, Error **errp);
 void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);
-void nbd_export_close(NBDExport *exp);
 void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
 
 AioContext *nbd_export_aio_context(NBDExport *exp);
 NBDExport *nbd_export_find(const char *name);
-void nbd_export_close_all(void);
 
 void nbd_client_new(QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
diff --git a/block.c b/block.c
index d9ac0e07eb..357c72846e 100644
--- a/block.c
+++ b/block.c
@@ -4424,7 +4424,7 @@ static void bdrv_close(BlockDriverState *bs)
 void bdrv_close_all(void)
 {
     assert(job_next(NULL) == NULL);
-    nbd_export_close_all();
+    blk_exp_close_all();
 
     /* Drop references from requests still in flight, such as canceled block
      * jobs whose AIO context has not been polled yet */
diff --git a/block/export/export.c b/block/export/export.c
index 9de108cbc1..675db9a8b9 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -24,6 +24,9 @@ static const BlockExportDriver* blk_exp_drivers[] = {
     &blk_exp_nbd,
 };
 
+static QLIST_HEAD(, BlockExport) block_exports =
+    QLIST_HEAD_INITIALIZER(block_exports);
+
 static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
 {
     int i;
@@ -60,6 +63,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         return NULL;
     }
 
+    QLIST_INSERT_HEAD(&block_exports, exp, next);
     return exp;
 }
 
@@ -73,11 +77,59 @@ void blk_exp_unref(BlockExport *exp)
 {
     assert(exp->refcount > 0);
     if (--exp->refcount == 0) {
+        QLIST_REMOVE(exp, next);
         exp->drv->delete(exp);
         g_free(exp);
+        aio_wait_kick();
     }
 }
 
+void blk_exp_request_shutdown(BlockExport *exp)
+{
+    AioContext *aio_context = exp->ctx;
+
+    aio_context_acquire(aio_context);
+    exp->drv->request_shutdown(exp);
+    aio_context_release(aio_context);
+}
+
+static bool blk_exp_has_type(BlockExportType type)
+{
+    BlockExport *exp;
+
+    if (type == BLOCK_EXPORT_TYPE__MAX) {
+        return !QLIST_EMPTY(&block_exports);
+    }
+
+    QLIST_FOREACH(exp, &block_exports, next) {
+        if (exp->drv->type == type) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+/* type == BLOCK_EXPORT_TYPE__MAX for all types */
+void blk_exp_close_all_type(BlockExportType type)
+{
+    BlockExport *exp, *next;
+
+    QLIST_FOREACH_SAFE(exp, &block_exports, next, next) {
+        if (type != BLOCK_EXPORT_TYPE__MAX && exp->drv->type != type) {
+            continue;
+        }
+        blk_exp_request_shutdown(exp);
+    }
+
+    AIO_WAIT_WHILE(NULL, blk_exp_has_type(type));
+}
+
+void blk_exp_close_all(void)
+{
+    blk_exp_close_all_type(BLOCK_EXPORT_TYPE__MAX);
+}
+
 void qmp_block_export_add(BlockExportOptions *export, Error **errp)
 {
     blk_exp_add(export, errp);
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index f97deba424..1c7aa874ee 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -277,7 +277,7 @@ void qmp_nbd_server_stop(Error **errp)
         return;
     }
 
-    nbd_export_close_all();
+    blk_exp_close_all_type(BLOCK_EXPORT_TYPE_NBD);
 
     nbd_server_free(nbd_server);
     nbd_server = NULL;
diff --git a/nbd/server.c b/nbd/server.c
index 6a58297557..7e2976b81d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -100,8 +100,6 @@ struct NBDExport {
 };
 
 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
-static QTAILQ_HEAD(, NBDExport) closed_exports =
-        QTAILQ_HEAD_INITIALIZER(closed_exports);
 
 /* NBDExportMetaContexts represents a list of contexts to be exported,
  * as selected by NBD_OPT_SET_META_CONTEXT. Also used for
@@ -1494,12 +1492,8 @@ static void blk_aio_detach(void *opaque)
 static void nbd_eject_notifier(Notifier *n, void *data)
 {
     NBDExport *exp = container_of(n, NBDExport, eject_notifier);
-    AioContext *aio_context;
 
-    aio_context = exp->common.ctx;
-    aio_context_acquire(aio_context);
-    nbd_export_close(exp);
-    aio_context_release(aio_context);
+    blk_exp_request_shutdown(&exp->common);
 }
 
 void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk)
@@ -1652,8 +1646,9 @@ nbd_export_aio_context(NBDExport *exp)
     return exp->common.ctx;
 }
 
-void nbd_export_close(NBDExport *exp)
+static void nbd_export_request_shutdown(BlockExport *blk_exp)
 {
+    NBDExport *exp = container_of(blk_exp, NBDExport, common);
     NBDClient *client, *next;
 
     blk_exp_ref(&exp->common);
@@ -1672,7 +1667,6 @@ void nbd_export_close(NBDExport *exp)
         g_free(exp->name);
         exp->name = NULL;
         QTAILQ_REMOVE(&exports, exp, next);
-        QTAILQ_INSERT_TAIL(&closed_exports, exp, next);
     }
     blk_exp_unref(&exp->common);
 }
@@ -1681,7 +1675,7 @@ void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp)
 {
     ERRP_GUARD();
     if (mode == NBD_SERVER_REMOVE_MODE_HARD || QTAILQ_EMPTY(&exp->clients)) {
-        nbd_export_close(exp);
+        nbd_export_request_shutdown(&exp->common);
         return;
     }
 
@@ -1716,9 +1710,6 @@ static void nbd_export_delete(BlockExport *blk_exp)
         bdrv_dirty_bitmap_set_busy(exp->export_bitmap, false);
         g_free(exp->export_bitmap_context);
     }
-
-    QTAILQ_REMOVE(&closed_exports, exp, next);
-    aio_wait_kick();
 }
 
 const BlockExportDriver blk_exp_nbd = {
@@ -1726,24 +1717,9 @@ const BlockExportDriver blk_exp_nbd = {
     .instance_size      = sizeof(NBDExport),
     .create             = nbd_export_create,
     .delete             = nbd_export_delete,
+    .request_shutdown   = nbd_export_request_shutdown,
 };
 
-void nbd_export_close_all(void)
-{
-    NBDExport *exp, *next;
-    AioContext *aio_context;
-
-    QTAILQ_FOREACH_SAFE(exp, &exports, next, next) {
-        aio_context = exp->common.ctx;
-        aio_context_acquire(aio_context);
-        nbd_export_close(exp);
-        aio_context_release(aio_context);
-    }
-
-    AIO_WAIT_WHILE(NULL, !(QTAILQ_EMPTY(&exports) &&
-                           QTAILQ_EMPTY(&closed_exports)));
-}
-
 static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iovec *iov,
                                         unsigned niov, Error **errp)
 {
diff --git a/qemu-nbd.c b/qemu-nbd.c
index f31868708c..939a08902a 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1110,7 +1110,7 @@ int main(int argc, char **argv)
     do {
         main_loop_wait(false);
         if (state == TERMINATE) {
-            nbd_export_close_all();
+            blk_exp_close_all();
             state = TERMINATED;
         }
     } while (state != TERMINATED);
-- 
2.25.4


