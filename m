Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B491FC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CFC23600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZY7Zvq8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CFC23600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLToO-0006Oh-T4
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAP-0001vH-GS
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTAM-0005Zo-Sv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bt9NlHVtgw83UMElicWV85EwG7RTeP1PpRDhpMnq+qo=;
 b=ZY7Zvq8a+jykwmuYuRf9UUD4wIMvZWpHrgLIwfPSeCW53hDSOyoxMWJdIql4eVRyb3yZqL
 Kkv7Jduoq4UcA/1Oi53xAnSIh/6O7YAcQS7D68q8I/CqlAQmbuNlFfx7jXLwQ0e6lWHlHx
 4ghC33+qiAiD7dR3fYMzC0zKI1+T678=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-nBfJVxxmPoOPzJ7i4jjHfA-1; Thu, 24 Sep 2020 11:28:12 -0400
X-MC-Unique: nBfJVxxmPoOPzJ7i4jjHfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 787BFAD509;
 Thu, 24 Sep 2020 15:28:02 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 399E060C04;
 Thu, 24 Sep 2020 15:28:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 18/31] block/export: Add 'id' option to block-export-add
Date: Thu, 24 Sep 2020 17:27:04 +0200
Message-Id: <20200924152717.287415-19-kwolf@redhat.com>
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

We'll need an id to identify block exports in monitor commands. This
adds one.

Note that this is different from the 'name' option in the NBD server,
which is the externally visible export name. While block export ids need
to be unique in the whole process, export names must be unique only for
the same server. Different export types or (potentially in the future)
multiple NBD servers can have the same export name externally, but still
need different block export ids internally.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-export.json               |  5 +++++
 include/block/export.h               |  3 +++
 block/export/export.c                | 26 ++++++++++++++++++++++++++
 blockdev-nbd.c                       |  1 +
 qemu-nbd.c                           |  1 +
 storage-daemon/qemu-storage-daemon.c |  2 +-
 tests/qemu-iotests/223.out           |  4 ++--
 7 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index d20b3a085d..47c75a1794 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -105,6 +105,8 @@
 #
 # Export a block node to QEMU's embedded NBD server.
 #
+# The export name will be used as the id for the resulting block export.
+#
 # Returns: error if the server is not running, or export with the same name
 #          already exists.
 #
@@ -182,6 +184,8 @@
 # Describes a block export, i.e. how single node should be exported on an
 # external interface.
 #
+# @id: A unique identifier for the block export (across all export types)
+#
 # @node-name: The node name of the block node to be exported (since: 5.2)
 #
 # @writethrough: If true, caches are flushed after every write request to the
@@ -192,6 +196,7 @@
 ##
 { 'union': 'BlockExportOptions',
   'base': { 'type': 'BlockExportType',
+            'id': 'str',
             'node-name': 'str',
             '*writethrough': 'bool' },
   'discriminator': 'type',
diff --git a/include/block/export.h b/include/block/export.h
index 6fffcb5651..cdc6e161ea 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -50,6 +50,9 @@ typedef struct BlockExportDriver {
 struct BlockExport {
     const BlockExportDriver *drv;
 
+    /* Unique identifier for the export */
+    char *id;
+
     /*
      * Reference count for this block export. This includes strong references
      * both from the owner (qemu-nbd or the monitor) and clients connected to
diff --git a/block/export/export.c b/block/export/export.c
index e94a68c183..7a4a78449a 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -19,6 +19,7 @@
 #include "block/nbd.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-export.h"
+#include "qemu/id.h"
 
 static const BlockExportDriver *blk_exp_drivers[] = {
     &blk_exp_nbd,
@@ -28,6 +29,19 @@ static const BlockExportDriver *blk_exp_drivers[] = {
 static QLIST_HEAD(, BlockExport) block_exports =
     QLIST_HEAD_INITIALIZER(block_exports);
 
+static BlockExport *blk_exp_find(const char *id)
+{
+    BlockExport *exp;
+
+    QLIST_FOREACH(exp, &block_exports, next) {
+        if (strcmp(id, exp->id) == 0) {
+            return exp;
+        }
+    }
+
+    return NULL;
+}
+
 static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
 {
     int i;
@@ -46,6 +60,15 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     BlockExport *exp;
     int ret;
 
+    if (!id_wellformed(export->id)) {
+        error_setg(errp, "Invalid block export id");
+        return NULL;
+    }
+    if (blk_exp_find(export->id)) {
+        error_setg(errp, "Block export id '%s' is already in use", export->id);
+        return NULL;
+    }
+
     drv = blk_exp_find_driver(export->type);
     if (!drv) {
         error_setg(errp, "No driver found for the requested export type");
@@ -57,10 +80,12 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     *exp = (BlockExport) {
         .drv        = drv,
         .refcount   = 1,
+        .id         = g_strdup(export->id),
     };
 
     ret = drv->create(exp, export, errp);
     if (ret < 0) {
+        g_free(exp->id);
         g_free(exp);
         return NULL;
     }
@@ -87,6 +112,7 @@ static void blk_exp_delete_bh(void *opaque)
     assert(exp->refcount == 0);
     QLIST_REMOVE(exp, next);
     exp->drv->delete(exp);
+    g_free(exp->id);
     g_free(exp);
 
     aio_context_release(aio_context);
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index f927264777..814554dd90 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -269,6 +269,7 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
     export_opts = g_new(BlockExportOptions, 1);
     *export_opts = (BlockExportOptions) {
         .type                   = BLOCK_EXPORT_TYPE_NBD,
+        .id                     = g_strdup(arg->name),
         .node_name              = g_strdup(bdrv_get_node_name(bs)),
         .u.nbd = {
             .has_name           = true,
diff --git a/qemu-nbd.c b/qemu-nbd.c
index c64f83618b..ac82acb4ac 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1064,6 +1064,7 @@ int main(int argc, char **argv)
     export_opts = g_new(BlockExportOptions, 1);
     *export_opts = (BlockExportOptions) {
         .type               = BLOCK_EXPORT_TYPE_NBD,
+        .id                 = g_strdup("qemu-nbd-export"),
         .node_name          = g_strdup(bdrv_get_node_name(bs)),
         .has_writethrough   = true,
         .writethrough       = writethrough,
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index 0fcab6ed2d..e6157ff518 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -92,7 +92,7 @@ static void help(void)
 "  --chardev <options>    configure a character device backend\n"
 "                         (see the qemu(1) man page for possible options)\n"
 "\n"
-"  --export [type=]nbd,device=<node-name>[,name=<export-name>]\n"
+"  --export [type=]nbd,device=<node-name>,id=<id>,[,name=<export-name>]\n"
 "           [,writable=on|off][,bitmap=<name>]\n"
 "                         export the specified block node over NBD\n"
 "                         (requires --nbd-server)\n"
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index e1eaaedb55..31ce9e6fe0 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -45,7 +45,7 @@ exports available: 0
 {"execute":"nbd-server-add", "arguments":{"device":"nosuch"}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=nosuch nor node_name=nosuch"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n"}}
-{"error": {"class": "GenericError", "desc": "NBD server already has export named 'n'"}}
+{"error": {"class": "GenericError", "desc": "Block export id 'n' is already in use"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitmap":"b2"}}
 {"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompatible with readonly export"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitmap":"b3"}}
@@ -126,7 +126,7 @@ exports available: 0
 {"execute":"nbd-server-add", "arguments":{"device":"nosuch"}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=nosuch nor node_name=nosuch"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n"}}
-{"error": {"class": "GenericError", "desc": "NBD server already has export named 'n'"}}
+{"error": {"class": "GenericError", "desc": "Block export id 'n' is already in use"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitmap":"b2"}}
 {"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompatible with readonly export"}}
 {"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitmap":"b3"}}
-- 
2.25.4


