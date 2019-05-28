Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36119C04AB6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 00:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3BD21670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 00:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3BD21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44399 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVm1X-0007Yo-6Z
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 20:00:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hVlzn-0006Ui-4r
	for qemu-devel@nongnu.org; Tue, 28 May 2019 19:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hVlzi-0001OA-88
	for qemu-devel@nongnu.org; Tue, 28 May 2019 19:59:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hVlze-0001HC-H1; Tue, 28 May 2019 19:58:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE3A530C1AE7;
	Tue, 28 May 2019 23:58:56 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 579CB5FC01;
	Tue, 28 May 2019 23:58:54 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 28 May 2019 19:58:41 -0400
Message-Id: <20190528235842.29453-3-jsnow@redhat.com>
In-Reply-To: <20190528235842.29453-1-jsnow@redhat.com>
References: <20190528235842.29453-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 28 May 2019 23:58:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/3] qapi: support external bitmaps in
 block-dirty-bitmap-merge
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	jsnow@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add new optional parameter making possible to merge bitmaps from
different nodes. It is needed to maintain external snapshots during
incremental backup chain history.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190517152111.206494-2-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 22 ++++++++++++++++---
 block/dirty-bitmap.c |  9 +++++---
 blockdev.c           | 50 +++++++++++++++++++++++++++++---------------
 3 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..dcc935d655 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2003,19 +2003,35 @@
   'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
             '*persistent': 'bool', '*autoload': 'bool', '*disabled': 'bo=
ol' } }
=20
+##
+# @BlockDirtyBitmapMergeSource:
+#
+# @local: name of the bitmap, attached to the same node as target bitmap=
.
+#
+# @external: bitmap with specified node
+#
+# Since: 4.1
+##
+{ 'alternate': 'BlockDirtyBitmapMergeSource',
+  'data': { 'local': 'str',
+            'external': 'BlockDirtyBitmap' } }
+
 ##
 # @BlockDirtyBitmapMerge:
 #
-# @node: name of device/node which the bitmap is tracking
+# @node: name of device/node which the @target bitmap is tracking
 #
 # @target: name of the destination dirty bitmap
 #
-# @bitmaps: name(s) of the source dirty bitmap(s)
+# @bitmaps: name(s) of the source dirty bitmap(s) at @node and/or fully
+#           specifed BlockDirtyBitmap elements. The latter are supported
+#           since 4.1.
 #
 # Since: 4.0
 ##
 { 'struct': 'BlockDirtyBitmapMerge',
-  'data': { 'node': 'str', 'target': 'str', 'bitmaps': ['str'] } }
+  'data': { 'node': 'str', 'target': 'str',
+            'bitmaps': ['BlockDirtyBitmapMergeSource'] } }
=20
 ##
 # @block-dirty-bitmap-add:
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 59e6ebb861..49646a30e6 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -816,10 +816,10 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest,=
 const BdrvDirtyBitmap *src,
 {
     bool ret;
=20
-    /* only bitmaps from one bds are supported */
-    assert(dest->mutex =3D=3D src->mutex);
-
     qemu_mutex_lock(dest->mutex);
+    if (src->mutex !=3D dest->mutex) {
+        qemu_mutex_lock(src->mutex);
+    }
=20
     if (bdrv_dirty_bitmap_check(dest, BDRV_BITMAP_DEFAULT, errp)) {
         goto out;
@@ -845,4 +845,7 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, c=
onst BdrvDirtyBitmap *src,
=20
 out:
     qemu_mutex_unlock(dest->mutex);
+    if (src->mutex !=3D dest->mutex) {
+        qemu_mutex_unlock(src->mutex);
+    }
 }
diff --git a/blockdev.c b/blockdev.c
index 79fbac8450..64ccef735b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2112,11 +2112,10 @@ static void block_dirty_bitmap_disable_abort(BlkA=
ctionState *common)
     }
 }
=20
-static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
-                                                    const char *target,
-                                                    strList *bitmaps,
-                                                    HBitmap **backup,
-                                                    Error **errp);
+static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
+        const char *node, const char *target,
+        BlockDirtyBitmapMergeSourceList *bitmaps,
+        HBitmap **backup, Error **errp);
=20
 static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
                                              Error **errp)
@@ -2965,15 +2964,14 @@ void qmp_block_dirty_bitmap_disable(const char *n=
ode, const char *name,
     bdrv_disable_dirty_bitmap(bitmap);
 }
=20
-static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
-                                                    const char *target,
-                                                    strList *bitmaps,
-                                                    HBitmap **backup,
-                                                    Error **errp)
+static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
+        const char *node, const char *target,
+        BlockDirtyBitmapMergeSourceList *bitmaps,
+        HBitmap **backup, Error **errp)
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *dst, *src, *anon;
-    strList *lst;
+    BlockDirtyBitmapMergeSourceList *lst;
     Error *local_err =3D NULL;
=20
     dst =3D block_dirty_bitmap_lookup(node, target, &bs, errp);
@@ -2988,11 +2986,28 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_mer=
ge(const char *node,
     }
=20
     for (lst =3D bitmaps; lst; lst =3D lst->next) {
-        src =3D bdrv_find_dirty_bitmap(bs, lst->value);
-        if (!src) {
-            error_setg(errp, "Dirty bitmap '%s' not found", lst->value);
-            dst =3D NULL;
-            goto out;
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
         }
=20
         bdrv_merge_dirty_bitmap(anon, src, NULL, &local_err);
@@ -3012,7 +3027,8 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_merge=
(const char *node,
 }
=20
 void qmp_block_dirty_bitmap_merge(const char *node, const char *target,
-                                  strList *bitmaps, Error **errp)
+                                  BlockDirtyBitmapMergeSourceList *bitma=
ps,
+                                  Error **errp)
 {
     do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
 }
--=20
2.20.1


