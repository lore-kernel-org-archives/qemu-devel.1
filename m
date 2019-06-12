Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEFAC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6236F20B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6236F20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBzx-0007mR-1D
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46022)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBSl-0008Bs-3h
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBSg-00085Q-Rw
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:11:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBSa-00080G-RO; Wed, 12 Jun 2019 18:11:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF5067E424;
 Wed, 12 Jun 2019 22:11:11 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D182060BF0;
 Wed, 12 Jun 2019 22:11:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:47 +0200
Message-Id: <20190612221004.2317-26-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 12 Jun 2019 22:11:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 25/42] mirror: Deal with filters
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
 block/mirror.c | 110 +++++++++++++++++++++++++++++++++++++------------
 blockdev.c     |  47 +++++++++++++++++----
 2 files changed, 124 insertions(+), 33 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 4fa8f57c80..3d767e3030 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -660,8 +660,10 @@ static int mirror_exit_common(Job *job)
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
@@ -711,7 +713,7 @@ static int mirror_exit_common(Job *job)
     block_job_remove_all_bdrv(bjob);
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
-    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_a=
bort);
+    bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_=
abort);
=20
     /* We just changed the BDS the job BB refers to (with either or both=
 of the
      * bdrv_replace_node() calls), so switch the BB back so the cleanup =
does
@@ -757,6 +759,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlock=
Job *s)
 {
     int64_t offset;
     BlockDriverState *base =3D s->base;
+    BlockDriverState *filtered_base;
     BlockDriverState *bs =3D s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs =3D blk_bs(s->target);
     int ret;
@@ -795,6 +798,9 @@ static int coroutine_fn mirror_dirty_init(MirrorBlock=
Job *s)
         s->initial_zeroing_ongoing =3D false;
     }
=20
+    /* Will be NULL if @base is not in @bs's chain */
+    filtered_base =3D bdrv_filtered_cow_bs(bdrv_find_overlay(bs, base));
+
     /* First part, loop on the sectors and initialize the dirty bitmap. =
 */
     for (offset =3D 0; offset < s->bdev_length; ) {
         /* Just to make sure we are not exceeding int limit. */
@@ -807,7 +813,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlock=
Job *s)
             return 0;
         }
=20
-        ret =3D bdrv_is_allocated_above(bs, base, offset, bytes, &count)=
;
+        ret =3D bdrv_is_allocated_above(bs, filtered_base, offset, bytes=
, &count);
         if (ret < 0) {
             return ret;
         }
@@ -903,7 +909,7 @@ static int coroutine_fn mirror_run(Job *job, Error **=
errp)
     } else {
         s->target_cluster_size =3D BDRV_SECTOR_SIZE;
     }
-    if (backing_filename[0] && !target_bs->backing &&
+    if (backing_filename[0] && !bdrv_backing_chain_next(target_bs) &&
         s->granularity < s->target_cluster_size) {
         s->buf_size =3D MAX(s->buf_size, s->target_cluster_size);
         s->cow_bitmap =3D bitmap_new(length);
@@ -1083,8 +1089,9 @@ static void mirror_complete(Job *job, Error **errp)
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
@@ -1503,8 +1510,8 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
     MirrorBlockJob *s;
     MirrorBDSOpaque *bs_opaque;
     BlockDriverState *mirror_top_bs;
-    bool target_graph_mod;
     bool target_is_backing;
+    uint64_t target_perms, target_shared_perms;
     Error *local_err =3D NULL;
     int ret;
=20
@@ -1523,7 +1530,7 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
         buf_size =3D DEFAULT_MIRROR_BUF_SIZE;
     }
=20
-    if (bs =3D=3D target) {
+    if (bdrv_skip_rw_filters(bs) =3D=3D bdrv_skip_rw_filters(target)) {
         error_setg(errp, "Can't mirror node into itself");
         return;
     }
@@ -1583,15 +1590,42 @@ static void mirror_start_job(const char *job_id, =
BlockDriverState *bs,
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
@@ -1641,15 +1675,39 @@ static void mirror_start_job(const char *job_id, =
BlockDriverState *bs,
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
@@ -1683,7 +1741,7 @@ fail:
=20
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
-    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_a=
bort);
+    bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_=
abort);
=20
     bdrv_unref(mirror_top_bs);
 }
@@ -1706,7 +1764,7 @@ void mirror_start(const char *job_id, BlockDriverSt=
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
index 0f0cf0d9ae..68e8d33447 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3777,7 +3777,7 @@ static void blockdev_mirror_common(const char *job_=
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
@@ -3826,7 +3826,7 @@ static void blockdev_mirror_common(const char *job_=
id, BlockDriverState *bs,
=20
 void qmp_drive_mirror(DriveMirror *arg, Error **errp)
 {
-    BlockDriverState *bs;
+    BlockDriverState *bs, *unfiltered_bs;
     BlockDriverState *source, *target_bs;
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode;
@@ -3835,6 +3835,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
p)
     int flags;
     int64_t size;
     const char *format =3D arg->format;
+    const char *replaces_node_name =3D NULL;
     int ret;
=20
     bs =3D qmp_get_root_bs(arg->device, errp);
@@ -3847,6 +3848,16 @@ void qmp_drive_mirror(DriveMirror *arg, Error **er=
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
@@ -3860,8 +3871,14 @@ void qmp_drive_mirror(DriveMirror *arg, Error **er=
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
@@ -3880,6 +3897,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
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
@@ -3899,6 +3919,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
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
@@ -3906,8 +3929,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
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
@@ -3943,7 +3966,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **err=
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
@@ -3979,7 +4002,7 @@ void qmp_blockdev_mirror(bool has_job_id, const cha=
r *job_id,
                          bool has_auto_dismiss, bool auto_dismiss,
                          Error **errp)
 {
-    BlockDriverState *bs;
+    BlockDriverState *bs, *unfiltered_bs;
     BlockDriverState *target_bs;
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode =3D MIRROR_LEAVE_BACKING_CHAIN;
@@ -3991,6 +4014,16 @@ void qmp_blockdev_mirror(bool has_job_id, const ch=
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


