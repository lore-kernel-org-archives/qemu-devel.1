Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF02C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD84E235FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elJ0EQGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD84E235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTeg-0005dw-Li
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAJ-0001ju-Rt
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAH-0005Yc-UT
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HHZDHrDe8oUdsRH9GAWXVPYaKjDeqf9arQSSCAzBJAw=;
 b=elJ0EQGydhZTI9AxMkBlh2G+DyIogqMaSG5syyuPXu4Pgq1PxLm3jEE9FZsD+7rm1WbEHQ
 9fhtLJnWA7ILFgiC3/OvOIJDfjh5ntwRQCl/0VwsdZZtFsM8nsmI5QJp8jdwntWaXMtxKx
 ZDJPA0hYk6PXZjpyamp+mE7FJvX0BC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-8qCsq76mMce_bdudO4xtHQ-1; Thu, 24 Sep 2020 11:28:05 -0400
X-MC-Unique: 8qCsq76mMce_bdudO4xtHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7C1980EF9F;
 Thu, 24 Sep 2020 15:27:57 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88C2560C04;
 Thu, 24 Sep 2020 15:27:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 15/31] block/export: Add node-name to BlockExportOptions
Date: Thu, 24 Sep 2020 17:27:01 +0200
Message-Id: <20200924152717.287415-16-kwolf@redhat.com>
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

Every block export needs a block node to export, so add a 'node-name'
option to BlockExportOptions and remove the replaced option 'device'
from BlockExportOptionsNbd.

To maintain compatibility in nbd-server-add, BlockExportOptionsNbd needs
to be wrapped by a new type NbdServerAddOptions that adds 'device' back
because nbd-server-add doesn't use the BlockExportOptions base type at
all (so even without changing it to a 'node-name' option in
block-export-add, this compatibility code would be necessary).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-export.json         | 27 ++++++++++++++++-----
 block/monitor/block-hmp-cmds.c |  6 ++---
 blockdev-nbd.c                 | 44 +++++++++++++++++++++++++---------
 qemu-nbd.c                     |  2 +-
 4 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 319a38be88..d20b3a085d 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -65,9 +65,8 @@
 ##
 # @BlockExportOptionsNbd:
 #
-# An NBD block export.
-#
-# @device: The device name or node name of the node to be exported
+# An NBD block export (options shared between nbd-server-add and the NBD branch
+# of block-export-add).
 #
 # @name: Export name. If unspecified, the @device parameter is used as the
 #        export name. (Since 2.12)
@@ -85,8 +84,21 @@
 # Since: 5.0
 ##
 { 'struct': 'BlockExportOptionsNbd',
-  'data': {'device': 'str', '*name': 'str', '*description': 'str',
-           '*writable': 'bool', '*bitmap': 'str' } }
+  'data': { '*name': 'str', '*description': 'str',
+            '*writable': 'bool', '*bitmap': 'str' } }
+
+##
+# @NbdServerAddOptions:
+#
+# An NBD block export.
+#
+# @device: The device name or node name of the node to be exported
+#
+# Since: 5.0
+##
+{ 'struct': 'NbdServerAddOptions',
+  'base': 'BlockExportOptionsNbd',
+  'data': { 'device': 'str' } }
 
 ##
 # @nbd-server-add:
@@ -99,7 +111,7 @@
 # Since: 1.3.0
 ##
 { 'command': 'nbd-server-add',
-  'data': 'BlockExportOptionsNbd', 'boxed': true }
+  'data': 'NbdServerAddOptions', 'boxed': true }
 
 ##
 # @NbdServerRemoveMode:
@@ -170,6 +182,8 @@
 # Describes a block export, i.e. how single node should be exported on an
 # external interface.
 #
+# @node-name: The node name of the block node to be exported (since: 5.2)
+#
 # @writethrough: If true, caches are flushed after every write request to the
 #                export before completion is signalled. (since: 5.2;
 #                default: false)
@@ -178,6 +192,7 @@
 ##
 { 'union': 'BlockExportOptions',
   'base': { 'type': 'BlockExportType',
+            'node-name': 'str',
             '*writethrough': 'bool' },
   'discriminator': 'type',
   'data': {
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 662b7f7d00..db357cafcb 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -398,7 +398,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
     Error *local_err = NULL;
     BlockInfoList *block_list, *info;
     SocketAddress *addr;
-    BlockExportOptionsNbd export;
+    NbdServerAddOptions export;
 
     if (writable && !all) {
         error_setg(&local_err, "-w only valid together with -a");
@@ -431,7 +431,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
             continue;
         }
 
-        export = (BlockExportOptionsNbd) {
+        export = (NbdServerAddOptions) {
             .device         = info->value->device,
             .has_writable   = true,
             .writable       = writable,
@@ -458,7 +458,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
     bool writable = qdict_get_try_bool(qdict, "writable", false);
     Error *local_err = NULL;
 
-    BlockExportOptionsNbd export = {
+    NbdServerAddOptions export = {
         .device         = (char *) device,
         .has_name       = !!name,
         .name           = (char *) name,
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index e208324d42..ef14303b25 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -188,7 +188,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
     }
 
     if (!arg->has_name) {
-        arg->name = arg->device;
+        arg->name = exp_args->node_name;
     }
 
     if (strlen(arg->name) > NBD_MAX_STRING_SIZE) {
@@ -206,7 +206,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
         return NULL;
     }
 
-    bs = bdrv_lookup_bs(arg->device, arg->device, errp);
+    bs = bdrv_lookup_bs(NULL, exp_args->node_name, errp);
     if (!bs) {
         return NULL;
     }
@@ -244,21 +244,40 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
     return (BlockExport*) exp;
 }
 
-void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
+void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
 {
     BlockExport *export;
     BlockDriverState *bs;
     BlockBackend *on_eject_blk;
-    BlockExportOptions export_opts;
+    BlockExportOptions *export_opts;
 
     bs = bdrv_lookup_bs(arg->device, arg->device, errp);
     if (!bs) {
         return;
     }
 
-    export_opts = (BlockExportOptions) {
-        .type = BLOCK_EXPORT_TYPE_NBD,
-        .u.nbd = *arg,
+    /*
+     * block-export-add would default to the node-name, but we may have to use
+     * the device name as a default here for compatibility.
+     */
+    if (!arg->has_name) {
+        arg->name = arg->device;
+    }
+
+    export_opts = g_new(BlockExportOptions, 1);
+    *export_opts = (BlockExportOptions) {
+        .type                   = BLOCK_EXPORT_TYPE_NBD,
+        .node_name              = g_strdup(bdrv_get_node_name(bs)),
+        .u.nbd = {
+            .has_name           = true,
+            .name               = g_strdup(arg->name),
+            .has_description    = arg->has_description,
+            .description        = g_strdup(arg->description),
+            .has_writable       = arg->has_writable,
+            .writable           = arg->writable,
+            .has_bitmap         = arg->has_bitmap,
+            .bitmap             = g_strdup(arg->bitmap),
+        },
     };
 
     /*
@@ -267,13 +286,13 @@ void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
      * block-export-add.
      */
     if (bdrv_is_read_only(bs)) {
-        export_opts.u.nbd.has_writable = true;
-        export_opts.u.nbd.writable = false;
+        export_opts->u.nbd.has_writable = true;
+        export_opts->u.nbd.writable = false;
     }
 
-    export = blk_exp_add(&export_opts, errp);
+    export = blk_exp_add(export_opts, errp);
     if (!export) {
-        return;
+        goto fail;
     }
 
     /*
@@ -284,6 +303,9 @@ void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
     if (on_eject_blk) {
         nbd_export_set_on_eject_blk(export, on_eject_blk);
     }
+
+fail:
+    qapi_free_BlockExportOptions(export_opts);
 }
 
 void qmp_nbd_server_remove(const char *name,
diff --git a/qemu-nbd.c b/qemu-nbd.c
index a863741e8f..23c2b7da8e 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1064,10 +1064,10 @@ int main(int argc, char **argv)
     export_opts = g_new(BlockExportOptions, 1);
     *export_opts = (BlockExportOptions) {
         .type               = BLOCK_EXPORT_TYPE_NBD,
+        .node_name          = g_strdup(bdrv_get_node_name(bs)),
         .has_writethrough   = true,
         .writethrough       = writethrough,
         .u.nbd = {
-            .device             = g_strdup(bdrv_get_node_name(bs)),
             .has_name           = true,
             .name               = g_strdup(export_name),
             .has_description    = !!export_description,
-- 
2.25.4


