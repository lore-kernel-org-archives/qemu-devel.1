Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C438C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54A02311B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h74LQ/fZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54A02311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLU1f-00010j-Qo
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAp-00025D-OJ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAj-0005cE-CW
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vtAwkx6Ac6RtCGipau0FOuUrS26ng5ynJS079mcJkU=;
 b=h74LQ/fZL8u0u+crgaiz3YZojDbgXIXqgNT12LD/UrbGiEg6AiL3Jc04qnWMpR2tu3AVlQ
 LPtDXtsXkcAxdkn41DLc6fkj0Ngn+d/WwS4za2yfIyf2yFv/1AuniijQOoajUwOJGBN2iE
 Lk/vqpYvg8MOln3WnUNfz/XAL9xSSjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-0g88eIFoPtW0w24BjIHEbg-1; Thu, 24 Sep 2020 11:28:21 -0400
X-MC-Unique: 0g88eIFoPtW0w24BjIHEbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC1F681CBE3;
 Thu, 24 Sep 2020 15:28:14 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA71A60C04;
 Thu, 24 Sep 2020 15:28:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 26/31] nbd: Merge nbd_export_new() and nbd_export_create()
Date: Thu, 24 Sep 2020 17:27:12 +0200
Message-Id: <20200924152717.287415-27-kwolf@redhat.com>
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

There is no real reason any more why nbd_export_new() and
nbd_export_create() should be separate functions. The latter only
performs a few checks before it calls the former.

What makes the current state stand out is that it's the only function in
BlockExportDriver that is not a static function inside nbd/server.c, but
a small wrapper in blockdev-nbd.c that then calls back into nbd/server.c
for the real functionality.

Move all the checks to nbd/server.c and make the resulting function
static to improve readability.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/nbd.h |  7 +-----
 blockdev-nbd.c      | 40 +++++----------------------------
 nbd/server.c        | 54 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 45 insertions(+), 56 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 5270b7eadd..3dd9a04546 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -330,12 +330,6 @@ int nbd_errno_to_system_errno(int err);
 typedef struct NBDExport NBDExport;
 typedef struct NBDClient NBDClient;
 
-int nbd_export_create(BlockExport *exp, BlockExportOptions *exp_args,
-                      Error **errp);
-int nbd_export_new(BlockExport *blk_exp,
-                   const char *name, const char *desc,
-                   const char *bitmap, bool readonly, bool shared,
-                   Error **errp);
 void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);
 
 AioContext *nbd_export_aio_context(NBDExport *exp);
@@ -349,6 +343,7 @@ void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);
 
 void nbd_server_is_qemu_nbd(bool value);
+bool nbd_server_is_running(void);
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
                       const char *tls_authz, uint32_t max_connections,
                       Error **errp);
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 30e165c23f..8174023e5c 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -37,6 +37,11 @@ void nbd_server_is_qemu_nbd(bool value)
     is_qemu_nbd = value;
 }
 
+bool nbd_server_is_running(void)
+{
+    return nbd_server || is_qemu_nbd;
+}
+
 static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
 {
     nbd_client_put(client);
@@ -173,41 +178,6 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
     qapi_free_SocketAddress(addr_flat);
 }
 
-int nbd_export_create(BlockExport *exp, BlockExportOptions *exp_args,
-                      Error **errp)
-{
-    BlockExportOptionsNbd *arg = &exp_args->u.nbd;
-
-    assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
-
-    if (!nbd_server && !is_qemu_nbd) {
-        error_setg(errp, "NBD server not running");
-        return -EINVAL;
-    }
-
-    if (!arg->has_name) {
-        arg->name = exp_args->node_name;
-    }
-
-    if (strlen(arg->name) > NBD_MAX_STRING_SIZE) {
-        error_setg(errp, "export name '%s' too long", arg->name);
-        return -EINVAL;
-    }
-
-    if (arg->description && strlen(arg->description) > NBD_MAX_STRING_SIZE) {
-        error_setg(errp, "description '%s' too long", arg->description);
-        return -EINVAL;
-    }
-
-    if (nbd_export_find(arg->name)) {
-        error_setg(errp, "NBD server already has export named '%s'", arg->name);
-        return -EEXIST;
-    }
-
-    return nbd_export_new(exp, arg->name, arg->description, arg->bitmap,
-                          !exp_args->writable, !exp_args->writable, errp);
-}
-
 void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
 {
     BlockExport *export;
diff --git a/nbd/server.c b/nbd/server.c
index 465ec9e762..f74766add7 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1507,17 +1507,44 @@ void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk)
     blk_add_remove_bs_notifier(blk, &nbd_exp->eject_notifier);
 }
 
-int nbd_export_new(BlockExport *blk_exp,
-                   const char *name, const char *desc,
-                   const char *bitmap, bool readonly, bool shared,
-                   Error **errp)
+static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
+                             Error **errp)
 {
     NBDExport *exp = container_of(blk_exp, NBDExport, common);
+    BlockExportOptionsNbd *arg = &exp_args->u.nbd;
     BlockBackend *blk = blk_exp->blk;
     int64_t size;
     uint64_t perm, shared_perm;
+    bool readonly = !exp_args->writable;
+    bool shared = !exp_args->writable;
     int ret;
 
+    assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
+
+    if (!nbd_server_is_running()) {
+        error_setg(errp, "NBD server not running");
+        return -EINVAL;
+    }
+
+    if (!arg->has_name) {
+        arg->name = exp_args->node_name;
+    }
+
+    if (strlen(arg->name) > NBD_MAX_STRING_SIZE) {
+        error_setg(errp, "export name '%s' too long", arg->name);
+        return -EINVAL;
+    }
+
+    if (arg->description && strlen(arg->description) > NBD_MAX_STRING_SIZE) {
+        error_setg(errp, "description '%s' too long", arg->description);
+        return -EINVAL;
+    }
+
+    if (nbd_export_find(arg->name)) {
+        error_setg(errp, "NBD server already has export named '%s'", arg->name);
+        return -EEXIST;
+    }
+
     size = blk_getlength(blk);
     if (size < 0) {
         error_setg_errno(errp, -size,
@@ -1525,8 +1552,6 @@ int nbd_export_new(BlockExport *blk_exp,
         return size;
     }
 
-    assert(name && strlen(name) <= NBD_MAX_STRING_SIZE);
-
     /* Don't allow resize while the NBD server is running, otherwise we don't
      * care what happens with the node. */
     blk_get_perm(blk, &perm, &shared_perm);
@@ -1538,9 +1563,8 @@ int nbd_export_new(BlockExport *blk_exp,
     blk_set_allow_aio_context_change(blk, true);
 
     QTAILQ_INIT(&exp->clients);
-    exp->name = g_strdup(name);
-    assert(!desc || strlen(desc) <= NBD_MAX_STRING_SIZE);
-    exp->description = g_strdup(desc);
+    exp->name = g_strdup(arg->name);
+    exp->description = g_strdup(arg->description);
     exp->nbdflags = (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_FLUSH |
                      NBD_FLAG_SEND_FUA | NBD_FLAG_SEND_CACHE);
     if (readonly) {
@@ -1554,12 +1578,12 @@ int nbd_export_new(BlockExport *blk_exp,
     }
     exp->size = QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);
 
-    if (bitmap) {
+    if (arg->bitmap) {
         BlockDriverState *bs = blk_bs(blk);
         BdrvDirtyBitmap *bm = NULL;
 
         while (bs) {
-            bm = bdrv_find_dirty_bitmap(bs, bitmap);
+            bm = bdrv_find_dirty_bitmap(bs, arg->bitmap);
             if (bm != NULL) {
                 break;
             }
@@ -1569,7 +1593,7 @@ int nbd_export_new(BlockExport *blk_exp,
 
         if (bm == NULL) {
             ret = -ENOENT;
-            error_setg(errp, "Bitmap '%s' is not found", bitmap);
+            error_setg(errp, "Bitmap '%s' is not found", arg->bitmap);
             goto fail;
         }
 
@@ -1583,15 +1607,15 @@ int nbd_export_new(BlockExport *blk_exp,
             ret = -EINVAL;
             error_setg(errp,
                        "Enabled bitmap '%s' incompatible with readonly export",
-                       bitmap);
+                       arg->bitmap);
             goto fail;
         }
 
         bdrv_dirty_bitmap_set_busy(bm, true);
         exp->export_bitmap = bm;
-        assert(strlen(bitmap) <= BDRV_BITMAP_MAX_NAME_SIZE);
+        assert(strlen(arg->bitmap) <= BDRV_BITMAP_MAX_NAME_SIZE);
         exp->export_bitmap_context = g_strdup_printf("qemu:dirty-bitmap:%s",
-                                                     bitmap);
+                                                     arg->bitmap);
         assert(strlen(exp->export_bitmap_context) < NBD_MAX_STRING_SIZE);
     }
 
-- 
2.25.4


