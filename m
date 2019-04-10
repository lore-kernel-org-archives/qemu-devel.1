Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE827C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9592082E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9592082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEJkK-0008Fv-PK
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 16:23:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJiT-0006z7-N3
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJiR-0004QV-FQ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:21:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEJiG-0004GX-RQ; Wed, 10 Apr 2019 16:20:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A0CA5945C;
	Wed, 10 Apr 2019 20:20:46 +0000 (UTC)
Received: from localhost (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 480AB19C65;
	Wed, 10 Apr 2019 20:20:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 10 Apr 2019 22:20:25 +0200
Message-Id: <20190410202033.28617-4-mreitz@redhat.com>
In-Reply-To: <20190410202033.28617-1-mreitz@redhat.com>
References: <20190410202033.28617-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 10 Apr 2019 20:20:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 03/11] block: Storage child access function
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410202025.PPp894JBAUoGegIr5sES_Sd8Tt1DcBW_k9275spKmIA@z>

For completeness' sake, add a function for accessing a node's storage
child, too.  For filters, this is their filtered child; for non-filters,
this is bs->file.

Some places are deliberately left unconverted:
- BDS opening/closing functions where bs->file is handled specially
  (which is basically wrong, but at least simplifies probing)
- bdrv_co_block_status_from_file(), because its name implies that it
  points to ->file
- bdrv_snapshot_goto() in one places unrefs bs->file.  Such a
  modification is not covered by this patch and is therefore just
  safeguarded by an additional assert(), but otherwise kept as-is.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  6 +++++
 block.c                   | 53 ++++++++++++++++++++++++++++-----------
 block/io.c                | 22 +++++++---------
 block/qapi.c              |  7 +++---
 block/snapshot.c          | 40 ++++++++++++++++-------------
 5 files changed, 81 insertions(+), 47 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index b22b1164f8..d0309e6307 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1243,6 +1243,7 @@ int refresh_total_sectors(BlockDriverState *bs, int=
64_t hint);
 BdrvChild *bdrv_filtered_cow_child(BlockDriverState *bs);
 BdrvChild *bdrv_filtered_rw_child(BlockDriverState *bs);
 BdrvChild *bdrv_filtered_child(BlockDriverState *bs);
+BdrvChild *bdrv_storage_child(BlockDriverState *bs);
 BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs);
 BlockDriverState *bdrv_skip_rw_filters(BlockDriverState *bs);
 BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
@@ -1267,4 +1268,9 @@ static inline BlockDriverState *bdrv_filtered_bs(Bl=
ockDriverState *bs)
     return child_bs(bdrv_filtered_child(bs));
 }
=20
+static inline BlockDriverState *bdrv_storage_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_storage_child(bs));
+}
+
 #endif /* BLOCK_INT_H */
diff --git a/block.c b/block.c
index e8f6febda0..89cb6de4c3 100644
--- a/block.c
+++ b/block.c
@@ -4404,15 +4404,21 @@ exit:
 int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *storage_bs;
+
     if (!drv) {
         return -ENOMEDIUM;
     }
+
     if (drv->bdrv_get_allocated_file_size) {
         return drv->bdrv_get_allocated_file_size(bs);
     }
-    if (bs->file) {
-        return bdrv_get_allocated_file_size(bs->file->bs);
+
+    storage_bs =3D bdrv_storage_bs(bs);
+    if (storage_bs) {
+        return bdrv_get_allocated_file_size(storage_bs);
     }
+
     return -ENOTSUP;
 }
=20
@@ -4982,7 +4988,7 @@ int bdrv_debug_breakpoint(BlockDriverState *bs, con=
st char *event,
                           const char *tag)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_breakpoint) {
-        bs =3D bs->file ? bs->file->bs : NULL;
+        bs =3D bdrv_storage_bs(bs);
     }
=20
     if (bs && bs->drv && bs->drv->bdrv_debug_breakpoint) {
@@ -4995,7 +5001,7 @@ int bdrv_debug_breakpoint(BlockDriverState *bs, con=
st char *event,
 int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_remove_breakpoint) {
-        bs =3D bs->file ? bs->file->bs : NULL;
+        bs =3D bdrv_storage_bs(bs);
     }
=20
     if (bs && bs->drv && bs->drv->bdrv_debug_remove_breakpoint) {
@@ -5008,7 +5014,7 @@ int bdrv_debug_remove_breakpoint(BlockDriverState *=
bs, const char *tag)
 int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
 {
     while (bs && (!bs->drv || !bs->drv->bdrv_debug_resume)) {
-        bs =3D bs->file ? bs->file->bs : NULL;
+        bs =3D bdrv_storage_bs(bs);
     }
=20
     if (bs && bs->drv && bs->drv->bdrv_debug_resume) {
@@ -5021,7 +5027,7 @@ int bdrv_debug_resume(BlockDriverState *bs, const c=
har *tag)
 bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_is_suspended) {
-        bs =3D bs->file ? bs->file->bs : NULL;
+        bs =3D bdrv_storage_bs(bs);
     }
=20
     if (bs && bs->drv && bs->drv->bdrv_debug_is_suspended) {
@@ -6142,14 +6148,23 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         bs->exact_filename[0] =3D '\0';
=20
         drv->bdrv_refresh_filename(bs);
-    } else if (bs->file) {
-        /* Try to reconstruct valid information from the underlying file=
 */
+    } else if (bdrv_storage_child(bs)) {
+        /*
+         * Try to reconstruct valid information from the underlying
+         * file -- this only works for format nodes (filter nodes
+         * cannot be probed and as such must be selected by the user
+         * either through an options dict, or through a special
+         * filename which the filter driver must construct in its
+         * .bdrv_refresh_filename() implementation).
+         */
+        BlockDriverState *storage_bs =3D bdrv_storage_bs(bs);
=20
         bs->exact_filename[0] =3D '\0';
=20
         /*
          * We can use the underlying file's filename if:
          * - it has a filename,
+         * - the current BDS is not a filter,
          * - the file is a protocol BDS, and
          * - opening that file (as this BDS's format) will automatically=
 create
          *   the BDS tree we have right now, that is:
@@ -6158,11 +6173,10 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          *   - no non-file child of this BDS has been overridden by the =
user
          *   Both of these conditions are represented by generate_json_f=
ilename.
          */
-        if (bs->file->bs->exact_filename[0] &&
-            bs->file->bs->drv->bdrv_file_open &&
-            !generate_json_filename)
+        if (storage_bs->exact_filename[0] && storage_bs->drv->bdrv_file_=
open &&
+            !drv->is_filter && !generate_json_filename)
         {
-            strcpy(bs->exact_filename, bs->file->bs->exact_filename);
+            strcpy(bs->exact_filename, storage_bs->exact_filename);
         }
     }
=20
@@ -6179,6 +6193,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 char *bdrv_dirname(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *storage_bs;
=20
     if (!drv) {
         error_setg(errp, "Node '%s' is ejected", bs->node_name);
@@ -6189,8 +6204,9 @@ char *bdrv_dirname(BlockDriverState *bs, Error **er=
rp)
         return drv->bdrv_dirname(bs, errp);
     }
=20
-    if (bs->file) {
-        return bdrv_dirname(bs->file->bs, errp);
+    storage_bs =3D bdrv_storage_bs(bs);
+    if (storage_bs) {
+        return bdrv_dirname(storage_bs, errp);
     }
=20
     bdrv_refresh_filename(bs);
@@ -6324,6 +6340,15 @@ BdrvChild *bdrv_filtered_child(BlockDriverState *b=
s)
     return cow_child ?: rw_child;
 }
=20
+/*
+ * Return the child that stores the data that is allocated on this
+ * node.  This may or may not include metadata.
+ */
+BdrvChild *bdrv_storage_child(BlockDriverState *bs)
+{
+    return bdrv_filtered_rw_child(bs) ?: bs->file;
+}
+
 static BlockDriverState *bdrv_skip_filters(BlockDriverState *bs,
                                            bool stop_on_explicit_filter)
 {
diff --git a/block/io.c b/block/io.c
index 83c2b6b46a..5c33ecc080 100644
--- a/block/io.c
+++ b/block/io.c
@@ -118,17 +118,10 @@ static void bdrv_merge_limits(BlockLimits *dst, con=
st BlockLimits *src)
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
-    BlockDriverState *storage_bs;
+    BlockDriverState *storage_bs =3D bdrv_storage_bs(bs);
     BlockDriverState *cow_bs =3D bdrv_filtered_cow_bs(bs);
     Error *local_err =3D NULL;
=20
-    /*
-     * FIXME: There should be a function for this, and in fact there
-     * will be as of a follow-up patch.
-     */
-    storage_bs =3D
-        child_bs(bs->file) ?: bdrv_filtered_rw_bs(bs);
-
     memset(&bs->bl, 0, sizeof(bs->bl));
=20
     if (!drv) {
@@ -2390,6 +2383,7 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVect=
or *qiov, int64_t pos,
                    bool is_read)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *storage_bs =3D bdrv_storage_bs(bs);
     int ret =3D -ENOTSUP;
=20
     bdrv_inc_in_flight(bs);
@@ -2402,8 +2396,8 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVect=
or *qiov, int64_t pos,
         } else {
             ret =3D drv->bdrv_save_vmstate(bs, qiov, pos);
         }
-    } else if (bs->file) {
-        ret =3D bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
+    } else if (storage_bs) {
+        ret =3D bdrv_co_rw_vmstate(storage_bs, qiov, pos, is_read);
     }
=20
     bdrv_dec_in_flight(bs);
@@ -2530,6 +2524,7 @@ static void coroutine_fn bdrv_flush_co_entry(void *=
opaque)
=20
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 {
+    BlockDriverState *storage_bs;
     int current_gen;
     int ret =3D 0;
=20
@@ -2559,7 +2554,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs=
)
     }
=20
     /* Write back cached data to the OS even with cache=3Dunsafe */
-    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_OS);
+    BLKDBG_EVENT(bdrv_storage_child(bs), BLKDBG_FLUSH_TO_OS);
     if (bs->drv->bdrv_co_flush_to_os) {
         ret =3D bs->drv->bdrv_co_flush_to_os(bs);
         if (ret < 0) {
@@ -2577,7 +2572,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs=
)
         goto flush_parent;
     }
=20
-    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
+    BLKDBG_EVENT(bdrv_storage_child(bs), BLKDBG_FLUSH_TO_DISK);
     if (!bs->drv) {
         /* bs->drv->bdrv_co_flush() might have ejected the BDS
          * (even in case of apparent success) */
@@ -2622,7 +2617,8 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs=
)
      * in the case of cache=3Dunsafe, so there are no useless flushes.
      */
 flush_parent:
-    ret =3D bs->file ? bdrv_co_flush(bs->file->bs) : 0;
+    storage_bs =3D bdrv_storage_bs(bs);
+    ret =3D storage_bs ? bdrv_co_flush(storage_bs) : 0;
 out:
     /* Notify any pending flushes that we have completed */
     if (ret =3D=3D 0) {
diff --git a/block/qapi.c b/block/qapi.c
index 478c6f5e0d..e026d27077 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -509,7 +509,7 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds=
, BlockBackend *blk)
 static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
                                         bool blk_level)
 {
-    BlockDriverState *cow_bs;
+    BlockDriverState *storage_bs, *cow_bs;
     BlockStats *s =3D NULL;
=20
     s =3D g_malloc0(sizeof(*s));
@@ -533,9 +533,10 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverS=
tate *bs,
=20
     s->stats->wr_highest_offset =3D stat64_get(&bs->wr_highest_offset);
=20
-    if (bs->file) {
+    storage_bs =3D bdrv_storage_bs(bs);
+    if (storage_bs) {
         s->has_parent =3D true;
-        s->parent =3D bdrv_query_bds_stats(bs->file->bs, blk_level);
+        s->parent =3D bdrv_query_bds_stats(storage_bs, blk_level);
     }
=20
     cow_bs =3D bdrv_filtered_cow_bs(bs);
diff --git a/block/snapshot.c b/block/snapshot.c
index f2f48f926a..3032cd0341 100644
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
@@ -204,39 +207,40 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         return ret;
     }
=20
-    if (bs->file) {
-        BlockDriverState *file;
+    storage_bs =3D bdrv_storage_bs(bs);
+    if (storage_bs) {
         QDict *options =3D qdict_clone_shallow(bs->options);
         QDict *file_options;
         Error *local_err =3D NULL;
=20
-        file =3D bs->file->bs;
         /* Prevent it from getting deleted when detached from bs */
-        bdrv_ref(file);
+        bdrv_ref(storage_bs);
=20
         qdict_extract_subqdict(options, &file_options, "file.");
         qobject_unref(file_options);
-        qdict_put_str(options, "file", bdrv_get_node_name(file));
+        qdict_put_str(options, "file", bdrv_get_node_name(storage_bs));
=20
         if (drv->bdrv_close) {
             drv->bdrv_close(bs);
         }
+
+        assert(bs->file->bs =3D=3D storage_bs);
         bdrv_unref_child(bs, bs->file);
         bs->file =3D NULL;
=20
-        ret =3D bdrv_snapshot_goto(file, snapshot_id, errp);
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
+        assert(bs->file->bs =3D=3D storage_bs);
+        bdrv_unref(storage_bs);
         return ret;
     }
=20
@@ -272,6 +276,7 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
                          Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *storage_bs =3D bdrv_storage_bs(bs);
     int ret;
=20
     if (!drv) {
@@ -288,8 +293,8 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
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
@@ -305,14 +310,15 @@ int bdrv_snapshot_list(BlockDriverState *bs,
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
2.20.1


