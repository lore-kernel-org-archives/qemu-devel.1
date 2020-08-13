Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6D0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A616206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efHPQSkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A616206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GGD-0002Un-MY
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7c-0002qi-2D
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7Z-0001QO-Aq
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hteBVefx1cKiiMbxnynTnOE91AMKJvVatWhPz906JBM=;
 b=efHPQSkd6KarXguXB3Qpd/2jErDqNEww4BELxryq0EotGECMpUPYnLc2xRx8Xt7ze41q2i
 TSk6qDhENMuIJPSRKoZwlWehxEliyyQLXKa0pVesQtXCq56SceZhJh8o3jzVCdSfKWFBZB
 4fId92V1tn1KUulODBxI/XV4EVolX7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-e4PrP72lP2yzU5G569-Muw-1; Thu, 13 Aug 2020 12:30:26 -0400
X-MC-Unique: e4PrP72lP2yzU5G569-Muw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D830801AC3;
 Thu, 13 Aug 2020 16:30:25 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B8F65C1A3;
 Thu, 13 Aug 2020 16:30:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 20/22] block/export: Add block-export-del
Date: Thu, 13 Aug 2020 18:29:33 +0200
Message-Id: <20200813162935.210070-21-kwolf@redhat.com>
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

Implement a new QMP command block-export-del and make nbd-server-remove
a wrapper around it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json         | 30 +++++++++++++++----
 include/block/nbd.h            |  1 -
 block/export/export.c          | 54 ++++++++++++++++++++++++++++++++++
 block/monitor/block-hmp-cmds.c |  2 +-
 blockdev-nbd.c                 | 28 ------------------
 nbd/server.c                   | 14 ---------
 6 files changed, 79 insertions(+), 50 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 0d0db9ca1b..a067de2ba3 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -111,9 +111,9 @@
   'data': 'NbdServerAddOptions', 'boxed': true }
 
 ##
-# @NbdServerRemoveMode:
+# @BlockExportRemoveMode:
 #
-# Mode for removing an NBD export.
+# Mode for removing a block export.
 #
 # @safe: Remove export if there are no existing connections, fail otherwise.
 #
@@ -129,16 +129,16 @@
 #
 # Since: 2.12
 ##
-{'enum': 'NbdServerRemoveMode', 'data': ['safe', 'hard']}
+{'enum': 'BlockExportRemoveMode', 'data': ['safe', 'hard']}
 
 ##
 # @nbd-server-remove:
 #
 # Remove NBD export by name.
 #
-# @name: Export name.
+# @name: Block export id.
 #
-# @mode: Mode of command operation. See @NbdServerRemoveMode description.
+# @mode: Mode of command operation. See @BlockExportRemoveMode description.
 #        Default is 'safe'.
 #
 # Returns: error if
@@ -149,7 +149,7 @@
 # Since: 2.12
 ##
 { 'command': 'nbd-server-remove',
-  'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }
+  'data': {'name': 'str', '*mode': 'BlockExportRemoveMode'} }
 
 ##
 # @nbd-server-stop:
@@ -208,3 +208,21 @@
 ##
 { 'command': 'block-export-add',
   'data': 'BlockExportOptions', 'boxed': true }
+
+##
+# @block-export-del:
+#
+# Remove a block export.
+#
+# @id: Block export id.
+#
+# @mode: Mode of command operation. See @BlockExportRemoveMode description.
+#        Default is 'safe'.
+#
+# Returns: Error if the export is not found or @mode is 'safe' and the export
+#          is still in use (e.g. by existing client connections)
+#
+# Since: 5.2
+##
+{ 'command': 'block-export-del',
+  'data': { 'id': 'str', '*mode': 'BlockExportRemoveMode' } }
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 91a9d4f96d..7982a63f96 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -335,7 +335,6 @@ int nbd_export_new(BlockExport *blk_exp, BlockDriverState *bs,
                    const char *bitmap, bool readonly, bool shared,
                    bool writethrough, Error **errp);
 void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);
-void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
 
 AioContext *nbd_export_aio_context(NBDExport *exp);
 NBDExport *nbd_export_find(const char *name);
diff --git a/block/export/export.c b/block/export/export.c
index f94a81258a..1255f3fc80 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -115,6 +115,15 @@ void blk_exp_request_shutdown(BlockExport *exp)
 {
     AioContext *aio_context = exp->ctx;
 
+    /*
+     * If the user doesn't own the export any more, it is already shutting
+     * down. We must not call .request_shutdown and decrease the refcount a
+     * second time.
+     */
+    if (!exp->user_owned) {
+        return;
+    }
+
     aio_context_acquire(aio_context);
     exp->drv->request_shutdown(exp);
     aio_context_release(aio_context);
@@ -215,3 +224,48 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
 fail:
     qapi_free_BlockExportOptions(export_opts);
 }
+
+void qmp_block_export_del(const char *id,
+                          bool has_mode, BlockExportRemoveMode mode,
+                          Error **errp)
+{
+    ERRP_GUARD();
+    BlockExport *exp;
+
+    exp = blk_exp_find(id);
+    if (exp == NULL) {
+        error_setg(errp, "Export '%s' is not found", id);
+        return;
+    }
+    if (!exp->user_owned) {
+        error_setg(errp, "Export '%s' is already shutting down", id);
+        return;
+    }
+
+    if (!has_mode) {
+        mode = BLOCK_EXPORT_REMOVE_MODE_SAFE;
+    }
+    if (mode == BLOCK_EXPORT_REMOVE_MODE_SAFE && exp->refcount > 1) {
+        error_setg(errp, "export '%s' still in use", exp->id);
+        error_append_hint(errp, "Use mode='hard' to force client "
+                          "disconnect\n");
+        return;
+    }
+
+    blk_exp_request_shutdown(exp);
+}
+
+void qmp_nbd_server_remove(const char *name,
+                           bool has_mode, BlockExportRemoveMode mode,
+                           Error **errp)
+{
+    BlockExport *exp;
+
+    exp = blk_exp_find(name);
+    if (exp && exp->drv->type != BLOCK_EXPORT_TYPE_NBD) {
+        error_setg(errp, "Block export '%s' is not an NBD export", name);
+        return;
+    }
+
+    qmp_block_export_del(name, has_mode, mode, errp);
+}
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 6c823234a9..10165252cf 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -477,7 +477,7 @@ void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
 
     /* Rely on NBD_SERVER_REMOVE_MODE_SAFE being the default */
-    qmp_nbd_server_remove(name, force, NBD_SERVER_REMOVE_MODE_HARD, &err);
+    qmp_nbd_server_remove(name, force, BLOCK_EXPORT_REMOVE_MODE_HARD, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 40013b7d64..5ec21045a8 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -237,34 +237,6 @@ int nbd_export_create(BlockExport *exp, BlockExportOptions *exp_args,
     return ret;
 }
 
-void qmp_nbd_server_remove(const char *name,
-                           bool has_mode, NbdServerRemoveMode mode,
-                           Error **errp)
-{
-    NBDExport *exp;
-    AioContext *aio_context;
-
-    if (!nbd_server) {
-        error_setg(errp, "NBD server not running");
-        return;
-    }
-
-    exp = nbd_export_find(name);
-    if (exp == NULL) {
-        error_setg(errp, "Export '%s' is not found", name);
-        return;
-    }
-
-    if (!has_mode) {
-        mode = NBD_SERVER_REMOVE_MODE_SAFE;
-    }
-
-    aio_context = nbd_export_aio_context(exp);
-    aio_context_acquire(aio_context);
-    nbd_export_remove(exp, mode, errp);
-    aio_context_release(aio_context);
-}
-
 void qmp_nbd_server_stop(Error **errp)
 {
     if (!nbd_server) {
diff --git a/nbd/server.c b/nbd/server.c
index e3ac7f548b..899d00782f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1669,20 +1669,6 @@ static void nbd_export_request_shutdown(BlockExport *blk_exp)
     blk_exp_unref(&exp->common);
 }
 
-void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp)
-{
-    ERRP_GUARD();
-    if (mode == NBD_SERVER_REMOVE_MODE_HARD || QTAILQ_EMPTY(&exp->clients)) {
-        nbd_export_request_shutdown(&exp->common);
-        return;
-    }
-
-    assert(mode == NBD_SERVER_REMOVE_MODE_SAFE);
-
-    error_setg(errp, "export '%s' still in use", exp->name);
-    error_append_hint(errp, "Use mode='hard' to force client disconnect\n");
-}
-
 static void nbd_export_delete(BlockExport *blk_exp)
 {
     NBDExport *exp = container_of(blk_exp, NBDExport, common);
-- 
2.25.4


