Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7BDC2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE712395C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoP/09qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE712395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTaH-0001dK-Ol
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAE-0001W1-QC
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAB-0005Ww-AK
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pf2PAz2JNwk4y16xrrrFoPYHte06nf0NXa26OsZPjys=;
 b=UoP/09qurL2n2t7dhYyLzZrfjjBCh0FRUnsOq+M2mke2VRzhzp87ckzdY34I82xiAsByl+
 o1Iw4HSbksyu+vAFS2MdyxDNIctVgIkCQIXOHIwrE29B7NxNMKvzZGRrPGuV1J1e1WbEL6
 xznz++tvhiBEGjIT9krlj7Zt6lzC6AM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-Bxq7QPzvOiSA7tn8UJ1MmQ-1; Thu, 24 Sep 2020 11:28:00 -0400
X-MC-Unique: Bxq7QPzvOiSA7tn8UJ1MmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CE8219611BC;
 Thu, 24 Sep 2020 15:27:59 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BB1C60C04;
 Thu, 24 Sep 2020 15:27:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 16/31] block/export: Allocate BlockExport in blk_exp_add()
Date: Thu, 24 Sep 2020 17:27:02 +0200
Message-Id: <20200924152717.287415-17-kwolf@redhat.com>
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

Instead of letting the driver allocate and return the BlockExport
object, allocate it already in blk_exp_add() and pass it. This allows us
to initialise the generic part before calling into the driver so that
the driver can just use these values instead of having to parse the
options a second time.

For symmetry, move freeing the BlockExport to blk_exp_unref().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/export.h |  8 +++++++-
 include/block/nbd.h    | 11 ++++++-----
 block/export/export.c  | 18 +++++++++++++++++-
 blockdev-nbd.c         | 26 ++++++++++++++------------
 nbd/server.c           | 30 +++++++++++++-----------------
 5 files changed, 57 insertions(+), 36 deletions(-)

diff --git a/include/block/export.h b/include/block/export.h
index e6f96f4e1e..cf9b1c9dad 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -22,8 +22,14 @@ typedef struct BlockExportDriver {
     /* The export type that this driver services */
     BlockExportType type;
 
+    /*
+     * The size of the driver-specific state that contains BlockExport as its
+     * first field.
+     */
+    size_t instance_size;
+
     /* Creates and starts a new block export */
-    BlockExport *(*create)(BlockExportOptions *, Error **);
+    int (*create)(BlockExport *, BlockExportOptions *, Error **);
 
     /*
      * Frees a removed block export. This function is only called after all
diff --git a/include/block/nbd.h b/include/block/nbd.h
index e3bd112227..fc2c153d5b 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -330,11 +330,12 @@ int nbd_errno_to_system_errno(int err);
 typedef struct NBDExport NBDExport;
 typedef struct NBDClient NBDClient;
 
-BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp);
-NBDExport *nbd_export_new(BlockDriverState *bs,
-                          const char *name, const char *desc,
-                          const char *bitmap, bool readonly, bool shared,
-                          bool writethrough, Error **errp);
+int nbd_export_create(BlockExport *exp, BlockExportOptions *exp_args,
+                      Error **errp);
+int nbd_export_new(BlockExport *blk_exp, BlockDriverState *bs,
+                   const char *name, const char *desc,
+                   const char *bitmap, bool readonly, bool shared,
+                   bool writethrough, Error **errp);
 void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);
 void nbd_export_close(NBDExport *exp);
 void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
diff --git a/block/export/export.c b/block/export/export.c
index 8635318ef1..6b2b29078b 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -39,6 +39,8 @@ static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
 {
     const BlockExportDriver *drv;
+    BlockExport *exp;
+    int ret;
 
     drv = blk_exp_find_driver(export->type);
     if (!drv) {
@@ -46,7 +48,20 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         return NULL;
     }
 
-    return drv->create(export, errp);
+    assert(drv->instance_size >= sizeof(BlockExport));
+    exp = g_malloc0(drv->instance_size);
+    *exp = (BlockExport) {
+        .drv        = drv,
+        .refcount   = 1,
+    };
+
+    ret = drv->create(exp, export, errp);
+    if (ret < 0) {
+        g_free(exp);
+        return NULL;
+    }
+
+    return exp;
 }
 
 /* Callers must hold exp->ctx lock */
@@ -62,6 +77,7 @@ void blk_exp_unref(BlockExport *exp)
     assert(exp->refcount > 0);
     if (--exp->refcount == 0) {
         exp->drv->delete(exp);
+        g_free(exp);
     }
 }
 
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index ef14303b25..b34f159888 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -173,18 +173,19 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
     qapi_free_SocketAddress(addr_flat);
 }
 
-BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
+int nbd_export_create(BlockExport *exp, BlockExportOptions *exp_args,
+                      Error **errp)
 {
     BlockExportOptionsNbd *arg = &exp_args->u.nbd;
     BlockDriverState *bs = NULL;
-    NBDExport *exp = NULL;
     AioContext *aio_context;
+    int ret;
 
     assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
 
     if (!nbd_server && !is_qemu_nbd) {
         error_setg(errp, "NBD server not running");
-        return NULL;
+        return -EINVAL;
     }
 
     if (!arg->has_name) {
@@ -193,22 +194,22 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
 
     if (strlen(arg->name) > NBD_MAX_STRING_SIZE) {
         error_setg(errp, "export name '%s' too long", arg->name);
-        return NULL;
+        return -EINVAL;
     }
 
     if (arg->description && strlen(arg->description) > NBD_MAX_STRING_SIZE) {
         error_setg(errp, "description '%s' too long", arg->description);
-        return NULL;
+        return -EINVAL;
     }
 
     if (nbd_export_find(arg->name)) {
         error_setg(errp, "NBD server already has export named '%s'", arg->name);
-        return NULL;
+        return -EEXIST;
     }
 
     bs = bdrv_lookup_bs(NULL, exp_args->node_name, errp);
     if (!bs) {
-        return NULL;
+        return -ENOENT;
     }
 
     aio_context = bdrv_get_aio_context(bs);
@@ -218,6 +219,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
         arg->writable = false;
     }
     if (bdrv_is_read_only(bs) && arg->writable) {
+        ret = -EINVAL;
         error_setg(errp, "Cannot export read-only node as writable");
         goto out;
     }
@@ -226,22 +228,22 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
         exp_args->writethrough = false;
     }
 
-    exp = nbd_export_new(bs, arg->name, arg->description, arg->bitmap,
+    ret = nbd_export_new(exp, bs, arg->name, arg->description, arg->bitmap,
                          !arg->writable, !arg->writable,
                          exp_args->writethrough, errp);
-    if (!exp) {
+    if (ret < 0) {
         goto out;
     }
 
     /* The list of named exports has a strong reference to this export now and
      * our only way of accessing it is through nbd_export_find(), so we can drop
      * the strong reference that is @exp. */
-    blk_exp_unref((BlockExport*) exp);
+    blk_exp_unref(exp);
 
+    ret = 0;
  out:
     aio_context_release(aio_context);
-    /* TODO Remove the cast: nbd_export_new() will return a BlockExport. */
-    return (BlockExport*) exp;
+    return ret;
 }
 
 void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
diff --git a/nbd/server.c b/nbd/server.c
index 7cf81646fc..f31d8bbb60 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1514,14 +1514,14 @@ void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk)
     blk_add_remove_bs_notifier(blk, &nbd_exp->eject_notifier);
 }
 
-NBDExport *nbd_export_new(BlockDriverState *bs,
-                          const char *name, const char *desc,
-                          const char *bitmap, bool readonly, bool shared,
-                          bool writethrough, Error **errp)
+int nbd_export_new(BlockExport *blk_exp, BlockDriverState *bs,
+                   const char *name, const char *desc,
+                   const char *bitmap, bool readonly, bool shared,
+                   bool writethrough, Error **errp)
 {
+    NBDExport *exp = container_of(blk_exp, NBDExport, common);
     AioContext *ctx;
     BlockBackend *blk;
-    NBDExport *exp;
     int64_t size;
     uint64_t perm;
     int ret;
@@ -1530,17 +1530,11 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
     if (size < 0) {
         error_setg_errno(errp, -size,
                          "Failed to determine the NBD export's length");
-        return NULL;
+        return size;
     }
 
     ctx = bdrv_get_aio_context(bs);
-
-    exp = g_new0(NBDExport, 1);
-    exp->common = (BlockExport) {
-        .drv        = &blk_exp_nbd,
-        .refcount   = 1,
-        .ctx        = ctx,
-    };
+    blk_exp->ctx = ctx;
 
     /*
      * NBD exports are used for non-shared storage migration.  Make sure
@@ -1599,16 +1593,19 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
         }
 
         if (bm == NULL) {
+            ret = -ENOENT;
             error_setg(errp, "Bitmap '%s' is not found", bitmap);
             goto fail;
         }
 
         if (bdrv_dirty_bitmap_check(bm, BDRV_BITMAP_ALLOW_RO, errp)) {
+            ret = -EINVAL;
             goto fail;
         }
 
         if (readonly && bdrv_is_writable(bs) &&
             bdrv_dirty_bitmap_enabled(bm)) {
+            ret = -EINVAL;
             error_setg(errp,
                        "Enabled bitmap '%s' incompatible with readonly export",
                        bitmap);
@@ -1628,14 +1625,13 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
     blk_exp_ref(&exp->common);
     QTAILQ_INSERT_TAIL(&exports, exp, next);
 
-    return exp;
+    return 0;
 
 fail:
     blk_unref(blk);
     g_free(exp->name);
     g_free(exp->description);
-    g_free(exp);
-    return NULL;
+    return ret;
 }
 
 NBDExport *nbd_export_find(const char *name)
@@ -1722,12 +1718,12 @@ static void nbd_export_delete(BlockExport *blk_exp)
     }
 
     QTAILQ_REMOVE(&closed_exports, exp, next);
-    g_free(exp);
     aio_wait_kick();
 }
 
 const BlockExportDriver blk_exp_nbd = {
     .type               = BLOCK_EXPORT_TYPE_NBD,
+    .instance_size      = sizeof(NBDExport),
     .create             = nbd_export_create,
     .delete             = nbd_export_delete,
 };
-- 
2.25.4


