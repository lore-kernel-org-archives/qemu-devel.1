Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDED5C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED0020724
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKl2nkI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED0020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR0Om-0001cW-IP
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 17:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jR0K4-0005K6-A2
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jR0Jm-0004YP-PK
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:20:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49653
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jR0Jj-0004SA-Vf
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587504030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7LZQGGXbYbbgrrm+GbyBvkNWg62W/PwJiHjUr7hMBQ=;
 b=WKl2nkI9RWNt0p3M34bQlRRjjWPu7BTrBC8BX6kVNZf3ON9ZNzvrTCE3md5I575/KAttUt
 O/rGJ3YuzTm7v/eR232JkJFE4Sc0z0LoNQ2lxvr01W5ZYGd209j/x+LOtyFkefSfPfLxbO
 GYc4dKhH2TjgFKVa2Q6UsFfyUDrrQJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-xak5nRvNNum5izF914m4Jw-1; Tue, 21 Apr 2020 17:20:26 -0400
X-MC-Unique: xak5nRvNNum5izF914m4Jw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6429D8017FC;
 Tue, 21 Apr 2020 21:20:25 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B65DA18B6;
 Tue, 21 Apr 2020 21:20:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] blockdev: Split off basic bitmap operations for
 qemu-img
Date: Tue, 21 Apr 2020 16:20:15 -0500
Message-Id: <20200421212019.170707-3-eblake@redhat.com>
In-Reply-To: <20200421212019.170707-1-eblake@redhat.com>
References: <20200421212019.170707-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 15:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Upcoming patches want to add some basic bitmap manipulation abilities
to qemu-img.  But blockdev.o is too heavyweight to link into qemu-img
(among other things, it would drag in block jobs and transaction
support - qemu-img does offline manipulation, where atomicity is less
important because there are no concurrent modifications to compete
with), so it's time to split off the bare bones of what we will need
into a new file blockbitmaps.o.

In addition to exposing 6 QMP commands for use by qemu-img (add,
remove, clear, enable, disable, merge), this also has to export three
previously-static functions for use by blockdev.c transactions.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 Makefile.objs             |   2 +-
 include/sysemu/blockdev.h |  14 ++
 blockbitmaps.c            | 324 ++++++++++++++++++++++++++++++++++++++
 blockdev.c                | 293 ----------------------------------
 MAINTAINERS               |   1 +
 5 files changed, 340 insertions(+), 294 deletions(-)
 create mode 100644 blockbitmaps.c

diff --git a/Makefile.objs b/Makefile.objs
index a7c967633acf..44e30fa9a6e3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -14,7 +14,7 @@ chardev-obj-y =3D chardev/
 authz-obj-y =3D authz/

 block-obj-y =3D nbd/
-block-obj-y +=3D block.o blockjob.o job.o
+block-obj-y +=3D block.o blockbitmaps.o blockjob.o job.o
 block-obj-y +=3D block/ scsi/
 block-obj-y +=3D qemu-io-cmds.o
 block-obj-$(CONFIG_REPLICATION) +=3D replication.o
diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
index a86d99b3d875..523b7493b1cd 100644
--- a/include/sysemu/blockdev.h
+++ b/include/sysemu/blockdev.h
@@ -57,4 +57,18 @@ QemuOpts *drive_add(BlockInterfaceType type, int index, =
const char *file,
 DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_type,
                      Error **errp);

+BdrvDirtyBitmap *block_dirty_bitmap_lookup(const char *node,
+                                           const char *name,
+                                           BlockDriverState **pbs,
+                                           Error **errp);
+BdrvDirtyBitmap *do_block_dirty_bitmap_remove(const char *node,
+                                              const char *name, bool relea=
se,
+                                              BlockDriverState **bitmap_bs=
,
+                                              Error **errp);
+BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
+                                             const char *target,
+                                             BlockDirtyBitmapMergeSourceLi=
st *bitmaps,
+                                             HBitmap **backup, Error **err=
p);
+
+
 #endif
diff --git a/blockbitmaps.c b/blockbitmaps.c
new file mode 100644
index 000000000000..fea80efcd03a
--- /dev/null
+++ b/blockbitmaps.c
@@ -0,0 +1,324 @@
+/*
+ * QEMU host block device bitmaps
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
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+
+#include "sysemu/blockdev.h"
+#include "block/block.h"
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
+    bs =3D bdrv_lookup_bs(node, node, NULL);
+    if (!bs) {
+        error_setg(errp, "Node '%s' not found", node);
+        return NULL;
+    }
+
+    bitmap =3D bdrv_find_dirty_bitmap(bs, name);
+    if (!bitmap) {
+        error_setg(errp, "Dirty bitmap '%s' not found", name);
+        return NULL;
+    }
+
+    if (pbs) {
+        *pbs =3D bs;
+    }
+
+    return bitmap;
+}
+
+void qmp_block_dirty_bitmap_add(const char *node, const char *name,
+                                bool has_granularity, uint32_t granularity=
,
+                                bool has_persistent, bool persistent,
+                                bool has_disabled, bool disabled,
+                                Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+    AioContext *aio_context;
+
+    if (!name || name[0] =3D=3D '\0') {
+        error_setg(errp, "Bitmap name cannot be empty");
+        return;
+    }
+
+    bs =3D bdrv_lookup_bs(node, node, errp);
+    if (!bs) {
+        return;
+    }
+
+    aio_context =3D bdrv_get_aio_context(bs);
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
+        granularity =3D bdrv_get_default_bitmap_granularity(bs);
+    }
+
+    if (!has_persistent) {
+        persistent =3D false;
+    }
+
+    if (!has_disabled) {
+        disabled =3D false;
+    }
+
+    if (persistent &&
+        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
+    {
+        goto out;
+    }
+
+    bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, name, errp);
+    if (bitmap =3D=3D NULL) {
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
+BdrvDirtyBitmap *do_block_dirty_bitmap_remove(const char *node,
+                                              const char *name, bool relea=
se,
+                                              BlockDriverState **bitmap_bs=
,
+                                              Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+    AioContext *aio_context;
+
+    bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
+    if (!bitmap || !bs) {
+        return NULL;
+    }
+
+    aio_context =3D bdrv_get_aio_context(bs);
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
+        *bitmap_bs =3D bs;
+    }
+
+    aio_context_release(aio_context);
+    return release ? NULL : bitmap;
+}
+
+void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
+                                   Error **errp)
+{
+    do_block_dirty_bitmap_remove(node, name, true, NULL, errp);
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
+    bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
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
+    bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
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
+    bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
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
+BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
+        const char *node, const char *target,
+        BlockDirtyBitmapMergeSourceList *bitmaps,
+        HBitmap **backup, Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *dst, *src, *anon;
+    BlockDirtyBitmapMergeSourceList *lst;
+    Error *local_err =3D NULL;
+
+    dst =3D block_dirty_bitmap_lookup(node, target, &bs, errp);
+    if (!dst) {
+        return NULL;
+    }
+
+    anon =3D bdrv_create_dirty_bitmap(bs, bdrv_dirty_bitmap_granularity(ds=
t),
+                                    NULL, errp);
+    if (!anon) {
+        return NULL;
+    }
+
+    for (lst =3D bitmaps; lst; lst =3D lst->next) {
+        switch (lst->value->type) {
+            const char *name, *node;
+        case QTYPE_QSTRING:
+            name =3D lst->value->u.local;
+            src =3D bdrv_find_dirty_bitmap(bs, name);
+            if (!src) {
+                error_setg(errp, "Dirty bitmap '%s' not found", name);
+                dst =3D NULL;
+                goto out;
+            }
+            break;
+        case QTYPE_QDICT:
+            node =3D lst->value->u.external.node;
+            name =3D lst->value->u.external.name;
+            src =3D block_dirty_bitmap_lookup(node, name, NULL, errp);
+            if (!src) {
+                dst =3D NULL;
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
+            dst =3D NULL;
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
+                                  BlockDirtyBitmapMergeSourceList *bitmaps=
,
+                                  Error **errp)
+{
+    do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
+}
diff --git a/blockdev.c b/blockdev.c
index 5faddaa7052f..d4efd4cbf2cb 100644
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
-static BdrvDirtyBitmap *block_dirty_bitmap_lookup(const char *node,
-                                                  const char *name,
-                                                  BlockDriverState **pbs,
-                                                  Error **errp)
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
-    bs =3D bdrv_lookup_bs(node, node, NULL);
-    if (!bs) {
-        error_setg(errp, "Node '%s' not found", node);
-        return NULL;
-    }
-
-    bitmap =3D bdrv_find_dirty_bitmap(bs, name);
-    if (!bitmap) {
-        error_setg(errp, "Dirty bitmap '%s' not found", name);
-        return NULL;
-    }
-
-    if (pbs) {
-        *pbs =3D bs;
-    }
-
-    return bitmap;
-}
-
 /* New and old BlockDriverState structs for atomic group operations */

 typedef struct BlkActionState BlkActionState;
@@ -2171,11 +2124,6 @@ static void block_dirty_bitmap_disable_abort(BlkActi=
onState *common)
     }
 }

-static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
-        const char *node, const char *target,
-        BlockDirtyBitmapMergeSourceList *bitmaps,
-        HBitmap **backup, Error **errp);
-
 static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
                                              Error **errp)
 {
@@ -2194,10 +2142,6 @@ static void block_dirty_bitmap_merge_prepare(BlkActi=
onState *common,
                                                 errp);
 }

-static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
-        const char *node, const char *name, bool release,
-        BlockDriverState **bitmap_bs, Error **errp);
-
 static void block_dirty_bitmap_remove_prepare(BlkActionState *common,
                                               Error **errp)
 {
@@ -2441,243 +2385,6 @@ void qmp_block_passwd(bool has_device, const char *=
device,
                "Setting block passwords directly is no longer supported");
 }

-void qmp_block_dirty_bitmap_add(const char *node, const char *name,
-                                bool has_granularity, uint32_t granularity=
,
-                                bool has_persistent, bool persistent,
-                                bool has_disabled, bool disabled,
-                                Error **errp)
-{
-    BlockDriverState *bs;
-    BdrvDirtyBitmap *bitmap;
-    AioContext *aio_context;
-
-    if (!name || name[0] =3D=3D '\0') {
-        error_setg(errp, "Bitmap name cannot be empty");
-        return;
-    }
-
-    bs =3D bdrv_lookup_bs(node, node, errp);
-    if (!bs) {
-        return;
-    }
-
-    aio_context =3D bdrv_get_aio_context(bs);
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
-        granularity =3D bdrv_get_default_bitmap_granularity(bs);
-    }
-
-    if (!has_persistent) {
-        persistent =3D false;
-    }
-
-    if (!has_disabled) {
-        disabled =3D false;
-    }
-
-    if (persistent &&
-        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
-    {
-        goto out;
-    }
-
-    bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, name, errp);
-    if (bitmap =3D=3D NULL) {
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
-static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
-        const char *node, const char *name, bool release,
-        BlockDriverState **bitmap_bs, Error **errp)
-{
-    BlockDriverState *bs;
-    BdrvDirtyBitmap *bitmap;
-    AioContext *aio_context;
-
-    bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
-    if (!bitmap || !bs) {
-        return NULL;
-    }
-
-    aio_context =3D bdrv_get_aio_context(bs);
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
-        *bitmap_bs =3D bs;
-    }
-
-    aio_context_release(aio_context);
-    return release ? NULL : bitmap;
-}
-
-void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
-                                   Error **errp)
-{
-    do_block_dirty_bitmap_remove(node, name, true, NULL, errp);
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
-    bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
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
-    bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
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
-    bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
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
-static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
-        const char *node, const char *target,
-        BlockDirtyBitmapMergeSourceList *bitmaps,
-        HBitmap **backup, Error **errp)
-{
-    BlockDriverState *bs;
-    BdrvDirtyBitmap *dst, *src, *anon;
-    BlockDirtyBitmapMergeSourceList *lst;
-    Error *local_err =3D NULL;
-
-    dst =3D block_dirty_bitmap_lookup(node, target, &bs, errp);
-    if (!dst) {
-        return NULL;
-    }
-
-    anon =3D bdrv_create_dirty_bitmap(bs, bdrv_dirty_bitmap_granularity(ds=
t),
-                                    NULL, errp);
-    if (!anon) {
-        return NULL;
-    }
-
-    for (lst =3D bitmaps; lst; lst =3D lst->next) {
-        switch (lst->value->type) {
-            const char *name, *node;
-        case QTYPE_QSTRING:
-            name =3D lst->value->u.local;
-            src =3D bdrv_find_dirty_bitmap(bs, name);
-            if (!src) {
-                error_setg(errp, "Dirty bitmap '%s' not found", name);
-                dst =3D NULL;
-                goto out;
-            }
-            break;
-        case QTYPE_QDICT:
-            node =3D lst->value->u.external.node;
-            name =3D lst->value->u.external.name;
-            src =3D block_dirty_bitmap_lookup(node, name, NULL, errp);
-            if (!src) {
-                dst =3D NULL;
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
-            dst =3D NULL;
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
-                                  BlockDirtyBitmapMergeSourceList *bitmaps=
,
-                                  Error **errp)
-{
-    do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
-}
-
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *=
node,
                                                               const char *=
name,
                                                               Error **errp=
)
diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fac2bfc..769cd357d281 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1989,6 +1989,7 @@ T: git https://github.com/jnsnow/qemu.git jobs
 Block QAPI, monitor, command line
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
+F: blockbitmaps.c
 F: blockdev.c
 F: blockdev-hmp-cmds.c
 F: block/qapi.c
--=20
2.26.2


