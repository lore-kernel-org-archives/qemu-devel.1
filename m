Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2B6C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F3A2311B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdjZIgVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F3A2311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTy1-0005n1-UW
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAU-0001zO-8e
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAP-0005aY-68
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a1TZ9dN2myeC8AcQFU8fybkeRvbP+s/Dsf6tiiuRN8E=;
 b=bdjZIgVAbYpXA7JS8AA/kWEhbkOGbtHwRbxnhGCumDjCgRJtKHYRJRA8ZRyDHjlSrlyrTb
 cNSekw0NLtSp0vrywNqIsKvk0MWW/5JtQRAYpJWAv2mXh9G1wevO5yc505I6rWHgmL22QP
 T+gQnenkSU7MXmCQPQ4EneMZ9gSG4Fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-jsBLOx0bPqer4uUzISSNFg-1; Thu, 24 Sep 2020 11:28:14 -0400
X-MC-Unique: jsBLOx0bPqer4uUzISSNFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 620F9188C128;
 Thu, 24 Sep 2020 15:28:13 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 222AC60C04;
 Thu, 24 Sep 2020 15:28:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 25/31] block/export: Move writable to BlockExportOptions
Date: Thu, 24 Sep 2020 17:27:11 +0200
Message-Id: <20200924152717.287415-26-kwolf@redhat.com>
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

The 'writable' option is a basic option that will probably be applicable
to most if not all export types that we will implement. Move it from NBD
to the generic BlockExport layer.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-export.json | 15 ++++++++++-----
 block/export/export.c  | 16 +++++++++++++++-
 blockdev-nbd.c         | 18 +++++-------------
 nbd/server.c           |  5 -----
 qemu-nbd.c             |  4 ++--
 5 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 28d4766215..ad01e9f8aa 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -74,9 +74,6 @@
 # @description: Free-form description of the export, up to 4096 bytes.
 #               (Since 5.0)
 #
-# @writable: Whether clients should be able to write to the device via the
-#            NBD connection (default false).
-#
 # @bitmap: Also export the dirty bitmap reachable from @device, so the
 #          NBD client can use NBD_OPT_SET_META_CONTEXT with
 #          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
@@ -85,7 +82,7 @@
 ##
 { 'struct': 'BlockExportOptionsNbd',
   'data': { '*name': 'str', '*description': 'str',
-            '*writable': 'bool', '*bitmap': 'str' } }
+            '*bitmap': 'str' } }
 
 ##
 # @NbdServerAddOptions:
@@ -94,11 +91,15 @@
 #
 # @device: The device name or node name of the node to be exported
 #
+# @writable: Whether clients should be able to write to the device via the
+#            NBD connection (default false).
+#
 # Since: 5.0
 ##
 { 'struct': 'NbdServerAddOptions',
   'base': 'BlockExportOptionsNbd',
-  'data': { 'device': 'str' } }
+  'data': { 'device': 'str',
+            '*writable': 'bool' } }
 
 ##
 # @nbd-server-add:
@@ -188,6 +189,9 @@
 #
 # @node-name: The node name of the block node to be exported (since: 5.2)
 #
+# @writable: True if clients should be able to write to the export
+#            (default false)
+#
 # @writethrough: If true, caches are flushed after every write request to the
 #                export before completion is signalled. (since: 5.2;
 #                default: false)
@@ -198,6 +202,7 @@
   'base': { 'type': 'BlockExportType',
             'id': 'str',
             'node-name': 'str',
+            '*writable': 'bool',
             '*writethrough': 'bool' },
   'discriminator': 'type',
   'data': {
diff --git a/block/export/export.c b/block/export/export.c
index 657bb58b51..f2c00d13bf 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -62,6 +62,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     BlockDriverState *bs;
     BlockBackend *blk;
     AioContext *ctx;
+    uint64_t perm;
     int ret;
 
     if (!id_wellformed(export->id)) {
@@ -84,6 +85,14 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         return NULL;
     }
 
+    if (!export->has_writable) {
+        export->writable = false;
+    }
+    if (bdrv_is_read_only(bs) && export->writable) {
+        error_setg(errp, "Cannot export read-only node as writable");
+        return NULL;
+    }
+
     ctx = bdrv_get_aio_context(bs);
     aio_context_acquire(ctx);
 
@@ -95,7 +104,12 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
      */
     bdrv_invalidate_cache(bs, NULL);
 
-    blk = blk_new(ctx, BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
+    perm = BLK_PERM_CONSISTENT_READ;
+    if (export->writable) {
+        perm |= BLK_PERM_WRITE;
+    }
+
+    blk = blk_new(ctx, perm, BLK_PERM_ALL);
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         goto fail;
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index cdbbcdb958..30e165c23f 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -204,16 +204,8 @@ int nbd_export_create(BlockExport *exp, BlockExportOptions *exp_args,
         return -EEXIST;
     }
 
-    if (!arg->has_writable) {
-        arg->writable = false;
-    }
-    if (blk_is_read_only(exp->blk) && arg->writable) {
-        error_setg(errp, "Cannot export read-only node as writable");
-        return -EINVAL;
-    }
-
     return nbd_export_new(exp, arg->name, arg->description, arg->bitmap,
-                          !arg->writable, !arg->writable, errp);
+                          !exp_args->writable, !exp_args->writable, errp);
 }
 
 void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
@@ -241,13 +233,13 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
         .type                   = BLOCK_EXPORT_TYPE_NBD,
         .id                     = g_strdup(arg->name),
         .node_name              = g_strdup(bdrv_get_node_name(bs)),
+        .has_writable           = arg->has_writable,
+        .writable               = arg->writable,
         .u.nbd = {
             .has_name           = true,
             .name               = g_strdup(arg->name),
             .has_description    = arg->has_description,
             .description        = g_strdup(arg->description),
-            .has_writable       = arg->has_writable,
-            .writable           = arg->writable,
             .has_bitmap         = arg->has_bitmap,
             .bitmap             = g_strdup(arg->bitmap),
         },
@@ -259,8 +251,8 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
      * block-export-add.
      */
     if (bdrv_is_read_only(bs)) {
-        export_opts->u.nbd.has_writable = true;
-        export_opts->u.nbd.writable = false;
+        export_opts->has_writable = true;
+        export_opts->writable = false;
     }
 
     export = blk_exp_add(export_opts, errp);
diff --git a/nbd/server.c b/nbd/server.c
index 6c8532de23..465ec9e762 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1530,11 +1530,6 @@ int nbd_export_new(BlockExport *blk_exp,
     /* Don't allow resize while the NBD server is running, otherwise we don't
      * care what happens with the node. */
     blk_get_perm(blk, &perm, &shared_perm);
-
-    if (!readonly) {
-        perm |= BLK_PERM_WRITE;
-    }
-
     ret = blk_set_perm(blk, perm, shared_perm & ~BLK_PERM_RESIZE, errp);
     if (ret < 0) {
         return ret;
diff --git a/qemu-nbd.c b/qemu-nbd.c
index ac82acb4ac..6d7ac7490f 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1068,13 +1068,13 @@ int main(int argc, char **argv)
         .node_name          = g_strdup(bdrv_get_node_name(bs)),
         .has_writethrough   = true,
         .writethrough       = writethrough,
+        .has_writable       = true,
+        .writable           = !readonly,
         .u.nbd = {
             .has_name           = true,
             .name               = g_strdup(export_name),
             .has_description    = !!export_description,
             .description        = g_strdup(export_description),
-            .has_writable       = true,
-            .writable           = !readonly,
             .has_bitmap         = !!bitmap,
             .bitmap             = g_strdup(bitmap),
         },
-- 
2.25.4


