Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2410C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 21:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D5F20756
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 21:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRuguRBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D5F20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamsJ-00081x-KD
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 17:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jamn4-0008QR-0g
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:55:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27741
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jamn1-0006c3-Fj
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589835310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWK/BkgJODrcU+JW9DScfwV4Hsk437gnIB12N+L1Cac=;
 b=GRuguRBw1rKb+fEghMFtGbKQ/jeal6uFKNHPaRfgn5eCSuB7GzHGeL9hdou2cg6XvT997q
 CGwNrIDUGhVGOOU4LrzQrCAyXQnvnqnanpK96RNnyESLyhhbJE0NPc+5QUJt9Lsp6hzDAx
 AQBP9VQvtbG2loPO429QWHyyYku6Des=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-idqTIQawOSyyvKDwEhRw1g-1; Mon, 18 May 2020 16:55:08 -0400
X-MC-Unique: idqTIQawOSyyvKDwEhRw1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E702872FE0;
 Mon, 18 May 2020 20:55:07 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4792797F6;
 Mon, 18 May 2020 20:55:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] blockdev: Split off basic bitmap operations for qemu-img
Date: Mon, 18 May 2020 15:54:47 -0500
Message-Id: <20200518205448.690566-7-eblake@redhat.com>
In-Reply-To: <20200518205448.690566-1-eblake@redhat.com>
References: <20200518205448.690566-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 16:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Upcoming patches want to add some basic bitmap manipulation abilities
to qemu-img.  But blockdev.o is too heavyweight to link into qemu-img
(among other things, it would drag in block jobs and transaction
support - qemu-img does offline manipulation, where atomicity is less
important because there are no concurrent modifications to compete
with), so it's time to split off the bare bones of what we will need
into a new file block/monitor/bitmap-qmp-cmds.o.

This is sufficient to expose 6 QMP commands for use by qemu-img (add,
remove, clear, enable, disable, merge), as well as move the three
helper functions touched in the previous patch.  Regarding
MAINTAINERS, the new file is automatically part of block core, but
also makes sense as related to other dirty bitmap files.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513011648.166876-6-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 Makefile.objs                   |   3 +-
 block/monitor/bitmap-qmp-cmds.c | 321 ++++++++++++++++++++++++++++++++
 blockdev.c                      | 284 ----------------------------
 MAINTAINERS                     |   1 +
 block/monitor/Makefile.objs     |   1 +
 5 files changed, 324 insertions(+), 286 deletions(-)
 create mode 100644 block/monitor/bitmap-qmp-cmds.c

diff --git a/Makefile.objs b/Makefile.objs
index a7c967633acf..99774cfd2545 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -13,9 +13,8 @@ chardev-obj-y = chardev/

 authz-obj-y = authz/

-block-obj-y = nbd/
+block-obj-y = block/ block/monitor/ nbd/ scsi/
 block-obj-y += block.o blockjob.o job.o
-block-obj-y += block/ scsi/
 block-obj-y += qemu-io-cmds.o
 block-obj-$(CONFIG_REPLICATION) += replication.o

diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
new file mode 100644
index 000000000000..9f11deec6467
--- /dev/null
+++ b/block/monitor/bitmap-qmp-cmds.c
@@ -0,0 +1,321 @@
+/*
+ * QEMU block dirty bitmap QMP commands
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ *
+ * This file incorporates work covered by the following copyright and
+ * permission notice:
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+
+#include "block/block_int.h"
+#include "qapi/qapi-commands-block.h"
+#include "qapi/error.h"
+
+/**
+ * block_dirty_bitmap_lookup:
+ * Return a dirty bitmap (if present), after validating
+ * the node reference and bitmap names.
+ *
+ * @node: The name of the BDS node to search for bitmaps
+ * @name: The name of the bitmap to search for
+ * @pbs: Output pointer for BDS lookup, if desired. Can be NULL.
+ * @errp: Output pointer for error information. Can be NULL.
+ *
+ * @return: A bitmap object on success, or NULL on failure.
+ */
+BdrvDirtyBitmap *block_dirty_bitmap_lookup(const char *node,
+                                           const char *name,
+                                           BlockDriverState **pbs,
+                                           Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+
+    if (!node) {
+        error_setg(errp, "Node cannot be NULL");
+        return NULL;
+    }
+    if (!name) {
+        error_setg(errp, "Bitmap name cannot be NULL");
+        return NULL;
+    }
+    bs = bdrv_lookup_bs(node, node, NULL);
+    if (!bs) {
+        error_setg(errp, "Node '%s' not found", node);
+        return NULL;
+    }
+
+    bitmap = bdrv_find_dirty_bitmap(bs, name);
+    if (!bitmap) {
+        error_setg(errp, "Dirty bitmap '%s' not found", name);
+        return NULL;
+    }
+
+    if (pbs) {
+        *pbs = bs;
+    }
+
+    return bitmap;
+}
+
+void qmp_block_dirty_bitmap_add(const char *node, const char *name,
+                                bool has_granularity, uint32_t granularity,
+                                bool has_persistent, bool persistent,
+                                bool has_disabled, bool disabled,
+                                Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+    AioContext *aio_context;
+
+    if (!name || name[0] == '\0') {
+        error_setg(errp, "Bitmap name cannot be empty");
+        return;
+    }
+
+    bs = bdrv_lookup_bs(node, node, errp);
+    if (!bs) {
+        return;
+    }
+
+    aio_context = bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+
+    if (has_granularity) {
+        if (granularity < 512 || !is_power_of_2(granularity)) {
+            error_setg(errp, "Granularity must be power of 2 "
+                             "and at least 512");
+            goto out;
+        }
+    } else {
+        /* Default to cluster size, if available: */
+        granularity = bdrv_get_default_bitmap_granularity(bs);
+    }
+
+    if (!has_persistent) {
+        persistent = false;
+    }
+
+    if (!has_disabled) {
+        disabled = false;
+    }
+
+    if (persistent &&
+        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
+    {
+        goto out;
+    }
+
+    bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
+    if (bitmap == NULL) {
+        goto out;
+    }
+
+    if (disabled) {
+        bdrv_disable_dirty_bitmap(bitmap);
+    }
+
+    bdrv_dirty_bitmap_set_persistence(bitmap, persistent);
+
+out:
+    aio_context_release(aio_context);
+}
+
+BdrvDirtyBitmap *block_dirty_bitmap_remove(const char *node, const char *name,
+                                           bool release,
+                                           BlockDriverState **bitmap_bs,
+                                           Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+    AioContext *aio_context;
+
+    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
+    if (!bitmap || !bs) {
+        return NULL;
+    }
+
+    aio_context = bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY | BDRV_BITMAP_RO,
+                                errp)) {
+        aio_context_release(aio_context);
+        return NULL;
+    }
+
+    if (bdrv_dirty_bitmap_get_persistence(bitmap) &&
+        bdrv_remove_persistent_dirty_bitmap(bs, name, errp) < 0)
+    {
+        aio_context_release(aio_context);
+        return NULL;
+    }
+
+    if (release) {
+        bdrv_release_dirty_bitmap(bitmap);
+    }
+
+    if (bitmap_bs) {
+        *bitmap_bs = bs;
+    }
+
+    aio_context_release(aio_context);
+    return release ? NULL : bitmap;
+}
+
+void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
+                                   Error **errp)
+{
+    block_dirty_bitmap_remove(node, name, true, NULL, errp);
+}
+
+/**
+ * Completely clear a bitmap, for the purposes of synchronizing a bitmap
+ * immediately after a full backup operation.
+ */
+void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
+                                  Error **errp)
+{
+    BdrvDirtyBitmap *bitmap;
+    BlockDriverState *bs;
+
+    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
+    if (!bitmap || !bs) {
+        return;
+    }
+
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, errp)) {
+        return;
+    }
+
+    bdrv_clear_dirty_bitmap(bitmap, NULL);
+}
+
+void qmp_block_dirty_bitmap_enable(const char *node, const char *name,
+                                   Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+
+    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
+    if (!bitmap) {
+        return;
+    }
+
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
+        return;
+    }
+
+    bdrv_enable_dirty_bitmap(bitmap);
+}
+
+void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
+                                    Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+
+    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
+    if (!bitmap) {
+        return;
+    }
+
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
+        return;
+    }
+
+    bdrv_disable_dirty_bitmap(bitmap);
+}
+
+BdrvDirtyBitmap *block_dirty_bitmap_merge(const char *node, const char *target,
+                                          BlockDirtyBitmapMergeSourceList *bms,
+                                          HBitmap **backup, Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *dst, *src, *anon;
+    BlockDirtyBitmapMergeSourceList *lst;
+    Error *local_err = NULL;
+
+    dst = block_dirty_bitmap_lookup(node, target, &bs, errp);
+    if (!dst) {
+        return NULL;
+    }
+
+    anon = bdrv_create_dirty_bitmap(bs, bdrv_dirty_bitmap_granularity(dst),
+                                    NULL, errp);
+    if (!anon) {
+        return NULL;
+    }
+
+    for (lst = bms; lst; lst = lst->next) {
+        switch (lst->value->type) {
+            const char *name, *node;
+        case QTYPE_QSTRING:
+            name = lst->value->u.local;
+            src = bdrv_find_dirty_bitmap(bs, name);
+            if (!src) {
+                error_setg(errp, "Dirty bitmap '%s' not found", name);
+                dst = NULL;
+                goto out;
+            }
+            break;
+        case QTYPE_QDICT:
+            node = lst->value->u.external.node;
+            name = lst->value->u.external.name;
+            src = block_dirty_bitmap_lookup(node, name, NULL, errp);
+            if (!src) {
+                dst = NULL;
+                goto out;
+            }
+            break;
+        default:
+            abort();
+        }
+
+        bdrv_merge_dirty_bitmap(anon, src, NULL, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            dst = NULL;
+            goto out;
+        }
+    }
+
+    /* Merge into dst; dst is unchanged on failure. */
+    bdrv_merge_dirty_bitmap(dst, anon, backup, errp);
+
+ out:
+    bdrv_release_dirty_bitmap(anon);
+    return dst;
+}
+
+void qmp_block_dirty_bitmap_merge(const char *node, const char *target,
+                                  BlockDirtyBitmapMergeSourceList *bitmaps,
+                                  Error **errp)
+{
+    block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
+}
diff --git a/blockdev.c b/blockdev.c
index 69a30613a3dd..72df193ca73b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1185,53 +1185,6 @@ out_aio_context:
     return NULL;
 }

-/**
- * block_dirty_bitmap_lookup:
- * Return a dirty bitmap (if present), after validating
- * the node reference and bitmap names.
- *
- * @node: The name of the BDS node to search for bitmaps
- * @name: The name of the bitmap to search for
- * @pbs: Output pointer for BDS lookup, if desired. Can be NULL.
- * @errp: Output pointer for error information. Can be NULL.
- *
- * @return: A bitmap object on success, or NULL on failure.
- */
-BdrvDirtyBitmap *block_dirty_bitmap_lookup(const char *node,
-                                           const char *name,
-                                           BlockDriverState **pbs,
-                                           Error **errp)
-{
-    BlockDriverState *bs;
-    BdrvDirtyBitmap *bitmap;
-
-    if (!node) {
-        error_setg(errp, "Node cannot be NULL");
-        return NULL;
-    }
-    if (!name) {
-        error_setg(errp, "Bitmap name cannot be NULL");
-        return NULL;
-    }
-    bs = bdrv_lookup_bs(node, node, NULL);
-    if (!bs) {
-        error_setg(errp, "Node '%s' not found", node);
-        return NULL;
-    }
-
-    bitmap = bdrv_find_dirty_bitmap(bs, name);
-    if (!bitmap) {
-        error_setg(errp, "Dirty bitmap '%s' not found", name);
-        return NULL;
-    }
-
-    if (pbs) {
-        *pbs = bs;
-    }
-
-    return bitmap;
-}
-
 /* New and old BlockDriverState structs for atomic group operations */

 typedef struct BlkActionState BlkActionState;
@@ -2432,243 +2385,6 @@ void qmp_block_passwd(bool has_device, const char *device,
                "Setting block passwords directly is no longer supported");
 }

-void qmp_block_dirty_bitmap_add(const char *node, const char *name,
-                                bool has_granularity, uint32_t granularity,
-                                bool has_persistent, bool persistent,
-                                bool has_disabled, bool disabled,
-                                Error **errp)
-{
-    BlockDriverState *bs;
-    BdrvDirtyBitmap *bitmap;
-    AioContext *aio_context;
-
-    if (!name || name[0] == '\0') {
-        error_setg(errp, "Bitmap name cannot be empty");
-        return;
-    }
-
-    bs = bdrv_lookup_bs(node, node, errp);
-    if (!bs) {
-        return;
-    }
-
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
-    if (has_granularity) {
-        if (granularity < 512 || !is_power_of_2(granularity)) {
-            error_setg(errp, "Granularity must be power of 2 "
-                             "and at least 512");
-            goto out;
-        }
-    } else {
-        /* Default to cluster size, if available: */
-        granularity = bdrv_get_default_bitmap_granularity(bs);
-    }
-
-    if (!has_persistent) {
-        persistent = false;
-    }
-
-    if (!has_disabled) {
-        disabled = false;
-    }
-
-    if (persistent &&
-        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
-    {
-        goto out;
-    }
-
-    bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
-    if (bitmap == NULL) {
-        goto out;
-    }
-
-    if (disabled) {
-        bdrv_disable_dirty_bitmap(bitmap);
-    }
-
-    bdrv_dirty_bitmap_set_persistence(bitmap, persistent);
-
-out:
-    aio_context_release(aio_context);
-}
-
-BdrvDirtyBitmap *block_dirty_bitmap_remove(const char *node, const char *name,
-                                           bool release,
-                                           BlockDriverState **bitmap_bs,
-                                           Error **errp)
-{
-    BlockDriverState *bs;
-    BdrvDirtyBitmap *bitmap;
-    AioContext *aio_context;
-
-    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
-    if (!bitmap || !bs) {
-        return NULL;
-    }
-
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
-    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY | BDRV_BITMAP_RO,
-                                errp)) {
-        aio_context_release(aio_context);
-        return NULL;
-    }
-
-    if (bdrv_dirty_bitmap_get_persistence(bitmap) &&
-        bdrv_remove_persistent_dirty_bitmap(bs, name, errp) < 0)
-    {
-        aio_context_release(aio_context);
-        return NULL;
-    }
-
-    if (release) {
-        bdrv_release_dirty_bitmap(bitmap);
-    }
-
-    if (bitmap_bs) {
-        *bitmap_bs = bs;
-    }
-
-    aio_context_release(aio_context);
-    return release ? NULL : bitmap;
-}
-
-void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
-                                   Error **errp)
-{
-    block_dirty_bitmap_remove(node, name, true, NULL, errp);
-}
-
-/**
- * Completely clear a bitmap, for the purposes of synchronizing a bitmap
- * immediately after a full backup operation.
- */
-void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
-                                  Error **errp)
-{
-    BdrvDirtyBitmap *bitmap;
-    BlockDriverState *bs;
-
-    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
-    if (!bitmap || !bs) {
-        return;
-    }
-
-    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, errp)) {
-        return;
-    }
-
-    bdrv_clear_dirty_bitmap(bitmap, NULL);
-}
-
-void qmp_block_dirty_bitmap_enable(const char *node, const char *name,
-                                   Error **errp)
-{
-    BlockDriverState *bs;
-    BdrvDirtyBitmap *bitmap;
-
-    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
-    if (!bitmap) {
-        return;
-    }
-
-    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
-        return;
-    }
-
-    bdrv_enable_dirty_bitmap(bitmap);
-}
-
-void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
-                                    Error **errp)
-{
-    BlockDriverState *bs;
-    BdrvDirtyBitmap *bitmap;
-
-    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
-    if (!bitmap) {
-        return;
-    }
-
-    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
-        return;
-    }
-
-    bdrv_disable_dirty_bitmap(bitmap);
-}
-
-BdrvDirtyBitmap *block_dirty_bitmap_merge(const char *node, const char *target,
-                                          BlockDirtyBitmapMergeSourceList *bms,
-                                          HBitmap **backup, Error **errp)
-{
-    BlockDriverState *bs;
-    BdrvDirtyBitmap *dst, *src, *anon;
-    BlockDirtyBitmapMergeSourceList *lst;
-    Error *local_err = NULL;
-
-    dst = block_dirty_bitmap_lookup(node, target, &bs, errp);
-    if (!dst) {
-        return NULL;
-    }
-
-    anon = bdrv_create_dirty_bitmap(bs, bdrv_dirty_bitmap_granularity(dst),
-                                    NULL, errp);
-    if (!anon) {
-        return NULL;
-    }
-
-    for (lst = bms; lst; lst = lst->next) {
-        switch (lst->value->type) {
-            const char *name, *node;
-        case QTYPE_QSTRING:
-            name = lst->value->u.local;
-            src = bdrv_find_dirty_bitmap(bs, name);
-            if (!src) {
-                error_setg(errp, "Dirty bitmap '%s' not found", name);
-                dst = NULL;
-                goto out;
-            }
-            break;
-        case QTYPE_QDICT:
-            node = lst->value->u.external.node;
-            name = lst->value->u.external.name;
-            src = block_dirty_bitmap_lookup(node, name, NULL, errp);
-            if (!src) {
-                dst = NULL;
-                goto out;
-            }
-            break;
-        default:
-            abort();
-        }
-
-        bdrv_merge_dirty_bitmap(anon, src, NULL, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            dst = NULL;
-            goto out;
-        }
-    }
-
-    /* Merge into dst; dst is unchanged on failure. */
-    bdrv_merge_dirty_bitmap(dst, anon, backup, errp);
-
- out:
-    bdrv_release_dirty_bitmap(anon);
-    return dst;
-}
-
-void qmp_block_dirty_bitmap_merge(const char *node, const char *target,
-                                  BlockDirtyBitmapMergeSourceList *bitmaps,
-                                  Error **errp)
-{
-    block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
-}
-
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
                                                               const char *name,
                                                               Error **errp)
diff --git a/MAINTAINERS b/MAINTAINERS
index 4e99bb05dad8..87a412c229b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2018,6 +2018,7 @@ L: qemu-block@nongnu.org
 S: Supported
 F: include/qemu/hbitmap.h
 F: include/block/dirty-bitmap.h
+F: block/monitor/bitmap-qmp-cmds.c
 F: block/dirty-bitmap.c
 F: block/qcow2-bitmap.c
 F: migration/block-dirty-bitmap.c
diff --git a/block/monitor/Makefile.objs b/block/monitor/Makefile.objs
index 0a74f9a8b5b7..39acf8502224 100644
--- a/block/monitor/Makefile.objs
+++ b/block/monitor/Makefile.objs
@@ -1 +1,2 @@
 common-obj-y += block-hmp-cmds.o
+block-obj-y += bitmap-qmp-cmds.o
-- 
2.26.2


