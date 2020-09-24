Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C144BC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1E723741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wk5tN1Iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1E723741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLU52-00048r-31
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAN-0001t4-8N
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAJ-0005Yx-Ka
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apkF663sOIIWl417cGvjjoKlUitNnQ9/ioG8wVLrsA0=;
 b=Wk5tN1IzsNsXdsey0nPUiD/ZS5LfyQisA2bJiKhLxfd0bCGSzDZiVqIk9qMYhCJLQEYvc3
 ODKRc6lJPYfUQ7/Ng9dFj+lEUjIpbufQmel8UNRQ5dodc9U9c1GPz05yR9n1gSPIcY5qGO
 Lx1n0Z1YzvgYbKWv1dioXpZIw43LriY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-rhfmw1vWM-ynInqd80qBHQ-1; Thu, 24 Sep 2020 11:28:06 -0400
X-MC-Unique: rhfmw1vWM-ynInqd80qBHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95E8B88EF22;
 Thu, 24 Sep 2020 15:28:05 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54D6D60C04;
 Thu, 24 Sep 2020 15:28:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 20/31] block/export: Add block-export-del
Date: Thu, 24 Sep 2020 17:27:06 +0200
Message-Id: <20200924152717.287415-21-kwolf@redhat.com>
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

Implement a new QMP command block-export-del and make nbd-server-remove
a wrapper around it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-export.json         | 32 ++++++++++++++++++++-----
 include/block/export.h         |  1 +
 include/block/nbd.h            |  1 -
 block/export/export.c          | 43 +++++++++++++++++++++++++++++++++-
 block/monitor/block-hmp-cmds.c |  4 ++--
 blockdev-nbd.c                 | 25 +++++---------------
 nbd/server.c                   | 14 -----------
 7 files changed, 77 insertions(+), 43 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 47c75a1794..0ba4d84c97 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -116,9 +116,9 @@
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
@@ -134,16 +134,16 @@
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
@@ -154,7 +154,7 @@
 # Since: 2.12
 ##
 { 'command': 'nbd-server-remove',
-  'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }
+  'data': {'name': 'str', '*mode': 'BlockExportRemoveMode'} }
 
 ##
 # @nbd-server-stop:
@@ -213,3 +213,23 @@
 ##
 { 'command': 'block-export-add',
   'data': 'BlockExportOptions', 'boxed': true }
+
+##
+# @block-export-del:
+#
+# Request to remove a block export. This drops the user's reference to the
+# export, but the export may still stay around after this command returns until
+# the shutdown of the export has completed.
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
diff --git a/include/block/export.h b/include/block/export.h
index 4833947e89..ff54d35872 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -76,6 +76,7 @@ struct BlockExport {
 };
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
+BlockExport *blk_exp_find(const char *id);
 void blk_exp_ref(BlockExport *exp);
 void blk_exp_unref(BlockExport *exp);
 void blk_exp_request_shutdown(BlockExport *exp);
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 0b9f3e5d4e..a4dc1f9e54 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -337,7 +337,6 @@ int nbd_export_new(BlockExport *blk_exp, BlockDriverState *bs,
                    const char *bitmap, bool readonly, bool shared,
                    bool writethrough, Error **errp);
 void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);
-void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
 
 AioContext *nbd_export_aio_context(NBDExport *exp);
 NBDExport *nbd_export_find(const char *name);
diff --git a/block/export/export.c b/block/export/export.c
index 62699dfa05..d186beffe9 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -29,7 +29,7 @@ static const BlockExportDriver *blk_exp_drivers[] = {
 static QLIST_HEAD(, BlockExport) block_exports =
     QLIST_HEAD_INITIALIZER(block_exports);
 
-static BlockExport *blk_exp_find(const char *id)
+BlockExport *blk_exp_find(const char *id)
 {
     BlockExport *exp;
 
@@ -143,12 +143,23 @@ void blk_exp_request_shutdown(BlockExport *exp)
     AioContext *aio_context = exp->ctx;
 
     aio_context_acquire(aio_context);
+
+    /*
+     * If the user doesn't own the export any more, it is already shutting
+     * down. We must not call .request_shutdown and decrease the refcount a
+     * second time.
+     */
+    if (!exp->user_owned) {
+        goto out;
+    }
+
     exp->drv->request_shutdown(exp);
 
     assert(exp->user_owned);
     exp->user_owned = false;
     blk_exp_unref(exp);
 
+out:
     aio_context_release(aio_context);
 }
 
@@ -199,3 +210,33 @@ void qmp_block_export_add(BlockExportOptions *export, Error **errp)
 {
     blk_exp_add(export, errp);
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
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index db357cafcb..d15a2be827 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -476,8 +476,8 @@ void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict)
     bool force = qdict_get_try_bool(qdict, "force", false);
     Error *err = NULL;
 
-    /* Rely on NBD_SERVER_REMOVE_MODE_SAFE being the default */
-    qmp_nbd_server_remove(name, force, NBD_SERVER_REMOVE_MODE_HARD, &err);
+    /* Rely on BLOCK_EXPORT_REMOVE_MODE_SAFE being the default */
+    qmp_nbd_server_remove(name, force, BLOCK_EXPORT_REMOVE_MODE_HARD, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 9efbaef8f7..4a9a1be571 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -307,31 +307,18 @@ fail:
 }
 
 void qmp_nbd_server_remove(const char *name,
-                           bool has_mode, NbdServerRemoveMode mode,
+                           bool has_mode, BlockExportRemoveMode mode,
                            Error **errp)
 {
-    NBDExport *exp;
-    AioContext *aio_context;
-
-    if (!nbd_server) {
-        error_setg(errp, "NBD server not running");
-        return;
-    }
+    BlockExport *exp;
 
-    exp = nbd_export_find(name);
-    if (exp == NULL) {
-        error_setg(errp, "Export '%s' is not found", name);
+    exp = blk_exp_find(name);
+    if (exp && exp->drv->type != BLOCK_EXPORT_TYPE_NBD) {
+        error_setg(errp, "Block export '%s' is not an NBD export", name);
         return;
     }
 
-    if (!has_mode) {
-        mode = NBD_SERVER_REMOVE_MODE_SAFE;
-    }
-
-    aio_context = nbd_export_aio_context(exp);
-    aio_context_acquire(aio_context);
-    nbd_export_remove(exp, mode, errp);
-    aio_context_release(aio_context);
+    qmp_block_export_del(name, has_mode, mode, errp);
 }
 
 void qmp_nbd_server_stop(Error **errp)
diff --git a/nbd/server.c b/nbd/server.c
index 22a1d66168..1a0e1db401 100644
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


