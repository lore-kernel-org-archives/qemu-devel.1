Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCFEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17AB206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6IFHd84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17AB206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GBl-0002Bu-61
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G75-0001ng-RM
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:29:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40824
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G72-0001D0-8a
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ds+x3uGjKOJoiQrFgVPKmat43BWVK5iXn4eoYFhvg0o=;
 b=P6IFHd843xv/tCOUn29cek20xOgCLgUotCSVUDjeqSeDWgujDqmKXCBBOgHMraErR4dLSz
 0jftBSkmQCDOlLcD6FkumEZuEc4BGiW4FMTg9v7EgtLQ5K3m+Pje2myLtsHZOZPqaIIZEA
 x7Cw4K5XF6wZv2VeDTR5Kpq7nc1Dw5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-PCTvLbY8NHC4H-MSMbNnPg-1; Thu, 13 Aug 2020 12:29:53 -0400
X-MC-Unique: PCTvLbY8NHC4H-MSMbNnPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AA631015DC5;
 Thu, 13 Aug 2020 16:29:52 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57E635C1A3;
 Thu, 13 Aug 2020 16:29:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 04/22] block/export: Add BlockExport infrastructure and
 block-export-add
Date: Thu, 13 Aug 2020 18:29:17 +0200
Message-Id: <20200813162935.210070-5-kwolf@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
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

We want to have a common set of commands for all types of block exports.
Currently, this is only NBD, but we're going to add more types.

This patch adds the basic BlockExport and BlockExportDriver structs and
a QMP command block-export-add that creates a new export based on the
given BlockExportOptions.

qmp_nbd_server_add() becomes a wrapper around qmp_block_export_add().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json     |  9 ++++++
 include/block/export.h     | 32 +++++++++++++++++++++
 include/block/nbd.h        |  3 +-
 block/export/export.c      | 57 ++++++++++++++++++++++++++++++++++++++
 blockdev-nbd.c             | 19 ++++++++-----
 nbd/server.c               | 15 +++++++++-
 Makefile.objs              |  6 ++--
 block/Makefile.objs        |  2 ++
 block/export/Makefile.objs |  1 +
 9 files changed, 132 insertions(+), 12 deletions(-)
 create mode 100644 include/block/export.h
 create mode 100644 block/export/export.c
 create mode 100644 block/export/Makefile.objs

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 9332076a05..40369814b4 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -170,3 +170,12 @@
       'nbd': 'BlockExportOptionsNbd'
    } }
 
+##
+# @block-export-add:
+#
+# Creates a new block export.
+#
+# Since: 5.2
+##
+{ 'command': 'block-export-add',
+  'data': 'BlockExportOptions', 'boxed': true }
diff --git a/include/block/export.h b/include/block/export.h
new file mode 100644
index 0000000000..b1d7325403
--- /dev/null
+++ b/include/block/export.h
@@ -0,0 +1,32 @@
+/*
+ * Declarations for block exports
+ *
+ * Copyright (c) 2012, 2020 Red Hat, Inc.
+ *
+ * Authors:
+ * Paolo Bonzini <pbonzini@redhat.com>
+ * Kevin Wolf <kwolf@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef BLOCK_EXPORT_H
+#define BLOCK_EXPORT_H
+
+#include "qapi/qapi-types-block-export.h"
+
+typedef struct BlockExport BlockExport;
+
+typedef struct BlockExportDriver {
+    BlockExportType type;
+    BlockExport *(*create)(BlockExportOptions *, Error **);
+} BlockExportDriver;
+
+struct BlockExport {
+    const BlockExportDriver *drv;
+};
+
+extern const BlockExportDriver blk_exp_nbd;
+
+#endif
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 262f6da2ce..c8c5cb6b61 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -20,7 +20,7 @@
 #ifndef NBD_H
 #define NBD_H
 
-#include "qapi/qapi-types-block-export.h"
+#include "block/export.h"
 #include "io/channel-socket.h"
 #include "crypto/tlscreds.h"
 #include "qapi/error.h"
@@ -328,6 +328,7 @@ int nbd_errno_to_system_errno(int err);
 typedef struct NBDExport NBDExport;
 typedef struct NBDClient NBDClient;
 
+BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp);
 NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
                           uint64_t size, const char *name, const char *desc,
                           const char *bitmap, bool readonly, bool shared,
diff --git a/block/export/export.c b/block/export/export.c
new file mode 100644
index 0000000000..3d0dacb3f2
--- /dev/null
+++ b/block/export/export.c
@@ -0,0 +1,57 @@
+/*
+ * Common block export infrastructure
+ *
+ * Copyright (c) 2012, 2020 Red Hat, Inc.
+ *
+ * Authors:
+ * Paolo Bonzini <pbonzini@redhat.com>
+ * Kevin Wolf <kwolf@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "block/export.h"
+#include "block/nbd.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-block-export.h"
+
+static const BlockExportDriver* blk_exp_drivers[] = {
+    &blk_exp_nbd,
+};
+
+static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(blk_exp_drivers); i++) {
+        if (blk_exp_drivers[i]->type == type) {
+            return blk_exp_drivers[i];
+        }
+    }
+    return NULL;
+}
+
+void qmp_block_export_add(BlockExportOptions *export, Error **errp)
+{
+    const BlockExportDriver *drv;
+
+    drv = blk_exp_find_driver(export->type);
+    if (!drv) {
+        error_setg(errp, "No driver found for the requested export type");
+        return;
+    }
+
+    drv->create(export, errp);
+}
+
+void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
+{
+    BlockExportOptions export = {
+        .type = BLOCK_EXPORT_TYPE_NBD,
+        .u.nbd = *arg,
+    };
+    qmp_block_export_add(&export, errp);
+}
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 98ee1b6170..a1dc11bdd7 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -148,17 +148,20 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
     qapi_free_SocketAddress(addr_flat);
 }
 
-void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
+BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
 {
+    BlockExportOptionsNbd *arg = &exp_args->u.nbd;
     BlockDriverState *bs = NULL;
     BlockBackend *on_eject_blk;
-    NBDExport *exp;
+    NBDExport *exp = NULL;
     int64_t len;
     AioContext *aio_context;
 
+    assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
+
     if (!nbd_server) {
         error_setg(errp, "NBD server not running");
-        return;
+        return NULL;
     }
 
     if (!arg->has_name) {
@@ -167,24 +170,24 @@ void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
 
     if (strlen(arg->name) > NBD_MAX_STRING_SIZE) {
         error_setg(errp, "export name '%s' too long", arg->name);
-        return;
+        return NULL;
     }
 
     if (arg->description && strlen(arg->description) > NBD_MAX_STRING_SIZE) {
         error_setg(errp, "description '%s' too long", arg->description);
-        return;
+        return NULL;
     }
 
     if (nbd_export_find(arg->name)) {
         error_setg(errp, "NBD server already has export named '%s'", arg->name);
-        return;
+        return NULL;
     }
 
     on_eject_blk = blk_by_name(arg->device);
 
     bs = bdrv_lookup_bs(arg->device, arg->device, errp);
     if (!bs) {
-        return;
+        return NULL;
     }
 
     aio_context = bdrv_get_aio_context(bs);
@@ -217,6 +220,8 @@ void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
 
  out:
     aio_context_release(aio_context);
+    /* TODO Remove the cast: Move to server.c which can access fields of exp */
+    return (BlockExport*) exp;
 }
 
 void qmp_nbd_server_remove(const char *name,
diff --git a/nbd/server.c b/nbd/server.c
index bee2ef8bd1..774325dbe5 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -18,6 +18,8 @@
  */
 
 #include "qemu/osdep.h"
+
+#include "block/export.h"
 #include "qapi/error.h"
 #include "qemu/queue.h"
 #include "trace.h"
@@ -80,6 +82,7 @@ struct NBDRequestData {
 };
 
 struct NBDExport {
+    BlockExport common;
     int refcount;
     void (*close)(NBDExport *exp);
 
@@ -1512,10 +1515,15 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
 {
     AioContext *ctx;
     BlockBackend *blk;
-    NBDExport *exp = g_new0(NBDExport, 1);
+    NBDExport *exp;
     uint64_t perm;
     int ret;
 
+    exp = g_new0(NBDExport, 1);
+    exp->common = (BlockExport) {
+        .drv = &blk_exp_nbd,
+    };
+
     /*
      * NBD exports are used for non-shared storage migration.  Make sure
      * that BDRV_O_INACTIVE is cleared and the image is ready for write
@@ -1731,6 +1739,11 @@ void nbd_export_put(NBDExport *exp)
     }
 }
 
+const BlockExportDriver blk_exp_nbd = {
+    .type               = BLOCK_EXPORT_TYPE_NBD,
+    .create             = nbd_export_create,
+};
+
 void nbd_export_close_all(void)
 {
     NBDExport *exp, *next;
diff --git a/Makefile.objs b/Makefile.objs
index d22b3b45d7..9b864ca046 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -14,7 +14,7 @@ chardev-obj-y = chardev/
 authz-obj-y = authz/
 
 block-obj-y = block/ nbd/ scsi/
-block-obj-y += block.o blockjob.o job.o
+block-obj-y += block.o blockjob.o job.o blockdev-nbd.o
 block-obj-y += qemu-io-cmds.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
 
@@ -31,7 +31,7 @@ endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 # used for system emulation, too, but specified separately there)
 
 storage-daemon-obj-y = block/ monitor/ qapi/ qom/ storage-daemon/
-storage-daemon-obj-y += blockdev.o blockdev-nbd.o iothread.o job-qmp.o
+storage-daemon-obj-y += blockdev.o iothread.o job-qmp.o
 storage-daemon-obj-$(CONFIG_WIN32) += os-win32.o
 storage-daemon-obj-$(CONFIG_POSIX) += os-posix.o
 
@@ -41,7 +41,7 @@ storage-daemon-obj-$(CONFIG_POSIX) += os-posix.o
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = blockdev.o blockdev-nbd.o block/
+common-obj-y = blockdev.o block/
 common-obj-y += bootdevice.o iothread.o
 common-obj-y += dump/
 common-obj-y += job-qmp.o
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 19c6f371c9..55b45c2f7d 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -44,6 +44,8 @@ block-obj-y += crypto.o
 block-obj-y += aio_task.o
 block-obj-y += backup-top.o
 block-obj-y += filter-compress.o
+
+block-obj-y += export/
 common-obj-y += monitor/
 block-obj-y += monitor/
 
diff --git a/block/export/Makefile.objs b/block/export/Makefile.objs
new file mode 100644
index 0000000000..0c170ee6f1
--- /dev/null
+++ b/block/export/Makefile.objs
@@ -0,0 +1 @@
+block-obj-y += export.o
-- 
2.25.4


