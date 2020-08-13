Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F96C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC43206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5MUrJnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC43206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GDu-0006za-WA
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7Z-0002ju-84
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49180
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7W-0001P4-0E
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wAHKs+08P/vSTz3lirDXGKErXF8MzB0H4yvSv1GYU5w=;
 b=D5MUrJnCCZfd5sEoAt8UyL589kjzyc0dqTFsVNFITGo8yLayKWwjoHTv8m4IugUduSMoLe
 mk3gANJornocKLYkDLFozHGSXICjnXrygEO8oLfpXQPy/9rHFaUaYmWvvp94AD7qll71pJ
 3gWcOHQ3P8H+qBZKmB8M56zPVOfeH/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-_uL5vCJ6OQ-20QuuUf5eLA-1; Thu, 13 Aug 2020 12:30:23 -0400
X-MC-Unique: _uL5vCJ6OQ-20QuuUf5eLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BC481853DB9;
 Thu, 13 Aug 2020 16:30:22 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B8385C1A3;
 Thu, 13 Aug 2020 16:30:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 18/22] block/export: Add 'id' option to block-export-add
Date: Thu, 13 Aug 2020 18:29:31 +0200
Message-Id: <20200813162935.210070-19-kwolf@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 12:29:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We'll need an id to identify block exports in monitor commands. This
adds one.

Note that this is different from the 'name' option in the NBD server,
which is the externally visible export name. While block export ids need
to be unique in the whole process, export names must be unique only for
the same server. Different export types or (potentially in the future)
multiple NBD servers can have the same export name externally, but still
need different block export ids internally.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json |  3 +++
 include/block/export.h |  3 +++
 block/export/export.c  | 27 +++++++++++++++++++++++++++
 qemu-nbd.c             |  1 +
 4 files changed, 34 insertions(+)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index d68f3bf87e..0d0db9ca1b 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -179,6 +179,8 @@
 # Describes a block export, i.e. how single node should be exported on an
 # external interface.
 #
+# @id: A unique identifier for the block export (across all export types)
+#
 # @device: The device name or node name of the node to be exported
 #
 # @writethrough: If true, caches are flushed after every write request to the
@@ -189,6 +191,7 @@
 ##
 { 'union': 'BlockExportOptions',
   'base': { 'type': 'BlockExportType',
+            'id': 'str',
             'device': 'str',
             '*writethrough': 'bool' },
   'discriminator': 'type',
diff --git a/include/block/export.h b/include/block/export.h
index 1698b68f09..43229857b0 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -30,6 +30,9 @@ typedef struct BlockExportDriver {
 struct BlockExport {
     const BlockExportDriver *drv;
 
+    /* Unique identifier for the export */
+    char *id;
+
     /*
      * Reference count for this block export. This includes strong references
      * both from the owner (qemu-nbd or the monitor) and clients connected to
diff --git a/block/export/export.c b/block/export/export.c
index 675db9a8b9..72f1fab975 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -19,6 +19,7 @@
 #include "block/nbd.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-export.h"
+#include "qemu/id.h"
 
 static const BlockExportDriver* blk_exp_drivers[] = {
     &blk_exp_nbd,
@@ -27,6 +28,19 @@ static const BlockExportDriver* blk_exp_drivers[] = {
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
@@ -45,6 +59,15 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
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
@@ -55,10 +78,12 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     *exp = (BlockExport) {
         .drv        = &blk_exp_nbd,
         .refcount   = 1,
+        .id         = g_strdup(export->id),
     };
 
     ret = drv->create(exp, export, errp);
     if (ret < 0) {
+        g_free(exp->id);
         g_free(exp);
         return NULL;
     }
@@ -79,6 +104,7 @@ void blk_exp_unref(BlockExport *exp)
     if (--exp->refcount == 0) {
         QLIST_REMOVE(exp, next);
         exp->drv->delete(exp);
+        g_free(exp->id);
         g_free(exp);
         aio_wait_kick();
     }
@@ -144,6 +170,7 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
     BlockExportOptions *export_opts = g_new(BlockExportOptions, 1);
     *export_opts = (BlockExportOptions) {
         .type                   = BLOCK_EXPORT_TYPE_NBD,
+        .id                     = g_strdup(arg->name ?: arg->device),
         .device                 = g_strdup(arg->device),
         .u.nbd = {
             .has_name           = arg->has_name,
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 939a08902a..c6fc0581c1 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1055,6 +1055,7 @@ int main(int argc, char **argv)
     export_opts = g_new(BlockExportOptions, 1);
     *export_opts = (BlockExportOptions) {
         .type               = BLOCK_EXPORT_TYPE_NBD,
+        .id                 = g_strdup("qemu-nbd-export"),
         .device             = g_strdup(bdrv_get_node_name(bs)),
         .has_writethrough   = true,
         .writethrough       = writethrough,
-- 
2.25.4


