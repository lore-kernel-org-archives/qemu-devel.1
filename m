Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCFBC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0292F20C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0292F20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7kz-000190-9y
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57275)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7Xg-0002DF-BI
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7Xe-0004HE-Vx
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14135)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7Xb-0004Fn-Vu; Fri, 09 Aug 2019 12:14:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4ECB381F07;
 Fri,  9 Aug 2019 16:14:55 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B36D15C578;
 Fri,  9 Aug 2019 16:14:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:45 +0200
Message-Id: <20190809161407.11920-21-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 09 Aug 2019 16:14:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 20/42] block/snapshot: Fix fallback
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the top node's driver does not provide snapshot functionality and we
want to fall back to a node down the chain, we need to snapshot all
non-COW children.  For simplicity's sake, just do not fall back if there
is more than one such child.

bdrv_snapshot_goto() becomes a bit weird because we may have to redirect
the actual child pointer, so it only works if the fallback child is
bs->file or bs->backing (and then we have to find out which it is).

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/snapshot.c | 100 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 21 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index f2f48f926a..35403c167f 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -146,6 +146,32 @@ bool bdrv_snapshot_find_by_id_and_name(BlockDriverSt=
ate *bs,
     return ret;
 }
=20
+/**
+ * Return the child BDS to which we can fall back if the given BDS
+ * does not support snapshots.
+ * Return NULL if there is no BDS to (safely) fall back to.
+ */
+static BlockDriverState *bdrv_snapshot_fallback(BlockDriverState *bs)
+{
+    BlockDriverState *child_bs =3D NULL;
+    BdrvChild *child;
+
+    QLIST_FOREACH(child, &bs->children, next) {
+        if (child =3D=3D bdrv_filtered_cow_child(bs)) {
+            /* Ignore: COW children need not be included in snapshots */
+            continue;
+        }
+
+        if (child_bs) {
+            /* Cannot fall back to a single child if there are multiple =
*/
+            return NULL;
+        }
+        child_bs =3D child->bs;
+    }
+
+    return child_bs;
+}
+
 int bdrv_can_snapshot(BlockDriverState *bs)
 {
     BlockDriver *drv =3D bs->drv;
@@ -154,8 +180,9 @@ int bdrv_can_snapshot(BlockDriverState *bs)
     }
=20
     if (!drv->bdrv_snapshot_create) {
-        if (bs->file !=3D NULL) {
-            return bdrv_can_snapshot(bs->file->bs);
+        BlockDriverState *fallback_bs =3D bdrv_snapshot_fallback(bs);
+        if (fallback_bs) {
+            return bdrv_can_snapshot(fallback_bs);
         }
         return 0;
     }
@@ -167,14 +194,15 @@ int bdrv_snapshot_create(BlockDriverState *bs,
                          QEMUSnapshotInfo *sn_info)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *fallback_bs =3D bdrv_snapshot_fallback(bs);
     if (!drv) {
         return -ENOMEDIUM;
     }
     if (drv->bdrv_snapshot_create) {
         return drv->bdrv_snapshot_create(bs, sn_info);
     }
-    if (bs->file) {
-        return bdrv_snapshot_create(bs->file->bs, sn_info);
+    if (fallback_bs) {
+        return bdrv_snapshot_create(fallback_bs, sn_info);
     }
     return -ENOTSUP;
 }
@@ -184,6 +212,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
                        Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *fallback_bs;
     int ret, open_ret;
=20
     if (!drv) {
@@ -204,39 +233,66 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         return ret;
     }
=20
-    if (bs->file) {
-        BlockDriverState *file;
-        QDict *options =3D qdict_clone_shallow(bs->options);
+    fallback_bs =3D bdrv_snapshot_fallback(bs);
+    if (fallback_bs) {
+        QDict *options;
         QDict *file_options;
         Error *local_err =3D NULL;
+        bool is_backing_child;
+        BdrvChild **child_pointer;
+
+        /*
+         * We need a pointer to the fallback child pointer, so let us
+         * see whether the child is referenced by a field in the BDS
+         * object.
+         */
+        if (fallback_bs =3D=3D bs->file->bs) {
+            is_backing_child =3D false;
+            child_pointer =3D &bs->file;
+        } else if (fallback_bs =3D=3D bs->backing->bs) {
+            is_backing_child =3D true;
+            child_pointer =3D &bs->backing;
+        } else {
+            /*
+             * The fallback child is not referenced by a field in the
+             * BDS object.  We cannot go on then.
+             */
+            error_setg(errp, "Block driver does not support snapshots");
+            return -ENOTSUP;
+        }
+
+        options =3D qdict_clone_shallow(bs->options);
=20
-        file =3D bs->file->bs;
         /* Prevent it from getting deleted when detached from bs */
-        bdrv_ref(file);
+        bdrv_ref(fallback_bs);
=20
-        qdict_extract_subqdict(options, &file_options, "file.");
+        qdict_extract_subqdict(options, &file_options,
+                               is_backing_child ? "backing." : "file.");
         qobject_unref(file_options);
-        qdict_put_str(options, "file", bdrv_get_node_name(file));
+        qdict_put_str(options, is_backing_child ? "backing" : "file",
+                      bdrv_get_node_name(fallback_bs));
=20
         if (drv->bdrv_close) {
             drv->bdrv_close(bs);
         }
-        bdrv_unref_child(bs, bs->file);
-        bs->file =3D NULL;
=20
-        ret =3D bdrv_snapshot_goto(file, snapshot_id, errp);
+        assert(fallback_bs =3D=3D (*child_pointer)->bs);
+        bdrv_unref_child(bs, *child_pointer);
+        *child_pointer =3D NULL;
+
+        ret =3D bdrv_snapshot_goto(fallback_bs, snapshot_id, errp);
         open_ret =3D drv->bdrv_open(bs, options, bs->open_flags, &local_=
err);
         qobject_unref(options);
         if (open_ret < 0) {
-            bdrv_unref(file);
+            bdrv_unref(fallback_bs);
             bs->drv =3D NULL;
             /* A bdrv_snapshot_goto() error takes precedence */
             error_propagate(errp, local_err);
             return ret < 0 ? ret : open_ret;
         }
=20
-        assert(bs->file->bs =3D=3D file);
-        bdrv_unref(file);
+        assert(fallback_bs =3D=3D (*child_pointer)->bs);
+        bdrv_unref(fallback_bs);
         return ret;
     }
=20
@@ -272,6 +328,7 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
                          Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *fallback_bs =3D bdrv_snapshot_fallback(bs);
     int ret;
=20
     if (!drv) {
@@ -288,8 +345,8 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
=20
     if (drv->bdrv_snapshot_delete) {
         ret =3D drv->bdrv_snapshot_delete(bs, snapshot_id, name, errp);
-    } else if (bs->file) {
-        ret =3D bdrv_snapshot_delete(bs->file->bs, snapshot_id, name, er=
rp);
+    } else if (fallback_bs) {
+        ret =3D bdrv_snapshot_delete(fallback_bs, snapshot_id, name, err=
p);
     } else {
         error_setg(errp, "Block format '%s' used by device '%s' "
                    "does not support internal snapshot deletion",
@@ -305,14 +362,15 @@ int bdrv_snapshot_list(BlockDriverState *bs,
                        QEMUSnapshotInfo **psn_info)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *fallback_bs =3D bdrv_snapshot_fallback(bs);
     if (!drv) {
         return -ENOMEDIUM;
     }
     if (drv->bdrv_snapshot_list) {
         return drv->bdrv_snapshot_list(bs, psn_info);
     }
-    if (bs->file) {
-        return bdrv_snapshot_list(bs->file->bs, psn_info);
+    if (fallback_bs) {
+        return bdrv_snapshot_list(fallback_bs, psn_info);
     }
     return -ENOTSUP;
 }
--=20
2.21.0


