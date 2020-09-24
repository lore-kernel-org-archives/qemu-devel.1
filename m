Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA50C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306B2235FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkXrUlf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306B2235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTcU-0003dP-4v
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAf-00020z-N2
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAS-0005bK-Db
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qFnkqNp8153GCDWUq7s5JAE0nwtZ1Ujv1G4YUo9jdvQ=;
 b=LkXrUlf4ysYQdnUW0O+FqzuRFYSALJapOlo7Tv+bdIoR0o+WgzfjApLom8n08pk3M0NpFi
 geMTGjXVoD6zzDhpibLoMbuqUzK/n2e72kMFuplPXcmP7umJ967pBapEVQ7ehTi78yJ5bH
 h/NCijwXQs4YA7rswuvAql8eZuzWVb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-CpoUiRggPTiCZYhc1A_ITA-1; Thu, 24 Sep 2020 11:28:17 -0400
X-MC-Unique: CpoUiRggPTiCZYhc1A_ITA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4631789CD14;
 Thu, 24 Sep 2020 15:28:10 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05A7F60C04;
 Thu, 24 Sep 2020 15:28:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 23/31] block/export: Create BlockBackend in blk_exp_add()
Date: Thu, 24 Sep 2020 17:27:09 +0200
Message-Id: <20200924152717.287415-24-kwolf@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Every export type will need a BlockBackend, so creating it centrally in
blk_exp_add() instead of the .create driver callback avoids duplication.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/nbd.h   |  4 ++--
 block/export/export.c | 49 +++++++++++++++++++++++++++++++++++++++----
 blockdev-nbd.c        | 33 ++++-------------------------
 nbd/server.c          | 38 +++++++++++----------------------
 4 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index a4dc1f9e54..5270b7eadd 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -332,10 +332,10 @@ typedef struct NBDClient NBDClient;
 
 int nbd_export_create(BlockExport *exp, BlockExportOptions *exp_args,
                       Error **errp);
-int nbd_export_new(BlockExport *blk_exp, BlockDriverState *bs,
+int nbd_export_new(BlockExport *blk_exp,
                    const char *name, const char *desc,
                    const char *bitmap, bool readonly, bool shared,
-                   bool writethrough, Error **errp);
+                   Error **errp);
 void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);
 
 AioContext *nbd_export_aio_context(NBDExport *exp);
diff --git a/block/export/export.c b/block/export/export.c
index ad374a6649..8702c233f3 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -58,7 +58,10 @@ static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
 {
     const BlockExportDriver *drv;
-    BlockExport *exp;
+    BlockExport *exp = NULL;
+    BlockDriverState *bs;
+    BlockBackend *blk;
+    AioContext *ctx;
     int ret;
 
     if (!id_wellformed(export->id)) {
@@ -76,6 +79,33 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         return NULL;
     }
 
+    bs = bdrv_lookup_bs(NULL, export->node_name, errp);
+    if (!bs) {
+        return NULL;
+    }
+
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
+
+    /*
+     * Block exports are used for non-shared storage migration. Make sure
+     * that BDRV_O_INACTIVE is cleared and the image is ready for write
+     * access since the export could be available before migration handover.
+     * ctx was acquired in the caller.
+     */
+    bdrv_invalidate_cache(bs, NULL);
+
+    blk = blk_new(ctx, BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
+    ret = blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    if (!export->has_writethrough) {
+        export->writethrough = false;
+    }
+    blk_set_enable_write_cache(blk, !export->writethrough);
+
     assert(drv->instance_size >= sizeof(BlockExport));
     exp = g_malloc0(drv->instance_size);
     *exp = (BlockExport) {
@@ -83,19 +113,30 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         .refcount   = 1,
         .user_owned = true,
         .id         = g_strdup(export->id),
+        .ctx        = ctx,
+        .blk        = blk,
     };
 
     ret = drv->create(exp, export, errp);
     if (ret < 0) {
-        g_free(exp->id);
-        g_free(exp);
-        return NULL;
+        goto fail;
     }
 
     assert(exp->blk != NULL);
 
     QLIST_INSERT_HEAD(&block_exports, exp, next);
+
+    aio_context_release(ctx);
     return exp;
+
+fail:
+    blk_unref(blk);
+    aio_context_release(ctx);
+    if (exp) {
+        g_free(exp->id);
+        g_free(exp);
+    }
+    return NULL;
 }
 
 /* Callers must hold exp->ctx lock */
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 4a9a1be571..cdbbcdb958 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -177,9 +177,6 @@ int nbd_export_create(BlockExport *exp, BlockExportOptions *exp_args,
                       Error **errp)
 {
     BlockExportOptionsNbd *arg = &exp_args->u.nbd;
-    BlockDriverState *bs = NULL;
-    AioContext *aio_context;
-    int ret;
 
     assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
 
@@ -207,38 +204,16 @@ int nbd_export_create(BlockExport *exp, BlockExportOptions *exp_args,
         return -EEXIST;
     }
 
-    bs = bdrv_lookup_bs(NULL, exp_args->node_name, errp);
-    if (!bs) {
-        return -ENOENT;
-    }
-
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
     if (!arg->has_writable) {
         arg->writable = false;
     }
-    if (bdrv_is_read_only(bs) && arg->writable) {
-        ret = -EINVAL;
+    if (blk_is_read_only(exp->blk) && arg->writable) {
         error_setg(errp, "Cannot export read-only node as writable");
-        goto out;
-    }
-
-    if (!exp_args->has_writethrough) {
-        exp_args->writethrough = false;
-    }
-
-    ret = nbd_export_new(exp, bs, arg->name, arg->description, arg->bitmap,
-                         !arg->writable, !arg->writable,
-                         exp_args->writethrough, errp);
-    if (ret < 0) {
-        goto out;
+        return -EINVAL;
     }
 
-    ret = 0;
- out:
-    aio_context_release(aio_context);
-    return ret;
+    return nbd_export_new(exp, arg->name, arg->description, arg->bitmap,
+                          !arg->writable, !arg->writable, errp);
 }
 
 void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
diff --git a/nbd/server.c b/nbd/server.c
index f9af45c480..6c8532de23 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1507,56 +1507,42 @@ void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk)
     blk_add_remove_bs_notifier(blk, &nbd_exp->eject_notifier);
 }
 
-int nbd_export_new(BlockExport *blk_exp, BlockDriverState *bs,
+int nbd_export_new(BlockExport *blk_exp,
                    const char *name, const char *desc,
                    const char *bitmap, bool readonly, bool shared,
-                   bool writethrough, Error **errp)
+                   Error **errp)
 {
     NBDExport *exp = container_of(blk_exp, NBDExport, common);
-    AioContext *ctx;
-    BlockBackend *blk;
+    BlockBackend *blk = blk_exp->blk;
     int64_t size;
-    uint64_t perm;
+    uint64_t perm, shared_perm;
     int ret;
 
-    size = bdrv_getlength(bs);
+    size = blk_getlength(blk);
     if (size < 0) {
         error_setg_errno(errp, -size,
                          "Failed to determine the NBD export's length");
         return size;
     }
 
-    ctx = bdrv_get_aio_context(bs);
-    blk_exp->ctx = ctx;
-
-    /*
-     * NBD exports are used for non-shared storage migration.  Make sure
-     * that BDRV_O_INACTIVE is cleared and the image is ready for write
-     * access since the export could be available before migration handover.
-     * ctx was acquired in the caller.
-     */
     assert(name && strlen(name) <= NBD_MAX_STRING_SIZE);
 
-    bdrv_invalidate_cache(bs, NULL);
-
     /* Don't allow resize while the NBD server is running, otherwise we don't
      * care what happens with the node. */
-    perm = BLK_PERM_CONSISTENT_READ;
+    blk_get_perm(blk, &perm, &shared_perm);
+
     if (!readonly) {
         perm |= BLK_PERM_WRITE;
     }
-    blk = blk_new(ctx, perm,
-                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
-                  BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD);
-    ret = blk_insert_bs(blk, bs, errp);
+
+    ret = blk_set_perm(blk, perm, shared_perm & ~BLK_PERM_RESIZE, errp);
     if (ret < 0) {
-        goto fail;
+        return ret;
     }
-    blk_set_enable_write_cache(blk, !writethrough);
+
     blk_set_allow_aio_context_change(blk, true);
 
     QTAILQ_INIT(&exp->clients);
-    exp->common.blk = blk;
     exp->name = g_strdup(name);
     assert(!desc || strlen(desc) <= NBD_MAX_STRING_SIZE);
     exp->description = g_strdup(desc);
@@ -1574,6 +1560,7 @@ int nbd_export_new(BlockExport *blk_exp, BlockDriverState *bs,
     exp->size = QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);
 
     if (bitmap) {
+        BlockDriverState *bs = blk_bs(blk);
         BdrvDirtyBitmap *bm = NULL;
 
         while (bs) {
@@ -1620,7 +1607,6 @@ int nbd_export_new(BlockExport *blk_exp, BlockDriverState *bs,
     return 0;
 
 fail:
-    blk_unref(blk);
     g_free(exp->name);
     g_free(exp->description);
     return ret;
-- 
2.25.4


