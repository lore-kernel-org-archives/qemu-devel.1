Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A7C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3766C2065D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRKueblD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3766C2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMMn-0007ix-Bx
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMIA-0001Qx-R8
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMI7-0004XU-GY
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601649850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tNMQh7Xe2LDCi83KKK++yn7LZsfQNUKTgeioE8vVrFg=;
 b=VRKueblDqYI/TAaPTZIDE+rlaCAFDgQsWI7ICyofGZUuel5jN6gzMw6hlZbJb4CjXdn/GK
 hlBbcU1pe142t2pqasx41/qNoXwKF8gssLS2o4cyh/XPu2LttuQbdJEro/x9izhKR1xe+V
 kgdweN/WTeGm+nUaaxGP1ufR0O5lh4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-H5-V4JkrPK6krXx0Jhe30Q-1; Fri, 02 Oct 2020 10:44:08 -0400
X-MC-Unique: H5-V4JkrPK6krXx0Jhe30Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A05BD1054F8E;
 Fri,  2 Oct 2020 14:44:07 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-139.ams2.redhat.com
 [10.36.112.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A981A5D9D3;
 Fri,  2 Oct 2020 14:44:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 11/37] block/export: Remove magic from block-export-add
Date: Fri,  2 Oct 2020 16:43:19 +0200
Message-Id: <20201002144345.253865-12-kwolf@redhat.com>
In-Reply-To: <20201002144345.253865-1-kwolf@redhat.com>
References: <20201002144345.253865-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nbd-server-add tries to be convenient and adds two questionable
features that we don't want to share in block-export-add, even for NBD
exports:

1. When requesting a writable export of a read-only device, the export
   is silently downgraded to read-only. This should be an error in the
   context of block-export-add.

2. When using a BlockBackend name, unplugging the device from the guest
   will automatically stop the NBD server, too. This may sometimes be
   what you want, but it could also be very surprising. Let's keep
   things explicit with block-export-add. If the user wants to stop the
   export, they should tell us so.

Move these things into the nbd-server-add QMP command handler so that
they apply only there.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200924152717.287415-8-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/export.h |  2 ++
 include/block/nbd.h    |  3 ++-
 block/export/export.c  | 13 +++++++++---
 blockdev-nbd.c         | 47 +++++++++++++++++++++++++++++++++++-------
 nbd/server.c           | 20 +++++++++++-------
 qemu-nbd.c             |  3 +--
 6 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/include/block/export.h b/include/block/export.h
index 42e3c055fc..e7af2c7687 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -30,4 +30,6 @@ struct BlockExport {
     const BlockExportDriver *drv;
 };
 
+BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
+
 #endif
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 451f399b0a..f55f5b710b 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -335,7 +335,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
                           const char *name, const char *desc,
                           const char *bitmap, bool readonly, bool shared,
                           void (*close)(NBDExport *), bool writethrough,
-                          BlockBackend *on_eject_blk, Error **errp);
+                          Error **errp);
+void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);
 void nbd_export_close(NBDExport *exp);
 void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
 void nbd_export_get(NBDExport *exp);
diff --git a/block/export/export.c b/block/export/export.c
index fd65541963..05bc5e3744 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -13,6 +13,8 @@
 
 #include "qemu/osdep.h"
 
+#include "block/block.h"
+#include "sysemu/block-backend.h"
 #include "block/export.h"
 #include "block/nbd.h"
 #include "qapi/error.h"
@@ -34,15 +36,20 @@ static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
     return NULL;
 }
 
-void qmp_block_export_add(BlockExportOptions *export, Error **errp)
+BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
 {
     const BlockExportDriver *drv;
 
     drv = blk_exp_find_driver(export->type);
     if (!drv) {
         error_setg(errp, "No driver found for the requested export type");
-        return;
+        return NULL;
     }
 
-    drv->create(export, errp);
+    return drv->create(export, errp);
+}
+
+void qmp_block_export_add(BlockExportOptions *export, Error **errp)
+{
+    blk_exp_add(export, errp);
 }
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 96cb0100e9..7bcca105f9 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -152,7 +152,6 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
 {
     BlockExportOptionsNbd *arg = &exp_args->u.nbd;
     BlockDriverState *bs = NULL;
-    BlockBackend *on_eject_blk;
     NBDExport *exp = NULL;
     AioContext *aio_context;
 
@@ -182,8 +181,6 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
         return NULL;
     }
 
-    on_eject_blk = blk_by_name(arg->device);
-
     bs = bdrv_lookup_bs(arg->device, arg->device, errp);
     if (!bs) {
         return NULL;
@@ -195,13 +192,14 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
     if (!arg->has_writable) {
         arg->writable = false;
     }
-    if (bdrv_is_read_only(bs)) {
-        arg->writable = false;
+    if (bdrv_is_read_only(bs) && arg->writable) {
+        error_setg(errp, "Cannot export read-only node as writable");
+        goto out;
     }
 
     exp = nbd_export_new(bs, arg->name, arg->description, arg->bitmap,
                          !arg->writable, !arg->writable,
-                         NULL, false, on_eject_blk, errp);
+                         NULL, false, errp);
     if (!exp) {
         goto out;
     }
@@ -219,11 +217,44 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
 
 void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
 {
-    BlockExportOptions export = {
+    BlockExport *export;
+    BlockDriverState *bs;
+    BlockBackend *on_eject_blk;
+    BlockExportOptions export_opts;
+
+    bs = bdrv_lookup_bs(arg->device, arg->device, errp);
+    if (!bs) {
+        return;
+    }
+
+    export_opts = (BlockExportOptions) {
         .type = BLOCK_EXPORT_TYPE_NBD,
         .u.nbd = *arg,
     };
-    qmp_block_export_add(&export, errp);
+
+    /*
+     * nbd-server-add doesn't complain when a read-only device should be
+     * exported as writable, but simply downgrades it. This is an error with
+     * block-export-add.
+     */
+    if (bdrv_is_read_only(bs)) {
+        export_opts.u.nbd.has_writable = true;
+        export_opts.u.nbd.writable = false;
+    }
+
+    export = blk_exp_add(&export_opts, errp);
+    if (!export) {
+        return;
+    }
+
+    /*
+     * nbd-server-add removes the export when the named BlockBackend used for
+     * @device goes away.
+     */
+    on_eject_blk = blk_by_name(arg->device);
+    if (on_eject_blk) {
+        nbd_export_set_on_eject_blk(export, on_eject_blk);
+    }
 }
 
 void qmp_nbd_server_remove(const char *name,
diff --git a/nbd/server.c b/nbd/server.c
index 33aaca918c..23d9a53094 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1506,11 +1506,23 @@ static void nbd_eject_notifier(Notifier *n, void *data)
     aio_context_release(aio_context);
 }
 
+void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk)
+{
+    NBDExport *nbd_exp = container_of(exp, NBDExport, common);
+    assert(exp->drv == &blk_exp_nbd);
+    assert(nbd_exp->eject_notifier_blk == NULL);
+
+    blk_ref(blk);
+    nbd_exp->eject_notifier_blk = blk;
+    nbd_exp->eject_notifier.notify = nbd_eject_notifier;
+    blk_add_remove_bs_notifier(blk, &nbd_exp->eject_notifier);
+}
+
 NBDExport *nbd_export_new(BlockDriverState *bs,
                           const char *name, const char *desc,
                           const char *bitmap, bool readonly, bool shared,
                           void (*close)(NBDExport *), bool writethrough,
-                          BlockBackend *on_eject_blk, Error **errp)
+                          Error **errp)
 {
     AioContext *ctx;
     BlockBackend *blk;
@@ -1617,12 +1629,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
     exp->ctx = ctx;
     blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, exp);
 
-    if (on_eject_blk) {
-        blk_ref(on_eject_blk);
-        exp->eject_notifier_blk = on_eject_blk;
-        exp->eject_notifier.notify = nbd_eject_notifier;
-        blk_add_remove_bs_notifier(on_eject_blk, &exp->eject_notifier);
-    }
     QTAILQ_INSERT_TAIL(&exports, exp, next);
     nbd_export_get(exp);
     return exp;
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 16473d809c..b2a0ea6c5e 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1067,8 +1067,7 @@ int main(int argc, char **argv)
 
     export = nbd_export_new(bs, export_name,
                             export_description, bitmap, readonly, shared > 1,
-                            nbd_export_closed, writethrough, NULL,
-                            &error_fatal);
+                            nbd_export_closed, writethrough, &error_fatal);
 
     if (device) {
 #if HAVE_NBD_DEVICE
-- 
2.25.4


