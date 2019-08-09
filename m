Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE2CC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68D720C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68D720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7j8-0003F2-62
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57430)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7Xw-00034R-13
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7Xu-0004Sc-3U
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7Xp-0004Nv-Qv; Fri, 09 Aug 2019 12:15:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 202E5316EFEC;
 Fri,  9 Aug 2019 16:15:09 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 808635C29A;
 Fri,  9 Aug 2019 16:15:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:50 +0200
Message-Id: <20190809161407.11920-26-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 09 Aug 2019 16:15:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 25/42] mirror: Deal with filters
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

This includes some permission limiting (for example, we only need to
take the RESIZE permission for active commits where the base is smaller
than the top).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 117 ++++++++++++++++++++++++++++++++++++++-----------
 blockdev.c     |  47 +++++++++++++++++---
 2 files changed, 131 insertions(+), 33 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 54bafdf176..6ddbfb9708 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -42,6 +42,7 @@ typedef struct MirrorBlockJob {
     BlockBackend *target;
     BlockDriverState *mirror_top_bs;
     BlockDriverState *base;
+    BlockDriverState *base_overlay;
=20
     /* The name of the graph node to replace */
     char *replaces;
@@ -665,8 +666,10 @@ static int mirror_exit_common(Job *job)
                              &error_abort);
     if (!abort && s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing =3D s->is_none_mode ? src : s->base;
-        if (backing_bs(target_bs) !=3D backing) {
-            bdrv_set_backing_hd(target_bs, backing, &local_err);
+        BlockDriverState *unfiltered_target =3D bdrv_skip_rw_filters(tar=
get_bs);
+
+        if (bdrv_filtered_cow_bs(unfiltered_target) !=3D backing) {
+            bdrv_set_backing_hd(unfiltered_target, backing, &local_err);
             if (local_err) {
                 error_report_err(local_err);
                 ret =3D -EPERM;
@@ -715,7 +718,7 @@ static int mirror_exit_common(Job *job)
      * valid.
      */
     block_job_remove_all_bdrv(bjob);
-    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_a=
bort);
+    bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_=
abort);
=20
     /* We just changed the BDS the job BB refers to (with either or both=
 of the
      * bdrv_replace_node() calls), so switch the BB back so the cleanup =
does
@@ -812,7 +815,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlock=
Job *s)
             return 0;
         }
=20
-        ret =3D bdrv_is_allocated_above(bs, base, false, offset, bytes, =
&count);
+        ret =3D bdrv_is_allocated_above(bs, s->base_overlay, true, offse=
t, bytes,
+                                      &count);
         if (ret < 0) {
             return ret;
         }
@@ -908,7 +912,7 @@ static int coroutine_fn mirror_run(Job *job, Error **=
errp)
     } else {
         s->target_cluster_size =3D BDRV_SECTOR_SIZE;
     }
-    if (backing_filename[0] && !target_bs->backing &&
+    if (backing_filename[0] && !bdrv_backing_chain_next(target_bs) &&
         s->granularity < s->target_cluster_size) {
         s->buf_size =3D MAX(s->buf_size, s->target_cluster_size);
         s->cow_bitmap =3D bitmap_new(length);
@@ -1088,8 +1092,9 @@ static void mirror_complete(Job *job, Error **errp)
     if (s->backing_mode =3D=3D MIRROR_OPEN_BACKING_CHAIN) {
         int ret;
=20
-        assert(!target->backing);
-        ret =3D bdrv_open_backing_file(target, NULL, "backing", errp);
+        assert(!bdrv_backing_chain_next(target));
+        ret =3D bdrv_open_backing_file(bdrv_skip_rw_filters(target), NUL=
L,
+                                     "backing", errp);
         if (ret < 0) {
             return;
         }
@@ -1531,8 +1536,8 @@ static BlockJob *mirror_start_job(
     MirrorBlockJob *s;
     MirrorBDSOpaque *bs_opaque;
     BlockDriverState *mirror_top_bs;
-    bool target_graph_mod;
     bool target_is_backing;
+    uint64_t target_perms, target_shared_perms;
     Error *local_err =3D NULL;
     int ret;
=20
@@ -1551,7 +1556,7 @@ static BlockJob *mirror_start_job(
         buf_size =3D DEFAULT_MIRROR_BUF_SIZE;
     }
=20
-    if (bs =3D=3D target) {
+    if (bdrv_skip_rw_filters(bs) =3D=3D bdrv_skip_rw_filters(target)) {
         error_setg(errp, "Can't mirror node into itself");
         return NULL;
     }
@@ -1615,15 +1620,50 @@ static BlockJob *mirror_start_job(
      * In the case of active commit, things look a bit different, though=
,
      * because the target is an already populated backing file in active=
 use.
      * We can allow anything except resize there.*/
+
+    target_perms =3D BLK_PERM_WRITE;
+    target_shared_perms =3D BLK_PERM_WRITE_UNCHANGED;
+
     target_is_backing =3D bdrv_chain_contains(bs, target);
-    target_graph_mod =3D (backing_mode !=3D MIRROR_LEAVE_BACKING_CHAIN);
+    if (target_is_backing) {
+        int64_t bs_size, target_size;
+        bs_size =3D bdrv_getlength(bs);
+        if (bs_size < 0) {
+            error_setg_errno(errp, -bs_size,
+                             "Could not inquire top image size");
+            goto fail;
+        }
+
+        target_size =3D bdrv_getlength(target);
+        if (target_size < 0) {
+            error_setg_errno(errp, -target_size,
+                             "Could not inquire base image size");
+            goto fail;
+        }
+
+        if (target_size < bs_size) {
+            target_perms |=3D BLK_PERM_RESIZE;
+        }
+
+        target_shared_perms |=3D BLK_PERM_CONSISTENT_READ
+                            |  BLK_PERM_WRITE
+                            |  BLK_PERM_GRAPH_MOD;
+    } else if (bdrv_chain_contains(bs, bdrv_skip_rw_filters(target))) {
+        /*
+         * We may want to allow this in the future, but it would
+         * require taking some extra care.
+         */
+        error_setg(errp, "Cannot mirror to a filter on top of a node in =
the "
+                   "source's backing chain");
+        goto fail;
+    }
+
+    if (backing_mode !=3D MIRROR_LEAVE_BACKING_CHAIN) {
+        target_perms |=3D BLK_PERM_GRAPH_MOD;
+    }
+
     s->target =3D blk_new(s->common.job.aio_context,
-                        BLK_PERM_WRITE | BLK_PERM_RESIZE |
-                        (target_graph_mod ? BLK_PERM_GRAPH_MOD : 0),
-                        BLK_PERM_WRITE_UNCHANGED |
-                        (target_is_backing ? BLK_PERM_CONSISTENT_READ |
-                                             BLK_PERM_WRITE |
-                                             BLK_PERM_GRAPH_MOD : 0));
+                        target_perms, target_shared_perms);
     ret =3D blk_insert_bs(s->target, target, errp);
     if (ret < 0) {
         goto fail;
@@ -1647,6 +1687,7 @@ static BlockJob *mirror_start_job(
     s->backing_mode =3D backing_mode;
     s->copy_mode =3D copy_mode;
     s->base =3D base;
+    s->base_overlay =3D bdrv_find_overlay(bs, base);
     s->granularity =3D granularity;
     s->buf_size =3D ROUND_UP(buf_size, granularity);
     s->unmap =3D unmap;
@@ -1693,15 +1734,39 @@ static BlockJob *mirror_start_job(
     /* In commit_active_start() all intermediate nodes disappear, so
      * any jobs in them must be blocked */
     if (target_is_backing) {
-        BlockDriverState *iter;
-        for (iter =3D backing_bs(bs); iter !=3D target; iter =3D backing=
_bs(iter)) {
-            /* XXX BLK_PERM_WRITE needs to be allowed so we don't block
-             * ourselves at s->base (if writes are blocked for a node, t=
hey are
-             * also blocked for its backing file). The other options wou=
ld be a
-             * second filter driver above s->base (=3D=3D target). */
+        BlockDriverState *iter, *filtered_target;
+        uint64_t iter_shared_perms;
+
+        /*
+         * The topmost node with
+         * bdrv_skip_rw_filters(filtered_target) =3D=3D bdrv_skip_rw_fil=
ters(target)
+         */
+        filtered_target =3D bdrv_filtered_cow_bs(bdrv_find_overlay(bs, t=
arget));
+
+        assert(bdrv_skip_rw_filters(filtered_target) =3D=3D
+               bdrv_skip_rw_filters(target));
+
+        /*
+         * XXX BLK_PERM_WRITE needs to be allowed so we don't block
+         * ourselves at s->base (if writes are blocked for a node, they =
are
+         * also blocked for its backing file). The other options would b=
e a
+         * second filter driver above s->base (=3D=3D target).
+         */
+        iter_shared_perms =3D BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
+
+        for (iter =3D bdrv_filtered_bs(bs); iter !=3D target;
+             iter =3D bdrv_filtered_bs(iter))
+        {
+            if (iter =3D=3D filtered_target) {
+                /*
+                 * From here on, all nodes are filters on the base.
+                 * This allows us to share BLK_PERM_CONSISTENT_READ.
+                 */
+                iter_shared_perms |=3D BLK_PERM_CONSISTENT_READ;
+            }
+
             ret =3D block_job_add_bdrv(&s->common, "intermediate node", =
iter, 0,
-                                     BLK_PERM_WRITE_UNCHANGED | BLK_PERM=
_WRITE,
-                                     errp);
+                                     iter_shared_perms, errp);
             if (ret < 0) {
                 goto fail;
             }
@@ -1737,7 +1802,7 @@ fail:
     bs_opaque->stop =3D true;
     bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
                              &error_abort);
-    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_a=
bort);
+    bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_=
abort);
=20
     bdrv_unref(mirror_top_bs);
=20
@@ -1764,7 +1829,7 @@ void mirror_start(const char *job_id, BlockDriverSt=
ate *bs,
         return;
     }
     is_none_mode =3D mode =3D=3D MIRROR_SYNC_MODE_NONE;
-    base =3D mode =3D=3D MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
+    base =3D mode =3D=3D MIRROR_SYNC_MODE_TOP ? bdrv_backing_chain_next(=
bs) : NULL;
     mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, backing_mode,
                      on_source_error, on_target_error, unmap, NULL, NULL=
,
diff --git a/blockdev.c b/blockdev.c
index c540802127..c451f553f7 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3851,7 +3851,7 @@ static void blockdev_mirror_common(const char *job_=
id, BlockDriverState *bs,
         return;
     }
=20
-    if (!bs->backing && sync =3D=3D MIRROR_SYNC_MODE_TOP) {
+    if (!bdrv_backing_chain_next(bs) && sync =3D=3D MIRROR_SYNC_MODE_TOP=
) {
         sync =3D MIRROR_SYNC_MODE_FULL;
     }
=20
@@ -3900,7 +3900,7 @@ static void blockdev_mirror_common(const char *job_=
id, BlockDriverState *bs,
=20
 void qmp_drive_mirror(DriveMirror *arg, Error **errp)
 {
-    BlockDriverState *bs;
+    BlockDriverState *bs, *unfiltered_bs;
     BlockDriverState *source, *target_bs;
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode;
@@ -3909,6 +3909,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
     int flags;
     int64_t size;
     const char *format =3D arg->format;
+    const char *replaces_node_name =3D NULL;
     int ret;
=20
     bs =3D qmp_get_root_bs(arg->device, errp);
@@ -3921,6 +3922,16 @@ void qmp_drive_mirror(DriveMirror *arg, Error **er=
rp)
         return;
     }
=20
+    /*
+     * If the user has not instructed us otherwise, we should let the
+     * block job run from @bs (thus taking into account all filters on
+     * it) but replace @unfiltered_bs when it finishes (thus not
+     * removing those filters).
+     * (And if there are any explicit filters, we should assume the
+     *  user knows how to use the @replaces option.)
+     */
+    unfiltered_bs =3D bdrv_skip_implicit_filters(bs);
+
     aio_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
=20
@@ -3934,8 +3945,14 @@ void qmp_drive_mirror(DriveMirror *arg, Error **er=
rp)
     }
=20
     flags =3D bs->open_flags | BDRV_O_RDWR;
-    source =3D backing_bs(bs);
+    source =3D bdrv_filtered_cow_bs(unfiltered_bs);
     if (!source && arg->sync =3D=3D MIRROR_SYNC_MODE_TOP) {
+        if (bdrv_filtered_bs(unfiltered_bs)) {
+            /* @unfiltered_bs is an explicit filter */
+            error_setg(errp, "Cannot perform sync=3Dtop mirror through a=
n "
+                       "explicitly added filter node on the source");
+            goto out;
+        }
         arg->sync =3D MIRROR_SYNC_MODE_FULL;
     }
     if (arg->sync =3D=3D MIRROR_SYNC_MODE_NONE) {
@@ -3954,6 +3971,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
                              " named node of the graph");
             goto out;
         }
+        replaces_node_name =3D arg->replaces;
+    } else if (unfiltered_bs !=3D bs) {
+        replaces_node_name =3D unfiltered_bs->node_name;
     }
=20
     if (arg->mode =3D=3D NEW_IMAGE_MODE_ABSOLUTE_PATHS) {
@@ -3973,6 +3993,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
         bdrv_img_create(arg->target, format,
                         NULL, NULL, NULL, size, flags, false, &local_err=
);
     } else {
+        /* Implicit filters should not appear in the filename */
+        BlockDriverState *explicit_backing =3D bdrv_skip_implicit_filter=
s(source);
+
         switch (arg->mode) {
         case NEW_IMAGE_MODE_EXISTING:
             break;
@@ -3980,8 +4003,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
             /* create new image with backing file */
             bdrv_refresh_filename(source);
             bdrv_img_create(arg->target, format,
-                            source->filename,
-                            source->drv->format_name,
+                            explicit_backing->filename,
+                            explicit_backing->drv->format_name,
                             NULL, size, flags, false, &local_err);
             break;
         default:
@@ -4017,7 +4040,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
     }
=20
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, tar=
get_bs,
-                           arg->has_replaces, arg->replaces, arg->sync,
+                           !!replaces_node_name, replaces_node_name, arg=
->sync,
                            backing_mode, arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
                            arg->has_buf_size, arg->buf_size,
@@ -4053,7 +4076,7 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
                          bool has_auto_dismiss, bool auto_dismiss,
                          Error **errp)
 {
-    BlockDriverState *bs;
+    BlockDriverState *bs, *unfiltered_bs;
     BlockDriverState *target_bs;
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode =3D MIRROR_LEAVE_BACKING_CHAIN;
@@ -4065,6 +4088,16 @@ void qmp_blockdev_mirror(bool has_job_id, const ch=
ar *job_id,
         return;
     }
=20
+    /*
+     * Same as in qmp_drive_mirror(): We want to run the job from @bs,
+     * but we want to replace @unfiltered_bs on completion.
+     */
+    unfiltered_bs =3D bdrv_skip_implicit_filters(bs);
+    if (!has_replaces && unfiltered_bs !=3D bs) {
+        replaces =3D unfiltered_bs->node_name;
+        has_replaces =3D true;
+    }
+
     target_bs =3D bdrv_lookup_bs(target, target, errp);
     if (!target_bs) {
         return;
--=20
2.21.0


