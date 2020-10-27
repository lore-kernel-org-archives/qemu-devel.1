Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0182AC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A8B20878
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y245U28X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A8B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXX8V-0006jF-2Y
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 18:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXX0B-0006iK-IM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXX07-0000if-Jp
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603835970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6fwET698CoDVM3PFu8Eu6onyr/uOuDRSSYFWgc8DTw=;
 b=Y245U28X0AjHwUZyoMfm8cObt9LAvOqzhSyDbp6ENZ3y8mjEXfaOhUpe0ARmen05qpHoDG
 By39XrMpdNmtduOJ84UDqMT9huk8y8GOl/dmJQ5lpGzOlHmHzPqfr4f0xwP9ONMSYbKozc
 sqTZxQ2ThOozL1lPB8UAPafMlg8qYeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-jGMBysCMM3S_OHClcbyBCQ-1; Tue, 27 Oct 2020 17:59:28 -0400
X-MC-Unique: jGMBysCMM3S_OHClcbyBCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4046A809DC9;
 Tue, 27 Oct 2020 21:59:27 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC20D10013DB;
 Tue, 27 Oct 2020 21:59:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/12] nbd: Update qapi to support exporting multiple bitmaps
Date: Tue, 27 Oct 2020 16:59:08 -0500
Message-Id: <20201027215914.619460-7-eblake@redhat.com>
In-Reply-To: <20201027215914.619460-1-eblake@redhat.com>
References: <20201027215914.619460-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 17:59:21
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 'block-export-add' is new to 5.2, we can still tweak the
interface; there, allowing 'bitmaps':['str'] is nicer than
'bitmap':'str'.  This wires up the qapi and qemu-nbd changes to permit
passing multiple bitmaps as distinct metadata contexts that the NBD
client may request, but the actual support for more than one will
require a further patch to the server.

Note that there are no changes made to the existing deprecated
'nbd-server-add' command; this required splitting the QAPI type
BlockExportOptionsNbd, which fortunately does not affect QMP
introspection.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20201027050556.269064-5-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Peter Krempa <pkrempa@redhat.com>
---
 docs/system/deprecated.rst |  3 ++-
 qapi/block-export.json     | 41 +++++++++++++++++++++++++++-----------
 blockdev-nbd.c             |  6 +++++-
 nbd/server.c               | 19 ++++++++++++------
 qemu-nbd.c                 | 18 ++++++++---------
 5 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 0ebce37a1919..32a0e620dbb9 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -257,7 +257,8 @@ the 'wait' field, which is only applicable to sockets in server mode
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''

 Use the more generic commands ``block-export-add`` and ``block-export-del``
-instead.
+instead.  As part of this deprecation, where ``nbd-server-add`` used a
+single ``bitmap``, the new ``block-export-add`` uses a list of ``bitmaps``.

 Human Monitor Protocol (HMP) commands
 -------------------------------------
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 480c497690b0..c4125f4d2104 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -63,10 +63,10 @@
             '*max-connections': 'uint32' } }

 ##
-# @BlockExportOptionsNbd:
+# @BlockExportOptionsNbdBase:
 #
-# An NBD block export (options shared between nbd-server-add and the NBD branch
-# of block-export-add).
+# An NBD block export (common options shared between nbd-server-add and
+# the NBD branch of block-export-add).
 #
 # @name: Export name. If unspecified, the @device parameter is used as the
 #        export name. (Since 2.12)
@@ -74,15 +74,27 @@
 # @description: Free-form description of the export, up to 4096 bytes.
 #               (Since 5.0)
 #
-# @bitmap: Also export the dirty bitmap reachable from @device, so the
-#          NBD client can use NBD_OPT_SET_META_CONTEXT with
-#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
-#
 # Since: 5.0
 ##
+{ 'struct': 'BlockExportOptionsNbdBase',
+  'data': { '*name': 'str', '*description': 'str' } }
+
+##
+# @BlockExportOptionsNbd:
+#
+# An NBD block export (distinct options used in the NBD branch of
+# block-export-add).
+#
+# @bitmaps: Also export each of the named dirty bitmaps reachable from
+#           @device, so the NBD client can use NBD_OPT_SET_META_CONTEXT with
+#           the metadata context name "qemu:dirty-bitmap:BITMAP" to inspect
+#           each bitmap.
+#
+# Since: 5.2
+##
 { 'struct': 'BlockExportOptionsNbd',
-  'data': { '*name': 'str', '*description': 'str',
-            '*bitmap': 'str' } }
+  'base': 'BlockExportOptionsNbdBase',
+  'data': { '*bitmaps': ['str'] } }

 ##
 # @BlockExportOptionsVhostUserBlk:
@@ -106,19 +118,24 @@
 ##
 # @NbdServerAddOptions:
 #
-# An NBD block export.
+# An NBD block export, per legacy nbd-server-add command.
 #
 # @device: The device name or node name of the node to be exported
 #
 # @writable: Whether clients should be able to write to the device via the
 #            NBD connection (default false).
 #
+# @bitmap: Also export a single dirty bitmap reachable from @device, so the
+#          NBD client can use NBD_OPT_SET_META_CONTEXT with the metadata
+#          context name "qemu:dirty-bitmap:BITMAP" to inspect the bitmap
+#          (since 4.0).
+#
 # Since: 5.0
 ##
 { 'struct': 'NbdServerAddOptions',
-  'base': 'BlockExportOptionsNbd',
+  'base': 'BlockExportOptionsNbdBase',
   'data': { 'device': 'str',
-            '*writable': 'bool' } }
+            '*writable': 'bool', '*bitmap': 'str' } }

 ##
 # @nbd-server-add:
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index cee9134b12eb..d8443d235b73 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -209,8 +209,12 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
         .has_writable           = arg->has_writable,
         .writable               = arg->writable,
     };
-    QAPI_CLONE_MEMBERS(BlockExportOptionsNbd, &export_opts->u.nbd,
+    QAPI_CLONE_MEMBERS(BlockExportOptionsNbdBase, &export_opts->u.nbd,
                        qapi_NbdServerAddOptions_base(arg));
+    if (arg->has_bitmap) {
+        export_opts->u.nbd.has_bitmaps = true;
+        QAPI_LIST_PREPEND(export_opts->u.nbd.bitmaps, g_strdup(arg->bitmap));
+    }

     /*
      * nbd-server-add doesn't complain when a read-only device should be
diff --git a/nbd/server.c b/nbd/server.c
index 08b621f70a3a..8d01662b4511 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1474,6 +1474,7 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
     uint64_t perm, shared_perm;
     bool readonly = !exp_args->writable;
     bool shared = !exp_args->writable;
+    strList *bitmaps;
     int ret;

     assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
@@ -1533,12 +1534,18 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
     }
     exp->size = QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);

-    if (arg->bitmap) {
+    /* XXX Allow more than one bitmap */
+    if (arg->bitmaps && arg->bitmaps->next) {
+        error_setg(errp, "multiple bitmaps per export not supported yet");
+        return -EOPNOTSUPP;
+    }
+    for (bitmaps = arg->bitmaps; bitmaps; bitmaps = bitmaps->next) {
+        const char *bitmap = bitmaps->value;
         BlockDriverState *bs = blk_bs(blk);
         BdrvDirtyBitmap *bm = NULL;

         while (bs) {
-            bm = bdrv_find_dirty_bitmap(bs, arg->bitmap);
+            bm = bdrv_find_dirty_bitmap(bs, bitmap);
             if (bm != NULL) {
                 break;
             }
@@ -1548,7 +1555,7 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,

         if (bm == NULL) {
             ret = -ENOENT;
-            error_setg(errp, "Bitmap '%s' is not found", arg->bitmap);
+            error_setg(errp, "Bitmap '%s' is not found", bitmap);
             goto fail;
         }

@@ -1562,15 +1569,15 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
             ret = -EINVAL;
             error_setg(errp,
                        "Enabled bitmap '%s' incompatible with readonly export",
-                       arg->bitmap);
+                       bitmap);
             goto fail;
         }

         bdrv_dirty_bitmap_set_busy(bm, true);
         exp->export_bitmap = bm;
-        assert(strlen(arg->bitmap) <= BDRV_BITMAP_MAX_NAME_SIZE);
+        assert(strlen(bitmap) <= BDRV_BITMAP_MAX_NAME_SIZE);
         exp->export_bitmap_context = g_strdup_printf("qemu:dirty-bitmap:%s",
-                                                     arg->bitmap);
+                                                     bitmap);
         assert(strlen(exp->export_bitmap_context) < NBD_MAX_STRING_SIZE);
     }

diff --git a/qemu-nbd.c b/qemu-nbd.c
index a0701cdf369d..74e73a74657b 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -574,7 +574,7 @@ int main(int argc, char **argv)
     QDict *options = NULL;
     const char *export_name = NULL; /* defaults to "" later for server mode */
     const char *export_description = NULL;
-    const char *bitmap = NULL;
+    strList *bitmaps = NULL;
     const char *tlscredsid = NULL;
     bool imageOpts = false;
     bool writethrough = true;
@@ -690,7 +690,7 @@ int main(int argc, char **argv)
             flags &= ~BDRV_O_RDWR;
             break;
         case 'B':
-            bitmap = optarg;
+            QAPI_LIST_PREPEND(bitmaps, g_strdup(optarg));
             break;
         case 'k':
             sockpath = optarg;
@@ -786,7 +786,7 @@ int main(int argc, char **argv)
             exit(EXIT_FAILURE);
         }
         if (export_name || export_description || dev_offset ||
-            device || disconnect || fmt || sn_id_or_name || bitmap ||
+            device || disconnect || fmt || sn_id_or_name || bitmaps ||
             seen_aio || seen_discard || seen_cache) {
             error_report("List mode is incompatible with per-device settings");
             exit(EXIT_FAILURE);
@@ -1067,12 +1067,12 @@ int main(int argc, char **argv)
         .has_writable       = true,
         .writable           = !readonly,
         .u.nbd = {
-            .has_name           = true,
-            .name               = g_strdup(export_name),
-            .has_description    = !!export_description,
-            .description        = g_strdup(export_description),
-            .has_bitmap         = !!bitmap,
-            .bitmap             = g_strdup(bitmap),
+            .has_name             = true,
+            .name                 = g_strdup(export_name),
+            .has_description      = !!export_description,
+            .description          = g_strdup(export_description),
+            .has_bitmaps          = !!bitmaps,
+            .bitmaps              = bitmaps,
         },
     };
     blk_exp_add(export_opts, &error_fatal);
-- 
2.29.0


