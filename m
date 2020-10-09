Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AC1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC0722258
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuOD1zot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC0722258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR0TN-0000h3-PW
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 18:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kR0Mg-0002np-V5
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kR0Mb-0003Q5-P9
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602280545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDhsjOxJJ17oolgE04i0yPAKFi3Ss1MM7vHXvbd8znQ=;
 b=HuOD1zot9hEqHZkWZSV46SbyZdn9F8sRqQgHkGgglAp6yrQ/VTSNIZTJlwcMEpoyP3fHpK
 avj5y1oHlJZayWc+yxvs0ZNM8apcURYLm2YqAUnS9rppUK/ywsI0UT5hSFnxortjkM3dtX
 TsUh+/CfrvqmzNetebfIG6pi/3Iu5Eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-PZ9DiLDtM_eirZzuZZmPcw-1; Fri, 09 Oct 2020 17:55:43 -0400
X-MC-Unique: PZ9DiLDtM_eirZzuZZmPcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3635F1074648;
 Fri,  9 Oct 2020 21:55:42 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A27910013C4;
 Fri,  9 Oct 2020 21:55:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/7] nbd: Update qapi to support exporting multiple bitmaps
Date: Fri,  9 Oct 2020 16:55:30 -0500
Message-Id: <20201009215533.1194742-5-eblake@redhat.com>
In-Reply-To: <20201009215533.1194742-1-eblake@redhat.com>
References: <20201009215533.1194742-1-eblake@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, rjones@redhat.com,
 Max Reitz <mreitz@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 'nbd-server-add' is deprecated, and 'block-export-add' is new to
5.2, we can still tweak the interface.  Allowing 'bitmaps':['str'] is
nicer than 'bitmap':'str'.  This wires up the qapi and qemu-nbd
changes to permit passing multiple bitmaps as distinct metadata
contexts that the NBD client may request, but the actual support for
more than one will require a further patch to the server.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-export.json | 18 ++++++++++++------
 blockdev-nbd.c         | 14 ++++++++++++++
 nbd/server.c           | 19 +++++++++++++------
 qemu-nbd.c             | 13 ++++++++-----
 4 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 893d5cde5dfe..c7c749d61097 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -74,10 +74,10 @@
 # @description: Free-form description of the export, up to 4096 bytes.
 #               (Since 5.0)
 #
-# @bitmap: Also export the dirty bitmap reachable from @device, so the
-#          NBD client can use NBD_OPT_SET_META_CONTEXT with the
-#          metadata context name "qemu:dirty-bitmap:NAME" to inspect the
-#          bitmap. (since 4.0)
+# @bitmaps: Also export each of the named dirty bitmaps reachable from
+#           @device, so the NBD client can use NBD_OPT_SET_META_CONTEXT with
+#           the metadata context name "qemu:dirty-bitmap:BITMAP" to inspect
+#           each bitmap. (since 5.2)
 #
 # @allocation-depth: Also export the allocation depth map for @device, so
 #                    the NBD client can use NBD_OPT_SET_META_CONTEXT with
@@ -88,7 +88,7 @@
 ##
 { 'struct': 'BlockExportOptionsNbd',
   'data': { '*name': 'str', '*description': 'str',
-            '*bitmap': 'str', '*allocation-depth': 'bool' } }
+            '*bitmaps': ['str'], '*allocation-depth': 'bool' } }

 ##
 # @NbdServerAddOptions:
@@ -100,12 +100,18 @@
 # @writable: Whether clients should be able to write to the device via the
 #            NBD connection (default false).
 #
+# @bitmap: Also export a single dirty bitmap reachable from @device, so the
+#          NBD client can use NBD_OPT_SET_META_CONTEXT with the metadata
+#          context name "qemu:dirty-bitmap:BITMAP" to inspect the bitmap
+#          (since 4.0).  Mutually exclusive with @bitmaps, and newer
+#          clients should use that instead.
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
index 43856c1058a5..359a198de2c7 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -192,6 +192,20 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
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
diff --git a/nbd/server.c b/nbd/server.c
index 30cfe0eee467..884ffa00f1bd 100644
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
index 847fde435a7f..fa5c68749e8f 100644
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
             .name                 = g_strdup(export_name),
             .has_description      = !!export_description,
             .description          = g_strdup(export_description),
-            .has_bitmap           = !!bitmap,
-            .bitmap               = g_strdup(bitmap),
+            .has_bitmaps          = !!bitmaps,
+            .bitmaps              = bitmaps,
             .has_allocation_depth = alloc_depth,
             .allocation_depth     = alloc_depth,
         },
-- 
2.28.0


