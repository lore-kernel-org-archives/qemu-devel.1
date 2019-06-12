Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF96C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAD520B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAD520B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35564 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBs1-0005K5-Hg
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBSY-00083z-0G
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBSV-0007w8-Lm
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBSN-0007rJ-6p; Wed, 12 Jun 2019 18:11:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 157FD30F1BA5;
 Wed, 12 Jun 2019 22:10:58 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C2825F9A7;
 Wed, 12 Jun 2019 22:10:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:42 +0200
Message-Id: <20190612221004.2317-21-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 12 Jun 2019 22:10:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 20/42] block/snapshot: Fall back to storage
 child
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
want to go down the chain, we should go towards the child which stores
the data, i.e. the storage child.

bdrv_snapshot_goto() becomes a bit weird because we may have to redirect
the actual child pointer, so it only works if the storage child is
bs->file or bs->backing (and then we have to find out which it is).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/snapshot.c | 74 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 21 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index f2f48f926a..58cd667f3a 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -154,8 +154,9 @@ int bdrv_can_snapshot(BlockDriverState *bs)
     }
=20
     if (!drv->bdrv_snapshot_create) {
-        if (bs->file !=3D NULL) {
-            return bdrv_can_snapshot(bs->file->bs);
+        BlockDriverState *storage_bs =3D bdrv_storage_bs(bs);
+        if (storage_bs) {
+            return bdrv_can_snapshot(storage_bs);
         }
         return 0;
     }
@@ -167,14 +168,15 @@ int bdrv_snapshot_create(BlockDriverState *bs,
                          QEMUSnapshotInfo *sn_info)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *storage_bs =3D bdrv_storage_bs(bs);
     if (!drv) {
         return -ENOMEDIUM;
     }
     if (drv->bdrv_snapshot_create) {
         return drv->bdrv_snapshot_create(bs, sn_info);
     }
-    if (bs->file) {
-        return bdrv_snapshot_create(bs->file->bs, sn_info);
+    if (storage_bs) {
+        return bdrv_snapshot_create(storage_bs, sn_info);
     }
     return -ENOTSUP;
 }
@@ -184,6 +186,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
                        Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *storage_bs;
     int ret, open_ret;
=20
     if (!drv) {
@@ -204,39 +207,66 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         return ret;
     }
=20
-    if (bs->file) {
-        BlockDriverState *file;
-        QDict *options =3D qdict_clone_shallow(bs->options);
+    storage_bs =3D bdrv_storage_bs(bs);
+    if (storage_bs) {
+        QDict *options;
         QDict *file_options;
         Error *local_err =3D NULL;
+        bool is_backing_child;
+        BdrvChild **child_pointer;
+
+        /*
+         * Filters may reference the storage child through
+         * bs->backing.  We need to know whether we are dealing with
+         * bs->backing or bs->file, so we check it here.
+         */
+        if (storage_bs =3D=3D bs->file->bs) {
+            is_backing_child =3D false;
+            child_pointer =3D &bs->file;
+        } else if (storage_bs =3D=3D bs->backing->bs) {
+            is_backing_child =3D true;
+            child_pointer =3D &bs->backing;
+        } else {
+            /*
+             * The storage child is not referenced by a field in the
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
+        bdrv_ref(storage_bs);
=20
-        qdict_extract_subqdict(options, &file_options, "file.");
+        qdict_extract_subqdict(options, &file_options,
+                               is_backing_child ? "backing." : "file.");
         qobject_unref(file_options);
-        qdict_put_str(options, "file", bdrv_get_node_name(file));
+        qdict_put_str(options, is_backing_child ? "backing" : "file",
+                      bdrv_get_node_name(storage_bs));
=20
         if (drv->bdrv_close) {
             drv->bdrv_close(bs);
         }
-        bdrv_unref_child(bs, bs->file);
-        bs->file =3D NULL;
=20
-        ret =3D bdrv_snapshot_goto(file, snapshot_id, errp);
+        assert(storage_bs =3D=3D (*child_pointer)->bs);
+        bdrv_unref_child(bs, *child_pointer);
+        *child_pointer =3D NULL;
+
+        ret =3D bdrv_snapshot_goto(storage_bs, snapshot_id, errp);
         open_ret =3D drv->bdrv_open(bs, options, bs->open_flags, &local_=
err);
         qobject_unref(options);
         if (open_ret < 0) {
-            bdrv_unref(file);
+            bdrv_unref(storage_bs);
             bs->drv =3D NULL;
             /* A bdrv_snapshot_goto() error takes precedence */
             error_propagate(errp, local_err);
             return ret < 0 ? ret : open_ret;
         }
=20
-        assert(bs->file->bs =3D=3D file);
-        bdrv_unref(file);
+        assert(storage_bs =3D=3D (*child_pointer)->bs);
+        bdrv_unref(storage_bs);
         return ret;
     }
=20
@@ -272,6 +302,7 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
                          Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *storage_bs =3D bdrv_storage_bs(bs);
     int ret;
=20
     if (!drv) {
@@ -288,8 +319,8 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
=20
     if (drv->bdrv_snapshot_delete) {
         ret =3D drv->bdrv_snapshot_delete(bs, snapshot_id, name, errp);
-    } else if (bs->file) {
-        ret =3D bdrv_snapshot_delete(bs->file->bs, snapshot_id, name, er=
rp);
+    } else if (storage_bs) {
+        ret =3D bdrv_snapshot_delete(storage_bs, snapshot_id, name, errp=
);
     } else {
         error_setg(errp, "Block format '%s' used by device '%s' "
                    "does not support internal snapshot deletion",
@@ -305,14 +336,15 @@ int bdrv_snapshot_list(BlockDriverState *bs,
                        QEMUSnapshotInfo **psn_info)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *storage_bs =3D bdrv_storage_bs(bs);
     if (!drv) {
         return -ENOMEDIUM;
     }
     if (drv->bdrv_snapshot_list) {
         return drv->bdrv_snapshot_list(bs, psn_info);
     }
-    if (bs->file) {
-        return bdrv_snapshot_list(bs->file->bs, psn_info);
+    if (storage_bs) {
+        return bdrv_snapshot_list(storage_bs, psn_info);
     }
     return -ENOTSUP;
 }
--=20
2.21.0


