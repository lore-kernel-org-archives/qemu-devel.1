Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51032C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE8C22255
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJs60tdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE8C22255
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQhqJ-00080O-HW
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 22:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQhol-00064P-Tt
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 22:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQhoc-0006rc-Rs
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 22:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602209245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T8wFYhrz/v4NI8FMXE3LWRphbgaidPX9Bd0i6MQ1Gp0=;
 b=dJs60tdh5sOpsv1A+gXLhSErzFA0Cjr1he3yBD4RWUpFg6XZAb10qsltjEXish8USe3LtG
 0YzQjaxL7AleLGB1oFrRQXZ174JxMBfMgDMd32T4bMWktgez88Up1mFMqMAFDglrDu4sZp
 x2FnS4RP0cpWc/bCWLESLa0rkrPBctY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-dAk286DAPpOFQKKYM0Y4Kw-1; Thu, 08 Oct 2020 22:07:23 -0400
X-MC-Unique: dAk286DAPpOFQKKYM0Y4Kw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9DA564143;
 Fri,  9 Oct 2020 02:07:22 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FEAA76650;
 Fri,  9 Oct 2020 02:07:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/6] nbd: Update qapi to support multiple bitmaps
Date: Thu,  8 Oct 2020 21:07:11 -0500
Message-Id: <20201009020714.1074061-4-eblake@redhat.com>
In-Reply-To: <20201009020714.1074061-1-eblake@redhat.com>
References: <20201009020714.1074061-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 22:07:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, rjones@redhat.com,
 Max Reitz <mreitz@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 'nbd-server-add' is deprecated, and 'block-export-add' is new to
5.2, we can still tweak the interface.  Allowing 'bitmaps':['str'] is
nicer than 'bitmap':'str'.  This wires up the qapi and qemu-nbd
changes to permit passing multiple bitmaps, but the actual support
will require a further patch to the server.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-export.json | 16 +++++++++++-----
 blockdev-nbd.c         | 18 ++++++++++++++++--
 nbd/server.c           | 19 +++++++++++++------
 qemu-nbd.c             | 13 ++++++++-----
 4 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 524cd3a94400..2dc45a54e364 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -74,9 +74,9 @@
 # @description: Free-form description of the export, up to 4096 bytes.
 #               (Since 5.0)
 #
-# @bitmap: Also export the dirty bitmap reachable from @device, so the
-#          NBD client can use NBD_OPT_SET_META_CONTEXT with
-#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
+# @bitmaps: Also export each of the named dirty bitmaps reachable from
+#           @device, so the NBD client can use NBD_OPT_SET_META_CONTEXT with
+#           "qemu:dirty-bitmap:BITMAP" to inspect each bitmap. (since 5.2)
 #
 # @alloc: Also export the allocation map for @device, so the NBD client
 #         can use NBD_OPT_SET_META_CONTEXT with "qemu:allocation-depth"
@@ -86,7 +86,7 @@
 ##
 { 'struct': 'BlockExportOptionsNbd',
   'data': { '*name': 'str', '*description': 'str',
-            '*bitmap': 'str', '*alloc': 'bool' } }
+            '*bitmaps': ['str'], '*alloc': 'bool' } }

 ##
 # @NbdServerAddOptions:
@@ -98,12 +98,18 @@
 # @writable: Whether clients should be able to write to the device via the
 #            NBD connection (default false).
 #
+# @bitmap: Also export a single dirty bitmap reachable from @device, so the
+#          NBD client can use NBD_OPT_SET_META_CONTEXT with
+#          "qemu:dirty-bitmap:BITMAP" to inspect the bitmap (since 4.0);
+#          mutually exclusive with @bitmaps, and newer clients should use
+#          that instead.
+#
 # Since: 5.0
 ##
 { 'struct': 'NbdServerAddOptions',
   'base': 'BlockExportOptionsNbd',
   'data': { 'device': 'str',
-            '*writable': 'bool' } }
+            '*writable': 'bool', '*bitmap': 'str' } }

 ##
 # @nbd-server-add:
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index f9012f93e2bb..f0a03c830c5f 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -190,6 +190,20 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
         return;
     }

+    /*
+     * New code should use the list 'bitmaps'; but until this code is
+     * gone, we must support the older single 'bitmap'.  Use only one.
+     */
+    if (arg->has_bitmap) {
+        if (arg->has_bitmaps) {
+            error_setg(errp, "Can't mix 'bitmap' and 'bitmaps'");
+            return;
+        }
+        arg->has_bitmaps = true;
+        arg->bitmaps = g_new0(strList, 1);
+        arg->bitmaps->value = g_strdup(arg->bitmap);
+    }
+
     /*
      * block-export-add would default to the node-name, but we may have to use
      * the device name as a default here for compatibility.
@@ -210,8 +224,8 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
             .name               = g_strdup(arg->name),
             .has_description    = arg->has_description,
             .description        = g_strdup(arg->description),
-            .has_bitmap         = arg->has_bitmap,
-            .bitmap             = g_strdup(arg->bitmap),
+            .has_bitmaps        = arg->has_bitmaps,
+            .bitmaps            = g_steal_pointer(&arg->bitmaps),
             .has_alloc          = arg->alloc,
             .alloc              = arg->alloc,
         },
diff --git a/nbd/server.c b/nbd/server.c
index e24495d93e2e..ea5de0b503cd 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1495,6 +1495,7 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
     uint64_t perm, shared_perm;
     bool readonly = !exp_args->writable;
     bool shared = !exp_args->writable;
+    strList *bitmaps;
     int ret;

     assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
@@ -1556,12 +1557,18 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
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
@@ -1571,7 +1578,7 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,

         if (bm == NULL) {
             ret = -ENOENT;
-            error_setg(errp, "Bitmap '%s' is not found", arg->bitmap);
+            error_setg(errp, "Bitmap '%s' is not found", bitmap);
             goto fail;
         }

@@ -1585,15 +1592,15 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
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
index e3cff17d6760..8648a39d0ab9 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -572,7 +572,7 @@ int main(int argc, char **argv)
     const char *export_name = NULL; /* defaults to "" later for server mode */
     const char *export_description = NULL;
     bool alloc_depth = false;
-    const char *bitmap = NULL;
+    strList *bitmaps = NULL, *tmp;
     const char *tlscredsid = NULL;
     bool imageOpts = false;
     bool writethrough = true;
@@ -701,7 +701,10 @@ int main(int argc, char **argv)
             alloc_depth = true;
             break;
         case 'B':
-            bitmap = optarg;
+            tmp = g_new(strList, 1);
+            tmp->value = g_strdup(optarg);
+            tmp->next = bitmaps;
+            bitmaps = tmp;
             break;
         case 'k':
             sockpath = optarg;
@@ -798,7 +801,7 @@ int main(int argc, char **argv)
         }
         if (export_name || export_description || dev_offset ||
             device || disconnect || fmt || sn_id_or_name || alloc_depth ||
-            bitmap || seen_aio || seen_discard || seen_cache) {
+            bitmaps || seen_aio || seen_discard || seen_cache) {
             error_report("List mode is incompatible with per-device settings");
             exit(EXIT_FAILURE);
         }
@@ -1082,8 +1085,8 @@ int main(int argc, char **argv)
             .name               = g_strdup(export_name),
             .has_description    = !!export_description,
             .description        = g_strdup(export_description),
-            .has_bitmap         = !!bitmap,
-            .bitmap             = g_strdup(bitmap),
+            .has_bitmaps        = !!bitmaps,
+            .bitmaps            = bitmaps,
             .has_alloc          = alloc_depth,
             .alloc              = alloc_depth,
         },
-- 
2.28.0


