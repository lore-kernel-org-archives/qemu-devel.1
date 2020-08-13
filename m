Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B113C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E9D206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W11YUwnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E9D206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GBh-00020x-1j
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G79-0001vK-IZ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48518
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G76-0001E1-DD
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E3ar3RgcXyL0pJSnGP3isZDNUlYNQKVhVvWZOsntFy4=;
 b=W11YUwnQkyhrByrvSGz+J0zVxVnkAP5w9e8ykic+6iGJMA5Wi+GfsOdll4qn1KDSfVQ5nh
 BwF1YEHpWQdy3ml3WoGerRvBNFwaNBGYDbE7bvBUZp1/+jGe95TXPBRaQyvezQvCQmelZg
 apeIe4bEVvUFp+CpqzyNmfeGH+o3E58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-Co6I81CsOmuSMJn2-VhMBg-1; Thu, 13 Aug 2020 12:29:57 -0400
X-MC-Unique: Co6I81CsOmuSMJn2-VhMBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7CE21015DBF;
 Thu, 13 Aug 2020 16:29:56 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7AFF5C1A3;
 Thu, 13 Aug 2020 16:29:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 07/22] block/export: Remove magic from block-export-add
Date: Thu, 13 Aug 2020 18:29:20 +0200
Message-Id: <20200813162935.210070-8-kwolf@redhat.com>
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
---
 include/block/nbd.h   |  3 ++-
 block/export/export.c | 44 ++++++++++++++++++++++++++++++++++++++-----
 blockdev-nbd.c        | 10 ++++------
 nbd/server.c          | 19 ++++++++++++-------
 qemu-nbd.c            |  3 +--
 5 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 3846d2bac8..ffca3be78f 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -333,7 +333,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
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
index 3d0dacb3f2..2d5f92861c 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -13,6 +13,8 @@
 
 #include "qemu/osdep.h"
 
+#include "block/block.h"
+#include "sysemu/block-backend.h"
 #include "block/export.h"
 #include "block/nbd.h"
 #include "qapi/error.h"
@@ -34,24 +36,56 @@ static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
     return NULL;
 }
 
-void qmp_block_export_add(BlockExportOptions *export, Error **errp)
+static BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
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
 
 void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
 {
-    BlockExportOptions export = {
+    BlockExport *export;
+    BlockDriverState *bs;
+    BlockBackend *on_eject_blk;
+
+    BlockExportOptions export_opts = {
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
+    bs = bdrv_lookup_bs(arg->device, arg->device, NULL);
+    if (bs && bdrv_is_read_only(bs)) {
+        arg->writable = false;
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
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 16cda3b052..019c37c0bc 100644
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
diff --git a/nbd/server.c b/nbd/server.c
index 92360d1f08..0b84fd30e2 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1506,11 +1506,22 @@ static void nbd_eject_notifier(Notifier *n, void *data)
     aio_context_release(aio_context);
 }
 
+void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk)
+{
+    NBDExport *nbd_exp = container_of(exp, NBDExport, common);
+    assert(exp->drv == &blk_exp_nbd);
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
@@ -1618,12 +1629,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
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
index 818c3f5d46..e348d5d6d8 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1058,8 +1058,7 @@ int main(int argc, char **argv)
 
     export = nbd_export_new(bs, export_name,
                             export_description, bitmap, readonly, shared > 1,
-                            nbd_export_closed, writethrough, NULL,
-                            &error_fatal);
+                            nbd_export_closed, writethrough, &error_fatal);
 
     if (device) {
 #if HAVE_NBD_DEVICE
-- 
2.25.4


